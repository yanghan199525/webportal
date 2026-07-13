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
using Ultimus.UWF.EmailNotification;
using System.Text;
using System.Data.Common;

namespace PR.PRProcess.CPR_FOOD
{
    public partial class ReportList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Request.QueryString[""]
            string pcCode = Request.QueryString["pccode"];
            string empNo = Request.QueryString["empNo"];
            pcCode = string.IsNullOrEmpty(pcCode) ? "" : pcCode.ToUpper();
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            //rpt.Source = "BizDB.select * from PROC_CPR_FOOD where 1=1 "+process.GetReportViewSql("CPR_FOOD",SessionLogic.GetLoginName());
            //rpt.Source = string.Format("BizDB.select * from (select * from PROC_CPR_FOOD union select * from PROC_CPR_NONFOOD) T WHERE 1=1 AND T.SITECODE='{0}'",pcCode);
            rpt.Source = string.Format("BizDB.SELECT TOP 2000000 AAA.FORMID, AAA.PROCESSNAME, AAA.INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, AAA.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE, ACTION FROM (SELECT TOP 2000000 * FROM (SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_FOOD UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_NONFOOD UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_SERVICE) T WHERE 1 = 1 AND T.SITECODE = '{0}' AND T.APPLICANTCODE='{1}' ORDER BY T.REQUESTDATE DESC) AAA,(SELECT * FROM WF_APPROVALHISTORY WHERE ID IN(SELECT TOP 2000000 MAX(ID) ID FROM WF_APPROVALHISTORY GROUP BY FORMID)) WF WHERE AAA.FORMID=WF.FORMID AND AAA.INCIDENT!='-1' ORDER BY AAA.REQUESTDATE DESC", pcCode, empNo);

            Ultimus.UWF.Form.WebControls.Repeater drafts = Page.FindControl("draftsList") as Ultimus.UWF.Form.WebControls.Repeater;
            drafts.Source = string.Format("BizDB.SELECT TOP 2000000 AAA.FORMID, AAA.PROCESSNAME, AAA.INCIDENT, DOCUMENTNO, AAA.CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, AAA.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM (SELECT TOP 2000000 * FROM (SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_FOOD UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_NONFOOD UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_SERVICE) T WHERE 1 = 1 AND T.SITECODE = '{0}' ORDER BY T.REQUESTDATE DESC) AAA,(SELECT * FROM WF_DRAFT) WF_D WHERE AAA.FORMID=WF_D.FORMID AND (AAA.INCIDENT='-1' or  AAA.INCIDENT='-2') ORDER BY AAA.REQUESTDATE DESC", pcCode);

            Ultimus.UWF.Form.WebControls.Repeater importFailedRecord = Page.FindControl("ImportFailedRecord") as Ultimus.UWF.Form.WebControls.Repeater;

