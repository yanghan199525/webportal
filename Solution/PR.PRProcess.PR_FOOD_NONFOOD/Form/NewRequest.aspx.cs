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
using System.Data.Common;
using System.Linq;
using System.Text.RegularExpressions;

namespace PR.PRProcess.PR_FOOD_NONFOOD
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
                GetPrNonFood( ProcessName,  Incident);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                string ProcessName = Request.QueryString["ProcessName"];
                GetPrNonFood( ProcessName,  Incident);
            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string ProcessName = Request.QueryString["ProcessName"];

                GetPrNonFood( ProcessName,  Incident);
            }
        }

        public void GetPrNonFood(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string Requirement = "";

                DataTable PROC_FOOD_NONFOOD = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_PR_FOOD_NONFOOD WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_FOOD_NONFOOD != null)
                {
                    PurchasingPurpose = PROC_FOOD_NONFOOD.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PROC_FOOD_NONFOOD.Rows[0]["Requirement"].ToString();
                    Label txt_PURCHASINGPURPOSE = (Label)Page.FindControl("txt_PURCHASINGPURPOSE");
                    Label txt_REQUIREMENT = (Label)Page.FindControl("txt_REQUIREMENT");
                    txt_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                    txt_REQUIREMENT.Text = Requirement;


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
                var amount = 600000;
                if ((Convert.ToDecimal(this.fld_AMOUNT.Text) >= amount))
                    {
                        string value = this.fld_APPREMARK.Text;
                        bool result = Regex.Matches(value, "[a-zA-Z]").Count > 0;
                        if (!result)
                        {
                            string msg = "该采购申请需中国区主席审批，备注栏中请提供采购收入或利润，并请包含对应英文描述";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "'); document.getElementById('ButtonList1_btnSend').style.display = '';", true);
                            e.Cancel = true;
                        }
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", " document.getElementById('ButtonList1_btnSend').style.display = 'none';", true);
                
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