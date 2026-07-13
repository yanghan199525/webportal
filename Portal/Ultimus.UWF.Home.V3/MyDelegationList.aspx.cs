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
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Home.V3.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class MyDelegationList : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string EnableProcessAssign = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Button4.Text = Lang.Get("Cancel_Delegation");
            btnSearch.Text = Lang.Get("btn_Search");
            if (!IsPostBack)
            {
                BindGrid();
            }

            if (ConfigurationManager.AppSettings["EnableProcessAssign"] == "0")
            {
                EnableProcessAssign = "hidden";
            }
        }

        void BindGrid()
        {
            List<ParameterEntity> table = new List<ParameterEntity>();
            string filter = GetFilter(out table);

            List<DelegationEntity> lists = new List<DelegationEntity>();

            lists = _workflow.GetDelegationTable(SessionLogic.GetLoginName(), filter, table, "T.ASSIGNFROM desc", 0, 999);

            ProcessesList.DataSource = lists;
            ProcessesList.DataBind();
        }

        string GetFilter(out List<ParameterEntity> table)
        {
            SqlFilterUtil fb = new SqlFilterUtil(false);
            if (!string.IsNullOrEmpty(txtProcessName.Text))
            {
                ProcessLogic pl = new ProcessLogic();
                fb.AddLike(" NVL(W.CNNAME,'所有')", pl.GetProcessName(txtProcessName.Text));
            }
            fb.AddLike("a.CNNAME", ConvertUtil.ToString(txtAssignUser.Text).Trim());
            DateTime startTime = DateTime.Now;
            DateTime endTime = DateTime.Now.AddYears(2);

            if (!string.IsNullOrEmpty(txtStartDate.Text) && string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = ConvertUtil.ToDateTime(txtStartDate.Text);
                endTime = DateTime.Now.AddYears(2);
            }
            if (string.IsNullOrEmpty(txtStartDate.Text) && !string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = DateTime.Now.AddMonths(-120);
                endTime = ConvertUtil.ToDateTime(txtEndDate.Text + " 23:59:59");
            }
            if (string.IsNullOrEmpty(txtStartDate.Text) && string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = DateTime.Now.AddMonths(-120);
                endTime = DateTime.Now.AddYears(2);
            }
            if (!string.IsNullOrEmpty(txtStartDate.Text) && !string.IsNullOrEmpty(txtEndDate.Text))
            {
                startTime = ConvertUtil.ToDateTime(txtStartDate.Text);
                endTime = ConvertUtil.ToDateTime(txtEndDate.Text + " 23:59:59");
            }
            //if (rdActive.Checked)
            //{
            //    fb.AddEqual("T.STATUS", "1");
            //}
            //if (rdDisable.Checked)
            //{
            //    fb.AddEqual("T.STATUS", "0");
            //}
            //msg += " AND ASSIGNFROM >= '" + startTime + "' AND ASSIGNUNTIL <= '" + endTime + "'";
            table = new List<ParameterEntity>();
            table.Add(new ParameterEntity("STARTTIME", startTime.ToString("yyyy-MM-dd HH:mm:ss")));
            table.Add(new ParameterEntity("ENDTIME", endTime.ToString("yyyy-MM-dd HH:mm:ss")));
          

            return fb.ToString();
        }

        private void MessageBox(string script)
        {
            this.Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "javascript", "<script language='javascript' defer>" + script + "</script>");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            try
            {
                int DBcount = 0;
                int BIZcount = 0;
                foreach (RepeaterItem item in ProcessesList.Items)
                {
                    HtmlInputCheckBox cb = item.FindControl("Processes_checkbox") as HtmlInputCheckBox;

                   
                    if (cb.Checked)
                    {
                        string ProcessNames = (item.FindControl("lblProcessName") as Label).Text.Trim();
                        string ASSIGNEDTOUSER = (item.FindControl("lblASSIGNEDTOUSER") as Label).Text.Trim();
                        string ASSIGNFROM = (item.FindControl("lblASSIGNFROM") as Label).Text.Trim();
                        string STATUS = (item.FindControl("Label2") as Label).Text.Trim();
                        //if (STATUS == "禁用")
                        //    return;
                        DateTime dtASSIGNFROM = ConvertUtil.ToDateTime(ASSIGNFROM);
                        //操作产品库
                   
                        bool res = _workflow.WithdrawDelegationTask(ProcessNames.Trim() == "All Process" ? "所有" : ProcessNames.Trim(), ASSIGNEDTOUSER, ASSIGNFROM);
                        if (res)
                            DBcount++;
                        BIZcount++;
                        if (ProcessNames.Trim() == "所有")
                        {
                            
                             DataAccess.Instance("BizDB").ExecuteNonQuery(
                                "UPDATE COM_ASSIGNMENT SET remark=N'被代理人取消代理操作' where PROCESSNAME=N'所有' and ASSIGNEDTOUSER=@ASSIGNEDTOUSER and ASSIGNFROM=@ASSIGNFROM", ASSIGNEDTOUSER, ASSIGNFROM);
                        }
                        else
                        {
                            
                            DataAccess.Instance("BizDB").ExecuteNonQuery(
                                "UPDATE COM_ASSIGNMENT SET remark=N'被代理人取消代理操作' where PROCESSNAME=@PROCESSNAME and ASSIGNEDTOUSER=@ASSIGNEDTOUSER and ASSIGNFROM=@ASSIGNFROM", ProcessNames, ASSIGNEDTOUSER, ASSIGNFROM);
                        }
                    }
                }
                if (DBcount > 0)
                {
                    BindGrid();
                    MessageBox("alert('取消成功！');");
                }
                else
                {
                    BindGrid();
                    MessageBox("alert('请选中行！');");
                }
            }
            catch (Exception ex)
            {
                MessageBox("alert('" + ex.Message + "');");
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "serachVisible", "document.getElementById('searchPanel').style.display='block';", true);
        }

        public string GetProcessCN(string processName)
        {
            string msg = string.Empty;
            if (processName.Trim() != "所有")
                msg = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar("SELECT CNNAME FROM WF_PROCESS WHERE PROCESSNAME=@PROCESSNAME", processName.Trim()));
            if (string.IsNullOrEmpty(msg))
                msg = processName;
            return msg;
        }
    }
}