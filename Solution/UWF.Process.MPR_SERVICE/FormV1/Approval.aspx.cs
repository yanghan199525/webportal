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

namespace PR.PRProcess.MPR_SERVICE
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ProcessName = Request.QueryString["ProcessName"];
            string Incident = Request.QueryString["Incident"];
            GetPrService(ProcessName, Incident);

        }     
       

        public void GetPrService(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string Requirement = "";

                DataTable PROC_MPR_SERVICE = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_MPR_SERVICE WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_MPR_SERVICE != null)
                {
                    PurchasingPurpose = PROC_MPR_SERVICE.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PROC_MPR_SERVICE.Rows[0]["Requirement"].ToString();
                    Label txt_PURCHASINGPURPOSE = (Label)Page.FindControl("read_PURCHASINGPURPOSE");
                    Label txt_REQUIREMENT = (Label)Page.FindControl("read_REQUIREMENT");
                    txt_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                    txt_REQUIREMENT.Text = Requirement;


                }
            }


            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}