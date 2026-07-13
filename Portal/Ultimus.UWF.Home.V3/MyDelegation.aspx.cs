using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Ultimus.UWF.Common.Logic;
using MyLib;
using System.Data;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using System.Web.Services;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyDelegation : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string EnableProcessAssign = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Button1.Text = Lang.Get("Delegation");
            if (Request.QueryString["TaskID"] != null)
            {
                TaskIDs.Value = Request.QueryString["TaskID"].ToString().Trim();
            }
            if (!IsPostBack)
            {
                BingProcess();
            }

            if (ConfigurationManager.AppSettings["EnableProcessAssign"] == "0")
            {
                EnableProcessAssign = "hidden";
            }
        }

        private void BingProcess()
        {
            List<ProcessEntity> processes = _workflow.GetAllProcessList();
            dropProcessName.DataTextField = Lang.Get("ProcessNameField");
            dropProcessName.DataValueField = "PROCESSNAME";
            dropProcessName.DataSource = processes;
            dropProcessName.DataBind();
            dropProcessName.Items.Insert(0, new ListItem("All Process", "All Process"));

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string pFromUser = SessionLogic.GetLoginName().Replace("\\", "/");
            string pToUser = AssignUserAccount.Value.Replace("|USER", "").Replace("\\", "/");
            string pEndDate = txtFutureTaskDate.Text.Trim() == "" ? DateTime.Now.ToString() : txtFutureTaskDate.Text;

            int pMode = 0;
            if (this.RadioButton1.Checked)
            {
                pMode = 1;//仅限选定的任务
            }
            else if (this.RadioButton2
.Checked)
            {
                pMode = 2;//所有现有的任务
            }
            else if (this.RadioButton3.Checked)
            {
                pMode = 3;//所有将来的任务  
                pEndDate = this.txtFutureTaskDate.Text;
            }
            else if (this.RadioButton4.Checked)
            {
                pMode = 4;//按流程指派
            }
            bool result = false;
            if (pMode == 1)
            {
                string[] TaskIDArray = TaskIDs.Value.Split(',');
                foreach (string pTaskID in TaskIDArray)
                {
                    if (pTaskID.Trim() == "")
                        continue;
                    result = this.SetAssign(pTaskID, pFromUser, pToUser, pMode, DateTime.Parse(txtBegin.Text), DateTime.Parse(pEndDate));
                }
            }
            else if (pMode == 3)
            {
                string strProcessName = "";
                //string dBegin = pEndDate;
                //string dEnd = "2099-01-01";
                string dBegin = DateTime.Now.ToShortDateString();
                string dEnd = pEndDate + " 23:59:59";
                if (this.isExistAssign(pFromUser, dBegin))
                {
                    MessageBox("alert('" + Lang.Get("Assign_Msg1") + "')");
                    return;
                }
                result = this.SetProcAssign(strProcessName, pFromUser, pToUser, dBegin, dEnd);
            }
            else if (pMode == 4)
            {
                string strProcessName = dropProcessName.SelectedItem.Value;
                string dBegin = this.txtBegin.Text;
                string dEnd = this.txtEnd.Text + " 23:59:59";


                result = this.SetProcAssign(strProcessName, pFromUser, pToUser, dBegin, dEnd);
            }
            else
            {
                //将来指派和所有任务指派不需要循环
                result = this.SetAssign("", pFromUser, pToUser, pMode, DateTime.Parse(txtBegin.Text), DateTime.Parse(pEndDate));
            }
            if (result)
            {
                MessageBox("closePage();");
            }
            else
            {
                MessageBox("alert('" + Lang.Get("Assign_Msg3") + "')");

            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="processName"></param>
        /// <param name="AssignUserAccount"></param>
        /// <param name="txtBegin"></param>
        /// <param name="txtEnd"></param>
        /// <returns></returns>
        [WebMethod]
        public static bool SendEmail(string processName, string AssignUserAccount, string txtBegin, string txtEnd)
        {
            try
            {
                string email = null;
                string pFromUser = SessionLogic.GetLoginName();
                 pFromUser = SessionLogic.GetLoginName().Split('\\')[1];
                string sSql1 = string.Format("select email,cnname,loginName from org_user where loginName='{0}' OR loginName='{1}'", AssignUserAccount, pFromUser);
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
                string EmailTitle = string.Format("有一个流程代理需要您确认,There is a process agent that requires your confirmation.");
                AssignUser entity = new AssignUser();
                entity.processName = processName.Trim()== "All Process"?"所有": processName.Trim();
                entity.AssignUserAccount = AssignUserAccount;
           
                entity.txtBegin = txtBegin.Replace('/', '-') + " 00:00:00";
                entity.txtEnd = txtEnd.Replace('/', '-') + " 23:59:59";
               
                entity.AssignUserEN = AssignUserAccount;
                entity.TaskUserEN = pFromUser;
                foreach (DataRow item in dt.Rows)
                {
                    if (item["loginName"].ToString() == AssignUserAccount)
                    {
                        entity.AssignUserCN = item["cnname"].ToString();
                        email= item["email"].ToString();
                    }
                    else if (item["loginName"].ToString() == pFromUser)
                    {
                        entity.TaskUserCN = item["cnname"].ToString();
                    }
                }
                if (!CheckOogType(entity)) {
                    string path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                    entity.RootPath = System.Configuration.ConfigurationManager.AppSettings["SendEmail.RootPath"];
                    string templatePath = "";
                    templatePath = path + "\\assignUserInformEmail.html";
                    string Body = "";
                    Body = TemplateEngine.Parse<AssignUser>(templatePath, entity);
                    if (!string.IsNullOrEmpty(email))
                    {
                        IEmail emails = ServiceContainer.Instance().GetService<IEmail>();
                        emails.SendMail(email, EmailTitle, Body);
                        LogUtil.Info("通知邮件代理功能SendEmail_Notify:" + email);

                        //插入操作记录
                        InsertLog(entity, "代理确认中");

                    }
                    else
                    {
                        LogUtil.Error("can not find email:" + dt.Rows[0]["email"].ToString());
                    }
                }
               
                return true;


            }
            catch (Exception ex)
            {
                LogUtil.Error($"通知邮件SD权力失败，失败原因：{ex.Message}");
                throw;
            }

        }

        public static bool CheckOogType(AssignUser entity) {

            var flag = false;
            string sql = $@"WITH locs(parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail)AS(
             SELECT parentOrgCode, parentOrgName, orgCode, orgName, orgType, leaderNumber, leaderName, orgStartDate, orgEndDate, siteCode, companyCode, isDeploy, deployDate, modifyDate, orgAddress, siteEmail, leaderContact, leaderEmail FROM
               SODEXO_ORGANIZATION WHERE  leaderNumber in (select EMPNO from ORG_USER where LOGINNAME = '{entity.TaskUserEN}')
               UNION ALL
               SELECT A.parentOrgCode, A.parentOrgName, A.orgCode, A.orgName, A.orgType, A.leaderNumber, A.leaderName, A.orgStartDate, A.orgEndDate, A.siteCode, A.companyCode, A.isDeploy, A.deployDate, A.modifyDate, A.orgAddress, A.siteEmail, A.leaderContact, A.leaderEmail FROM SODEXO_ORGANIZATION A, locs B WHERE
             A.orgCode = B.PARENTORGCODE )
           select DISTINCT orgCode from locs where orgCode like 'ND%'";
            DataTable dtN = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dtN.Rows.Count > 0)
            {
                var sds = ConfigurationManager.AppSettings["SD"]?.ToString();
                if (sds != null)
                {
                    var sdArr = sds.Split('|').ToList();
                    for (int i = 0; i < dtN.Rows.Count; i++)
                    {
                        var sd = dtN.Rows[i]["orgCode"].ToString();
                        var sdNew = sdArr.FirstOrDefault(d => d == sd);
                        if (sdNew != null)
                        {
                            flag = true;
                            break;
                        }
                    }
                }
            }
            string sqlStr = string.Format("select orgCode from SODEXO_ORGANIZATION where leaderNumber in(select EMPNO from ORG_USER where LOGINNAME = '{0}')",entity.TaskUserEN);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sqlStr);
            if (dt.Rows.Count > 0&& flag) {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["orgCode"].ToString().StartsWith("RD")) {
                        approvalEmail(entity,3);
                        return true;
                    }
                }
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["orgCode"].ToString().StartsWith("AM"))
                    {
                        approvalEmail(entity,2);
                        return true;
                    }

                }
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["orgCode"].ToString().StartsWith("CX"))
                    {
                        approvalEmail(entity,1);
                        return true;
                    }
                }
                return false;
            }
            return false;
        }
        public static void approvalEmail(AssignUser entity,int type) {
            string orgCode = null;
            switch (type)
            {
                case 1:
                    orgCode = "CX";
                        break;
                case 2:
                    orgCode = "AM";
                    break;
                case 3:
                    orgCode = "RD";
                    break;
                default:
                    orgCode = null;
                    break;
            }
            string EmailTitle = "有一个流程代理需要您的审批";
            
            string sql = string.Format("select EMAIL,LOGINNAME,CNNAME from ORG_USER where EMPNO in(select leaderNumber from SODEXO_ORGANIZATION where orgcode in ((select parentOrgCode from SODEXO_ORGANIZATION where leaderNumber in (select EMPNO from ORG_USER where LOGINNAME = '{0}') AND ORGCODE LIKE '{1}%')))", entity.TaskUserEN,orgCode);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0) {
                entity.approvalNameEN = dt.Rows[0]["LOGINNAME"].ToString();
                entity.approvalNameCN = dt.Rows[0]["CNNAME"].ToString();
                string path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                entity.RootPath = System.Configuration.ConfigurationManager.AppSettings["SendEmail.RootPath"];
                string templatePath = "";
                templatePath = path + "\\assignUseApproval.html";
                string Body = "";
                Body = TemplateEngine.Parse<AssignUser>(templatePath, entity);
                if (!string.IsNullOrEmpty(dt.Rows[0]["EMAIL"].ToString()))
                {
                    IEmail emails = ServiceContainer.Instance().GetService<IEmail>();
                    emails.SendMail(dt.Rows[0]["EMAIL"].ToString(), EmailTitle, Body);
                    InsertLog(entity, "代理人上级审批中");
                    LogUtil.Info("通知邮件代理功能SendEmail_Notify:" + dt.Rows[0]["EMAIL"].ToString());
                }
                else
                {
                    LogUtil.Error("can not find email:" + dt.Rows[0]["email"].ToString());
                }
            }
           
        }
        public static void InsertLog(AssignUser user,string remark) {
            // endTime = ConvertUtil.ToDateTime(txtEndDate.Text + " 23:59:59");
            string sql = string.Format("insert into COM_ASSIGNMENT(taskuser,processname,assignedtouser,assignuntil,assignfrom,status,updatetime,remark) values('CustomOC/{0}',N'{1}','CustomOC/{2}',N'{3}','{4}','2',GETDATE(),N'{5}')", user.TaskUserEN,user.processName,user.AssignUserEN, user.txtEnd,user.txtBegin  , remark);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);

        }

        private void MessageBox(string script)
        {
            this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "clo", script, true);
        }

        private bool isExistAssign(string strProcessName, string pFromUser, string dBegin)
        {
            return _workflow.IsExistAssign(strProcessName, pFromUser, ConvertUtil.ToDateTime(dBegin));
        }

        private bool isExistAssign(string pFromUser, string dBegin)
        {
            return _workflow.IsExistAssign(pFromUser, ConvertUtil.ToDateTime(dBegin));
        }

        private bool SetProcAssign(string strProcessName, string pFromUser, string pToUser, string dBegin, string dEnd)
        {
            _workflow.DelegationTask("", strProcessName.Trim(), "", pFromUser, pToUser, ConvertUtil.ToDateTime(dBegin), ConvertUtil.ToDateTime(dEnd));
            return true;

        }

        private bool SetAssign(string pTaskID, string pFromUser, string pToUser, int pMode, DateTime start, DateTime end)
        {
            bool result = false;
            try
            {
                switch (pMode)
                {
                    case 1:
                        result = _workflow.AssignTask("", pTaskID, pToUser);
                        break;
                    case 2:
                        result = _workflow.AssignAllTasks(pFromUser, pToUser);
                        break;
                    case 3:
                        result = _workflow.DelegationTask("", "", "", pFromUser, pToUser, start, end);
                        break;
                }
                return result;

            }
            catch
            {
                return false;
            }
        }
        public class AssignUser
        {
            public string processName { get; set; }
            public string AssignUserAccount { get; set; }
            public string txtBegin { get; set; }
            public string txtEnd { get; set; }
            public string TaskUserCN { get; set; }
            public string TaskUserEN { get; set; }
            public string AssignUserCN { get; set; }
            public string AssignUserEN { get; set; }
            public string RootPath { get; set; }
            public string approvalNameCN { get; set; }
            public string approvalNameEN { get; set; }
        }
    }
}