using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class GraphicalView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string processName = Server.UrlDecode(Request.QueryString["ProcessName"]);
            string taskId = ConvertUtil.ToString(Request.QueryString["taskId"]);
            string ServerName = Server.UrlDecode(Request.QueryString["ServerName"]);
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            TaskEntity task = _workflow.GetTaskEntity(ServerName, taskId);
            //int incident = ConvertUtil.ToInt32(Request.QueryString["Incident"]);
            int incident = 0;
            if (task != null)
            {
                incident = task.INCIDENT;
            }

            //是否没有在配置表中有，如果没有，那么为V7
            ProcessEntity process = _workflow.GetProcessInfo("", processName);
            if (process != null)
            {
                if (process.ULTIMUSVERSION == "V7")
                {
                    if (incident == 0)
                    {
                        Response.Write("<script>window.close();</script>");
                        Response.End();
                    }
                    else
                    {
                        Response.Redirect(ConfigurationManager.AppSettings["V7TaskStatusUrl"] + "?taskid=" + _workflow.GetViewTaskID("", processName, incident));
                    }
                }
            }

            try
            {
                byte[] bytesGif = null;
                bytesGif = _workflow.GetFlowChart(ServerName, processName, ConvertUtil.ToInt32(incident));

                Response.ContentType = "image/gif";
                Response.HeaderEncoding = System.Text.Encoding.GetEncoding("gb2312");
                Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
                Response.BinaryWrite(bytesGif);
                Response.End();
            }
            catch
            {
                Response.End();
            }
        }
    }
}