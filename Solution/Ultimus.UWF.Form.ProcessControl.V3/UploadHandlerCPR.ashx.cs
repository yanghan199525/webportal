using MyLib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    /// <summary>
    /// UploadHandlerCPR 的摘要说明
    /// </summary>
    public class UploadHandlerCPR : IHttpHandler
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
                logic.Upload(HttpContext.Current, file, item);
            }
            catch (Exception ex)
            {
                int i = sn.GetMaxNo("WF_Attachment", "ID");
                DataAccess.Instance("BizDB").ExecuteNonQuery("update com_serialno set serialno=@serialno where serialtype=@serialtype", i, "WF_Attachment_ID");
                MyLib.LogUtil.Error(ex);
            }

            //context.Response.ContentType = "text/plain";
            //context.Response.Charset = "utf-8";

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