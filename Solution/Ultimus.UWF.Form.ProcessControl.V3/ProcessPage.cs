using MyLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Form;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public class ProcessPage : FormPage
    {
        /// <summary>
        /// 根据流程名和实例号获取表单数据
        /// </summary>
        public DataSet LoadData(string processName, int incident)
        {
            //获取表名
            DataTable processDt = DataAccess.Instance("BizDB").ExecuteDataTable(
                "select TABLENAME,DETAILTABLENAMES from WF_Process where PROCESSNAME=@p1 ", processName);
            if (processDt.Rows.Count == 0)
            {
                throw new Exception("TABLENAME can not found in WF_Process table.");
            }
            //表
            string tableName = ConvertUtil.ToString(processDt.Rows[0][0]);
            string detailTableNames = ConvertUtil.ToString(processDt.Rows[0][1]);
            //FormId,可以通过formid传过来，也可以通过实例号来查询
            string formID = HttpContext.Current.Request.QueryString["FormID"];
            if (!string.IsNullOrEmpty(formID) && HttpContext.Current.Request.QueryString["hasformid"] == "1")
            {
            }
            else if (incident > 0)
            {
                formID = GetFormID(tableName, processName, incident);
            }

            return LoadData(tableName + "," + detailTableNames, "FORMID", formID);
        }

        /// <summary>
        /// 流程提交
        /// </summary>
        /// <param name="ds">页面数据</param>
        /// <returns></returns>
        public override string OnSubmit(DataSet ds)
        {
            try
            {
                bool flag = false;
                IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                //TaskId
                string taskID = GetQueryString(ds,"TaskID");
                if (string.IsNullOrEmpty(taskID))
                {
                    return GetReturnMessage(false, "Task ID is null");
                }
                //获取流程名实例号
                string processName = GetQueryString(ds, "ProcessName");
                int incident = ConvertUtil.ToInt32(GetQueryString(ds, "incident"));
                if (string.IsNullOrEmpty(processName))
                {
                    TaskEntity taskEntity = _workflow.GetTaskEntity("", taskID);
                    if(taskEntity==null)
                    {
                        return GetReturnMessage(false, "Can not found the task!");
                    }
                    incident = taskEntity.INCIDENT;
                    processName = ConvertUtil.ToString(taskEntity.PROCESSNAME).Trim();
                }
                //类型myrequest,mytask...
                string type = GetQueryString(ds, "type").ToUpper().Trim();
                //步骤名
                string stepName = GetQueryString(ds, "StepName");
                //获取prefix,tableName
                DataTable processDt = DataAccess.Instance("BizDB").ExecuteDataTable(
                    "select TABLENAME,SHORTNAME,DETAILTABLENAMES from WF_Process where PROCESSNAME=@p1", processName);
                string prefix = "";
                string tableName = "";
                string detailTables = "";
                if (processDt.Rows.Count > 0)
                {
                    prefix = ConvertUtil.ToString(processDt.Rows[0][1]);
                    tableName = ConvertUtil.ToString(processDt.Rows[0][0]);
                    detailTables = ConvertUtil.ToString(processDt.Rows[0][2]);
                }
                //是否为发起流程
                bool isCreateForm = false;
                if (incident <= 0)
                {
                    isCreateForm = true;
                }
                //form id
                string formID = "";
                if (isCreateForm) //新的formid
                {
                    formID = Guid.NewGuid().ToString();
                }
                else
                {
                    formID = GetFormValue("FormID"); //已经在页面里面有
                    if (string.IsNullOrEmpty(formID)) //根据incident去取
                    {
                        formID = GetFormID(tableName, processName, incident);
                    }
                }
                //申请人姓名
                string applicant = GetFormValue("Applicant");
                //操作类型 0:同意 1:退回 2：拒绝 3：选择性退回 -1:草稿
                int actionType = ConvertUtil.ToInt32(Request["ActionType"]);
                //选择性退回的步骤
                string returnStep = ConvertUtil.ToString(Request["ReturnStep"]).ToUpper().Trim();
                //单据号
                string documentNo = GetFormValue("DOCUMENTNO");
                //流程摘要
                string PROCESSSUMMARY = GetFormValue("PROCESSSUMMARY");
                //部门
                string DEPARTMENT = GetFormValue("DEPARTMENT");
                string error = "";
                Hashtable vars = new Hashtable();

                //获取当前登录用户
                string loginname = SessionLogic.GetLoginName();
                if (string.IsNullOrEmpty(loginname))
                {
                    return GetReturnMessage(false, "Login Name empty!");
                }
                //流程摘要
                string summary = PROCESSSUMMARY + DEPARTMENT;
                //审批意见
                string comments = GetFormValue("ApprovalHistory", "Comments");
                //ultimus流程变量 #var
                DataTable dtMain = ds.Tables["MainTable"];
                if (dtMain != null && dtMain.Rows.Count > 0)
                {
                    foreach (DataColumn col in dtMain.Columns)
                    {
                        string name = ConvertUtil.ToString(col.ColumnName).Split('#')[0];
                        if (ConvertUtil.ToString(col.ColumnName).ToLower().Contains("#var"))
                        {
                            vars.Add(name, ConvertUtil.ToString(dtMain.Rows[0][col]));
                        }
                        col.ColumnName = name;
                    }

                    if (!dtMain.Columns.Contains("FORMID"))
                    {
                        dtMain.Columns.Add("FORMID");
                    }
                    dtMain.Rows[0]["FORMID"] = formID;
                    if(!dtMain.Columns.Contains("PROCESSNAME"))
                    {
                        dtMain.Columns.Add("PROCESSNAME");
                    }
                    dtMain.Rows[0]["PROCESSNAME"] = processName;
                    if (!dtMain.Columns.Contains("INCIDENT"))
                    {
                        dtMain.Columns.Add("INCIDENT");
                    }
                    dtMain.Rows[0]["INCIDENT"] = incident;
                    if (!dtMain.Columns.Contains("REQUESTDATE"))
                    {
                        dtMain.Columns.Add("REQUESTDATE");
                    }
                    dtMain.Rows[0]["REQUESTDATE"] = DateTime.Now;
                }
                //提交
                ds.Tables.Remove("QueryString");
                //明细行FormID及RowGuid
                foreach(DataTable dt in ds.Tables)
                {
                    if(dt.TableName!="MainTable")
                    {
                        bool hasRowGuid = true;
                        if (!dt.Columns.Contains("FORMID"))
                        {
                            dt.Columns.Add("FORMID");
                        }
                        if (!dt.Columns.Contains("ROWGUID"))
                        {
                            dt.Columns.Add("ROWGUID");
                            hasRowGuid = false;
                        }
                        if (!dt.Columns.Contains("PROCESSNAME"))
                        {
                            dt.Columns.Add("PROCESSNAME");
                        }
                        if (!dt.Columns.Contains("INCIDENT"))
                        {
                            dt.Columns.Add("INCIDENT");
                        }
                        foreach (DataRow row in dt.Rows)
                        {
                            row["FORMID"] = formID;
                            row["PROCESSNAME"] = processName;
                            row["INCIDENT"] = incident;
                            if (!hasRowGuid || string.IsNullOrEmpty(ConvertUtil.ToString(row["ROWGUID"])))
                            {
                                row["ROWGUID"] = Guid.NewGuid().ToString();
                            }
                        }
                    }
                }
                if (actionType == -1) //-1提交草稿
                {
                    flag = _workflow.SaveDraft(ds, loginname, taskID, processName,
                    stepName, tableName, detailTables, formID, prefix, type, summary, ref error);
                }
                else //0提交、0同意、1退回、2拒绝
                {
                    flag = _workflow.SubmitForm(ds, vars, loginname, applicant, taskID, processName,
                        incident, stepName, tableName, formID, prefix, isCreateForm, type,
                        summary, actionType, returnStep, comments, ref error, documentNo, true);
                }
                if (!flag || !string.IsNullOrEmpty(error))
                {
                    return GetReturnMessage(false, error.Replace("'", "").Replace("\"", ""));
                }
            }
            catch (Exception ex)
            {
                return GetReturnMessage(false, ex.Message.Replace("'", "").Replace("\"", ""));
            }

            return GetReturnMessage(true, "");
        }

        public string GetQueryString(DataSet ds,string queryString)
        {
            DataTable dt = ds.Tables["QueryString"];
            if(dt!=null)
            {
                if(dt.Rows.Count>0)
                {
                    return ConvertUtil.ToString(dt.Rows[0][queryString]).Trim();
                }
            }
            return "";
        }
    }
}