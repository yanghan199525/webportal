//using System;
//using System.Collections.Generic;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.HtmlControls;
//using System.Text;
//using System.Data;
//using Ultimus.UWF.Form.ProcessControl.V3;
//using MyLib;
//using Ultimus.UWF.Workflow.Logic;
//using Ultimus.UWF.Form.Interface;
//using Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic;
//using System.Data.Common;
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
using System.Globalization;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.OrgChart;
using Ultimus.UWF.Home.V3;
using System.Web.Script.Serialization;
using System.Web.Services;
using MyLib.Json;
using System.Text.RegularExpressions;
using System.Linq;
using System.IO;

namespace PR.PRProcess.MCPR_SERVICE
{
    public partial class NewRequest : System.Web.UI.Page
    {
        public static string user_name = string.Empty;
        public static string CprType = string.Empty;
        public static string CprArticle = string.Empty;
        public static string SiteCode = string.Empty;
        public static string supplierCode = string.Empty;
        public static string supplierName = string.Empty;
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
                if (!string.IsNullOrWhiteSpace(CprArticle))
                {
                    List<Article> list = FromJSON<List<Article>>(CprArticle);
                    DataTable dt = SelectSupplier(list[0].ArticleCode, list[0].RFQ_Number);
                    this.fld_SUPPLIERCODE.Text = dt.Rows[0]["SupplierCode"].ToString();
                    this.fld_SUPPLIERNAME.Text = dt.Rows[0]["SupplierName"].ToString();
                }
                ButtonList ButtonList1 = (ButtonList)Page.FindControl("ButtonList1");
                LinkButton btnSaveDraft = (LinkButton)ButtonList1.FindControl("btnSaveDraft");
                //btnSaveDraft.Attributes.Add("style", "display:block");
                btnSaveDraft.Visible = true;
                string pcCode = Request.QueryString["pccode"];
                //string pcCode = "CN001601";
                TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                //pcCode = "CN042601";
                //pcCode = "CN001601";
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
                    TextBox fld_PCCOMPCODE = (TextBox)Page.FindControl("fld_PCCOMPCODE");
                    fld_SITENAME.Text = siteName;
                    fld_PCCOMPCODE.Text = compCode;
                }
                TextBox fld_ASSETTYPE = (TextBox)Page.FindControl("fld_ASSETTYPE");
                fld_ASSETTYPE.Text = "Services";
                //HiddenField hdDate = (HiddenField)Page.FindControl("hdDate");
                //hdDate.Value = string.Format("{0}", DateTime.Now.AddDays(2).ToString("yyyy-MM-dd"));

