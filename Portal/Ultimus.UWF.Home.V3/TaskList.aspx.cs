using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Home.V3.Logic;
using Ultimus.UWF.Workflow.Interface;
using System.Data;

namespace Ultimus.UWF.Home.V3
{
    public partial class TaskList : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string COUNT = "0"; 

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProcessCategory();
                BindGrid();
                btnSearch.Text = Lang.Get("btn_Search");
            }
        }

        void BindProcessCategory()
        {
            List<ProcessCategoryEntity> lists = _workflow.GetCategoryList();
            ProcessCategoryEntity[] arlist = new ProcessCategoryEntity[lists.Count];
            lists.CopyTo(arlist);
            List<ProcessCategoryEntity> nlist = new List<ProcessCategoryEntity>();
            nlist.AddRange(arlist);
            if (!nlist.Exists(p => p.CATEGORYNAME == Lang.Get("NewTask_AllProcess")))
            {
                ProcessCategoryEntity pe = new ProcessCategoryEntity();
                pe.CATEGORYNAME = Lang.Get("NewTask_AllProcess");
                pe.CATEGORYENNAME = Lang.Get("NewTask_AllProcess");
                nlist.Insert(0, pe);
            }
            ddlProcessCategory.DataTextField = Lang.Get("CategoryNameField");
            ddlProcessCategory.DataValueField = Lang.Get("CategoryNameField");
            ddlProcessCategory.DataSource = nlist;
            ddlProcessCategory.DataBind();
        }

        void BindGrid()
        {
            List<ParameterEntity> table = new List<ParameterEntity>();
            string filter = GetFilter(out table);
            int skipResults = 0;// (AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize;
            int maxResults = 999;// AspNetPager1.PageSize;

            List<TaskEntity> lists = new List<TaskEntity>();
            string sort = "a.STARTTIME DESC";
            if (!string.IsNullOrEmpty(txtSort.Text))
            {
                sort = txtSort.Text;
            }
            else
            {
                sort = "a.STARTTIME DESC";
            }

            //string BizDBName = ConfigurationManager.AppSettings["BizDBName"];
            //// 增加过滤批量审批数据（批量审批数据先保存后执行，再次需要让数据过滤）
            string s = Request.QueryString["s"];
            if (!string.IsNullOrEmpty(s))
            {
                s = s.Replace("'", "''");
                filter += " and ( SUMMARY like N'%" + s + "%' or a.PROCESSNAME like N'%" + s + "%' or a.STEPLABEL like N'%" + s + "%' )";
            }
            else
            {
                maxResults = 20;
            }
            lists = _workflow.GetTaskList( filter, table, sort, skipResults, maxResults);
            //filter = GetFilter(out table);
            //AspNetPager1.RecordCount = _task.GetMyTaskCount(SessionLogic.GetLoginName(), filter, table);
            //COUNT = AspNetPager1.RecordCount.ToString();
            COUNT = lists.Count.ToString();
            rptTask.DataSource = lists;
            rptTask.DataBind();
        }

        string GetFilter(out List<ParameterEntity> table)
        {
            SqlFilterUtil fb = new SqlFilterUtil(false);
            if (ddlProcessCategory.SelectedItem != null)
            {
                txtProcessCategory.Text = ddlProcessCategory.SelectedItem.Value;
            }
            if (!string.IsNullOrEmpty(txtProcessName.Text))
            {
                ProcessLogic pl = new ProcessLogic();
                fb.AddLike("a.PROCESSNAME", pl.GetProcessName(txtProcessName.Text));
            }
            if (!string.IsNullOrEmpty(txtProcessCategory.Text) && txtProcessCategory.Text != Lang.Get("TaskList_AllProcess"))
            {
                List<ProcessEntity> processes = _workflow.GetCategoryProcessList("", txtProcessCategory.Text);
                List<string> strs = new List<string>();
                foreach (ProcessEntity process in processes)
                {
                    strs.Add(process.PROCESSNAME);
                }
                fb.AddIn("a.PROCESSNAME", strs.ToArray());
            }
            if (!ConvertUtil.IsInt(txtIncident.Text))
            {

                txtIncident.Text = "";
            }
            fb.AddEqual("a.INCIDENT", txtIncident.Text);
            //fb.AddScope("a.STARTTIME", txtStartDate.Text, txtEndDate.Text);
            fb.AddLike("SUMMARY", txtSummary.Text);
            
            fb.AddLike("a.STEPLABEL", txtStepName.Text);
            fb.AddEqual("a.ASSIGNEDTOUSER", SessionLogic.GetUltimusLoginName());

           

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
            if (rdActive.Checked)
            {
                fb.AddEqual("b.STATUS", "1");
            }
            if (rdComplete.Checked)
            {
                fb.AddEqual("b.STATUS", "2");
            }
            table = new List<ParameterEntity>();
            table.Add(new ParameterEntity("STARTTIME", startTime.ToString()));
            table.Add(new ParameterEntity("ENDTIME", endTime.ToString()));

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
        public string GetUserCN(string INITIATOR)
        {
            string res = string.Empty;
            try
            {
                INITIATOR = ConvertUtil.ToString(INITIATOR.Replace("/", "\\").Trim());
                string sql = @"select CNNAME from v_ORG_USER where LOGINNAME=N'" + INITIATOR + "'";
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
                if (dt != null && dt.Rows[0]["CNNAME"].ToString() != "")
                    res = dt.Rows[0]["CNNAME"].ToString();
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return res;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);
        }
    }
}