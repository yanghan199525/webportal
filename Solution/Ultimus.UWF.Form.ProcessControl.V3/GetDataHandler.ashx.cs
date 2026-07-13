using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Compilation;
using MyLib;
using System.Reflection;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using System.Data;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.OrgChart.Interface;
using System.Net;
using UPL.Common.BussinessControl.Logic;
using System.Text;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    /// <summary>
    /// UploadHandler 的摘要说明
    /// </summary>
    public class GetDataHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string method = HttpContext.Current.Request["method"];
                string newname = HttpContext.Current.Request["newname"];
                string type = HttpContext.Current.Request["type"];
                string id = HttpContext.Current.Request["id"];
                IAttachment logic = ServiceContainer.Instance().GetService<IAttachment>();
                string jsonString = "";
                DataTable dt = new DataTable();
                switch (method.ToLower())
                {
                    case "getattachment":
                        dt = logic.GetAttachmentsByFormID(HttpContext.Current.Request["formid"], type);
                        dt.Columns.Add("URL");
                        dt.Columns.Add("FILE_NAME");
                        foreach (DataRow row in dt.Rows)
                        {
                            row["FILE_NAME"] = DESEncrypt.Encrypt(HttpUtility.UrlEncode(ConvertUtil.ToString(row["FILENAME"])));
                            row["URL"] = DESEncrypt.Encrypt(HttpUtility.UrlEncode(GetUrl(ConvertUtil.ToString(row["ProcessName"]), ConvertUtil.ToString(row["NEWNAME"]), ConvertUtil.ToString(row["FileType"]), ConvertUtil.ToString(row["CreateDate"]))));
                        }
                        jsonString = MyLib.SerializeUtil.JsonSerialize(dt);
                        context.Response.Write(jsonString);
                        break;
                    case "getsingleattachment":
                        dt = logic.GetAttachmentsByFormID(HttpContext.Current.Request["formid"], type);
                        if (dt.Rows.Count > 0)
                        {
                            dt.Columns.Add("URL");
                            DataRow row = dt.Rows[dt.Rows.Count - 1];
                            row["URL"] = GetUrl(row["ProcessName"], row["NEWNAME"], row["FileType"], row["CreateDate"]);
                            DataTable newdt = dt.Clone();
                            newdt.ImportRow(row);
                            jsonString = MyLib.SerializeUtil.JsonSerialize(newdt);
                        }
                        context.Response.Write(jsonString);
                        break;
                    case "delete":
                        bool res = logic.DeleteAttachmentsByID(HttpUtility.UrlDecode(newname));
                        if (res && MyLib.ConfigurationManager.AppSettings["AttachmentOptions"] == "1")
                        {
                            FTP ftp = new FTP();
                            ftp.Delete(DESEncrypt.Decrypt(context.Request.QueryString["path"]));
                        }
                        break;
                    case "getuserinformation":
                        string LoginName = HttpContext.Current.Request["LOGINNAME"];
                        UserEntity user = SessionLogic.GetUserEntity(LoginName.Replace('/', '\\'));
                        IOrg org = ServiceContainer.Instance().GetService<IOrg>();

                        List<DepartmentEntity> Depts = org.GetUserDepartments(LoginName); //部门
                        if (Depts != null && Depts.Count > 0)
                        {
                            user.DEPARTMENT = Depts[0].DEPARTMENTNAME;
                            user.DEPARTMENTID = Depts[0].DEPARTMENTID;
                        }

                        jsonString = MyLib.SerializeUtil.JsonSerialize(user);
                        context.Response.Write(jsonString);
                        break;
                    case "getcost":
                        string sql = @"select * from ORG_COSTCENTER where G3COSTCENTER=@Costcenter";
                        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, id);
                        jsonString = MyLib.SerializeUtil.JsonSerialize(dt);
                        context.Response.Write(jsonString);
                        break;
                    case "downattachment":
                        downAttachment(context);
                        break;
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                MyLib.LogUtil.Error(msg);
            }

        }

        string GetUrl(object processname, object newname, object fileType, object createDate)
        {
            string path = string.Empty;
            if (MyLib.ConfigurationManager.AppSettings["AttachmentOptions"] == "1")
                path = MyLib.ConfigurationManager.AppSettings["FTPAttachmentServerIP"];
            else
                path = MyLib.ConfigurationManager.AppSettings["AttachmentOpenPath"];

            string p = ConvertUtil.ToString(processname).TrimEnd();
            string s = ConvertUtil.ToDateTime(createDate).ToString("yyyy\\\\MM\\\\dd") + "\\" + p + "\\" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
            return path + s;
            //string ftpServerIP = MyLib.ConfigurationManager.AppSettings["FTPAttachmentServerIP"];
            //string p = ConvertUtil.ToString(processname).TrimEnd();
            //string s = ConvertUtil.ToDateTime(createDate).ToString("yyyy/MM/dd") + "/" + p + "/" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
            //return ftpServerIP + "/Ultimus BPM/" + s;
        }

        //文件下载
        public void downAttachment(HttpContext context)
        {
            string fileName = HttpUtility.UrlDecode(DESEncrypt.Decrypt(context.Request.QueryString["fileName"]));
            string filePath = filePath = HttpUtility.UrlDecode(DESEncrypt.Decrypt(context.Request.QueryString["path"]));

            try
            {
                if (MyLib.ConfigurationManager.AppSettings["AttachmentOptions"] == "1")
                {
                    FTP ftp = new FTP();
                    ftp.Download(context.Response, filePath, fileName);
                }
                else
                {
                    filePath = System.Web.HttpContext.Current.Server.MapPath(filePath);
                    FileInfo file = new FileInfo(filePath);
                    //以字符流的形式下载文件
                    FileStream stream = new FileInfo(filePath).OpenRead();
                    byte[] bytes = new byte[stream.Length];
                    stream.Read(bytes, 0, Convert.ToInt32(stream.Length));
                    context.Response.ContentType = "application/octet-stream";
                    //通知浏览器下载文件而不是打开
                    //判断是否为火狐浏览器
                    var Agent = context.Request.Browser.Browser;
                    if (Agent != "Firefox")
                    {
                        fileName = HttpUtility.UrlEncode(Encoding.UTF8.GetBytes(fileName));
                        fileName = fileName.Replace("+", "%20");
                    }
                    context.Response.Clear();
                    context.Response.ClearContent();
                    context.Response.ClearHeaders();
                    context.Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
                    context.Response.AddHeader("Content-Length", bytes.Length.ToString());
                    context.Response.AddHeader("Content-Transfer-Encoding", "binary");
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
                    //context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
                    context.Response.BinaryWrite(bytes);
                    context.Response.Flush();
                    context.Response.Close();
                    //context.Response.End();
                }
            }
            catch (Exception ex)
            {

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