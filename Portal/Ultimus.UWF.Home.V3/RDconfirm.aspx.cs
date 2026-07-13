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

namespace Ultimus.UWF.Home.V3
{
    public partial class RDconfirm : System.Web.UI.Page
    {
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string rdEmpNo = HttpUtility.UrlDecode(Request.QueryString["rdEmpNo"]);
            string sdEmpNo = Request.QueryString["sdEmpNo"];
            string sdOrgName = Request.QueryString["sdOrgName"];
            string orgName = Request.QueryString["orgName"]; 
            string authRange = Request.QueryString["authRange"];

            languaes = GetLanguaes(rdEmpNo);
            BindPageTxt(languaes);

            Label rdUserName = (Label)Page.FindControl("rdUserName");
            Label sdName = (Label)Page.FindControl("sdName");
            Label orgNametxt = (Label)Page.FindControl("orgName");
            Label startTime = (Label)Page.FindControl("startTime");
            Label endTime = (Label)Page.FindControl("endTime");
            Label rdName = (Label)Page.FindControl("rdName");
            Label authRangeTXT = (Label)Page.FindControl("authRange");
            authRangeTXT.Text = authRange;
            DataTable dt = null;


            string sql = string.Format("select orgCode,startTime,endTime,rdLeaderNumber,sdOrgCode,sdLeaderNumber from PROC_SDAuth where type=N'授权中/Under authorization' AND rdLeaderNumber='{0}' and sdOrgCode='{1}' and orgCode='{2}'", rdEmpNo, sdOrgName,orgName);
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                startTime.Text = dt.Rows[0]["startTime"].ToString();
                endTime.Text = dt.Rows[0]["endTime"].ToString();
                orgNametxt.Text = dt.Rows[0]["sdOrgCode"].ToString();
                string sSql = string.Format("select LOGINNAME from ORG_USER WHERE EMPNO='{0}'", rdEmpNo);
                DataTable table = DataAccess.Instance("BizDB").ExecuteDataTable(sSql);
                rdUserName.Text = table.Rows[0]["LOGINNAME"].ToString();
                rdName.Text = table.Rows[0]["LOGINNAME"].ToString();
                string sSql1 = string.Format("select LOGINNAME from ORG_USER WHERE EMPNO='{0}'", dt.Rows[0]["sdLeaderNumber"].ToString());
                DataTable table1 = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
                sdName.Text = table1.Rows[0]["LOGINNAME"].ToString();
            }
            else
            {
                Response.Write("<script>alert('此页面内容为空,The content of this page is empty!');window.location.href='RDconfirmList.aspx'</script>");
            }
        }
        public string GetLeaderNumber(string LoginName)
        {

            string sql = string.Format("SELECT EMPNO FROM ORG_USER WHERE LOGINNAME = N'{0}'", LoginName);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt.Rows[0]["EMPNO"].ToString();
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string rdEmpNo = HttpUtility.UrlDecode(Request.QueryString["rdEmpNo"]);
                string sdEmpNo = Request.QueryString["sdEmpNo"];
                string sdOrgName = this.orgName.Text;
                string orgName = Request.QueryString["orgName"];
                string authRange = Request.QueryString["authRange"];
                string sql = string.Format("select orgCode,startTime,endTime,rdLeaderNumber,sdLeaderNumber from PROC_SDAuth where type=N'已授权/Authorized' AND rdLeaderNumber='{0}' AND sdLeaderNumber='{1}' and sdOrgCode='{2}' and orgCode='{3}'", rdEmpNo, sdEmpNo, sdOrgName,orgName);
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    Response.Write("<script>alert('您已经同意授权，请勿重复操作,You have agreed to authorize, please do not repeat the operation!');window.location.href='RDconfirmList.aspx'</script>");
                }
                else
                {
                    string sql1 = string.Format("UPDATE PROC_SDAUTH SET type=N'{2}' WHERE rdLeaderNumber='{0}' AND sdLeaderNumber='{1}' and sdOrgCode='{3}' and orgCode='{4}'", rdEmpNo, sdEmpNo, "已授权/Authorized", sdOrgName,orgName);
                    int result = DataAccess.Instance("BizDB").ExecuteNonQuery(sql1);
                    if (result > 0)
                    {
                        AuthInfo auth = new AuthInfo {
                            rdName = GetName(rdEmpNo),
                            rdCode = rdEmpNo,
                            sdEmpNo = sdEmpNo,
                            sdName = GetName(sdEmpNo),
                            sdOrgName = sdOrgName,
                            startTime = this.startTime.Text,
                            endTime = this.endTime.Text,
                            authRange= authRange,
                            RootPath = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email"
                         };
                        SendEmail(auth,1);
                        DecentralizationLog log = new DecentralizationLog
                        {
                            sdName = this.sdName.Text,
                            sdEmpNo = sdEmpNo,
                            sdCreatTime = DateTime.Now,
                            sdOrgName = sdOrgName,
                            rdEmpNo = rdEmpNo,
                            rdName = this.rdName.Text,
                            authStartTime = Convert.ToDateTime(this.startTime.Text),
                            authEndTime = Convert.ToDateTime(this.endTime.Text),
                            rdCreatTime = DateTime.Now,
                            authDesc = "The delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies.Non - compliance to the DOA as outlined in this document may result in disciplinary actions.被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。The authority delegated in this document shall not be sub - delegated.上述授权不能二次授权。",
                            authRange = authRange,
                            comments = "同意授权/Consent to Authorization"
                        };
                        Log(log);
                        Response.Write("<script>alert('操作成功!');window.location.href='RDconfirmList.aspx'</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                string txt = string.Format("操作失败，请联系管理员! 失败原因：{0}", ex.Message);
                Response.Write("<script>alert(" + txt + ");");
            }
        }

        public bool SendEmail(AuthInfo auth,int result)
        {
            string sSql1 = string.Format("select email from org_user where empno='{0}'", auth.sdEmpNo);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
            string EmailTitle = null;
            string path = null;
            string templatePath = "";
            if (result == 0) {
                EmailTitle=string.Format("您有一个权力下放已经被拒绝,You have a delegation of authority that has been refused");
                path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                templatePath = path + "\\sdInfoEmail.html";
            } else {
                EmailTitle = string.Format("您有一个SD权力下放RD已经同意,You have agreed to a delegation of authority");
                path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                templatePath = path + "\\sdConfirm.html";
            }
            string Body = "";
            Body = TemplateEngine.Parse<AuthInfo>(templatePath, auth);
            if (!string.IsNullOrEmpty(dt.Rows[0]["email"].ToString()))
            {
                IEmail emails = ServiceContainer.Instance().GetService<IEmail>();
                emails.SendMail(dt.Rows[0]["email"].ToString(), EmailTitle, Body);
                LogUtil.Info("RD通知邮件SD权力下放SendEmail_Notify:" + dt.Rows[0]["email"].ToString());

            }
            else
            {
                LogUtil.Error("can not find email:" + dt.Rows[0]["email"].ToString());
            }
            return true;
        }
        public string  GetName(string EmpNo) {
            string sql = string.Format("SELECT LOGINNAME from ORG_USER where EMPNO='{0}'", EmpNo);
            DataTable table= DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (table.Rows.Count > 0)
            {
                return table.Rows[0]["LOGINNAME"].ToString();
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
                    this.label_info.Text = "RD授权信息确认";
                    this.label_txtUser.Text = "尊敬的用户:";
                    this.label_txtSD.Text = "您的直属领导SD：";
                    this.label_txtAuthInfo.Text = "，授权您进行您所辖分店Buysmart所有单外采购审批中SD审批节点的审批操作，授权信息如下：";
                    this.label_orgNameTxt.Text = "1.事业部名称：";
                    this.label_rdNameTxt.Text = "2.被授权RD：";
                    this.label_startTimeTxt.Text = "3.授权日期：";
                    this.label_RangeTxt.Text = "4.授权范围：";
                    
                    this.label_authDsc.Text = "被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。";


                    this.label_authDsc1.Text = "上述授权不能二次授权。";
                    this.label_common.Text = "理由";
                    break;
                case "en-US":
                    this.label_info.Text = "RD Licensing Information Confirmation";
                    this.label_txtUser.Text = "Dear:";
                    this.label_txtSD.Text = "your direct manager：";
                    this.label_txtAuthInfo.Text = ",authorizes you to approve the SD approval node in all the out of catalogue purchase approvals in BuySMART  for the sites under your management. The authorization information is as follows:";
                    this.label_orgNameTxt.Text = "1.BU Name:";
                    this.label_rdNameTxt.Text = "2. Authorized RD:";
                    this.label_startTimeTxt.Text = "3.Authorized Time:";
                    this.label_RangeTxt.Text = "4. Authorized Scope：";
                    this.label_authDsc.Text = "delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies. Non-compliance to the DOA as outlined in this document may result in disciplinary actions. ";
                    this.label_authDsc1.Text = "The authority delegated in this document shall not be sub-delegated.";
                    this.label_common.Text = "common";
                    this.btn_Approval.Text = "I know and accept";
                    this.btn_Reject.Text = "Reject";
                    break;
                default:
                    break;
            }
        }

        public string GetLanguaes(string rdEmpNo)
        {
            string sql = string.Format("select LANGUAGE from ORG_USER where EMPNO='{0}'", rdEmpNo);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt.Rows[0]["LANGUAGE"].ToString();
        }
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
            string rdEmpNo = HttpUtility.UrlDecode(Request.QueryString["rdEmpNo"]);
            string sdEmpNo = Request.QueryString["sdEmpNo"];
            string sdOrgName = Request.QueryString["sdOrgName"];
            string orgName = Request.QueryString["orgName"];
            string authRange = Request.QueryString["authRange"];
            string sSql = string.Format("select orgCode,startTime,endTime,rdLeaderNumber,sdLeaderNumber from PROC_SDAuth where type=N'授权中/Under authorization' AND rdLeaderNumber='{0}' and sdOrgCode='{1}'  and orgCode='{2}'", rdEmpNo, sdOrgName,orgName);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql);
            if (dt.Rows.Count > 0)
            {
                AuthInfo auth = new AuthInfo
                {
                    rdName = GetName(rdEmpNo),
                    rdCode = rdEmpNo,
                    sdEmpNo = sdEmpNo,
                    sdName = GetName(sdEmpNo),
                    sdOrgName = sdOrgName,
                    startTime = dt.Rows[0]["startTime"].ToString(),
                    endTime = dt.Rows[0]["endTime"].ToString(),
                    authRange = authRange,
                    RootPath = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email"
                };
                SendEmail(auth,0);
                string comments = this.txtComments.Text;
                DecentralizationLog log = new DecentralizationLog
                {
                    sdName = this.sdName.Text,
                    sdEmpNo = sdEmpNo,
                    sdCreatTime = DateTime.Now,
                    sdOrgName = sdOrgName,
                    rdEmpNo = rdEmpNo,
                    rdName = this.rdName.Text,
                    authStartTime = Convert.ToDateTime(dt.Rows[0]["startTime"].ToString()),
                    authEndTime = Convert.ToDateTime(dt.Rows[0]["endTime"].ToString()),
                    rdCreatTime = DateTime.Now,
                    authDesc = "The delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies.Non - compliance to the DOA as outlined in this document may result in disciplinary actions.被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。The authority delegated in this document shall not be sub - delegated.上述授权不能二次授权。",
                    authRange = authRange,
                    comments = "RD拒绝,拒绝理由/RD refused, reason for refusal:" + comments
                };
                Log(log);
                string sql = string.Format("update PROC_SDAuth set type=N'已拒绝/Rejected' where type=N'授权中/Under authorization' AND rdLeaderNumber='{0}' AND sdLeaderNumber='{1}' and sdOrgCode='{2}'  and orgCode='{3}'", rdEmpNo, sdEmpNo, sdOrgName,orgName);
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                Response.Write("<script>alert('操作成功!');window.location.href='RDconfirmList.aspx'</script>");
            }
        }

        public void Log(DecentralizationLog log)
        {
            string sql = string.Format("insert into PROC_Decentralization_Log values(NEWID(),   N'{0}','{1}','{2}','{3}',N'{4}','{5}','{6}',N'{7}','{8}','{9}',N'{10}',N'{11}')", log.sdName, log.sdEmpNo, log.sdCreatTime, log.sdOrgName, log.rdName, log.rdEmpNo, log.rdCreatTime, log.comments, log.authStartTime, log.authEndTime, log.authDesc, log.authRange);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
        }
        public class DecentralizationLog
        {
            public string sdName { get; set; }
            public string sdEmpNo { get; set; }
            public DateTime sdCreatTime { get; set; }
            public string sdOrgName { get; set; }
            public string rdName { get; set; }
            public string rdEmpNo { get; set; }
            public DateTime rdCreatTime { get; set; }
            public string comments { get; set; }
            public DateTime authStartTime { get; set; }
            public DateTime authEndTime { get; set; }
            public string authDesc { get; set; }
            public string authRange { get; set; }

        }
    }
}