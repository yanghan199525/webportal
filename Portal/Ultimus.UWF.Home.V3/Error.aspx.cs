using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class Error : System.Web.UI.Page
    {
        public string hidden = "hidden";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Exception"] != null)
            {
                Exception ex = (Exception)Session["Exception"];
                ltError.Text = ex.Message;
                if (ex.StackTrace != null)
                {
                    ltStack.Text = ex.StackTrace.Replace("\r", "<br/>");
                }
            }
            else
            {
                ltError.Text = StringFilter.FilterHtmls(Request["error"]);
            }
            if (Request.QueryString["showerror"] == "1")
            {
                hidden = "";
            }
        }
    }
}