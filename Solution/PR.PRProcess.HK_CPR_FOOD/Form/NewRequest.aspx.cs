
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
using System.Data.Common;
using System.Web.Services;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Common.Interface;
using Microsoft.VisualBasic;
using System.Runtime.InteropServices;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart;
using Ultimus.UWF.Home.V3;
using System.Text.RegularExpressions;
using System.Linq;

namespace PR.PRProcess.HK_CPR_FOOD
{
    public partial class NewRequest : System.Web.UI.Page
    {
        public static string user_name = string.Empty;
        protected void AfterLoad()
        {
            //string languageCE = Request.QueryString["lang"];
           
            string procType = Request.QueryString["Type"];
            string Incident = Request.QueryString["Incident"];
            string TaskID = Request.QueryString["TaskID"];
            string UserName = Request.QueryString["UserName"];
            string FORMID = Request.QueryString["FORMID"];
            string ShowType = Request.QueryString["ShowType"];
            //根据buysmart系统的语言切换BPM语言
            //GetLanguage(UserName, languageCE);
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
            string languageCE = GetLanguage(UserName);
            ////多语言显示下拉框
            PersonInfo pr = new PersonInfo();
            pr.Loding(GetCname(user_name.Trim().Replace('/', '\\').ToString()), languageCE);
           
            BindDropdownlistByLanguage(languageCE);

            if (procType.ToUpper().Trim() == "NEWREQUEST")
            {
                ButtonList ButtonList1 = (ButtonList)Page.FindControl("ButtonList1");
                LinkButton btnSaveDraft = (LinkButton)ButtonList1.FindControl("btnSaveDraft");
                btnSaveDraft.Visible = true;
                string pcCode = Request.QueryString["pccode"];
                //string pcCode = "CN077104";
                TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                fld_SITECODE.Text = pcCode;
                string siteName = string.Empty;
                string compCode = string.Empty;
                QuerySiteNameAndCompCode(out siteName, pcCode);

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
                TextBox fld_ASSETTYPE = (TextBox)Page.FindControl("fld_ASSETTYPE");
                fld_ASSETTYPE.Text = "Food";
                HiddenField hdDatetime = (HiddenField)Page.FindControl("hdDatetime");
                hdDatetime.Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
                //HiddenField hdDate = (HiddenField)Page.FindControl("hdDate");
                //hdDate.Value = string.Format("{0}", DateTime.Now.AddDays(2).ToString("yyyy-MM-dd"));

                #region 根据固定资产赋值给一级加签审批人
                //Add By Sylvia At 2020-04-27
                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                string fixedassets_value = fld_FIXEDASSETS.SelectedItem.Value;
                if (fixedassets_value == "01")
                {
                    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                    //固定资产：一级加签审批人
                    string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                    string user = GetUserByEmp(fixedAssetsSignedApproverEmp);
                    string loginName = user.Split(';')[0].ToString();
                    string cnname = user.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user;
                    if (user != ";")
                    {
                        fld_USER_SIGNEDAPPROVER.Text = string.Format("USER:org=CustomOC,user=CustomOC/{0}", loginName);
                        string language = GetLanguage(UserName);
                        if (language == "en-US")
                        {
                            fld_USER_SIGNEDAPPROVERNAME.Text = loginName;
                        }
                        else
                        {
                            fld_USER_SIGNEDAPPROVERNAME.Text = cnname;
                        }
                    }
                }
                else if (fixedassets_value == "02")
                {
                    //固定资产：一级加签审批人
                    string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                    string user = GetUserByEmp(fixedAssetsSignedApproverEmp);
                    string loginName = user.Split(';')[0].ToString();
                    string cnname = user.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user;
                }
                #endregion

                #region 获取代采购默认一级加签审批人并赋值
                //DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                //string customerProcurementSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["CustomerProcurementSignedApproverEmp"];
                //string user_ = GetUserByEmp(customerProcurementSignedApproverEmp);
                //HiddenField hdCustomerProcurementSignedApprover = (HiddenField)Page.FindControl("hdCustomerProcurementSignedApprover");
                //if (fld_APPLYPURPOSE.SelectedItem.Value == "-200")
                //{
                //    //TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                //    //TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                //    ////固定资产：一级加签审批人
                //    //string loginName = user_.Split(';')[0].ToString();
                //    //string cnname = user_.Split(';')[1].ToString();
                //    //HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                //    //hdFixedAssetsSignedApprover.Value = user_;
                //    //if (user_ != ";")
                //    //{
                //    //    fld_USER_SIGNEDAPPROVER.Text = string.Format("USER:org=CustomOC,user=CustomOC/{0}", loginName);
                //    //    string language = GetLanguage(UserName);
                //    //    if (language == "en-US")
                //    //    {
                //    //        fld_USER_SIGNEDAPPROVERNAME.Text = loginName;
                //    //    }
                //    //    else
                //    //    {
                //    //        fld_USER_SIGNEDAPPROVERNAME.Text = cnname;
                //    //    }
                //    //}
                //}
                //else
                //{
                //    hdCustomerProcurementSignedApprover.Value = user_;
                //}
                #endregion

                TextBox fld_ISEDU = (TextBox)Page.FindControl("fld_ISEDU");
                fld_ISEDU.Text = IsEDU(pcCode).ToString() ;

            }
            if (procType.ToUpper().Trim() == "REPORT")
            {
                string rootPath = getRootPath();

                string url = string.Format("{4}/Solution/PR.PRProcess.HK_CPR_FOOD/Form/NewRequest.aspx?ProcessName=HK_CPR_FOOD&StepName=Begin&Incident={0}&TaskID={1}&UserName={2}&Type=MYREQUEST&ServerName=&t=&FORMID={3}&hasformid=0&t=&processStatus=1&ShowType=REPORT", Incident, TaskID, UserName, FORMID, rootPath);
                Response.Redirect(url);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                if (ShowType == "REPORT")
                {
					ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
					LinkButton btnAbortIncident = (LinkButton)buttonList1.FindControl("btnAbortIncident");
                    btnAbortIncident.Attributes.Add("style", "display:none");
                }

            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string loginName = UserName.Replace('/', '\\');
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginName, "");

                #region 根据固定资产赋值给一级加签审批人
                ////Add By Sylvia At 2020-04-27
                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                string fixedassets_value = fld_FIXEDASSETS.SelectedItem.Value;
                if (fixedassets_value == "01")
                {
                    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                    //固定资产：一级加签审批人
                    string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                    string user = GetUserByEmp(fixedAssetsSignedApproverEmp);
                    string approver = user.Split(';')[0].ToString();
                    string cnname = user.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user;
                    if (user != ";")
                    {
                        fld_USER_SIGNEDAPPROVER.Text = string.Format("USER:org=CustomOC,user=CustomOC/{0}", approver);
                        string language = GetLanguage(UserName);
                        if (language == "en-US")
                        {
                            fld_USER_SIGNEDAPPROVERNAME.Text = approver;
                        }
                        else
                        {
                            fld_USER_SIGNEDAPPROVERNAME.Text = cnname;
                        }
                    }
                }
                else if (fixedassets_value == "02")
                {
                    //固定资产：一级加签审批人
                    string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                    string user = GetUserByEmp(fixedAssetsSignedApproverEmp);
                    string approver = user.Split(';')[0].ToString();
                    string cnname = user.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user;
                }
                #endregion

                #region 获取代采购默认一级加签审批人并赋值
                //DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                //string customerProcurementSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["CustomerProcurementSignedApproverEmp"];
                //string user_ = GetUserByEmp(customerProcurementSignedApproverEmp);
                //HiddenField hdCustomerProcurementSignedApprover = (HiddenField)Page.FindControl("hdCustomerProcurementSignedApprover");
                //if (fld_APPLYPURPOSE.SelectedItem.Value == "-200")
                //{
                //    //TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                //    //TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                //    ////固定资产：一级加签审批人
                //    //string approver = user_.Split(';')[0].ToString();
                //    //string cnname = user_.Split(';')[1].ToString();
                //    //HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                //    //hdFixedAssetsSignedApprover.Value = user_;
                //    //if (user_ != ";")
                //    //{
                //    //    fld_USER_SIGNEDAPPROVER.Text = string.Format("USER:org=CustomOC,user=CustomOC/{0}", approver);
                //    //    string language = GetLanguage(UserName);
                //    //    if (language == "en-US")
                //    //    {
                //    //        fld_USER_SIGNEDAPPROVERNAME.Text = approver;
                //    //    }
                //    //    else
                //    //    {
                //    //        fld_USER_SIGNEDAPPROVERNAME.Text = cnname;
                //    //    }
                //    //}
                //}
                //else
                //{
                //    hdCustomerProcurementSignedApprover.Value = user_;
                //}
                #endregion

            }
            //草稿箱
            if (procType.ToUpper().Trim() == "DRAFT")
            {
                #region 根据固定资产赋值给一级加签审批人
                //Add By Sylvia At 2020-04-27
                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                string fixedassets_value = fld_FIXEDASSETS.SelectedItem.Value;
                if (fixedassets_value == "01")
                {
                    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                    //固定资产：一级加签审批人
                    string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                    string user = GetUserByEmp(fixedAssetsSignedApproverEmp);
                    string loginName = user.Split(';')[0].ToString();
                    string cnname = user.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user;
                    if (user != ";")
                    {
                        fld_USER_SIGNEDAPPROVER.Text = string.Format("USER:org=CustomOC,user=CustomOC/{0}", loginName);
                        string language = GetLanguage(UserName);
                        if (language == "en-US")
                        {
                            fld_USER_SIGNEDAPPROVERNAME.Text = loginName;
                        }
                        else
                        {
                            fld_USER_SIGNEDAPPROVERNAME.Text = cnname;
                        }
                    }
                }
                else if (fixedassets_value == "02")
                {
                    //固定资产：一级加签审批人
                    string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                    string user = GetUserByEmp(fixedAssetsSignedApproverEmp);
                    string loginName = user.Split(';')[0].ToString();
                    string cnname = user.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user;
                }
                #endregion

                #region 获取代采购默认一级加签审批人并赋值
                //DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                //string customerProcurementSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["CustomerProcurementSignedApproverEmp"];
                //string user_ = GetUserByEmp(customerProcurementSignedApproverEmp);
                //HiddenField hdCustomerProcurementSignedApprover = (HiddenField)Page.FindControl("hdCustomerProcurementSignedApprover");
                //if (fld_APPLYPURPOSE.SelectedItem.Value == "2")
                //{
                //    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                //    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                //    //固定资产：一级加签审批人
                //    string loginName = user_.Split(';')[0].ToString();
                //    string cnname = user_.Split(';')[1].ToString();
                //    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                //    hdFixedAssetsSignedApprover.Value = user_;
                //    if (user_ != ";")
                //    {
                //        fld_USER_SIGNEDAPPROVER.Text = string.Format("USER:org=CustomOC,user=CustomOC/{0}", loginName);
                //        string language = GetLanguage(UserName);
                //        if (language == "en-US")
                //        {
                //            fld_USER_SIGNEDAPPROVERNAME.Text = loginName;
                //        }
                //        else
                //        {
                //            fld_USER_SIGNEDAPPROVERNAME.Text = cnname;
                //        }
                //    }
                //}
                //else
                //{
                //    hdCustomerProcurementSignedApprover.Value = user_;
                //}
                #endregion
            }
        }

