using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
//using MyLib;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic;
using System.Web.Script.Serialization;
using System.Net;
using System.IO;
//using System.Net.Http;
using MyLib;
using MyLib.Json;
using MyLib.Json.Serialization;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedEntity;




namespace PR.PRProcess.CPRFOOD
{
    public partial class AddPRItemPage : System.Web.UI.Page
    {
        public static string username;
        private const string SupplierTable = "[dbo].[SODEXO_t_Foun_SCM_Suppliers]";
        private const int DefaultTopCount = 20;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HiddenField hdCategory = Page.FindControl("hdCategory") as HiddenField;
                HiddenField hdSiteCode = Page.FindControl("hdSiteCode") as HiddenField;
                HiddenField hdSupplierType = Page.FindControl("hdSupplierType") as HiddenField;
                HiddenField hdSupplierCode = Page.FindControl("hdSupplierCode") as HiddenField;
                HiddenField hdSupplierName = Page.FindControl("hdSupplierName") as HiddenField;
                HiddenField hdFamilyCode = Page.FindControl("hdFamilyCode") as HiddenField;
                HiddenField hdUserName = Page.FindControl("hdUserName") as HiddenField;
                hdCategory.Value = Request.QueryString["materialcategory"];
                hdSiteCode.Value = Request.QueryString["sitecode"];
                hdSupplierType.Value = Request.QueryString["suppliertype"];
                hdSupplierCode.Value = Request.QueryString["suppliercode"];
                hdSupplierName.Value = Request.QueryString["suppliername"];
                hdFamilyCode.Value = Request.QueryString["familycode"];
                hdUserName.Value = Request.QueryString["username"];
                username = hdUserName.Value.Replace('/', '\\').Split('\\')[1];
                getLanguage(hdUserName.Value.Replace('/', '\\').Split('\\')[1]);
            }
        }

        public void getLanguage(string username)
        {
            HiddenField hdLanguage = Page.FindControl("hdLanguage") as HiddenField;
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + username + "'");
            hdLanguage.Value = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
        }

        /// <summary>
        /// 获取用户使用的语言
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        private static string GetLanguageByUserName(string username)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + username + "'");
            string language = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
            return language;
        }

        [WebMethod]
        public static string BindFamily(string categorycode)
        {
            StringBuilder sSql = new StringBuilder();
            string language = GetLanguageByUserName(username).ToUpper();
            if (language == "EN-US")
            {
                sSql.Append(@"SELECT [FamilyCode],[FamilyNameEN] FROM [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]");
            }
            else if (language == "ZH-CN")
            {
                sSql.Append(@"SELECT [FamilyCode],[FamilyNameCN] FROM [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]");
            }

            if (categorycode == "Food")
            {
                sSql.Append(@" where CategoryNameEN='Food'");
            }
            else if (categorycode == "Non-Food")
            {
                sSql.Append(@" where CategoryNameEN='Non-Food'");
            }
            else
            {
                sSql.Append(@" where CategoryNameEN='Services'");
            }

            if (language == "EN-US")
            {
                sSql.Append(@" group by [FamilyCode],[FamilyNameEN] order by FamilyCode");
            }
            else if (language == "ZH-CN")
            {
                sSql.Append(@" group by [FamilyCode],[FamilyNameCN] order by FamilyCode");
            }

            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }

        //[WebMethod]
        //public static string BindLanguage(string username)
        //{
        //    StringBuilder sSql = new StringBuilder();
        //    sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + username + "'");
        //    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
        //    return new JsonHelper().DataTableToJson(dt);
        //}

        [WebMethod]
        public static string BindSubFamily(string categorycode, string familycode)
        {
            StringBuilder sSql = new StringBuilder();
            string language = GetLanguageByUserName(username).ToUpper();
            if (language == "EN-US")
            {
                sSql.Append(@"SELECT [SubFamilyNameEN],[SubFamilyCode] FROM [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]");
            }
            else if (language == "ZH-CN")
            {
                sSql.Append(@"SELECT [SubFamilyNameCN],[SubFamilyCode] FROM [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]");
            }

            if (categorycode == "Food")
            {
                sSql.Append(@" where CategoryNameEN='Food'");
            }
            else if (categorycode == "Non-Food")
            {
                sSql.Append(@" where CategoryNameEN='Non-Food'");
            }
            else
            {
                sSql.Append(@" where CategoryNameEN='Services'");
            }

            if (language == "EN-US")
            {
                sSql.AppendFormat(@" AND FamilyCode='{0}' group by [SubFamilyNameEN],[SubFamilyCode] order by SubFamilyCode", familycode);
            }
            else if (language == "ZH-CN")
            {
                sSql.AppendFormat(@" AND FamilyCode='{0}' group by [SubFamilyNameCN],[SubFamilyCode] order by SubFamilyCode", familycode);
            }

            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }

        [WebMethod]
        public static string BindSubSubFamily(string categorycode, string familycode, string subfamilycode)
        {
            StringBuilder sSql = new StringBuilder();
            string language = GetLanguageByUserName(username).ToUpper();
            if (language == "EN-US")
            {
                sSql.Append(@"SELECT [SubSubFamilyNameEN],[SubSubFamilyCode] FROM [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]");
            }
            else if (language == "ZH-CN")
            {
                sSql.Append(@"SELECT [SubSubFamilyNameCN],[SubSubFamilyCode] FROM [dbo].[SODEXO_t_Foun_SCM_FamilyHierarchy]");
            }

            if (categorycode == "Food")
            {
                sSql.Append(@" where CategoryNameEN='Food'");
            }
            else if (categorycode == "Non-Food")
            {
                sSql.Append(@" where CategoryNameEN='Non-Food'");
            }
            else
            {
                sSql.Append(@" where CategoryNameEN='Services'");
            }

            if (language == "EN-US")
            {
                sSql.AppendFormat(@" AND FamilyCode='{0}' AND SubFamilyCode='{1}' group by [SubSubFamilyNameEN],[SubSubFamilyCode] order by SubSubFamilyCode", familycode, subfamilycode);
            }
            else if (language == "ZH-CN")
            {
                sSql.AppendFormat(@" AND FamilyCode='{0}' AND SubFamilyCode='{1}' group by [SubSubFamilyNameCN],[SubSubFamilyCode] order by SubSubFamilyCode", familycode, subfamilycode);
            }

            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());

            return new JsonHelper().DataTableToJson(dt);
        }


        [WebMethod]
        public static string BindInvoiceType()
        {
            StringBuilder sSql = new StringBuilder();
            DataTable dt = new DataTable();
            sSql.AppendFormat(@"select TaxCode,TaxRate,InvoiceTypeDesc from SODEXO_t_Foun_VAT_Config");
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            string jsonStr = DataTableToJsons(dt);
            return jsonStr;
        }

        /// <summary>
        /// 对值中包含单引号的进行处理
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DataTableToJsons(DataTable dt)
        {
            var JsonString = new StringBuilder();
            if (dt.Rows.Count > 0)
            {
                JsonString.Append("[");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    JsonString.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (j < dt.Columns.Count - 1)
                        {
                            string value = dt.Rows[i][j].ToString();
                            if (value.Contains("\""))
                            {
                                value = value.Replace("\"", "\\\"");
                            }
                            if (value.Contains("\\"))
                            {
                                value = value.Replace("\\", "\\\\");
                            }
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + value + "\",");
                        }
                        else if (j == dt.Columns.Count - 1)
                        {
                            string value = dt.Rows[i][j].ToString();
                            if (value.Contains("\""))
                            {
                                value = value.Replace("\"", "\\\"");
                            }
                            if (value.Contains("\\"))
                            {
                                value = value.Replace("\\", "\\\\");
                            }
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + value + "\"");
                        }
                    }
                    if (i == dt.Rows.Count - 1)
                    {
                        JsonString.Append("}");
                    }
                    else
                    {
                        JsonString.Append("},");
                    }
                }
                JsonString.Append("]");
            }
            return JsonString.ToString();
        }

        /// <summary>
        /// json字符串将属性值中的英文双引号变成中文双引号或英文单引号
        /// </summary>
        /// <param name="oldJson">json字符串</param>
        /// <returns></returns>
        private static String jsonString(String oldJson)
        {
            char[] temp = oldJson.ToCharArray();
            int n = temp.Length;
            for (int i = 0; i < n; i++)
            {
                if (temp[i] == ':' && temp[i + 1] == '"')
                {
                    for (int j = i + 2; j < n; j++)
                    {
                        if (temp[j] == '"')
                        {
                            if (temp[j + 1] != ',' && temp[j + 1] != '}')
                            {
                                //temp[j] = '”';
                                temp[j] = '\'';
                            }
                            else if (temp[j + 1] == ',' || temp[j + 1] == '}')
                            {
                                break;
                            }
                        }
                    }
                }
            }
            return new String(temp);
        }



        //private static string SodexoWebApiUrl = "http://trainingsmartwebapi.sodexo-cn.com:8080";

        private static TObj JsonString2Object<TObj>(string str)
        {
            return JsonConvert.DeserializeObject<TObj>(str,
                new JsonSerializerSettings
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver()
                });
        }

        private static string CreateJsonParameters(List<SupplyViewModelDto> ListReferenceSupplers)
        {
            StringBuilder JsonString = new StringBuilder();
            //Exception Handling        
            if (ListReferenceSupplers != null && ListReferenceSupplers.Count > 0)
            {
                JsonString.Append("{ ");
                JsonString.Append("\"T_blog\":[ ");
                foreach (SupplyViewModelDto entity in ListReferenceSupplers)
                {
                    int i = 0;
                    JsonString.Append("{ ");
                    JsonString.Append("\"SupplierCode\":" + "\"" + entity.SupplierCode + "\",");
                    JsonString.Append("\"SupplierNameCN\":" + "\"" + entity.SupplierNameCN + "\",");
                    string tempStr = JsonString.ToString();

                    JsonString.Append(tempStr.Substring(0, tempStr.Length - 1));
                    JsonString.Append("},");
                }
                string tempStr2 = JsonString.ToString();
                JsonString.Append(tempStr2.Substring(0, tempStr2.Length - 1));
                JsonString.Append("]}");
                return JsonString.ToString();
            }
            else
            {
                return null;
            }
        }



        [WebMethod]
        public static string SaveArticle(string rowdata)
        {
            //JObject jo = (JObject)JsonConvert.SerializeObject(rowdata);
            return "";
        }

        //加载采购单位
        [WebMethod]
        public static string BindOrderUnit()
        {
            StringBuilder sSql = new StringBuilder();
            string language = GetLanguageByUserName(username).ToUpper();
            if (language == "EN-US")
            {
                sSql.Append(@"SELECT [OrderUnitAbbr],[OrderUnitEN] FROM [dbo].[SODEXO_OrderUnit]");
            }
            else if (language == "ZH-CN")
            {
                sSql.Append(@"SELECT [OrderUnitAbbr],[OrderUnitCN] FROM [dbo].[SODEXO_OrderUnit]");
            }
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }

        //加载库存单位
        [WebMethod]
        public static string BindBaseUnit()
        {
            StringBuilder sSql = new StringBuilder();
            string language = GetLanguageByUserName(username).ToUpper();
            if (language == "EN-US")
            {
                sSql.Append(@"SELECT [BaseUnitAbbr],[BaseUnitEN] FROM [dbo].[SODEXO_BaseUnit]");
            }
            else if (language == "ZH-CN")
            {
                sSql.Append(@"SELECT [BaseUnitAbbr],[BaseUnitCN] FROM [dbo].[SODEXO_BaseUnit]");
            }
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }


        public static string DataTableToJson(DataTable dt)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
            Dictionary<string, object> childRow;
            foreach (DataRow row in dt.Rows)
            {
                childRow = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    childRow.Add(col.ColumnName, row[col]);
                }
                parentRow.Add(childRow);
            }
            return jsSerializer.Serialize(parentRow);
        }

        //加载子子类别双语
        [WebMethod]
        public static string BindSubSubFamilyCE(string SubSubFamilyCode)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat(@"SELECT SubSubFamilyNameCN,SubSubFamilyNameEN FROM SODEXO_t_Foun_SCM_FamilyHierarchy WHERE SubSubFamilyCode='{0}'", SubSubFamilyCode);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }

        /// <summary>
        /// 查询是否为子分店
        /// </summary>
        /// <param name="sitecode"></param>
        /// <returns></returns>
        private static string IsMasterPC(string sitecode)
        {
            try
            {
                StringBuilder sSql = new StringBuilder();
                DataAccess db = DataAccess.Instance("BizDB");
                sSql.AppendFormat("SELECT * FROM SODEXO_MasterProfitCenter WHERE PCCode='{0}'", sitecode);
                DataTable dt = db.ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count > 0)
                {
                    string parentCode = dt.Rows[0]["ParentPCCode"].ToString();
                    if (parentCode != "")
                    {
                        return parentCode;
                    }
                    else
                    {
                        return "false";
                    }
                }
                else
                {
                    return "false";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("主子PC查询失败，请联系管理员（" + ex.Message + "）");
            }

        }


        [WebMethod]
        public static string BindTaxonomy(string categorycode, int level, string familycode)
        {
            StringBuilder sSql = new StringBuilder();
            string language = GetLanguageByUserName(username).ToUpper();
            var TaxonomyName = "TaxonomyNameCN";
            if (language == "EN-US")
            {
                TaxonomyName = "TaxonomyNameEN";
            }
            sSql.Append(@"SELECT [TaxonomyCode]," + TaxonomyName + " FROM [dbo].[SODEXO_TaxonomyFamilyHierarchy]");
            if (categorycode == "Food")
            {
                sSql.Append(@" where CategoryNameEN='Food'");
            }
            else if (categorycode == "Non-Food")
            {
                sSql.Append(@" where CategoryNameEN='Non-Food'");
            }
            else
            {
                sSql.Append(@" where CategoryNameEN='Services'");
            }
            if (!string.IsNullOrWhiteSpace(familycode))
                sSql.Append(@" and TaxonomyCode like '" + familycode + "%'");
            if (level > 0)
                sSql.Append(@" and  Level='" + level + "'");

            sSql.Append(@" group by [TaxonomyCode]," + TaxonomyName + " order by TaxonomyCode");

            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return new JsonHelper().DataTableToJson(dt);
        }




        public static string BindArticleOld(string sitecode, string articlefamily, string suppliertype, string suppliercode, string category, string searchcondition)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            DataTable dt = new DataTable();
            if (suppliertype == "9")
            {
                sSql.Length = 0;
                if (suppliercode == "")
                {
                    if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                    {
                        sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", sitecode, DateNow, category);
                    }
                    else
                    {
                        sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND ArticleName LIKE N'%{3}%' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", sitecode, DateNow, category, searchcondition);
                    }
                }
                else
                {
                    if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                    {
                        sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND SupplierCode='{3}' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", sitecode, DateNow, category, suppliercode);
                    }
                    else
                    {
                        sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND SupplierCode='{3}' AND ArticleName LIKE N'%{4}%' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", sitecode, DateNow, category, suppliercode, searchcondition);
                    }

                }

                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count == 0)
                {
                    string MasterPC = IsMasterPC(sitecode);
                    if (MasterPC != "false")
                    {
                        #region 查询主PC前30行物料
                        sSql.Length = 0;
                        if (suppliercode == "")
                        {
                            if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                            {
                                sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", MasterPC, DateNow, category);
                            }
                            else
                            {
                                sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND ArticleName LIKE N'%{3}%' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", MasterPC, DateNow, category, searchcondition);
                            }
                        }
                        else
                        {
                            if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                            {
                                sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND SupplierCode='{3}' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", MasterPC, DateNow, category, suppliercode);
                            }
                            else
                            {
                                sSql.AppendFormat(@"SELECT TOP 30 [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],[SupplierCode],[SitePrice],[NetNetPrice] FROM [dbo].[SODEXO_OrderUnit] ou,[dbo].[SODEXO_Article] a,[dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh where ou.OrderUnitAbbr=a.UOM_PurUnit AND a.ArticleFamily=fh.SubSubFamilyCode AND [SiteCode]='{0}' AND EffictiveEndDate>='{1}' and fh.CategoryNameEN='{2}' AND SupplierCode='{3}' AND ArticleName LIKE N'%{4}%' AND ((IsOneTimeUsing=1 AND UseTimes=0) OR IsOneTimeUsing=0) ORDER BY [ArticleName]", MasterPC, DateNow, category, suppliercode, searchcondition);
                            }

                        }
                        #endregion
                        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                    }
                }
            }
            else
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"SELECT [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes] FROM [dbo].[SODEXO_Article] WHERE [SiteCode]='{0}' AND [ArticleFamily]='{1}' ORDER BY [ArticleName]", sitecode, articlefamily);
                dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            //string jsonStr = new JsonHelper().DataTableToJson(dt);
            string jsonStr = DataTableToJsons(dt);
            return jsonStr;
        }
      

        [WebMethod]
        public static string BindArticle(string sitecode, string articlefamily, string suppliertype, string suppliercode, string category, string searchcondition)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            DataTable dt = new DataTable();
            var isMaster = IsMasterPC(sitecode);
            if (isMaster != "false")
            {
                sitecode = isMaster;
            }
            if (suppliertype == "9")
            {
                var spWhere = string.Empty;
                if (!string.IsNullOrWhiteSpace(suppliercode))
                {
                    spWhere = "AND SupplierCode = '" + suppliercode + "'";
                }

                var seWhere = string.Empty;
                if (!string.IsNullOrWhiteSpace(searchcondition.Trim()))
                {
                    seWhere = "AND ArticleName LIKE N'%'" + suppliercode + "'%'";
                }
                sSql.Length = 0;
                sSql.AppendFormat(@"SELECT TOP 30
    [ArticleCode],
    REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],
    [ArticleFamily],
    [UOM_PurUnit],
    [UOM_Pur2InvRate],
    [UOM_InvUnit],
    [UOM_Inv2UseRate],
    [UOM_UseUnit],
    [Gross_weight],
    [NetVolume],
    [NetVolumeUnit],
    [IsOneTimeUsing],
    [UseTimes],
    [SupplierCode],
    [SitePrice],
    [NetNetPrice],
    SubSubFamilyTextCN
FROM
    [dbo].[SODEXO_OrderUnit] ou
    -- 与 SODEXO_Article 表进行内连接
    INNER JOIN [dbo].[SODEXO_Article] a ON ou.OrderUnitAbbr = a.UOM_PurUnit
    -- 与 SODEXO_t_Foun_SCM_FamilyHierarchy 表进行内连接
    INNER JOIN [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh ON a.ArticleFamily =fh.SubSubFamilyCode
WHERE
    [SiteCode] = '{0}'
    AND EffictiveEndDate >= '{1}'
    AND fh.CategoryNameEN = '{2}'
    AND (
        -- 一次性使用且使用次数为 0 或者不是一次性使用的条件
        (IsOneTimeUsing = 1 AND UseTimes = 0)
        OR IsOneTimeUsing = 0
    ) " + spWhere + " " + seWhere + " ORDER BY  [ArticleName];", sitecode, DateNow, category);
            }
            else
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"SELECT [ArticleCode],REPLACE(ArticleName, CHAR(10), '') AS [ArticleName],[ArticleFamily],[UOM_PurUnit],[UOM_Pur2InvRate],[UOM_InvUnit],[UOM_Inv2UseRate],[UOM_UseUnit],[Gross_weight],[NetVolume],[NetVolumeUnit],[IsOneTimeUsing],[UseTimes],
    SubSubFamilyTextCN FROM [dbo].[SODEXO_Article] a  INNER JOIN [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh ON a.ArticleFamily =  fh.SubSubFamilyCode WHERE [SiteCode]='{0}' AND [ArticleFamily]='{1}' ORDER BY [ArticleName]", sitecode, articlefamily);
                //dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            }
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //string jsonStr = new JsonHelper().DataTableToJson(dt);
            string jsonStr = DataTableToJsons(dt);
            return jsonStr;

        }
        [WebMethod]
        public static string BindSupplier(string suppliertype, string searchcondition, string pccode, string subfamilycode)
        {
            string language = GetLanguageByUserName(username).ToUpper();
            if (language == "EN-US")
            {
                language = language.Split('-')[0];
            }
            else if (language == "ZH-CN")
            {
                language = language.Split('-')[1];
            }
            string res = string.Empty;
            StringBuilder sSql = new StringBuilder();

            if (suppliertype == "2" || suppliertype == "5")
            {
                // 核心优化后的SQL构建逻辑
                var sqlBuilder = new StringBuilder();

                // 1. 基础查询（结构化拼接，分行更易读，完全参数化固定值）
                sqlBuilder.AppendLine("SELECT TOP  " + DefaultTopCount + "  SupplierCode, SupplierName" + language + "");
                sqlBuilder.AppendLine("FROM  " + SupplierTable + " ");
                sqlBuilder.AppendLine("WHERE IndustryKey != 'V001' ");

                // 2. 供应商类型条件（简化判断+参数化账户组，避免字符串拼接魔法值）
                string accountGroupCondition = suppliertype == "2"
                    ? "SupplierAccountGroup NOT IN ('E101', 'CASH')"
                    : "SupplierAccountGroup IN ('E101', 'CASH')";
                sqlBuilder.AppendLine("AND " + accountGroupCondition + "");
                // 适配SQL Server的表值参数（更优雅），或拼接为参数化字符串（兼容低版本）         
                // 添加搜索条件
                if (!string.IsNullOrWhiteSpace(searchcondition))
                {
                    sqlBuilder.AppendFormat(
                        " AND (supplierCode LIKE '%"+ searchcondition +"%'" +
                        "OR SupplierName{0} LIKE N'%"+ searchcondition+"%')",
                        language);
                }

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sqlBuilder.ToString());
                res = new JsonHelper().DataTableToJson(dt);
            }
            else
            {
                StringBuilder url = new StringBuilder();
                //string fixedAssetsSignedApproverEmp = System.Web.Configuration.WebConfigurationManager.AppSettings["FixedAssetsSignedApproverEmp"];
                string SodexoWebApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["SodexoWebApiUrl"].ToString();
                string ReferenceSupplierUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["ReferenceSupplierUrl"].ToString();
                string urls = string.Format("{0}{1}", SodexoWebApiUrl, ReferenceSupplierUrl);
                if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                {
                    url.AppendFormat("{2}?pcCode={0}&subSubFamilyCode={1}", pccode, subfamilycode, urls);
                }
                else
                {
                    url.AppendFormat("{3}?pcCode={0}&subSubFamilyCode={1}&supplierCodeOrName={2}", pccode, subfamilycode, searchcondition, urls);
                }
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
                if (string.IsNullOrEmpty(searchcondition))
                {
                    ListReferenceSupplers = ListReferenceSupplers.Take(20).ToList();
                    res = JsonConvert.SerializeObject(ListReferenceSupplers);
                }
                else
                {
                    ListReferenceSupplers = ListReferenceSupplers.Where(s => s.SupplierCode.Contains(searchcondition) || s.SupplierNameCN.Contains(searchcondition)).ToList();

                    res = JsonConvert.SerializeObject(ListReferenceSupplers);
                }

            }
            //sSql.Append(@" group by [FamilyCode],[FamilyNameCN] order by FamilyCode");
            //DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return res;
        }
        [WebMethod]
        public static string GetArticle(string sitecode, string articlefamily, string suppliertype, string suppliercode, string category, string searchcondition)
        {
            StringBuilder sSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            DataTable dt = new DataTable();
            var isMaster = IsMasterPC(sitecode);
            if (isMaster != "false")
            {
                sitecode = isMaster;
            }
            var seWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(searchcondition))
            {
                seWhere = "AND ArticleName LIKE N'%'" + searchcondition + "'%'";
            }
            sSql.Length = 0;
            sSql.AppendFormat(@"
WITH FoodFamilyData AS (
    SELECT 
        fh.CategoryCode,
        fh.SubSubFamilyCode,
        fh.FamilyCode,
        fh.FamilyNameCN,
        fh.SubFamilyCode,
        fh.SubFamilyNameCN,
        fh.SubSubFamilyNameCN
    FROM [dbo].SODEXO_t_Foun_SCM_FamilyHierarchy fh
    WHERE fh.[CategoryNameEN] = '{0}'
),
UnionData AS (
    SELECT 
        REPLACE(a.ArticleName, CHAR(10), '') AS [ArticleName],
        ffd.FamilyCode,
        ffd.FamilyNameCN,
        ffd.SubFamilyCode,
        ffd.SubFamilyNameCN,
        ffd.SubSubFamilyCode,
        ffd.SubSubFamilyNameCN
    FROM [dbo].[SODEXO_Article] a
    INNER JOIN FoodFamilyData ffd 
        ON a.ArticleFamily = ffd.SubSubFamilyCode 
        AND a.CategoryCode = ffd.CategoryCode
        {1}

    UNION ALL
    SELECT 
        REPLACE(a.[ArticleShortNameCN], CHAR(10), '') AS [ArticleName],
        ffd.FamilyCode,
        ffd.FamilyNameCN,
        ffd.SubFamilyCode,
        ffd.SubFamilyNameCN,
        ffd.SubSubFamilyCode,
        ffd.SubSubFamilyNameCN
    FROM [dbo].[SODEXO_t_Foun_SCM_Article] a
    INNER JOIN FoodFamilyData ffd 
        ON a.SubSubFamily = ffd.SubSubFamilyCode 
        AND a.[MerchandiseCategory] = ffd.CategoryCode
        {1}
)
SELECT DISTINCT TOP 30
    [ArticleName],
    FamilyCode,
    FamilyNameCN,
    SubFamilyCode,
    SubFamilyNameCN,
    SubSubFamilyCode,
    SubSubFamilyNameCN
FROM UnionData ", category, seWhere);
           
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            //string jsonStr = new JsonHelper().DataTableToJson(dt);
            string jsonStr = DataTableToJsons(dt);
            return jsonStr;

        }



    }

}