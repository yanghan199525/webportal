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
using Ultimus.UWF.Workflow.Logic; 
using Ultimus.UWF.Form.Interface;

namespace UWF.Process.PO_Amendment
{
    public partial class NewRequest : System.Web.UI.Page
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
                string ADJUSTDOCUMENTNO = "";
                DataTable PO_Amendment = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement,ADJUSTDOCUMENTNO FROM PROC_PO_Amendment WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PO_Amendment != null)
                {
                    PurchasingPurpose = PO_Amendment.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PO_Amendment.Rows[0]["Requirement"].ToString();
                    TextBox fld_PURCHASINGPURPOSE = (TextBox)Page.FindControl("fld_PURCHASINGPURPOSE");
                    TextBox fld_ADJUSTDOCUMENTNO = (TextBox)Page.FindControl("fld_ADJUSTDOCUMENTNO");
                    ADJUSTDOCUMENTNO = PO_Amendment.Rows[0]["ADJUSTDOCUMENTNO"].ToString();
                    ////Label txt_REQUIREMENT = (Label)Page.FindControl("txt_REQUIREMENT");
                    fld_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                    fld_ADJUSTDOCUMENTNO.Text = ADJUSTDOCUMENTNO;
                    // fld_PURCHASINGPURPOSE.Text = Requirement;


                }
            }


            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}