using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Form;
using Ultimus.UWF.OrgChart.Entity;

namespace UPL.Common.BussinessControl
{
    public class CommonHelp
    {
        /// <summary>
        /// 主表联动下拉框值设置
        /// </summary>
        /// <param name="Page"></param>
        /// <param name="formid"></param>
        /// <param name="tableName"></param>
        /// <param name="column"></param>
        public void SetddlValue(Control Page, string formid, string tableName, string column)
        {
            Ultimus.UWF.Form.WebControls.DropDownList ddlControl = Page.FindControl("fld_" + column) as Ultimus.UWF.Form.WebControls.DropDownList;
            string sql = "select nvl(" + column + ",'') as value , nvl(" + column + "_NAME,'') as name from " + tableName + " where Formid=@Formid";
            DataTable ddl = DataAccess.Instance("BizDB").ExecuteDataTable(sql, formid);
            if (ddl.Rows.Count > 0)
            {
                ddlControl.SelectedItem.Value = ConvertUtil.ToString(ddl.Rows[0]["value"]);
                ddlControl.SelectedItem.Text = ConvertUtil.ToString(ddl.Rows[0]["name"]);
            }
        }

        /// <summary>
        /// 明细行设置联动下拉框数据源
        /// </summary>
        /// <param name="Page">页面对象</param>
        /// <param name="formid">formid</param>
        /// <param name="tableName">表名称</param>
        /// <param name="mainColumn">一级联动主要字段</param>
        /// <param name="mainType">一级联动类型</param>
        /// <param name="column">联动字段</param>
        public void SetDetailddlValue(Control Page, string formid, string tableName, string mainColumn, string mainType, string column)
        {
            Ultimus.UWF.Form.WebControls.Repeater rp = Page.FindControl("fld_detail_" + tableName) as Ultimus.UWF.Form.WebControls.Repeater;
            string sql = "select ROWNO,nvl(" + mainColumn + ",'') as mainValue ,nvl(" + column + ",'') as value , nvl(" + column + "_NAME,'') as name from " + tableName + " where Formid=@Formid";
            DataTable ddlSource = DataAccess.Instance("BizDB").ExecuteDataTable(sql, formid);
            foreach (RepeaterItem item in rp.Items)
            {
                string rowNo = (item.FindControl("fld_ROWNO") as Ultimus.UWF.Form.WebControls.TextBox).Text;
                if (!string.IsNullOrEmpty(rowNo))
                {
                    DataRow[] dr = ddlSource.Select("ROWNO='" + rowNo + "'");
                    if (dr.Length > 0)
                    {
                        string value = ConvertUtil.ToString(dr[0]["value"]);
                        string text = ConvertUtil.ToString(dr[0]["name"]);
                        string mainValue = ConvertUtil.ToString(dr[0]["mainValue"]);

                        sql = @"select VALUE,NAME from COM_RESOURCE where PARENTID=(
                                select RESOURCEID from COM_RESOURCE where TYPE=@TYPE AND VALUE=@VALUE AND ISACTIVE=1) AND ISACTIVE=1 order by orderno";

                        DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, mainType, mainValue);

                        Ultimus.UWF.Form.WebControls.DropDownList ddlControl = item.FindControl("fld_" + column) as Ultimus.UWF.Form.WebControls.DropDownList;
                        ddlControl.Items.Clear();
                        ddlControl.Items.Add("");

                        foreach (DataRow row in dt.Rows)
                        {
                            ddlControl.Items.Add(new ListItem(ConvertUtil.ToString(row["NAME"]), ConvertUtil.ToString(row["VALUE"])));
                        }
                        ddlControl.SelectedValue = value;
                    }
                }
            }
        }

        /// <summary>
        /// 通过组编码获取组中用户
        /// </summary>
        /// <param name="groupCode"></param>
        /// <returns></returns>
        public List<UserEntity> GetGroupMembers(string groupCode)
        {
            List<UserEntity> list = new List<UserEntity>();
            try
            {
                string strQuery = @"DECLARE @GroupID INT
               SELECT @GroupID=GROUPID FROM ORG_GROUP WHERE GROUPCODE = N'" + groupCode + @"';
               with org(DEPARTMENTID,DEPARTMENTNAME,PARENTID) 
               as (
               select DEPARTMENTID,DEPARTMENTNAME,PARENTID from V_CUSTOMOC_DEPARTMENT where DEPARTMENTID IN (SELECT  MEMBERID 
               FROM  V_CUSTOMOC_GROUPMEMBER 
               WHERE  GROUPID =@GroupID and MEMBERTYPE = 3)
               union all
               select V_CUSTOMOC_DEPARTMENT.DEPARTMENTID,V_CUSTOMOC_DEPARTMENT.DEPARTMENTNAME,V_CUSTOMOC_DEPARTMENT.PARENTID from V_CUSTOMOC_DEPARTMENT
               join org on V_CUSTOMOC_DEPARTMENT.PARENTID = org.DEPARTMENTID
               )
               SELECT DISTINCT * 
               FROM         V_CUSTOMOC_USER    
               WHERE  ( USERID IN (SELECT  MEMBERID 
               FROM  V_CUSTOMOC_GROUPMEMBER 
               WHERE  GROUPID =@GroupID and MEMBERTYPE = 1)  
               OR USERID IN (SELECT DISTINCT USERID
               FROM          V_CUSTOMOC_USERDEPARTMENT
               WHERE      DEPARTMENTID in (SELECT DISTINCT DEPARTMENTID  FROM ORG )))
               AND USERID not in( SELECT  MEMBERID 
               FROM  V_CUSTOMOC_GROUPMEMBER 
               WHERE  GROUPID =@GroupID and MEMBERTYPE = 99)  order by USERNAME";
                list = DataAccess.Instance("BizDB").ExecuteList<UserEntity>(strQuery);
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return list;
        }

        /// <summary>
        /// 判断用户是否存在组中
        /// </summary>
        /// <param name="groupCode"></param>
        /// <param name="loginName"></param>
        /// <returns></returns>
        public bool GetGroupBYLoginName(string groupCode, string loginName)
        {
            bool isbool = false;
            loginName = loginName.Replace("\\", "/");
            try
            {
                List<UserEntity> lists = GetGroupMembers(groupCode);
                foreach (UserEntity Users in lists)
                {
                    if (Users.LOGINNAME.ToUpper().Trim() == loginName.ToUpper().Trim())
                    {
                        isbool = true;
                        return isbool;
                    }
                    else
                    {
                        isbool = false;
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return isbool;
        }

        /// <summary>
        /// Owner组特殊权限
        /// </summary>
        /// <param name="Group_Prefix">Owner组标识</param>
        /// <param name="loginName">登陆人</param>
        /// <param name="InvestigationName">公司组表所查字段名称</param>
        /// <param name="Investigation1">公司组表所查数据对应的字段名称</param>
        /// <returns></returns>
        public string Owner_Power(string Group_Prefix, string loginName,string InvestigationName, string Investigation)
        {
            if (GetGroupBYLoginName("002", loginName))
            {
                return "";
            }
            string sqlwhere = "and 1<>1";
            string countSql = @"select ORG_COMPANYGROUP.COMPANYGROUP,ORG_COMPANYGROUP."+ InvestigationName + " from ORG_USER, ORG_COMPANYGROUP where ORG_COMPANYGROUP.COMPANYID=ORG_USER.EXT03 and ext13=3 and DOMAIN+'\\'+LOGINNAME=@LOGINNAME";
            DataTable Companygroup_Dt = DataAccess.Instance("BizDB").ExecuteDataTable(countSql, loginName);
            if (Companygroup_Dt.Rows.Count > 0)
            {
                sqlwhere = "";
                string COMPANYGROUP = ConvertUtil.ToString(Companygroup_Dt.Rows[0]["COMPANYGROUP"]);
                if (GetGroupBYLoginName(Group_Prefix, loginName))
                {
                    countSql = @"select * from ORG_COMPANYGROUP where COMPANYGROUP=@COMPANYGROUP";
                    DataTable company_dt = DataAccess.Instance("BizDB").ExecuteDataTable(countSql, COMPANYGROUP);
                    string companyid = "";
                    foreach (DataRow itme in company_dt.Rows)
                    {
                        companyid += "'" + ConvertUtil.ToString(itme[""+ InvestigationName + ""]) + "',";
                    }
                    companyid = companyid.TrimEnd(',');
                    if (!string.IsNullOrEmpty(companyid))
                    {
                        sqlwhere += " and "+ Investigation + " in(" + companyid + ")";
                    }
                }
                else
                {
                    sqlwhere += " and "+ Investigation + "='" + ConvertUtil.ToString(Companygroup_Dt.Rows[0]["" + InvestigationName + ""]) + "'";//查阅本公司
                }
            }
            return sqlwhere;
        }
    }
}
