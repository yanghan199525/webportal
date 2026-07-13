<%@ WebHandler Language="C#" Class="PR.PRProcess.CPR_FOOD.Form.AddPRItemPageHandler" %>

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

namespace PR.PRProcess.CPR_FOOD.Form
{
    /// <summary>
    /// Summary description for AddPRItemPageHandler
    /// </summary>
    public class AddPRItemPageHandler : IHttpHandler
    {
        HttpRequest request;
        HttpResponse response;

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            this.request = context.Request;
            this.response = context.Response;
            var categorycode = this.request["categorycode"];
            var method = this.request["Method"] ?? "";
            var familycode = this.request["familycode"] ?? "";
            string username = this.request["username"];
            var SubSubFamilyCode = this.request["SubSubFamilyCode"] ?? "";
            if (username != "")
            {
                username = username.Replace('/', '\\').Split('\\')[1];
            }

            var datadata = this.request["datadata"] ?? "";
            var sitecode = this.request["sitecode"] ?? "";
            var articlefamily = this.request["articlefamily"] ?? "";
            var suppliertype = this.request["suppliertype"] ?? "";
            var suppliercode = this.request["suppliercode"] ?? "";
            var searchcondition = this.request["searchcondition"] ?? "";
            var subfamilycode = this.request["subfamilycode"] ?? "";
            string dt = "";//返回结果
            switch (method)
            {
                case "BindFamily":
                    dt = BindFamily(categorycode, username);
                    break;
                case "BindSubFamily":
                    dt = BindSubFamily(categorycode, familycode, username);
                    break;
                case "BindOrderUnit":
                    dt = BindOrderUnit(username);
                    break;
                case "BindBaseUnit":
                    dt = BindBaseUnit(username);
                    break;
                case "BindSubSubFamily":
                    dt = BindSubSubFamily(categorycode, familycode, subfamilycode, username);
                    break;
                case "BindSubSubFamilyCE":
                    dt = BindSubSubFamilyCE(SubSubFamilyCode);
                    break;
                case "BindSupplier":
                    dt = BindSupplier(suppliertype,searchcondition,sitecode,subfamilycode,username);
                    // dt = BindSupplier(datadata);
                    break;
                case "BindArticle":
                    dt = BindArticle(sitecode, articlefamily, suppliertype, suppliercode, categorycode, searchcondition, username);
                    break;

                default:
                    break;
            }
            if (!string.IsNullOrEmpty(dt))
            {
                this.response.Write(dt);
            }
            else
            {
                this.response.Write("1");
            }
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
        /// <summary>
        /// 绑定物品类别
        /// </summary>
        /// <param name="categorycode"></param>
        /// <returns></returns>
        public static string BindFamily(string categorycode, string username)
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

        /// <summary>
        /// 绑定物品子类别
        /// </summary>
        /// <param name="categorycode"></param>
        /// <param name="familycode"></param>
        /// <returns></returns>
        public static string BindSubFamily(string categorycode, string familycode, string username)
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
        /// <summary>
        /// 物品子子子类别绑定
        /// </summary>
        /// <param name="categorycode"></param>
        /// <param name="familycode"></param>
        /// <param name="subfamilycode"></param>
        /// <returns></returns>
        public static string BindSubSubFamily(string categorycode, string familycode, string subfamilycode, string username)
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
        /// <summary>
        /// 获取物品名称
        /// </summary>
        /// <param name="sitecode"></param>
        /// <param name="articlefamily"></param>
        /// <param name="suppliertype"></param>
        /// <param name="suppliercode"></param>
        /// <param name="category"></param>
        /// <param name="searchcondition"></param>
        /// <returns></returns>
        public static string BindArticle(string sitecode, string articlefamily, string suppliertype, string suppliercode, string category, string searchcondition, string username)
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
        /// <summary>
        /// 绑定供应商信息
        /// </summary>
        /// <param name="suppliertype"></param>
        /// <param name="searchcondition"></param>
        /// <param name="pccode"></param>
        /// <param name="subfamilycode"></param>
        /// <returns></returns>
        public static string BindSupplier(string suppliertype, string searchcondition, string pccode, string subfamilycode, string username)
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
            if (suppliertype == "2")
            {
                if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                {
                    //sSql.Append(@"SELECT top 20 SupplierCode,SupplierNameCN FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup NOT IN('E101','CASH')");
                    sSql.AppendFormat(@"SELECT top 20 SupplierCode,SupplierName{0} FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup NOT IN('E101','CASH')", language);
                }
                else
                {
                    //sSql.AppendFormat(@"SELECT top 20 SupplierCode,SupplierNameCN FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup NOT IN('E101','CASH') AND supplierCode LIKE '%{0}%' OR SupplierNameCN LIKE N'%{0}%'", searchcondition);
                    sSql.AppendFormat(@"SELECT top 20 SupplierCode,SupplierName{1} FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup NOT IN('E101','CASH') AND supplierCode LIKE '%{0}%' OR SupplierName{1} LIKE N'%{0}%'", searchcondition, language);
                }

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                res = new JsonHelper().DataTableToJson(dt);
            }
            else if (suppliertype == "5")
            {
                if (string.IsNullOrEmpty(searchcondition.Trim()) || searchcondition.Trim() == "")
                {
                    //sSql.Append(@"SELECT top 20 SupplierCode,SupplierNameCN FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup IN('E101','CASH')");
                    sSql.AppendFormat(@"SELECT top 20 SupplierCode,SupplierName{0} FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup IN('E101','CASH')", language);
                }
                else
                {
                    //sSql.AppendFormat(@"SELECT top 20 SupplierCode,SupplierNameCN FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup IN('E101','CASH') AND supplierCode LIKE '%{0}%' OR SupplierNameCN LIKE N'%{0}%'", searchcondition);
                    sSql.AppendFormat(@"SELECT top 20 SupplierCode,SupplierName{1} FROM [dbo].[SODEXO_t_Foun_SCM_Suppliers] WHERE SupplierAccountGroup IN('E101','CASH') AND supplierCode LIKE '%{0}%' OR SupplierName{1} LIKE N'%{0}%'", searchcondition, language);
                }

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
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
        //加载采购单位
        public static string BindOrderUnit(string username)
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
        public static string BindBaseUnit(string username)
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
        /// <summary>
        /// 加载子子类别双语
        /// </summary>
        /// <param name="SubSubFamilyCode"></param>
        /// <returns></returns>
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}