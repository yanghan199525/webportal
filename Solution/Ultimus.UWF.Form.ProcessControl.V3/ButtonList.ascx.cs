using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using MyLib;
using System.Text;
using System.Collections;
using System.ComponentModel;
using System.Data.Common;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Entity;
using System.Diagnostics;
using System.IO;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.EmailNotification;
using DES_PSO.Web.Matlab;
using System.Net;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class ButtonList : System.Web.UI.UserControl
    {
        public event CancelEventHandler BeforeSubmit;
        public event CancelEventHandler BeforeSaveDraft;
        public event CancelEventHandler AfterSubmit;
        public event EventHandler LoadPrintForm;
        protected CirculationUserInfo Circulation;
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
        DataTable statusDT;
        string readStatus = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            userInfo.AfterLoadData += userInfo_AfterLoadData;
            if (!IsPostBack)
            {
                string statusSQL = "select status from incidents where incident = '" + Request.QueryString["INCIDENT"].ToString().Trim() + "'and processname='" + Request.QueryString["PROCESSNAME"].ToString().Trim() + "'";
                statusDT = DataAccess.Instance("UltDB").ExecuteDataTable(statusSQL);
                if (statusDT != null && statusDT.Rows.Count > 0 && statusDT.Rows[0][0].ToString().Trim() == "2")
                {
                    readStatus = "2";
                }
                string type = ConvertUtil.ToString(Request.QueryString["Type"]);
                type = type.ToUpper().Trim();
                btnSend.Visible = false;

               
                StepSetting ss = stepSettings.GetStep(userInfo.ProcessName, userInfo.StepName);
                CheckDisplayButton(ss, statusDT);
                CheckDisplayButton(ss, type, statusDT);
                string processStepName = "";
                int iStatus = 1;
                string taskid = userInfo.TaskID;
                string processname = userInfo.ProcessName;
                GetShow(processname, int.Parse(Request.QueryString["INCIDENT"].ToString().Trim()));
                if (string.IsNullOrEmpty(taskid)) //没有任务编号，提交不可见
                {
                    btnSend.Visible = false;
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                    btnReject.Visible = false;
                    btnSelectReturn.Visible = false;
                  
                }
                else
                {
                    if (processname.ToUpper().StartsWith("C") || processname.ToUpper().StartsWith("HK"))
                    {
                        if (!taskid.StartsWith("S")) //已完成任务，提交不可见
                        {
                            TaskEntity task = _workflow.GetTaskEntity(Request.QueryString["ServerName"], taskid);
                            if (task != null)
                            {
                                processStepName = ConvertUtil.ToString(task.STEPLABEL).Trim();
                                iStatus = task.STATUS;
                                if (iStatus != 1)
                                {
                                 
                                    btnSend.Visible = false;
                                    btnApprove.Visible = false;
                                    btnReturn.Visible = false;
                                    btnReject.Visible = false;
                                    btnSelectReturn.Visible = false;
                                    btnAddSign.Visible = false;
                                    btnSendRead.Visible = false;
                                    MultiAttachments atts = Page.FindControl("Attachments1") as MultiAttachments;
                                    if (atts != null)
                                    {
                                        atts.ReadOnly = true;
                                    }
                                }
                                else
                                {
                                    if (task.ASSIGNEDTOUSER.Trim().ToUpper() != SessionLogic.GetUltimusLoginName().ToUpper()) //不是AssignedToUser隐藏
                                    {
                                      
                                        btnSend.Visible = false;
                                        btnApprove.Visible = false;
                                        btnReturn.Visible = false;
                                        btnReject.Visible = false;
                                        btnSelectReturn.Visible = false;
                                    }
                                }
                                //申请人加签控制
                                if (ss.StepType == "2" && iStatus != 1 && processStepName == userInfo.StepName)
                                {
                                    btnAddSign.Visible = true;
                                }
                                else if (ss.StepType == "2" && iStatus == 1 && processStepName == userInfo.StepName)
                                {
                                    btnAddSign.Visible = false;
                                }
                            }
                            else
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提示信息：" + Lang.Get("OpenForm_CannotLoadTask") + "');", true);
                                //throw new Exception(Lang.Get("OpenForm_CannotLoadTask"));
                            }
                        }
                    }

                    if (Request.QueryString["processStatus"] != "1" && type == "MYREQUEST") //已完成的流程，不能撤回及作废
                    {
                        btnCallback.Visible = false;
                        btnReminders.Visible = false;
                        btnAbortIncident.Visible = false;
                        btnAddSign.Visible = false;
                       
                    }
                    int processStatus = 0;
                    if (statusDT.Rows.Count > 0)
                    {
                        processStatus = ConvertUtil.ToInt32(statusDT.Rows[0][0]);
                        if (processStatus != 1)
                        {
                            btnCallback.Visible = false;
                            btnReminders.Visible = false;
                            btnAbortIncident.Visible = false;
                            btnAddSign.Visible = false;
                           
                        }
                    }


                }
                bool isCreateForm = userInfo.IsCreateForm;
                if (ConfigurationManager.AppSettings["ShowNextApprover"] == "1" && !isCreateForm)
                {
                    btnApprover.Visible = true;
                }

                //多语言
                btnSend.Text = Lang.Get("Form_Submit");//"<i class='fa fa-check'></i>" +
                btnPrint.Text = Lang.Get("Form_Print");
                btnApprove.Text = Lang.Get("Approve");
                btnAddSign.Value = Lang.Get("History_AddSign");
                btnChuanYue.Value = Lang.Get("Btn_Circulated");
                btnReturn.Text = Lang.Get("Return");
                btnSelectReturn.Text = Lang.Get("ButtonList_SelectReturn");
                btnReject.Text = Lang.Get("Reject");
                btnAbortIncident.Text = Lang.Get("TaskList_Abort");
                btnCallback.Text = Lang.Get("TaskList_Callback");
                btnClose.Text = Lang.Get("TaskStatus_Close");
                btnSaveDraft.Text = Lang.Get("Form_SaveDraft");
                btnXieban.Value = Lang.Get("ButtonList_Xieban");
                btnCopy.Value = Lang.Get("ButtonList_Copy");
                btnGoto.Value = Lang.Get("ButtonList_Goto");
                hyFlow.Text = Lang.Get("TaskStatus_FlowChart");
                btnApprove.Text = Lang.Get("Approve");
                btnAddSign.Value = Lang.Get("History_AddSign");
                butSIGN.Text = Lang.Get("SIGN");
                btTransfer.Text = Lang.Get("Transfer");
                hyFlow.NavigateUrl = "~/Portal/Ultimus.UWF.Home.V3/TaskStatus.aspx?ProcessName=" + Server.UrlEncode(Request.QueryString["ProcessName"]) + "&Incident=" + Request.QueryString["INCIDENT"] + "&TaskId=" + Request.QueryString["TaskId"] + "&ServerName=" + Request.QueryString["ServerName"];

                if (type.ToUpper().Trim() == "DRAFT")
                {
                    if (ss.ISPRINT == "0" || string.IsNullOrEmpty(ss.ISPRINT))
                    {
                        btnPrint.Visible = false;
                    }
                    else
                    {
                        btnPrint.Visible = true;
                    }
                    btnPrint.Text = "打印预览";
                }
                butSIGN.Visible = false;
                if (ApprovalHistory.ISSIGN(1, userInfo.ProcessName, userInfo.StepName))
                {
                    butSIGN.Visible = true;
                    showSign.Text ="1";
                }
                btTransfer.Visible = false;
                if (ApprovalHistory.ISSIGN(2, userInfo.ProcessName, userInfo.StepName))
                {
                    btTransfer.Visible = true;
                    showSign.Text = "1";
                }
            }
        }



        void userInfo_AfterLoadData(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            //是否显示打印按钮
            if (btnPrint.Visible)
            {
                string dir = Server.MapPath("../Print");
                if (!Directory.Exists(dir))
                {
                    dir = Server.MapPath("Print");
                }
                string path = "";
                for (int i = 0; i < Request.Url.Segments.Length - 1; i++)
                {
                    path += Request.Url.Segments[i];
                }
                path = "formid=" + userInfo.FormID + "&settings=" + dir + "\\Settings.xml" + "&dir=" + dir + "&processname=" + Server.UrlEncode(userInfo.ProcessName) + "&incident=" + userInfo.Incident + "&StepName=" + Server.UrlEncode(userInfo.StepName) + "&url=" + path;

                btnPrint.NavigateUrl = "../Ultimus.UWF.Form.ProcessControl.V3/PrintForm.aspx?" + path;

                if (LoadPrintForm != null)
                {
                    LoadPrintForm(sender, e);
                }
            }
        }

        void CheckDisplayButton(StepSetting ss, DataTable statusDT)
        {
            //string statusSQL = "select status from incidents where incident = '" + Request.QueryString["INCIDENT"].ToString().Trim() + "'and processname='" + Request.QueryString["PROCESSNAME"].ToString().Trim() + "'";
            //DataTable statusDT = DataAccess.Instance("UltDB").ExecuteDataTable(statusSQL);
            if (statusDT != null && statusDT.Rows.Count > 0 && statusDT.Rows[0][0].ToString().Trim() == "2")
            {
                readStatus = "2";
            }
            // 提交
            if (ss.ISSUBMIT == "0" || string.IsNullOrEmpty(ss.ISSUBMIT))
            {
                btnSend.Visible = false;
            }
            else
            {
                btnSend.Visible = true;

                //自定义调整单明细提交按钮
                string processname = Request.QueryString["PROCESSNAME"].ToString().Trim();
              
            }
            //btnSaveDraft.Visible = false;
            if (ss.ISAPPROVE == "0" || string.IsNullOrEmpty(ss.ISSUBMIT))
            {
                btnApprove.Visible = false;
            }
            else
            {
                btnApprove.Visible = true;
            }
            if (ss.ISRETURN == "0" || string.IsNullOrEmpty(ss.ISRETURN))
            {
                btnReturn.Visible = false;
            }
            else
            {
                btnReturn.Visible = true;
            }
            if (ss.ISSELECTRETURN == "0" || string.IsNullOrEmpty(ss.ISSELECTRETURN))
            {
                btnSelectReturn.Visible = false;
            }
            else
            {
                btnSelectReturn.Visible = true;
            }

            if (ss.ISREJECT == "0" || string.IsNullOrEmpty(ss.ISREJECT))
            {
                btnReject.Visible = false;
            }
            else
            {
                btnReject.Visible = true;
            }


            if (ss.ISABORT == "0" || string.IsNullOrEmpty(ss.ISABORT))
            {
                btnAbortIncident.Visible = false;
            }
            else
            {
                btnAbortIncident.Visible = true;
            }

            if (ss.ISPRINT == "0" || string.IsNullOrEmpty(ss.ISPRINT))
            {
                btnPrint.Visible = false;
            }
            else
            {
                btnPrint.Visible = true;
            }

            if (ss.ISADDSIGN == "0" || string.IsNullOrEmpty(ss.ISADDSIGN))
            {
                btnAddSign.Visible = false;
                btnSendRead.Visible = false;
            }
            else
            {
                btnAddSign.Visible = true;
            }
        }

        void CheckDisplayButton(StepSetting ss, string type, DataTable statusDT)
        {
            //string statusSQL = "select status from incidents where incident = '" + Request.QueryString["INCIDENT"].ToString().Trim() + "'and processname='" + Request.QueryString["PROCESSNAME"].ToString().Trim() + "'";
            //DataTable statusDT = DataAccess.Instance("UltDB").ExecuteDataTable(statusSQL);
            if (statusDT != null && statusDT.Rows.Count > 0 && statusDT.Rows[0][0].ToString().Trim() == "2")
            {
                readStatus = "2";
            }
            bool IsStart = ss.StepType == "2";
            bool isStartByReturn = IsStart && type.ToUpper().Trim() == "MYTASK" && ConvertUtil.ToInt32(Request.QueryString["incident"]) > 0;
            //是否显示传阅按钮
            if (ss.ISREAD == "0" || string.IsNullOrEmpty(ss.ISREAD))
            {
                btnChuanYue.Visible = false;
            }
            switch (type.ToUpper().Trim())
            {
                case "NEWREQUEST":
                case "DRAFT":
                    btnSend.Visible = true;
                    // 保存草稿
                    if (ss.ISSAVEDRAFT == "0")
                    {
                        btnSaveDraft.Visible = false;
                    }
                    else
                    {
                        btnSaveDraft.Visible = true;
                    }
                    btnChuanYue.Visible = false;
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                    btnSelectReturn.Visible = false;
                    btnReject.Visible = false;
                    btnPrint.Visible = false;
                    btnAbortIncident.Visible = false;
                    btnXieban.Visible = false;
                    btnCopy.Visible = false;
                    btnAddSign.Visible = false;
                    break;
                case "MYTASK":
                    btnApprove.Visible = true;
                    btnSend.Visible = false;

                    if (isStartByReturn)
                    {
                        //自定义调整单明细提交按钮
                        string processname = Request.QueryString["PROCESSNAME"].ToString().Trim();
                    

                        btnSend.Visible = true;
                        btnApprove.Visible = false;
                        btnReturn.Visible = false;
                        btnSelectReturn.Visible = false;
                        btnReject.Visible = false;
                    }
                    break;
                case "MYREQUEST":

                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                    btnSelectReturn.Visible = false;
                    btnReject.Visible = false;
                    btnXieban.Visible = false;
                    btnCopy.Visible = false;

                    if (ss.ISWITHDRAW == "0" || string.IsNullOrEmpty(ss.ISWITHDRAW))
                    {
                        btnCallback.Visible = false;
                        btnReminders.Visible = false;
                    }
                    else
                    {
                        btnCallback.Visible = true;
                        btnReminders.Visible = true;
                    }

                    if (ss.ISADDSIGN == "0" || string.IsNullOrEmpty(ss.ISADDSIGN))
                    {
                        btnAddSign.Visible = false;
                    }
                    else
                    {
                        btnAddSign.Visible = true;
                    }

                    if (ss.Ext05 == "0" || string.IsNullOrEmpty(ss.Ext05))
                    {
                        btnProcessCopy.Visible = false;
                    }
                    else
                    {
                        btnProcessCopy.Visible = true;
                    }
                    break;
                case "MYAPPROVAL":
                    btnSend.Visible = false;
                    btnSaveDraft.Visible = false;
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                    btnSelectReturn.Visible = false;
                    btnReject.Visible = false;
                    btnAbortIncident.Visible = false;
                    btnXieban.Visible = false;
                    btnCopy.Visible = false;
                    break;
                case "ADDSIGN":
                    this.Visible = false;
                    break;
                case "MYUNREAD":
                    btnChuanYue.Visible = false;
                    break;
                case "MYREAD":
                    btnChuanYue.Visible = false;
                    break;
            }

            if (Request.QueryString["XieBan"] == "1")
            {
                btnXieban.Visible = false;
                btnCopy.Visible = false;
            }
            if (Request.QueryString["Copy"] == "1")
            {
                btnXieban.Visible = false;
                btnCopy.Visible = false;
                btnSaveDraft.Visible = false;
                btnSend.Visible = false;
                btnApprove.Visible = false;
                btnReturn.Visible = false;
                btnReject.Visible = false;
                btnSelectReturn.Visible = false;
            }

            if (type.ToUpper().Trim() == "REPORT")
            {
                btnXieban.Visible = false;
                btnCopy.Visible = false;
                btnSaveDraft.Visible = false;
                btnSend.Visible = false;
                btnApprove.Visible = false;
                btnReturn.Visible = false;
                btnSelectReturn.Visible = false;
                btnReject.Visible = false;
                btnAbortIncident.Visible = true;
                btnAddSign.Visible = false;
                btnSendRead.Visible = false;
            }
            
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {

                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                bool flag = false;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                string prefix = userInfo.ProcessPrefix;
                string processName = userInfo.ProcessName;
                string stepName = userInfo.StepName;
                string formID = userInfo.FormID;

                //Stopwatch watch = new Stopwatch();
                //watch.Start();
                DataSet formData = new DataSet();
                //watch.Stop();
                //long lng= watch.ElapsedMilliseconds;
                //LogUtil.Info("watch:" + lng);
                string tableName = userInfo.TableName;
                bool isCreateForm = userInfo.IsCreateForm;
                string taskID = userInfo.TaskID;
                string applicant = userInfo.Applicant;
                int actionType = approvalHistory.ActionType;
                string returnStep = approvalHistory.ReturnStep;

                string error = "";
                Hashtable vars = new Hashtable();

                //1.获取当前登录用户
                string loginname = GetLoginName(userInfo);
                if (string.IsNullOrEmpty(loginname))
                {
                    return;
                }
                //2.开始执行之前的自定义事件
                if (BeforeSubmit != null)
                {
                    CancelEventArgs cea = new CancelEventArgs();
                    BeforeSubmit(vars, cea);
                    if (cea.Cancel)
                    {
                        return;
                    }
                }
                //string summary = userInfo.Summary + (userInfo.FindControl("read_DEPARTMENT") as Label).Text;// +"-" + userInfo.Applicant;
                //string summary = (userInfo.FindControl("read_DEPARTMENT") as Label).Text + "-" + userInfo.Summary;
                string summary = userInfo.Summary;
                string comments = approvalHistory.Comments;
                vars = _workflow.GetFormVars(userInfo, ref vars);//获取变量
                vars.Add("STEPNAME", stepName);
                formData = _workflow.GetFormData(userInfo, formID);//获取表单数据
                flag = _workflow.SubmitForm(formData, vars, loginname, applicant, taskID, processName,
                    incident, stepName, tableName, formID, prefix, isCreateForm, type,
                    summary, actionType, returnStep, comments, ref error, userInfo.DOCUMENTNO, true);

                if (!flag || !string.IsNullOrEmpty(error))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败：" + error.Replace("'", "").Replace("\"", "") + "');", true);
                    return;
                }
                if (actionType == 1 & processName.ToUpper() == "PO_AMENDMENT") {
                    ReturnResultPO(processName, incident);
                }
                if (actionType == 2 && processName.Contains("OR")) {
                    GetDocumentNo(processName,incident,tableName);
                }
                //自动发起待阅
                if (userInfo.Type.ToUpper() != "NEWREQUEST" && userInfo.Type.ToUpper() != "DRAFT")
                {
                    string readsql = string.Format("update WF_READS set Status='1' where PROCESSNAME=N'{0}' and INCIDENT='{1}' and APPLICANT='{2}'"
                        , userInfo.ProcessName, userInfo.Incident, SessionLogic.GetLoginName());
                    DataAccess.Instance("BizDB").ExecuteNonQuery(readsql);
                }
                //自动发起待阅
                //if (processName == "恒大集团资金拨借单流程" && stepName == "sdf")
                //{
                //    string procSql = "SELECT QSTARTTIME, STEPID, STATUS, STEPLABEL, STARTTIME FROM TASKS WHERE TASKID = '" + taskID + "'";
                //    DataTable procDT = DataAccess.Instance("UltDB").ExecuteDataTable(procSql);
                //    string createDate = procDT.Rows[0][0].ToString().Trim();
                //    string stepid = procDT.Rows[0][1].ToString().Trim();
                //    string status = procDT.Rows[0][2].ToString().Trim();
                //    string stepLabel = procDT.Rows[0][3].ToString().Trim();
                //    string startTime = procDT.Rows[0][4].ToString().Trim();

                //    string groupSql = "SELECT DISTINCT a.LOGINNAME FROM ORG_USER a LEFT JOIN ORG_GROUPMEMBER b on a.USERID = b.memberid  WHERE b.GROUPID = (SELECT groupid FROM org_group WHERE groupname = '待阅组')";
                //    DataTable loginnameTable = DataAccess.Instance("BizDB").ExecuteDataTable(groupSql);
                //    if (loginnameTable.Rows.Count > 0 && string.IsNullOrEmpty(loginnameTable.Rows[0][0].ToString().Trim()))
                //    {
                //        for (int i = 0; i < loginnameTable.Rows.Count; i++)
                //        {
                //            string sql0 = "SELECT max(ID) FROM WF_READS";
                //            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql0);
                //            int ID = Convert.ToInt32(dt.Rows[0][0].ToString().Trim()) + 1;

                //            string loginName = loginnameTable.Rows[i][0].ToString().Trim();
                //            string department = loginnameTable.Rows[i][1].ToString().Trim();
                //            string sql1 = "INSERT INTO WF_READS (ID, TASKID, READFLAG, READER, PROCESSNAME, INCIDENT, CREATEDATE, DEPARTMENT, APPLICANT, READERTYPE, STEPID, STATUS, STEPLABEL, STARTTIME) VALUES('" + ID + "', '" + taskID + "', '0', 'CustomOC/" + loginName + "', '恒大集团资金拨借单流程', '" + incident + "', to_date('" + createDate + "', 'yyyy/mm/dd hh24:mi:ss'), '" + department + "', '" + applicant + "', '0', '" + stepid + "', '" + status + "', '" + stepLabel + "', to_date('" + startTime + "', 'yyyy/mm/dd hh24:mi:ss'))";
                //            DataAccess.Instance("BizDB").ExecuteNonQuery(sql1);
                //        }
                //    }
                //}

                //6.执行成功之后的自定义事件
                if (AfterSubmit != null)
                {
                    CancelEventArgs ce = new CancelEventArgs();
                    AfterSubmit(sender, ce);
                    if (ce.Cancel)
                    {
                        return;
                    }
                }
                if (processName.Contains("OR")) {
                    btnReject.Visible = false;
                    btnApprove.Visible = false;
                  
                }
                if (processName.Contains("CPR")) {
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
               
                }
                if (processName.Contains("PR"))
                {
                    btnReject.Visible = false;
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                }
                if (processName.Contains("CAPEX"))
                {
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;

                }
                if (processName.Contains("SUMMARY")|| processName.Contains("NETPRICE") )
                {
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;

                }

            }
            catch (Exception ex) //意外终止
            {
                LogUtil.Error("提交失败!", ex);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败!错误信息：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
                return;
            }
           
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "submitSuccess();", true);
            
        }

      
        public void ReturnResultPO(string strProcessName, int nIncident)
        {
            try
            {
                string baseUrl = ConfigurationManager.AppSettings["WEB_API_URL"].Trim();
                string result;
                result = HttpUtil.HttpGet(string.Format("{0}/api/po/POPushApprovalResult?processName={1}&incident={2}&approvalResult={3}", baseUrl, strProcessName, nIncident, 2), "application/json;charset=UTF-8");
                LogUtil.Error("测试退回SodexoCPRLogicSubscription：" + result + "DOCUMENTNO:" + strProcessName + "INCIDENT:" + nIncident);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        protected void btnAbort_Click(object sender, EventArgs e)
        {
            string abort_processname = string.Empty;
            string abort_formID = string.Empty;
            try
            {

                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                string dpcumentNo = userInfo.DOCUMENTNO;
                //string incident = userInfo.Incident;
                string processname = userInfo.ProcessName;
                ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                bool flag = false;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                string prefix = userInfo.ProcessPrefix;
                string processName = userInfo.ProcessName;
                string stepName = userInfo.StepName;
                string formID = userInfo.FormID;
             
                abort_processname = processName;
                abort_formID = formID;
                //Stopwatch watch = new Stopwatch();
                //watch.Start();
                DataSet formData = new DataSet();
                //watch.Stop();
                //long lng= watch.ElapsedMilliseconds;
                //LogUtil.Info("watch:" + lng);
                string tableName = userInfo.TableName;
                bool isCreateForm = userInfo.IsCreateForm;
                string taskID = userInfo.TaskID;
                string applicant = userInfo.Applicant;
                int actionType = 5; //终止
                string returnStep = approvalHistory.ReturnStep;

                string error = "";
                Hashtable vars = new Hashtable();

                //1.获取当前登录用户
                string loginname = GetLoginName(userInfo);
                if (string.IsNullOrEmpty(loginname))
                {
                    return;
                }
                //2.开始执行之前的自定义事件
                if (BeforeSubmit != null)
                {
                    CancelEventArgs cea = new CancelEventArgs();
                    BeforeSubmit(vars, cea);
                    if (cea.Cancel)
                    {
                        return;
                    }
                }
                string summary = userInfo.Summary;
                string comments = approvalHistory.Comments;
                vars = _workflow.GetFormVars(userInfo, ref vars);//获取变量

                formData = _workflow.GetFormData(userInfo, userInfo.FormID);//获取表单数据
                flag = _workflow.SubmitForm(formData, vars, loginname, applicant, taskID, processName,
                    incident, stepName, tableName, formID, prefix, isCreateForm, type,
                    summary, actionType, returnStep, comments, ref error, userInfo.DOCUMENTNO, true);
                if (!flag || !string.IsNullOrEmpty(error))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Failure：" + error.Replace("'", "").Replace("\"", "") + "');", true);
                    return;
                }
                if (processName.Contains("OR"))
                {
                    GetDocumentNo(processName, incident, tableName);
                }
                //6.执行成功之后的自定义事件
                if (AfterSubmit != null)
                {
                    CancelEventArgs ce = new CancelEventArgs();
                    AfterSubmit(sender, ce);
                    if (ce.Cancel)
                    {
                        return;
                    }
                }
            }
            catch (Exception ex) //意外终止
            {
                LogUtil.Error("提交失败!", ex);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Failure!Message：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
                return;
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "submitSuccess();", true);
            try
            {
                if (abort_processname == "CPR_FOOD" || abort_processname == "CPR_NONFOOD" || abort_processname == "CPR_SERVICE")
                {
                    #region 作废之后更改一次性物料使用次数
                    StringBuilder sSql = new StringBuilder();
                    string SiteCode = string.Empty;
                    string SupplierCode = string.Empty;
                    string ArticleCode = string.Empty;
                    string ArticleName = string.Empty;
                    string ArticleFamily = string.Empty;
                    string SupplierType = string.Empty;
                    sSql.AppendFormat(@"SELECT * FROM PROC_{0} WHERE FORMID='{1}';", abort_processname, abort_formID);
                    if (abort_processname == "CPR_FOOD")
                    {
                        abort_processname = "CPRFOOD";
                    }
                    sSql.AppendFormat(@"SELECT * FROM PROC_{0}_ITEMS WHERE FORMID='{1}';", abort_processname, abort_formID);
                    DataSet cpr = DataAccess.Instance("BizDB").ExecuteDataSet(sSql.ToString());
                    DataTable cpr_ = cpr.Tables[0];
                    DataTable cpr_items = cpr.Tables[1];
                    if (cpr_.Rows.Count > 0)
                    {
                        SiteCode = cpr_.Rows[0]["SITECODE"].ToString();
                        SupplierCode = cpr_.Rows[0]["SUPPLIERCODE"].ToString();
                        SupplierType = cpr_.Rows[0]["SUPPLIERTYPE"].ToString();

                        if (SupplierType == "9")
                        {
                            if (cpr_items.Rows.Count > 0)
                            {
                                foreach (DataRow item in cpr_items.Rows)
                                {
                                    ArticleName = item["ARTICLENAME"].ToString();
                                    ArticleCode = item["ARTICLECODE"].ToString();
                                    ArticleFamily = item["SUBSUBFAMILYCODE"].ToString();

                                    sSql.Length = 0;
                                    sSql.AppendFormat("SELECT * FROM [dbo].[SODEXO_Article] where [SiteCode]='{0}' AND [ArticleFamily]='{1}' AND SupplierCode='{2}' AND ArticleName=N'{3}' AND ArticleCode='{4}'", SiteCode, ArticleFamily, SupplierCode, ArticleName, ArticleCode);
                                    DataTable ar = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                                    if (ar.Rows.Count > 0)
                                    {
                                        string IsOneTimeUsing = ar.Rows[0]["IsOneTimeUsing"].ToString();
                                        string UseTimes = ar.Rows[0]["UseTimes"].ToString();
                                        if (IsOneTimeUsing == "1")
                                        {
                                            string ID = ar.Rows[0]["ID"].ToString();
                                            sSql.Length = 0;
                                            sSql.AppendFormat(@"UPDATE SODEXO_Article SET UseTimes=0 WHERE ID='{0}'", ID);
                                            int res = DataAccess.Instance("BizDB").ExecuteNonQuery(sSql.ToString());
                                        }
                                    }
                                    else
                                    {
                                        sSql.Length = 0;
                                        sSql.AppendFormat(@"SELECT ParentPCCode FROM SODEXO_MasterProfitCenter WHERE PCCode='{0}'", SiteCode);
                                        DataTable ParentPCCode_table = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                                        if (ParentPCCode_table.Rows.Count > 0)
                                        {
                                            string parentCode = ParentPCCode_table.Rows[0]["ParentPCCode"].ToString();
                                            if (parentCode != "")
                                            {
                                                sSql.Length = 0;
                                                sSql.AppendFormat("SELECT * FROM [dbo].[SODEXO_Article] where [SiteCode]='{0}' AND [ArticleFamily]='{1}' AND SupplierCode='{2}' AND ArticleName=N'{3}' AND ArticleCode='{4}'", parentCode, ArticleFamily, SupplierCode, ArticleName, ArticleCode);
                                                DataTable ar_ = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                                                if (ar_.Rows.Count > 0)
                                                {
                                                    string IsOneTimeUsing = ar_.Rows[0]["IsOneTimeUsing"].ToString();
                                                    string UseTimes = ar_.Rows[0]["UseTimes"].ToString();
                                                    if (IsOneTimeUsing == "1")
                                                    {
                                                        string ID = ar_.Rows[0]["ID"].ToString();
                                                        sSql.Length = 0;
                                                        sSql.AppendFormat(@"UPDATE SODEXO_Article SET UseTimes=0 WHERE ID='{0}'", ID);
                                                        int res = DataAccess.Instance("BizDB").ExecuteNonQuery(sSql.ToString());
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    #endregion
                }
            }
            catch (Exception ex)
            {
                throw new Exception("一次性物品使用次数更新失败，请联系管理员（" + ex.Message + "）");
            }
        }

        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            try
            {
                ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                bool flag = false;
                string formID = userInfo.FormID;
                DataSet formData = new DataSet();
                string tableName = userInfo.TableName;
                string tableNameDetail = userInfo.TableNameDetail;
                string prefix = userInfo.ProcessPrefix;
                string summary = userInfo.Summary;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                string processName = userInfo.ProcessName;
                string stepName = userInfo.StepName;
                string taskID = userInfo.TaskID;

                string error = "";
                //1.获取当前登录用户
                string loginname = GetLoginName(userInfo);
                if (string.IsNullOrEmpty(loginname))
                {
                    return;
                }


                //2.保存业务库
                formData = _workflow.GetFormData(userInfo, userInfo.FormID);//获取表单数据

                if (BeforeSaveDraft != null)
                {
                    CancelEventArgs cea = new CancelEventArgs();
                    BeforeSaveDraft(sender, cea);
                    if (cea.Cancel)
                    {
                        return;
                    }
                }

                flag = _workflow.SaveDraft(formData, loginname, taskID, processName,
                    stepName, tableName, tableNameDetail, formID, prefix, type, summary, ref error);
                if (!flag || !string.IsNullOrEmpty(error))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败：" + error.Replace("'", "") + "');", true);
                    return;
                }
            }
            catch (Exception ex) //意外终止
            {
                LogUtil.Error(ex);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('保存失败!错误信息：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
                return;
            }
            userInfo.Type = "DRAFT";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "saveSuccess();", true);
        }


        void SaveDraft()
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                bool flag = false;
                string formID = userInfo.FormID;
                DataSet formData = new DataSet();
                string tableName = userInfo.TableName;
                string tableNameDetail = userInfo.TableNameDetail;
                string prefix = userInfo.ProcessPrefix;
                string summary = userInfo.Summary;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                string processName = userInfo.ProcessName;
                string stepName = userInfo.StepName;
                string taskID = userInfo.TaskID;

                string error = "";
                //1.获取当前登录用户
                string loginname = GetLoginName(userInfo);
                if (string.IsNullOrEmpty(loginname))
                {
                    return;
                }


                //2.保存业务库
                formData = _workflow.GetFormData(userInfo, userInfo.FormID);//获取表单数据


                flag = _workflow.SaveDraft(formData, loginname, taskID, processName,
                    stepName, tableName, tableNameDetail, formID, prefix, type, summary, ref error);
                if (!flag || !string.IsNullOrEmpty(error))
                {
                    return;
                }
            }
            catch (Exception ex) //意外终止
            {
                LogUtil.Error(ex);
                return;
            }
        }

        protected void lbnSelectReturn_Click(object sender, EventArgs e)
        {
            btnSubmit_Click(sender, e);
        }

        string GetLoginName(UserInfo userInfo)
        {
            string strApplicantAccout = null;
            if (string.IsNullOrEmpty(SessionLogic.GetLoginName())) //没有登录或者用户取不到 
            {
                LogUtil.Error("B001提交失败！未找到用户信息 IdentityName:" + SessionLogic.GetLoginName() + " SessionUserName:" + ConvertUtil.ToString(HttpContext.Current.Session["loginName"]));
                strApplicantAccout = ((TextBox)userInfo.FindControl("txtApplicantAccount")).Text.Replace("/", "\\");
                if (strApplicantAccout.Trim() == "")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败！未找到用户信息！');", true);
                    return "";
                }
            }
            else
            {
                strApplicantAccout = SessionLogic.GetLoginName();
            }
            LogUtil.Info("B002提交！IdentityName:" + strApplicantAccout + " SessionUserName:" + ConvertUtil.ToString(HttpContext.Current.Session["loginName"]));
            return strApplicantAccout;
        }

        protected void btnCallback_Click(object sender, EventArgs e)
        {
            IWorkflow pfl = ServiceContainer.Instance().GetService<IWorkflow>();
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            //1.获取当前登录用户
            string loginname = GetLoginName(userInfo);
            if (string.IsNullOrEmpty(loginname))
            {
                return;
            }
            string error = "";
            int incident = ConvertUtil.ToInt32(userInfo.Incident);
            string type = userInfo.Type.ToUpper().Trim();
            string processName = userInfo.ProcessName;
            string stepName = "";// userInfo.StepName;
            string formID = userInfo.FormID;
            string tableName = userInfo.TableName;
            string taskID = "";// userInfo.TaskID;
            string summary = userInfo.Summary;
            string documentNo = userInfo.DOCUMENTNO;
            Hashtable vars = new Hashtable();
            vars = _workflow.GetFormVars(userInfo, ref vars);//获取变量
            //bool flag = pfl.Callback(strTaskid, formID, Request.QueryString["UserName"], Request.QueryString["StepName"], tableName);
            string returnStep = userInfo.StepName;  //撤回步骤
            //获取当前激活的步骤
            string strSql = "select top 1 TASKID,STEPLABEL,ASSIGNEDTOUSER from TASKS  where PROCESSNAME=@PROCESSNAME and INCIDENT=@INCIDENT  and STATUS=1";
            DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(strSql, processName, incident);
            if (dt.Rows.Count > 0)
            {
                taskID = ConvertUtil.ToString(dt.Rows[0]["TASKID"]).Trim();
                stepName = ConvertUtil.ToString(dt.Rows[0]["STEPLABEL"]).Trim();
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Pushnotify", "<script>alert('" + Lang.Get("CallbackFailure") + "!');window.close();</script>");
                return;
            }
            //不可以重复撤回!
            if (stepName == returnStep)
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Pushnotify", "<script>alert('已撤回,不可以重复撤回!');</script>");
                return;
            }
            //调用接口
            bool flag = pfl.SubmitTask(6, taskID, processName, ref incident
                , stepName, loginname, summary, "", vars, type, tableName, new List<string>(), formID, documentNo, returnStep, ref error);
            if (!flag)
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Pushnotify", "<script>alert('" + Lang.Get("CallbackFailure") + "!');window.close();</script>");
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Pushnotify", "<script>alert('" + Lang.Get("CallbackSuccess") + "');window.close();</script>");
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {

        }


        private void GetDocumentNo(string processname, int incident, string tablename)
        {
            try
            {
                string sql = "select FORMID,documentno from " + tablename +
               " where processname=N'" + processname + "' and incident='" + incident + "'";
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["documentno"].ToString().Contains("YG") || dt.Rows[0]["documentno"].ToString().Contains("JD"))
                    {
                        string baseUrl = ConfigurationManager.AppSettings["WEB_API_URL"].Trim();
                        string result;
                        result = HttpUtil.HttpGet(string.Format("{0}/api/order/AutomaticApproval?DocumentNo={1}", baseUrl, dt.Rows[0]["documentno"].ToString()), "application/json;charset=UTF-8");
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error($"自动拒绝：{ex.Message}");
                throw;
            }

        }
        //protected void btnApprover_Click(object sender, EventArgs e)
        //{
        //    UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
        //    bool isCreateForm = userInfo.IsCreateForm;

        //    if (isCreateForm)
        //    {
        //        SaveDraft();
        //    }

        //    Session["FormID"] = userInfo.FormID;

        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "showNextApprover", "showNextApprover();", true);

        //}

        /// <summary>
        /// 复制
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnProcessCopy_Click(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 催办
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnReminders_Click(object sender, EventArgs e)
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                string processName = userInfo.ProcessName;
                string documentNo = userInfo.DOCUMENTNO;
                string formID = userInfo.FormID;
                string applicantcode = userInfo.ApplicantAccount;
                string applicant = userInfo.Applicant;
                //查询出要催办的人员信息
                string str = @"select TASKID	,PROCESSNAME	,PROCESSVERSION	INCIDENT,	STEPID,	STEPLABEL,ASSIGNEDTOUSER  from TASKS  where STATUS=1 and PROCESSNAME=@PROCESSNAME and INCIDENT=@INCIDENT";
                DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(str, processName, incident);
                string taskid = string.Empty;
                string assignedtouser = string.Empty;
                string steplabel = string.Empty;
                int stepid = 0;
                string Email_Message = string.Empty;
                string Email_Status = string.Empty;
                foreach (DataRow item in dt.Rows)
                {
                    taskid = ConvertUtil.ToString(item["TASKID"]).Trim();
                    assignedtouser = ConvertUtil.ToString(item["ASSIGNEDTOUSER"]).Trim(); //通知人
                    steplabel = ConvertUtil.ToString(item["STEPLABEL"]).Trim();
                    stepid = ConvertUtil.ToInt32(item["STEPID"]);
                    string assignedToUserName = string.Empty;
                    string language = GetLanguage(processName.Trim(), incident, assignedtouser, ref assignedToUserName); //获取语言

                    #region Email 催办通知
                    EmailSender email = new EmailSender();
                    email.EmailTitle = "[工作流-催办] 您有任务需要审批," + GetCnProcessName(processName, incident, language) + "--";
                    try
                    {
                        email.SendEmail(processName, incident, stepid, taskid);
                        //成功
                        Email_Message += "邮件催办-" + assignedToUserName + "成功!\\n";
                        Email_Status = "1";
                    }
                    catch (Exception)
                    {
                        //失败
                        Email_Message += "邮件催办-" + assignedToUserName + "失败!\\n";
                        Email_Status = "0";

                    }
                    //bool message = email.SendEmail(processName, incident, stepid, taskid);
                    //if (message)
                    //{
                    //    //成功
                    //    Email_Message += "邮件催办-" + assignedToUserName + "成功!\\n";
                    //    Email_Status = "1";
                    //}
                    //else
                    //{
                    //    //失败
                    //    Email_Message += "邮件催办-" + assignedToUserName + "失败!\\n";
                    //    Email_Status = "0";
                    //}
                    #endregion

                    #region 钉钉 催办通知

                    #endregion

                    string sql = @"insert into WF_REMINDERS(ID, FORMID, PROCESSNAME, INCIDENT, DOCUMENTNO, TASKID, STEPID, STEPLABEL, APPLICANTCODE, APPLICANT, ASSIGNEDTOUSER, ASSIGNEDTOUSERNAME, 
                    CREATEDATE, EMAIL_ERRORMESSAGE, EMAIL_STATUS, DINGTALK_ERRORMESSAGE, DINGTALK_STATUS) 
                    values(@ID,@FORMID,@PROCESSNAME, @INCIDENT, @DOCUMENTNO, @TASKID, @STEPID, @STEPLABEL, @APPLICANTCODE, @APPLICANT, @ASSIGNEDTOUSER, @ASSIGNEDTOUSERNAME, 
                    @CREATEDATE, @EMAIL_ERRORMESSAGE, @EMAIL_STATUS, @DINGTALK_ERRORMESSAGE, @DINGTALK_STATUS)";
                    DataAccess.Instance("BizDB").ExecuteNonQuery(sql, Guid.NewGuid().ToString(), formID, processName, incident, documentNo, taskid, stepid, steplabel, applicantcode, applicant, assignedtouser, assignedToUserName,
                    DateTime.Now, Email_Message, Email_Status, "", 1);
                }
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Reminders", "<script>alert('" + Email_Message + "');</script>");
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Reminders", "<script>alert('催办失败!');</script>");
            }

        }

        public string GetCnProcessName(string ProcessName, int Incident, string language)
        {
            string processname = "";
            if (language.ToLower() == "en-us")
            {
                return ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar("select ENNAME from WF_PROCESS where PROCESSNAME=@PROCESSNAME", ProcessName));
            }
            else if (language.ToLower() == "zh-cn")
            {
                return ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar("select CNNAME from WF_PROCESS where PROCESSNAME=@PROCESSNAME", ProcessName));
            }
            return processname;
        }

        public string GetLanguage(string ProcessName, int Incident, string assignedToUser, ref string assignedToUserName)
        {
            string language = "en-us";
            try
            {
                string to = "";
                if (!string.IsNullOrEmpty(assignedToUser))
                {
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable("select email,username,LANGUAGE from v_org_user where loginname='" + assignedToUser.Replace("/", "\\") + "'");
                    if (dt.Rows.Count > 0)
                    {
                        to = ConvertUtil.ToString(dt.Rows[0][0]);
                        assignedToUserName = ConvertUtil.ToString(dt.Rows[0][1]).Trim();
                        language = ConvertUtil.ToString(dt.Rows[0][2]).Trim();
                    }
                }
                if (string.IsNullOrEmpty(language))
                {
                    language = "en-us";
                }
            }
            catch (Exception)
            {

            }
            return language;
        }

        protected void btnSIGN_Click(object sender, EventArgs e)
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                bool flag = false;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                string prefix = userInfo.ProcessPrefix;
                string processName = userInfo.ProcessName;
                string stepName = userInfo.StepName;
                string formID = userInfo.FormID;

                //Stopwatch watch = new Stopwatch();
                //watch.Start();
                DataSet formData = new DataSet();
                //watch.Stop();
                //long lng= watch.ElapsedMilliseconds;
                //LogUtil.Info("watch:" + lng);
                string tableName = userInfo.TableName;
                bool isCreateForm = userInfo.IsCreateForm;
                string taskID = userInfo.TaskID;
                string applicant = userInfo.Applicant;
                int actionType = approvalHistory.ActionType;
                string returnStep = approvalHistory.ReturnStep;

                string error = "";
                Hashtable vars = new Hashtable();

                //1.获取当前登录用户
                string loginname = GetLoginName(userInfo);
                if (string.IsNullOrEmpty(loginname))
                {
                    return;
                }
                //2.开始执行之前的自定义事件
                if (BeforeSubmit != null)
                {
                    CancelEventArgs cea = new CancelEventArgs();
                    BeforeSubmit(vars, cea);
                    if (cea.Cancel)
                    {
                        return;
                    }
                }
                //string summary = userInfo.Summary + (userInfo.FindControl("read_DEPARTMENT") as Label).Text;// +"-" + userInfo.Applicant;
                //string summary = (userInfo.FindControl("read_DEPARTMENT") as Label).Text + "-" + userInfo.Summary;
                string summary = userInfo.Summary;
                string comments = approvalHistory.Comments;
                vars = _workflow.GetFormVars(userInfo, ref vars);//获取变量
                var signName = string.Format("{0}", FormatUltimusUser(approvalHistory.SIGNNAME));
                var isSign = GETISSIGN(1, processName, stepName);
                vars.Add("ISSIGN", isSign);
                vars.Add("USER_SIGNNAME", signName);
                vars.Add("STEPNAME", stepName);

                formData = _workflow.GetFormData(userInfo, formID);//获取表单数据
                flag = _workflow.SubmitForm(formData, vars, loginname, applicant, taskID, processName,
                    incident, stepName, tableName, formID, prefix, isCreateForm, type,
                    summary, actionType, returnStep, comments, ref error, userInfo.DOCUMENTNO, true);

                if (!flag || !string.IsNullOrEmpty(error))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败：" + error.Replace("'", "").Replace("\"", "") + "');", true);
                    return;
                }
                if (actionType == 1 & processName.ToUpper() == "PO_AMENDMENT")
                {
                    ReturnResultPO(processName, incident);
                }
                if (actionType == 2 && processName.Contains("OR"))
                {
                    GetDocumentNo(processName, incident, tableName);
                }
                //自动发起待阅
                if (userInfo.Type.ToUpper() != "NEWREQUEST" && userInfo.Type.ToUpper() != "DRAFT")
                {
                    string readsql = string.Format("update WF_READS set Status='1' where PROCESSNAME=N'{0}' and INCIDENT='{1}' and APPLICANT='{2}'"
                        , userInfo.ProcessName, userInfo.Incident, SessionLogic.GetLoginName());
                    DataAccess.Instance("BizDB").ExecuteNonQuery(readsql);
                }               
                //6.执行成功之后的自定义事件
                if (AfterSubmit != null)
                {
                    CancelEventArgs ce = new CancelEventArgs();
                    AfterSubmit(sender, ce);
                    if (ce.Cancel)
                    {
                        return;
                    }
                }
                if (processName.Contains("OR"))
                {
                    btnReject.Visible = false;
                    btnApprove.Visible = false;

                }
                if (processName.Contains("CPR"))
                {
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;

                }
                if (processName.Contains("PR"))
                {
                    btnReject.Visible = false;
                    btnApprove.Visible = false;
                    btnReturn.Visible = false;
                }
                UpdateSIGN(processName, incident, signName);
                btTransfer.Visible = false;
                butSIGN.Visible = false;
            }
            catch (Exception ex) //意外终止
            {
                LogUtil.Error("提交失败!", ex);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败!错误信息：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
                return;
            }                
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "submitSuccess();", true);

        }
        private string GETISSIGN(int type, string processName, string stepName)
        {
            return DataAccess.Instance("BizDB").ExecuteScalar(string.Format("SELECT ISSIGN FROM PROC_PROCESS_SIGN WHERE PROCESSNAME='{0}' AND  STEPNAME='{1}' and TYPE={2}", processName, stepName, type)).ToString();

        }
        private void UpdateSIGN(string processName, int incident, string signName)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.Append(" update  [dbo].[PROC_" + processName + "] set USER_SIGNNAME='" + signName + "'  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "' and DOCUMENTNO is not null");
            DataAccess.Instance("BizDB").ExecuteNonQuery(sSql.ToString());

        }
        private string FormatUltimusUser(string userCode)
        {
            string domain = "CustomOC";
            return string.Format("USER:org={0},user={0}/{1}", domain, userCode);
        }

        protected void btnTransfer_Click(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
            string taskID = userInfo.TaskID;
            string processName = userInfo.ProcessName;
            int incident = ConvertUtil.ToInt32(userInfo.Incident);
            var signName = "CustomOC/" + approvalHistory.SIGNNAME;         
            var sql = "update TASKS set ASSIGNEDTOUSER= N'" + signName + "' where TASKID = '" + taskID + "' and status = 1";
            DataAccess.Instance("UltDB").ExecuteNonQuery(sql);
            SaveStartAddSignApprovalHistroy();
            UpdateSIGN(processName, incident, signName);
            btTransfer.Visible = false;
            butSIGN.Visible = false;

        }
        public bool SaveStartAddSignApprovalHistroy()
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                string loginname = GetLoginName(userInfo);
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string processName = userInfo.ProcessName;
                string stepName = userInfo.StepName;
                ApprovalHistory approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                var signName = "CustomOC/" + approvalHistory.SIGNNAME;
                string sql = @"INSERT INTO WF_APPROVALHISTORY
                (PROCESSNAME ,INCIDENT,STEPNAME,APPROVERNAME ,APPROVERACCOUNT
                ,ACTION,COMMENTS,CREATEDATE,CHILDPROCESSNAME,CHILDINCIDENT,EXT01,ID)
                 VALUES(@PROCESSNAME ,@INCIDENT,@STEPNAME,@APPROVERNAME ,@APPROVERACCOUNT
                ,@ACTION,@COMMENTS,@CREATEDATE,@CHILDPROCESSNAME,@CHILDINCIDENT,@EXT01,@ID)"; DataAccess.Instance("BizDB").ExecuteNonQuery(sql, processName, incident, stepName, signName, signName, "", "转办人:" + loginname.Split('\\')[1], DateTime.Now, "", "", "", SerialNoLogic.GetMaxNo("WF_APPROVALHISTORY", "ID"));
            }
            catch (Exception ex)
            {
                LogUtil.Error("Error:" + ex.Message);
                throw;
            }
            return true;
        }

        private void Reminders()
        {
            EmailNotificationSubscription emailNotification = new EmailNotificationSubscription();
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            int incident = ConvertUtil.ToInt32(userInfo.Incident);
            string processName = userInfo.ProcessName;
            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat(@"SELECT TASKID,a.PROCESSNAME,a.INCIDENT,b.SUMMARY,b.INITIATOR,a.STEPLABEL,a.TASKUSER,a.ASSIGNEDTOUSER,a.STATUS,      a.SUBSTATUS,a.STARTTIME,a.ENDTIME,a.STEPID,a.OVERDUETIME,b.STATUS as PROCESSSTATUS,'' as SERVERNAME  FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 ", processName, incident);
            DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
            if (dtTask.Rows.Count > 0)
            {
                string stepLabel = string.Empty;
                string taskUser = string.Empty;
                string ti = string.Empty;
                foreach (DataRow row in dtTask.Rows)
                {
                    string hwProcessname = processName;
                    int nStepType = ConvertUtil.ToInt32(row["StepId"]);
                    string strTaskId = ConvertUtil.ToString(row["TaskID"]);

                    stepLabel = string.Format("{0};", ConvertUtil.ToString(row["STEPLABEL"]).Trim());
                    taskUser = string.Format("{0};", ConvertUtil.ToString(row["TASKUSER"]).Trim());
                    ti = string.Format("{0};", ConvertUtil.ToString(row["TASKID"]).Trim());

                    emailNotification.TaskActivated(hwProcessname, ConvertUtil.ToInt32(incident), nStepType, strTaskId);
                }

            }

        }

        public void GetShow(string processName, int incident)
        {
            if ((processName == "CPR_FOOD" || processName == "OR_CPR_FOOD") && incident != -1)
            {
                StringBuilder sSql = new StringBuilder();
                sSql.Append("SELECT USER_SIGNNAME FROM [dbo].[PROC_" + processName + "]  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "' and DOCUMENTNO is not null");
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count > 0)
                {
                    if (!string.IsNullOrWhiteSpace(dt.Rows[0]["USER_SIGNNAME"].ToString()))
                    {
                        butSIGN.Visible = false;
                        btTransfer.Visible = false;
                    }
                }

            }

        }

    }
}