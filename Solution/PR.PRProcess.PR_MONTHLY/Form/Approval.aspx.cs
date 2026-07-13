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

namespace PR.PRProcess.PR_MONTHLY
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ProcessName = Request.QueryString["ProcessName"];
            string Incident = Request.QueryString["Incident"];
            GetPrMonthly(ProcessName, Incident);
        }

        public void GetPrMonthly(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string Requirement = "";
                string DOCUMENTNO = "";
                string MonthlyAmount = "";
                string BranchQuota = "";
                string PercentageOfExcess = "";

                DataTable PROC_PR_MONTHLY = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement,DOCUMENTNO,MonthlyAmount ,BranchQuota,PercentageOfExcess FROM PROC_PR_MONTHLY WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_PR_MONTHLY != null)
                {
                    PurchasingPurpose = PROC_PR_MONTHLY.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PROC_PR_MONTHLY.Rows[0]["Requirement"].ToString();
                    DOCUMENTNO = PROC_PR_MONTHLY.Rows[0]["DOCUMENTNO"].ToString();
                    MonthlyAmount = PROC_PR_MONTHLY.Rows[0]["MonthlyAmount"].ToString();
                    BranchQuota = PROC_PR_MONTHLY.Rows[0]["BranchQuota"].ToString();
                    PercentageOfExcess = PROC_PR_MONTHLY.Rows[0]["PercentageOfExcess"].ToString();
                    Label txt_PURCHASINGPURPOSE = (Label)Page.FindControl("read_PURCHASINGPURPOSE");
                    Label txt_REQUIREMENT = (Label)Page.FindControl("read_REQUIREMENT");
                    Label txt_DOCUMENTNO = (Label)Page.FindControl("read_DOCUMENTNO");
                    Label txt_MonthlyAmount = (Label)Page.FindControl("read_MonthlyAmount");
                    Label txt_BranchQuota = (Label)Page.FindControl("read_BranchQuota");
                    Label txt_PercentageOfExcess = (Label)Page.FindControl("read_PercentageOfExcess");
                    txt_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                    txt_REQUIREMENT.Text = Requirement;
                    txt_DOCUMENTNO.Text = DOCUMENTNO;
                    txt_MonthlyAmount.Text = MonthlyAmount;
                    txt_BranchQuota.Text = BranchQuota;
                    txt_PercentageOfExcess.Text = PercentageOfExcess;
                }
            }


            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}