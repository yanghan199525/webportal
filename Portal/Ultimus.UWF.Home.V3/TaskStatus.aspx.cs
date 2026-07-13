using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public class TaskStatus : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string HIDDEN = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string processName = Server.UrlDecode(Request.QueryString["ProcessName"]);
            string taskId = ConvertUtil.ToString(Request.QueryString["taskId"]);
            string ServerName = Server.UrlDecode(Request.QueryString["ServerName"]);
            TaskEntity task = _workflow.GetTaskEntity(ServerName, taskId);
            //int incident = ConvertUtil.ToInt32(Request.QueryString["Incident"]);
            int incident = 0;
            if (task != null)
            {
                incident = task.INCIDENT;
            }

            //是否没有在配置表中有，如果没有，那么为V7
            ProcessEntity process = _workflow.GetProcessInfo("", processName);
            if (process != null)
            {
                if (process.ULTIMUSVERSION == "V7")
                {
                    if (incident == 0)
                    {
                        Response.Write("<script>window.close();</script>");
                        Response.End();
                    }
                    else
                    {
                        Response.Redirect(ConfigurationManager.AppSettings["V7TaskStatusUrl"] + "?taskid=" + _workflow.GetViewTaskID("", processName, incident));
                    }
                }
            }
            //IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
            //StepSetting stepPage = stepSettings.GetStep(processName, stepLabel); //.net表单


            if (incident <= 0)
            {
                HIDDEN = "hide";
                btnClose.Visible = false;
            }
            try
            {
                btnClose.Text = Lang.Get("TaskStatus_Close");
                List<TaskEntity> list = _workflow.GetTaskList(" and a.processname=N'" + processName.Replace("'", "''") + "' and a.incident=" + incident + " order by StartTime,a.status desc", new List<ParameterEntity>(), "StartTime,a.status desc", 0, 999);
                byte[] bytesGif;
                int j = 0;
            Auto: bytesGif = _workflow.GetFlowChart(ServerName, processName, incident);
                if (bytesGif == null && j < 4)
                {
                    j++;
                    goto Auto;
                }
                Session["flowpic"] = bytesGif;

                DataTable pGetData = this.Blank();

                foreach (TaskEntity pStep in list)
                {
                    // 5:数据库机器人 2:发起步骤 4:用户步骤 6:子流程
                    int pStepType = _workflow.GetStepType(ServerName, pStep.TASKID, pStep.STEPID);
                    if (pStepType != 2 && pStepType != 4 && pStepType != 6)
                    {
                        if (pStep.STEPLABEL.Trim().ToUpper() != "COMPLETE")
                            continue;
                    }

                    DataRow pRow = pGetData.NewRow();
                    pRow["StepName"] = pStep.STEPLABEL;

                    string pStepUser = pStep.ASSIGNEDTOUSER;
                    if (pStepUser == null)
                    {
                        pStepUser = pStep.TASKUSER;
                        if (pStepUser == null)
                        {
                            pStepUser = "";
                            continue;

                        }
                    }

                    //获取fullname
                    string pFullName = pStepUser;
                    try
                    {
                        IOrg org = ServiceContainer.Instance().GetService<IOrg>();// SessionLogic.GetOrgType(SessionLogic.GetLoginName(pStepUser));
                        IDomain domain1 = ServiceContainer.Instance().GetService<IDomain>();
                        UserEntity ety = org.GetUserEntity(pStepUser);
                        if (ety != null)
                        {
                            pFullName = ety.USERNAME;
                            if (pFullName == null)
                            {
                                pFullName = "";
                            }
                        }
                    }
                    catch
                    {
                    }

                    try
                    {
                        IOrg org = ServiceContainer.Instance().GetService<IOrg>();// SessionLogic.GetOrgType(SessionLogic.GetLoginName(pStep.TASKUSER));
                        IDomain domain1 = ServiceContainer.Instance().GetService<IDomain>();
                        UserEntity taskUser = org.GetUserEntity(pStep.TASKUSER);
                        if (taskUser != null)
                        {
                            pRow["TaskUserName"] = taskUser.USERNAME;
                        }
                    }
                    catch
                    {
                    }

                    //去掉域名
                    int pIndex = pStepUser.Trim().IndexOf("/");
                    if (pIndex > 0)
                        pStepUser = pStepUser.Trim().Substring(pStepUser.Trim().IndexOf("/") + 1);


                    //去掉域名
                    int pIndex1 = pFullName.Trim().IndexOf("/");
                    if (pIndex1 > 0)
                        pFullName = pFullName.Trim().Substring(pFullName.Trim().IndexOf("/") + 1);

                    pRow["StepUser"] = pFullName + "(" + pStepUser + ")";
                    if (pStepType == 6) //子流程
                    {
                        DataTable dt = _workflow.GetSubProcess(pStep.TASKID);
                        if (dt.Rows.Count > 0)
                        {
                            pRow["StepUser"] = string.Format("<a href='TaskStatus.aspx?processname={0}&incident={1}&TaskId={4}&servername={2}&t={3}' target='_blank'>{0} - {1}</a>",
                                ConvertUtil.ToString(dt.Rows[0]["CNAME"]), ConvertUtil.ToString(dt.Rows[0]["CINCIDENT"]), Request.QueryString["ServerName"], Guid.NewGuid().ToString(), pStep.TASKID);
                        }
                    }

                    if (pStep.STATUS.ToString() == "13")
                    {
                        pRow["StartTime"] = "**********";
                    }
                    else
                    {
                        pRow["StartTime"] = pStep.STARTTIME;
                    }
                    if (pStep.STATUS.ToString() == "13" || pStep.STATUS.ToString() == "1")
                    {
                        pRow["EndTime"] = "**********";
                    }
                    else
                    {
                        pRow["EndTime"] = pStep.ENDTIME;
                    }

                    if (pStep.STATUS.ToString() == "1")
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Active");
                        pRow["CopyLink"] = "<a href='#' onclick=copyLink('" + WebUtil.GetRootPath() + "','" + pStep.TASKID + "','" + pStep.ASSIGNEDTOUSER + "')>Copy Link</a>";
                    }
                    else if (pStep.STATUS.ToString() == "3")
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Completed");
                    }
                    else if (pStep.STATUS.ToString() == "4")
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Return");
                    }
                    else if (pStep.STATUS.ToString() == "7")
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Abort");
                    }
                    else if (pStep.STATUS.ToString() == "13")
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Queue");
                    }
                    else if (pStep.STATUS.ToString() == "19")
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Failure");
                    }
                    else
                    {
                        pRow["Status"] = Lang.Get("TaskStatus_Unknown");
                    }

                    pGetData.Rows.Add(pRow);
                }
                //绑定数据源
                if (pGetData.Rows.Count > 0)
                {
                    this.DataBind(pGetData);
                }
                else
                {
                    this.DataBindDefaultData(pGetData);
                }
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 得到缺省的数据
        /// </summary>
        /// <returns></returns>
        private DataTable Blank()
        {
            DataTable pGetData = new DataTable();

            DataColumn pCol4 = new DataColumn("StepName");
            pGetData.Columns.Add(pCol4);

            DataColumn pCol5 = new DataColumn("StepUser");
            pGetData.Columns.Add(pCol5);

            DataColumn pCol6 = new DataColumn("StartTime", typeof(DateTime));
            pGetData.Columns.Add(pCol6);

            DataColumn pCol7 = new DataColumn("EndTime");
            pGetData.Columns.Add(pCol7);

            DataColumn pCol8 = new DataColumn("Status");
            pGetData.Columns.Add(pCol8);

            DataColumn pCol9 = new DataColumn("TaskUserName");
            pGetData.Columns.Add(pCol9);
            DataColumn pCol10 = new DataColumn("CopyLink");
            pGetData.Columns.Add(pCol10);
            return pGetData;
        }


        //目的  设置网格行数
        //参数  myDataTable－数据表；intPageCount－每页行数；intCol－加空行的列号
        public static void SetTableRows(ref DataTable myDataTable, int intPageCount)
        {
            int intTemp = myDataTable.Rows.Count % intPageCount;
            if ((myDataTable.Rows.Count == 0) || (intTemp != 0))
            {
                for (int i = 0; i < (intPageCount - intTemp); i++)
                {
                    DataRow myDataRow = myDataTable.NewRow();
                    myDataTable.Rows.Add(myDataRow);
                }
            }
        }

        /// <summary>
        /// 绑定缺省的空数据
        /// </summary>
        /// <param name="pBindData"></param>
        private void DataBindDefaultData(DataTable pDataTable)
        {
            DataView dv = pDataTable.DefaultView;
            dv.Sort = "StartTime";
            this.rptTaskList.DataSource = dv;
            this.rptTaskList.DataBind();
        }

        /// <summary>
        /// 绑定数据源
        /// </summary>
        /// <param name="pDataTable"></param>
        public void DataBind(DataTable pDataTable)
        {
            DataView dv = pDataTable.DefaultView;
            //dv.Sort = "StartTime,Status";
            this.rptTaskList.DataSource = pDataTable.DefaultView;
            this.rptTaskList.DataBind();

        }



        protected global::System.Web.UI.WebControls.Repeater rptTaskList;
        protected global::System.Web.UI.WebControls.Button btnClose;

    }
}