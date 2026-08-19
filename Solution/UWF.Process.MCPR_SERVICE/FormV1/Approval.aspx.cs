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
using Ultimus.UWF.Common.Interface;

namespace PR.PRProcess.MCPR_SERVICE
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

            //HiddenField hdDate = (HiddenField)Page.FindControl("hdDate");
            HiddenField hdDatetime = (HiddenField)Page.FindControl("hdDatetime");
            TextBox var_APPROVEDATE = (TextBox)Page.FindControl("var_APPROVEDATE");
            TextBox var_APPROVE = (TextBox)Page.FindControl("var_APPROVE");
            Label read_DELIVERYDATE = (Label)Page.FindControl("read_DELIVERYDATE");
            //Label read_DELIVERYDATESHOW = (Label)Page.FindControl("read_DELIVERYDATESHOW");

            var_APPROVEDATE.Text = DateTime.Now.ToString();
            var_APPROVE.Text = Convert.ToDateTime(var_APPROVEDATE.Text).ToString("yyyyMMddHHmm");

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
                //hdDate.Value = string.Format("{0}", DateTime.Now.AddDays(2).ToString("yyyy-MM-dd"));
                hdDatetime.Value = string.Format("{0} 18:00:00", DateTime.Now.AddDays(1).ToString("yyyy-MM-dd"));
            }
            if (StepName.Trim() == "Segment Director")
            {

                getSD(TaskID);
            }
            else if (Type.ToUpper()=="REPORT")
            {

            }

            //string DeliveryDate = getDeliveryDate(ProcessName, Incident, TaskID);
            //read_DELIVERYDATE.Text = DeliveryDate;
            string Delivery = getDeliveryDate(ProcessName, Incident, TaskID);
            string DeliveryDate = Delivery;
            //string DeliveryDate = Delivery.Split(';')[0];
            //string DeliveryDateShow = Delivery.Split(';')[1];
            read_DELIVERYDATE.Text = DeliveryDate;
            //read_DELIVERYDATESHOW.Text = DeliveryDateShow;

            getLanguage(UserName.Replace('/', '\\').Split('\\')[1]);
        }
        public void getSD(string TaskID)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                sSql.Append("SELECT * FROM TASKS WHERE TASKID='" + TaskID + "'");
                DataTable dt_TASKS = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
                if (dt_TASKS.Rows.Count > 0)
                {

                    foreach (DataRow item in dt_TASKS.Rows)
                    {
                        if (item["STEPLABEL"].ToString().Trim() == "Segment Director" && item["TASKUSER"].ToString().Trim().ToUpper() == "CUSTOMOC/JUN2.YAN")
                        {
                            Label read_USER_SEGMENTDIRECTOR_1 = (Label)Page.FindControl("read_USER_SEGMENTDIRECTOR_1");
                            Label read_SEGMENTDIRECTOR = (Label)Page.FindControl("read_SEGMENTDIRECTOR");
                            string domain = "CustomOC";
                            string SegmentDirector1 = System.Web.Configuration.WebConfigurationManager.AppSettings["SegmentDirector1"];
                            string loginName = SegmentDirector1;
                            read_USER_SEGMENTDIRECTOR_1.Text = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                            read_SEGMENTDIRECTOR.Text = "CUSTOMOC/JUN2.YAN";

                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public string getDeliveryDate(string ProcessName, string Incident, string TaskID)
        {
            StringBuilder sSql = new StringBuilder();
            try
            {
                string DeliveryDate = "";
                string DeliveryDateShow = "";
                sSql.Append("SELECT * FROM TASKS WHERE TASKID='" + TaskID + "'");
                if (DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString()).Rows.Count > 0)
                {
                    DataTable PROC_CPR_FOOD = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT * FROM PROC_MCPR_SERVICE WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident);
                    if (PROC_CPR_FOOD != null)
                    {
                        DeliveryDate = PROC_CPR_FOOD.Rows[0]["DELIVERYDATE"].ToString();
                        //if (PROC_CPR_FOOD.Rows[0]["DELIVERYDATESHOW"].ToString() == "")
                        //{
                        //    DeliveryDateShow = DeliveryDate.Split(' ')[0];
                        //}
                        //else
                        //{
                        //    DeliveryDateShow = Convert.ToDateTime(PROC_CPR_FOOD.Rows[0]["DELIVERYDATESHOW"]).ToString("yyyy-MM-dd");
                        //}
                    }
                }
                //return DeliveryDate + ";" + DeliveryDateShow;
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
            if (string.IsNullOrWhiteSpace(username))
                return state;
            username = username.Trim();
            if (username.Contains("administrator"))
            {
                state = true;
            }
            else if(username.Contains("admin"))
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

        //public string getDeliveryDate(string ProcessName, string Incident, string TaskID)
        //{
        //    StringBuilder sSql = new StringBuilder();
        //    try
        //    {
        //        string DeliveryDate = "";
        //        sSql.Append("SELECT * FROM TASKS WHERE TASKID='" + TaskID + "'");
        //        if (DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString()).Rows.Count > 0)
        //        {
        //            DeliveryDate = DataAccess.Instance("BizDB").ExecuteScalar("SELECT DELIVERYDATE FROM PROC_MCPR_SERVICE WHERE PROCESSNAME='" + ProcessName + "' AND INCIDENT=" + Incident).ToString();
        //        }
        //        return DeliveryDate;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(ex.Message);
        //    }
        //}
    }
}