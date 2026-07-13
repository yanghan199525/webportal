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
using Ultimus.UWF.Common.Interface;
namespace PR.PRProcess.OR_CPR_NONFOOD
{
    public partial class Approval : System.Web.UI.Page
    {
      
            protected void Page_Load(object sender, EventArgs e)
            {
                string procType = Request.QueryString["Type"];
                string Incident = Request.QueryString["Incident"];
                string TaskID = Request.QueryString["TaskID"];
                string UserName = Request.QueryString["UserName"];
                string FORMID = Request.QueryString["FORMID"];
                string ShowType = Request.QueryString["ShowType"];
                string StepName = Request.QueryString["StepName"];
                string Type = Request.QueryString["Type"];
                GetCprNonFood("OR_CPR_NONFOOD", Incident);
            if (StepName.Trim() == "Applicant Confirmation" && Type.ToUpper() == "MYTASK")
            {
                string loginName = UserName.Replace('/', '\\');
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginName, "");

                //hdDate.Value = string.Format("{0}", DateTime.Now.AddDays(2).ToString("yyyy-MM-dd"));
                hdDatetime.Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
            }
        }

            public void GetCprNonFood(string ProcessName, string Incident)
            {
                StringBuilder sSql = new StringBuilder();
                try
                {
                    string PurchasingPurpose = "";
                    string POAmount = "";

                DataTable PROC_OR_CPR_NONFOOD = DataAccess.Instance("BizDB").ExecuteDataTable("select PurchasingPurpose,IsCapex, POAmount,DELIVERYDATE,CREATEBYACCOUNT from PROC_OR_CPR_NONFOOD where  PROCESSNAME ='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_OR_CPR_NONFOOD != null)
                    {
                        PurchasingPurpose = PROC_OR_CPR_NONFOOD.Rows[0]["PurchasingPurpose"].ToString();
                        POAmount = PROC_OR_CPR_NONFOOD.Rows[0]["POAmount"].ToString();
                        Label fld_PURCHASINGPURPOSE = (Label)Page.FindControl("read_PURCHASINGPURPOSE");
                        Label fld_DELIVERYDATE = (Label)Page.FindControl("read_DELIVERYDATE");
                        Label fld_POAMOUNT = (Label)Page.FindControl("read_POAMOUNT");
                        fld_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                        fld_POAMOUNT.Text = POAmount;
                        fld_DELIVERYDATE.Text= PROC_OR_CPR_NONFOOD.Rows[0]["DELIVERYDATE"].ToString();
                        Label read_ISCAPEX = (Label)Page.FindControl("read_ISCAPEX");
                        read_ISCAPEX.Text = PROC_OR_CPR_NONFOOD.Rows[0]["IsCapex"].ToString();
                    }
                }


                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
       
    }
}