using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data;
using Ultimus.UWF.Form.ProcessControl.V3;
using Ultimus.UWF.Workflow.Logic;
using Ultimus.UWF.Form.Interface;
using System.Data.Common;
using System.Linq;
using System.Text.RegularExpressions;
using MyLib;

namespace PR.PRProcess.PR_SERVICE
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
                GetPrService(ProcessName, Incident);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                string ProcessName = Request.QueryString["ProcessName"];
                GetPrService(ProcessName, Incident);
            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string ProcessName = Request.QueryString["ProcessName"];

                GetPrService(ProcessName, Incident);
            }
        }
        public void GetPrService(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string Requirement = "";

                DataTable PROC_PR_SERVICE = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_PR_SERVICE WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_PR_SERVICE != null)
                {
                    PurchasingPurpose = PROC_PR_SERVICE.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PROC_PR_SERVICE.Rows[0]["Requirement"].ToString();
                    TextBox txt_PURCHASINGPURPOSE = (TextBox)Page.FindControl("fld_PURCHASINGPURPOSE");
                    TextBox txt_REQUIREMENT = (TextBox)Page.FindControl("fld_REQUIREMENT");
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
                var amount = 1000000;
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