using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ultimus.UWF.Home.V3
{
    public partial class OpenHelp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string processName = Request.QueryString["ProcessName"];
            if (!string.IsNullOrEmpty(processName))
            {
                string file =Server.MapPath( "\\Solution\\Help\\" +processName + ".pdf");
                if(File.Exists(file))
                {
                    Response.Redirect("\\Solution\\Help\\" + Server.UrlEncode(processName) + ".pdf");

                }
                else
                {
                    Response.Write("Help file not config!<br> File Path like Solution\\Help\\ProcessName.pdf");
                }

            }

        }
    }
}