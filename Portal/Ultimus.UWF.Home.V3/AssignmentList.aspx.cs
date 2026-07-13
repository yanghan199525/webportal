using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Ultimus.UWF.Common.Logic;
using MyLib;
using System.Data;
using System.Web.UI.HtmlControls;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class AssignmentList : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string EnableProcessAssign = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Button1.Text = Lang.Get("btn_Search");
            Button3.Text = Lang.Get("btn_Reset");
            Button4.Text = Lang.Get("btn_RecallTask");
            Button5.Text = Lang.Get("Assign_BackButton");
            if (!IsPostBack)
            {
                //BindProcess();
                BindAsignList();
            }

            if (ConfigurationManager.AppSettings["EnableProcessAssign"] == "0")
            {
                EnableProcessAssign = "hidden";
            }
        }

        private void BindProcess()
        {
            dropProcessName.DataSource = _workflow.GetProcessList();
            dropProcessName.DataTextField = "PROCESSNAME";
            dropProcessName.DataValueField = "PROCESSNAME";
            dropProcessName.DataBind();
            dropProcessName.Items.Insert(0, new ListItem("", ""));
        }

        private void BindAsignList()
        {
            try
            {
                if (RadioButton1.Checked)
                {
                    task.Visible = true;
                    FutureTasks.Visible = false;
                    Processes.Visible = false;
                    DataTable dt = _workflow.GetAssignedTable(SessionLogic.GetUltimusLoginName(), "");
                    TaskList.DataSource = dt;
                    TaskList.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox("alert('" + ex.Message + "');");
            }
        }

        private void MessageBox(string script)
        {
            this.Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "javascript", "<script language='javascript' defer>" + script + "</script>");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            BindAsignList();
        }

        /// <summary>
        /// 获取申请人中文名称
        /// </summary>
        /// <param name="INITIATOR">LoginName</param>
        /// <returns></returns>
        public string GetUserCN(string ASSIGNEDTOUSER)
        {
            string res = string.Empty;
            try
            {
                ASSIGNEDTOUSER = ConvertUtil.ToString(ASSIGNEDTOUSER.Replace("/", "\\").Trim());
                string sql = @"select CNNAME from v_ORG_USER where LOGINNAME=@ASSIGNEDTOUSER";
                res = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar(sql, ASSIGNEDTOUSER));
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return res;
        }

        public string GetDisplaySummary(string SUMMARY)
        {
            string _displaySummary = SUMMARY;
            string[] sz = ConvertUtil.ToString(SUMMARY).Split(',');
            if (sz.Length == 3)
            {
                _displaySummary = sz[0] + "," + sz[1] + "]";
            }
            return _displaySummary;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            try
            {
                bool flag = false;
                if (RadioButton1.Checked)//单个任务
                {
                    foreach (RepeaterItem item in TaskList.Items)
                    {
                        HtmlInputCheckBox cb = item.FindControl("Task_checkbox") as HtmlInputCheckBox;
                        if (cb.Checked)
                        {
                            string taskid = cb.Value;
                            _workflow.WithdrawAssignedTask("", taskid);
                            flag = true;
                        }
                    }
                }
                BindAsignList();
                if (flag)
                {
                    MessageBox("alert('Success！');");
                }
            }
            catch (Exception ex)
            {
                MessageBox("alert('" + ex.Message + "');");
            }
        }
    }
}