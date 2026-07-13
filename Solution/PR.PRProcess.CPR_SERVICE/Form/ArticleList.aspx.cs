using MyLib;
using MyLib.Json;
using MyLib.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedEntity;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic;
using Ultimus.UWF.Workflow.Logic;

namespace PR.PRProcess.CPR_SERVICE
{
    public partial class ArticleList : System.Web.UI.Page
    {
        public static string username;
        public static string siteCode;
        public static string familyCode;
        private static int count=500;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                siteCode = Request.QueryString["sitecode"];
                hdSiteCode.Value= Request.QueryString["sitecode"];
                string suppliercode = Request.QueryString["suppliercode"];
                familyCode = Request.QueryString["familyCode"];
                hdSupplierCode.Value = Request.QueryString["suppliercode"];
                username = Request.QueryString["username"].Replace('/', '\\').Split('\\')[1];
                getLanguage(username);        
               DataTable dt= BindArticle(siteCode, "", suppliercode, "", familyCode);
                this.ArticleSource.DataSource = dt;
                this.ArticleSource.DataBind();
            }
        }
        public DataTable BindArticle(string siteCode, string RFQ_Number, string SupperCode, string ArticleName, string familyCode)
        {
            StringBuilder sSql = new StringBuilder();
            DataTable dt = new DataTable();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            StringBuilder sSqlNew = new StringBuilder();
            sSqlNew.Append(@"
                    SELECT DISTINCT TOP "+ count + " a.[ID],[ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Services' and a.ArticleFamily=fh.SubSubFamilyCode  AND a.CategoryCode=fh.CategoryCode and a.EffictiveEndDate>='" + DateNow + "' and a.SiteCode='" + siteCode + "' and SitePrice>0  and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)");

            if (!string.IsNullOrEmpty(RFQ_Number)) {
                sSqlNew.Append(" and RFQ_Number='" + RFQ_Number + "'");
            }
            if (!string.IsNullOrEmpty(SupperCode))
            {
                sSqlNew.Append("   and a.SupplierCode='" + SupperCode + "'");
            }
            if (!string.IsNullOrEmpty(ArticleName))
            {
                sSqlNew.Append("   and a.ArticleName  like N'%" + ArticleName + "%'");
            }
            if (!string.IsNullOrEmpty(familyCode))
            {
                sSqlNew.Append("   and fh.familyCode='" + SupperCode + "'");
            }           
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSqlNew.ToString());
            dt = CheckArticle(dt);
            return dt;
        }
        public void btn_Add_Click(object sender, EventArgs e) {
            string HdRFQ_Number = this.HdRFQ_Number.Value;
            string HdsupplerName = this.HdsupplerName.Value;
            string HdArticleName = this.HdArticleName.Value;
            DataTable dt = BindArticle(siteCode, HdRFQ_Number, HdsupplerName, HdArticleName, familyCode);
           this.ArticleSource.DataSource = dt;
           this.ArticleSource.DataBind();
        }

        public DataTable CheckArticle(DataTable dt) {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = dt.Rows.Count - 1; j > i; j--)
                {
                    if ((dt.Rows[i]["RFQ_Number"].ToString()== dt.Rows[j]["RFQ_Number"].ToString())&& (dt.Rows[i]["SupplierCode"].ToString() == dt.Rows[j]["SupplierCode"].ToString()) && (dt.Rows[i]["ArticleCode"].ToString() == dt.Rows[j]["ArticleCode"].ToString()))
                    {
                        dt.Rows.RemoveAt(j);
                    }
                }
            }
            return dt;
        }


        [WebMethod]
        public static string BindSupplier(string searchcondition, string pccode, string subfamilycode)
        {
            string res = string.Empty;
            StringBuilder url = new StringBuilder();
            string SodexoWebApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["SodexoWebApiUrl"].ToString();
            string ReferenceSupplierUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["ReferenceSupplierUrl"].ToString();
            string urls = string.Format("{0}{1}", SodexoWebApiUrl, ReferenceSupplierUrl);
            url.AppendFormat("{3}?pcCode={0}&subSubFamilyCode={1}&supplierCodeOrName={2}", pccode, subfamilycode, searchcondition, urls);
            Encoding encoding = Encoding.UTF8;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url.ToString());
            request.Method = "POST";
            request.Accept = "application/json,text/javascript,*/*";
            request.ContentType = "application/json;charset=utf-8";

            string jsonString = "{\"pcCode\":\"" + pccode + "\",\"subSubFamilyCode\":\"" + subfamilycode + "\"}";
            string resSupplers = "";
            byte[] buffer = encoding.GetBytes(jsonString);
            request.ContentLength = buffer.Length;
            request.GetRequestStream().Write(buffer, 0, buffer.Length);
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (StreamReader reader = new StreamReader(response.GetResponseStream(), encoding))
            {
                resSupplers = reader.ReadToEnd();
            }

            var ajaxResponse = JsonString2Object<AjaxResponse<List<SupplyViewModelDto>>>(resSupplers);
            if (!ajaxResponse.Success)
            {
                throw new Exception();
            }
            List<SupplyViewModelDto> ListReferenceSupplers = ajaxResponse.Result;
            ListReferenceSupplers = ListReferenceSupplers.Where(s => s.SupplierCode.Contains(searchcondition) || s.SupplierNameCN.Contains(searchcondition)).ToList();
            res = JsonConvert.SerializeObject(ListReferenceSupplers);


            return res;
        }
        [WebMethod]
        public static string BindRRQ_Number(string searchRFQInput,string searchSupper,string searchArticleName)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            DataTable dt = new DataTable();
            if ((!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and RFQ_Number like '%{1}%' and SiteCode='{2}' ", DateNow, searchRFQInput, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.CategoryNameEN='Services' and SupplierCode like '%{1}%' and SiteCode='{2}'  ", DateNow, searchSupper, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.ArticleName like N'%{1}%' and SiteCode='{2}' ", DateNow, searchArticleName, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.SupplierCode like '%{3}%' ", DateNow, searchArticleName, siteCode, searchSupper);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchArticleName, siteCode, searchRFQInput);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.CategoryNameEN='Services' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchSupper, siteCode, searchRFQInput);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (!string.IsNullOrEmpty(searchArticleName) || searchArticleName != ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' and b.ArticleName like N'%{4}%' ", DateNow, searchSupper, siteCode, searchRFQInput, searchArticleName);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.CategoryNameEN='Services'  and SiteCode='{1}'and RFQ_Number is not null", DateNow,siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            string jsonStr = new JsonHelper().DataTableToJson(dt);
            return jsonStr;
        }

        [WebMethod]
        public static string BindSupper(string searchRFQInput, string searchSupper, string searchArticleName)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            DataTable dt = new DataTable();
            if ((!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "")&& (string.IsNullOrEmpty(searchSupper) || searchSupper == "")&& (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)   and a.CategoryNameEN='Services' and RFQ_Number like '%{1}%' and SiteCode='{2}' ", DateNow, searchRFQInput, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "")&& (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == "")&& (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and SupplierCode like '%{1}%' and SiteCode='{2}'  ", DateNow, searchSupper, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "")&& (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and  a.CategoryNameEN='Services' and b.ArticleName like N'%{1}%' and SiteCode='{2}' ", DateNow, searchArticleName, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchSupper) || searchSupper != "")&& (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and  and a.CategoryNameEN='Services' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.SupplierCode like '%{3}%' ", DateNow, searchArticleName, siteCode, searchSupper);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "")&& (string.IsNullOrEmpty(searchSupper) || searchSupper == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchArticleName, siteCode, searchRFQInput);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "")&& (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchSupper, siteCode, searchRFQInput);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (!string.IsNullOrEmpty(searchArticleName) || searchArticleName != ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' and b.ArticleName like N'%{4}%' ", DateNow, searchSupper, siteCode, searchRFQInput, searchArticleName);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Services' and SiteCode='{1}' and SupplierCode is not null", DateNow,siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            string jsonStr = new JsonHelper().DataTableToJson(dt);
            return jsonStr;
        }

        [WebMethod]
        //public static string BindFamily(string searchRFQInput, string searchSupper, string searchFamilyNameInput)
        //{
        //    StringBuilder sSql = new StringBuilder();
        //    string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
        //    DataTable dt = new DataTable();
        //    if ((!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput == ""))
        //    {
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and b.RFQ_Number like '%{1}%' and SiteCode='{2}' ", DateNow, searchRFQInput, siteCode);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == "") && (string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput == ""))
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and b.SupplierCode like '%{1}%' and SiteCode='{2}' ", DateNow, searchSupper, siteCode);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else if ((!string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.SubFamilyNameCN like N'%{1}%' and SiteCode='{2}' ", DateNow, searchFamilyNameInput, siteCode);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else if ((!string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput != "") && (!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.SubFamilyNameCN like N'%{1}%' and SiteCode='{2}' and b.SupplierCode like '%{3}%' ", DateNow, searchFamilyNameInput, siteCode, searchSupper);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else if ((!string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == ""))
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.SubFamilyNameCN like N'%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchFamilyNameInput, siteCode, searchRFQInput);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput == ""))
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchSupper, siteCode, searchRFQInput);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (!string.IsNullOrEmpty(searchFamilyNameInput) || searchFamilyNameInput != ""))
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' and a.SubFamilyNameCN like N'%{4}%' ", DateNow, searchSupper, siteCode, searchRFQInput, searchFamilyNameInput);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    else
        //    {
        //        sSql.Length = 0;
        //        sSql.AppendFormat(@"select DISTINCT top 20  a.SubFamilyNameCN from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and a.CategoryNameEN='Food' and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and b.SiteCode='{1}' and a.SubSubFamilyCode is not null", DateNow,siteCode);
        //        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    }
        //    string jsonStr = new JsonHelper().DataTableToJson(dt);
        //    return jsonStr;
        //}
        private static TObj JsonString2Object<TObj>(string str)
        {
            return JsonConvert.DeserializeObject<TObj>(str,
                new JsonSerializerSettings
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver()
                });
        }

        public void getLanguage(string username)
        {
            HiddenField hdLanguage = Page.FindControl("hdLanguage") as HiddenField;
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + username + "'");
            hdLanguage.Value = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
        }
    }
}