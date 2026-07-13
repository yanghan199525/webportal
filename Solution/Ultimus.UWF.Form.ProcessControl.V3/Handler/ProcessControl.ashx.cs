using MyLib;
using MyLib.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3.Handler
{
    /// <summary>
    /// ProcessControl 的摘要说明
    /// </summary>
    public class ProcessControl : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request.QueryString["method"];
            string returnValue = "";
            switch (method.ToUpper())
            {
                //获得传阅记录
                case "GETCIRCULATION":
                    returnValue = GETCIRCULATION(context);
                    break;
                // 添加传阅
                case "INSERTCIRCULATION":
                    returnValue = InsertCirculation(context);
                    break;
                //删除传阅
                case "DELETECIRROW":
                    returnValue = DeleteCirRow(context);
                    break;
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(returnValue);
        }

        string GETCIRCULATION(HttpContext context)
        {
            string processName = context.Request["PROCESSNAME"].ToString().Trim();
            string incident = context.Request["INCIDENT"].ToString().Trim();
            string account = SessionLogic.GetLoginName();
            string strSql = string.Format(@" select * from WF_READS
                    where PROCESSNAME=N'{0}' and INCIDENT='{1}'", processName, incident);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(strSql);
            StringBuilder sb = new StringBuilder("");
            int num = 1;
            foreach (DataRow item in dt.Rows)
            {
                if (account != item["APPLICANT"].ToString().Trim() && item["STATUS"].ToString() == "0")
                {
                }
                else
                {
                    sb.Append("<tr> <td  class=\"td_no\" data-label=\"序号\">" +
                                              "<div class=\"index\">" +
                                                  "<span>" + num + "</span>" +
                                                    "</div></td>" +
                                          "<td class=\"td_guid\">" +
                                              "<div>" +
                                                 " <span >" + item["READUSERNAME"] + "</span>" +
                                             "</div>" +
                                          "</td>" +
                                          "<td class=\"hidden-xs\">" +
                                              "<span >" + item["OPINION"] + "</span>" +
                                         " </td>" +
                                          "<td class=\"text-center\">" +
                                          "<span >" + (item["READFLAG"].ToString() == "1" ? "已阅" : "待阅") + "</span>" +
                                         " </td>" +
                                          "<td class=\"text-center\">" +
                                              "<span >" + item["APPLICANTNAME"] + "</span>" +
                                         " </td>" +
                                         " <td class=\"text-center\">" +
                                              "<span >" + ConvertUtil.ToShortDateTimeString(item["STARTTIME"]) + "</span>" +
                                         " </td>" +
                                          "<td class=\"text-center\"><span class=\"hidden\">" + item["ID"] + "</span>");
                    if (account == item["APPLICANT"].ToString().Trim() && item["READFLAG"].ToString() != "1")
                    {
                        sb.Append("<button  onclick=\"if(confirm('确认删除？')){CirculationUserInfo_DeleteRowClick(this)}return false;\" class=\"btn btn-icon btn-sm\">" +
                           " <i class=\"fa fa-trash\"></i>" +
                       " </button>");
                    }

                    sb.Append("</td> </tr>");
                    num++;
                }
            }
            return sb.ToString();
        }


        /// <summary>
        /// shan
        /// </summary>
        string DeleteCirRow(HttpContext context)
        {
            try
            {
                string ID = context.Request.Params["ID"];
                int i = DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("delete WF_READS where ID={0}", ID));
                if (i > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception)
            {
                return "0";
            }
        }
        //添加传阅
        public string InsertCirculation(HttpContext context)
        {
            try
            {
                #region 获取参数,定义变量
                string type = context.Request["TYPE"];
                string readusername = context.Request["READUSERNAME"];
                string readloginname = ConvertUtil.ToString(context.Request["READLOGINNAME"]).Replace("\\", "/");
                string opinion = StringFilter.FilterHtmls(StringFilter.FilterSql(ConvertUtil.ToString(context.Request["OPINION"])));
                string processname = context.Request["PROCESSNAME"].ToString().Trim();
                string incident = context.Request["INCIDENT"].ToString().Trim();
                string stepname = context.Request["STEPNAME"].ToString().Trim();
                string taskid = context.Request["TASKID"].ToString().Trim();
                string readstatus = "0";
                if (type.ToUpper() == "MYREQUEST" || type.ToUpper() == "MYAPPROVAL")
                    readstatus = "1";
                UserEntity model = SessionLogic.GetLoginUserEntity();
                string applicant = SessionLogic.GetLoginName();
                string applicantUserName = model.USERNAME;
                string createDate = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
                IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
                StepSetting ss = stepSettings.GetStep(processname, stepname);
                string summyary = "";
                if (DatabaseUtil.IsOracle("BizDB"))
                    summyary = ConvertUtil.ToString(DataAccess.Instance("UltDB").ExecuteScalar(string.Format(
                    "select trim(SUMMARY) from  INCIDENTS where trim(processname)=N'{0}' and INCIDENT='{1}'", processname, incident)));
                else
                    summyary = ConvertUtil.ToString(DataAccess.Instance("UltDB").ExecuteScalar(string.Format(
                   "select SUMMARY from  INCIDENTS where processname=N'{0}' and INCIDENT='{1}'", processname, incident)));
                //序列化Json
                if (!string.IsNullOrEmpty(summyary))
                {
                    try
                    {
                        var obj = JObject.Parse(summyary);
                        if (obj != null)
                        {
                            summyary = ConvertUtil.ToString(obj["documentNo"]);
                            if (!string.IsNullOrEmpty(ConvertUtil.ToString(obj["summary"])))
                            {
                                summyary = ConvertUtil.ToString(obj["documentNo"]) + " - " + ConvertUtil.ToString(obj["summary"]);
                            }
                        }
                    }
                    catch (Exception)
                    {

                    }
                }

                #endregion

                //判断数据源是我的申请页面还是其他页面
                int ID = SerialNoLogic.GetMaxNo("WF_READS", "ID");
                string sql1 = "";
                string READFLAG = "";
                string READERTYPE = "";
                #region 传阅保存到数据库
                if (ss.ISREADSTATUS == "1")
                {
                    READFLAG = "0";
                    READERTYPE = "0";
                    if (DatabaseUtil.IsOracle("BizDB"))
                    {

                        sql1 = @"INSERT INTO WF_READS (ID, TASKID, READFLAG, READER, PROCESSNAME, INCIDENT,CREATEDATE, APPLICANT, READERTYPE, 
                           STEPLABEL, STARTTIME,OPINION,readusername,SUMMARY,STATUS,APPLICANTNAME) 
                           VALUES(@ID, @TASKID, @READFLAG, @READER, @PROCESSNAME, @INCIDENT,@CREATEDATE, @APPLICANT, @READERTYPE, @STEPLABEL, @STARTTIME,
                           @OPINION,@readusername,@SUMMARY,@STATUS,@APPLICANTNAME)";
                        //Unread submitted from MyTask or MyRequest will come out in MyUnread page immediately, READFLAG = 0 : Unread.
                    }
                    else
                    {
                        sql1 = @"INSERT INTO WF_READS (ID, TASKID, READFLAG, READER, processname, INCIDENT, CREATEDATE , APPLICANT, READERTYPE, 
                            STEPLABEL, STARTTIME,OPINION,readusername,SUMMARY,STATUS,APPLICANTNAME) 
                            VALUES(@ID, @TASKID, @READFLAG, @READER, @PROCESSNAME, @INCIDENT,@CREATEDATE, @APPLICANT, @READERTYPE, @STEPLABEL, @STARTTIME,
                            @OPINION,@readusername,@SUMMARY,@STATUS,@APPLICANTNAME)";
                    }
                }
                else
                {
                    READFLAG = "2";
                    READERTYPE = "0";
                    if (DatabaseUtil.IsOracle("BizDB"))
                    {

                        sql1 = @"INSERT INTO WF_READS (ID, TASKID, READFLAG, READER, PROCESSNAME, INCIDENT, CREATEDATE, APPLICANT, READERTYPE, 
                            STEPLABEL, STARTTIME,OPINION,readusername,SUMMARY,STATUS,APPLICANTNAME) 
                            VALUES(@ID, @TASKID, @READFLAG, @READER, @PROCESSNAME, @INCIDENT,@CREATEDATE, @APPLICANT, @READERTYPE, @STEPLABEL, @STARTTIME,
                            @OPINION,@readusername,@SUMMARY,@STATUS,@APPLICANTNAME)";
                        //Unread submitted from other pages will come out in MyUnread page when the process is done, READFLAG = 2 : Unsolved.
                    }
                    else
                    {
                        sql1 = @"INSERT INTO WF_READS (ID, TASKID, READFLAG, READER, PROCESSNAME, INCIDENT, CREATEDATE, APPLICANT, READERTYPE, 
                            STEPLABEL, STARTTIME,OPINION,readusername,SUMMARY,STATUS,APPLICANTNAME) 
                            VALUES(@ID, @TASKID, @READFLAG, @READER, @PROCESSNAME, @INCIDENT,@CREATEDATE, @APPLICANT, @READERTYPE, @STEPLABEL, @STARTTIME,
                            @OPINION,@readusername,@SUMMARY,@STATUS,@APPLICANTNAME)";
                    }
                }
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql1, ID, taskid, READFLAG, readloginname, processname, incident, DateTime.Now, applicant, READERTYPE, stepname, DateTime.Now,
                    opinion, readusername, summyary, readstatus, applicantUserName);
                #endregion

                #region 拼接页面html代码
                StringBuilder sb = new StringBuilder();
                sb.Append("<tr> <td  class=\"td_no\" data-label=\"序号\">" +
                                         "<div class=\"index\">" +
                                             "<span></span>" +
                                               "</div></td>" +
                                     "<td class=\"td_guid\">" +
                                         "<div>" +
                                            " <span >" + readusername + "</span>" +
                                        "</div>" +
                                     "</td>" +
                                     "<td class=\"hidden-xs\">" +
                                         "<span >" + opinion + "</span>" +
                                    " </td>" +
                                     "<td class=\"text-center\">" +
                                     "<span >待阅</span>" +
                                    " </td>" +
                                     "<td class=\"text-center\">" +
                                         "<span >" + applicantUserName + "</span>" +
                                    " </td>" +
                                    " <td class=\"text-center\">" +
                                         "<span >" + ConvertUtil.ToShortDateTimeString(createDate) + "</span>" +
                                    " </td>" +
                                     "<td class=\"text-center\"> <span class=\"hidden\">" + ID + "</span>");
                sb.Append("<button  onclick=\"if(confirm('确认删除？')){CirculationUserInfo_DeleteRowClick(this)}return false;\" class=\"btn btn-icon btn-sm\">" +
                           " <i class=\"fa fa-trash\"></i>" +
                       " </button> </td> </tr>");
                #endregion

                return sb.ToString();
            }
            catch (Exception ex)
            {
                LogUtil.Error("添加传阅记录失败");
                throw new Exception(ex.Message);
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