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
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using System.Text;
using System.Data.Common;
using System.Data;
using UPL.Common.BussinessControl.Logic;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    /// <summary>
    /// UploadHandler 的摘要说明
    /// </summary>
    public class UploadHandler : IHttpHandler
    {

        private IAttachment logic = ServiceContainer.Instance().GetService<IAttachment>();
        private IWorkflow form = ServiceContainer.Instance().GetService<IWorkflow>();
        private ISerialNo sn = ServiceContainer.Instance().GetService<ISerialNo>();
        static object obj = new object();
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                HttpPostedFile file = context.Request.Files["Filedata"];
                string[] filetypw = ConfigurationManager.AppSettings["FileType"].Split(',');
                if (filetypw != null)
                {
                    if (Array.IndexOf(filetypw, file.FileName.Substring(file.FileName.LastIndexOf(".") + 1, file.FileName.Length - file.FileName.LastIndexOf(".") - 1)) > 0)
                    {
                        MyLib.LogUtil.Error(file.FileName + "文件类型不支持！");
                        throw new Exception(file.FileName + "文件类型不支持");
                    }
                }
                AttachmentEntity item = new AttachmentEntity();
                lock (obj)
                {
                    item.ID = sn.GetSerialNo("WF_Attachment_ID").ToString();
                }
                item.ProcessName = HttpContext.Current.Request["ProcessName"].ToString();
                item.Incident = ConvertUtil.ToInt32(HttpContext.Current.Request["Incident"]);
                item.UploadStepName = HttpContext.Current.Request["StepName"].ToString();
                FileInfo info = new FileInfo(file.FileName);
                item.FileName = info.Name;
                item.FileType = item.FileName.Substring(item.FileName.LastIndexOf("."), item.FileName.Length - item.FileName.LastIndexOf("."));
                item.FileSize = file.ContentLength;
                item.NewName = Guid.NewGuid().ToString() + "~" + item.FileName.Trim().Replace(item.FileType, "");
                item.CreateByName = HttpContext.Current.Request["USERNAME"].ToString();
                item.Ext02 = ConvertUtil.ToString(HttpContext.Current.Request["APPLICANTACCOUNT"]);
                
                if (string.IsNullOrEmpty(item.CreateByName))
                {
                    UserEntity ue = SessionLogic.GetLoginUserEntity();
                    if (ue != null)
                    {
                        item.CreateByName = ue.USERNAME;
                    }
                }
                item.CreateDate = DateTime.Now;
                string formid = HttpContext.Current.Request["FORMID"].ToString();
                if (item.Incident > 0)
                {
                    formid = form.GetFormID(item.ProcessName, item.Incident).FORMID;
                }
                item.Ext01 = formid;
                item.FORMID = formid;
                item.TYPE = HttpContext.Current.Request["TYPE"];
                if (MyLib.ConfigurationManager.AppSettings["AttachmentOptions"] == "1")
                {
                    FTP ftp = new FTP();
                    ftp.Upload(context.Server, file, item);
                }
                else
                {
                    logic.Upload(HttpContext.Current, file, item);
                }
            }
            catch (Exception ex)
            {
                int i = sn.GetMaxNo("WF_Attachment", "ID");
                DataAccess.Instance("BizDB").ExecuteNonQuery("update com_serialno set serialno=@serialno where serialtype=@serialtype", i, "WF_Attachment_ID");
                MyLib.LogUtil.Error(ex);
            }

        }

        private void SaveHistory(HttpContext context, string path, string filename, int filesize)
        {

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