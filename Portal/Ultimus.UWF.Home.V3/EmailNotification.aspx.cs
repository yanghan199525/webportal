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
    public partial class EmailNotification : System.Web.UI.Page
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
            DataTable table = db.ExecuteDataTable("select LoginName,CXCode FROM PROC_Monthly_Notification");
            List<NotificationUser> list = UuserToList(table);
            bind(list);
        }
        /// <summary>
        ///分页
        /// </summary>
        /// <param name="list"></param>
        public void bind(List<NotificationUser> list)
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
        public void InsertEmailUser(List<NotificationUser> list)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            db.ExecuteNonQuery("DELETE FROM PROC_Monthly_Notification");
            foreach (var item in list)
            {
                try
                {
                    db.ExecuteNonQuery(String.Format("INSERT INTO PROC_Monthly_Notification values(NEWID(),'{0}','{1}',GETDATE())", item.UserName, item.CXCode));
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
        public bool RepeatData(List<NotificationUser> list)
        {
            int result = list.GroupBy(g => new { g.CXCode, g.UserName }).Select(g => new { CXCode = g.Key.CXCode, Username = g.Key.UserName, Num = g.Count() }).Where(g => g.Num > 1).Count();
            if (result > 0)
            {
                var resultCXCode = list.GroupBy(g => new { g.CXCode, g.UserName }).Select(g => new { CXCode = g.Key.CXCode, Username = g.Key.UserName, Num = g.Count() }).Where(g => g.Num > 1).Select(i => i);
                //var error=string.Format($"重复的：EmployeeNumber :{string.Join(",", resultEmployeeNumber)}; \r\n ");
                var error = string.Format($"{ string.Join(",", resultCXCode.Select(g => g.Username))}");
                error += string.Format($"{ string.Join(",", resultCXCode.Select(g => g.CXCode))}");
                Response.Write("<script type='text/javascript'>alert('分店编号不能重复，重复数据:" + error + "')</script>");
                return true;
            }
            else
            {
                return false;
            }
        }


        public List<NotificationUser> UuserToList(DataTable dt) {
            List<NotificationUser> list = new List<NotificationUser>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                NotificationUser user = new NotificationUser();
                user.UserName = dt.Rows[i][0].ToString();
                user.CXCode = dt.Rows[i][1].ToString();
                list.Add(user);
            }
            return list;
        }

        /// <summary>
        /// 将数据转化成集合,并且根据列名来匹配数据
        /// </summary>
        /// <param name="dt"></param>
        public List<NotificationUser> EmailInfo(DataTable dt)
        {
            List<NotificationUser> list = new List<NotificationUser>();
            if (dt.Rows[0][0].ToString() == "UserName" && dt.Rows[0][1].ToString() == "CXCode")
            {
                for (int i = 1; i < dt.Rows.Count; i++)
                {
               
                    NotificationUser user = new NotificationUser();
                    user.UserName = dt.Rows[i][0].ToString();
                    user.CXCode = dt.Rows[i][1].ToString();
                    list.Add(user);
                }

            }
            else if (dt.Rows[0][0].ToString() == "CXCode" && dt.Rows[0][1].ToString() == "UserName")
            {
                for (int i = 1; i < dt.Rows.Count; i++)
                {
                    NotificationUser user = new NotificationUser();
                    user.UserName = dt.Rows[i][1].ToString();
                    user.CXCode = dt.Rows[i][0].ToString();
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
        public  List<NotificationUser> Compare(List<NotificationUser> list){

            for (int i = 0; i < list.Count; i++)
            {
                for (int j = list.Count - 1;  j > i; j--)
                {
                    if (list[i].CXCode == list[j].CXCode&& list[i].UserName == list[j].UserName) {
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


        public class NotificationUser
        {
            public string ID { get; set; }
            /// <summary>
            /// 用户名
            /// </summary>
            public string UserName { get; set; }
            /// <summary>
            /// 员工编号
            /// </summary>
            public string CXCode { get; set; }

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
            TextBox txt_UserName = (TextBox)Page.FindControl("txt_UserName");
            TextBox txt_CXCode = (TextBox)Page.FindControl("txt_CXCode");
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable table = db.ExecuteDataTable("select LoginName,CXCode FROM PROC_Monthly_Notification");
            List<NotificationUser> list = UuserToList(table);
            if (!string.IsNullOrEmpty(txt_UserName.Text) && string.IsNullOrEmpty(txt_CXCode.Text))
            {
                list = list.Where(x => x.UserName.Contains(txt_UserName.Text)).ToList();
            }
            else if (string.IsNullOrEmpty(txt_UserName.Text) && !string.IsNullOrEmpty(txt_CXCode.Text))
            {
                list = list.Where(x => x.CXCode.Contains(txt_CXCode.Text)).ToList();
            } else if (!string.IsNullOrEmpty(txt_UserName.Text) && !string.IsNullOrEmpty(txt_CXCode.Text))
            {
                list = list.Where(x => x.UserName.Contains(txt_UserName.Text) && x.CXCode.Contains(txt_CXCode.Text)).ToList();
            }
            bind(list);
        }
    }
 
}