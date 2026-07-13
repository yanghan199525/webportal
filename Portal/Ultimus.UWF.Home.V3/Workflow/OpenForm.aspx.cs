using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using System.Data;
using Ultimus.UWF.Home.V3.Logic;
using System.Security.Cryptography;
using System.Text;
using System.IO;

namespace Ultimus.UWF.Workflow
{
    public partial class OpenForm : System.Web.UI.Page
    {
        IWorkflow _portal = ServiceContainer.Instance().GetService<IWorkflow>();
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        ISession session = ServiceContainer.Instance().GetService<ISession>();

        static string encryptKey = "Oyea";
        protected void Page_Load(object sender, EventArgs e)
        {

            //验证单点登录
           SSO.CheckSSO(Request["zg_sso_token_temp"], "Default");

            string taskID = ConvertUtil.ToString(Request.QueryString["TaskID"]).Trim();
            string taskUser = Request.QueryString["TaskUser"];
            string type = ConvertUtil.ToString(Request.QueryString["Type"]);
            string processName = Request.QueryString["ProcessName"];
            int incident = ConvertUtil.ToInt32(Request.QueryString["Incident"]);
            string stepName = Request.QueryString["StepName"];
            string formId = Request.QueryString["FormID"];
            string serverName = Request.QueryString["ServerName"];
            string password = ConvertUtil.ToString(HttpContext.Current.Session["LoginPassword"]);
            string name = Request.QueryString["UserName"];
            string PW = Request.QueryString["Password"];
            string URLTYPE = Request.QueryString["URLTYPE"];
            string pcCode = Request.QueryString["pccode"];
            string prSource = Request.QueryString["prSource"];
            string userName = Request.QueryString["username"];
            string user = Request.QueryString["CREATEBY"];
            if (processName == "PO_AMENDMENT") {
                if (!string.IsNullOrEmpty(user))
                {
                    userName = user;
                }
               
            }
            if (!string.IsNullOrEmpty(name))
            {
                session.Login(Decrypt(name), Decrypt(PW));
                LogUtil.Info(typeof(Login), "Login,User:" + Decrypt(name) + ", IP:" + Request.UserHostAddress);
            }

            if (!string.IsNullOrEmpty(name))
            {
                //Email 打开需要验证登录人，第三方系统不需要验证
                if (Decrypt(URLTYPE) == "URL_Email")
                {
                    //若不是同一人则跳转登录页
                    if (Decrypt(name) != SessionLogic.GetLoginName())
                    {
                        HttpContext.Current.Response.Redirect(WebUtil.GetRootPath() + ConfigurationManager.AppSettings["LoginForm"]);
                    }
                }
                else
                {
                    //登录
                    session.Login(Decrypt(name), Decrypt(PW));
                }
                LogUtil.Info(typeof(Login), "Login,User:" + Decrypt(name) + ", IP:" + Request.UserHostAddress);
            }
            //2种情况可以打开页面：1.传正确的TaskId 2.非任务用户:必须传正确的FormID,processName,Incident
            //根据FormID打开
            if (!string.IsNullOrEmpty(formId))
            {
                taskID = _workflow.GetViewTaskID(serverName, processName, ConvertUtil.ToInt32(incident));
            }
            //taskID为空，那么根据流程名和实例号取taskID
            if (string.IsNullOrEmpty(taskID) && type.ToUpper().Trim() != "DRAFT")
            {
                if (ConvertUtil.ToInt32(incident) == 0)
                {
                    taskID = _workflow.GetTaskID(HttpContext.Current.Request.QueryString["ServerName"],
                     processName, ConvertUtil.ToInt32(incident), SessionLogic.GetLoginName());
                    if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["EmailLogin"]))
                    {
                        //判断流程名和实例号，是否本人有权限打开
                        _workflow.CheckTaskSecurity(HttpContext.Current.Request.QueryString["ServerName"],
                            processName, ConvertUtil.ToInt32(incident), SessionLogic.GetLoginName());
                    }
                }
                else
                {
                    throw new Exception("TaskID can not be null!");
                }
            }
            //草稿箱
            if (string.IsNullOrEmpty(taskID) && type.ToUpper().Trim() == "DRAFT")
            {
                taskID = _workflow.GetTaskID(HttpContext.Current.Request.QueryString["ServerName"],
                processName, ConvertUtil.ToInt32(incident), SessionLogic.GetLoginName());
            }

