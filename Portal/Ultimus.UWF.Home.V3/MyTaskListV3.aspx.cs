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
using Ultimus.UWF.Home.V3.Logic;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyTaskListV3 : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string COUNT = "0";
        public string CATEGORY_COUNT = "";
        List<TaskEntity> lists = new List<TaskEntity>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProcessCategory();
                BindGrid("");
                //绑定流程分类
                rpProcessCategory.DataSource = ProcessCategoryInit();
                rpProcessCategory.DataBind();
                btnSearch.Text = Lang.Get("btn_Search");
                btnReset.Text = Lang.Get("btn_Reset");
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
            string loginname = SessionLogic.GetLoginName().Replace("\\", "/");
          
                processes = processes.FindAll(p => p.PROCESSNAME != "Contract Joint Trial");
           
            ddlProcessName.DataTextField = DataTextField;
            ddlProcessName.DataValueField = "PROCESSNAME";
            ddlProcessName.DataSource = processes;
            ddlProcessName.DataBind();
            ddlProcessName.Items.Insert(0, new ListItem(Lang.Get("Dropdown_Select"), ""));
        }

        void BindGrid(string categoryName)
        {
            List<ParameterEntity> table = new List<ParameterEntity>();
            string filter = GetFilter(categoryName, out table);
            int skipResults = 0;// (AspNetPager1.CurrentPageIndex - 1) * AspNetPager1.PageSize;
            int maxResults = 999;// AspNetPager1.PageSize;
            
            string sort = "a.STARTTIME";
            if (!string.IsNullOrEmpty(txtSort.Text))
            {
                sort = txtSort.Text;
            }
            else
            {
                sort = "a.STARTTIME";
            }
            string loginname = SessionLogic.GetLoginName().Replace("\\", "/");
         
            lists = _workflow.GetMyTaskList(SessionLogic.GetLoginName(), filter, table, sort, skipResults, maxResults);
         
            //获取正在ADDSIGN审批的任务，并且过滤
            DataTable dtAddSign = DataAccess.Instance("BizDB").ExecuteDataTable("select distinct PARENTTASKID from WF_ADDSIGN where isnull(Status,'0')<>'2'");
            lists = lists.FindAll(p => dtAddSign.Select("PARENTTASKID='" + p.TASKID + "'").Length == 0);
            if (!string.IsNullOrEmpty(Request.QueryString["PROCESSNAME"]))
            {
                string PROCESSNME = Request.QueryString["PROCESSNAME"].ToString();
                lists = lists.FindAll(p => p.PROCESSNAME.Trim().ToUpper() == PROCESSNME.Trim());
            }
            COUNT = lists.Count.ToString();
            rptTask.DataSource = lists;
            rptTask.DataBind();
        }

        string GetFilter(string categoryName, out List<ParameterEntity> table)
        {
            SqlFilterUtil fb = new SqlFilterUtil(false);
            if (ddlProcessCategory.SelectedItem != null&&string.IsNullOrEmpty(categoryName))
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
            if (!string.IsNullOrEmpty(txtProcessCategory.Text)&& txtProcessCategory.Text != "allprocess")
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
            BindGrid("");
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
                string sql = @"select CNNAME from v_ORG_USER where LOGINNAME=N'" + INITIATOR.Replace("'", "''") + "'";
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid("");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);
        }

        /// <summary>
        /// 流程分类初始化
        /// </summary>
        /// <returns></returns>
        private DataTable ProcessCategoryInit()
        {
            //拼接按分类汇总待办任务数
            string processCategoryCount = @" ,(SELECT COUNT(1) FROM V_WF_TASKS a ";
            processCategoryCount += @" INNER JOIN WF_PROCESS C ON a.PROCESSNAME=c.PROCESSNAME ";
            processCategoryCount += @" WHERE a.ASSIGNEDTOUSER='{0}' and a.STATUS=1 ";
            if (ConfigurationManager.AppSettings["FilterTaskQueue"] == "1")
            {
                //增加过滤批量审批数据（批量审批数据先保存后执行，再次需要让数据过滤）
                processCategoryCount += @" and taskid not in (SELECT TASKID FROM WF_TASKQUEUE  WHERE STATUS <> 2 ) ";
            }

            if (ConfigurationManager.AppSettings["FilterAddSign"] == "1")
            {
                //待办任务过滤已发送的加签数据
                processCategoryCount += @" and taskid not in (SELECT PARENTTASKID FROM  WF_ADDSIGN where ( status<>'2' or status is null)) ";
            }
            processCategoryCount += @" and c.CATEGORYID = g.CATEGORYID ) CagegoryCount ";

            string loginname = SessionLogic.GetLoginName().Replace("\\", "/");
                processCategoryCount = string.Format(processCategoryCount, SessionLogic.GetLoginName().Replace("\\", "/"));
            
        

            //流程分类
            var processCategoryTable = new DataTable();

            string pcDataTextField = Lang.Get("CategoryNameField");
            if (pcDataTextField == "CATEGORYNAME")
            {
                pcDataTextField = "DISPLAYNAME";
            }
            if (pcDataTextField == "CategoryNameField"|| pcDataTextField== "CATEGORYENNAME")
            {
                pcDataTextField = "CATEGORYNAME";
            }            

            var sql = "select  CATEGORYNAME,{0} AS MAPCATEGORYNAME,Categoryid, ORDERNO ,EXT01 ,EXT02 " + processCategoryCount + " from WF_PROCESSCATEGORY g order by ORDERNO asc";
            sql = string.Format(sql, pcDataTextField);
            
            processCategoryTable = MyLib.DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            DataRow row = processCategoryTable.NewRow();
            row["CATEGORYNAME"] = "allprocess";
            row["MAPCATEGORYNAME"] = Lang.Get("NewTask_AllProcess");// "所有流程";           
            row["categoryid"] = "allprocess";
            row["ORDERNO"] = "0";
            row["EXT01"] = "color21-bg";
            row["EXT02"] = "icon-th-large";
            //加载所有流程待办任务数量
            SqlFilterUtil filter = new SqlFilterUtil();
            filter.AddEqual("a.STATUS", 1);
            row["CagegoryCount"] = lists.Count; //_workflow.GetTaskCount(SessionLogic.GetLoginName(), filter.GetFilterList()).ToString();
            processCategoryTable.Rows.InsertAt(row, 0);
            return processCategoryTable;
        }

        /// <summary>
        /// 按分类汇总待办任务数
        /// </summary>
        /// <param name="proceCagegoryId"></param>
        /// <returns></returns>
        public string getProcessCategoryCount(string proceCagegoryId)
        {
            if (!string.IsNullOrEmpty(proceCagegoryId))
            {
                string processCategoryCount = @" (SELECT COUNT(1) FROM V_WF_TASKS a ";
                processCategoryCount += @" INNER JOIN WF_PROCESS C ON a.PROCESSNAME=c.PROCESSNAME ";
                processCategoryCount += @" WHERE a.ASSIGNEDTOUSER='{0}' and a.STATUS=1 ";
                processCategoryCount += @" and c.CATEGORYID='{1}' ) ";
                processCategoryCount = string.Format(processCategoryCount, SessionLogic.GetLoginName().Replace("\\","/"), proceCagegoryId);
                Object obj = DataAccess.Instance("BizDB").ExecuteScalar(processCategoryCount);
                return ConvertUtil.ToInt32(obj).ToString();
            }
            else {
                return "0";
            }
        }
        /// <summary>
        /// 分类检索
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void rpProcessCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string categoryName = e.CommandArgument.ToString();
            txtProcessCategory.Text = categoryName;            
            BindGrid(categoryName);
        }
        public string GetStepName(object process,object step)
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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlProcessCategory.ClearSelection();
            txtProcessName.Text = "";
            ddlProcessName.ClearSelection();
            txtStepName.Text = "";
            txtSummary.Text = "";
            txtIncident.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);

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
            if (!string.IsNullOrEmpty(txtProcessCategory.Text)&& txtProcessCategory.Text != "allprocess")
            {
                processes = _workflow.GetCategoryProcessList("", txtProcessCategory.Text);
            }
            else
            {
                processes = _workflow.GetAllProcessList();
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
            sql = string.Format(sql, txtProcessName.Text, string.Join("','", steps));
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