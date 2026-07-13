using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class RDconfirmList : System.Web.UI.Page
    {
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string LoginName = SessionLogic.GetLoginName().Split('\\')[1];
            string empNo = GetLeaderNumber(LoginName);
            languaes = GetLanguaes(LoginName);
            BindPageTxt(languaes);
            if (empNo == null)
            {
                Response.Write("<script>alert('此页面为RD授权确认页面，您无法访问,This page is an RD Licensing confirmation page, and you cannot access it!');window.location.href='MyTaskListV3.aspx'</script>");
            }
            else {
                Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
                //ProcessFormLogic process = new ProcessFormLogic();
                rpt.Source = string.Format("BizDB.select orgCode, startTime, endTime, rdLeaderNumber,authRange, sdLeaderNumber,sdOrgCode,b.LOGINNAME rdName,c.LOGINNAME sdName from PROC_SDAuth a,ORG_USER b,ORG_USER c where type = N'授权中/Under authorization'  and a.rdLeaderNumber=b.EMPNO and a.sdLeaderNumber=c.EMPNO and a.rdLeaderNumber='{0}'", empNo);

                Ultimus.UWF.Form.WebControls.Repeater rptLog = Page.FindControl("rptInfo") as Ultimus.UWF.Form.WebControls.Repeater;
                //ProcessFormLogic process = new ProcessFormLogic();
                rptLog.Source = string.Format("BizDB.select sdName,sdEmpNo,sdCreatTime,sdOrgName,rdName,rdEmpNo,rdCreatTime,authStartTime,authEndTime,authDesc,authRange,comments  from PROC_Decentralization_Log where rdEmpNo='{0}'", empNo);
                rptLog.Sort = " sdCreatTime DESC";
            }
           
           
        }
        public string GetLeaderNumber(string LoginName)
        {

            string sql = string.Format("select leaderName,leaderNumber from SODEXO_ORGANIZATION where orgCode like '%RD%'AND leaderNumber IN(SELECT EMPNO FROM ORG_USER WHERE LOGINNAME = N'{0}')", LoginName);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["leaderNumber"].ToString();
            }
            else {
                return null;
            }
         
        }
        public void BindPageTxt(string type)
        {
            switch (type)
            {
                case "zh-CN":
                    this.lable_info.Text = "RD授权信息确认列表";
                    this.lable_rdName.Text = "RD姓名";
                    this.label_rdEmpNo.Text = "RD员工编号:";
                    this.label_rdOrgName.Text = "RD事业部:";
                    this.label_sdEpmName.Text = "SD名称";
                    this.label_sdEpmNo.Text = "SD编号";
                    this.label_sdOrgName.Text = "SD事业部";
                    this.label_startTime.Text = "授权开始时间";
                    this.label_endTime.Text = "授权结束时间";
                    this.label_Range.Text = "授权范围";
                    this.label_operation.Text = "操作";
                    

                    this.log_info.Text = "RD授权信息操作记录";
                    this.log_sdName.Text = "授权操作人名称";
                    this.log_sdEmpNo.Text = "授权操作人编号";
                    this.log_sdCreate.Text = "授权操作时间";
                    this.log_orgName.Text = "事业部";
                    this.log_rdName.Text = "RD姓名";
                    this.log_rdempNo.Text = "RD员工编号";
                    this.log_rdCreate.Text = "RD操作时间";
                    this.log_startTime.Text = "授权开始时间";
                    this.log_endTime.Text = "授权结束时间";
                    this.log_desc.Text = "授权说明";
                    this.log_range.Text = "授权范围";
                    this.log_content.Text = "操作内容";
                    break;
                case "en-US":
                    this.lable_info.Text = "List of RD's authorized information";
                    this.lable_rdName.Text = "RD Name";
                    this.label_rdEmpNo.Text = "RD Staff No.";
                    this.label_rdOrgName.Text = "Business Unit";
                    this.label_sdEpmName.Text = "SD Name";
                    this.label_sdEpmNo.Text = "SD Staff No.";
                    this.label_sdOrgName.Text = "Business Unit";
                    this.label_startTime.Text = "Start time of authorization";
                    this.label_endTime.Text = "End time of authorization";
                    this.label_Range.Text = "Scope of Authorization";
                    this.label_operation.Text = "operation";

                    this.log_info.Text = "Operating records of RD's authorized information";
                    this.log_sdName.Text = "SD Name";
                    this.log_sdEmpNo.Text = "SD Staff No.";
                    this.log_sdCreate.Text = "Operating Time of Authorization";
                    this.log_orgName.Text = "Business Unit";
                    this.log_rdName.Text = "RD Name";
                    this.log_rdempNo.Text = "RD Staff No.";
                    this.log_rdCreate.Text = "Operating Time of RD";
                    this.log_startTime.Text = "Start Time of Authorization";
                    this.log_endTime.Text = "End Time of Authorization";
                    this.log_desc.Text = "Authorization Discription";
                    this.log_range.Text = "Scope of Authorization";
                    this.log_content.Text = "Operation content";
                    break;
                default:
                    break;
            }
        }

        public string GetLanguaes(string loginName)
        {
            string sql = string.Format("select LANGUAGE from ORG_USER where LOGINNAME='{0}'", loginName);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt.Rows[0]["LANGUAGE"].ToString();
        }

    }
}