                HiddenField hdDatetime = (HiddenField)Page.FindControl("hdDatetime");
                hdDatetime.Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
                HiddenField hdFinshDate = (HiddenField)Page.FindControl("hdFinshDate");
                hdFinshDate.Value = DateTime.Now.ToString("yyyy-MM-dd");

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
                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                string customerProcurementSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["CustomerProcurementSignedApproverEmp"];
                string user_ = GetUserByEmp(customerProcurementSignedApproverEmp);
                HiddenField hdCustomerProcurementSignedApprover = (HiddenField)Page.FindControl("hdCustomerProcurementSignedApprover");
                if (fld_APPLYPURPOSE.SelectedItem.Value == "2")
                {
                    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                    //固定资产：一级加签审批人
                    string loginName = user_.Split(';')[0].ToString();
                    string cnname = user_.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user_;
                    if (user_ != ";")
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
                else
                {
                    hdCustomerProcurementSignedApprover.Value = user_;
                }
                #endregion

                TextBox fld_ISCOR = (TextBox)Page.FindControl("fld_ISCOR");
                var COR = IsCOR(pcCode);
                var isCOR = COR.Result;
                fld_ISCOR.Text = isCOR.ToString();
                if (isCOR == 1)
                {
                    TextBox fld_ISCORName = (TextBox)Page.FindControl("fld_ISCORName");
                    fld_ISCORName.Text = COR.OrgName;// ISCORName(pcCode).ToString();
                }
            }
            if (procType.ToUpper().Trim() == "REPORT")
            {
                string rootPath = getRootPath();

                string url = string.Format("{4}/Solution/PR.PRProcess.MCPR_SERVICE/Form/NewRequest.aspx?ProcessName=MCPR_SERVICE&StepName=Begin&Incident={0}&TaskID={1}&UserName={2}&Type=MYREQUEST&ServerName=&t=&FORMID={3}&hasformid=0&t=&processStatus=1&ShowType=REPORT", Incident, TaskID, UserName, FORMID, rootPath);
                Response.Redirect(url);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                if (ShowType == "REPORT")
                {
                    ButtonList ButtonList1 = (ButtonList)Page.FindControl("ButtonList1");
                    LinkButton btnAbortIncident = (LinkButton)ButtonList1.FindControl("btnAbortIncident");
                    btnAbortIncident.Attributes.Add("style", "display:none");
                }

            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string loginName = UserName.Replace('/', '\\');
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginName, "");

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
                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                string customerProcurementSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["CustomerProcurementSignedApproverEmp"];
                string user_ = GetUserByEmp(customerProcurementSignedApproverEmp);
                HiddenField hdCustomerProcurementSignedApprover = (HiddenField)Page.FindControl("hdCustomerProcurementSignedApprover");
                if (fld_APPLYPURPOSE.SelectedItem.Value == "2")
                {
                    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                    //固定资产：一级加签审批人
                    string approver = user_.Split(';')[0].ToString();
                    string cnname = user_.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user_;
                    if (user_ != ";")
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
                else
                {
                    hdCustomerProcurementSignedApprover.Value = user_;
                }
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
                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                string customerProcurementSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["CustomerProcurementSignedApproverEmp"];
                string user_ = GetUserByEmp(customerProcurementSignedApproverEmp);
                HiddenField hdCustomerProcurementSignedApprover = (HiddenField)Page.FindControl("hdCustomerProcurementSignedApprover");

                if (fld_APPLYPURPOSE.SelectedItem.Value == "2")
                {
                    TextBox fld_USER_SIGNEDAPPROVER = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVER");
                    TextBox fld_USER_SIGNEDAPPROVERNAME = (TextBox)Page.FindControl("fld_USER_SIGNEDAPPROVERNAME");
                    //固定资产：一级加签审批人
                    string loginName = user_.Split(';')[0].ToString();
                    string cnname = user_.Split(';')[1].ToString();
                    HiddenField hdFixedAssetsSignedApprover = (HiddenField)Page.FindControl("hdFixedAssetsSignedApprover");
                    hdFixedAssetsSignedApprover.Value = user_;
                    if (user_ != ";")
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
                else
                {
                    hdCustomerProcurementSignedApprover.Value = user_;
                }
                #endregion
            }
            HiddenField hiddenIncident = (HiddenField)Page.FindControl("HiddenIncident");
            hiddenIncident.Value = Incident;
            if (Incident == "-2")
            {

                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                RadioButtonList fld_SHOWREMARK = (RadioButtonList)Page.FindControl("fld_SHOWREMARK");
                // add hanyang time 2021/8/19
                RadioButtonList fld_IsPrePaid = (RadioButtonList)Page.FindControl("fld_IsPrePaid");

                TextBox fld_DELIVERYDATE = (TextBox)Page.FindControl("fld_DELIVERYDATE");
                // TextBox fld_ServiceEstimatedFinishTime = (TextBox)Page.FindControl("fld_ServiceEstimatedFinishTime");
                HtmlButton btnAddCPRItems = (HtmlButton)Page.FindControl("btnAddCPRItems");
                fld_APPLYPURPOSE.Enabled = false;
                fld_FIXEDASSETS.Enabled = false;
                fld_SHOWREMARK.Enabled = false;
                fld_IsPrePaid.Enabled = false;
                btnAddCPRItems.Visible = false;

                //TextBox fld_AMOUNT = (TextBox)Page.FindControl("fld_AMOUNT");
                //TextBox fld_ORIGINALAMOUNT = (TextBox)Page.FindControl("fld_ORIGINALAMOUNT");
                //fld_ORIGINALAMOUNT.Text = fld_AMOUNT.Text;
                // fld_DELIVERYDATE.Enabled = false;
                //fld_ServiceEstimatedFinishTime.Enabled = false;

                // ButtonList1_btnSaveDraft

            }
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
                string[] articleArr = CheckIsOneTimeUsingArticleUseTimes();
                string[] articleItemArr = checkArticleCode();
                string ArticleName = CheckOrderQuantity();
                decimal AuthorizedAmount = Convert.ToDecimal(System.Web.Configuration.WebConfigurationManager.AppSettings["AuthorizedAmount"].ToString());
                decimal UnauthorizedAmount = Convert.ToDecimal(System.Web.Configuration.WebConfigurationManager.AppSettings["UnauthorizedAmount"].ToString());
                if (articleArr.Length > 0 && articleArr[0] != null)
                {
                    StringBuilder articleName = new StringBuilder();
                    foreach (var item in articleArr)
                    {
                        articleName.Append(item + ";");
                    }
                    string arName = articleName.ToString().Substring(0, articleName.ToString().Length - 1);

                    //ClientScript.RegisterStartupScript(this.GetType(), "tishi", "<script type=\"text/javascript\">alert('您所添加的物料(" + arName + "）为已被使用的一次性物品，无法继续添加该物料，请重新选择其它物料！The article you added is a disposable item that has been used. You cannot continue to add this article. Please choose another article!',function(){return false;});</script>");

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('您所添加的物料{" + arName + "}为已被使用的一次性物品，无法继续添加该物料，请重新选择其它物料！The article you added is a disposable item that has been used. You cannot continue to add this article. Please choose another article!');", true);

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

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('您所添加的物料{" + ar_Name + "}存在重复项，请手动删除后再提交！\\nThere are duplicates in the material you added. Please delete them manually before submitting!');", true);

                    e.Cancel = true;
                }
                else if (ArticleName != null)
                {
                    string msg = string.Empty;
                    string msg_cn = "以下物料数量不能为零";
                    string msg_en = "The following article quantities cannot be zero";
                    msg = string.Format("{0}\\n{1}\\n{2}", msg_cn, msg_en, ArticleName);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                    e.Cancel = true;
                }
                else
                {
                    #region 网上或超市采购/客户代采购无附件无法进行提交

                    //Add By Sylvia At 2020-08-03
                    DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                    string applypurpose_value = fld_APPLYPURPOSE.SelectedItem.Value;
                    if (applypurpose_value == "2")
                    {
                        UserInfo UserInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                        IAttachment logic = ServiceContainer.Instance().GetService<IAttachment>();
                        //DataTable dt_supplier = new DataTable();
                        DataTable dt_approver = new DataTable();
                        //dt_supplier = logic.GetAttachmentsByFormID(UserInfo1.FormID, "SUPPLIER");
                        dt_approver = logic.GetAttachmentsByFormID(UserInfo1.FormID, "");
                        if (dt_approver.Rows.Count <= 0)
                        {
                            string msg = string.Empty;
                            string msg_cn = "请至少上传一个附件";
                            string msg_en = "Please upload at least one attachment";
                            msg = string.Format("{0}\\n{1}", msg_cn, msg_en);
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "');", true);
                            e.Cancel = true;
                        }
                    }

                    #endregion

                    //DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                    DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
                    TextBox fld_ASSETTYPE = (TextBox)Page.FindControl("fld_ASSETTYPE");

                    TextBox fld_APPLYPURPOSETXT = (TextBox)Page.FindControl("fld_APPLYPURPOSETXT");
                    TextBox fld_SUPPLIERTYPETXT = (TextBox)Page.FindControl("fld_SUPPLIERTYPETXT");
                    TextBox fld_ASSETTYPETXT = (TextBox)Page.FindControl("fld_ASSETTYPETXT");

                    HiddenField SUPPLIERTYPE = (HiddenField)Page.FindControl("SUPPLIERTYPE");
                    HiddenField SUPPLIERTYPETXT = (HiddenField)Page.FindControl("SUPPLIERTYPETXT");
                    fld_SUPPLIERTYPE.SelectedItem.Value = SUPPLIERTYPE.Value;
                    fld_SUPPLIERTYPE.SelectedItem.Text = SUPPLIERTYPETXT.Value;
                    if (fld_SUPPLIERTYPE.SelectedItem.Text == "")
                    {
                        string msg = "该采购类型不能为空";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                        e.Cancel = true;
                    }

                    fld_APPLYPURPOSETXT.Text = GetApplypurose(fld_APPLYPURPOSE.SelectedItem.Value);
                    fld_SUPPLIERTYPETXT.Text = fld_SUPPLIERTYPE.SelectedItem.Text;
                    fld_ASSETTYPE.Text = "Services";

                    fld_ASSETTYPETXT.Text = "服务";

                    UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;

                    TextBox fld_SITECODE = (TextBox)Page.FindControl("fld_SITECODE");
                    TextBox fld_SITENAME = (TextBox)Page.FindControl("fld_SITENAME");
                    TextBox fld_AMOUNT = (TextBox)Page.FindControl("fld_AMOUNT");
                    //TextBox fld_ORIGINALAMOUNT = (TextBox)Page.FindControl("fld_ORIGINALAMOUNT");
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

                    //AddArticleRepeater();
                    if (fld_SUPPLIERTYPE.SelectedItem.Value != "9" || fld_SUPPLIERTYPE.SelectedItem.Text != "授权供应商")
                    {
                        AddArticleRepeater();
                    }

                    AssignmentSignedApprover();
                    TextBox fld_PURCHASINGAGENT = (TextBox)Page.FindControl("fld_PURCHASINGAGENT");
                    if (fld_APPLYPURPOSE.SelectedItem.Value == "2")
                    {
                        fld_PURCHASINGAGENT.Text = "1";
                    }
                    else
                    {
                        fld_PURCHASINGAGENT.Text = "0";
                    }
                    TextBox fld_ISCOR = (TextBox)Page.FindControl("fld_ISCOR");
                    TextBox fld_ISCORName = (TextBox)Page.FindControl("fld_ISCORName");
                    if (Convert.ToDateTime(date_DELIVERYDATE.ToString()) < Convert.ToDateTime(Value.ToString()))
                    {
                        //Response.Write("<script>alert('要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am');</script>");

                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);

                        e.Cancel = true;
                    }
                    if ((Convert.ToDecimal(this.fld_AMOUNT.Text) >= AuthorizedAmount && fld_SUPPLIERTYPE.SelectedItem.Value == "9") || (Convert.ToDecimal(this.fld_AMOUNT.Text) >= UnauthorizedAmount && fld_SUPPLIERTYPE.SelectedItem.Value != "9"))
                    {
                        string value = this.fld_APPREMARK.Text;
                        bool result = Regex.Matches(value, "[a-zA-Z]").Count > 0;
                        if (!result)
                        {
                            string msg = "该采购申请需中国区主席审批，备注栏中请提供采购收入或利润，并请包含对应英文描述";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                            e.Cancel = true;
                        }
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", " document.getElementById('ButtonList1_btnSend').style.display = 'none';", true);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public string GetApplypurose(string Applypurose)
        {
            switch (Applypurose)
            {
                case "3":
                    return "员工福利";
                case "2":
                    return "客户代采购";
                default:
                    return "营运生产";
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
                    Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
                    IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                    DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_MCPR_SERVICE_ITEMS, UserInfo.FormID);
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

            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable dt2 = _workflow.GetDetailData(UserInfo, fld_detail_PROC_MCPR_SERVICE_ITEMS, UserInfo.FormID);

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


        [WebMethod]
        public static string BindIsOneTime()
        {
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            string sql = string.Format("SELECT DISTINCT TOP 5000 [ArticleCode]  FROM [dbo].[SODEXO_Article]  join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Services' and ArticleFamily=fh.SubSubFamilyCode and EffictiveEndDate>='{0}' and SiteCode='{1}'  and SitePrice>0  and  ((IsOneTimeUsing=1 AND UseTimes=0)) AND RFQ_Number IS NOT NULL", DateNow, SiteCode);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            string jsonStr = new JsonHelper().DataTableToJson(dt);
            return jsonStr;

        }
        /// <summary>
        /// 查询当前用户使用的语言，下拉框显示对应的文本语言
        /// </summary>
        /// <param name="userName"></param>
        private void BindDropdownlistByLanguage(string userName)
        {
            string language = GetLanguage(userName);
            //string language = GetLanguageByUserName(userName);
            //language = language.Split(':')[1];
            //language = language.Split('"')[1];
            //[{"LANGUAGE":"en-US"}]
            if (language == "en-US")
            {
                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                RadioButtonList fld_SHOWREMARK = (RadioButtonList)Page.FindControl("fld_SHOWREMARK");
                // add hanyang time 2021/8/19
                RadioButtonList fld_IsPrePaid = (RadioButtonList)Page.FindControl("fld_IsPrePaid");
                string applypurpose = fld_APPLYPURPOSE.SelectedItem.Text;
                string suppliertype = fld_SUPPLIERTYPE.SelectedItem.Text;
                string fixedassets = fld_FIXEDASSETS.SelectedItem.Text;
                string showremark = fld_SHOWREMARK.SelectedItem.Text;
                string isPrePaid = fld_IsPrePaid.SelectedItem.Text;
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
                if (fixedassets == "否")
                {
                    //是否是固定资产
                    BindFixedAssets();
                }
                if (showremark == "否")
                {
                    //是否显示备注
                    BindShowRemark();
                }
                if (isPrePaid == "否")
                {
                    BindIsPrePaid();
                }
            }
        }

        /// <summary>
        /// 查询当前用户使用的语言
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        #region 查询当前用户使用的语言老旧方法
        //private string GetLanguage(string username)
        //{
        //    string loginName = "";
        //    if (username != "")
        //    {
        //        loginName = username.Trim().Replace('/', '\\').Split('\\')[1];
        //    }
        //    StringBuilder sSql = new StringBuilder();
        //    sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + loginName + "'");
        //    string language = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
        //    return language;
        //}
        #endregion
        private string GetLanguage(string username)
        {
            string loginName = "";
            string language = "";
            StringBuilder sSql = new StringBuilder();
            if (!string.IsNullOrWhiteSpace(username))
            {
                loginName = username.Trim().Replace('/', '\\').Split('\\')[1];
                sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + loginName + "'");
                language = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
            }
            return language;
        }

        /// <summary>
        /// 加载英文版-申请目的
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
        /// 加载英文版-采购类型
        /// </summary>
        private void BindOrderType()
        {
            DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
            DataTable PRPurpose = DataAccess.Instance("BizDB").ExecuteDataTable("select code,en_value from [dbo].[SODEXO_OrderType]");
            fld_SUPPLIERTYPE.Items.Clear();
            fld_SUPPLIERTYPE.DataSource = PRPurpose;
            fld_SUPPLIERTYPE.DataTextField = "en_value";
            fld_SUPPLIERTYPE.DataValueField = "Code";
            fld_SUPPLIERTYPE.DataBind();
            fld_SUPPLIERTYPE.Items.Insert(0, new ListItem("", ""));

            //SELECT Code,ENName FROM [dbo].[SODEXO_t_PRPurpose] WHERE [StateCode]=1
        }

        /// <summary>
        /// 加载英文版-是否是固定资产
        /// </summary>
        private void BindFixedAssets()
        {
            RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
            fld_FIXEDASSETS.Items.Clear();
            fld_FIXEDASSETS.Items.Add(new ListItem("Yes", "01"));
            fld_FIXEDASSETS.Items.Add(new ListItem("No", "02"));
            fld_FIXEDASSETS.Items[1].Selected = true;
        }

        /// <summary>
        /// 加载英文版-是否显示备注
        /// </summary>
        private void BindShowRemark()
        {
            RadioButtonList fld_SHOWREMARK = (RadioButtonList)Page.FindControl("fld_SHOWREMARK");
            fld_SHOWREMARK.Items.Clear();
            fld_SHOWREMARK.Items.Add(new ListItem("Yes", "1"));
            fld_SHOWREMARK.Items.Add(new ListItem("No", "0"));
            fld_SHOWREMARK.Items[1].Selected = true;
        }

        /// <summary>
        /// 是否预付
        /// </summary>
        private void BindIsPrePaid()
        {
            RadioButtonList fld_IsPrePaid = (RadioButtonList)Page.FindControl("fld_IsPrePaid");
            fld_IsPrePaid.Items.Clear();
            fld_IsPrePaid.Items.Add(new ListItem("Yes", "1"));
            fld_IsPrePaid.Items.Add(new ListItem("No", "0"));
            fld_IsPrePaid.Items[1].Selected = true;
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
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_MCPR_SERVICE_ITEMS, UserInfo.FormID);
            string[] resArray = new string[Article.Rows.Count];

            DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
            if (fld_SUPPLIERTYPE.SelectedItem.Value == "9" || fld_SUPPLIERTYPE.SelectedItem.Text == "授权供应商" || fld_SUPPLIERTYPE.SelectedItem.Text == "Authorized Supplier")
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
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_MCPR_SERVICE_ITEMS, UserInfo.FormID);
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

