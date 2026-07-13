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
            string procType = Request.QueryString["Type"];
            string Incident = Request.QueryString["Incident"];
            string TaskID = Request.QueryString["TaskID"];
            string UserName = Request.QueryString["UserName"];
            string FORMID = Request.QueryString["FORMID"];
            string ShowType = Request.QueryString["ShowType"];

            if (procType.ToUpper().Trim() == "REPORT")
            {
                string ProcessName = Request.QueryString["ProcessName"];
                GetPrNonFood(ProcessName, Incident);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                string ProcessName = Request.QueryString["ProcessName"];
                GetPrNonFood(ProcessName, Incident);
            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string ProcessName = Request.QueryString["ProcessName"];

                GetPrNonFood(ProcessName, Incident);
            }
        }
        public void GetPrNonFood(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string Requirement = "";

                DataTable PO_Amendment = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_PO_Amendment WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PO_Amendment != null)
                {
                    
                    // fld_PURCHASINGPURPOSE.Text = Requirement;
                    PurchasingPurpose = PO_Amendment.Rows[0]["PurchasingPurpose"].ToString();
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