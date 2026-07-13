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
    public partial class MyDelegationConfirm : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string processName =Request.QueryString["processName"];
            string type= Request.QueryString["type"];
            string AssignUserAccount = Request.QueryString["assignToUser"];
            string TaskUserEN = Request.QueryString["taskUser"];
            if (type == "Email") {
                 AssignUserAccount = "CustomOC/"+ Request.QueryString["assignToUser"];
                 TaskUserEN = "CustomOC/" +Request.QueryString["taskUser"];
            }
          
            string txtBegin = Request.QueryString["beginTime"];
            string txtEnd = Request.QueryString["endTime"];
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
            string sqlStr = string.Format("select count(0) from COM_ASSIGNMENT where taskuser='{0}' and assignedtouser='{1}' and assignuntil='{2}' and assignfrom='{3}' and processname='{4}' and status=1", TaskUserEN, AssignUserAccount, txtBegin, txtEnd, processName);
            int count=Convert.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(sqlStr));
            if (count > 0) {
                Response.Write("<script>alert('您已经同意代理操作，请勿重复操作');window.location.href='MyDelegationConfirmList.aspx'</script>");
            }
          
            bool result=  _workflow.DelegationTask("", processName.Trim()== "All Process"? "All Process" : processName.Trim(), "", TaskUserEN, AssignUserAccount, DateTime.Parse(txtBegin), DateTime.Parse(txtEnd));
            if (result) {
               
                string sql = string.Format("delete from COM_ASSIGNMENT where taskuser='{0}' and assignedtouser='{1}' and assignuntil='{2}' and assignfrom='{3}' and processname=N'{4}' and status=2", TaskUserEN, AssignUserAccount, txtEnd, txtBegin, processName);
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                string sSql = string.Format("update COM_ASSIGNMENT set remark=N'{5}'where taskuser='{0}' and assignedtouser='{1}' and assignfrom='{2}' and assignuntil='{3}' and processname=N'{4}' and status=1", TaskUserEN, AssignUserAccount, txtBegin, txtEnd, processName, "代理人已确认");
                DataAccess.Instance("BizDB").ExecuteNonQuery(sSql);
            }
            AssignUser user = new AssignUser()
            {
                processName = processName,
                TaskUserEN= TaskUserEN.Split('/')[1],
                TaskUserCN= GetUserName(TaskUserEN.Split('/')[1]),
                AssignUserEN = AssignUserAccount.Split('/')[1],
                AssignUserCN = GetUserName(AssignUserAccount.Split('/')[1]),
                txtBegin=txtBegin,
                txtEnd=txtEnd

            };
            SendEmail(user, 1);
            Response.Write(string.Format("<script>alert('操作成功');window.location.href='MyDelegationConfirmList.aspx?AssignUserAccount={0}'</script>",AssignUserAccount));
        }

        public bool SendEmail(AssignUser auth,int result)
        {
            string sSql1 = string.Format("select email from org_user where loginname='{0}'", auth.TaskUserEN);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
            string EmailTitle = null;
            string path = null;
            string templatePath = "";
            if (result == 0)
            {
                EmailTitle = string.Format("您有一个流程代理已经被拒绝,You have a process agent that has been rejected");
                path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                templatePath = path + "\\assignUserCancelEmail.html";
            }
            else
            {
                EmailTitle = string.Format("您有一个流程代理已经同意,You have a process agent that has been agreed");
                path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                templatePath = path + "\\assignUserConfirmEmail.html";
            }
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
        //public string  GetName(string EmpNo) {
        //    string sql = string.Format("SELECT LOGINNAME from ORG_USER where EMPNO='{0}'", EmpNo);
        //    DataTable table= DataAccess.Instance("BizDB").ExecuteDataTable(sql);
        //    if (table.Rows.Count > 0)
        //    {
        //        return table.Rows[0]["LOGINNAME"].ToString();
        //    }
        //    else {
        //        return null;
        //    }
           
        //}


        //public string GetLanguaes(string rdEmpNo)
        //{
        //    string sql = string.Format("select LANGUAGE from ORG_USER where EMPNO='{0}'", rdEmpNo);
        //    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
        //    return dt.Rows[0]["LANGUAGE"].ToString();
        //}
        public class AuthInfo
        {

            public string rdName { get; set; }
            public string rdCode { get; set; }
            public string orgName { get; set; }
            public string startTime { get; set; }
            public string endTime { get; set; }
            public string sdName { get; set; }
            public string sdEmpNo { get; set; }
            public string RootPath { get; set; }
            public string sdOrgName { get; set; }
            public string authRange { get; set; }
            
        }
        protected void btnReject_Click(object sender, EventArgs e)
        {
            string common = this.txtComments.Text;
            string AssignUserAccount = this.assignUser.Text;
            string TaskUserEN = this.taskUser.Text;
            string processName = this.Process.Text;
            string txtBegin = this.startTime.Text;
            string txtEnd = this.endTime.Text;
            AssignUser user = new AssignUser()
            {
                processName = processName,
                TaskUserEN = TaskUserEN.Split('/')[1],
                TaskUserCN = GetUserName(TaskUserEN.Split('/')[1]),
                AssignUserEN = AssignUserAccount.Split('/')[1],
                AssignUserCN = GetUserName(AssignUserAccount.Split('/')[1]),
                txtBegin = txtBegin,
                txtEnd = txtEnd

            };
            string sSql = string.Format("update COM_ASSIGNMENT set remark=N'{5}', status=0 where taskuser='{0}' and assignedtouser='{1}' and assignuntil='{2}' and assignfrom='{3}' and processname='{4}' and status=2", TaskUserEN, AssignUserAccount, txtEnd,txtBegin , processName, "代理人已拒绝,拒绝理由:"+ common);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sSql);
            SendEmail(user, 0);
            Response.Write("<script>alert('操作成功');window.location.href='MyDelegationConfirmList.aspx'</script>");
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
        }
    }
}