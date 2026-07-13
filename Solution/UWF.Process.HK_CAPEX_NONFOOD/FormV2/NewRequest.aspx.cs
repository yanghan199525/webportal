using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data;
using Ultimus.UWF.Form.ProcessControl.V3;
using MyLib;
using Ultimus.UWF.Workflow.Logic;
using Ultimus.UWF.Form.Interface;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Workflow.Entity;
using System.Data.Common;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.OrgChart;
using Ultimus.UWF.Home.V3;
using System.Web.Script.Serialization;
using System.Web.Services;
using MyLib.Json;
using System.Text.RegularExpressions;
using System.Linq;

namespace UWF.Process.CAPEX_NONFOOD
{
    public partial class NewRequest : System.Web.UI.Page
    {
        public static string user_name = string.Empty;
        public static string CprType = string.Empty;
        public static string CprArticle = string.Empty;
        public static string SiteCode = string.Empty;
        protected void AfterLoad()
        {
            string procType = Request.QueryString["Type"];
            string Incident = Request.QueryString["Incident"];
            string TaskID = Request.QueryString["TaskID"];
            string UserName = Request.QueryString["UserName"];
            string FORMID = Request.QueryString["FORMID"];
            string ShowType = Request.QueryString["ShowType"];
            try
            {
                if (TaskID.Contains("S") && procType.ToUpper() == "NEWREQUEST")
                {
                    HttpContext.Current.Session["LoginName"] = UserName;
                    HttpContext.Current.Session["LoginPassword"] = null;
                }
            }

            catch (Exception ex)
            { }

            user_name = UserName;
            //多语言显示下拉框
            BindDropdownlistByLanguage(UserName);
            string languageCE = GetLanguage(UserName);
            PersonInfo pr = new PersonInfo();
            pr.Loding(GetCname(user_name.Trim().Replace('/', '\\').ToString()), languageCE);
            if (procType.ToUpper().Trim() == "NEWREQUEST")
            {
                ButtonList ButtonList1 = (ButtonList)Page.FindControl("ButtonList1");
                LinkButton btnSaveDraft = (LinkButton)ButtonList1.FindControl("btnSaveDraft");
                //btnSaveDraft.Attributes.Add("style", "display:none");
                btnSaveDraft.Visible = true;
                string pcCode = Request.QueryString["pccode"];
                //string pcCode = "CN001601"; 
                //UserInfo UserInfo1=Page.FindControl("UserInfo1") as UserInfo;
                TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                fld_SITECODE.Text = pcCode;
                string siteName = string.Empty;
                string compCode = string.Empty;

                new sodexoProfitCentersLogic().QuerySiteNameAndCompCode(out siteName, out compCode, pcCode);
                if (string.IsNullOrEmpty(siteName))
                {
                    throw new Exception("分店名称查询失败/PC name query failed");
                }
                else if (string.IsNullOrEmpty(siteName))
                {
                    throw new Exception("分店所在公司编码查询失败/The company code query for the branch failed");
                }
                else
                {
                    TextBox fld_SITENAME = (TextBox)Page.FindControl("fld_SITENAME");
                    fld_SITENAME.Text = siteName;

                }
                TextBox fld_ISCOR = (TextBox)Page.FindControl("fld_ISCOR");
                var isCOR = IsCOR(pcCode);
                fld_ISCOR.Text = isCOR.ToString();
                if (isCOR == 1)
                {
                    TextBox fld_ISCORName = (TextBox)Page.FindControl("fld_ISCORName");
                    fld_ISCORName.Text = ISCORName(pcCode).ToString();
                }
            }
            if (procType.ToUpper().Trim() == "REPORT")
            {
                string rootPath = getRootPath();

                string url = string.Format("{4}/Solution/PR.PRProcess.CAPEX_NONFOOD/Form/NewRequest.aspx?ProcessName=CAPEX_NONFOOD&StepName=Begin&Incident={0}&TaskID={1}&UserName={2}&Type=MYREQUEST&ServerName=&t=&FORMID={3}&hasformid=0&t=&processStatus=1&ShowType=REPORT", Incident, TaskID, UserName, FORMID, rootPath);
                Response.Redirect(url);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                if (ShowType == "REPORT")
                {
                    ButtonList ButtonList1 = (ButtonList)Page.FindControl("ButtonList1");
                    Button btnAbortIncident = (Button)ButtonList1.FindControl("btnAbortIncident");
                    btnAbortIncident.Attributes.Add("style", "display:none");
                }

            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string loginName = UserName.Replace('/', '\\');
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginName, "");

            }
            //草稿箱
            if (procType.ToUpper().Trim() == "DRAFT")
            {


            }
        }

