using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class HomeLink : System.Web.UI.Page
    {
        public string MYTASK_COUNT = "";
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlFilterUtil filter = new SqlFilterUtil();
            filter.AddEqual("a.STATUS", 1);
            MYTASK_COUNT = _workflow.GetTaskCount(SessionLogic.GetLoginName(), filter.GetFilterList()).ToString();

        }
    }
}