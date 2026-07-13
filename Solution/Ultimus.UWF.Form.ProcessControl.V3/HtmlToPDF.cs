using SelectPdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public class HtmlToPDF
    {
        public bool HtmlToPdf(string url, string processName, string FileName)
        {
            HtmlToPdf toPdf = new HtmlToPdf();
            toPdf.Options.PdfPageSize = PdfPageSize.A4;
            toPdf.Options.MarginRight = 3;
            toPdf.Options.MarginLeft = 3;
            toPdf.Options.MinPageLoadTime = 2;
            PdfDocument pdf = toPdf.ConvertUrl(url.Trim());

            string strPath = ConfigurationManager.AppSettings["PathPdf"].ToString() + processName + "\\" + FileName + ".pdf";
            bool isOK = true;
            try
            {

                pdf.Save(strPath);
            }
            catch (Exception)
            {

                isOK = false;
            }

            pdf.Close();
            bool success = true;
            if (!System.IO.File.Exists(strPath))
                success = false;
            if (System.IO.File.Exists(strPath))
            {
                FileStream fs = new FileStream(strPath, FileMode.Open);
                byte[] bytes = new byte[(int)fs.Length];
                fs.Read(bytes, 0, bytes.Length);
                fs.Close();
                if (HttpContext.Current.Request.UserAgent != null)
                {

                    string userAgent = HttpContext.Current.Request.UserAgent.ToUpper();
                    if (userAgent.IndexOf("FIREFOX", StringComparison.Ordinal) <= 0)
                    {
                        HttpContext.Current.Response.AddHeader("Content-Disposition",
                        "attachment;  filename=" + HttpUtility.UrlEncode(FileName + ".pdf", Encoding.UTF8));
                    }
                    else
                    {
                        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;  filename=" + FileName + ".pdf");
                    }
                }

                HttpContext.Current.Response.ContentEncoding = Encoding.UTF8;
                HttpContext.Current.Response.ContentType = "application/octet-stream";

                //通知浏览器下载文件而不是打开
                HttpContext.Current.Response.BinaryWrite(bytes);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
                fs.Close();
                System.IO.File.Delete(strPath);

            }

            return false;
        }
    }
}