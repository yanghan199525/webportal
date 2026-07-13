using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using UPL.Common.BussinessControl;
using MyLib;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.IO;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class GridExport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public void Export(string ExportString)
        {
            string json = ExportString;
            DataTable dt = ToDataTableTwo(json);
            DataTable dtResult = new DataTable();
            if (dt.Columns.Count==8)
            {
                dtResult.Columns.Add("WBS Element");
                dtResult.Columns.Add("Description");
                dtResult.Columns.Add("Planning Amount");
                dtResult.Columns.Add("是否最底层");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dtResult.NewRow();
                    dr["WBS Element"] = dt.Rows[i][2].ToString();
                    dr["Description"] = dt.Rows[i][3].ToString();
                    dr["Planning Amount"] = dt.Rows[i][4].ToString();
                    dr["是否最底层"] = dt.Rows[i][5].ToString();
                    dtResult.Rows.Add(dr);
                }
            }

            if (dt.Columns.Count == 9)
            {
                dtResult.Columns.Add("WBS Element");
                dtResult.Columns.Add("Description");
                dtResult.Columns.Add("Year");
                dtResult.Columns.Add("Planning Amount");
                dtResult.Columns.Add("是否最底层");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dtResult.NewRow();
                    dr["WBS Element"] = dt.Rows[i][2].ToString();
                    dr["Description"] = dt.Rows[i][3].ToString();
                    dr["Year"] = dt.Rows[i][4].ToString();
                    dr["Planning Amount"] = dt.Rows[i][5].ToString();
                    dr["是否最底层"] = dt.Rows[i][6].ToString();
                    dtResult.Rows.Add(dr);
                }
            }
            
            if (dt != null)
            {
                string fileName = string.Format("{0:yyyy-MM-dd_HH_mm}.xlsx", DateTime.Now);
                //string fileName = "Project Application_CER Upload Template.xlsx";
                string urlPath = "/Solution/UWF.Process.ProjectApplication/ExportExcel/" + fileName; // 文件下载的URL地址，供给前台下载
                string filePath = HttpContext.Current.Server.MapPath(urlPath); // 文件路径
                TableToExcel(dtResult, filePath, fileName);
                Response.Write("<script>window.opener=null;window.close();</script>");// 不会弹出询问
                //ExcelHelper.ExportByWeb(dtResult, "", fileName);
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            Export(hfExportString.Value);
        }

        /// <summary>
        /// Json 字符串 转换为 DataTable数据集合
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public static DataTable ToDataTableTwo(string json)
        {
            DataTable dataTable = new DataTable();  //实例化
            DataTable result;
            try
            {
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                javaScriptSerializer.MaxJsonLength = Int32.MaxValue; //取得最大数值
                ArrayList arrayList = javaScriptSerializer.Deserialize<ArrayList>(json);
                if (arrayList.Count > 0)
                {
                    foreach (Dictionary<string, object> dictionary in arrayList)
                    {
                        if (dictionary.Keys.Count<string>() == 0)
                        {
                            result = dataTable;
                            return result;
                        }
                        //Columns
                        if (dataTable.Columns.Count == 0)
                        {
                            foreach (string current in dictionary.Keys)
                            {
                                dataTable.Columns.Add(current, dictionary[current].GetType());
                            }
                        }
                        //Rows
                        DataRow dataRow = dataTable.NewRow();
                        foreach (string current in dictionary.Keys)
                        {
                            dataRow[current] = dictionary[current];
                        }
                        dataTable.Rows.Add(dataRow); //循环添加行到DataTable中
                    }
                }
            }
            catch
            {
            }
            result = dataTable;
            return result;
        }

        #region Datable导出成Excel
        /// <summary>
        /// Datable导出成Excel
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="file">导出路径(包括文件名与扩展名)</param>
        public static void TableToExcel(DataTable dt, string file, string FileName)
        {
            //实例工作簿
            IWorkbook workbook;
            string fileExt = Path.GetExtension(FileName);
            if (fileExt == ".xlsx") { workbook = new XSSFWorkbook(); } else if (fileExt == ".xls") { workbook = new HSSFWorkbook(); } else { workbook = null; }
            if (workbook == null) { return; }
            //创建Sheet
            ISheet sheet = string.IsNullOrEmpty(dt.TableName) ? workbook.CreateSheet("Sheet1") : workbook.CreateSheet(dt.TableName);

            //表头  
            IRow row = sheet.CreateRow(0);
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                ICell cell = row.CreateCell(i);
                cell.SetCellValue(dt.Columns[i].ColumnName);
            }
            //数据  
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                IRow row1 = sheet.CreateRow(i + 1);
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    ICell cell = row1.CreateCell(j);
                    cell.SetCellValue(dt.Rows[i][j].ToString());
                }
            }

            //转为字节数组  
            MemoryStream stream = new MemoryStream();
            workbook.Write(stream);
            var buf = stream.ToArray();

            //保存为Excel文件  
            using (FileStream fs = new FileStream(file, FileMode.Create, FileAccess.Write))
            {
                fs.Write(buf, 0, buf.Length);
                fs.Flush();
                HttpContext.Current.Response.ContentType = "application/octet-stream;charset=gb2321";
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(FileName, System.Text.Encoding.UTF8));
                HttpContext.Current.Response.BinaryWrite(buf);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
        }
        #endregion

    }
}