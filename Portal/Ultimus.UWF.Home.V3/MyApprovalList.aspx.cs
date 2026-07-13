using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity; 
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Home.V3.Logic;
using Ultimus.UWF.Workflow.Interface;
using System.Data;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyApprovalList : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string COUNT = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int days = ConvertUtil.ToInt32(ConfigurationManager.AppSettings["Cache.CompletedTask"]);
                if (days > 0)
                {
                    txtStartDate.Text = DateTime.Now.AddDays(-days).ToString("yyyy/MM/dd");
                }
                else
                {
                    txtStartDate.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
                }
                txtEndDate.Text = DateTime.Now.AddDays(1).ToString("yyyy/MM/dd");
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
            if (!nlist.Exists(p => p.CATEGORYENNAME == "allprocess"))
            {
                ProcessCategoryEntity pe = new ProcessCategoryEntity();
                pe.CATEGORYNAME = Lang.Get("NewTask_AllProcess");
                pe.CATEGORYENNAME = "allprocess";
                nlist.Insert(0, pe);
            }
            string pcDataTextField = Lang.Get("CategoryNameField");
            if (pcDataTextField == "CategoryNameField")
            {
                pcDataTextField = "CATEGORYNAME";
            }
            ddlProcessCategory.DataTextField = pcDataTextField;
            ddlProcessCategory.DataValueField = "CATEGORYENNAME";
            ddlProcessCategory.DataSource = nlist;
            ddlProcessCategory.DataBind();

            List<ProcessEntity> processes = _workflow.GetAllProcessList();
            string DataTextField = Lang.Get("ProcessNameField");
            if (DataTextField == "ProcessNameField")
            {
                DataTextField = "PROCESSCNNAME";
            }
            processes = processes.FindAll(p => p.PROCESSNAME != "Contract Joint Trial");
            ddlProcessName.DataTextField = DataTextField;
            ddlProcessName.DataValueField = "PROCESSNAME";
            ddlProcessName.DataSource = processes;
            ddlProcessName.DataBind();
            ddlProcessName.Items.Insert(0, new ListItem(Lang.Get("Dropdown_Select"), ""));

        }

        void BindGrid()
        {
            List<ParameterEntity> table = new List<ParameterEntity>();
            string filter = GetFilter(out table);
            int skipResults = 0;// (AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize;
            int maxResults = 999;// AspNetPager1.PageSize;
            LogUtil.Debug("GetMyApprovalList:" + filter);
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

            lists = _workflow.GetMyApprovalList(SessionLogic.GetLoginName(), filter, table, sort, skipResults, maxResults);
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
            //if (!string.IsNullOrEmpty(txtProcessName.Text))
            //{
            //    ProcessLogic pl = new ProcessLogic();
            //    fb.AddLike("a.PROCESSNAME", pl.GetProcessName(txtProcessName.Text));
            //}
            if (ddlProcessName.SelectedItem != null)
            {
                txtProcessName.Text = ddlProcessName.SelectedItem.Value;
            }
            if (!string.IsNullOrEmpty(txtProcessName.Text))
            {
                fb.AddEqual("a.PROCESSNAME", txtProcessName.Text);
            }
            if (!string.IsNullOrEmpty(txtProcessCategory.Text) && txtProcessCategory.Text != "allprocess")
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
            string StepName = string.Empty;
            if (dllStepName.SelectedItem != null)
            {
                txtStepName.Text = dllStepName.SelectedItem.Value;
                StepName = txtStepName.Text.Replace("1", "");
            }           
            fb.AddLike("a.STEPLABEL", StepName);
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
                if (dt != null && dt.Rows[0]["CNNAME"].ToString() != "")
                    res = dt.Rows[0]["CNNAME"].ToString();
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return res;
        }

        public string GetStatusClass(string status)
        {
            if (status == "2")
            {
                return "label label-default";
                //return "label label-danger";
            }
            if (status == "4")
            {
                return "label label-danger";
                //return "label label-success";
            }
            return "label label-success";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);
        }

        public string GetStepName(object process, object step)
        {
            string processName = ConvertUtil.ToString(process); ;
            string strStep = ConvertUtil.ToString(step);
            if (strStep != "Complete")
            {
                string cnname = Lang.Get(processName + "." + strStep);
                if (cnname == processName + "." + strStep)
                {
                    cnname = Lang.Get(strStep);
                }
                return cnname;
            }
            else
            {
                return Lang.Get("Complete");
            }
        }

        protected void ddlProcessCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlProcessName.Items.Clear();
            dllStepName.Items.Clear();
            if (ddlProcessCategory.SelectedItem != null)
            {
                txtProcessCategory.Text = ddlProcessCategory.SelectedItem.Value;
            }
            List<ProcessEntity> processes = null;
            if (txtProcessCategory.Text == "allprocess")
            {
                processes = _workflow.GetAllProcessList();

            }
            else if (!string.IsNullOrEmpty(txtProcessCategory.Text))
            {
                processes = _workflow.GetCategoryProcessList("", txtProcessCategory.Text);
            }
            processes = processes.FindAll(p => p.PROCESSNAME != "Contract Joint Trial");
            ddlProcessName.DataTextField = Lang.Get("ProcessNameField");
            ddlProcessName.DataValueField = "PROCESSNAME";
            ddlProcessName.DataSource = processes;
            ddlProcessName.DataBind();
            ddlProcessName.Items.Insert(0, new ListItem(Lang.Get("Dropdown_Select"), ""));
        }
        
        protected void ddlProcessName_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<string> steps = new List<string>();


            steps.Add("Report Line Review2");
            steps.Add("Report Line Review3");
            steps.Add("Report Line Review4");
            steps.Add("Report Line Review5");
            steps.Add("Report Line Review6");
            steps.Add("Report Line Review7");
            steps.Add("Report Line Review8");
            steps.Add("Report Line Review9");
            steps.Add("Report Line Review10");
            steps.Add("Report Line Review11");
            steps.Add("Report Line Review12");

            steps.Add("Report Line Confirm2");
            steps.Add("Report Line Confirm3");
            steps.Add("Report Line Confirm4");
            steps.Add("Report Line Confirm5");
            steps.Add("Report Line Confirm6");
            steps.Add("Report Line Confirm7");
            steps.Add("Report Line Confirm8");
            steps.Add("Report Line Confirm9");
            steps.Add("Report Line Confirm10");
            steps.Add("Report Line Confirm11");
            steps.Add("Report Line Confirm12");

            steps.Add("Decision Approve2");
            steps.Add("Decision Approve3");
            steps.Add("Decision Approve4");
            steps.Add("Decision Approve5");
            steps.Add("Decision Approve6");
            steps.Add("Decision Approver7");
            steps.Add("Decision Approver8");
            steps.Add("Decision Approver9");
            steps.Add("Decision Approver10");
            steps.Add("Decision Approver11");
            steps.Add("Decision Approver12");

            steps.Add("Joint Trial2");
            steps.Add("Joint Trial3");
            steps.Add("Joint Trial4");
            steps.Add("Joint Trial5");
            steps.Add("Joint Trial6");
            dllStepName.Items.Clear();
            if (ddlProcessName.SelectedItem != null)
            {
              txtProcessName.Text = ddlProcessName.SelectedItem.Value;
            }
            LogUtil.Info(txtProcessName.Text);
            string sql = @"select STEPNAME,CNNAME,ENNAME,EXT20 from WF_PROCESSSTEP where PROCESSNAME=N'{0}' and STEPNAME not in ('{1}') order by ORDERNO";
            sql = string.Format(sql, txtProcessName.Text,string.Join("','", steps));
            LogUtil.Info(sql);
            DataTable procStep = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            string DataTextField = Lang.Get("StepNameField");
            if (DataTextField == "StepNameField")
            {
                DataTextField = "STEPNAME";
            }
            dllStepName.DataTextField = DataTextField;
            dllStepName.DataValueField = "STEPNAME";
            dllStepName.DataSource = procStep;
            dllStepName.DataBind();
            dllStepName.Items.Insert(0, new ListItem(Lang.Get("Dropdown_Select"), ""));            
        }
    }
}