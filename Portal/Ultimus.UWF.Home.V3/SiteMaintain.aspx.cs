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
    public partial class SiteMaintain : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            SelectProfitCenters();
        }
        public void SelectProfitCenters()
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable table = db.ExecuteDataTable("select siteCode,siteName,siteManage,address FROM PROC_YG_ProfitCenters");
            List<site> list = ProfitCentersToList(table);
            this.Repeater1.DataSource = list;
            this.Repeater1.DataBind();
        }
        public List<site> ProfitCentersToList(DataTable dt)
        {
            List<site> list = new List<site>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                site user = new site();
                user.siteCode = dt.Rows[i]["siteCode"].ToString();
                user.siteName = dt.Rows[i]["siteName"].ToString();
                user.siteManage = dt.Rows[i]["siteManage"].ToString();
                user.address = dt.Rows[i]["address"].ToString();
                list.Add(user);
            }
            return list;
        }
        /// <summary>
        /// Excel文件上传
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
            name = string.Format("{0}{1}", DateTime.Now.ToString("yyyyMMddHHmmssfff"), name);
            string SavePath = Server.MapPath(("YGFile\\") + name);
            DataTable ds = new DataTable();
            ExcelFileUpload.SaveAs(SavePath);
            List<site> list = GetExcelDatatable(SavePath,name);
            //if (!RepeatData(list))
            // {
            InsertProfitCenters(list);
            this.Repeater1.DataSource = list;
            this.DataBind();
            Response.Write("<script>alert('文件上传成功！')</script> ");
        }
        private List<site> GetExcelDatatable(string filePath,string name)
        {
            var list = new List<site>();
            FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            XSSFWorkbook workBook = new XSSFWorkbook(fileStream);
            int sheetCount = workBook.Count;
            if (sheetCount > 0)
            {
                var sheet = workBook.GetSheet("YG_Site");//获取Excel的指定SHEET的数据

                //从第二行开始导入，第一行是列名
                for (int r = 1; r <= sheet.LastRowNum; r++)
                {
                    IRow row = sheet.GetRow(r);
                    if (string.IsNullOrWhiteSpace(GetCellValue(row, 1)))
                    {
                        continue;
                    }

                   site site = new site()
                    {
                        address = GetCellValue(row, 0),
                        siteCode = GetCellValue(row, 1),
                        //Sex = GetCellValue(row, 2),
                        siteName = GetCellValue(row, 2),
                        siteManage = GetCellValue(row, 3),
                    };

                    list.Add(site);
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
        public void InsertProfitCenters(List<site> list)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            db.ExecuteNonQuery("DELETE FROM PROC_YG_ProfitCenters");
            foreach (var item in list)
            {
                try
                {
                    db.ExecuteNonQuery(String.Format("INSERT INTO PROC_YG_ProfitCenters values(NEWID(),'{0}',N'{1}',N'{2}',N'{3}')", item.siteCode, item.siteName,item.siteManage,item.address));
                }
                catch (Exception)
                {

                    throw;
                }

            }

        }
        public class site {
            public string siteCode { get; set; }
            public string siteName { get; set; }
            public string siteManage { get; set; }
            public string address { get; set; }
        }
    }
}