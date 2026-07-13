using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Workflow
{
    public class GraphicalView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string incident = Request.QueryString["Incident"];
            string processName = Server.UrlDecode(Request.QueryString["ProcessName"].Trim());
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            string ServerName = Server.UrlDecode(Request.QueryString["ServerName"]);
            try
            {
                //Incident objInc = new Incident();
                //bool pReturnInc = objInc.LoadIncident(processName, int.Parse(incident));
               
                //Incident.Status objIncStatus = new Incident.Status();
                //objInc.GetIncidentStatus(out objIncStatus);

                byte[] bytesGif=null;
                //bytesGif = _workflow.GetFlowChart(ServerName, processName,ConvertUtil.ToInt32( incident));
                //Session["flowpic"] = bytesGif;
                if (Session["flowpic"] != null)
                {
                    bytesGif = (byte[])Session["flowpic"];
                }
                //objIncStatus.GetGraphicalStatus(objInc.strProcessName, objInc.nIncidentNo, objInc.nVersion, out bytesGif);
                Response.ContentType = "image/gif";
                Response.HeaderEncoding = System.Text.Encoding.GetEncoding("gb2312");
                Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
                Response.BinaryWrite(bytesGif);
                Response.End();
            }
            catch
            {
                //throw new Exception(ee.Message);
                Response.End();
            }
        }
    }
}