            importFailedRecord.Source = string.Format("BizDB.SELECT TOP 2000000 AAA.FORMID, AAA.PROCESSNAME, AAA.INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT,CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE,DEPARTMENT,DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, AAA.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME,DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE,PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET,USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME,USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE,SYNCSTATUS,ERRORMSG, CREATEDATE FROM (SELECT TOP 2000000 * FROM (SELECT FORMID, PROCESSNAME,INCIDENT, DOCUMENTNO,CREATEBY,CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT,APPLICANTCODE, APPLICANTTEL, REQUESTDATE,COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE,SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE,SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE,AMOUNT, APPREMARK,APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE,OVERTIME,PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2,USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME,SIGNEDAPPROVERNUMBER, DELIVERY,APPROVE FROM PROC_CPR_FOOD where  SITECODE = '{0}' AND APPLICANTCODE='{1}'  AND INCIDENT !=-1 AND REQUESTDATE>GETDATE()-30 UNION SELECT FORMID, PROCESSNAME,INCIDENT,DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE,APPLICANTTEL,REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY,STATUS,APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME,ASSETTYPE,AMOUNT,APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT,CPRFAMILYCODE,OVERTIME,PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2,USER_SIGNEDAPPROVER3,USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME,SIGNEDAPPROVERNUMBER,DELIVERY, APPROVE FROM PROC_CPR_NONFOOD where  SITECODE = '{0}' AND APPLICANTCODE='{1}'  AND INCIDENT !=-1 AND REQUESTDATE>GETDATE()-30 UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT,APPLICANTACCOUNT,APPLICANTCODE,APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID,COMPANY,COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE,SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE,AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT,SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE,OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME,SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_SERVICE where  SITECODE = '{0}' AND APPLICANTCODE='{1}' AND INCIDENT !=-1 AND REQUESTDATE>GETDATE()-30) T WHERE 1 = 1 ORDER BY T.REQUESTDATE DESC) AAA  join (SELECT * FROM PROC_CPR_LOG CPR_LOG WHERE CREATEDATE=(SELECT MAX(CREATEDATE)FROM PROC_CPR_LOG WHERE EXT01=CPR_LOG.EXT01 AND EXT02=CPR_LOG.EXT02 and CREATEDATE>GETDATE()-30)) CL on AAA.PROCESSNAME=CL.EXT01 AND AAA.INCIDENT=CL.EXT02 AND CL.SYNCSTATUS=0 ORDER BY CL.CREATEDATE DESC ", pcCode, empNo);




