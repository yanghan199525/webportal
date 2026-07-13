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

namespace PR.PRProcess.OR_CPR_FOOD
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
                GetCprNonFood(ProcessName, Incident);

            }
            if (procType.ToUpper().Trim() == "MYREQUEST")
            {
                string ProcessName = Request.QueryString["ProcessName"];
                GetCprNonFood(ProcessName, Incident);
            }
            if (procType.ToUpper().Trim() == "MYTASK")
            {
                string ProcessName = Request.QueryString["ProcessName"];

                GetCprNonFood(ProcessName, Incident);
            }
        }

        public void GetCprNonFood(string ProcessName, string Incident)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string PurchasingPurpose = "";
                string POAmount = "";
                string sql = "select PurchasingPurpose,IsCapex, POAmount from UltimusBiz.dbo.PROC_OR_CPR_FOOD where  PROCESSNAME ='" + ProcessName + "' AND INCIDENT=" + Incident;
                DataTable PROC_OR_CPR_FOOD = DataAccess.Instance("BizDB").ExecuteDataTable("select PurchasingPurpose,IsCapex, POAmount from dbo.PROC_OR_CPR_FOOD where  PROCESSNAME ='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_OR_CPR_FOOD != null)
                {
                    PurchasingPurpose = PROC_OR_CPR_FOOD.Rows[0]["PurchasingPurpose"].ToString();
                    POAmount = PROC_OR_CPR_FOOD.Rows[0]["POAmount"].ToString();
                    TextBox fld_PURCHASINGPURPOSE = (TextBox)Page.FindControl("fld_PURCHASINGPURPOSE");
                    TextBox fld_POAMOUNT = (TextBox)Page.FindControl("fld_POAMOUNT");
                    TextBox fld_IsCapex = (TextBox)Page.FindControl("fld_IsCapex");
                    fld_PURCHASINGPURPOSE.Text = PurchasingPurpose;
                    fld_POAMOUNT.Text = POAmount;
                    fld_IsCapex.Text= PROC_OR_CPR_FOOD.Rows[0]["IsCapex"].ToString();

                }
            }


            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 提交前触发的事件
        /// </summary>me
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