            string page = "";
            string url = "";
            string loginName = "";
            string PROCESSNAMES = ConvertUtil.ToString(DataAccess.Instance("UltDB").ExecuteScalar("SELECT PROCESSNAME FROM TASKS WHERE TASKID='" + taskID + "'")).Trim();
            if (PROCESSNAMES == "CPR_FOOD" || PROCESSNAMES == "CPR_NONFOOD" || PROCESSNAMES == "CPR_SERVICE"|| PROCESSNAMES == "HK_CPR_FOOD" || PROCESSNAMES == "HK_CPR_NONFOOD" || PROCESSNAMES == "HK_CPR_SERVICE"||processName=="PO_AMENDMENT"||processName=="OR_CPR_FOOD"||processName=="OR_CPR_NONFOOD")
            {
                if (userName != null)
                {
                    loginName = userName.Replace('/', '\\');
                    ISession session = ServiceContainer.Instance().GetService<ISession>();
                    session.Login(loginName, "");
                }
                else
                {
                    loginName = SessionLogic.GetLoginName();
                }
            }
            else
            {
                loginName = SessionLogic.GetLoginName();
            }
            switch (type.ToUpper().Trim())
            {
                case "DRAFT"://从草稿打开
                    IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
                    page = stepSettings.GetDraftPage(processName);
                    url = WebUtil.GetRootPath() + "/" + page + "?ProcessName=" + processName + "&StepName=" + stepName + "&Incident="
                       + incident + "&TaskID=" + taskID + "&UserName=" + HttpContext.Current.Server.UrlEncode(loginName) + "&Type=" + type;
                    break;

                case "MYUNREAD": //从待阅打开
                    string unreadSQL = "SELECT DISTINCT PROCESSNAME, INCIDENT FROM WF_READS WHERE TASKID = @p1";
                    DataTable unreadDT = DataAccess.Instance("BizDB").ExecuteDataTable(unreadSQL, taskID);
                    if (unreadDT.Rows.Count > 0 && !string.IsNullOrEmpty(unreadDT.Rows[0][0].ToString().Trim()))
                    {
                        processName = unreadDT.Rows[0][0].ToString().Trim();
                        incident = ConvertUtil.ToInt32(unreadDT.Rows[0][1].ToString().Trim());
                    }
                    url = _workflow.GetTaskUrl(serverName, taskID, type, loginName, password);
                    _workflow.CheckTaskSecurity(HttpContext.Current.Request.QueryString["ServerName"],
                       processName, ConvertUtil.ToInt32(incident), SessionLogic.GetLoginName());

                    if (string.IsNullOrEmpty(taskID))
                    {
                        throw new Exception("Current user have no rights to view it!");
                    }
                    if (string.IsNullOrEmpty(url))
                    {
                        //登录
                        string sessionid = _portal.LoginUser(loginName, password);
                        if (string.IsNullOrEmpty(sessionid))
                        {
                            throw new AppException("GetStandardFormUrl", "User Login failure:" + loginName);
                        }
                        //获取表单地址
                        url = _workflow.GetStandardFormUrl(serverName, loginName, taskID, sessionid);
                    }
                    page = url;
                    if (!url.StartsWith("http"))
                    {
                        url = WebUtil.GetRootPath() + "/" + url;
                    }
                    string setSQL = "update WF_READS set readflag = '1' where taskid = @p1  and READER=@p2";
                    DataAccess.Instance("BizDB").ExecuteNonQuery(setSQL, taskID, loginName);

                    break;
                case "MYREAD"://从已阅打开
                    string readSQL = "SELECT DISTINCT PROCESSNAME, INCIDENT FROM WF_READS WHERE TASKID = @p1";
                    DataTable readDT = DataAccess.Instance("BizDB").ExecuteDataTable(readSQL, taskID);
                    if (readDT.Rows.Count > 0 && !string.IsNullOrEmpty(readDT.Rows[0][0].ToString().Trim()))
                    {
                        processName = readDT.Rows[0][0].ToString().Trim();
                        incident = ConvertUtil.ToInt32(readDT.Rows[0][1].ToString().Trim());
                    }
                    url = _workflow.GetTaskUrl(serverName, taskID, processName, ConvertUtil.ToInt32(incident), type, loginName, password, false);
                    _workflow.CheckTaskSecurity(HttpContext.Current.Request.QueryString["ServerName"],
                       processName, ConvertUtil.ToInt32(incident), SessionLogic.GetLoginName());
                    if (string.IsNullOrEmpty(url))
                    {
                        //登录
                        string sessionid = _portal.LoginUser(loginName, password);
                        if (string.IsNullOrEmpty(sessionid))
                        {
                            throw new AppException("GetStandardFormUrl", "User Login failure:" + loginName);
                        }
                        //获取表单地址
                        url = _workflow.GetStandardFormUrl(serverName, loginName, taskID, sessionid);
                    }
                    page = url;
                    if (!url.StartsWith("http"))
                    {
                        url = WebUtil.GetRootPath() + "/" + url;
                    }
                    break;
                case "EMAIL": //从邮件打开
                case "ADDSIGN": //加签
                case "REPORT": //从报表打开
                default: //待办打开
                        //.net表单
                    url = _workflow.GetTaskUrl(serverName + ":" + processName + ":" + stepName + ":" + incident, taskID, type, loginName, password);

                    //标准表单
                    if (string.IsNullOrEmpty(url))
                    {
                        //登录
                        string sessionid = _portal.LoginUser(loginName, password);
                        if (string.IsNullOrEmpty(sessionid))
                        {
                            throw new AppException("GetStandardFormUrl", "User Login failure:" + loginName);
                        }
                            //获取表单地址
                            url = _workflow.GetStandardFormUrl(serverName, loginName, taskID, sessionid);
                    }
                    page = url;
                    if (!url.StartsWith("http"))
                    {
                        url = url.Replace("\\", "/");
                        if (url.StartsWith("/"))
                        {
                            url = WebUtil.GetRootPath() + url;

                        }
                        else
                        {
                            url = WebUtil.GetRootPath() + "/" + url;
                        }
                    }
                    break;
            }


