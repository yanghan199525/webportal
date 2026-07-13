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
//using Ultimus.UWF.Workflow.Logic;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Workflow.Dao;

namespace Ultimus.UWF.AddSign
{
    public partial class ButtonList_AddSign : System.Web.UI.UserControl
    {
        public event CancelEventHandler BeforeSubmit;
        public event CancelEventHandler AfterSubmit;
        IWorkflow _task = ServiceContainer.Instance().GetService<IWorkflow>();
        WorkflowDao _dao = new WorkflowDao();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserInfo_AddSign userInfo = Page.FindControl("UserInfo1") as UserInfo_AddSign;
                string type = Request.QueryString["Type"];
                //btnSaveDraft.Visible = false;
                switch (type.ToUpper().Trim())
                {
                    case "NEWREQUEST":
                        //btnSaveDraft.Visible = true;                    
                        break;
                    case "DRAFT":
                        //btnSaveDraft.Visible = true;
                        btnSubmit.Visible = true;
                        btnSend.Visible = true;
                        break;
                    case "MYAPPROVAL":
                    case "MYREQUEST":
                        btnSubmit.Visible = false;
                        btnSend.Visible = false;
                        break;
                }

                string taskid = userInfo.TaskId;
                if (string.IsNullOrEmpty(taskid)) //没有任务编号，提交不可见
                {
                    btnSubmit.Visible = false;
                    btnSend.Visible = false;
                }
                else
                {
                    if (!taskid.StartsWith("S")) //已完成任务，提交不可见
                    {

                        int iStatus = GetTaskStatusBySql(taskid);
                        if (iStatus != 1)
                        {
                            btnSubmit.Visible = false;
                            btnSend.Visible = false;
                        }
                    }
                }
                //多语言
                btnSend.Text = Lang.Get("Form_Submit");
                btnClose.Text = Lang.Get("TaskStatus_Close");
                //btnSaveDraft.Text = Lang.Get("Form_SaveDraft");

