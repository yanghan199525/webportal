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

namespace PR.PRProcess.CPR_FOOD
{
    public partial class ArticleList : System.Web.UI.Page
    {
        public static string username = string.Empty;
        public static string siteCode = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //var pc = Application["SiteCode"].ToString();              
                siteCode = Request.QueryString["sitecode"];
                //if (pc != siteCode)
                //{
                //    throw new Exception("浏览器版本问题，导致获取分店编号异常");
                //}
                hdSiteCode.Value = Request.QueryString["sitecode"];
                string suppliercode = Request.QueryString["suppliercode"];
                hdSupplierCode.Value = Request.QueryString["suppliercode"];
                username = Request.QueryString["username"].Replace('/', '\\').Split('\\')[1];
                getLanguage(username);
                DataTable dt = BindArticle(siteCode, "", suppliercode, "");
                this.ArticleSource.DataSource = dt;
                this.ArticleSource.DataBind();
            }
        }
        public DataTable BindArticle(string siteCode, string RFQ_Number, string SupperCode, string ArticleName)
        {

            StringBuilder sSql = new StringBuilder();
            DataTable dt = new DataTable();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");

            var spWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(SupperCode))
            {
                spWhere = "AND SupplierCode = '" + SupperCode + "'";
            }
            var rfqWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(RFQ_Number))
            {
                rfqWhere = "AND RFQ_Number = '" + RFQ_Number + "'";
            }
            var articleWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(ArticleName.Trim()))
            {
                articleWhere = "AND ArticleName LIKE N'%" + ArticleName.Trim() + "%'";
            }

            sSql.Append(@"SELECT DISTINCT TOP 5000
    a.[ID],
    [ArticleCode],
    RFQ_Number,
    REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],
    FamilyCode,
    FamilyName,
    SubFamilyCode,
    SubFamilyNameCN,
    SubSubFamilyCode,
    SubSubFamilyNameCN,
 
    UOM_PurUnit,
    OrderUnitCN,
    OrderUnitAbbr,
    BaseUnitAbbr,
    BaseUnitCN,
    UOM_Pur2InvRate,
    UOM_Inv2UseRate,
    UOM_UseUnit,
    NetVolume,
    NetVolumeUnit,
    Gross_weight,
    SitePrice,
    NetNetPrice,
    OrderLimit,
    a.SupplierName,
    a.SupplierCode,
    tax.TaxCode,
    a.TaxRate,
    tax.InvoiceTypeDesc,
    IsOneTimeUsing
FROM
    [dbo].[SODEXO_Article] a
    LEFT JOIN SODEXO_t_Foun_VAT_Config tax 
        ON tax.TaxRate = a.TaxRate 
        AND tax.InvoiceType = a.InvoiceType
    LEFT JOIN [SODEXO_OrderUnit] ou 
        ON ou.OrderUnitAbbr = a.UOM_PurUnit
    LEFT JOIN SODEXO_BaseUnit bu 
        ON bu.BaseUnitAbbr = a.UOM_UseUnit 
        AND a.UOM_InvUnit = bu.BaseUnitAbbr
    INNER JOIN  [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]  fh 
        ON fh.CategoryNameEN = 'Food' 
        AND a.ArticleFamily = fh.SubSubFamilyCode
        AND a.CategoryCode=fh.CategoryCode