            if (!string.IsNullOrEmpty(formId))
            {
                if (!string.IsNullOrEmpty(name))
                {
                    url += "&FORMID=" + formId + "&hasformid=0";
                }
                else
                {
                    url += "&FORMID=" + formId + "&hasformid=1";
                }
            }
            else
            {
                url += "&FORMID=" + Guid.NewGuid().ToString() + "&hasformid=0";
            }

            //记录并发用户数，统计时间为半小时
            if (ConfigurationManager.AppSettings["LogOpenForm"] == "1")
            {
                DBLogUtil.LogOpenForm();
            }
            if (string.IsNullOrEmpty(page))
            {
                throw new ApplicationException("未配置流程页面!");
            }
            else
            {
                if (!string.IsNullOrEmpty(pcCode))
                {
                    url += "&pccode=" + pcCode;
                }
                if (!string.IsNullOrEmpty(prSource))
                {
                    url += "&prSource=" + prSource;
                }
                Response.Redirect(url + "&t=" + Guid.NewGuid().ToString() + "&processStatus=" + Request.QueryString["processStatus"] + "&CprType=" + Request.QueryString["CprType"] + "&ArticleList=" + Request.QueryString["ArticleList"]);
            }
        }

        /// <summary>
        /// 加密方法
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string Encrypt(string str)
        {
            try
            {

                DESCryptoServiceProvider descsp = new DESCryptoServiceProvider();   //实例化加/解密类对象   

                byte[] key = Encoding.Unicode.GetBytes(encryptKey); //定义字节数组，用来存储密钥    

                byte[] data = Encoding.Unicode.GetBytes(str);//定义字节数组，用来存储要加密的字符串  

                MemoryStream MStream = new MemoryStream(); //实例化内存流对象      

                //使用内存流实例化加密流对象   
                CryptoStream CStream = new CryptoStream(MStream, descsp.CreateEncryptor(key, key), CryptoStreamMode.Write);

                CStream.Write(data, 0, data.Length);  //向加密流中写入数据      

                CStream.FlushFinalBlock();              //释放加密流      

                return Convert.ToBase64String(MStream.ToArray()).Replace("+", "%2B");//返回加密后的字符串  

            }
            catch (Exception)
            {

                throw;
            }
        }


        /// <summary>
        /// 解密方法
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string Decrypt(string str)
        {
            try
            {
                if (string.IsNullOrEmpty(str))
                {
                    return str;
                }
                else
                {
                    DESCryptoServiceProvider descsp = new DESCryptoServiceProvider();   //实例化加/解密类对象    

                    byte[] key = Encoding.Unicode.GetBytes(encryptKey); //定义字节数组，用来存储密钥    

                    byte[] data = Convert.FromBase64String(str);//定义字节数组，用来存储要解密的字符串  

                    MemoryStream MStream = new MemoryStream(); //实例化内存流对象      

                    //使用内存流实例化解密流对象       
                    CryptoStream CStream = new CryptoStream(MStream, descsp.CreateDecryptor(key, key), CryptoStreamMode.Write);

                    CStream.Write(data, 0, data.Length);      //向解密流中写入数据     

                    CStream.FlushFinalBlock();               //释放解密流      

                    return Encoding.Unicode.GetString(MStream.ToArray()).Replace("%2B", "+");       //返回解密后的字符串  
                }
            }
            catch (Exception)
            {

                return str;
            }

        }
    }
}