using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.EmailNotification;
using Ultimus.UWF.Workflow.Logic;

namespace UWF.Process.PO_AMENDMENT
{
    public partial class ReportListAll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pcCode = Request.QueryString["pccode"];
            string empNo = Request.QueryString["empNo"];
            pcCode = string.IsNullOrEmpty(pcCode) ? "" : pcCode.ToUpper();
            if (pcCode == "" || empNo == "")
            {
                string msg = "链接无效";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
            }
            Ultimus.UWF.Form.WebControls.Repeater cprt = Page.FindControl("po_rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            cprt.Source = string.Format(@"BizDB.SELECT 
    AAA.[FORMID], AAA.[PROCESSNAME], AAA.[INCIDENT], AAA.[DOCUMENTNO], 
    AAA.[CREATEBY], AAA.[CREATEBYACCOUNT], AAA.[CREATEBYCODE], 
    AAA.[APPLICANT], AAA.[APPLICANTACCOUNT], AAA.[APPLICANTCODE], 
    AAA.[REQUESTDATE], AAA.[COMPLETEDATE], AAA.[DEPARTMENT], AAA.[DEPARTMENTID], 
    AAA.[PROCESSSUMMARY], AAA.[STATUS], AAA.[PurchasingPurpose], 
    AAA.[SITECODE], AAA.[SITENAME], AAA.[DELIVERYDATE], AAA.[Requirement], 
    AAA.[APPROVEDATE], AAA.[DELIVERY], AAA.[APPROVE], AAA.[APPLICANTTEL], 
    AAA.[COMPANY], AAA.[COSTCENTER], AAA.[APPREMARK], AAA.[AMOUNT],
    WF.[ACTION]
FROM PROC_PO_AMENDMENT AS AAA
-- 依然保留 CROSS APPLY 高效获取每个表单的最新审批记录
CROSS APPLY (
    SELECT TOP (1) ACTION
    FROM WF_APPROVALHISTORY
    WHERE FORMID = AAA.FORMID
    ORDER BY ID DESC
) AS WF
WHERE AAA.SITECODE = '{0}' 
  AND AAA.APPLICANTCODE = '{1}' 
  AND AAA.INCIDENT <> -1", pcCode, empNo);
            cprt.Sort = "REQUESTDATE DESC";
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
            dt = ExportLogic.GetSchemaTable("PO_AMENDMENT", dt);
            ExcelUtil.Export(dt);
        }

        protected void PO_lbHastenWork_Click(object sender, EventArgs e)
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
                if (action.Contains("拒绝")|| action.Contains("退回"))
                {
                    string msg = "调整单【" + documentno + "】状态为已拒绝或者已退回，无法催办" + "\\n" + "The status of PO Amendment[" + documentno + "] is returned,cannot be urged";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                }
                else
                {
                    if (Convert.ToDateTime(completedate) == Convert.ToDateTime("1900-01-01 00:00:00.000"))
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
                                string msg = string.Format("调整单【{0}】邮件发送成功，不要重复点击" + "\\n" + "The status of PO   Amendment  [{0}] email sent successfully,do not repeat the click", documentno);
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('111');", true);
                                UnloadJavascript();
                            }
                            catch (Exception ex)
                            {
                                UnloadJavascript();
                                errorMsg = ex.Message;
                                res = 0;
                                //催办记录
                                hwLog(res, processname, incident, errorMsg, stepLabel, taskUser, ti);
                                string msg = string.Format("调整单【{0}】邮件发送失败（{1}），请联系管理员" + "\\n" + "The status of PO Amendment[{0}] email sent failed({1}),please contact the administrator", documentno, ex.Message);
                                throw new Exception(msg);
                            }
                            hwLog(res, processname, incident, errorMsg, stepLabel, taskUser, ti);

                        }
                    }
                    else
                    {
                        string msg = "调整单【" + documentno + "】状态为已完成，无法催办" + "\\n" + "The status of PO Amendment[" + documentno + "] is completed,cannot be urged";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                        UnloadJavascript();
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

        public static bool checkRemindersInterval(string processName, string incident)
        {
            return true;
            //string STEPLABEL = string.Empty;
            //string TASKUSER = string.Empty;
            //string TASKID = string.Empty;

            //StringBuilder sSql = new StringBuilder();
            //sSql.AppendFormat(@"SELECT TASKID,a.PROCESSNAME,a.INCIDENT,b.SUMMARY,b.INITIATOR,a.STEPLABEL,a.TASKUSER,a.ASSIGNEDTOUSER,a.STATUS,      a.SUBSTATUS,a.STARTTIME,a.ENDTIME,a.STEPID,a.OVERDUETIME,b.STATUS as PROCESSSTATUS,'' as SERVERNAME  FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 ", processName, incident);
            //DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
            //if (dtTask.Rows.Count > 0)
            //{
            //    foreach (DataRow item in dtTask.Rows)
            //    {
            //        STEPLABEL = string.Format("{0};", ConvertUtil.ToString(item["STEPLABEL"]).Trim());
            //        TASKUSER = string.Format("{0};", ConvertUtil.ToString(item["TASKUSER"]).Trim());
            //        TASKID = string.Format("{0};", ConvertUtil.ToString(item["TASKID"]).Trim());
            //    }
            //}

            //sSql.Length = 0;
            //sSql.AppendFormat(@"SELECT TOP 1 CREATEDATE FROM PROC_CPR_HASTENWORK_LOG  WHERE EXT01='{0}' AND EXT02='{1}' AND EXT03='{2}' AND EXT04='{3}' AND EXT05='{4}' AND SYNCSTATUS=1 ORDER BY CREATEDATE DESC", processName, incident, STEPLABEL, TASKUSER, TASKID);
            //DataTable dtLog = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //if (dtLog.Rows.Count > 0)
            //{
            //    DateTime createdate = ConvertUtil.ToDateTime(dtLog.Rows[0]["CREATEDATE"]);
            //    DateTime create_date = createdate.AddHours(4);
            //    long create_dates = Convert.ToInt64(create_date.ToString("yyyyMMddHHmmss"));
            //    long datetime = Convert.ToInt64(DateTime.Now.ToString("yyyyMMddHHmmss"));
            //    if (datetime > create_dates)
            //    {
            //        return true;
            //    }
            //    else
            //    {
            //        return false;
            //    }
            //}
            //else
            //{
            //    return true;
            //}
        }
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
    }
}