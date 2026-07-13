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
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Common.Interface;
using System.Data.Common;
using System.Web.Services;

namespace UWF.Process.CAPEX_SERVICE
{
    public partial class Approval : System.Web.UI.Page
    {
        private string _stepName = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string ProcessName = Request.QueryString["ProcessName"];
                string Incident = Request.QueryString["Incident"];
                string TaskID = Request.QueryString["TaskID"];
                string Type = Request.QueryString["Type"];
                string StepName = Request.QueryString["StepName"];
                string UserName = Request.QueryString["UserName"];


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
                }

                if (StepName.Trim() == "Segment Director")
                {
                    getSD(TaskID);
                }
                getLanguage(UserName.Replace('/', '\\').Split('\\')[1]);
                if (StepName == "OC" || StepName == "FPA" || StepName == "GL" || StepName == "GNL")
                {
                    HiddenField approvalType = (HiddenField)Page.FindControl("approvalType");
                    approvalType.Value = "1";
                    if (StepName == "GL")
                    {
                        HiddenField isGL = (HiddenField)Page.FindControl("isGL");
                        isGL.Value = "1";

                    }

                }
            }

           
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