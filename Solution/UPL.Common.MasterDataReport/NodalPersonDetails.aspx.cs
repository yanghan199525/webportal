using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.CPR
{
    public partial class NodalPersonDetails : System.Web.UI.Page
    {
        string type = string.Empty;
        string nodalpersonid = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            type = Request.QueryString["Type"];
            nodalpersonid = Request.QueryString["NodalPersonID"];
            if (nodalpersonid != null)
            {
                if (!IsPostBack)
                {
                    AssignmentNodePerson(nodalpersonid);
                }
            }
        }

        [WebMethod]
        public static string BindNodePersonNumber(string searchcondition)
        {
            StringBuilder sSql = new StringBuilder();
            searchcondition = searchcondition.Trim();
            if (string.IsNullOrEmpty(searchcondition) || searchcondition == "")
            {
                sSql.AppendFormat(@"SELECT TOP 30 EMPNO,USERNAME FROM ORG_USER WHERE EMPNO NOT IN('10001','10002')");
            }
            else
            {
                sSql.AppendFormat(@"SELECT TOP 30 EMPNO,USERNAME FROM ORG_USER WHERE EMPNO NOT IN('10001','10002') AND (EMPNO LIKE '%{0}%' OR USERNAME LIKE N'%{0}%')", searchcondition);
            }

            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }

        [WebMethod]
        public static string BindNodeName(string searchcondition)
        {
            StringBuilder sSql = new StringBuilder();
            searchcondition = searchcondition.Trim();
            if (string.IsNullOrEmpty(searchcondition) || searchcondition == "")
            {
                sSql.AppendFormat(@"SELECT TOP 30 orgCode FROM (SELECT parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName FROM SODEXO_ORGANIZATION WHERE leaderNumber IN(SELECT leaderNumber FROM SODEXO_ORGANIZATION GROUP BY leaderNumber HAVING leaderNumber NOT IN (SELECT employeeNumber FROM SODEXO_EMPLOYEE GROUP BY employeeNumber)) AND orgCode NOT LIKE '%CN%') A GROUP BY orgCode");
            }
            else
            {
                sSql.AppendFormat(@"SELECT TOP 30 orgCode FROM (SELECT parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName FROM SODEXO_ORGANIZATION WHERE leaderNumber IN(SELECT leaderNumber FROM SODEXO_ORGANIZATION GROUP BY leaderNumber HAVING leaderNumber NOT IN (SELECT employeeNumber FROM SODEXO_EMPLOYEE GROUP BY employeeNumber)) AND orgCode NOT LIKE '%CN%') A GROUP BY orgCode HAVING orgCode LIKE N'%{0}%'", searchcondition);
            }

            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }

        /// <summary>
        /// 保存按钮单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                #region 保存
                //HttpCookie Cookies_LoginName = Request.Cookies["LoginName"];
                HiddenField hdNodeName = (HiddenField)Page.FindControl("hdNodeName");
                HiddenField hdNodePersonNumber = (HiddenField)Page.FindControl("hdNodePersonNumber");
                HiddenField hdNodePersonName = (HiddenField)Page.FindControl("hdNodePersonName");
                StringBuilder sSql = new StringBuilder();
                DataAccess db = DataAccess.Instance("BizDB");

                string UserName = SessionLogic.GetLoginName();
                string LoginName = string.Empty;
                if (UserName.Contains("\\"))
                {
                    LoginName = UserName.Split('\\')[1];
                }
                else
                {
                    string domain = "CustomOC";
                    Regex r = new Regex(domain);
                    Match m = r.Match(UserName);
                    if (m.Success)
                    {
                        LoginName = UserName.Replace(domain, "");
                    }
                }

                string NodeName = hdNodeName.Value;
                string NodePersonNumber = hdNodePersonNumber.Value;
                string NodePersonName = hdNodePersonName.Value;

                sSql.Length = 0;
                sSql.AppendFormat(@"SELECT EMPNO FROM ORG_USER WHERE LOGINNAME='{0}'", LoginName);
                DataTable users = db.ExecuteDataTable(sSql.ToString());
                if (users.Rows.Count > 0)
                {
                    if (type.ToUpper() == "ADD")
                    {
                        #region 新增
                        string createUser = users.Rows[0][0].ToString();
                        if (!string.IsNullOrEmpty(NodeName) && NodeName != "请选择")
                        {
                            if (!string.IsNullOrEmpty(NodePersonNumber))
                            {
                                sSql.Length = 0;
                                sSql.AppendFormat(@"SELECT orgCode,leaderNumber FROM SODEXO_ORGANIZATION_BAK ORGBAK,SODEXO_EMPLOYEE EMPLOYEE WHERE orgCode='{0}' AND ORGBAK.leaderNumber=EMPLOYEE.employeeNumber", NodeName);
                                if (db.ExecuteDataTable(sSql.ToString()).Rows.Count > 0)
                                {
                                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('此节点（" + NodeName + "）负责人是接口同步数据，无法添加');window.close()</script>");
                                }
                                else if (!checkConfigured(NodeName))
                                {
                                    sSql.Length = 0;
                                    sSql.Append(@"INSERT INTO SODEXO_PROCESSSTEPAPPROVER(orgCode,leaderNumber,leaderName,createUser,createDate) VALUES(@orgCode,@leaderNumber,@leaderName,@createUser,@createDate)");

                                    using (DbCommand cmd = db.CreateCommand())
                                    {
                                        cmd.CommandText = sSql.ToString();
                                        cmd.CommandType = CommandType.Text;

                                        db.AddInParameter(cmd, "@orgCode", DbType.String, NodeName);
                                        db.AddInParameter(cmd, "@leaderNumber", DbType.String, NodePersonNumber);
                                        db.AddInParameter(cmd, "@leaderName", DbType.String, NodePersonName);
                                        db.AddInParameter(cmd, "@createUser", DbType.String, createUser);
                                        db.AddInParameter(cmd, "@createDate", DbType.DateTime, DateTime.Now);
                                        if (db.ExecuteNonQuery(cmd) > 0)
                                        {
                                            #region 更新进ORGANIZATION里

                                            sSql.Length = 0;
                                            sSql.AppendFormat(@"UPDATE SODEXO_ORGANIZATION SET leaderNumber='{0}',leaderName=N'{1}' WHERE orgCode='{2}'", NodePersonNumber, NodePersonName, NodeName);
                                            if (db.ExecuteNonQuery(sSql.ToString()) > 0)
                                            {
                                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('保存成功');window.close()</script>");
                                            }
                                            else
                                            {
                                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('保存失败');window.close()</script>");
                                            }
                                            #endregion
                                        }
                                    }
                                }
                                else
                                {
                                    hdNodeName.Value = "";
                                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('当前节点（" + NodeName + "）已配置，请至负责人节点维护界面查看.')</script>");
                                }
                            }
                            else
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('请选择节点负责人.')</script>");
                            }
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('请选择节点名称.')</script>");
                        }
                        #endregion
                    }
                    else if (type.ToUpper() == "EDIT")
                    {
                        #region 修改
                        string createUser = users.Rows[0][0].ToString();
                        sSql.Length = 0;
                        sSql.AppendFormat(@"SELECT orgCode,leaderNumber FROM SODEXO_ORGANIZATION_BAK ORGBAK,SODEXO_EMPLOYEE EMPLOYEE WHERE orgCode='{0}' AND ORGBAK.leaderNumber=EMPLOYEE.employeeNumber", NodeName);
                        if (db.ExecuteDataTable(sSql.ToString()).Rows.Count > 0)
                        {
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('此节点（" + NodeName + "）负责人是接口同步数据，无法修改');window.close()</script>");
                        }
                        else
                        {
                            sSql.Length = 0;
                            if (!string.IsNullOrEmpty(nodalpersonid))
                            {
                                sSql.AppendFormat(@"UPDATE SODEXO_PROCESSSTEPAPPROVER SET leaderNumber='{0}',leaderName=N'{1}',createUser='{3}',createDate=GETDATE() WHERE Id={2}", NodePersonNumber, NodePersonName, nodalpersonid, createUser);
                            }
                            else
                            {
                                sSql.AppendFormat(@"UPDATE SODEXO_PROCESSSTEPAPPROVER SET leaderNumber='{0}',leaderName=N'{1}',createUser='{3}',createDate=GETDATE() WHERE orgCode='{2}'", NodePersonNumber, NodePersonName, NodeName, createUser);
                            }
                            int res1 = db.ExecuteNonQuery(sSql.ToString());
                            sSql.Length = 0;
                            sSql.AppendFormat(@"UPDATE SODEXO_ORGANIZATION SET leaderNumber='{0}',leaderName=N'{1}' WHERE orgCode='{2}'", NodePersonNumber, NodePersonName, NodeName);
                            int res2 = db.ExecuteNonQuery(sSql.ToString());
                            if (res1 > 0 && res2 > 0)
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('操作成功');window.close()</script>");
                            }
                            else
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('操作失败，请联系管理员')</script>");
                            }
                        }
                        #endregion
                    }
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('登录已失效，请重新登入系统.')</script>");
                }
                #endregion
            }
            catch (Exception ex)
            {
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "aaaa", "<script>alert('操作失败，请联系管理员，错误信息：" + ex.Message + "')</script>");
                throw new Exception("操作失败，请联系管理员，错误信息：" + ex.Message + "");
            }

        }

        /// <summary>
        /// 判断是否配置
        /// </summary>
        /// <param name="NodeName"></param>
        /// <returns></returns>
        protected bool checkConfigured(string NodeName)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");
            sSql.AppendFormat(@"SELECT Id FROM SODEXO_PROCESSSTEPAPPROVER WHERE orgCode='{0}'", NodeName);
            DataTable PRO = db.ExecuteDataTable(sSql.ToString());
            if (PRO.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 根据ID查询结果并赋值
        /// </summary>
        /// <param name="nodalPersonId"></param>
        protected void AssignmentNodePerson(string nodalPersonId)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");
            HiddenField hdNodeName = (HiddenField)Page.FindControl("hdNodeName");
            HiddenField hdNodePersonNumber = (HiddenField)Page.FindControl("hdNodePersonNumber");
            HiddenField hdNodePersonName = (HiddenField)Page.FindControl("hdNodePersonName");

            sSql.AppendFormat(@"SELECT orgCode,leaderNumber,USERNAME FROM SODEXO_PROCESSSTEPAPPROVER PRO,ORG_USER USERS WHERE Id={0} AND PRO.leaderNumber=USERS.EMPNO", nodalPersonId);
            DataTable processStepApprover = db.ExecuteDataTable(sSql.ToString());
            if (processStepApprover.Rows.Count > 0)
            {
                string orgCode = processStepApprover.Rows[0]["orgCode"].ToString();
                string leaderNumber = processStepApprover.Rows[0]["leaderNumber"].ToString();
                string userName = processStepApprover.Rows[0]["USERNAME"].ToString();
                hdNodeName.Value = orgCode;
                hdNodePersonNumber.Value = leaderNumber;
                hdNodePersonName.Value = userName;
            }
        }
    }
}