using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyDelegationConfirmApproval : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string processName =Request.QueryString["processName"];
            string type= Request.QueryString["type"];
            string AssignUserAccount = Request.QueryString["assignToUser"];
            string TaskUserEN = Request.QueryString["taskUser"];
            AssignUserAccount = "CustomOC/"+ Request.QueryString["assignToUser"];
            TaskUserEN = "CustomOC/" +Request.QueryString["taskUser"];
          
            string txtBegin = Request.QueryString["beginTime"];
            string txtEnd = Request.QueryString["endTime"];
            string approvalName= Request.QueryString["approvalName"];
            this.approvalName.Text = GetUserName(approvalName);
            this.assignUser.Text = AssignUserAccount;
            this.taskUser.Text = TaskUserEN;
            this.Process.Text = processName;
            this.startTime.Text = txtBegin;
            this.endTime.Text = txtEnd;


           
        }
       
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string AssignUserAccount=this.assignUser.Text;
            string TaskUserEN = this.taskUser.Text;
            string processName = this.Process.Text;
            string txtBegin = this.startTime.Text;
            string txtEnd = this.endTime.Text;
           bool result= SendEmail(processName, TaskUserEN, AssignUserAccount, txtBegin, txtEnd);
            if (result) {
               
               
                string sSql = string.Format("update COM_ASSIGNMENT set remark=N'{5}'where taskuser='{0}' and assignedtouser='{1}' and assignfrom='{2}' and assignuntil='{3}' and processname=N'{4}' and status=2", TaskUserEN, AssignUserAccount, txtBegin, txtEnd, processName, "代理人确认中");
                DataAccess.Instance("BizDB").ExecuteNonQuery(sSql);
            }
            Response.Write(string.Format("<script>alert('操作成功');window.location.href='MyDelegationConfirmList.aspx?AssignUserAccount={0}'</script>",AssignUserAccount));
        }
        public  bool SendEmail(string processName,string TaskUserEN, string AssignUserAccount, string txtBegin, string txtEnd)
        {
            try
            {
                string email = null;
            
                string sSql1 = string.Format("select email,cnname,loginName from org_user where loginName='{0}' OR loginName='{1}'", AssignUserAccount.Split('/')[1], TaskUserEN.Split('/')[1]);
                LogUtil.Info(sSql1);
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
                string EmailTitle = string.Format("有一个流程代理需要您确认,There is a process agent that requires your confirmation.");
                AssignUser entity = new AssignUser();
                entity.processName = processName;
                entity.AssignUserAccount = AssignUserAccount;

                entity.txtBegin = txtBegin;
                entity.txtEnd = txtEnd;

                entity.AssignUserEN = AssignUserAccount.Split('/')[1];
                entity.TaskUserEN = TaskUserEN.Split('/')[1];
                foreach (DataRow item in dt.Rows)
                {
                    LogUtil.Info(item["loginName"].ToString()+ AssignUserAccount.Split('/')[1]+ TaskUserEN.Split('/')[1]);
                   
                    if (item["loginName"].ToString().ToUpper() == AssignUserAccount.Split('/')[1].ToUpper())
                    {
                        LogUtil.Info(item["cnname"].ToString() + item["email"].ToString());
                        entity.AssignUserCN = item["cnname"].ToString();
                        email = item["email"].ToString();
                       
                    }
                    else if (item["loginName"].ToString().ToUpper() == TaskUserEN.Split('/')[1].ToUpper())
                    {
                        entity.TaskUserCN = item["cnname"].ToString();
                        
                    }
                }
               
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

                    }
                    else
                    {
                        LogUtil.Error("can not find email:" + dt.Rows[0]["email"].ToString());
                    }
                

                return true;


            }
            catch (Exception ex)
            {
                LogUtil.Error($"通知邮件SD权力失败，失败原因：{ex.Message}");
                throw;
            }

        }

        public bool SendEmail(AssignUser auth)
        {
            string sSql1 = string.Format("select email from org_user where loginname='{0}'", auth.TaskUserEN);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
            string EmailTitle = null;
            string path = null;
            string templatePath = "";
           
                EmailTitle = string.Format("您有一个流程代理已经被拒绝,You have a process agent that has been rejected");
                path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                templatePath = path + "\\assignUseApprovalRejest.html";
            
            string Body = "";
            Body = TemplateEngine.Parse<AssignUser>(templatePath, auth);
            if (!string.IsNullOrEmpty(dt.Rows[0]["email"].ToString()))
            {
                IEmail emails = ServiceContainer.Instance().GetService<IEmail>();
                emails.SendMail(dt.Rows[0]["email"].ToString(), EmailTitle, Body);
                LogUtil.Info("通知邮件流程代理SendEmail_Notify:" + dt.Rows[0]["email"].ToString());

            }
            else
            {
                LogUtil.Error("can not find email:" + dt.Rows[0]["email"].ToString());
            }
            return true;
        }
   


      
  
        protected void btnReject_Click(object sender, EventArgs e)
        {
            string common = this.txtComments.Text;
            string AssignUserAccount = this.assignUser.Text;
            string TaskUserEN = this.taskUser.Text.Split('/')[1];
            string processName = this.Process.Text;
            string txtBegin = this.startTime.Text;
            string txtEnd = this.endTime.Text;
            string approvalName = this.approvalName.Text;
            AssignUser user = new AssignUser()
            {
                processName = processName,
                TaskUserEN = TaskUserEN,
                TaskUserCN = GetUserName(TaskUserEN),
                AssignUserEN = AssignUserAccount.Split('/')[1],
                AssignUserCN = GetUserName(AssignUserAccount.Split('/')[1]),
                txtBegin = txtBegin,
                txtEnd = txtEnd,
                approvalNameEN = Request.QueryString["approvalName"],
                approvalNameCN= approvalName
            };

            SendEmail(user);
            string sSql = string.Format("update COM_ASSIGNMENT set remark=N'{5}', status=0  where taskuser='CustomOC/{0}' and assignedtouser='{1}' and assignuntil='{2}' and assignfrom='{3}' and processname=N'{4}' and status=2", TaskUserEN, AssignUserAccount, txtEnd, txtBegin, processName, "代理人领导已拒绝,拒绝理由:" + common);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sSql);
            Response.Write(string.Format("<script>alert('操作成功');window.location.href='MyDelegationConfirmList.aspx?AssignUserAccount={0}'</script>", AssignUserAccount));
        }
        public string GetUserName(string userName) {
            string sSql1 = string.Format("select email,cnname,loginName from org_user where loginName='{0}' ", userName);
           DataTable dt=  DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
            if (dt.Rows.Count > 0) {
                return  dt.Rows[0]["cnname"].ToString();
            }
            return null;
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