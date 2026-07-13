using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MyLib;
using System.IO;
using Ultimus.UWF.Common.Logic;

namespace UPL.Common.BussinessControl.Ajax
{
    /// <summary>
    /// 支持EXCEL导入明细行数据
    /// </summary>
    public class HandlerExcelImport : IHttpHandler
    {
        HttpRequest request;
        HttpResponse response;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            this.request = context.Request;
            this.response = context.Response;
            string JosnString = string.Empty;
            try
            {
                string method = request["Method"];
                switch (method)
                {
                    // Excel 导入生成DataTable
                    case "ExcelImport":
                        HttpPostedFile file = request.Files["Filedata"];
                        Stream str = file.InputStream;
                        DataTable dt = ExcelHelper.RenderDataTableFromExcel_X(str, 0, 0);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            JosnString = MyLib.SerializeUtil.JsonSerialize(dt);
                            this.response.Write(JosnString);
                        }
                        break;
                    case "DownAttachment":
                        string fileName = request["fileName"];
                        string path = request["path"];
                        string filePath = "";
                        if(path.IndexOf("/")>=0)
                        {
                            filePath = path;
                        }
                        else
                        {
                            filePath = DESEncrypt.Decrypt(path);
                        }
                        downAttachment(fileName, filePath);
                        break;
                }
            }
            catch (Exception ex)
            {

            }
        }
        /// <summary>
        /// 文件下载
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="filePath"></param>
        public void downAttachment(string fileName, string filePath)
        {
            try
            {
                filePath = System.Web.HttpContext.Current.Server.MapPath(filePath);
                FileInfo file = new FileInfo(filePath);
                if (file.Exists)
                {
                    response.Clear();
                    response.Charset = "UTF-8";
                    response.ContentEncoding = System.Text.Encoding.UTF8;
                    response.AddHeader("Content-Type", "application/octet-stream");
                    response.AddHeader("Content-Disposition", "attachment; filename=" + System.Web.HttpUtility.UrlEncode(fileName.Trim(), System.Text.Encoding.UTF8));
                    response.AddHeader("Content-Length", file.Length.ToString());
                    response.ContentType = "application/ms-excel";
                    response.WriteFile(file.FullName);
                    response.End();
                }
            }
            catch (Exception ex)
            {
                MyLib.LogUtil.Info(ex.Message);
                throw;
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