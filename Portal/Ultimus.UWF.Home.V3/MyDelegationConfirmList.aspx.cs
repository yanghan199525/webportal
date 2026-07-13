using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyDelegationConfirmList : System.Web.UI.Page
    {
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string LoginName = SessionLogic.GetLoginName().Split('\\')[1];
            string AssignUserAccount = Request.QueryString["AssignUserAccount"];
            //AssignUserAccount

            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
                //ProcessFormLogic process = new ProcessFormLogic();
                rpt.Source = string.Format("BizDB.select taskuser, processname, assignedtouser, assignuntil,assignfrom, status,updatetime,remark  from COM_ASSIGNMENT where status = '2'  and assignedtouser='{0}'", AssignUserAccount);

                Ultimus.UWF.Form.WebControls.Repeater rptLog = Page.FindControl("rptInfo") as Ultimus.UWF.Form.WebControls.Repeater;
                //ProcessFormLogic process = new ProcessFormLogic();
                rptLog.Source = string.Format("BizDB.select taskuser, processname, assignedtouser, assignuntil,assignfrom, status,updatetime,remark  from COM_ASSIGNMENT where  assignedtouser='{0}'", AssignUserAccount);
                rptLog.Sort = " assignuntil DESC";
        }
    }
}