        /// <summary>
        /// json字符串转json对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="jsonString"></param>
        /// <returns></returns>
        public static T FromJSON<T>(string jsonString)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Deserialize<T>(jsonString);
        }

        public static string GetCname(string userName)
        {

            string loginName = userName.Trim().Replace('/', '\\').Split('\\')[1];
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT USERNAME FROM ORG_USER WHERE LOGINNAME='" + loginName + "' ");
            DataTable db = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return db.Rows[0]["USERNAME"].ToString();
        }
        /// <summary>
        /// 提交前触发的事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void NewRequest_BeforeSubmit(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                decimal AuthorizedAmount = Convert.ToDecimal(System.Web.Configuration.WebConfigurationManager.AppSettings["AuthorizedAmount"].ToString());
                decimal UnauthorizedAmount = Convert.ToDecimal(System.Web.Configuration.WebConfigurationManager.AppSettings["UnauthorizedAmount"].ToString());

                TextBox fld_APPLYPURPOSETXT = (TextBox)Page.FindControl("fld_APPLYPURPOSETXT");
                TextBox fld_SUPPLIERTYPETXT = (TextBox)Page.FindControl("fld_SUPPLIERTYPETXT");


                HiddenField SUPPLIERTYPE = (HiddenField)Page.FindControl("SUPPLIERTYPE");
                HiddenField SUPPLIERTYPETXT = (HiddenField)Page.FindControl("SUPPLIERTYPETXT");

                UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;

                TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                TextBox fld_SITENAME = (TextBox)Page.FindControl("fld_SITENAME");
                TextBox fld_AMOUNT = (TextBox)Page.FindControl("fld_AMOUNT");

                TextBox fld_APPROVEDATE = (TextBox)Page.FindControl("fld_APPROVEDATE");
                TextBox fld_DELIVERYDATE = (TextBox)Page.FindControl("fld_DELIVERYDATE");
                TextBox fld_DELIVERY = (TextBox)Page.FindControl("fld_DELIVERY");
                TextBox fld_APPROVE = (TextBox)Page.FindControl("fld_APPROVE");
                fld_APPROVEDATE.Text = DateTime.Now.ToString();
                DateTime date_APPROVEDATE = Convert.ToDateTime(fld_APPROVEDATE.Text);
                DateTime date_DELIVERYDATE = Convert.ToDateTime(fld_DELIVERYDATE.Text);
                string str_APPROVEDATE = date_APPROVEDATE.ToString("yyyyMMddHHmm");
                string str_DELIVERYDATE = date_DELIVERYDATE.ToString("yyyyMMddHHmm");
                string Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
                fld_APPROVE.Text = str_APPROVEDATE;
                fld_DELIVERY.Text = str_DELIVERYDATE;

                UserInfo.Summary = string.Format("{0}({1})-合计金额({2})", fld_SITENAME.Text, fld_SITECODE.Text, fld_AMOUNT.Text);
                // AddArticleRepeater();
                TextBox fld_PURCHASINGAGENT = (TextBox)Page.FindControl("fld_PURCHASINGAGENT");

                TextBox fld_ISCOR = (TextBox)Page.FindControl("fld_ISCOR");
                TextBox fld_ISCORName = (TextBox)Page.FindControl("fld_ISCORName");
                //1224.5.22
                //要求送货日期，必须再明天晚上6点以后,默认时间为早上6点30（1224）
                if (Convert.ToDateTime(date_DELIVERYDATE.ToString()) < Convert.ToDateTime(Value.ToString()))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);

                    e.Cancel = true;
                }
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", " document.getElementById('ButtonList1_btnSend').style.display = 'none';", true);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 提交后触发的事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void NewRequest_AfterSubmit(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
                if (fld_SUPPLIERTYPE.SelectedItem.Value == "9" || fld_SUPPLIERTYPE.SelectedItem.Text == "授权供应商" || fld_SUPPLIERTYPE.SelectedItem.Text == "Authorized Supplier")
                {
                    #region 提交成功之后更改一次性物料使用次数
                    TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                    TextBox fld_SUPPLIERCODE = (TextBox)Page.FindControl("fld_SUPPLIERCODE");
                    UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
                    Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_CAPEX_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_CAPEX_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
                    IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                    DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_CAPEX_NONFOOD_ITEMS, UserInfo.FormID);
                    foreach (DataRow item in Article.Rows)
                    {
                        string ArticleName = item["ARTICLENAME"].ToString();
                        string ArticleCode = item["ARTICLECODE"].ToString();
                        string ArticleFamily = item["SUBSUBFAMILYCODE"].ToString();
                        string SiteCode = fld_SITECODE.Text;
                        string SupplierCode = fld_SUPPLIERCODE.Text;

                        StringBuilder sSql = new StringBuilder();
                        sSql.AppendFormat(@"SELECT * FROM [dbo].[SODEXO_Article] where [SiteCode]='{0}' AND [ArticleFamily]='{1}' AND SupplierCode='{2}' AND ArticleName=N'{3}' AND ArticleCode='{4}'", SiteCode, ArticleFamily, SupplierCode, ArticleName, ArticleCode);
                        DataTable ar = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                        if (ar.Rows.Count > 0)
                        {
                            string IsOneTimeUsing = ar.Rows[0]["IsOneTimeUsing"].ToString();
                            string UseTimes = ar.Rows[0]["UseTimes"].ToString();
                            if (IsOneTimeUsing == "1")
                            {
                                string ID = ar.Rows[0]["ID"].ToString();
                                sSql.Length = 0;
                                sSql.AppendFormat(@"UPDATE SODEXO_Article SET UseTimes=1 WHERE ID='{0}'", ID);
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
                                            sSql.AppendFormat(@"UPDATE SODEXO_Article SET UseTimes=1 WHERE ID='{0}'", ID);
                                            int res = DataAccess.Instance("BizDB").ExecuteNonQuery(sSql.ToString());
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
                throw new Exception(ex.Message);
            }

        }
        /// 获取链接对应的域名
        /// </summary>
        /// <returns></returns>
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
        /// <summary>
        /// 查询当前用户使用的语言，下拉框显示对应的文本语言
        /// </summary>
        /// <param name="userName"></param>
        private void BindDropdownlistByLanguage(string userName)
        {
            string language = GetLanguage(userName);

        }
        private string GetLanguage(string username)
        {
            string loginName = "";
            string language = "";
            StringBuilder sSql = new StringBuilder();
            if (username != "")
            {
                loginName = username.Trim().Replace('/', '\\').Split('\\')[1];
                sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + loginName + "'");
                language = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
            }
            return language;
        }
        /// <summary>
        /// 根据员工编号查询用户信息
        /// </summary>
        /// <param name="empno"></param>
        private string GetUserByEmp(string empno)
        {
            try
            {
                string loginname = string.Empty;
                string cnname = string.Empty;
                StringBuilder sSql = new StringBuilder();
                sSql.AppendFormat("SELECT * FROM ORG_USER WHERE EMPNO='{0}'", empno);
                DataTable ORG_USER = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (ORG_USER.Rows.Count > 0)
                {
                    loginname = ORG_USER.Rows[0]["LOGINNAME"].ToString();
                    string name_cn = ORG_USER.Rows[0]["CNNAME"].ToString();
                    if (name_cn != "")
                    {
                        cnname = name_cn;
                    }
                    else
                    {
                        cnname = ORG_USER.Rows[0]["USERNAME"].ToString();
                    }
                }
                else
                {
                    string msg = string.Format("无固定资产对应的一级加签审批人\\nNo fixed assets corresponding to the level of the signature of the approver");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                }

                return loginname + ";" + cnname;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public static int IsCOR(string pccode)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = new DataTable();
            sSql.Append(@"
  WITH locs(parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail)
AS
(
SELECT parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail FROM SODEXO_ORGANIZATION WHERE orgcode=@orgcode
UNION ALL
SELECT A.parentOrgCode,A.parentOrgName,A.orgCode,A.orgName,A.orgType,A.leaderNumber,A.leaderName,A.orgStartDate,A.orgEndDate,A.siteCode,A.companyCode,A.isDeploy,A.deployDate,A.modifyDate,A.orgAddress,A.siteEmail,A.leaderContact,A.leaderEmail FROM SODEXO_ORGANIZATION A,locs B WHERE
A.orgCode = B.PARENTORGCODE
)
select  parentOrgCode,parentOrgName,orgCode,orgName,c.EMPNO EMPNO,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail from locs l left join PROC_PROCESSSTEPAPPROVER_COO c on l.orgCode = c.ND 
");
            using (DbCommand cmd = db.CreateCommand())
            {
                cmd.CommandText = sSql.ToString();
                cmd.CommandType = CommandType.Text;

                db.AddInParameter(cmd, "@orgcode", DbType.String, pccode);
                dt = db.ExecuteDataTable(cmd);
            }
            string ndEdu = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCOR"];
            string ndEduName = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCORName"];
            string NdCORF = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCORF"];
            string NdCORN = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCORN"];
            var dd = dt.AsEnumerable().Where(x => x["orgCode"].ToString() == ndEdu && x["orgName"].ToString() == ndEduName);
            if (dd.Any())
            {
                var dd1 = dt.AsEnumerable().Where(x => x["orgCode"].ToString().StartsWith("ND") && (x["EMPNO"].ToString().Contains(NdCORF) || x["EMPNO"].ToString().Contains(NdCORN)));
                if (dd1.Any())
                {
                    return 1;
                }
            }
            return 0;

        }

        private string ISCORName(String pccode)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            StringBuilder sSql2 = new StringBuilder();
            sSql2.Append(string.Format(@" WITH locs(
  parentOrgCode, parentOrgName, orgCode,
  orgName, orgType, leaderNumber, leaderName,
  orgStartDate, orgEndDate, siteCode,
  companyCode, isDeploy, deployDate,
  modifyDate, orgAddress, siteEmail,
  leaderContact, leaderEmail
) AS(
  SELECT
    parentOrgCode,
    parentOrgName,
    orgCode,
    orgName,
    orgType,
    leaderNumber,
    leaderName,
    orgStartDate,
    orgEndDate,
    siteCode,
    companyCode,
    isDeploy,
    deployDate,
    modifyDate,
    orgAddress,
    siteEmail,
    leaderContact,
    leaderEmail
  FROM
    SODEXO_ORGANIZATION
  WHERE
    orgcode = '{0}'
  UNION ALL
  SELECT
    A.parentOrgCode,
    A.parentOrgName,
    A.orgCode,
    A.orgName,
    A.orgType,
    A.leaderNumber,
    A.leaderName,
    A.orgStartDate,
    A.orgEndDate,
    A.siteCode,
    A.companyCode,
    A.isDeploy,
    A.deployDate,
    A.modifyDate,
    A.orgAddress,
    A.siteEmail,
    A.leaderContact,
    A.leaderEmail
  FROM
    SODEXO_ORGANIZATION A,
    locs B
  WHERE
    A.orgCode = B.PARENTORGCODE
)
select
  o.LOGINNAME
from
  locs l
  inner
join PROC_PROCESSSTEPAPPROVER_COO c on l.orgCode = c.ND

and l.orgCode like 'ND%'
  inner join ORG_USER o on c.EMPNO = o.EMPNO ", pccode));
            DataTable dt2 = db.ExecuteDataTable(sSql2.ToString());
            if (dt2.Rows.Count > 0)
            {
                return dt2.AsEnumerable().FirstOrDefault()["LOGINNAME"].ToString();
            }
            else
            {
                throw new Exception("组织架构CRO异常,请联系管理员");
            }
        }
    }
}