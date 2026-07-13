using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ultimus.UWF.OrgChart
{
    public partial class SelectSignedApproverHK : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string user = Request.QueryString["userId"];
            string lan = Request.QueryString["language"];
            userId.Text = user;
            language.Text = lan;
        }
    }
}