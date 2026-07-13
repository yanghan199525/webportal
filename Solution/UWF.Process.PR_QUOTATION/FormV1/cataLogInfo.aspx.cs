using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Workflow.Interface;

namespace UWF.Process.PR_QUOTATION.FormV1
{
    public partial class cataLogInfo : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            //20230323
            string cataLogID = Request.QueryString["cataLogID"];
            string incident = Request.QueryString["incident"];
            hdCheckApproved.Value= Request.QueryString["approval"];
            //求该数据集合的记录总和
            this.hdIncident.Value = incident;
            BindData();
        }
        void BindData()
        {
            string cataLogID = Request.QueryString["cataLogID"];

            string sSql = null;
            #region 查询sql拼接
            string city = this.txt_City.Text.Trim();
            string upstreamSupplierCode = this.txt_upstreamSupplierCode.Text.Trim();
            string articleCode = this.txt_ArticleCode.Text.Trim();
            string subSubFy = this.txt_FamilyName.Text.Trim();
            string txt_Purchaser = this.txt_Purchaser.Text.Trim();
            string region = this.txt_Region.Text.Trim();
            string sql = null;
            if (city != "")
            {
                sql += "City like N'%" + city + "%' and";
            }
            if (upstreamSupplierCode != "")
            {
                sql += "( upstreamSupplierCode like '%" + upstreamSupplierCode + "%' or upstreamSupplierName like N'%"+ upstreamSupplierCode + "%') and";
            }
            if (articleCode != "")
            {
                sql += "( articleCode like'%" + articleCode + "%' or articleName like N'%" + articleCode + "%' ) and";
            }
            if (subSubFy != "")
            {
                sql += " ( Family like'%" + subSubFy + "%' or FamilyName like N'%" + subSubFy + "%' or subSubFy like N'%" + subSubFy + "%' or subSubFyName like N'%" + subSubFy + "%') and";
            }
            if (region != "")
            {
                sql += " Region like N'%" + region + "%' and";
            }
            if (txt_Purchaser != "")
            {
                sql += " Purchaser like N'%" + txt_Purchaser + "%' and";
            }
            #endregion
            if (sql != null)
            {
                sql = sql.Remove(sql.Trim().Length - 3);
                int num = Convert.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(string.Format("SELECT count(0) from PROC_CataLogArticle where {0} and ApprovalNo='{1}'", sql, cataLogID)));
                this.AspNetPager1.RecordCount = num;
                int RecordPage = (AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize;
                sSql = string.Format("select * from PROC_CataLogArticle where {1} and ApprovalNo='{2}' order by PreviewId offset {0} rows fetch next 500 rows only", RecordPage.ToString(), sql, cataLogID);
            }
            else
            {
                int num = Convert.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(string.Format("SELECT count(0) from PROC_CataLogArticle where ApprovalNo='{0}' ", cataLogID)));
                this.AspNetPager1.RecordCount = num;
                int RecordPage = (AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize;
                sSql = String.Format(" select * from PROC_CataLogArticle where ApprovalNo='{1}' order by PreviewId offset {0} rows fetch next 500 rows only", RecordPage.ToString(),cataLogID);
            }

            DataTable table = DataAccess.Instance("BizDB").ExecuteDataTable(sSql);
            CataLogReport.DataSource = table;
            CataLogReport.DataBind();
            //动态设置用户自定义文本内容
            this.AspNetPager1.CustomInfoHTML = "记录总数：<font color=\"blue\"><b>" + AspNetPager1.RecordCount.ToString() + "</b></font>";
            AspNetPager1.CustomInfoHTML += " 总页数：<font color=\"blue\"><b>" + AspNetPager1.PageCount.ToString() + "</b></font>";
            AspNetPager1.CustomInfoHTML += " 当前页：<font color=\"red\"><input type='button' style='border:none;' id='CurrentPageIndex' value='" + AspNetPager1.CurrentPageIndex.ToString() + "'> </font>";
        }
        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btn_Serch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            
        }
        protected void closeForm_Click(object sender, EventArgs e)
        {
            string type= Request.QueryString["Type"];
            string incident = Request.QueryString["incident"];
            string TaskID = Request.QueryString["TaskID"];
            string userName = Request.QueryString["userName"];
            string StepName = Request.QueryString["StepName"];
            string path = getRootPath();
            string url;
            if (StepName.ToUpper().Contains("SOURCING"))
            {
                url = string.Format("{0}/Solution/UWF.Process.{1}/FormV1/Approval.aspx?ProcessName={1}&StepName=Sourcing%20Director&Incident={2}&TaskID={3}&UserName={4}&Type={5}", path, "PR_QUOTATION", incident, TaskID, userName, type);
            }
            else {
                url = string.Format("{0}/Solution/UWF.Process.{1}/FormV1/Approval.aspx?ProcessName={1}&StepName=Director%20Of%20Supply%20Management&Incident={2}&TaskID={3}&UserName={4}&Type={5}", path, "PR_QUOTATION", incident, TaskID, userName, type);
            }
            //
            Response.Redirect(url);
        }
     
     
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
        public static bool UpdateCataLogArticle(string jsonStr)
        {
            try
            {
                JavaScriptSerializer js = new JavaScriptSerializer();
                List<CatALogArticle> list = js.Deserialize<List<CatALogArticle>>(jsonStr);
                DataTable table = ListToDataTable<CatALogArticle>(list);
                SaveCateLogArticle(table);
                string sSql = "UPDATE a SET a.IsAgree=b.item,a.ReMark=b.remark from PROC_CataLogArticle_Cursor b left join PROC_CataLogArticle a on a.ApprovalNo=b.ApprovalNo and a.PreviewId=b.PreviewId";
                DataAccess.Instance("BizDB").ExecuteNonQuery(sSql);
                DataAccess.Instance("BizDB").ExecuteNonQuery("delete from PROC_CataLogArticle_Cursor");
                return true;
            }
            catch (Exception ex)
            {
                LogUtil.Error("报价单物料信息更新失败，失败原因:" + ex.Message);
                return false;
            }

        }
        [WebMethod]
        public static bool SaveApprovalResult(string incident) {
            StringBuilder url = new StringBuilder();
            string SodexoWebApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["BPMWebApiUrl"].ToString();
            url.AppendFormat("{2}?incident={0}&approvalResult={1}", incident, 0, SodexoWebApiUrl);
            Encoding encoding = Encoding.UTF8;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url.ToString());
            request.Method = "GET";
            request.Accept = "application/json,text/javascript,*/*";
            request.ContentType = "application/json;charset=utf-8";
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (StreamReader reader = new StreamReader(response.GetResponseStream(), encoding))
            {
                 reader.ReadToEnd();
            }
            return true;
        }
        /// <summary>
        /// 将List转换为DataTable
        /// </summary>
        /// <param name="list">请求数据</param>
        /// <returns></returns>
        public static DataTable ListToDataTable<T>(List<T> list)
        {

            DataTable dataTable = new DataTable();

            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                dataTable.Columns.Add(prop.Name);
            }

            foreach (T obj in list)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    values[i] = Props[i].GetValue(obj, null);
                }
                dataTable.Rows.Add(values);
            }

            return dataTable;
        }

        /// <summary>
        /// 批量保存报价单物料数据
        /// </summary>
        /// <param name="table"></param>
        public static void SaveCateLogArticle(DataTable table)
        {
            table.TableName = "PROC_CataLogArticle_Cursor";
            string connectionStr = ConfigurationManager.ConnectionStrings["BizDB"].ToString();
            SqlConnection connection = new SqlConnection(connectionStr);
            using (connection)
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(connectionStr, SqlBulkCopyOptions.UseInternalTransaction))
                {
                    try
                    {
                        sqlBulkCopy.DestinationTableName = "PROC_CataLogArticle_Cursor";
                        sqlBulkCopy.BatchSize = table.Rows.Count;
                        for (int i = 0; i < table.Columns.Count; i++)
                        {
                            sqlBulkCopy.ColumnMappings.Add(table.Columns[i].ColumnName, table.Columns[i].ColumnName);
                        }
                        sqlBulkCopy.WriteToServer(table);

                    }
                    catch (Exception ex)
                    {
                        LogUtil.Error("插入数据报错，错误原因："+ex.Message);
                    }
                }
            }
        }
        public class CatALogArticle
        {
            public string ApprovalNo { get; set; }
            public string PreviewId { get; set; }//物料
            public string item { get; set; }
            public string remark { get; set; }
        }
    }
}