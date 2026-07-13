using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ultimus.UWF.Home.V3
{
    public partial class JdJump : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string uid = Request["uid"].Replace(" ", "+");
            string submitOrderTime = Request["submitOrderTime"].Replace(" ", "+");
            string orderId = Request["orderId"].Replace(" ", "+");
            string totalMoney = Request["totalMoney"].Replace(" ", "+");
            string freight = Request["freight"].Replace(" ", "+");
            string sign = Request["sign"].Replace(" ", "+");
            string path = getRootPath();
            string url = string.Format("{0}/Portal/Ultimus.UWF.Home.V3/JdNewRequest.aspx?uid={1}&submitOrderTime={2}&orderId={3}&totalMoney={4}&freight={5}&sign={6}&platType=0", path,uid,submitOrderTime,orderId,totalMoney,freight,sign);
            Response.Redirect(url);
        }
        private string getRootPath()
        {
            string rootPath = string.Empty;
            string prex = "http";
            if (HttpContext.Current.Request.Url.Scheme == "https")
            {
                prex = "https";
            }
            else if (HttpContext.Current.Request.Url.Scheme == "http")
            {
                prex = "http";
            }
            if (HttpContext.Current.Request.Url.Port == 80)
            {
                rootPath = prex + "://" + HttpContext.Current.Request.Url.Host;
            }
            else
            {
                rootPath = prex + "://" + HttpContext.Current.Request.Url.Host + ":" +
                  HttpContext.Current.Request.Url.Port;
            }

            return rootPath;
        }
    }
}