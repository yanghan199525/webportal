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

namespace PR.PRProcess.PRHK_SERVICE
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

                DataTable PROC_PRHK_SERVICE = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT PurchasingPurpose,Requirement FROM PROC_PRHK_SERVICE WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                if (PROC_PRHK_SERVICE != null)
                {
                    PurchasingPurpose = PROC_PRHK_SERVICE.Rows[0]["PurchasingPurpose"].ToString();
                    Requirement = PROC_PRHK_SERVICE.Rows[0]["Requirement"].ToString();
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