WHERE 1=1 
    and a.EffictiveEndDate >='" + DateNow + "' AND a.SiteCode = '" + siteCode + "' AND SitePrice > 0   AND ((IsOneTimeUsing = 1 AND UseTimes = 0)   OR IsOneTimeUsing = 0 )  " + spWhere + " " + articleWhere + "  " + rfqWhere + "  ORDER BY [ArticleName]; ");

            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            dt = CheckArticle(dt);
            return dt;

            // StringBuilder sSql = new StringBuilder();
            // DataTable dt = new DataTable();
            // string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            // if (RFQ_Number != "" && SupperCode == "" && ArticleName == "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            // SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and RFQ_Number='{2}' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode,RFQ_Number);
            //                 dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else if (RFQ_Number == "" && SupperCode != "" && ArticleName == "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            //  SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and SupplierCode='{2}' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode,SupperCode);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else if (RFQ_Number == "" && SupperCode == "" && ArticleName != "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            //  SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and ArticleName like N'%{2}%' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode, ArticleName);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else if (RFQ_Number != "" && SupperCode != "" && ArticleName == "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            //   SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and RFQ_Number ='{2}' and SupplierCode='{3}' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode,RFQ_Number,SupperCode);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else if (RFQ_Number != "" && SupperCode == "" && ArticleName != "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            // SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and RFQ_Number ='{2}' and ArticleName like N'%{3}%' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode,RFQ_Number, ArticleName);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else if (RFQ_Number == "" && SupperCode != "" && ArticleName != "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            //   SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and SupplierCode ='{2}' and ArticleName like N'%{3}%' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode,SupperCode, ArticleName);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else if (RFQ_Number != "" && SupperCode != "" && ArticleName != "")
            // {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            //SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and RFQ_Number ='{2}' and SupplierCode='{3}' and ArticleName like N'%{4}%' and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode,RFQ_Number,SupperCode, ArticleName);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // else {
            //     sSql.Length = 0;
            //     sSql.AppendFormat(@"
            //    SELECT DISTINCT TOP 5000 [ArticleCode],RFQ_Number,REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[FamilyCode],FamilyName,SubFamilyCode,SubFamilyNameCN,SubSubFamilyCode,SubSubFamilyNameCN,UOM_PurUnit,OrderUnitCN,OrderUnitAbbr,BaseUnitAbbr,BaseUnitCN,UOM_Pur2InvRate,UOM_Inv2UseRate,UOM_UseUnit,NetVolume,NetVolumeUnit,Gross_weight,SitePrice,NetNetPrice,OrderLimit,a.SupplierName, a.SupplierCode,tax.TaxCode,a.TaxRate,tax.InvoiceTypeDesc,IsOneTimeUsing  FROM [dbo].[SODEXO_Article] a left join SODEXO_t_Foun_VAT_Config tax on tax.TaxRate=a.TaxRate and tax.InvoiceType=a.InvoiceType left join [SODEXO_OrderUnit] ou on ou.OrderUnitAbbr=a.UOM_PurUnit left join SODEXO_BaseUnit bu on bu.BaseUnitAbbr=a.UOM_UseUnit and a.UOM_InvUnit=bu.BaseUnitAbbr join [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh on fh.CategoryNameEN='Food' and a.ArticleFamily=fh.SubSubFamilyCode and a.EffictiveEndDate>='{0}' and a.SiteCode='{1}'  and SitePrice>0  and  ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)", DateNow, siteCode);
            //     dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            // }
            // dt = CheckArticle(dt);
            // return dt;
        }

        public void btn_Add_Click(object sender, EventArgs e)
        {
            string HdRFQ_Number = this.HdRFQ_Number.Value;
            string HdsupplerName = this.HdsupplerName.Value;
            string HdArticleName = this.HdArticleName.Value;
            DataTable dt = BindArticle(siteCode, HdRFQ_Number, HdsupplerName, HdArticleName);
            this.ArticleSource.DataSource = dt;
            this.ArticleSource.DataBind();
        }

        public DataTable CheckArticle(DataTable dt)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = dt.Rows.Count - 1; j > i; j--)
                {
                    if ((dt.Rows[i]["RFQ_Number"].ToString() == dt.Rows[j]["RFQ_Number"].ToString()) && (dt.Rows[i]["SupplierCode"].ToString() == dt.Rows[j]["SupplierCode"].ToString()) && (dt.Rows[i]["ArticleCode"].ToString() == dt.Rows[j]["ArticleCode"].ToString()))
                    {
                        dt.Rows.RemoveAt(j);
                    }
                }
            }
            return dt;
        }

        [WebMethod]
        public static string BindRRQ_Number(string RFQ_Number, string suppliercode, string ArticleName)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");

            var spWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(suppliercode))
            {
                spWhere = "AND SupplierCode  LIKE '%" + suppliercode + "%'";
            }
            var rfqWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(RFQ_Number))
            {
                rfqWhere = " AND RFQ_Number LIKE '%" + RFQ_Number + "%'";
            }
            var articleWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(ArticleName.Trim()))
            {
                articleWhere = "AND ArticleName LIKE N'%'" + ArticleName.Trim() + "'%'";
            }

            sSql.Append(@"SELECT DISTINCT TOP 20
    b.RFQ_Number
FROM
    SODEXO_t_Foun_SCM_FamilyHierarchy a,
    SODEXO_Article b
WHERE
    a.SubSubFamilyCode = b.ArticleFamily  
    AND (
        (IsOneTimeUsing = 1 AND UseTimes = 0)
        OR IsOneTimeUsing = 0
    )
    AND a.CategoryNameEN = 'Food'
    AND SiteCode = '" + siteCode + "' " + spWhere + " " + articleWhere + "  " + rfqWhere + "  AND EffictiveEndDate >= '" + DateNow + "' ;");
            DataTable dt = new DataTable();
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            string jsonStr = new JsonHelper().DataTableToJson(dt);
            return jsonStr;
            //StringBuilder sSql = new StringBuilder();
            //string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            //DataTable dt = new DataTable();
            //if ((!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            //{
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and RFQ_Number like  '%{1}%' and SiteCode='{2}' ", DateNow, searchRFQInput, siteCode);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.CategoryNameEN='Food' and SupplierCode like '%{1}%' and SiteCode='{2}'  ", DateNow, searchSupper, siteCode);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.ArticleName like N'%{1}%' and SiteCode='{2}' ", DateNow, searchArticleName, siteCode);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.SupplierCode like '%{3}%' ", DateNow, searchArticleName, siteCode, searchSupper);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == ""))
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchArticleName, siteCode, searchRFQInput);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.CategoryNameEN='Food' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchSupper, siteCode, searchRFQInput);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (!string.IsNullOrEmpty(searchArticleName) || searchArticleName != ""))
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' and b.ArticleName like N'%{4}%' ", DateNow, searchSupper, siteCode, searchRFQInput, searchArticleName);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //else
            //{
            //    sSql.Length = 0;
            //    sSql.AppendFormat(@"select DISTINCT top 20  b.RFQ_Number from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and a.CategoryNameEN='Food'  and SiteCode='{1}'and RFQ_Number is not null", DateNow,siteCode);
            //    dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //}
            //string jsonStr = new JsonHelper().DataTableToJson(dt);
            //return jsonStr;
        }

        [WebMethod]
        public static string BindSupper(string searchRFQInput, string searchSupper, string searchArticleName)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            DataTable dt = new DataTable();
            if ((!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)   and a.CategoryNameEN='Food' and RFQ_Number like '%{1}%' and SiteCode='{2}' ", DateNow, searchRFQInput, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and SupplierCode like '%{1}%' and SiteCode='{2}'  ", DateNow, searchSupper, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and  a.CategoryNameEN='Food' and b.ArticleName like N'%{1}%' and SiteCode='{2}' ", DateNow, searchArticleName, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (string.IsNullOrEmpty(searchRFQInput) || searchRFQInput == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) and  and a.CategoryNameEN='Food' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.SupplierCode like '%{3}%' ", DateNow, searchArticleName, siteCode, searchSupper);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchArticleName) || searchArticleName != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchSupper) || searchSupper == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.ArticleName like N'%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchArticleName, siteCode, searchRFQInput);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (string.IsNullOrEmpty(searchArticleName) || searchArticleName == ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' ", DateNow, searchSupper, siteCode, searchRFQInput);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else if ((!string.IsNullOrEmpty(searchSupper) || searchSupper != "") && (!string.IsNullOrEmpty(searchRFQInput) || searchRFQInput != "") && (!string.IsNullOrEmpty(searchArticleName) || searchArticleName != ""))
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and b.SupplierCode like '%{1}%' and SiteCode='{2}' and b.RFQ_Number like '%{3}%' and b.ArticleName like N'%{4}%' ", DateNow, searchSupper, siteCode, searchRFQInput, searchArticleName);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            else
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"select DISTINCT top 20  b.SupplierCode from SODEXO_t_Foun_SCM_FamilyHierarchy a,SODEXO_Article  b where a.SubSubFamilyCode=b.ArticleFamily and EffictiveEndDate>='{0}'AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0)  and a.CategoryNameEN='Food' and SiteCode='{1}' and SupplierCode is not null", DateNow, siteCode);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            string jsonStr = new JsonHelper().DataTableToJson(dt);
            return jsonStr;
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