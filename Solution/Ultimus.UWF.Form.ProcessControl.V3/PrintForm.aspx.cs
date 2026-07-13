using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using System.Web.Security;
using System.IO;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.TemplatePrint;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class PrintForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string settingsFile = Request.QueryString["settings"];
            string url = Request.QueryString["url"];
            string[] sz = url.Split('/');
            if(sz.Length>2)
            {
                url = sz[1] + "/"+sz[2];
            }

            if (!File.Exists(settingsFile))
            {
                Response.Redirect(WebUtil.GetRootPath() + "/" + url + "/Print/PrintForm.aspx?formid="+ Request.QueryString["formid"] + "&processname=" + Request.QueryString["processname"] + "&Type=PRINT&incident=" + Request.QueryString["incident"] + "&StepName=" + Request.QueryString["StepName"]+ "&hasformid=1");
            }
            string xml = File.ReadAllText(settingsFile);
            DataEntity entity = SerializeUtil.XMLDeserialize<DataEntity>(xml);
            if (ConvertUtil.ToString(entity.TemplateType).ToUpper().Trim() == "ASPX" || ConvertUtil.ToString(entity.TemplateType).ToUpper().Trim() == "HTML")
            {
                Response.Redirect(WebUtil.GetRootPath() + "/" + entity.TemplatePath + "?processname=" + Request.QueryString["processname"] + "&incident=" + Request.QueryString["incident"] + "&StepName=" + Request.QueryString["StepName"]);
            }
            else
            {
                Ultimus.UWF.TemplatePrint.DataEntity data =
                    Ultimus.UWF.TemplatePrint.PrintUtil.Export(Request.QueryString["formid"], Request.QueryString["settings"]);
                string str = data.OutputFilePath.Substring(data.OutputFilePath.IndexOf("\\Solution\\"));
                Response.Redirect(WebUtil.GetRootPath() + str.Replace("\\", "/"));
            }
        }
    }
}