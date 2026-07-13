using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Ultimus.UWF.Form.ProcessControl.V3.Handler
{
    /// <summary>
    /// CalculateOvertime 的摘要说明
    /// </summary>
    public class CalculateOvertime : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}