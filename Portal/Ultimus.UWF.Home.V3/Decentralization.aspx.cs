using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using System.Data;
using System.Web.Services;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class Decentralization : System.Web.UI.Page
    {
        public static string sdName;
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string LoginName = SessionLogic.GetLoginName().Split('\\')[1];
            languaes = GetLanguaes(LoginName);
            this.hdLanguaes.Value = languaes;
            BindPageTxt(languaes);
            DataTable dt = GetLeaderNumber(LoginName);
                if (dt.Rows.Count > 0)
                {
                   this.empNo.Text = dt.Rows[0]["leaderNumber"].ToString();
                   this.empName.Text = dt.Rows[0]["leaderEmail"].ToString().Split('@')[0];
                   sdName= dt.Rows[0]["leaderEmail"].ToString().Split('@')[0];
                List<Auth> list = BindOrg(dt.Rows[0]["leaderNumber"].ToString());
                this.OrgInfo.DataSource = list;
                this.OrgInfo.DataBind();
                DropDownList DropDownListRD = (DropDownList)Page.FindControl("DropDownListRD");
                   string empName = DropDownListRD.SelectedItem.Text;
                   if (empName == "") {
                    BindRD(list);
                   }
                Ultimus.UWF.Form.WebControls.Repeater rptLog = Page.FindControl("rptInfo") as Ultimus.UWF.Form.WebControls.Repeater;
                //ProcessFormLogic process = new ProcessFormLogic();
                rptLog.Source = string.Format("BizDB.select sdName,sdEmpNo,sdCreatTime,sdOrgName,rdName,rdEmpNo,rdCreatTime,comments,authStartTime,authEndTime,authDesc,authRange  from PROC_Decentralization_Log where rdEmpNo='{0}'", this.empNo.Text);
                rptLog.Sort = " sdCreatTime DESC";
            }
                else {
                Response.Write("<script>alert('尊敬的用户此页面为SD权力下放，您当前无权操作,Dear user, this page is SD delegation of authority. You have no right to operate at present!');window.location.href='MyTaskListV3.aspx'</script>");
                }
        }
        private void BindRD(List<Auth> list)
        {
            var result=list.GroupBy(x =>new { x.sdOrgValue }).Select(x=>new { x.Key.sdOrgValue });
            DropDownList empNo = (DropDownList)Page.FindControl("DropDownListRD");
            empNo.Items.Clear();
            empNo.DataSource = result;
            empNo.DataTextField = "sdOrgValue";
            empNo.DataValueField = "sdOrgValue";
            empNo.DataBind();
            empNo.Items.Insert(0, new ListItem("", ""));
        }
        public DataTable GetLeaderNumber(string LoginName) {

            string sql = string.Format("select leaderName,leaderNumber,leaderEmail from SODEXO_ORGANIZATION where orgCode like '%ND%'AND leaderNumber IN(SELECT EMPNO FROM ORG_USER WHERE LOGINNAME = N'{0}')", LoginName);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="leaderNumber"></param>
        /// <returns></returns>
        public List<Auth> BindOrg(string leaderNumber) {
            List<Auth> list = new List<Auth>();
            string sql1 = string.Format("select a.orgCode,sdOrgCode,rdLeaderNumber,sdLeaderNumber,startTime,endTime,authRange,type,b.leaderName,b.leaderEmail from proc_sdauth a, SODEXO_ORGANIZATION b where a.rdLeaderNumber = b.leaderNumber and a.orgCode = b.orgCode and a.sdLeaderNumber='{0}'", leaderNumber);
            DataTable table = DataAccess.Instance("BizDB").ExecuteDataTable(sql1);
            if (table.Rows.Count > 0)
            {
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    Auth auth = new Auth();
                    auth.rdCode = table.Rows[i]["rdLeaderNumber"].ToString();
                    auth.rdName = table.Rows[i]["leaderEmail"].ToString().Split('@')[0];
                    auth.orgName = table.Rows[i]["orgCode"].ToString();
                    auth.sdOrgName = table.Rows[i]["sdOrgCode"].ToString();
                    auth.sdOrgValue = table.Rows[i]["sdOrgCode"].ToString() + "-" + sdName;
                   auth.isOrg = "是/yes";
                    if (string.IsNullOrEmpty(table.Rows[i]["authRange"].ToString()))
                    {
                        auth.authRange = "0";
                    }
                    else {
                        //只针对单外，目前写死
                        if (languaes == "zh-CN")
                        {
                            auth.authRange = "单外采购流程审批";
                        }
                        else {
                            auth.authRange = "Approval of Out-of-Catalogue purcahse requisition";
                        }
                       
                    }
                    auth.startTime= table.Rows[i]["startTime"].ToString();
                    auth.endTime = table.Rows[i]["endTime"].ToString();
                    if (Convert.ToDateTime(table.Rows[i]["endTime"]) <DateTime.Now)
                    {
                        auth.authType = "已过期/Expired";
                    }
                    else {
                        auth.authType = table.Rows[i]["type"].ToString();
                    }
                    if (languaes == "zh-CN")
                    {
                        auth.operation = "收回";
                    }
                    else {
                        auth.operation = "cancel";
                    }
                   
                    list.Add(auth);
                }
            }
            string sql = string.Format("select parentOrgCode,parentOrgName,orgCode,orgName,leaderName,leaderNumber,leaderEmail from SODEXO_ORGANIZATION where parentOrgCode in(select orgCode from SODEXO_ORGANIZATION where leaderNumber = '{0}'and orgCode like '%ND%') and leaderName != ''and leaderNumber != '' AND leaderEmail != ''", leaderNumber);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
           
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    bool isLeaderNumber =Convert.ToInt32( DataAccess.Instance("BizDB").ExecuteScalar(string.Format("select count(0) from ORG_USER WHERE EMPNO ='{0}'", dt.Rows[i]["leaderNumber"].ToString())))> 0;
                    if (!isLeaderNumber) continue;
                    Auth auth = new Auth();
                    auth.rdCode = dt.Rows[i]["leaderNumber"].ToString();
                    auth.rdName = dt.Rows[i]["leaderEmail"].ToString().Split('@')[0];
                    auth.orgName = dt.Rows[i]["orgCode"].ToString();
                    auth.sdOrgName= dt.Rows[i]["parentOrgCode"].ToString();
                    auth.sdOrgValue = dt.Rows[i]["parentOrgCode"].ToString()+"-"+ sdName;
                    auth.authRange = "0";
                    auth.isOrg = "是/yes";
                    auth.authType = "未授权/Unauthorized";
                    if (languaes == "zh-CN")
                    {
                        auth.operation = "授权";
                    }
                    else
                    {
                        auth.operation = "auth";
                    }
                   
                    if (list.Count(x => x.orgName == auth.orgName && x.rdCode == auth.rdCode) > 0)
                    {
                        continue;
                    }
                    else {
                        list.Add(auth);
                    }
                }
            }
            return list;
        }
        public class Auth {
            public string rdName { get; set; }
            public string rdCode { get; set; }
            public string orgName { get; set; }
            public string sdOrgName { get; set; }
            public string sdOrgValue { get; set; }
            public string isOrg { get; set; }
            public string authType { get; set; }
            public string startTime { get; set; }
            public string endTime { get; set; }
            public string operation { get; set; }
            public string sdName { get; set; }
            public string sdEmpNo { get; set; }
            public string authRange { get; set; }
            

        }

        protected void btn_Serch_Click(object sender, EventArgs e)
        {
            DropDownList DropDownListType = (DropDownList)Page.FindControl("DropDownListType");
            DropDownList DropDownListRD = (DropDownList)Page.FindControl("DropDownListRD");
            string authType = DropDownListType.SelectedItem.Text;
            string empName= DropDownListRD.SelectedItem.Text;
            string LoginName = SessionLogic.GetLoginName().Split('\\')[1];
            DataTable dt = GetLeaderNumber(LoginName);
            if (dt.Rows.Count > 0)
            {
                List<Auth> list = BindOrg(dt.Rows[0]["leaderNumber"].ToString());
                if (authType != "" && empName == "")
                {
                    list = list.Where(x => x.authType.Contains(authType)).ToList();
                    this.OrgInfo.DataSource = list;
                    this.OrgInfo.DataBind();
                }
                else if (empName != "" && authType == "")
                {
                    list = list.Where(x => x.sdOrgValue.Contains(empName)).ToList();
                    this.OrgInfo.DataSource = list;
                    this.OrgInfo.DataBind();
                }
                else if (empName != "" && authType != "")
                {
                    list = list.Where(x => x.authType.Contains(authType) && x.sdOrgValue.Contains(empName)).ToList();
                    this.OrgInfo.DataSource = list;
                    this.OrgInfo.DataBind();
                }
                else {
                    this.OrgInfo.DataSource = list;
                    this.OrgInfo.DataBind();
                }
               
            }

        }

        public void BindPageTxt(string type)
        {
            switch (type)
            {
                case "zh-CN":
                    this.label_sdInfo.Text = "事业部总监信息";
                    this.label_epmNo.Text = "事业部总监员工号:";
                    this.label_empName.Text = "事业部总监员工姓名:";
                    this.label_rdInfo.Text = "事业部下属RD信息";
                    this.label_orgName.Text = "事业部";
                    this.label_rdType.Text = "RD授权状态";
                    this.label_sdOrgName.Text = "SD所属事业部";

                    this.label_rdName.Text = "RD姓名";
                    this.label_rdEmpNo.Text = "RD员工编号";
                    this.label_isOrgName.Text = "RD是否仍在事业部";
                    this.label_rdOrgName.Text = "RD所属事业部";
                    this.label_authType.Text = "授权状态";
                    this.label_startTime.Text = "授权开始日期";
                    this.label_endTime.Text = "授权截至时间";
                    this.label_authRange.Text = "授权范围";
                    this.label_operation.Text = "操作";

                    this.btn_Serch.Text = "查询";

                    this.log_info.Text = "SD授权信息操作记录";
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
                    this.label_sdInfo.Text = "SD Information:";
                    this.label_epmNo.Text = "SD Staff No:";
                    this.label_empName.Text = "SD Name:";
                    this.label_rdInfo.Text = "RD Information";
                    this.label_orgName.Text = "Business Unit";
                    this.label_rdType.Text = "RD authorization status";
                    this.label_sdOrgName.Text = "BU of SD";

                    this.label_rdName.Text = "RD Name";
                    this.label_rdEmpNo.Text = "RD Staff No.";
                    this.label_isOrgName.Text = "RD is still in the BU";
                    this.label_rdOrgName.Text = "BU of RD";
                    this.label_authType.Text = "Authorization Status";
                    this.label_startTime.Text = "Start Time of Authorization";
                    this.label_endTime.Text = "End Time of Authorization";
                    this.label_authRange.Text = "Scope of authorization";
                    this.label_operation.Text = "Operate";

                    this.btn_Serch.Text = "Search";

                    this.log_info.Text = "Operating Records of SD Authorized Information";
                    this.log_sdName.Text = "SD Name";
                    this.log_sdEmpNo.Text = "SD Staff No.";
                    this.log_sdCreate.Text = "Operating Time of Authorization";
                    this.log_orgName.Text = "Business Unit";
                    this.log_rdName.Text = "RD Name";
                    this.log_rdempNo.Text = "RD Staff No.";
                    this.log_rdCreate.Text = "Operating Time of RD";
                    this.log_startTime.Text = "Start Time of Authorization";
                    this.log_endTime.Text = "End Time of Authorization";
                    this.log_desc.Text = "Authorization Instruction";
                    this.log_range.Text = "Scope of authorization";
                    this.log_content.Text = "Operation content";
                    break;
                default:
                    break;
            }
        }

        public string GetLanguaes(string loginName) {
            string sql = string.Format("select LANGUAGE from ORG_USER where LOGINNAME='{0}'",loginName);
            DataTable dt= DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt.Rows[0]["LANGUAGE"].ToString();
         }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="rdName"></param>
        /// <param name="rdEmpNo"></param>
        /// <param name="sdEmpNo"></param>
        /// <param name="sdEmpName"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        [WebMethod]
        public static bool SendEmail(string rdName, string rdEmpNo, string sdEmpNo, string sdEmpName, string startTime, string endTime, string type,string orgName,string sdOrgName,string authRange)
        {
            try
            {
                if (type == "1")
                {
                    authRange = "单外采购流程审批/Approval of Out-of-Catalogue purcahse requisition";
                    string sSql1 = string.Format("select email from org_user where empno='{0}'", rdEmpNo);
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql1);
                    string EmailTitle = string.Format("有一个SD权力下放需要您的同意,Your confirmation for delegation is Appreciated.");
                    AuthInform entity = new AuthInform();
                    entity.rdCode = rdEmpNo;
                    entity.rdName = rdName;
                    entity.sdEmpNo = sdEmpNo;
                    entity.sdName = sdEmpName;
                    entity.startTime = startTime.ToString();
                    entity.endTime = endTime.ToString();
                    entity.orgName = orgName;
                    entity.sdOrgName = sdOrgName;
                    entity.authRange = authRange;
                    string path = System.Configuration.ConfigurationManager.AppSettings["RootPhysicalPath"] + "\\Portal\\Ultimus.UWF.Home.V3\\Email";
                    entity.RootPath= System.Configuration.ConfigurationManager.AppSettings["SendEmail.RootPath"];
                    string templatePath = "";
                    templatePath = path + "\\informEmail.html";
                    string Body = "";
                    Body = TemplateEngine.Parse<AuthInform>(templatePath, entity);
                    if (!string.IsNullOrEmpty(dt.Rows[0]["email"].ToString()))
                    {
                        IEmail emails = ServiceContainer.Instance().GetService<IEmail>();
                        emails.SendMail(dt.Rows[0]["email"].ToString(), EmailTitle, Body);

                        string sSql = string.Format("SELECT orgCode FROM PROC_SDAUTH WHERE rdLeaderNumber='{0}' AND sdLeaderNumber='{1}'AND orgCode='{2}'and sdOrgCode='{3}' ", rdEmpNo, sdEmpNo,orgName,sdOrgName);
                        DataTable table = DataAccess.Instance("BizDB").ExecuteDataTable(sSql);
                        if (table.Rows.Count > 0)
                        {
                            string sSql2 = string.Format("UPDATE PROC_SDAUTH SET startTime='{2}',endTime='{3}' WHERE rdLeaderNumber='{0}' AND sdLeaderNumber='{1}' AND orgCode='{4}' and sdOrgCode='{5}' and authRange=N'{6}'", rdEmpNo, sdEmpNo, startTime, endTime,orgName, sdOrgName,authRange);
                            DataAccess.Instance("BizDB").ExecuteNonQuery(sSql2);
                        }
                        else
                        {
                            string sql = string.Format("insert into proc_sdauth values(NEWID(), '{0}', '{1}', '{2}', '{3}', '{4}','{5}',N'{6}',N'{7}')", sdOrgName, orgName, rdEmpNo, sdEmpNo, Convert.ToDateTime(startTime), Convert.ToDateTime(endTime), "授权中/Under authorization", authRange);
                            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                        }
                        LogUtil.Info("通知邮件SD权力下放SendEmail_Notify:" + dt.Rows[0]["email"].ToString());

                        //插入操作记录
                        DecentralizationLog log = new DecentralizationLog {
                            sdName = sdEmpName,
                            sdEmpNo = sdEmpNo,
                            sdCreatTime = DateTime.Now,
                            sdOrgName = sdOrgName,
                            rdEmpNo = rdEmpNo,
                            rdName = rdName,
                            authStartTime=Convert.ToDateTime(startTime),
                            authEndTime=Convert.ToDateTime(endTime),
                            authDesc= "The delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies.Non -compliance to the DOA as outlined in this document may result in disciplinary actions. 被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。The authority delegated in this document shall not be sub - delegated.上述授权不能二次授权。",
                            comments = "等待RD授权确认中/Waiting for RD authorization confirmation",
                            authRange= authRange
                        };
                        Log(log);
                    }
                    else
                    {
                        LogUtil.Error("can not find email:" + dt.Rows[0]["email"].ToString());
                    }
                    return true;
                }
                else
                {
                    string sql = string.Format("delete from PROC_SDAuth where sdOrgCode='{2}' AND rdLeaderNumber='{0}' AND sdLeaderNumber='{1}' and orgCode='{3}'", rdEmpNo, sdEmpNo, sdOrgName,orgName);
                    DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                    //插入操作记录
                    DecentralizationLog log = new DecentralizationLog
                    {
                        sdName = sdEmpName,
                        sdEmpNo = sdEmpNo,
                        sdCreatTime = DateTime.Now,
                        sdOrgName = sdOrgName,
                        rdEmpNo = rdEmpNo,
                        rdName = rdName,
                        authStartTime = Convert.ToDateTime(startTime),
                        authEndTime = Convert.ToDateTime(endTime),
                        authDesc = "The delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies.Non - compliance to the DOA as outlined in this document may result in disciplinary actions. 被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。 The authority delegated in this document shall not be sub - delegated.上述授权不能二次授权。",
                        comments = "SD取消授权/SD Unauthorization",
                        authRange = authRange
                    };
                    Log(log);
                    return true;
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error($"通知邮件SD权力失败，失败原因：{ex.Message}");
                throw;
            }
           
        }
        public static void Log(DecentralizationLog log) {
                string sql = string.Format("insert into PROC_Decentralization_Log values(NEWID(),   N'{0}','{1}','{2}','{3}',N'{4}','{5}','{6}',N'{7}','{8}','{9}',N'{10}',N'{11}')", log.sdName, log.sdEmpNo, log.sdCreatTime, log.sdOrgName, log.rdName, log.rdEmpNo, log.rdCreatTime, log.comments,log.authStartTime,log.authEndTime,log.authDesc,log.authRange);
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
        }

        public class AuthInform
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
        public class DecentralizationLog {
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