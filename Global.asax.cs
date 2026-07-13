using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using Microsoft.AspNet.FriendlyUrls;
using MyLib;
using Ultimus.UWF.Common;
using Ultimus.UWF.Common.Logic;

namespace UWF.Portal
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
           


        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session != null)
            {
                Exception objErr = Server.GetLastError().GetBaseException();
                LogUtil.Error(objErr);
                //HttpContext.Current.Session["Exception"] = objErr;
                //string path = "../../../Portal/Ultimus.UWF.Home.V3/Error.aspx";
                //if (HttpContext.Current.Request.RawUrl.IndexOf("Portal/Ultimus.UWF") >= 0)
                //{
                //    path = "../../Portal/Ultimus.UWF.Home.V3/Error.aspx";
                //}
                //Server.Transfer(path);
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }

    

}