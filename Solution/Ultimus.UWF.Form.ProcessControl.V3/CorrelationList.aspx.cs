using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class CorrelationList : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string COUNT = "0";
        public string CanNotCancel = Lang.Get("TaskList_CanNotCancel");
        List<TaskEntity> lists = new List<TaskEntity>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //int days = ConvertUtil.ToInt32(ConfigurationManager.AppSettings["Cache.CompletedTask"]);
                //if (days > 0)
                //    txtStartDate.Text = DateTime.Now.AddDays(-days).ToString("yyyy/MM/dd");
                //else
                //    txtStartDate.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");

                //txtEndDate.Text = DateTime.Now.AddDays(1).ToString("yyyy/MM/dd");
                BindProcessCategory();
                //BindGrid();
                btnSearch.Text = Lang.Get("btn_Search");
            }
        }

        void BindProcessCategory()
        {
            List<ProcessCategoryEntity> lists = _workflow.GetCategoryList();
            if (!lists.Exists(p => p.CATEGORYNAME == Lang.Get("NewTask_AllProcess")))
            {
                ProcessCategoryEntity pe = new ProcessCategoryEntity();
                pe.CATEGORYNAME = Lang.Get("NewTask_AllProcess");
                pe.CATEGORYENNAME = Lang.Get("NewTask_AllProcess");
                lists.Insert(0, pe);
            }
            ddlProcessCategory.DataTextField = Lang.Get("CategoryNameField");
            ddlProcessCategory.DataValueField = Lang.Get("CategoryNameField");
            ddlProcessCategory.DataSource = lists;
            ddlProcessCategory.DataBind();
        }

        void BindGrid()
        {
            List<ParameterEntity> table = new List<ParameterEntity>();
            string filter = GetFilter(out table);
            int skipResults = 0;// (AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize;
            int maxResults = 999;// AspNetPager1.PageSize;

            List<TaskEntity> lists = new List<TaskEntity>();

            lists = _workflow.GetMyRequestList(SessionLogic.GetLoginName(), filter, table, "a.STARTTIME DESC", skipResults, maxResults);
            rptTask.DataSource = lists;
            rptTask.DataBind();
        }

        string GetFilter(out List<ParameterEntity> table)
        {
            SqlFilterUtil fb = new SqlFilterUtil(false);
            if (!string.IsNullOrEmpty(txtProcessName.Text))
            {
                fb.AddLike("a.PROCESSNAME", GetProcessName(txtProcessName.Text));
            }
            if (!string.IsNullOrEmpty(ddlProcessCategory.SelectedValue) && ddlProcessCategory.SelectedValue != Lang.Get("TaskList_AllProcess"))
            {
                List<ProcessEntity> processes = _workflow.GetCategoryProcessList("", ddlProcessCategory.SelectedValue);
                List<string> strs = new List<string>();
                foreach (ProcessEntity process in processes)
                {
                    strs.Add(process.PROCESSNAME);
                }
                fb.AddIn("a.PROCESSNAME", strs.ToArray());
            }
            fb.AddLike("SUMMARY", txtSummary.Text);
            fb.AddEqual("b.STATUS", "2");
            fb.AddLike("a.STEPLABEL", txtStepName.Text);
            DateTime startTime = DateTime.Now;
            DateTime endTime = DateTime.Now.AddDays(1);

            if (!string.IsNullOrEmpty(txtStartDate.Text) && string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = ConvertUtil.ToDateTime(txtStartDate.Text);
                endTime = DateTime.Now.AddDays(1);
            }
            if (string.IsNullOrEmpty(txtStartDate.Text) && !string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = DateTime.Now.AddMonths(-120);
                endTime = ConvertUtil.ToDateTime(txtEndDate.Text + " 23:59:59");
            }
            if (string.IsNullOrEmpty(txtStartDate.Text) && string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = DateTime.Now.AddMonths(-120);
                endTime = DateTime.Now.AddDays(1);
            }
            if (!string.IsNullOrEmpty(txtStartDate.Text) && !string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = ConvertUtil.ToDateTime(txtStartDate.Text);
                endTime = ConvertUtil.ToDateTime(txtEndDate.Text + " 23:59:59");
            }
            table = new List<ParameterEntity>();
            table.Add(new ParameterEntity("STARTTIME", startTime.ToString("yyyy-MM-dd HH:mm:ss")));
            table.Add(new ParameterEntity("ENDTIME", endTime.ToString("yyyy-MM-dd HH:mm:ss")));

            return fb.ToString();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        public string GetStatus(string status)
        {
            if (status == "1")
            {
                return Lang.Get("TaskStatus_Active");
            }
            else if (status == "2")
            {
                return Lang.Get("TaskStatus_Completed");
            }
            else if (status == "4")
            {
                return Lang.Get("TaskStatus_Abort");
            }
            else if (status == "8")
            {
                return Lang.Get("TaskStatus_Suspend");
            }
            else if (status == "33")
            {
                return Lang.Get("TaskStatus_Stalled");
            }
            else
            {
                return Lang.Get("TaskStatus_Unknown");
            }
        }

        public string GetStatusClass(string status)
        {
            if (status == "2")
            {
                return "label label-danger";
            }
            if (status == "4")
            {
                return "label label-success";
            }
            return "label label-default";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);
        }

        /// <summary>
        /// 加载所有流程列表
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public string GetProcessName(string text)
        {
            //string sql = " select PROCESSNAME from wf_process where processname like '%@PROCESSNAME%' or processcnname like '%@PROCESSNAME%'";
            //string PROCESSNAME = ConvertUtil.ToString(DataAccess.Instance("UltDB").ExecuteScalar(sql, text));
            ; IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            List<ProcessEntity> processes = _workflow.GetAllProcessList();
            ProcessEntity proc = processes.Find(p => p.PROCESSCNNAME.Contains(text) || p.PROCESSENNAME.Contains(text));
            if (proc != null)
            {
                return proc.PROCESSNAME;
            }
            //if (string.IsNullOrEmpty(PROCESSNAME))
            //    return PROCESSNAME;
            return text;
        }

        /// <summary>
        /// 获取申请人中文名称
        /// </summary>
        /// <param name="INITIATOR">LoginName</param>
        /// <returns></returns>
        public string GetUserCN(string INITIATOR)
        {
            string res = string.Empty;
            try
            {
                INITIATOR = ConvertUtil.ToString(INITIATOR.Replace("/", "\\").Trim());
                string sql = @"select CNNAME from v_ORG_USER where LOGINNAME=N'" + INITIATOR + "'";
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
                if (dt != null && dt.Rows.Count >= 0)
                    res = ConvertUtil.ToString(dt.Rows[0]["CNNAME"]);
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return res;
        }
    }
}