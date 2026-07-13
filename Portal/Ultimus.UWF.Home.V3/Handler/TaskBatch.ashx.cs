using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3.Handler
{
    /// <summary>
    /// TaskBatch 的摘要说明
    /// </summary>
    public class TaskBatch : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["method"];
            switch(method)
            {
                case "TaskBatch":
                    string taskid = context.Request["taskid"];
                    IWorkflow workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                    string[] sz = taskid.Split(',');
                    foreach (string str in sz)
                    {
                        //ApproveProcess(str, SessionLogic.GetLoginName(), "", "0", Lang.Get("TaskList_ApproveBatch", "en-US"));
                        workflow.InsertTaskQueue(str, "Approve", SessionLogic.GetLoginName(), "", 0,
                           null, Lang.Get("TaskList_ApproveBatch", "en-US"), "", new List<Ultimus.UWF.Workflow.Entity.ParameterEntity>(), "", "", "");
                    }
                    break;
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write("success");
        }


        public string ApproveProcess( string taskid, string userAccount, string processName,
            string incident, string comments)
        {

            DataTable dtApplicant = new DataTable();
            try
            {
                TaskEntity ety = new TaskEntity();
                int return_incident = 0;
                string tableName = "";
                string mainTable = string.Empty;
                string detailTable = string.Empty;
                string shortName = string.Empty;
                string module = string.Empty;

                string info = "";
                ety.ASSIGNEDTOUSER = userAccount;
                ety.TASKID = taskid;
                ety.COMMENTS = comments;
                string formid = "";
                IWorkflow workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                string prefix = "";
                string stepname = "";

                DataTable dttask = DataAccess.Instance("UltDB").ExecuteDataTable("select processname,steplabel,incident from tasks where taskid=@p", ety.TASKID);
                if (dttask.Rows.Count > 0)
                {
                    processName = ConvertUtil.ToString(dttask.Rows[0][0]).Trim();
                    stepname = ConvertUtil.ToString(dttask.Rows[0][1]).Trim();
                    incident = ConvertUtil.ToString(dttask.Rows[0][2]);
                }
                DataTable dtprocess = DataAccess.Instance("BizDB").ExecuteDataTable("select * from wf_process where processname=@p", processName);
                if (dtprocess.Rows.Count > 0)
                {
                    tableName = ConvertUtil.ToString(dtprocess.Rows[0]["TableName"]).Trim();
                    prefix = ConvertUtil.ToString(dtprocess.Rows[0]["ShortName"]).Trim();
                }
                DataSet ds = DataAccess.Instance("BizDB").ExecuteDataSet("select * from " + tableName + " where processname=@p and incident=@i", processName, incident);
                if (ds.Tables.Count > 0)
                {
                    ds.Tables[0].TableName = "MainTable";
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        formid = ConvertUtil.ToString(ds.Tables[0].Rows[0]["formid"]).Trim();
                    }

                }
                bool flag = workflow.SubmitForm(ds, new System.Collections.Hashtable(), ety.ASSIGNEDTOUSER, ety.ASSIGNEDTOUSER,
                    ety.TASKID.Trim(), processName, ConvertUtil.ToInt32(incident)
                    , stepname, tableName, formid, prefix,
                    true, "MYTASK", null, 0, "", ety.COMMENTS, ref info, "", false);

                if (flag)
                {
                    info = "success:" + incident;
                }
                else
                {
                    info = "failure:" + info;
                }

                if (info.IndexOf("failure") < 0)
                {
                    int i = ConvertUtil.ToInt32(info.Replace("success:", ""));
                    if (incident == "0")
                    {
                        return_incident = i;
                    }
                    else
                    {
                        return_incident = ConvertUtil.ToInt32(incident);
                    }
                }
                else
                {
                    throw new Exception(info);
                }

                return info;
            }
            catch (Exception e)
            {
                LogUtil.Error(e.ToString());
                throw e;
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}