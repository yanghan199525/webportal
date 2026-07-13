using MyLib;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class YGArticle : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            SelectArticle();
        }
        public void SelectArticle()
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable table = db.ExecuteDataTable("select SKU,supplierCode,supplierName,skuName,categroyCode,orderUnit,conversion,InventoryUnit,consumption,consumptionUnit,sitePrice,InvoiceType,taxCode,NetGoodsAmount,ArtType FROM PROC_YG_ARTICLE");
            List<Article> list = ArticleToList(table);
            this.Repeater1.DataSource = list;
            this.Repeater1.DataBind();
        }
        public List<Article> ArticleToList(DataTable dt)
        {
            List<Article> list = new List<Article>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Article user = new Article();
                user.SKU = dt.Rows[i]["SKU"].ToString();
                user.supplierCode = dt.Rows[i]["supplierCode"].ToString();
                user.supplierName = dt.Rows[i]["supplierName"].ToString();
                user.skuName = dt.Rows[i]["skuName"].ToString();
                user.categroyCode = dt.Rows[i]["categroyCode"].ToString();
                user.orderUnit = dt.Rows[i]["orderUnit"].ToString();
                user.conversion = dt.Rows[i]["conversion"].ToString();
                user.InventoryUnit = dt.Rows[i]["InventoryUnit"].ToString();
                user.consumption = dt.Rows[i]["consumption"].ToString();
                user.consumptionUnit = dt.Rows[i]["consumptionUnit"].ToString();
                user.sitePrice = dt.Rows[i]["sitePrice"].ToString();
                user.InvoiceType = dt.Rows[i]["InvoiceType"].ToString();
                user.taxCode = dt.Rows[i]["taxCode"].ToString();
                user.NetGoodsAmount = dt.Rows[i]["NetGoodsAmount"].ToString();
                user.ArtType = dt.Rows[i]["ArtType"].ToString();
                list.Add(user);
            }
            return list;
        }
        protected void UploadBtn_Click(object sender, EventArgs e)
        {
            if (ExcelFileUpload.HasFile == false)//检查是否选择了文件
            {
                Response.Write("<script>alert('请您选择Excel文件')</script> ");
                return;//当无文件时,返回
            }
            //获取山川文件的后缀名
            string type = Path.GetExtension(ExcelFileUpload.FileName).ToString().ToLower();
            //进行类型判断
            if (type != ".xls" && type != ".xlsx")
            {
                Response.Write("<script>alert('您选择的文件格式不正确！请选择Excel文件')</script> ");
                return;
            }
            string name = ExcelFileUpload.FileName;
            name = string.Format("{0}{1}", DateTime.Now.ToString("yyyyMMddHHmmssfff"),name);
            string SavePath = Server.MapPath(("YGFile\\") + name);
            DataTable ds = new DataTable();
            ExcelFileUpload.SaveAs(SavePath);
            List<Article> list = GetExcelDatatable(SavePath, name);
            RepeatData(list);
            if (RepeatData(list))
            {
                InsertProfitCenters(list);
                this.Repeater1.DataSource = list;
                this.DataBind();
                Response.Write("<script>alert('文件上传成功！')</script> ");
            }
        }

        /// <summary>
        ///重复数据判断,并页面弹框
        /// </summary>
        public bool RepeatData(List<Article> list)
        {
            foreach (var item in list)
            {
                if (Convert.ToDecimal(item.conversion) <= 0) {
                    Response.Write("<script type='text/javascript'>alert('转换率必须大于零')</script>");
                    return false;
                }
            }
            int result = list.GroupBy(g => new { g.SKU }).Select(g => new { sku = g.Key.SKU, Num = g.Count() }).Where(g => g.Num > 1).Count();
            if (result > 0)
            {
                var sku = list.GroupBy(g => new { g.SKU}).Select(g => new { sku = g.Key.SKU, Num = g.Count() }).Where(g => g.Num > 1).Select(i => i);
                //var error=string.Format($"重复的：EmployeeNumber :{string.Join(",", resultEmployeeNumber)}; \r\n ");
                var error = string.Format($"{ string.Join(",", sku.Select(g => g.sku))}");
                error += string.Format($"{ string.Join(",", sku.Select(g => g.sku))}");
                Response.Write("<script type='text/javascript'>alert('SKU编号重复，重复数据:" + error + "')</script>");
                return false;
            }
            else
            {
                return true ;
            }
        }
        private List<Article> GetExcelDatatable(string filePath, string name)
        {
            var list = new List<Article>();
            FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            XSSFWorkbook workBook = new XSSFWorkbook(fileStream);
            int sheetCount = workBook.Count;
            if (sheetCount > 0)
            {
                var sheet = workBook.GetSheet("YG_Article");//获取Excel的指定SHEET的数据

                //从第二行开始导入，第一行是列名
                for (int r = 1; r <= sheet.LastRowNum; r++)
                {
                    IRow row = sheet.GetRow(r);
                    if (string.IsNullOrWhiteSpace(GetCellValue(row, 1)))
                    {
                        continue;
                    }

                    Article article = new Article()
                    {
                        supplierCode = GetCellValue(row, 0),
                        supplierName = GetCellValue(row, 1),
                        //Sex = GetCellValue(row, 2),
                        SKU = GetCellValue(row, 2),
                        skuName = GetCellValue(row, 3),
                        categroyCode = GetCellValue(row, 4),
                        orderUnit = GetCellValue(row, 5),
                        conversion = GetCellValue(row, 6),
                        InventoryUnit = GetCellValue(row, 7),
                        consumption = GetCellValue(row, 8),
                        consumptionUnit = GetCellValue(row, 9),
                        sitePrice = GetCellValue(row, 10),
                        InvoiceType = GetCellValue(row, 11),
                        taxCode = GetCellValue(row, 12),
                        NetGoodsAmount = GetCellValue(row, 13),
                        ArtType = GetCellValue(row, 14),
                    };

                    list.Add(article);
                }
            }

            return list;
        }
        private string GetCellValue(IRow row, int colIndex)
        {
            if (row != null)
            {
                ICell cell = row.GetCell(colIndex);
                if (cell != null)
                {
                    if (cell.CellType == CellType.String)
                    {
                        return cell.StringCellValue.Trim();
                    }
                    if (cell.CellType == CellType.Numeric)
                    {
                        return cell.NumericCellValue.ToString().Trim();
                    }
                    return cell.StringCellValue.Trim();
                }
            }
            return string.Empty;
        }
        /// <summary>
        /// 插入月度通知人信息
        /// </summary>
        /// <param name="list"></param>
        public void InsertProfitCenters(List<Article> list)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            db.ExecuteNonQuery("DELETE FROM PROC_YG_ARTICLE");
            foreach (var item in list)
            {
                try
                {
                    db.ExecuteNonQuery(String.Format("INSERT INTO PROC_YG_ARTICLE values(NEWID(),'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}',N'{11}',N'{12}',N'{13}',N'{14}')", item.SKU, item.supplierCode, item.supplierName, item.skuName, item.categroyCode, item.orderUnit, item.conversion, item.InventoryUnit, item.consumption, item.consumptionUnit, item.sitePrice, item.InvoiceType, item.taxCode, item.NetGoodsAmount,item.ArtType));
                }
                catch (Exception)
                {

                    throw;
                }

            }

        }
        public class Article {
            public string SKU { get; set; }
            public string supplierCode { get; set; }
            public string supplierName { get; set; }
            public string skuName { get; set; }
            public string categroyCode { get; set; }
            public string orderUnit { get; set; }
            public string conversion { get; set; }
            public string InventoryUnit { get; set; }
            public string consumption { get; set; }
            public string consumptionUnit { get; set; }
            public string sitePrice { get; set; }
            public string InvoiceType { get; set; }
            public string taxCode { get; set; }
            public string NetGoodsAmount { get; set; }
            public string ArtType { get; set; }
        }
    }
}