                // hyFlow.NavigateUrl = "~/Portal/Ultimus.UWF.Workflow/TaskStatus.aspx?ProcessName=" + Request.QueryString["ProcessName"] + "&Incident=" + Request.QueryString["INCIDENT"] + "&ServerName=" + Request.QueryString["ServerName"];
            }
        }
        public int GetTaskStatusBySql(string strTaskid)
        {
            try
            {
                string strSql = "select t.status from tasks t where t.taskid ='" + strTaskid + "'";
                return Convert.ToInt32(DataAccess.Instance("UltDB").ExecuteScalar(strSql));

            }
            catch (Exception ex)
            {
                return 0;
                throw ex;

            }
        }
        string GetLoginName(UserInfo_AddSign userInfo)
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

        List<VarEntity> GetVarList(Hashtable table)
        {
            List<VarEntity> list = new List<VarEntity>();
            foreach (DictionaryEntry ety in table)
            {
                VarEntity p = new VarEntity();
                p.Name = Convert.ToString(ety.Key);
                p.Value = Convert.ToString(ety.Value);
                list.Add(p);
            }
            return list;
        }
        List<ParameterEntity> GetParameterList(Hashtable table)
        {
            List<ParameterEntity> list = new List<ParameterEntity>();
            foreach (DictionaryEntry ety in table)
            {
                ParameterEntity p = new ParameterEntity();
                p.Name = Convert.ToString(ety.Key);
                p.Value = Convert.ToString(ety.Value);
                list.Add(p);
            }
            return list;
        }

        bool Submit(int actionType, string taskId, string processName, ref int incident, string stepLabel,
            string userName, string summary, Hashtable vars, string tableName, string formID, string documentNo, string type)
        {
            string error = "";
            ApprovalHistory_AddSign approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory_AddSign;

            TaskEntity entity = new TaskEntity();
            entity.ASSIGNEDTOUSER = userName;
            entity.TASKID = taskId;
            entity.SUMMARY = summary;
            entity.VarList = GetVarList(vars);

            int outIncident = 0;
            string info = "";
            int submitAfter = ConvertUtil.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar("select SUBMITAFTER from WF_ADDSIGN where incident=@incident", incident));
            int addSignCount = 0;
            int taskCount = 0;
            string parenttaskid = "";
            String APPLICANTACCOUNT = "";
            DataTable dt = new DataTable();
            bool flag = true;
            if (actionType == 0)
            {
                if (_dao.CheckTaskQueue(taskId))
                {
                    error = "已签核，请在已办中查看!";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败：" + error + "');", true);
                    return false;
                }
                //提交当前任务

                info = _task.ApproveTask("", taskId, entity.ASSIGNEDTOUSER, entity.SUMMARY, "", GetParameterList(vars),
                    formID, processName, incident, stepLabel);

                if (info.IndexOf("failure") >= 0)
                {
                    flag = false;
                }
            }
            else
            {
                //退回，终止当前流程
                info = _task.AbortProcess("", processName, incident, entity.ASSIGNEDTOUSER, summary, formID, stepLabel);

                if (info.IndexOf("failure") >= 0)
                {
                    flag = false;
                }

                //插入审批历史记录
                flag = SaveApprovalHistroy(actionType, type, processName, incident, approvalHistory.Comments
                    , userName, stepLabel);
                if (!flag)
                {
                    return false;
                }

                //退回父任务
                if (submitAfter == 1 && flag)
                {

                    dt = DataAccess.Instance("BizDB").ExecuteDataTable("select top 1 * from WF_ADDSIGN where incident=@incident", incident);
                    if (dt.Rows.Count > 0)
                    {
                        parenttaskid = ConvertUtil.ToString(dt.Rows[0]["parenttaskid"]);
                        APPLICANTACCOUNT = ConvertUtil.ToString(dt.Rows[0]["APPLICANTACCOUNT"]);
                        info = _task.ReturnTask("", parenttaskid, APPLICANTACCOUNT, entity.SUMMARY, "", null, formID, processName, incident, stepLabel);

                    }

                }

            }
            if (info.IndexOf("failure") >= 0)
            {
                error = info;
            }
            else
            {
                error = "";
            }
            outIncident = ConvertUtil.ToInt32(info.Replace("success:", ""));

            if (!string.IsNullOrEmpty(error)) //2.1提交失败
            {
                //DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("update {0} set INCIDENT={1},  STATUS=0 where FORMID='{2}'",
                //    tableName, -1 , formID));
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败：" + error + "');", true);
                return false;
            }
            else //2.2提交成功
            {

            }

            return true;
        }

        bool SaveApprovalHistroy(int actionType, string type, string processName, int incident, string comments,
            string userName, string stepLabel)
        {
            ApprovalHistoryEntity approval = new ApprovalHistoryEntity();
            UserEntity user = SessionLogic.GetLoginUserEntity();


            Label read_PARENTPROCESSNAME = Page.FindControl("read_PARENTPROCESSNAME") as Label;
            Label read_PARENTINCIDENT = Page.FindControl("read_PARENTINCIDENT") as Label;

            string sql = @"INSERT INTO WF_APPROVALHISTORY
           (PROCESSNAME ,INCIDENT,STEPNAME ,APPROVERNAME ,APPROVERACCOUNT
           ,ACTION,COMMENTS,CREATEDATE,CHILDPROCESSNAME,CHILDINCIDENT,EXT01,ID)
            VALUES(@PROCESSNAME ,@INCIDENT,@STEPNAME ,@APPROVERNAME ,@APPROVERACCOUNT
           ,@ACTION,@COMMENTS,@CREATEDATE,@CHILDPROCESSNAME,@CHILDINCIDENT,@EXT01,@ID)";

            string AddApproveHistory = "";
            try
            {
                if (!string.IsNullOrEmpty(Lang.Get("Add_History_Approve")))
                {
                    AddApproveHistory = Lang.Get("Add_History_Approve");
                }
                else
                {
                    AddApproveHistory = Lang.Get("History_Approve");
                }
            }
            catch (Exception)
            {
                AddApproveHistory = Lang.Get("History_Approve");
            }



            DataAccess.Instance("BizDB").ExecuteNonQuery(sql, read_PARENTPROCESSNAME.Text, read_PARENTINCIDENT.Text, stepLabel, user.USERNAME, "",
                AddApproveHistory, comments, DateTime.Now, processName, incident, userName
                , SerialNoLogic.GetMaxNo("WF_APPROVALHISTORY", "ID"));

            return true;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string strApplicantAccout;
            bool flag;
            Hashtable vars = new Hashtable();
            ApprovalHistory_AddSign approvalHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory_AddSign;
            try
            {
                UserInfo_AddSign userInfo = Page.FindControl("UserInfo1") as UserInfo_AddSign;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                string type = userInfo.Type.ToUpper().Trim();
                //1.获取当前登录用户
                strApplicantAccout = GetLoginName(userInfo);
                if (string.IsNullOrEmpty(strApplicantAccout))
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

                //3.保存业务库
                List<string> detailTables = new List<string>();
                string documentNo = "";
                DataSet FormData = userInfo.GetFormData();

                if (string.IsNullOrEmpty(userInfo.Summary))
                {
                    userInfo.Summary = documentNo;
                }
                flag = Submit(approvalHistory.ActionType, userInfo.TaskId, userInfo.ProcessName, ref incident
                    , userInfo.StepName, strApplicantAccout, null, vars, userInfo.TableName, userInfo.FormId, documentNo, type);
                if (!flag)
                {
                    return;
                }
                //5.插入审批历史记录
                flag = SaveApprovalHistroy(approvalHistory.ActionType, type, userInfo.ProcessName, incident, approvalHistory.Comments
                    , strApplicantAccout, userInfo.StepName);
                if (!flag)
                {
                    return;
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
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败!错误信息：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
                return;
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "submitSuccess();", true);
        }


    }
}