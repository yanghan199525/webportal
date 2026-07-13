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

namespace PR.PRProcess.PR_MONTHLY
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
                GetPrMonthly(ProcessName, Incident);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                string ProcessName = Request.QueryString["ProcessName"];
                GetPrMonthly(ProcessName, Incident);
            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string ProcessName = Request.QueryString["ProcessName"];

                GetPrMonthly(ProcessName, Incident);
            }
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
                    MonthlyAmount= PROC_PR_MONTHLY.Rows[0]["MonthlyAmount"].ToString();
                    BranchQuota = PROC_PR_MONTHLY.Rows[0]["BranchQuota"].ToString();
                    PercentageOfExcess = PROC_PR_MONTHLY.Rows[0]["PercentageOfExcess"].ToString();
                    TextBox txt_PURCHASINGPURPOSE = (TextBox)Page.FindControl("fld_PURCHASINGPURPOSE");
                    TextBox txt_REQUIREMENT = (TextBox)Page.FindControl("fld_REQUIREMENT");
                    TextBox txt_DOCUMENTNO = (TextBox)Page.FindControl("fld_DOCUMENTNO");
                    TextBox txt_MonthlyAmount = (TextBox)Page.FindControl("fld_MonthlyAmount");
                    TextBox txt_BranchQuota = (TextBox)Page.FindControl("fld_BranchQuota");
                    TextBox txt_PercentageOfExcess = (TextBox)Page.FindControl("fld_PercentageOfExcess");
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


        /// <summary>
        /// 提交前触发的事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// 提交后触发的事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void NewRequest_AfterSubmit(object sender, System.ComponentModel.CancelEventArgs e)
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