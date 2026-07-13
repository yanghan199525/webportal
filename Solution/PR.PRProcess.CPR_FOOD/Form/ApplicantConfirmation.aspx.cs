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

namespace PR.PRProcess.CPR_FOOD
{
    public partial class ApplicantConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            HiddenField hdDatetime = (HiddenField)Page.FindControl("hdDatetime");
            hdDatetime.Value = string.Format("{0} 18:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
        }

        protected void NewRequest_BeforeSubmit(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}