        /// <summary>
        /// Add By Sylvia At 2020-08-13
        /// 在提交之前检查是否添加了重复的articlecode物料
        /// </summary>
        /// <returns></returns>
        private string[] checkArticleCode()
        {
            UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_Items = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            DataTable Article = _workflow.GetDetailData(UserInfo, fld_detail_PROC_MCPR_SERVICE_Items, UserInfo.FormID);
            string[] resArray = new string[Article.Rows.Count];

            DropDownList fld_SUPPLIERTYPE = (DropDownList)Page.FindControl("fld_SUPPLIERTYPE");
            if (fld_SUPPLIERTYPE.SelectedItem.Value == "9" || fld_SUPPLIERTYPE.SelectedItem.Text == "授权供应商" || fld_SUPPLIERTYPE.SelectedItem.Text == "Authorized Supplier")
            {
                int m = 0;
                for (int i = 0; i < Article.Rows.Count; i++)
                {
                    string articlecode = Article.Rows[i]["ARTICLECODE"].ToString();
                    string articlename = Article.Rows[i]["ARTICLENAME"].ToString();
                    for (int j = i + 1; j < Article.Rows.Count; j++)
                    {
                        if (i != j)
                        {
                            string article_code = Article.Rows[j]["ARTICLECODE"].ToString();
                            if (articlecode == article_code)
                            {
                                resArray[m] = string.Format(@"{0}({1})", articlename, articlecode);
                                m++;
                            }
                        }
                    }
                }
            }
            else
            {
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
            }

            return resArray;
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

        [WebMethod]
        public static string BindArticle()
        {
            if (CprType == "0")
            {
                // List<List<ArticleList>> JsonResult = new List<List<ArticleList>>();
                List<ArticleList> JsonResult = new List<ArticleList>();
                List<Article> list = FromJSON<List<Article>>(CprArticle);
                if (list != null)
                {
                    StringBuilder sSql = new StringBuilder();
                    DataTable dt = new DataTable();
                    string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
                    foreach (var item in list)
                    {
                        List<ArticleList> result = new List<ArticleList>();
                        sSql.AppendFormat(@"
            SELECT DISTINCT TOP 30 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_Pur2InvRate,UOM_UseUnit,UOM_Pur2InvRate,UOM_Inv2UseRate,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode  FROM [dbo].[SODEXO_OrderUnit] ou,SODEXO_BaseUnit,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND  a.EffictiveEndDate>='{0}'and a.SiteCode='{1}' and fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode  AND a.RFQ_Number='{2}' and a.ArticleCode='{3}' and ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", DateNow, SiteCode, item.RFQ_Number.ToString(), item.ArticleCode.ToString());
                        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                        result = GetCprArticleList(dt);
                        JsonResult = GetArticleList(JsonResult, result);
                    }
                    JsonResult = CheckArticle(JsonResult);
                    string jsonStr = JsonConvert.SerializeObject(JsonResult);
                    return jsonStr;
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }

        public DataTable SelectSupplier(string RFQ_Number, string ArticleCode)
        {
            StringBuilder sSql = new StringBuilder();
            DataTable dt = new DataTable();
            sSql.AppendFormat(@"SELECT SupplierName, SupplierCode  FROM [dbo].[SODEXO_Article] where ArticleCode='{0}' and RFQ_Number='{1}'", ArticleCode, RFQ_Number);
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return dt;
        }
        public static List<ArticleList> CheckArticle(List<ArticleList> list)
        {
            for (int i = 0; i < list.Count; i++)
            {
                for (int j = list.Count - 1; j > i; j--)
                {
                    if (list[i].ArticleCode == list[j].ArticleCode)
                    {
                        list.RemoveAt(j);
                    }
                }
            }
            return list;
        }
        public class Article
        {
            public string RFQ_Number { get; set; }
            public string ArticleCode { get; set; }
        }
        public static List<ArticleList> GetArticleList(List<ArticleList> dt, List<ArticleList> db)
        {
            foreach (var item in db)
            {
                ArticleList article = new ArticleList();
                article.ArticleName = item.ArticleName.ToString();
                article.FamilyCode = item.FamilyCode.ToString();
                article.FamilyName = item.FamilyName.ToString();
                article.SubFamilyCode = item.SubFamilyCode.ToString();
                article.SubFamilyNameCN = item.SubFamilyNameCN.ToString();
                article.SubSubFamilyCode = item.SubSubFamilyCode.ToString();
                article.SubSubFamilyNameCN = item.SubSubFamilyNameCN.ToString();
                article.OrderUnitCN = item.OrderUnitCN.ToString();
                article.OrderUnitAbbr = item.OrderUnitAbbr.ToString();
                article.BaseUnitAbbr = item.BaseUnitAbbr.ToString();
                article.BaseUnitCN = item.BaseUnitCN.ToString();
                article.UOM_Pur2InvRate = item.UOM_Pur2InvRate.ToString();
                article.UOM_Inv2UseRate = item.UOM_Inv2UseRate.ToString();
                article.UOM_UseUnit = item.UOM_UseUnit.ToString();
                article.NetVolume = item.NetVolume.ToString();
                article.NetVolumeUnit = item.NetVolumeUnit.ToString();
                article.Gross_weight = item.Gross_weight.ToString();
                article.SitePrice = item.SitePrice.ToString();
                article.NetNetPrice = item.NetNetPrice.ToString();
                article.OrderLimit = item.OrderLimit.ToString();
                dt.Add(article);
            }
            return dt;
        }

        public static List<ArticleList> GetCprArticleList(DataTable dt)
        {
            List<ArticleList> list = new List<ArticleList>();
            ArticleList articles = new ArticleList();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                articles.ArticleCode = dt.Rows[i]["ArticleCode"].ToString();
                articles.ArticleName = dt.Rows[i]["ArticleName"].ToString();
                articles.FamilyCode = dt.Rows[i]["FamilyCode"].ToString();
                articles.FamilyName = dt.Rows[i]["FamilyName"].ToString();
                articles.SubFamilyCode = dt.Rows[i]["SubFamilyCode"].ToString();
                articles.SubFamilyNameCN = dt.Rows[i]["SubFamilyNameCN"].ToString();
                articles.SubSubFamilyCode = dt.Rows[i]["SubSubFamilyCode"].ToString();
                articles.SubSubFamilyNameCN = dt.Rows[i]["SubSubFamilyNameCN"].ToString();
                articles.OrderUnitCN = dt.Rows[i]["OrderUnitCN"].ToString();
                articles.OrderUnitAbbr = dt.Rows[i]["OrderUnitAbbr"].ToString();
                articles.BaseUnitAbbr = dt.Rows[i]["BaseUnitAbbr"].ToString();
                articles.BaseUnitCN = dt.Rows[i]["BaseUnitCN"].ToString();
                articles.UOM_Pur2InvRate = dt.Rows[i]["UOM_Pur2InvRate"].ToString();
                articles.UOM_Inv2UseRate = dt.Rows[i]["UOM_Inv2UseRate"].ToString();
                articles.UOM_UseUnit = dt.Rows[i]["UOM_UseUnit"].ToString();
                articles.NetVolume = dt.Rows[i]["NetVolume"].ToString();
                articles.NetVolumeUnit = dt.Rows[i]["NetVolumeUnit"].ToString();
                articles.Gross_weight = dt.Rows[i]["Gross_weight"].ToString();
                articles.SitePrice = Convert.ToDecimal(dt.Rows[i]["SitePrice"]).ToString("0.00");
                articles.NetNetPrice = Convert.ToDecimal(dt.Rows[i]["SitePrice"]).ToString("0.00");
                articles.OrderLimit = dt.Rows[i]["OrderLimit"].ToString();
                list.Add(articles);
            }

            return list;
        }
        public static int IsCOROld(string pccode)
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
            var isCORs = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCOR"].Split('|').ToList();
            var dd = dt.AsEnumerable().Where(x => isCORs.Any(c => c == x["orgCode"].ToString()));
            string NdCORF = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCORF"];
            string NdCORN = System.Web.Configuration.WebConfigurationManager.AppSettings["NdCORN"];           
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
        public Cor IsCOR(string pccode)
        {
            var cor = new Cor();
            string baseUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["BPM_WEB_API_URL"].Trim();
            var res = HttpUtil.HttpGet(string.Format("{0}/api/bpm/Cor?SITECODE={1}",baseUrl, pccode, "application/json;charset=UTF-8"));
            if (!string.IsNullOrWhiteSpace(res))
            {
                return FromJSON<Cor>(res);
            }
            return cor;
        }
        public class Cor
        {
            public int Result { get; set; }
            public string OrgName { get; set; }

        }
        public class ArticleList
        {
            public string ArticleCode { get; set; }
            public string ArticleName { get; set; }
            public string FamilyCode { get; set; }
            public string FamilyName { get; set; }
            public string SubFamilyCode { get; set; }
            public string SubFamilyNameCN { get; set; }
            public string SubSubFamilyCode { get; set; }
            public string SubSubFamilyNameCN { get; set; }
            public string OrderUnitCN { get; set; }
            public string OrderUnitAbbr { get; set; }
            public string BaseUnitAbbr { get; set; }
            public string BaseUnitCN { get; set; }
            public string UOM_Pur2InvRate { get; set; }
            public string UOM_Inv2UseRate { get; set; }
            public string UOM_UseUnit { get; set; }
            public string NetVolume { get; set; }
            public string NetVolumeUnit { get; set; }
            public string Gross_weight { get; set; }
            public string SitePrice { get; set; }
            public string NetNetPrice { get; set; }
            public string OrderLimit { get; set; }

        }
        private string UploadDirectory
        {
            get { return Server.MapPath("~/Uploads/"); }
        }

        // 允许的文件扩展名
        private readonly string[] AllowedExtensions = {
           /* ".jpg", ".jpeg", ".png", ".gif",*/ ".pdf", ".ofd", ".xml"/*, ".xls", ".xlsx"*/
        };

        // 最大文件大小（10MB）
        private readonly int MaxFileSize = 10 * 1024 * 1024;

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (!Directory.Exists(UploadDirectory))
            {
                Directory.CreateDirectory(UploadDirectory);
            }
            try
            {
                if (fileUpload.HasFiles)
                {
                    var results = new List<UploadResult>();

                    foreach (HttpPostedFile file in fileUpload.PostedFiles)
                    {
                        var result = UploadFile(file);
                        results.Add(result);

                        // 更新前端进度（需要配合AJAX使用，此处为示例）
                        ClientScript.RegisterStartupScript(this.GetType(),
                           "UploadScript",
                           "onUploadCompleted();", true);
                    }

                    // 显示上传结果
                    ShowUploadResults(results);
                }
                else
                {
                    errorLabel.Text = "请选择文件";
                }
            }
            catch (Exception ex)
            {
                errorLabel.Text = "上传过程中发生错误: " + ex.Message;
            }
        }

        private UploadResult UploadFile(HttpPostedFile file)
        {
            var result = new UploadResult
            {
                OriginalFileName = file.FileName,
                Size = file.ContentLength,
                Uploaded = false
            };

            try
            {
                // 验证文件类型
                string fileExtension = Path.GetExtension(file.FileName).ToLower();
                if (!Array.Exists(AllowedExtensions, ext => ext == fileExtension))
                {
                    result.ErrorMessage = "不支持的文件类型";
                    return result;
                }

                // 验证文件大小
                if (file.ContentLength > MaxFileSize)
                {
                    result.ErrorMessage = string.Format("文件大小超过限制（最大 {0}MB）", MaxFileSize / (1024 * 1024));
                    return result;
                }

                // 生成唯一文件名
                string uniqueFileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + file.FileName;
                string filePath = Path.Combine(UploadDirectory, uniqueFileName);

                // 保存文件
                file.SaveAs(filePath);

                result.Uploaded = true;
                result.SavePath = filePath;
                result.UniqueFileName = uniqueFileName;

                // 记录上传日志（可根据需要实现）
                LogUpload(result);

                string baseUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["BPM_WEB_API_URL"].Trim();

                var Invoice = HttpUtil.HttpGet(string.Format("{0}/api/bpm/Invoice?path={1}", baseUrl, filePath, "application/json;charset=UTF-8"));
                if (!string.IsNullOrWhiteSpace(Invoice))
                {
                    var InvoiceModel = FromJSON<InvoiceInfo>(Invoice);

                    LogUtil.Info("UploadFile:2" + Invoice);
                    TextBox fld_INVOICETYPE = (TextBox)Page.FindControl("fld_INVOICETYPE");
                    fld_INVOICETYPE.Text = InvoiceModel.InvoiceType;
                    // DropDownList fld_INVOICETYPE = (DropDownList)Page.FindControl("fld_INVOICETYPE");

                    TextBox fld_INVOICENUMBER = (TextBox)Page.FindControl("fld_INVOICENUMBER");
                    fld_INVOICENUMBER.Text = InvoiceModel.InvoiceNumber;

                    TextBox fld_BUYERNAME = (TextBox)Page.FindControl("fld_BUYERNAME");
                    fld_BUYERNAME.Text = InvoiceModel.SellerName;

                    TextBox fld_BUYERTAXID = (TextBox)Page.FindControl("fld_BUYERTAXID");
                    fld_BUYERTAXID.Text = InvoiceModel.SellerTaxId;

                    TextBox fld_INVOICEPATH = (TextBox)Page.FindControl("fld_INVOICEPATH");

                    string webUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["BPM_WEB_URL"].Trim();
                    fld_INVOICEPATH.Text = filePath.Replace(@"D:\Project\sodexo\trunk\WebPortal\Uploads\", webUrl + "/Uploads/");

                    //if (!string.IsNullOrWhiteSpace(InvoiceModel.InvoiceType))
                    //{
                    //    fld_INVOICETYPE.SelectedValue = InvoiceModel.InvoiceType;
                    //}
                    //else
                    //{
                    //    fld_INVOICETYPE.SelectedValue = "";
                    //}
                }

            }
            catch (Exception ex)
            {
                result.ErrorMessage = "保存文件时出错: " + ex.Message;
            }

            return result;
        }

        private void ShowUploadResults(List<UploadResult> results)
        {
            var successCount = results.Count(r => r.Uploaded);
            var failedCount = results.Count - successCount;

            if (successCount > 0)
            {
                errorLabel.Text = string.Format("成功上传 {0} 个文件", successCount);

                if (failedCount > 0)
                {
                    errorLabel.Text += string.Format(", {0} 个文件上传失败", failedCount);
                }
            }
            else
            {
                errorLabel.Text = "所有文件上传失败";
            }
        }

        private void LogUpload(UploadResult result)
        {
            // 实现日志记录（如写入数据库或日志文件）
            // 示例：将上传信息写入文本日志
            try
            {
                string logPath = Path.Combine(UploadDirectory, "upload_log.txt");
                string logEntry = string.Format("[{0}] 上传成功: {1} -> {2}\n", DateTime.Now, result.OriginalFileName, result.UniqueFileName);
                File.AppendAllText(logPath, logEntry);
            }
            catch { /* 忽略日志错误 */ }
        }

    }
    public class UploadResult
    {
        public string OriginalFileName { get; set; }
        public string UniqueFileName { get; set; }
        public string SavePath { get; set; }
        public int Size { get; set; }
        public bool Uploaded { get; set; }
        public string ErrorMessage { get; set; }
    }
    public class InvoiceInfo
    {
        public string InvoiceNumber { get; set; }
        public string InvoiceType { get; set; }
        public string IssueDate { get; set; }
        public string BuyerName { get; set; }
        public string BuyerTaxId { get; set; }
        public string SellerName { get; set; }
        public string SellerTaxId { get; set; }
        public string Amount { get; set; }
        public string AmountInWords { get; set; }
        public string ItemName { get; set; }
        public string TaxRate { get; set; }
        public string TaxAmount { get; set; }
        public string Issuer { get; set; }


    }

}
