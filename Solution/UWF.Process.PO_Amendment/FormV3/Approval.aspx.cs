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

namespace UWF.Process.PO_Amendment
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void AfterLoad()
        {
            string ProcessName = Request.QueryString["ProcessName"];
            string Incident = Request.QueryString["Incident"];
            //string TaskID = Request.QueryString["TaskID"];
            //string Type = Request.QueryString["Type"];
            //string StepName = Request.QueryString["StepName"];
            //string UserName = Request.QueryString["UserName"];
            GetPrNonFood(ProcessName, Incident);


        }
        public void GetPrNonFood(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string Requirement = "";

                DataTable PROC_PO_AMENDMENT = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_PO_AMENDMENT WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_PO_AMENDMENT != null)
                {
                    PurchasingPurpose = PROC_PO_AMENDMENT.Rows[0]["PurchasingPurpose"].ToString();
                   // Requirement = PROC_FOOD_NONFOOD.Rows[0]["Requirement"].ToString();
                    Label txt_PURCHASINGPURPOSE = (Label)Page.FindControl("read_PURCHASINGPURPOSE");
                  //  Label txt_REQUIREMENT = (Label)Page.FindControl("read_REQUIREMENT");
                    txt_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                  //  txt_REQUIREMENT.Text = Requirement;


                }
            }


            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}