using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Logic;
using MyLib;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using System.Web.SessionState;

namespace Ultimus.UWF.Home.V3
{
    /// <summary>
    /// Summary description for TaskStepsOverview
    /// </summary>
    public class TaskStepsOverview : IHttpHandler, IRequiresSessionState
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/html";            
            context.Response.Write(GetDataToHtml(context));
        }

        public String GetDataToHtml(HttpContext context)
        {
            string str_html = "";
            string str_html_head = @"<!DOCTYPE html> 
                                            <html lang='en'> 
                                            <head>
                                            <meta charset='utf-8'>
                                            <meta http-equiv='X-UA-Compatible' content='IE=edge'>
                                            <meta name='viewport' content='width=device-width, initial-scale=1,user-scalable=0'>
                                            <meta name='description' content='Ultimus BPM , Ultimus Business Process Management'>
                                            <meta name='keywords' content='ultimus, bpm, workflow, business process management'/>
                                            </head>
                                            <body>
                                            <form name='form1' id='form1'>
	                                            <div class='container-fluid'>
		                                            <fieldset>			                                            
			                                            <div class='row-fluid'>
				                                            <table class='table-striped' style='font-size:12px; width:100%;' >
				                                            <tr>
                                                                <th  style='width:10%;text-align:left;'>
						                                            <span class='' style='width:2px'>{0}</span>
					                                            </th>
					                                            <th style='width:20%'>
						                                            <span class=''>{1}</span>
					                                            </th>					                                             
					                                            <th style='width:15%'>
						                                            <span class=''>{2}</span>
					                                            </th>
					                                            <th class='' style='width:25%'>
						                                            <span class=''>{3}</span>
					                                            </th>
					                                            <th class='' style='width:25%'>
						                                            <span class=''>{4}</span>
					                                            </th>					                                            
				                                            </tr> ";

            str_html_head = string.Format(str_html_head, Lang.Get("TaskStatus_Status"),
               Lang.Get("TaskStatus_StepName"), Lang.Get("TaskStatus_Approver"), Lang.Get("TaskStatus_StartTime"),
               Lang.Get("TaskStatus_EndTime"));
            string str_html_end = @"</table>
			                        </div>			                       
		                                    </fieldset>
	                                    </div>
                                    </form>
                                    </body>
                                    </html>";
            string str_html_body = "";
            try
            {
                int incident = ConvertUtil.ToInt32(HttpContext.Current.Request["Incident"]);
                string processName = context.Server.UrlDecode(HttpContext.Current.Request["ProcessName"].ToString());
                string ServerName = context.Server.UrlDecode(HttpContext.Current.Request["ServerName"].ToString());
                if (incident > 0)
                {
                    string UserName = "";
                    string startTime = "";
                    string endTime = "";
                    string Status = "";
                    List<TaskEntity> list = _workflow.GetTaskList(" and a.processname=N'" + processName.Replace("'", "''") + "' and a.incident=" + incident + " and a.status=1 order by StartTime,a.status desc", new List<ParameterEntity>(), "StartTime", 0, 999);
                    foreach (TaskEntity pStep in list)
                    {
                        //// 5:数据库机器人 2:发起步骤 4:用户步骤 6:子流程
                        //int pStepType = _workflow.GetStepType(ServerName, pStep.TASKID, pStep.STEPID);
                        //if (pStepType != 2 && pStepType != 4 && pStepType != 6)
                        //{
                        //    if (pStep.STEPLABEL.Trim().ToUpper() != "COMPLETE")
                        //        continue;
                        //}

                        //获取中文名
                        try
                        {
                            IOrg org = ServiceContainer.Instance().GetService<IOrg>();
                            UserEntity taskUser = org.GetUserEntity(pStep.ASSIGNEDTOUSER.Replace("/","\\"));
                            if (taskUser != null)
                            {
                                // string pStepUser = pStep.ASSIGNEDTOUSER;
                                //int pIndex = pStepUser.Trim().IndexOf("/");
                                //if (pIndex > 0)
                                //{
                                //    pStepUser = pStepUser.Trim().Substring(pStepUser.Trim().IndexOf("/") + 1);
                                //}


                                UserName = taskUser.USERNAME+taskUser.ACCOUNT;
                            }
                        }
                        catch
                        {
                        }
                        
                        #region Date
                        if (pStep.STATUS.ToString() == "13")
                        {
                            startTime = "**********"; ;
                        }
                        else
                        {
                            startTime = Convert.ToDateTime(pStep.STARTTIME).ToString("yyyy-MM-dd HH:mm:ss").ToString();
                        }
                        if (pStep.STATUS.ToString() == "13" || pStep.STATUS.ToString() == "1")
                        {
                            endTime = "**********"; ;
                        }
                        else
                        {
                            endTime = Convert.ToDateTime(pStep.ENDTIME).ToString("yyyy-MM-dd HH:mm:ss").ToString();
                        }
                        #endregion

                        #region Status
                        if (pStep.STATUS.ToString() == "1")
                        {
                            Status = Lang.Get("TaskStatus_Active");
                        }
                        else if (pStep.STATUS.ToString() == "3")
                        {
                            Status = Lang.Get("TaskStatus_Completed");
                        }
                        else if (pStep.STATUS.ToString() == "4")
                        {
                            Status = Lang.Get("TaskStatus_Return");
                        }
                        else if (pStep.STATUS.ToString() == "7")
                        {
                            Status = Lang.Get("TaskStatus_Abort");
                        }
                        else if (pStep.STATUS.ToString() == "13")
                        {
                            Status = Lang.Get("TaskStatus_Queue");
                        }
                        else if (pStep.STATUS.ToString() == "19")
                        {
                            Status = Lang.Get("TaskStatus_Failure");
                        }
                        else
                        {
                            Status = Lang.Get("TaskStatus_Unknown");
                        }
                        #endregion 
                        //拼接赋值
                        str_html_body += " <tr style='line-height:30px;'>  <td class='label label-default' style='text-align:left;'>" + 
                            Status + "</td>  <td>" + pStep.STEPLABEL + "</td>    <td>" + UserName 
                            + "</td>    <td class='utcdatetime'>" + startTime + "</td>    <td class='utcdatetime'>" + endTime + "</td>    </tr> ";
                    }
                }

                str_html = str_html_head + str_html_body + str_html_end;
            }
            catch 
            {

            }
            return str_html;
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