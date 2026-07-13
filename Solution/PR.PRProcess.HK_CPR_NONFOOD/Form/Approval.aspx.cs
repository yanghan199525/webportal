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
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Common.Interface;


namespace PR.PRProcess.HK_CPR_NONFOOD
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ProcessName = Request.QueryString["ProcessName"];
            string Incident = Request.QueryString["Incident"];
            string TaskID = Request.QueryString["TaskID"];
            string Type = Request.QueryString["Type"];
            string StepName = Request.QueryString["StepName"];
            string UserName = Request.QueryString["UserName"];

            HiddenField hdDatetime = (HiddenField)Page.FindControl("hdDatetime");

            if (chechAdministrator(UserName))
            {
                #region 当用户为管理员时，隐藏作废按钮
                ButtonList ButtonList1 = (ButtonList)Page.FindControl("ButtonList1");
                LinkButton btnAbortIncident = (LinkButton)ButtonList1.FindControl("btnAbortIncident");
                btnAbortIncident.Attributes.Add("style", "display:none");
                #endregion
            }
            if (StepName.Trim() == "Applicant Confirmation" && Type.ToUpper() == "MYTASK")
            {
                string loginName = UserName.Replace('/', '\\');
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginName, "");

              
                hdDatetime.Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
            }
            if (StepName.Trim() == "Applicant Confirmation" && Type.ToUpper() == "MYTASK")
            {
                string loginName = UserName.Replace('/', '\\');
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginName, "");

                hdDatetime.Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
            }
            string Delivery = getDeliveryDate(ProcessName, Incident, TaskID);
            string DeliveryDate = Delivery;
            //string DeliveryDate = Delivery.Split(';')[0];
            //string DeliveryDateShow = Delivery.Split(';')[1];
            read_DELIVERYDATE.Text = DeliveryDate;
            getLanguage(UserName.Replace('/', '\\').Split('\\')[1]);
        }


        public string getDeliveryDate(string ProcessName, string Incident, string TaskID)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string DeliveryDate = "";
                sSql.Append("SELECT * FROM TASKS WHERE TASKID='" + TaskID + "'");
                if (DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString()).Rows.Count > 0)
                {
                    DataTable PROC_HK_CPR_NONFOOD = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT * FROM PROC_HK_CPR_NONFOOD WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                    if (PROC_HK_CPR_NONFOOD != null)
                    {
                        DeliveryDate = PROC_HK_CPR_NONFOOD.Rows[0]["DELIVERYDATE"].ToString();
                    }
                }
                return DeliveryDate;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void getLanguage(string username)
        {
            HiddenField hdLanguage = Page.FindControl("hdLanguage") as HiddenField;
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + username + "'");
            hdLanguage.Value = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
        }

        public bool chechAdministrator(string username)
        {
            bool state = false;
            username = username.Trim();
            if (username.Contains("administrator"))
            {
                state = true;
            }
            else if (username.Contains("admin"))
            {
                if (username.Contains("\\"))
                {
                    username = username.Split('\\')[1];
                    StringBuilder sSql = new StringBuilder();
                    sSql.AppendFormat(@"SELECT USERID FROM ORG_USER WHERE LOGINNAME='{0}'", username);
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                    if (dt.Rows.Count > 0)
                    {
                        string userid = dt.Rows[0][0].ToString();
                        string member_id = string.Format("{0}|USER", userid);
                        sSql.Length = 0;
                        sSql.AppendFormat(@"SELECT ID FROM SEC_MENURIGHTS WHERE MEMBERID='{0}'", member_id);
                        DataTable dt_ = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                        if (dt_.Rows.Count > 0)
                        {
                            state = true;
                        }
                    }

                }
            }
            return state;
        }
    }
}