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
using Ultimus.UWF.Workflow.Logic;

namespace UWF.Process.PO_SUPPLIER_SUMMARY
{
    public partial class Items : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                var suppliercode = Request.QueryString["suppliercode"];
                string batchnumber = Request.QueryString["batchnumber"];

                DataTable dt = BindArticle(suppliercode, batchnumber);
                this.ArticleSource.DataSource = dt;
                this.ArticleSource.DataBind();
            }
        }
        public DataTable BindArticle(string suppliercode, string batchnumber)
        {

            StringBuilder sSql = new StringBuilder();
            DataTable dt = new DataTable();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");

            var spWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(suppliercode))
            {
                spWhere = "AND SUPPLIERCODE = '" + suppliercode + "'";
            }
            var rfqWhere = string.Empty;
            if (!string.IsNullOrWhiteSpace(batchnumber))
            {
                rfqWhere = "AND BATCHNUMBER = '" + batchnumber + "'";
            }
            sSql.Append(@"SELECT 
                       [SUPPLIERCODE]
                      ,[BATCHNUMBER]
                      ,[ARTICLECODE]
                      ,[ARTICLENAME]
                      ,[GRRECEIVINGQUANTITY]
                      ,[TAXNUMBER]
                      ,[TAXRATEORDER]
                      ,[TAXRATESUPPLIER]
                      ,[TAXRATEDIFFER]
                      ,[NETPRICEORDER]
                      ,[NETPRICESUPPLIER]
                      ,[NETPRICEDIFFER]
                      FROM [dbo].[PROC_PO_SUPPLIER_NETPRICE_ITEMS]
                      WHERE 1=1 " + spWhere + " " + rfqWhere + "  ORDER BY [ArticleName]; ");
            dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return dt;
        }

    }
}