            #region 老旧查询导入失败记录方法（已注释）
            //importFailedRecord.Source = string.Format("BizDB.SELECT TOP 2000000 AAA.FORMID, AAA.PROCESSNAME, AAA.INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, AAA.STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE, SYNCSTATUS, ERRORMSG, CREATEDATE FROM (SELECT TOP 2000000 * FROM (SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_FOOD UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_NONFOOD UNION SELECT FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, CREATEBY, CREATEBYACCOUNT, CREATEBYCODE, APPLICANT, APPLICANTACCOUNT, APPLICANTCODE, APPLICANTTEL, REQUESTDATE, COMPLETEDATE, DEPARTMENT, DEPARTMENTID, COMPANY, COSTCENTER, PROCESSSUMMARY, STATUS, APPLYPURPOSE, SUPPLIERTYPE, SITECODE, SITENAME, DELIVERYDATE, SUPPLIERCODE, SUPPLIERNAME, ASSETTYPE, AMOUNT, APPREMARK, APPROVEDATE, PCCOMPCODE, APPLYPURPOSETXT, SUPPLIERTYPETXT, ASSETTYPETXT, CPRFAMILYCODE, OVERTIME, PURCHASINGAGENT, ONLINEORSUPERMARKET, USER_SIGNEDAPPROVER, USER_SIGNEDAPPROVER2, USER_SIGNEDAPPROVER3, USER_SIGNEDAPPROVERNAME, USER_SIGNEDAPPROVER2NAME, USER_SIGNEDAPPROVER3NAME, SIGNEDAPPROVERNUMBER, DELIVERY, APPROVE FROM PROC_CPR_SERVICE) T WHERE 1 = 1 AND T.SITECODE = '{0}' AND T.APPLICANTCODE='{1}' ORDER BY T.REQUESTDATE DESC) AAA,(SELECT * FROM PROC_CPR_LOG) CL WHERE AAA.PROCESSNAME=CL.EXT01 AND AAA.INCIDENT=CL.EXT02 AND CL.SYNCSTATUS=0 ORDER BY CL.CREATEDATE DESC", pcCode, empNo);
            #endregion
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
            dt = ExportLogic.GetSchemaTable("CPR_FOOD", dt);
            ExcelUtil.Export(dt);
        }

        protected void lbHastenWork_Click(object sender, EventArgs e)
        {
            EmailNotificationSubscription emailNotification = new EmailNotificationSubscription();
            string HastenWork = ((LinkButton)sender).CommandArgument;
            string processname = HastenWork.Split(',')[0];
            string incident = HastenWork.Split(',')[1];
            string completedate = HastenWork.Split(',')[2];
            string documentno = HastenWork.Split(',')[3];
            string action = HastenWork.Split(',')[4];

            //点击催办，显示loading效果
            initJavascript();
            //催办邮件日志
            string errorMsg = string.Empty;
            //判断点击之后是否间隔一分钟
            if (checkRemindersInterval(processname, incident))
            {
                if (action.Contains("退回"))
                {
                    string msg = "单外采购申请【" + documentno + "】状态为已退回，无法催办" + "\\n" + "The status of CPR[" + documentno + "] is returned,cannot be urged";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                }
                else
                {
                    if (completedate == "")
                    {
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('催办');", true);
                        StringBuilder sSql = new StringBuilder();
                        sSql.AppendFormat(@"SELECT TASKID,a.PROCESSNAME,a.INCIDENT,b.SUMMARY,b.INITIATOR,a.STEPLABEL,a.TASKUSER,a.ASSIGNEDTOUSER,a.STATUS,      a.SUBSTATUS,a.STARTTIME,a.ENDTIME,a.STEPID,a.OVERDUETIME,b.STATUS as PROCESSSTATUS,'' as SERVERNAME  FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 ", processname, incident);
                        DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
                        if (dtTask.Rows.Count > 0)
                        {
                            string stepLabel = string.Empty;
                            string taskUser = string.Empty;
                            string ti = string.Empty;
                            int res = 0;

                            try
                            {
                                foreach (DataRow row in dtTask.Rows)
                                {
                                    string hwProcessname = processname + ".HastenWork";
                                    int nStepType = ConvertUtil.ToInt32(row["StepId"]);
                                    string strTaskId = ConvertUtil.ToString(row["TaskID"]);

                                    stepLabel = string.Format("{0};", ConvertUtil.ToString(row["STEPLABEL"]).Trim());
                                    taskUser = string.Format("{0};", ConvertUtil.ToString(row["TASKUSER"]).Trim());
                                    ti = string.Format("{0};", ConvertUtil.ToString(row["TASKID"]).Trim());

                                    emailNotification.TaskActivated(hwProcessname, ConvertUtil.ToInt32(incident), nStepType, strTaskId);
                                }

                                res = 1;
                                string msg = string.Format("单外采购申请【{0}】邮件发送成功，不要重复点击" + "\\n" + "The status of CPR[{0}] email sent successfully,do not repeat the click", documentno);
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('111');", true);
                                UnloadJavascript();
                            }
                            catch (Exception ex)
                            {
                                UnloadJavascript();
                                errorMsg = ex.Message;
                                res = 0;

                                #region 催办日志记录
                                hwLog(res, processname, incident, errorMsg, stepLabel, taskUser, ti);
                                #endregion

                                string msg = string.Format("单外采购申请【{0}】邮件发送失败（{1}），请联系管理员" + "\\n" + "The status of CPR[{0}] email sent failed({1}),please contact the administrator", documentno, ex.Message);
                                throw new Exception(msg);
                            }

                            #region 催办日志记录
                            hwLog(res, processname, incident, errorMsg, stepLabel, taskUser, ti);
                            #endregion
                        }
                    }
                    else
                    {
                        string msg = "单外采购申请【" + documentno + "】状态为已完成，无法催办" + "\\n" + "The status of CPR[" + documentno + "] is completed,cannot be urged";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                    }
                }
            }
            else
            {
                string msg = string.Format("请四小时后再点击此【催办】按钮" + "\\n" + "Please click the push button four hour later");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                UnloadJavascript();
            }

        }

        protected void lbDraftDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string HastenWork = ((LinkButton)sender).CommandArgument;
                string processname = HastenWork.Split(',')[0];
                string incident = HastenWork.Split(',')[1];
                string formid = HastenWork.Split(',')[2];
                string taskid = string.Empty;
                string rootPath = getRootPath();

                StringBuilder sSql = new StringBuilder();
                sSql.AppendFormat(@"SELECT TASKID FROM WF_DRAFT WHERE FORMID='{0}'", formid);
                taskid = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
                string url = string.Format("{6}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&FORMID={2}&incident={3}&ProcessName={4}&StepName={5}", taskid, "Draft", formid, incident, processname, "Begin", rootPath);
                Response.Redirect(url);
                //Response.Write("<script>window.open('" + url + "','_blank')</script>");
            }
            catch (Exception ex)
            {
                string msg = "打开草稿失败，请联系管理员（" + ex.Message + "）\\nOpen draft failed, please contact administrator";
                Response.Write(msg);
            }
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

        #region "页面加载中效果"
        /// <summary>
        /// 页面加载中效果
        /// </summary>
        public static void initJavascript()
        {
            HttpContext.Current.Response.Write(" <script language=JavaScript type=text/javascript>");
            HttpContext.Current.Response.Write("var t_id = setInterval(animate,20);");
            HttpContext.Current.Response.Write("var pos=0;var dir=2;var len=0;");
            HttpContext.Current.Response.Write("function animate(){");
            HttpContext.Current.Response.Write("var elem = document.getElementById('progress');");
            HttpContext.Current.Response.Write("if(elem != null) {");
            HttpContext.Current.Response.Write("if (pos==0) len += dir;");
            HttpContext.Current.Response.Write("if (len>32 || pos>79) pos += dir;");
            HttpContext.Current.Response.Write("if (pos>79) len -= dir;");
            HttpContext.Current.Response.Write(" if (pos>79 && len==0) pos=0;");
            HttpContext.Current.Response.Write("elem.style.left = pos;");
            HttpContext.Current.Response.Write("elem.style.width = len;");
            HttpContext.Current.Response.Write("}}");
            HttpContext.Current.Response.Write("function remove_loading() {");
            HttpContext.Current.Response.Write(" this.clearInterval(t_id);");
            HttpContext.Current.Response.Write("var targelem = document.getElementById('loader_container');");
            HttpContext.Current.Response.Write("targelem.style.display='none';");
            HttpContext.Current.Response.Write("targelem.style.visibility='hidden';");
            HttpContext.Current.Response.Write("}");
            HttpContext.Current.Response.Write("</script>");
            HttpContext.Current.Response.Write("<style>");
            HttpContext.Current.Response.Write("#loader_container {text-align:center; position:absolute; top:40%; width:100%; left: 0;}");
            HttpContext.Current.Response.Write("#loader {font-family:Tahoma, Helvetica, sans; font-size:11.5px; color:#000000; background-color:#FFFFFF; padding:10px 0 16px 0; margin:0 auto; display:block; width:130px; border:1px solid #5a667b; text-align:left; z-index:2;}");
            HttpContext.Current.Response.Write("#progress {height:5px; font-size:1px; width:1px; position:relative; top:1px; left:0px; background-color:#8894a8;}");
            HttpContext.Current.Response.Write("#loader_bg {background-color:#e4e7eb; position:relative; top:8px; left:8px; height:7px; width:113px; font-size:1px;}");
            HttpContext.Current.Response.Write("</style>");
            HttpContext.Current.Response.Write("<div id=loader_container>");
            HttpContext.Current.Response.Write("<div id=loader>");
            HttpContext.Current.Response.Write("<div align=center>正在发送...</div>");
            HttpContext.Current.Response.Write("<div id=loader_bg><div id=progress> </div></div>");
            HttpContext.Current.Response.Write("</div></div>");
            HttpContext.Current.Response.Flush();
        }
        public static void UnloadJavascript()
        {
            HttpContext.Current.Response.Write(" <script language=JavaScript type=text/javascript>");
            HttpContext.Current.Response.Write("remove_loading();");
            HttpContext.Current.Response.Write(" </script>");
        }
        #endregion

        public static void hwLog(int res, string processName, string incident, string errorMsg, string stepLabel, string taskUser, string taskId)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            StringBuilder sSql = new StringBuilder();
            sSql.Length = 0;
            sSql.Append(@"
INSERT INTO PROC_CPR_HASTENWORK_LOG
(ID,SYNCTYPE,SYNCSTATUS,CREATEDATE,EXT01,EXT02,EXT03,EXT04,EXT05,ERRORMSG)
VALUES
(@ID,@SYNCTYPE,@SYNCSTATUS,@CREATEDATE,@EXT01,@EXT02,@EXT03,@EXT04,@EXT05,@ERRORMSG)");
            //DataAccess db = DataAccess.Instance("BizDB");
            using (DbCommand cmd = db.CreateCommand())
            {
                cmd.CommandText = sSql.ToString();
                cmd.CommandType = CommandType.Text;


                db.AddInParameter(cmd, "@ID", DbType.String, Guid.NewGuid().ToString());
                db.AddInParameter(cmd, "@SYNCTYPE", DbType.String, "SendReminders");
                db.AddInParameter(cmd, "@SYNCSTATUS", DbType.Int32, res);
                db.AddInParameter(cmd, "@CREATEDATE", DbType.DateTime, Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                db.AddInParameter(cmd, "@EXT01", DbType.String, processName);
                db.AddInParameter(cmd, "@EXT02", DbType.String, incident);
                db.AddInParameter(cmd, "@EXT03", DbType.String, stepLabel);
                db.AddInParameter(cmd, "@EXT04", DbType.String, taskUser);
                db.AddInParameter(cmd, "@EXT05", DbType.String, taskId);
                db.AddInParameter(cmd, "@ERRORMSG", DbType.String, errorMsg);
                db.ExecuteNonQuery(cmd);
            }
        }

        public static bool checkRemindersInterval(string processName, string incident)
        {
            string STEPLABEL = string.Empty;
            string TASKUSER = string.Empty;
            string TASKID = string.Empty;

            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat(@"SELECT TASKID,a.PROCESSNAME,a.INCIDENT,b.SUMMARY,b.INITIATOR,a.STEPLABEL,a.TASKUSER,a.ASSIGNEDTOUSER,a.STATUS,      a.SUBSTATUS,a.STARTTIME,a.ENDTIME,a.STEPID,a.OVERDUETIME,b.STATUS as PROCESSSTATUS,'' as SERVERNAME  FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 ", processName, incident);
            DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
            if (dtTask.Rows.Count > 0)
            {
                foreach (DataRow item in dtTask.Rows)
                {
                    STEPLABEL = string.Format("{0};", ConvertUtil.ToString(item["STEPLABEL"]).Trim());
                    TASKUSER = string.Format("{0};", ConvertUtil.ToString(item["TASKUSER"]).Trim());
                    TASKID = string.Format("{0};", ConvertUtil.ToString(item["TASKID"]).Trim());
                }
            }

            sSql.Length = 0;
            sSql.AppendFormat(@"SELECT TOP 1 CREATEDATE FROM PROC_CPR_HASTENWORK_LOG WHERE EXT01='{0}' AND EXT02='{1}' AND EXT03='{2}' AND EXT04='{3}' AND EXT05='{4}' AND SYNCSTATUS=1 ORDER BY CREATEDATE DESC", processName, incident, STEPLABEL, TASKUSER, TASKID);
            DataTable dtLog = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            if (dtLog.Rows.Count > 0)
            {
                DateTime createdate = ConvertUtil.ToDateTime(dtLog.Rows[0]["CREATEDATE"]);
                DateTime create_date = createdate.AddHours(4);
                long create_dates = Convert.ToInt64(create_date.ToString("yyyyMMddHHmmss"));
                long datetime = Convert.ToInt64(DateTime.Now.ToString("yyyyMMddHHmmss"));
                if (datetime > create_dates)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return true;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void draftsList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //草稿箱“删除”单击事件
            if (e.CommandName == "del")
            {
                string formID = e.CommandArgument.ToString();
                string sql = "delete from WF_DRAFT where formid = @formid";
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql, formID);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + Lang.Get("SecurityList_DeleteSuccess") + "!');", true);
            }
        }

        public string JudgmentHandler(string formId, string processName, string incident, string action, string documentno, string completedate, string deliverydate)
        {
            bool timeout = JudgmentTimeout(deliverydate);
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

                string t = Guid.NewGuid().ToString();
                url = string.Format("<a target=\"_blank\" href=\"{0}/Solution/PR.PRProcess.{1}/Form/NewRequest.aspx?ProcessName={1}&StepName=Begin&Incident={2}&TaskID={3}&t={6}&UserName={4}&Type=MYTASK\">{5}</a>", path, processName.Trim(), incident.Trim(), taskId.Trim(), userName.Trim(), documentno, t);
                return url;
            }
            //else if (!action.Contains("退回") && !action.Contains("作废") && completedate == "" && timeout)
            else if (TasksApprover(processName, incident))
            {
                string path = getRootPath();
                string loginName = Request.QueryString["loginName"];
                string userName = "CustomOC\\" + loginName;
                string taskId = string.Empty;
                StringBuilder sSql = new StringBuilder();
                sSql.AppendFormat(@"SELECT TASKID FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 and STEPLABEL='Applicant Confirmation'", processName, incident);
                DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
                if (dtTask.Rows.Count > 0)
                {
                    taskId = dtTask.Rows[0][0].ToString();
                }

                url = string.Format("<a target=\"_blank\" href=\"{0}/Solution/PR.PRProcess.{1}/Form/Approval.aspx?ProcessName={1}&StepName=Applicant%20Confirmation&Incident={2}&TaskID={3}&UserName={4}&Type=MYTASK\">{5}</a>", path, processName.Trim(), incident.Trim(), taskId.Trim(), userName.Trim(), documentno);
                return url;
            }
            else
            {
                url = string.Format("<a target=\"_blank\" href=\"javascript: void(0)\" onclick=\"javascript: objReport.openForm('{0}','{1}','{2}');return false;\" style=\"cursor:head\">{3}</a>", formId, processName, incident, documentno);
                return url;
            }

            //url = string.Format("<a target=\"_blank\" href=\"{0}/Solution/PR.PRProcess.{1}/Form/aaa.aspx?ProcessName={1}&StepName=Applicant%20Confirmation&Incident={2}&TaskID={3}&UserName={4}&Type=MYTASK\">{5}</a>", path, processName.Trim(), incident.Trim(), taskId.Trim(), userName.Trim(), documentno);
        }

        public bool JudgmentTimeout(string deliverydate)
        {
            string delivery = Convert.ToDateTime(deliverydate).ToString("yyyyMMddHHss");
            //delivery=202001080404
            long delivery_ = long.Parse(delivery);
            string approve = DateTime.Now.ToString("yyyyMMddHHss");
            long approve_ = long.Parse(approve);
            if (delivery_ < approve_)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

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

        public bool TasksApprover(string processName, string incident)
        {
            bool state = false;
            DataTable dt = new DataTable();
            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat(@"SELECT STEPLABEL FROM TASKS WHERE PROCESSNAME=N'{0}' AND INCIDENT={1} AND RECIPIENT!='WGCNAC-ASMWEB1P_WF' ORDER BY STARTTIME", processName, incident);
            dt = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
            foreach (DataRow item in dt.Rows)
            {
                string steplabel = item["STEPLABEL"].ToString().Trim();
                if (steplabel == "Applicant Confirmation")
                {
                    state = true;
                }
            }
            return state;
        }
    }
}