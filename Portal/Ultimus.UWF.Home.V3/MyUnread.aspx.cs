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
using System.Reflection;
using Ultimus.UWF.OrgChart.Entity;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyUnread : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string COUNT = "0";
        UserEntity loginUser = SessionLogic.GetLoginUserEntity();


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
            RadioButtonList rdStatus = Page.FindControl("rdStatus") as RadioButtonList;
            rdStatus.Items.Add(new ListItem(Lang.Get("TaskList_All"), ""));
            rdStatus.Items.Add(new ListItem(Lang.Get("TaskStatus_Active"), "1"));
            rdStatus.Items.Add(new ListItem(Lang.Get("TaskStatus_Completed"), "2"));
            rdStatus.SelectedValue = "";
        }
        private List<WF_READS> getReadsList(ref List<WF_READS> readsList)
        {
            if (ddlProcessCategory.SelectedItem != null)
            {
                txtProcessCategory.Text = ddlProcessCategory.SelectedItem.Value;
            }
            if (!string.IsNullOrEmpty(txtProcessCategory.Text) && txtProcessCategory.Text != Lang.Get("TaskList_AllProcess"))
            {
                List<ProcessEntity> processes = _workflow.GetCategoryProcessList("", txtProcessCategory.Text);
                List<string> strs = new List<string>();
                foreach (ProcessEntity process in processes)
                {
                    strs.Add(process.PROCESSNAME);
                }
                readsList = readsList.FindAll(delegate(WF_READS reModel)
                {
                    if (strs.Where(p => p == reModel.PROCESSNAME.Trim()).Count() > 0)
                        return true;
                    else
                        return false;
                });
            }
            if (!string.IsNullOrEmpty(txtProcessName.Text))
            {
                readsList = readsList.FindAll(p => Lang.Get(MyLib.ConvertUtil.ToString(p.PROCESSNAME)).ToUpper().Contains(txtProcessName.Text.ToUpper().Trim()));
            }
            if (!string.IsNullOrEmpty(txtStepName.Text))
            {
                readsList = readsList.FindAll(p => p.STEPLABEL.ToUpper().Contains(txtStepName.Text.ToUpper().Trim()));
            }
            if (!string.IsNullOrEmpty(txtStartDate.Text))
            {
                readsList = readsList.FindAll(p => p.STARTTIME >= ConvertUtil.ToDateTime(txtStartDate.Text));
            }
            if (!string.IsNullOrEmpty(txtEndDate.Text))
            {
                readsList = readsList.FindAll(p => p.STARTTIME <= ConvertUtil.ToDateTime(txtEndDate.Text + " 23:59:59"));
            }
            if (!string.IsNullOrEmpty(txtSummary.Text))
            {
                readsList = readsList.FindAll(p => p.SUMMARY.ToUpper().Contains(txtSummary.Text.ToUpper().Trim()));
            }
            RadioButtonList rdStatus = Page.FindControl("rdStatus") as RadioButtonList;
            if (!string.IsNullOrEmpty(rdStatus.SelectedValue))
            {
                readsList = readsList.FindAll(p => ConvertUtil.ToString(DataAccess.Instance("UltDB").ExecuteScalar(string.Format(@"select STATUS from INCIDENTS where
            PROCESSNAME=N'{0}' and INCIDENT={1}", p.PROCESSNAME, p.INCIDENT))) == rdStatus.SelectedValue);
            }
            return readsList;

        }

        void BindGrid()
        {
            UserEntity loginUser = SessionLogic.GetLoginUserEntity();
            string sql = @"SELECT  max(ID) ID, '' ServerName, TASKID, PROCESSNAME,SUMMARY, INCIDENT, STEPID, APPLICANT,APPLICANTNAME, STATUS, READFLAG, READER,
            STEPLABEL, STARTTIME FROM WF_READS WHERE READFLAG = 0 and STATUS=0 AND READER = '" + loginUser.LOGINNAME.Replace("CustomOC\\", "CustomOC/").ToString() +
            "'GROUP BY TASKID, PROCESSNAME, INCIDENT, STEPID, APPLICANT, APPLICANTNAME, STATUS, READFLAG, READER, STEPLABEL, STARTTIME, SUMMARY ORDER BY ID DESC"; //READFLAG=1 => 已阅
            List<WF_READS> readsList = DataAccess.Instance("BizDB").ExecuteList<WF_READS>(sql);
            getReadsList(ref readsList);

            COUNT = readsList.Count.ToString();
            rptTask.DataSource = readsList;
            rptTask.DataBind();
        }
        public string getIncidentsStatus(string PROCESSNAME, string INCIDENT)
        {
            string status = ConvertUtil.ToString(DataAccess.Instance("UltDB").ExecuteScalar(string.Format(@"select STATUS from INCIDENTS where
            PROCESSNAME=N'{0}' and INCIDENT={1}", PROCESSNAME, INCIDENT)));
            string msg = string.Empty;
            if (status == "1")
            {
                msg = Lang.Get("TaskStatus_Active");
            }
            else if (status == "2")
            {
                msg = Lang.Get("TaskStatus_Completed");
            }
            else if (status == "4")
            {
                msg = Lang.Get("TaskStatus_Abort");
            }
            else if (status == "8")
            {
                msg = Lang.Get("TaskStatus_Suspend");
            }
            else if (status == "33")
            {
                msg = Lang.Get("TaskStatus_Stalled");
            }
            else
            {
                msg = Lang.Get("TaskStatus_Unknown");
            }
            return "<span class=\"" + GetStatusClass(status) + "\">" + msg + "</span>";
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

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindGrid();
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);
        }

        public string GetUserCN(string APPLICANT)
        {
            //string sql = @"select USERNAME from v_ORG_USER where ACCOUNT=N'" + APPLICANT + "'";
            //DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            //string str = string.Empty;
            //if (dt != null && dt.Rows.Count > 0)
            //    str = Convert.ToString(dt.Rows[0]["USERNAME"]);
            //return str;
            string res = string.Empty;
            try
            {
                APPLICANT = ConvertUtil.ToString(APPLICANT.Replace("/", "\\").Trim());
                string sql = @"select CNNAME from v_ORG_USER where ACCOUNT=N'" + APPLICANT + "'";
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
    }
}