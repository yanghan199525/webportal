using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Interface;
using System.Data;
using System.Text;
using System.Linq;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class ApprovalHistory : System.Web.UI.UserControl
    {
        public bool ShowAction
        {
            get
            {
                if (txtShowAction.Text == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            set
            {
                if (value)
                {
                    txtShowAction.Text = "1";
                }
                else
                {
                    txtShowAction.Text = "0";
                }
                //trAction.Visible = value;
                trIdear.Visible = value;
            }
        }

        public string Comments
        {
            get
            {
                if (CheckBoxText.Text!="")
                {
                    return txtComments.Text + "\n" + CheckBoxText.Text;
                }
                else
                {
                    return txtComments.Text;
                }
            }
        }
        public string SIGNNAME
        {
            get
            {               
              return fldSIGNNAME.SelectedItem.Text;
                
            }
        }


        /// <summary>
        /// 操作类型 退回1 同意0 拒绝2
        /// </summary>
        public int ActionType
        {
            get
            {
                if (rbReturn.Checked)
                {
                    return 1;
                }
                if (rbReject.Checked)
                {
                    return 2;
                }
                if (rbSelectReturn.Checked)
                {
                    return 3;
                }
                return 0;
            }
        }

        /// <summary>
        /// 操作类型 
        /// </summary>
        public string ReturnStep
        {
            get
            {
                if (rbSelectReturn.Checked)
                {
                    return rblStepList.SelectedValue;
                }
                return "";
            }
        }

        IApprovalHistory _appovalHistory = ServiceContainer.Instance().GetService<IApprovalHistory>();

        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            userInfo.AfterLoadData += userInfo_AfterLoadData;

            if (!IsPostBack)
            {

                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                if (incident <= 0)
                {
                    this.Visible = false;
                }
                string processName = Request.QueryString["ProcessName"];
                string TaskID = Request.QueryString["TaskID"];           
                string type = Request.QueryString["Type"];
                dev_SIGNNAME.Visible = false;
                if (ISSIGN(1, processName, userInfo.StepName) )
                {
                    dev_SIGNNAME.Visible = true;
                    BindSIGNNAME(1, processName, userInfo.StepName);
                }
                if (ISSIGN(2, processName, userInfo.StepName))
                {
                    dev_SIGNNAME.Visible = true;
                    BindSIGNNAME(2, processName, userInfo.StepName);
                }
                Getapplypurpose(processName, incident, TaskID);
                GetShow(processName, incident);
                if (!string.IsNullOrEmpty(type))
                {
                    if (type.ToUpper() == "MYAPPROVAL" || type.ToUpper() == "MYREQUEST" || type.ToUpper() == "REPORT") //已完成，不显示提交按钮
                    {
                        this.Check_values.Text = "hidden";
                        this.ChechBox.Visible = false;
                        ShowAction = false;
                      
                    }
                    if (type.ToUpper() == "MYREAD" || type.ToUpper() == "MYUNREAD") //已完成，不显示提交按钮
                    {
                        this.Check_values.Text = "hidden";
                        trIdear.Visible = false;
                        this.ChechBox.Visible = false;
                    }
                    else
                    {
                        DataTable dt = _appovalHistory.GetReturnableSteps(userInfo.ProcessName, incident,
                            userInfo.StepName);
                        if (dt.Rows.Count > 0)
                        {
                            rblStepList.DataSource = dt;
                            rblStepList.DataTextField = "STEPLABEL";
                            rblStepList.DataValueField = "STEPLABEL";
                            rblStepList.DataBind();
                        }
                    }
                }

                rbApprove.Text = Lang.Get("Approve");
                rbReturn.Text = Lang.Get("Return");

                if (Request.QueryString["type"] != null)
                {
                    if (Request.QueryString["type"].ToUpper() == "ADDSIGN")
                    {
                        rbApprove.Checked = true;
                        txtShowAction.Text = "0";
                        trIdear.Visible = false;
                    }

                }
                hyFlow.Text = Ultimus.UWF.Common.Logic.Lang.Get("ViewProcess");
                hyFlow.NavigateUrl = "~/Portal/Ultimus.UWF.Home.V3/TaskStatus.aspx?ProcessName=" + Server.UrlEncode(Request.QueryString["ProcessName"]) + "&Incident=" + Request.QueryString["INCIDENT"] + "&TaskId=" + Request.QueryString["TaskId"] + "&ServerName=" + Request.QueryString["ServerName"];
            }
        }

        void userInfo_AfterLoadData(object sender, EventArgs e)
        {
            BingApprovalHistory();
        }
        public void Getapplypurpose(string processName, int incident, string TaskID)
        {
            string applypurpose = null;
            decimal amount = 0;
            string steplabel = null;
            if ((processName == "CPR_FOOD" || processName == "CPR_NONFOOD" || processName == "CPR_SERVICE") && incident != -1)
            {
                StringBuilder sSql = new StringBuilder();               
                sSql.Append("SELECT APPLYPURPOSE,AMOUNT FROM [dbo].[PROC_" + processName + "]  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "' and DOCUMENTNO is not null");
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count > 0)
                {
                    applypurpose = dt.Rows[0]["APPLYPURPOSE"].ToString();
                    amount = Convert.ToDecimal(dt.Rows[0]["AMOUNT"]);                   
                }
                sSql.Length = 0;
                sSql.Append("SELECT STEPLABEL FROM [dbo].[TASKS]  WHERE TASKID='" + TaskID + "'");
                DataTable task = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
                if (task.Rows.Count > 0)
                {

                    steplabel = task.Rows[0]["STEPLABEL"].ToString().Trim();

                }
                if (applypurpose == "2" && amount > 100000 && steplabel == "Segment Director")
                {
                    this.Check_values.Text = "block";
                }
                else
                {
                    this.Check_values.Text = "hidden";
                }
            }
            else
            {
                this.Check_values.Text = "hidden";
            }
        }
        void BingApprovalHistory()
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                List<ApprovalHistoryEntity> list = _appovalHistory.GetApprovalHistory(userInfo.FormID,
                    userInfo.ProcessName, ConvertUtil.ToInt32(userInfo.Incident));

                BindApprovalHisttory(list, userInfo.ProcessName, ConvertUtil.ToInt32(userInfo.Incident));
                list = _appovalHistory.GetApprovalHistory(userInfo.FormID,
                    userInfo.ProcessName, ConvertUtil.ToInt32(userInfo.Incident));
                ApprovalHistoryList.DataSource = list/*.OrderBy(x=>x.CREATEDATE)*/;
                ApprovalHistoryList.DataBind();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void BindApprovalHisttory(List<ApprovalHistoryEntity> list,string processName,int incident) {
            foreach (var item in list)
            {
                if (item.STEPNAME.Trim() == "Segment Director") {
                    string LoginName = item.APPROVERNAME;
                    DataTable table = GetSiteCode(processName, incident);
                  
                    if (table.Rows.Count > 0)
                    {
                        DataTable dt = GetAuthInfo(LoginName, table);
                        if (dt.Rows.Count > 0)
                        {
                           LoginName = string.Format("{0} (事业部总监授权区域总监)", dt.Rows[0]["rdName"].ToString());
                           // LoginName = string.Format("{0} (SD{1}权力下放)", dt.Rows[0]["rdName"].ToString(), dt.Rows[0]["sdName"].ToString());
                            UpdateApprovalHistroy(processName, incident, item.STEPNAME.Trim(), LoginName);
                        }
                    }
                }
            }
          

        }

        /// <summary>
        /// 插入历史审批记录
        /// </summary>
        /// <param name="processname">流程名称</param>
        /// <param name="incident">实例号</param>
        /// <param name="approve">审批人</param>
        /// <param name="action">审批动作</param>      
        bool UpdateApprovalHistroy(string processName, int incident, string stepLabel, string loginName)
        {
            string sql =string.Format( "update WF_APPROVALHISTORY set APPROVERNAME=N'{3}' where PROCESSNAME=N'{0}' AND INCIDENT={1} AND STEPNAME=N'{2}'", processName, incident, stepLabel, loginName);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
            return true;
        }

        public DataTable GetAuthInfo(string loginName, DataTable table)
        {
            string sql = string.Format("select rdName,sdName,sdEmpNO,rdEmpNo  from proc_auth_log where  rdEmpNo in (select EMPNO from ORG_USER where CNNAME = N'{1}') and  siteCode = '{0}' and DocumentNo = '{2}'", table.Rows[0]["siteCode"], loginName, table.Rows[0]["FORMID"]);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt;
        }
        public DataTable GetSiteCode(string processName, int incident)
        {
            string sql = string.Format("select sitecode,FORMID from proc_{0} where incident='{1}' ", processName, incident);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }
        private void BindSIGNNAME(int type,string processName,string stepName)
        {
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("SELECT EMPNO,EMPNAME FROM PROC_PROCESS_SIGN WHERE PROCESSNAME='{0}' AND  STEPNAME='{1}'and TYPE={2}", processName, stepName, type));
            fldSIGNNAME.Items.Clear();
            fldSIGNNAME.DataSource = dt;
            fldSIGNNAME.DataTextField = "EMPNAME";
            fldSIGNNAME.DataValueField = "EMPNO";
            fldSIGNNAME.DataBind();
            fldSIGNNAME.Items.Insert(0, new ListItem("", ""));
        }
        public static bool ISSIGN(int type, string processName, string stepName)
        {
            DataTable PRPurpose = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("SELECT EMPNO,EMPNAME FROM PROC_PROCESS_SIGN WHERE PROCESSNAME='{0}' AND  STEPNAME='{1}' and TYPE={2}", processName, stepName, type));
            if (PRPurpose == null || PRPurpose.Rows.Count == 0)
                return false;
            return true;
        }
        public void GetShow(string processName, int incident)
        {
            if ((processName == "CPR_FOOD" || processName == "OR_CPR_FOOD") && incident != -1)
            {
                StringBuilder sSql = new StringBuilder();
                sSql.Append("SELECT USER_SIGNNAME FROM [dbo].[PROC_" + processName + "]  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "' and DOCUMENTNO is not null");
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count > 0)
                {
                    if (!string.IsNullOrWhiteSpace(dt.Rows[0]["USER_SIGNNAME"].ToString()))
                    {
                        dev_SIGNNAME.Visible = false;  
                    }
                }

            }

        }
    }
}