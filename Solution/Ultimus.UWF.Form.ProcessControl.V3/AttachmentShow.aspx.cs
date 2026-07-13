using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Workflow
{
    public partial class AttachmentShow : System.Web.UI.Page
    {
        IAttachment _attachment = ServiceContainer.Instance().GetService<IAttachment>();
        public bool ReadOnly
        {
            get
            {
                if (txtReadonly.Text == "1")
                {
                    return true;
                }
                return false;
            }
            set
            {
                if (value)
                {
                    txtReadonly.Text = "1";
                    actionRow.Visible = false;
                }
                else
                {
                    txtReadonly.Text = "0";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["readonly"] == "1")
            {
                ReadOnly = true;
            }

            DataTable dt = _attachment.GetAttachments(Request.QueryString["formid"], Request.QueryString["processname"],
                ConvertUtil.ToInt32(Request.QueryString["incident"]),
               Request.QueryString["type"]);
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }
        

       
        public string GetUrl(object processname, object newname, object fileType, object createDate)
        {
            string path = string.Empty;
            if (MyLib.ConfigurationManager.AppSettings["AttachmentOptions"] == "1")
                path = MyLib.ConfigurationManager.AppSettings["FTPAttachmentServerIP"];
            else
                path = MyLib.ConfigurationManager.AppSettings["AttachmentOpenPath"];

            string p = ConvertUtil.ToString(processname).TrimEnd();
            string s = ConvertUtil.ToDateTime(createDate).ToString("yyyy\\\\MM\\\\dd") + "\\" + p + "\\" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
            return DESEncrypt.Encrypt(HttpUtility.UrlEncode(path + s));

        }
        public string GetFileName(object FileName)
        {
            return DESEncrypt.Encrypt(HttpUtility.UrlEncode(ConvertUtil.ToString(FileName)));
        }
    }
}