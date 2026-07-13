using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using System.Web.Security;

namespace UWF.Portal
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string home = ConfigurationManager.AppSettings["DefaultForm"];
            if (!string.IsNullOrEmpty(home))
            {
                Response.Redirect(home);
            }
            else
            {
                Response.Redirect("~/Portal/Ultimus.UWF.Home.V3/Default.aspx");
            }
        }
    }
}