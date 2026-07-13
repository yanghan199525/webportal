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

namespace PR.PRProcess.PRHK_FOOD_NONFOOD
{
    public partial class Approval : System.Web.UI.Page
    {
      
         protected void Page_Load(object sender, EventArgs e)
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

                DataTable PRHK_FOOD_NONFOOD = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_PRHK_FOOD_NONFOOD WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PRHK_FOOD_NONFOOD != null)
                {
                    PurchasingPurpose = PRHK_FOOD_NONFOOD.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PRHK_FOOD_NONFOOD.Rows[0]["Requirement"].ToString();
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