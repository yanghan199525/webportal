using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Logic;
using System.Text;

namespace PR.PRProcess.HK_CPR_SERVICE
{
    public partial class ReportListAll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            //ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = "BizDB.SELECT TOP 200000 T.FORMID, T.PROCESSNAME, T.INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, T.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE, ACTION FROM (SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_HK_CPR_SERVICE WHERE 1 = 1) T,(SELECT * FROM WF_APPROVALHISTORY WHERE ID IN(SELECT TOP 200000 MAX(ID) ID FROM WF_APPROVALHISTORY GROUP BY FORMID)) WF WHERE T.FORMID=WF.FORMID AND T.INCIDENT!='-1' ORDER BY T.REQUESTDATE DESC";
            //rpt.Source = "BizDB.select * from PROC_CPR_FOOD where 1=1 " + process.GetReportViewSql("CPR_FOOD", SessionLogic.GetLoginName());

            Ultimus.UWF.Form.WebControls.Repeater importFailedRecord = Page.FindControl("ImportFailedRecord") as Ultimus.UWF.Form.WebControls.Repeater;
            importFailedRecord.Source = string.Format("BizDB.SELECT TOP 200000 AAA.FORMID, AAA.PROCESSNAME, AAA.INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, AAA.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE, SYNCSTATUS, ERRORMSG, CL.CREATEDATE, ACTION FROM (SELECT TOP 200000 FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_HK_CPR_SERVICE WHERE 1 = 1  ORDER BY PROC_HK_CPR_SERVICE.REQUESTDATE DESC) AAA,(SELECT * FROM PROC_CPR_LOG CPR_LOG WHERE CREATEDATE=(SELECT MAX(CREATEDATE) FROM PROC_CPR_LOG WHERE EXT01=CPR_LOG.EXT01 AND EXT02=CPR_LOG.EXT02)) CL,(SELECT * FROM WF_APPROVALHISTORY WHERE ID IN(SELECT TOP 200000 MAX(ID) ID FROM WF_APPROVALHISTORY GROUP BY FORMID)) WF WHERE AAA.PROCESSNAME=CL.EXT01 AND AAA.INCIDENT=CL.EXT02 AND CL.SYNCSTATUS=0 AND AAA.FORMID=WF.FORMID ORDER BY CL.CREATEDATE DESC");
        }

        protected void lbExport_Click(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            DataTable dt = rpt.GetFullDataTable();
            // dt数据为空不导出Excel
            if (dt.Rows.Count == 0 || dt == null)
            {
                return;
            }
            dt = ExportLogic.GetSchemaTable("HK_CPR_SERVICE", dt);
            ExcelUtil.Export(dt);
        }

        /// <summary>
        /// 审批中查询事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUnderApproval_Click(object sender, EventArgs e)
        {
            DropDownList txt_ACTION = (DropDownList)Page.FindControl("txt_ACTION");
            txt_ACTION.SelectedItem.Value = "";
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = "BizDB.SELECT TOP 200000 T.FORMID, T.PROCESSNAME, T.INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, T.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE, ACTION FROM (SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_HK_CPR_SERVICE WHERE 1 = 1) T,(SELECT * FROM WF_APPROVALHISTORY WHERE ID IN(SELECT TOP 200000 MAX(ID) ID FROM WF_APPROVALHISTORY GROUP BY FORMID)) WF WHERE T.FORMID=WF.FORMID AND T.INCIDENT!='-1' AND T.COMPLETEDATE IS NULL AND WF.ACTION NOT LIKE N'%退回%' AND WF.ACTION NOT LIKE N'%作废%' ORDER BY T.REQUESTDATE DESC";
        }

        /// <summary>
        /// 根据错误信息，显示期望错误信息
        /// </summary>
        /// <param name="errormsg"></param>
        /// <param name="createdate"></param>
        /// <returns></returns>
        public string JudgmentCPR_Log(string errormsg, string createdate)
        {
            string errormsg_ = string.Empty;
            string date = string.Empty;
            DateTime createdate_ = new DateTime();
            if (!string.IsNullOrEmpty(errormsg))
            {
                switch (errormsg)
                {
                    case "An internal error occurred during your request!":
                        //errormsg_ = "CPR生成异常：2020-07-09 14:24:30  请联系管理员";
                        createdate_ = Convert.ToDateTime(createdate);
                        date = createdate_.ToString("yy-MM-dd HH:mm:ss");
                        errormsg_ = string.Format("CPR生成异常：{0}  请联系管理员", date);
                        break;
                    //case "Your request is not valid!":
                    //    createdate_ = Convert.ToDateTime(createdate);
                    //    date = createdate_.ToString("yy-MM-dd HH:mm:ss");
                    //    errormsg_ = string.Format("CPR生成异常，验证不通过：{0}  请联系管理员", date);
                    //    break;
                    case "发生一个或多个错误。":
                        //errormsg_ = "CPR生成异常：2020-07-09 14:24:30  请联系管理员";
                        createdate_ = Convert.ToDateTime(createdate);
                        date = createdate_.ToString("yy-MM-dd HH:mm:ss");
                        errormsg_ = string.Format("CPR生成异常：{0}  请联系管理员", date);
                        break;
                    default:
                        errormsg_ = errormsg;
                        break;
                }
            }
            else
            {
                errormsg_ = "";
            }
            return errormsg_;
        }

        private string getRootPath()
        {
            string rootPath = string.Empty;
            string prex = "http";
            if (HttpContext.Current.Request.Url.Scheme == "https")
            {
                prex = "https";
            }
            else if (HttpContext.Current.Request.Url.Scheme == "http")
            {
                prex = "http";
            }
            if (HttpContext.Current.Request.Url.Port == 80)
            {
                rootPath = prex + "://" + HttpContext.Current.Request.Url.Host;
            }
            else
            {
                rootPath = prex + "://" + HttpContext.Current.Request.Url.Host + ":" +
                  HttpContext.Current.Request.Url.Port;
            }

            return rootPath;
        }

        public string JudgmentHandler(string formId, string processName, string incident, string action, string documentno)
        {
            string url = string.Empty;
            if (action.Contains("退回"))
            {
                string path = getRootPath();
                string loginName = Request.QueryString["loginName"];
                string userName = "CustomOC\\" + loginName;
                string taskId = string.Empty;
                StringBuilder sSql = new StringBuilder();
                sSql.AppendFormat(@"SELECT TASKID FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 and STEPLABEL='Begin'", processName, incident);
                DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
                if (dtTask.Rows.Count > 0)
                {
                    taskId = dtTask.Rows[0][0].ToString();
                }

                url = string.Format("<a target=\"_blank\" href=\"{0}/Solution/PR.PRProcess.{1}/Form/NewRequest.aspx?ProcessName={1}&StepName=Begin&Incident={2}&TaskID={3}&UserName={4}&Type=REPORT\">{5}</a>", path, processName.Trim(), incident.Trim(), taskId.Trim(), userName.Trim(), documentno);
                return url;
            }
            else
            {
                url = string.Format("<a target=\"_blank\" href=\"javascript: void(0)\" onclick=\"javascript: objReport.openForm('{0}','{1}','{2}');return false;\" style=\"cursor:head\">{3}</a>", formId, processName, incident, documentno);
                return url;
            }

            //url = string.Format("<a target=\"_blank\" href=\"{0}/Solution/PR.PRProcess.{1}/Form/aaa.aspx?ProcessName={1}&StepName=Applicant%20Confirmation&Incident={2}&TaskID={3}&UserName={4}&Type=MYTASK\">{5}</a>", path, processName.Trim(), incident.Trim(), taskId.Trim(), userName.Trim(), documentno);
        }
    }
}