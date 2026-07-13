using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Compilation;
using MyLib;
using System.Reflection;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using System.Data;
using MyLib.Json.Linq;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    /// <summary>
    /// UploadHandler 的摘要说明
    /// </summary>
    public class UploadAssociatedProcessHandler : IHttpHandler
    {
        private IAttachment logic = ServiceContainer.Instance().GetService<IAttachment>();
        private IWorkflow form = ServiceContainer.Instance().GetService<IWorkflow>();
        private ISerialNo sn = ServiceContainer.Instance().GetService<ISerialNo>();
        static object obj = new object();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            try
            {
                string method = context.Request["method"];
                switch (method)
                {
                    // 添加关联流程
                    case "InsertAssociatedProcess":
                        InsertAssociatedProcess(context);
                        break;
                    case "delete":
                        DeleteAssociatedProcessByGUID(context);
                        break;
                }
            }
            catch (Exception)
            {

            }
        }

        public void InsertAssociatedProcess(HttpContext context)
        {
            string taskids = context.Request["taskids"];
            string _formid = context.Request["formid"];
            string _Incident = context.Request["Incident"];
            string _StepName = HttpUtility.UrlDecode(context.Request["StepName"]);
            string _UserName = HttpUtility.UrlDecode(context.Request["USERNAME"]);
            string _ProcessName = HttpUtility.UrlDecode(context.Request["ProcessName"]);
            int _parse = ConvertUtil.ToInt32(context.Request["parseInt"]);
            string loading = string.Empty;

            if (string.IsNullOrEmpty(_UserName))
            {
                UserEntity ue = SessionLogic.GetLoginUserEntity();
                if (ue != null)
                    _UserName = ue.CNNAME;
            }

            if (!string.IsNullOrEmpty(taskids))
            {
                string sql = @"SELECT TASKID,
                              a.PROCESSNAME,
                              a.INCIDENT,
                              b.SUMMARY,
                              b.INITIATOR,
                              a.STEPLABEL,
                              a.TASKUSER,
                              a.ASSIGNEDTOUSER,
                              a.STATUS,
                              a.SUBSTATUS,
                              a.STARTTIME,
                              a.ENDTIME,
                              a.OVERDUETIME
                              ,b.STATUS as PROCESSSTATUS
                              FROM TASKS a 
                              INNER JOIN INCIDENTS b ON a.PROCESSNAME = b.PROCESSNAME AND a.INCIDENT = b.INCIDENT
                              INNER JOIN PROCESSSTEPS c ON a.PROCESSNAME=c.PROCESSNAME and a.PROCESSVERSION=c.PROCESSVERSION and a.STEPID=c.STEPID AND c.STEPTYPE=2
                              where a.TASKID in ({0})";
                DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(string.Format(sql, taskids));
                try
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        string taskid = ConvertUtil.ToString(dr["TASKID"]).Trim();
                        string incident = ConvertUtil.ToString(dr["INCIDENT"]);
                        string processName = ConvertUtil.ToString(dr["PROCESSNAME"]).Trim();
                        string documnet = string.Empty;
                        string formid = GetProcessFormid(processName, incident, ref documnet);
                        string DSummary = GetDisplaySummary(ConvertUtil.ToString(dr["SUMMARY"])).Trim();
                        string StepLabel = ConvertUtil.ToString(dr["STEPLABEL"]).Trim();
                        string STATUS = ConvertUtil.ToString(dr["PROCESSSTATUS"]).Trim();
                        string guid = Guid.NewGuid().ToString();

                        string sql1 = @"insert into WF_ASSOCIATEDPROCESS(ID,NEWGUID,FORMID,PROCESSNAME,INCIDENT,STEPNAME,ASSOCIATEDPROCESSNAME,ASSOCIATEDFORMID,DOCUMNET,TASKID,DISPLAYSUMMARY,ASSOCIATEDINCIDENT,STEPLABEL,STATUS,CREATEDATE,CREATEBY)
                                                            VALUES(@ID,@NEWGUID,@FORMID,@PROCESSNAME,@INCIDENT,@STEPNAME,@ASSOCIATEDPROCESSNAME,@ASSOCIATEDFORMID,@DOCUMNET,@TASKID,@DISPLAYSUMMARY,@ASSOCIATEDINCIDENT,@STEPLABEL,@STATUS,sysdate,@CREATEBY)";
                        DataAccess.Instance("BizDB").ExecuteNonQuery(sql1, SerialNoLogic.GetMaxNo("WF_ASSOCIATEDPROCESS", "ID"), guid,
                           _formid.Trim(), _ProcessName.Trim(), _Incident.Trim(), _StepName.Trim(), processName, formid, documnet, taskid, DSummary, incident, StepLabel, STATUS, _UserName);

                        loading += "<tr><td class='hidden-xs attno' style='text-align: center; word-break: break-all;'>" + (_parse + 1).ToString() + "</td>"
                        + "<td class='hidden-xs comments ' style='text-align: center; word-break: break-all;'>"
                            + "<a target='_blank' href='javascript:void(0)' onclick='javascript:objReport.openForm(\"" + formid + "\",\"" + processName + "\"," + incident + ");return false;' style='cursor: head'>" + documnet + @"</a></td>
                        <td style='text-align: center; word-break: break-all;'>" + processName + @"</td>
                        <td style='text-align: center; word-break: break-all;'>" + DSummary + @"</td>
                        <td class='hidden-xs' style='text-align: center; word-break: break-all;'>" + _UserName + @"</td>
                        <td style='display:none;text-align: center; word-break: break-all;'>" + DateTime.Now.ToString() + @"</td>
                        <td style='text-align: center;' id='AssociatedProcess_Repeater1_ctl" + _parse + "_Td1' style='text-align: center; word-break: break-all;'>"
                            + "<a onclick='if(confirm(\"" + Lang.Get("SecurityList_ConfirmDelete") + "\")){deleteAttAP(\"" + guid + "\",this)}' class='btn btn-icon btn-sm' href='javascript:void(0)'><i class='fa fa-trash'></i></a></td></tr>";
                        _parse++;
                    }

                }
                catch
                {

                }
            }
            if (!string.IsNullOrEmpty(loading))
            {
                context.Response.Write(loading);
            }
            else
            {
                context.Response.Write("");
            }
        }

        public bool DeleteAssociatedProcessByGUID(HttpContext context)
        {
            string guid = context.Request["guid"];
            string sql = string.Empty;
            if (guid.IndexOf(",") < 0)
            {
                sql = "delete from WF_ASSOCIATEDPROCESS where NEWGUID=@guid";
                if (DataAccess.Instance("BizDB").ExecuteNonQuery(sql, guid) > 0)
                    return true;
                else
                    return false;
            }
            else
            {
                sql = "delete from WF_ASSOCIATEDPROCESS where NEWGUID in (" + guid + ")";
                if (DataAccess.Instance("BizDB").ExecuteNonQuery(sql) > 0)
                    return true;
                else
                    return false;
            }
        }

        public string GetProcessFormid(string processName, string incident, ref string documnet)
        {
            string formid = string.Empty;
            string sql = "select tablename from wf_process where processname=@processName";
            string tableName = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar(sql, processName));
            if (!string.IsNullOrEmpty(tableName))
            {
                sql = "select FORMID,DOCUMENTNO from " + tableName + " where processname=@processName and incident=@incident";
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, processName, incident);
                if (dt != null && dt.Rows.Count > 0)
                {
                    formid = ConvertUtil.ToString(dt.Rows[0]["FORMID"]);
                    documnet = ConvertUtil.ToString(dt.Rows[0]["DOCUMENTNO"]);
                }
            }
            return formid;
        }

        /// <summary>
        /// 获取流程摘要
        /// </summary>
        /// <param name="SUMMARY"></param>
        /// <returns></returns>
        public string GetDisplaySummary(string SUMMARY)
        {
            string _displaySummary = SUMMARY;
            string[] sz = ConvertUtil.ToString(SUMMARY).Split(',');
            if (sz.Length == 3)
            {
                _displaySummary = sz[0] + "," + sz[1] + "]";
            }

            //序列化Json
            if (!string.IsNullOrEmpty(_displaySummary))
            {
                try
                {
                    var obj = JObject.Parse(_displaySummary);
                    if (obj != null)
                    {
                        _displaySummary = ConvertUtil.ToString(obj["documentNo"]);
                        if (!string.IsNullOrEmpty(ConvertUtil.ToString(obj["summary"])))
                        {
                            _displaySummary = ConvertUtil.ToString(obj["documentNo"]) + " - " + ConvertUtil.ToString(obj["summary"]);
                        }
                    }
                }
                catch (Exception)
                {

                }
            }
            return _displaySummary;
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