        public static string  GetCname(string userName)
        {
           
            string loginName = userName.Trim().Replace('/', '\\').Split('\\')[1];
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT USERNAME FROM ORG_USER WHERE LOGINNAME='" + loginName + "' ");
            DataTable db = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return db.Rows[0]["USERNAME"].ToString();
        }

        /// <summary>
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

        private const int LOCALE_SYSTEM_DEFAULT = 0x0800;
        private const int LCMAP_SIMPLIFIED_CHINESE = 0x02000000;
        private const int LCMAP_TRADITIONAL_CHINESE = 0x04000000;
        [DllImport("kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern int LCMapString(int Locale, int dwMapFlags, string lpSrcStr, int cchSrc, [Out] string lpDestStr, int cchDest);
        // <summary>
        /// 将字符转换为繁体中文
        /// </summary>
        /// <param name="source">输入要转换的字符串</param>
        /// <returns>转换完成后的字符串</returns>
        public static string ToTraditional(string source)
        {
            String target = new String(' ', source.Length);
            int ret = LCMapString(LOCALE_SYSTEM_DEFAULT, LCMAP_TRADITIONAL_CHINESE, source, source.Length, target, source.Length);
            return target;
        }
        /// <summary>
        /// 根据PCCode查询分店名称及公司编号
        /// </summary>
        /// <param name="siteName"></param>
        /// <param name="compCode"></param>
        /// <param name="pcCode"></param>
        public static void QuerySiteNameAndCompCode(out string siteName, string pcCode)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");
            sSql.AppendFormat("select cnname,enname,companycode from [dbo].[SODEXO_ProfitCenters] where code='{0}'", pcCode);
            DataTable dt = db.ExecuteDataTable(sSql.ToString());
            if (dt.Rows.Count == 1)
            {
               
                DataRow dr = dt.Rows[0];

                //siteName = Strings.StrConv(dr["cnname"].ToString(), VbStrConv.TraditionalChinese, 0);
                siteName = ToTraditional(dr["cnname"].ToString());

            }
            else
            {
                siteName = "";
               
            }

        }

        private void BindDropdownlistByLanguage(string language)
        {
            //string language = GetLanguage(userName);
            //string language = GetLanguageByUserName(userName);
            //language = language.Split(':')[1];
            //language = language.Split('"')[1];
            //[{"LANGUAGE":"en-US"}]
            if (language == "en-US")
            {
                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");

                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");

                string applypurpose = fld_APPLYPURPOSE.SelectedItem.Text;
                string suppliertype = fld_SUPPLIERTYPE.SelectedItem.Text;

                string fixedassets = fld_FIXEDASSETS.SelectedItem.Text;


                if (applypurpose == "")
                {
                    //申请目的
                    BindApplyPurpose();
                }
                if (suppliertype == "")
                {
                    //采购类型
                    BindOrderType();
                }

                if (fixedassets == "是")
                {
                    //是否是固定资产
                    BindFixedAssets();
                }

            }
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
        /// 申请目的
        /// </summary>
        private void BindApplyPurpose()
        {
            DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
            DataTable PRPurpose = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT Code,ENName FROM [dbo].[SODEXO_t_PRPurpose] WHERE [StateCode]=1");
            fld_APPLYPURPOSE.Items.Clear();
            fld_APPLYPURPOSE.DataSource = PRPurpose;
            fld_APPLYPURPOSE.DataTextField = "ENName";
            fld_APPLYPURPOSE.DataValueField = "Code";
            fld_APPLYPURPOSE.DataBind();
            fld_APPLYPURPOSE.Items.Insert(0, new ListItem("", ""));

            //SELECT Code,ENName FROM [dbo].[SODEXO_t_PRPurpose] WHERE [StateCode]=1
        }

        /// <summary>
        /// 采购类型
        /// </summary>
        private void BindOrderType()
        {
            DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
            DataTable PRPurpose = DataAccess.Instance("BizDB").ExecuteDataTable("select code,en_value from [dbo].[SODEXO_HK_OrderType]");
            fld_SUPPLIERTYPE.Items.Clear();
            fld_SUPPLIERTYPE.DataSource = PRPurpose;
            fld_SUPPLIERTYPE.DataTextField = "en_value";
            fld_SUPPLIERTYPE.DataValueField = "Code";
            fld_SUPPLIERTYPE.DataBind();
            fld_SUPPLIERTYPE.Items.Insert(0, new ListItem("", ""));

            //SELECT Code,ENName FROM [dbo].[SODEXO_t_PRPurpose] WHERE [StateCode]=1
        }

      

        /// <summary>
        /// 是否是固定资产
        /// </summary>
        private void BindFixedAssets()
        {
            RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
            fld_FIXEDASSETS.Items.Clear();
            fld_FIXEDASSETS.Items.Add(new ListItem("Yes", "01"));
            fld_FIXEDASSETS.Items.Add(new ListItem("No", "02"));
            fld_FIXEDASSETS.Items[0].Selected = true;
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

                string[] articleArr = CheckIsOneTimeUsingArticleUseTimes();
                string[] articleItemArr = checkArticleCode();
                string ArticleName = CheckOrderQuantity();
                if (articleArr.Length > 0 && articleArr[0] != null)
                {
                    StringBuilder articleName = new StringBuilder();
                    foreach (var item in articleArr)
                    {
                        articleName.Append(item + ";");
                    }
                    string arName = articleName.ToString().Substring(0, articleName.ToString().Length - 1);

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('您所添加的物料{" + arName + "}为已被使用的一次性物品，无法继续添加该物料，请重新选择其它物料！The article you added is a disposable item that has been used. You cannot continue to add this article. Please choose another article!'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);

                    e.Cancel = true;
                }
                else if (articleItemArr.Length > 0 && articleItemArr[0] != null)
                {
                    StringBuilder article_Name = new StringBuilder();
                    foreach (var item in articleItemArr)
                    {
                        if (!string.IsNullOrEmpty(item))
                        {
                            article_Name.Append(item + ";");
                        }
                    }
                    string ar_Name = article_Name.ToString().Substring(0, article_Name.ToString().Length - 1);

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('您所添加的物料{" + ar_Name + "}存在重复项，请手动删除后再提交！\\nThere are duplicates in the material you added. Please delete them manually before submitting!'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);

                    e.Cancel = true;
                }
                else if (ArticleName != null)
                {
                    string msg = string.Empty;
                    string msg_cn = "以下物料數量不能為零";
                    string msg_en = "The following article quantities cannot be zero";
                    msg = string.Format("{0}\\n{1}\\n{2}", msg_cn, msg_en, ArticleName);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                    e.Cancel = true;
                }
                else
                {
                    //#region 客户代采购无附件无法进行提交


                    //DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
              
                    //string applypurpose_value = fld_APPLYPURPOSE.SelectedItem.Value;
                    //if (applypurpose_value == "2") 
                    //{
                    //    UserInfo UserInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                    //    IAttachment logic = ServiceContainer.Instance().GetService<IAttachment>();
                    //    //DataTable dt_supplier = new DataTable();
                    //    DataTable dt_approver = new DataTable();
                    //    //dt_supplier = logic.GetAttachmentsByFormID(UserInfo1.FormID, "SUPPLIER");
                    //    dt_approver = logic.GetAttachmentsByFormID(UserInfo1.FormID, "");
                    //    if (dt_approver.Rows.Count <= 0)
                    //    {
                    //        string msg = string.Empty;
                    //        string msg_cn = "请至少上传一个附件";
                    //        msg_cn=ToTraditional(msg_cn);
                    //        string msg_en = "Please upload at least one attachment";
                    //        msg = string.Format("{0}\\n{1}", msg_cn, msg_en);
                    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                    //        e.Cancel = true;
                    //    }
                    //}

                    //#endregion

                    HiddenField SUPPLIERTYPE = (HiddenField)Page.FindControl("SUPPLIERTYPE");
                    HiddenField SUPPLIERTYPETXT = (HiddenField)Page.FindControl("SUPPLIERTYPETXT");

                    DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
                    //DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                    TextBox fld_ASSETTYPE = (TextBox)Page.FindControl("fld_ASSETTYPE");

                    //fld_SUPPLIERTYPE.SelectedItem.Value = SUPPLIERTYPE.Value;
                    //fld_SUPPLIERTYPE.SelectedItem.Text = SUPPLIERTYPETXT.Value;
                    SUPPLIERTYPE.Value = fld_SUPPLIERTYPE.SelectedItem.Value;
                    SUPPLIERTYPETXT.Value = fld_SUPPLIERTYPE.SelectedItem.Text;

                    TextBox fld_APPLYPURPOSETXT = (TextBox)Page.FindControl("fld_APPLYPURPOSETXT");
                    TextBox fld_SUPPLIERTYPETXT = (TextBox)Page.FindControl("fld_SUPPLIERTYPETXT");
                    TextBox fld_ASSETTYPETXT = (TextBox)Page.FindControl("fld_ASSETTYPETXT");

                    fld_APPLYPURPOSETXT.Text = fld_APPLYPURPOSE.SelectedItem.Text;
                    fld_SUPPLIERTYPETXT.Text = fld_SUPPLIERTYPE.SelectedItem.Text;
                    fld_ASSETTYPE.Text = "Food";

                    fld_ASSETTYPETXT.Text = "食品";
                    UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;

                    TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                    TextBox fld_SITENAME = (TextBox)Page.FindControl("fld_SITENAME");
                    //SumAmount
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
                    fld_APPROVE.Text = str_APPROVEDATE;
                    fld_DELIVERY.Text = str_DELIVERYDATE;


                    //将千分位数值转化成字符串类型数据
                    //string fld_amount=Amount(fld_AMOUNT.Text);
                    UserInfo.Summary = string.Format("{0}({1})-合计金额({2})", fld_SITENAME.Text, fld_SITECODE.Text, fld_AMOUNT.Text);



                    if (fld_SUPPLIERTYPE.SelectedItem.Value != "9" || fld_SUPPLIERTYPE.SelectedItem.Text != "授權供應商" || fld_SUPPLIERTYPE.SelectedItem.Text != "Authorized Supplier")
                    {
                        AddArticleRepeater();
                    }

                    AssignmentSignedApprover();
                    TextBox fld_PURCHASINGAGENT = (TextBox)Page.FindControl("fld_PURCHASINGAGENT");
                    TextBox fld_ISEDU = (TextBox)Page.FindControl("fld_ISEDU");
                    TextBox fld_ISFIXEDASSETS = (TextBox)Page.FindControl("fld_ISFIXEDASSETS");
                    RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                    fld_ISFIXEDASSETS.Text = fld_FIXEDASSETS.SelectedItem.Value;
                    //if (fld_APPLYPURPOSE.SelectedItem.Value == "2")
                    //{
                    //    fld_PURCHASINGAGENT.Text = "1";
                    //}
                    //else
                    //{
                    //    fld_PURCHASINGAGENT.Text = "0";
                    //}
                }
                if (Convert.ToDecimal(this.fld_AMOUNT.Text) >= 300000)
                {
                    string value = this.fld_APPREMARK.Text;
                    bool result = Regex.Matches(value, "[a-zA-Z]").Count > 0;
                    if (!result)
                    {
                        string msg = "該采購申請需中國區主席審批，備註欄中請提供采購收入或利潤，並請包含對應英文描述";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                        e.Cancel = true;
                    }
                }

                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", " document.getElementById('ButtonList1_btnSend').style.display = 'none';", true);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            //获取所有的物料明细信息


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
                if (fld_SUPPLIERTYPE.SelectedItem.Value == "9" || fld_SUPPLIERTYPE.SelectedItem.Text == "授權供應商" || fld_SUPPLIERTYPE.SelectedItem.Text == "Authorized Supplier")
                {
                    #region 提交成功之后更改一次性物料使用次数
                    TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                    TextBox fld_SUPPLIERCODE = (TextBox)Page.FindControl("fld_SUPPLIERCODE");
                    UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
                    Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_FOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_FOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
                    IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                    DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_HK_CPR_FOOD_Items, UserInfo.FormID);
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

        /// <summary>
        /// 同步历史采购数据
        /// </summary>
        private void AddArticleRepeater()
        {
            TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");//分店编号ok
            UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
            Label read_APPLICANTCODE = (Label)UserInfo.FindControl("read_APPLICANTCODE");//工号ok

            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_FOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_FOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable dt2 = _workflow.GetDetailData(UserInfo, fld_detail_PROC_HK_CPR_FOOD_Items, UserInfo.FormID);

            foreach (DataRow item in dt2.Rows)
            {
                string ArticleName = item["ARTICLENAME"].ToString();
                string ArticleFamily = item["SUBSUBFAMILYCODE"].ToString();
                string SiteCode = fld_SITECODE.Text;
                string UOM_PurUnit = item["ORDERUNITVALUE"].ToString();
                decimal UOM_Pur2InvRate = Convert.ToDecimal(item["CONVERSION"].ToString());
                string UOM_InvUnit = item["UNITVALUE"].ToString();
                decimal UOM_Inv2UseRate = Convert.ToDecimal(item["STOCK"].ToString());
                string UOM_UseUnit = item["CONSUMPTIONUNITVALUE"].ToString();
                decimal Gross_weight = Convert.ToDecimal(item["GROSSWEIGHT"].ToString());
                decimal NetVolume = Convert.ToDecimal(item["NETVOMULE"].ToString());
                string NetVolumeUnit = item["NETVOMULEUNIT"].ToString();
                string CreateDesc = read_APPLICANTCODE.Text;

                bool boolArticle = distinctArticle(ArticleName, ArticleFamily, SiteCode, UOM_PurUnit, UOM_Pur2InvRate, UOM_InvUnit, UOM_Inv2UseRate, UOM_UseUnit, Gross_weight, NetVolume, NetVolumeUnit, CreateDesc);

                if (!boolArticle)
                {
                    StringBuilder sSql = new StringBuilder();
                    DataAccess db = DataAccess.Instance("BizDB");

                    sSql.Append(@"
INSERT INTO [dbo].[SODEXO_Article]
([ID],[ArticleCode],[ArticleName],[ArticleFamily],[SiteCode],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[CreateDesc],[CreateDate]) 
VALUES 
(@ID,@ArticleCode,@ArticleName,@ArticleFamily,@SiteCode,@UOM_PurUnit,@UOM_Pur2InvRate,@UOM_InvUnit,@UOM_Inv2UseRate,
@UOM_UseUnit,@Gross_weight,@NetVolume,@NetVolumeUnit,@CreateDesc,@CreateDate)");

                    using (DbCommand cmd = db.CreateCommand())
                    {
                        cmd.CommandText = sSql.ToString();
                        cmd.CommandType = CommandType.Text;
                        string id = Guid.NewGuid().ToString();

                        db.AddInParameter(cmd, "@ID", DbType.String, id);
                        db.AddInParameter(cmd, "@ArticleCode", DbType.String, id);
                        db.AddInParameter(cmd, "@ArticleName", DbType.String, ArticleName);
                        db.AddInParameter(cmd, "@ArticleFamily", DbType.String, ArticleFamily);
                        db.AddInParameter(cmd, "@SiteCode", DbType.String, SiteCode);
                        db.AddInParameter(cmd, "@UOM_PurUnit", DbType.String, UOM_PurUnit);
                        db.AddInParameter(cmd, "@UOM_Pur2InvRate", DbType.Decimal, UOM_Pur2InvRate);
                        db.AddInParameter(cmd, "@UOM_InvUnit", DbType.String, UOM_InvUnit);
                        db.AddInParameter(cmd, "@UOM_Inv2UseRate", DbType.Decimal, UOM_Inv2UseRate);
                        db.AddInParameter(cmd, "@UOM_UseUnit", DbType.String, UOM_UseUnit);
                        db.AddInParameter(cmd, "@Gross_weight", DbType.Decimal, Gross_weight);
                        db.AddInParameter(cmd, "@NetVolume", DbType.Decimal, NetVolume);
                        db.AddInParameter(cmd, "@NetVolumeUnit", DbType.String, NetVolumeUnit);
                        db.AddInParameter(cmd, "@CreateDesc", DbType.String, CreateDesc);
                        db.AddInParameter(cmd, "@CreateDate", DbType.DateTime, DateTime.Now);
                        db.ExecuteNonQuery(cmd);
                    }
                }
            }
        }

        /// <summary>
        /// 查询是否存在相同数据
        /// </summary>
        private bool distinctArticle(string ArticleName, string ArticleFamily, string SiteCode, string UOM_PurUnit, decimal UOM_Pur2InvRate, string UOM_InvUnit, decimal UOM_Inv2UseRate, string UOM_UseUnit, decimal Gross_weight, decimal NetVolume, string NetVolumeUnit, string CreateDesc)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");

            sSql.AppendFormat(@"SELECT ID FROM [dbo].[SODEXO_Article] WHERE [ArticleName]=N'{0}' AND [ArticleFamily]='{1}' AND [SiteCode]='{2}' AND [UOM_PurUnit]='{3}' AND [UOM_Pur2InvRate]={4} AND [UOM_InvUnit]='{5}' AND [UOM_Inv2UseRate]={6} AND [UOM_UseUnit]='{7}' AND [Gross_weight]={8} AND [NetVolume]={9} AND [NetVolumeUnit]='{10}' AND [CreateDesc]='{11}'", ArticleName, ArticleFamily, SiteCode, UOM_PurUnit, UOM_Pur2InvRate, UOM_InvUnit, UOM_Inv2UseRate, UOM_UseUnit, Gross_weight, NetVolume, NetVolumeUnit, CreateDesc);

            DataSet setArticle = db.ExecuteDataSet(sSql.ToString());
            if (setArticle.Tables[0].Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 是否加签
        /// </summary>
        private void AssignmentSignedApprover()
        {
            TextBox fld_SIGNEDAPPROVERNUMBER = (TextBox)Page.FindControl("fld_SIGNEDAPPROVERNUMBER");
            string SIGNEDAPPROVERNUMBER = fld_SIGNEDAPPROVERNUMBER.Text;

            bool result = JudgmentSignedApprover();
            bool result2 = JudgmentSignedApprover2();
            bool result3 = JudgmentSignedApprover3();

            if (result)
            {
                if (result2)
                {
                    if (result3)
                    {
                        fld_SIGNEDAPPROVERNUMBER.Text = "3";
                    }
                    else
                    {
                        fld_SIGNEDAPPROVERNUMBER.Text = "2";
                    }
                }
                else
                {
                    fld_SIGNEDAPPROVERNUMBER.Text = "1";
                }
            }
            else
            {
                fld_SIGNEDAPPROVERNUMBER.Text = "0";
            }
        }
        private bool JudgmentSignedApprover()
        {
            TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
            string USER_SIGNEDAPPROVER = fld_USER_SIGNEDAPPROVER.Text;

            if (USER_SIGNEDAPPROVER != "")
            {
                if (USER_SIGNEDAPPROVER.StartsWith("USER:org=CustomOC,user=CustomOC/"))
                {
                    return true;
                }
                else if (USER_SIGNEDAPPROVER.Contains("\\"))
                {
                    string domain = USER_SIGNEDAPPROVER.Split('\\')[0];
                    string loginName = USER_SIGNEDAPPROVER.Split('\\')[1];
                    fld_USER_SIGNEDAPPROVER.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                    return true;
                }
                else
                {
                    string domain = "CustomOC";
                    string loginName = USER_SIGNEDAPPROVER;
                    fld_USER_SIGNEDAPPROVER.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                    return true;
                }
            }
            else
            {
                return false;
            }
        }

        private bool JudgmentSignedApprover2()
        {
            TextBox fld_USER_SIGNEDAPPROVER2 = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER2");
            string USER_SIGNEDAPPROVER2 = fld_USER_SIGNEDAPPROVER2.Text;

            if (USER_SIGNEDAPPROVER2 != "")
            {
                if (USER_SIGNEDAPPROVER2.StartsWith("USER:org=CustomOC,user=CustomOC/"))
                {
                    return true;
                }
                else if (USER_SIGNEDAPPROVER2.Contains("\\"))
                {
                    string domain = USER_SIGNEDAPPROVER2.Split('\\')[0];
                    string loginName = USER_SIGNEDAPPROVER2.Split('\\')[1];
                    fld_USER_SIGNEDAPPROVER2.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                    return true;
                }
                else
                {
                    string domain = "CustomOC";
                    string loginName = USER_SIGNEDAPPROVER2;
                    fld_USER_SIGNEDAPPROVER2.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                    return true;
                }
            }
            else
            {
                return false;
            }
        }

        private bool JudgmentSignedApprover3()
        {
            TextBox fld_USER_SIGNEDAPPROVER3 = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER3");
            string USER_SIGNEDAPPROVER3 = fld_USER_SIGNEDAPPROVER3.Text;

            if (USER_SIGNEDAPPROVER3 != "")
            {
                if (USER_SIGNEDAPPROVER3.StartsWith("USER:org=CustomOC,user=CustomOC/"))
                {
                    return true;
                }
                else if (USER_SIGNEDAPPROVER3.Contains("\\"))
                {
                    string domain = USER_SIGNEDAPPROVER3.Split('\\')[0];
                    string loginName = USER_SIGNEDAPPROVER3.Split('\\')[1];
                    fld_USER_SIGNEDAPPROVER3.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                    return true;
                }
                else
                {
                    string domain = "CustomOC";
                    string loginName = USER_SIGNEDAPPROVER3;
                    fld_USER_SIGNEDAPPROVER3.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                    return true;
                }
            }
            else
            {
                return false;
            }
        }

      

     

        /// <summary>
        /// 判断已添加的物料是否为已被使用的一次性物料
        /// </summary>
        /// <returns></returns>
        private string[] CheckIsOneTimeUsingArticleUseTimes()
        {
            TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
            TextBox fld_SUPPLIERCODE = (TextBox)Page.FindControl("fld_SUPPLIERCODE");
            UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_FOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_FOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_HK_CPR_FOOD_Items, UserInfo.FormID);
            string[] resArray = new string[Article.Rows.Count];

            DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
            if (fld_SUPPLIERTYPE.SelectedItem.Value == "9" || fld_SUPPLIERTYPE.SelectedItem.Text == "授權供應商" || fld_SUPPLIERTYPE.SelectedItem.Text == "Authorized Supplier")
            {
                int i = 0;
                foreach (DataRow item in Article.Rows)
                {
                    string ArticleCode = item["ARTICLECODE"].ToString();
                    string ArticleName = item["ARTICLENAME"].ToString();
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
                        if (IsOneTimeUsing == "1" && UseTimes == "1")
                        {
                            //resArray[i] = ArticleName;
                            resArray[i] = string.Format(@"{0}({1})", ArticleName, ArticleCode);
                        }
                    }

                    i++;
                }
            }
            return resArray;
        }

        private string CheckOrderQuantity()
        {
            string ArticleName = null;
            UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_FOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_FOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_HK_CPR_FOOD_Items, UserInfo.FormID);
            foreach (DataRow item in Article.Rows)
            {
                string OrderQuantity = item["OrderQuantity"].ToString();
                if (OrderQuantity == "0")
                {
                    ArticleName += string.Format("{0},", item["ARTICLENAME"].ToString());
                }
            }
            if (ArticleName != null)
            {
                return ArticleName = ArticleName.TrimEnd(',');

            }
            else
            {
                return null;
            }
        }
        /// <summary>
        /// 对已经存在的物料进行articlecode的更新
        /// </summary>
        private void updateArticle()
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");
            sSql.Append("SELECT * FROM SODEXO_Article WHERE SupplierCode IS NULL");
            DataTable dt = db.ExecuteDataTable(sSql.ToString());
            foreach (DataRow item in dt.Rows)
            {
                var id = item["ID"].ToString();
                sSql.Length = 0;
                sSql.AppendFormat(@"UPDATE SODEXO_Article SET ArticleCode='{0}' WHERE ID='{0}'", id);
                db.ExecuteNonQuery(sSql.ToString());
            }
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
                    msg = ToTraditional(msg);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + msg + "');", true);
                }

