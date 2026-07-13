using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ultimus.UWF.Home.V3
{
    public partial class SetCOOByOd : System.Web.UI.Page
    {
        PagedDataSource pds = new PagedDataSource();
        protected void Page_Load(object sender, EventArgs e)
        {
            SelectEmailUser();


        }
        /// <summary>
        /// 邮件通知人
        /// </summary>
        public void SelectEmailUser()
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable table = db.ExecuteDataTable("select EMPNO,ND FROM PROC_PROCESSSTEPAPPROVER_COO");
            List<SetCOOByOdModel> list = UuserToList(table);
            bind(list);
        }
        /// <summary>
        ///分页
        /// </summary>
        /// <param name="list"></param>
        public void bind(List<SetCOOByOdModel> list)
        {
            this.AspNetPager1.PageSize = 2;
            this.AspNetPager1.RecordCount = list.Count;
            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.CurrentPageIndex = this.AspNetPager1.CurrentPageIndex-1;
            pds.PageSize = AspNetPager1.PageSize;
            this.Repeater1.DataSource = pds;
            this.Repeater1.DataBind();
        }

        /// <summary>
        /// 插入月度通知人信息
        /// </summary>
        /// <param name="list"></param>
        public void InsertEmailUser(List<SetCOOByOdModel> list)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            db.ExecuteNonQuery("DELETE FROM PROC_PROCESSSTEPAPPROVER_COO");
            foreach (var item in list)
            {
                try
                {
                    db.ExecuteNonQuery(String.Format("INSERT INTO PROC_PROCESSSTEPAPPROVER_COO values(NEWID(),'{0}','{1}')", item.EMPNO, item.ND));
                }
                catch (Exception)
                {

                    throw;
                }

            }

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
            string SavePath = Server.MapPath(("UplodeExcel\\") + name);
            DataTable ds = new DataTable();
            ExcelFileUpload.SaveAs(SavePath);
            DataTable dt = GetExcelDatatable(SavePath);
            //if (!RepeatData(list))
            // {
            InsertEmailUser(EmailInfo(dt));
            bind(EmailInfo(dt));
            File.Delete(SavePath);//删除文件
            Response.Write("<script>alert('文件上传成功！')</script> ");
            //}


        }
        /// <summary>
        ///重复数据判断,并页面弹框
        /// </summary>
        public bool RepeatData(List<SetCOOByOdModel> list)
        {
            int result = list.GroupBy(g => new { g.ND, g.EMPNO }).Select(g => new { ND = g.Key.ND, EMPNO = g.Key.EMPNO, Num = g.Count() }).Where(g => g.Num > 1).Count();
            if (result > 0)
            {
                var resultND = list.GroupBy(g => new { g.ND, g.EMPNO }).Select(g => new { ND = g.Key.ND, EMPNO = g.Key.EMPNO, Num = g.Count() }).Where(g => g.Num > 1).Select(i => i);
                //var error=string.Format($"重复的：EmployeeNumber :{string.Join(",", resultEmployeeNumber)}; \r\n ");
                var error = string.Format($"{ string.Join(",", resultND.Select(g => g.EMPNO))}");
                error += string.Format($"{ string.Join(",", resultND.Select(g => g.ND))}");
                Response.Write("<script type='text/javascript'>alert('用户编号不能重复，重复数据:" + error + "')</script>");
                return true;
            }
            else
            {
                return false;
            }
        }


        public List<SetCOOByOdModel> UuserToList(DataTable dt) {
            List<SetCOOByOdModel> list = new List<SetCOOByOdModel>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SetCOOByOdModel user = new SetCOOByOdModel();
                user.EMPNO = dt.Rows[i][0].ToString();
                user.ND = dt.Rows[i][1].ToString();
                list.Add(user);
            }
            return list;
        }

        /// <summary>
        /// 将数据转化成集合,并且根据列名来匹配数据
        /// </summary>
        /// <param name="dt"></param>
        public List<SetCOOByOdModel> EmailInfo(DataTable dt)
        {
            List<SetCOOByOdModel> list = new List<SetCOOByOdModel>();
            if (dt.Rows[0][0].ToString() == "EMPNO" && dt.Rows[0][1].ToString() == "ND")
            {
                for (int i = 1; i < dt.Rows.Count; i++)
                {
               
                    SetCOOByOdModel user = new SetCOOByOdModel();
                    user.EMPNO = dt.Rows[i][0].ToString();
                    user.ND = dt.Rows[i][1].ToString();
                    list.Add(user);
                }

            }
            else if (dt.Rows[0][0].ToString() == "ND" && dt.Rows[0][1].ToString() == "EMPNO")
            {
                for (int i = 1; i < dt.Rows.Count; i++)
                {
                    SetCOOByOdModel user = new SetCOOByOdModel();
                    user.EMPNO = dt.Rows[i][1].ToString();
                    user.ND = dt.Rows[i][0].ToString();
                    list.Add(user);
                }
            }
            list = Compare(list);
            return list;
        }

        /// <summary>
        /// 去除list里面的重复数据
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public  List<SetCOOByOdModel> Compare(List<SetCOOByOdModel> list){

            for (int i = 0; i < list.Count; i++)
            {
                for (int j = list.Count - 1;  j > i; j--)
                {
                    if (list[i].ND == list[j].ND&& list[i].EMPNO == list[j].EMPNO) {
                        list.RemoveAt(j);
                    }
                }
            }
            return list;
        }
        /// <summary>
        /// 读取Excel文件
        /// </summary>
        /// <param name="fileUrl"></param>
        /// <returns></returns>
        private static DataTable GetExcelDatatable(string fileUrl)
        {
            string connstring = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileUrl + ";Extended Properties='Excel 8.0;HDR=No;IMEX=1';";

            System.Data.DataTable dt = null;
            OleDbConnection conn = new OleDbConnection(connstring);
            try
            {
                if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                string strSql = "select * from [Sheet1$]";
                OleDbDataAdapter da = new OleDbDataAdapter(strSql, conn);
                DataTable ds = new DataTable();
                da.Fill(ds);
                dt = ds;
                return dt;
            }
            catch (Exception exc)
            {
                throw exc;
            }
            finally
            {
                conn.Close();
                conn.Dispose();
            }

        }


        public class SetCOOByOdModel
        {
            public string ID { get; set; }
            /// <summary>
            /// 用户编号
            /// </summary>
            public string EMPNO { get; set; }
            /// <summary>
            /// ND编号
            /// </summary>
            public string ND { get; set; }

        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 条件查询 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btn_Search_Click(object sender, EventArgs e)
        {
            TextBox txt_EMPNO = (TextBox)Page.FindControl("txt_EMPNO");
            TextBox txt_ND = (TextBox)Page.FindControl("txt_ND");
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable table = db.ExecuteDataTable("select EMPNO,ND FROM PROC_PROCESSSTEPAPPROVER_COO");
            List<SetCOOByOdModel> list = UuserToList(table);
            if (!string.IsNullOrEmpty(txt_EMPNO.Text))
            {
                list = list.Where(x => x.EMPNO.Contains(txt_EMPNO.Text)).ToList();
            }
            if  (!string.IsNullOrEmpty(txt_ND.Text))
            {
                list = list.Where(x => x.ND.Contains(txt_ND.Text)).ToList();
            }
            bind(list);
        }
    }
 
}