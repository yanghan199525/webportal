using MyLib;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ultimus.UWF.Home.V3
{
    public partial class HongKongOrganizational : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UploadBtn_Click(object sender, EventArgs e)
        {
            try
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
                name = "HK_Org_Emp_UploadFile.xlsx";
                string filepath = System.Configuration.ConfigurationManager.AppSettings["SyncSodexoHKExcelFilePath"].ToString();
                ExcelFileUpload.SaveAs(filepath + name);
                Response.Write("<script>alert('文件上传成功！')</script> ");
            }
            catch (Exception ex)
            {
                LogUtil.Error($"上传组织架构数据失败{ex.Message}");

                Response.Write("<script>alert('上传失败'" + ex.Message + ")</script> ");
            }

        }
    }
}