                return loginname + ";" + cnname;
            }
            catch (Exception)
            {

                throw;
            }
        }

        /// <summary>
        /// Add By Sylvia At 2020-08-13
        /// 在提交之前检查是否添加了重复的articlecode物料
        /// </summary>
        /// <returns></returns>
        private string[] checkArticleCode()
        {
            UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_FOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_FOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_HK_CPR_FOOD_Items, UserInfo.FormID);
            string[] resArray = new string[Article.Rows.Count];

            DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
           
                for (int i = 0; i < Article.Rows.Count; i++)
                {
                    string articlename = Article.Rows[i]["ARTICLENAME"].ToString();
                    string orderunit = Article.Rows[i]["ORDERUNITVALUE"].ToString();
                    string unit = Article.Rows[i]["UNITVALUE"].ToString();
                    string consumptionunit = Article.Rows[i]["CONSUMPTIONUNITVALUE"].ToString();
                    string conversion = Article.Rows[i]["CONVERSION"].ToString();
                    string stock = Article.Rows[i]["STOCK"].ToString();
                    string subsubfamilycode = Article.Rows[i]["SUBSUBFAMILYCODE"].ToString();
                    int n = 0;
                    for (int j = i + 1; j < Article.Rows.Count; j++)
                    {
                        if (i != j)
                        {
                            string a_articlename = Article.Rows[j]["ARTICLENAME"].ToString();
                            string a_orderunit = Article.Rows[j]["ORDERUNITVALUE"].ToString();
                            string a_unit = Article.Rows[j]["UNITVALUE"].ToString();
                            string a_consumptionunit = Article.Rows[j]["CONSUMPTIONUNITVALUE"].ToString();
                            string a_conversion = Article.Rows[j]["CONVERSION"].ToString();
                            string a_stock = Article.Rows[j]["STOCK"].ToString();
                            string a_subsubfamilycode = Article.Rows[j]["SUBSUBFAMILYCODE"].ToString();
                            if (articlename == a_articlename && orderunit == a_orderunit && unit == a_unit && consumptionunit == a_consumptionunit && conversion == a_conversion && stock == a_stock && subsubfamilycode == a_subsubfamilycode)
                            {
                                resArray[n] = string.Format(@"{0}({1}|{2}|{3}|{4}|{5}|{6})", articlename, orderunit, unit, consumptionunit, conversion, stock, subsubfamilycode);
                                n++;
                            }
                        }
                    }
                }
            

            return resArray;
        }

        private int IsEDU(String pccode)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = new DataTable();
            sSql.Append(@"
  WITH locs(parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail)
AS
(
SELECT parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail FROM SODEXO_HK_ORGANIZATION WHERE orgcode=@orgcode
UNION ALL
SELECT A.parentOrgCode,A.parentOrgName,A.orgCode,A.orgName,A.orgType,A.leaderNumber,A.leaderName,A.orgStartDate,A.orgEndDate,A.siteCode,A.companyCode,A.isDeploy,A.deployDate,A.modifyDate,A.orgAddress,A.siteEmail,A.leaderContact,A.leaderEmail FROM SODEXO_HK_ORGANIZATION A,locs B WHERE
A.orgCode = B.PARENTORGCODE
)
select  parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail from locs 
");
            using (DbCommand cmd = db.CreateCommand())
            {
                cmd.CommandText = sSql.ToString();
                cmd.CommandType = CommandType.Text;

                db.AddInParameter(cmd, "@orgcode", DbType.String, pccode);
                dt = db.ExecuteDataTable(cmd);
            }
            string ndEdu = System.Web.Configuration.WebConfigurationManager.AppSettings["NdEdu"];
            string ndEduName = System.Web.Configuration.WebConfigurationManager.AppSettings["NdEduName"];
            var dd = dt.AsEnumerable().Where(x => x["orgCode"].ToString() == ndEdu&& x["orgName"].ToString()== ndEduName);
            if (dd.Any()) return 1;
            return 0;

        }


    }
}