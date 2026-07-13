using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3.Handler
{
    /// <summary>
    /// TaskRefresh 的摘要说明
    /// </summary>
    public class TaskRefresh : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            SqlFilterUtil filter = new SqlFilterUtil();
            filter.AddEqual("a.STATUS", 1);
            string count=_workflow.GetTaskCount(SessionLogic.GetLoginName(), filter.GetFilterList()).ToString();
            context.Response.ContentType = "text/plain";
            context.Response.Write(count);
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