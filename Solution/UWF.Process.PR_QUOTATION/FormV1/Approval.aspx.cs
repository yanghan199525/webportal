using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data;
using Ultimus.UWF.Form.ProcessControl.V3;
using MyLib;

namespace UWF.Process.PR_QUOTATION
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void AfterLoad()
        {
            string incident = Request.QueryString["Incident"];
            string stepName = Request.QueryString["StepName"];
            bool result = GetApprovalType(incident, stepName);
            if (result)
            {
                hdCheckApproved.Value = "approval";
            }
        }
        public bool GetApprovalType(string incident, string stepName)
        {
            int num = Convert.ToInt32(DataAccess.Instance("UltDB").ExecuteScalar(string.Format("select count(0) from Tasks where incident='{0}' and processname='PR_QUOTATION' and steplabel='{1}' and status=3 ", incident, stepName.Trim())));
            return num > 0;

        }
    }
}