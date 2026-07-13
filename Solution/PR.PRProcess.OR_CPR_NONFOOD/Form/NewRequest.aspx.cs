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

namespace PR.PRProcess.OR_CPR_NONFOOD
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
            HttpContext.Current.Session["LoginName"] = UserName;
            HttpContext.Current.Session["LoginPassword"] = null;
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
                string POAmount = "";

                DataTable PROC_OR_CPR_NONFOOD = DataAccess.Instance("BizDB").ExecuteDataTable("select PurchasingPurpose,IsCapex, POAmount,DELIVERYDATE from PROC_OR_CPR_NONFOOD where  PROCESSNAME ='" + ProcessName + "' AND INCIDENT="+Incident);
                if (PROC_OR_CPR_NONFOOD != null)
                {
                    PurchasingPurpose = PROC_OR_CPR_NONFOOD.Rows[0]["PurchasingPurpose"].ToString();
                    POAmount = PROC_OR_CPR_NONFOOD.Rows[0]["POAmount"].ToString();
                    TextBox fld_PURCHASINGPURPOSE = (TextBox)Page.FindControl("fld_PURCHASINGPURPOSE");
                    TextBox fld_DELIVERYDATE = (TextBox)Page.FindControl("fld_DELIVERYDATE");
                    TextBox fld_POAMOUNT = (TextBox)Page.FindControl("fld_POAMOUNT");
                    TextBox fld_IsCapex = (TextBox)Page.FindControl("fld_IsCapex");
                    fld_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                    fld_POAMOUNT.Text = POAmount;
                    fld_DELIVERYDATE.Text= PROC_OR_CPR_NONFOOD.Rows[0]["DELIVERYDATE"].ToString();
                    fld_IsCapex.Text = PROC_OR_CPR_NONFOOD.Rows[0]["IsCapex"].ToString();


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