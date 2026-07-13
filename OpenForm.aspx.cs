using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Security.Interface;
using MyLib;
using System.Data;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Interface;
using System.Collections.Generic;
using Ultimus.UWF.Workflow.Entity;
using System;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Form.ProcessControl.V3;
using System.Text;
using System.Security.Cryptography;

namespace UWF.Portal
{
    public partial class OpenForm : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        List<TaskEntity> _initProcessList = new List<TaskEntity>();
        string _userAccount = "";
        DataTable _process = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            #region 解密
            string decryptUrl = Request.Url.ToString();
            string decryptString = decryptUrl.Substring(decryptUrl.IndexOf('?') + 1);
            EncryptDESClass EncryptDESClass = new EncryptDESClass();
            string decryptLink = EncryptDESClass.DecryptDES(decryptString);
            //LoginName=kingson.wang&Pwd=FolPKe+iuEUAL6rR4aNLUg==&EMPNO=20120900005&pccode=CN001601&PRSource=Site&Lang=zh-CN&Proc=WA_Uniform&type=NEWREQUEST

            string loginName = string.Empty;
            string pwd = string.Empty;
            string empNo = string.Empty;
            string pcCode = string.Empty;
            string lang = string.Empty;
            string processName = string.Empty;
            string type = string.Empty;
            string taskid = string.Empty;
            string prSource = string.Empty;
            string CprType = string.Empty;
            string ArticleList = string.Empty;
            string DocumentNo = string.Empty;
            string sign = string.Empty;
            string timestamp = string.Empty;
            string login = string.Empty;
            string[] sArray = decryptLink.Split('&');
            for (int i = 0; i < sArray.Length; i++)
            {
                string[] vArray = sArray[i].Split('=');
                string name = vArray[0].ToUpper();
                string value = vArray[1];
                switch (name)
                {
                    case "LOGINNAME":
                        loginName = value;
                        break;
                    case "PWD":
                        pwd = value;
                        break;
                    case "EMPNO":
                        empNo = value;
                        break;
                    case "PCCODE":
                        pcCode = value;
                        break;
                    case "LANG":
                        lang = value;
                        break;
                    case "PROC":
                        processName = value;
                        break;
                    case "TYPE":
                        type = value;
                        break;
                    case "PRSOURCE":
                        prSource = value;
                        break;
                    case "CPRTYPE":
                        CprType = value;
                        break;
                    case "ARTICLELIST":
                        ArticleList = value;
                        break;
                    case "DOCUMENTNO":
                        DocumentNo = value;
                        break;
                    case "SIGN":
                        sign = value;
                        break;
                    case "TIMESTAMP":
                        timestamp = value;
                        break;
                    case "LOGIN":
                        login = value;
                        break;
                    default:
                        break;
                }
            }


            //string loginName = sArray[0].Substring(sArray[0].IndexOf('=') + 1);
            //string pwd = sArray[1].Substring(sArray[1].IndexOf('=') + 1);
            //string empNo = sArray[2].Substring(sArray[2].IndexOf('=') + 1);
            //string pcCode = sArray[3].Substring(sArray[3].IndexOf('=') + 1);
            //string lang = sArray[4].Substring(sArray[4].IndexOf('=') + 1);
            //string processName = sArray[5].Substring(sArray[5].IndexOf('=') + 1);
            //string type = sArray[6].Substring(sArray[6].IndexOf('=') + 1);  //NEWREQUEST
            //string taskid = string.Empty;
            #endregion

            #region 测试解密加密字符串
            //string decryptUrl = "http://localhost/OpenForm.aspx?8Xxb2tGUhNMP0LthWAAruwLkqDd9IH1PKt0PyKDNrtvZXJq/NJZ45K7U4jg0WoMDMmFUEU8axsjzCtoRNtEB2Nn+IQzn97GAqrn3oqsLrjbs1dUvL80taaKaMcM4ncLsBsFyMBiE4svQZ+5dLVmaemW5a8rXRGN4hnnoVfRA7wI=";
            //string decryptString = decryptUrl.Substring(decryptUrl.IndexOf('?') + 1);
            //EncryptDESClass EncryptDESClass = new EncryptDESClass();
            //string decryptLink = EncryptDESClass.DecryptDES(decryptString);
            ////string ceshiLink = "LoginName=kingson.wang&Pwd=Sodexo2018&EMPNO=20140200450&pccode=CN001601&Lang=zh-cn&Proc=CPR_FOOD&type=NEWREQUEST";
            //string[] sArray = decryptLink.Split('&');
            //string ceshi_loginName = sArray[0].Substring(sArray[0].IndexOf('=') + 1);
            //string ceshi_pwd = sArray[1].Substring(sArray[1].IndexOf('=') + 1);
            //string ceshi_empNo = sArray[2].Substring(sArray[2].IndexOf('=') + 1);
            //string ceshi_pcCode = sArray[3].Substring(sArray[3].IndexOf('=') + 1);
            //string ceshi_lang = sArray[4].Substring(sArray[4].IndexOf('=') + 1);
            //string ceshi_processName = sArray[5].Substring(sArray[5].IndexOf('=') + 1);
            //string ceshi_type = sArray[6].Substring(sArray[6].IndexOf('=') + 1);

            //string loginName = Request.QueryString["LoginName"];
            //string pwd = Request.QueryString["Pwd"];
            //string empNo = Request.QueryString["EMPNO"];
            //string pcCode = Request.QueryString["pccode"];
            //string lang = Request.QueryString["Lang"];
            //string processName = Request.QueryString["Proc"];
            //string type = Request.QueryString["type"];  //NEWREQUEST
            //string taskid = string.Empty;
            #endregion

            #region 接收不加密链接参数
            //string loginName = Request.QueryString["LoginName"];
            //string pwd = Request.QueryString["Pwd"];
            //string empNo = Request.QueryString["EMPNO"];
            //string pcCode = Request.QueryString["pccode"];
            //string lang = Request.QueryString["Lang"];
            //string processName = Request.QueryString["Proc"];
            //string type = Request.QueryString["type"];  //NEWREQUEST
            //string taskid = string.Empty;
            #endregion

            #region 工服限制条件
            if (processName == "WA_Uniform")
            {
                //设置登录人工号
                if (HttpContext.Current.Session != null)
                {
                    HttpContext.Current.Session["EmpNo"] = empNo;
                }

                string domain = "CustomOC";
                string ssoUser = domain + "\\" + loginName.ToLower();
                string ssoPassword = ConfigurationManager.AppSettings["AdminPwd"].ToString();

                SessionLogic.CheckLicenseExpired();
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                //session.Login(ssoUser, ssoPassword);

                //设置登录人
                if (HttpContext.Current.Session != null)
                {
                    HttpContext.Current.Session["LoginName"] = ssoUser;
                    HttpContext.Current.Session["LoginPassword"] = ssoPassword;
                }

                //登录人保存到Cookie
                if (ConfigurationManager.AppSettings["SaveLoginUserToCookie"] == "1")
                {
                    string str = StringUtil.ToBase64String(ssoUser + "&" + ssoPassword);
                    HttpCookie cookie = new HttpCookie("LoginName");
                    cookie.Value = str;
                    cookie.Expires = DateTime.Now.AddMonths(1);
                    HttpContext.Current.Response.Cookies.Add(cookie);
                }
                LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + Request.UserHostAddress);

                DataSet set = DataAccess.Instance("BizDB").ExecuteDataSet("select * from V_ORG_USER where EMPNO='" + empNo + "'");
                if (set.Tables[0].Rows.Count > 0)
                {
                    switch (lang.ToLower())
                    {
                        case "zh-cn":
                            lang = "zh-CN";
                            break;
                        case "en-us":
                            lang = "en-US";
                            break;
                        default:
                            lang = "zh-CN";
                            break;
                    }

                    DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("update ORG_USER set language='{0}' where empno='{1}'", lang, empNo));
                }


                if (type.ToUpper() == "NEWREQUEST")
                {
                    _process = DataAccess.Instance("BizDB").ExecuteDataTable("select a.PROCESSNAME,a.icon,b.DISPLAYNAME as CATEGORYNAME,b.CATEGORYNAME as CATEGORYENNAME,'' as SERVERNAME,isnull(a.orderno,9999) as OrderNo from WF_PROCESS a left join WF_Processcategory b on a.categoryid=b.categoryid where  isnull(a.UnEnbleStart,'0')=0 ");
                    //load init process
                    //_userAccount = SessionLogic.GetLoginName().Replace("\\", "/");
                    _userAccount = ssoUser.Replace("\\", "/");
                    _initProcessList = _workflow.GetInitTaskList(_userAccount, "", null, "", 0, 1000);
                    canStartProcesss();
                    _initProcessList.Sort();
                    foreach (TaskEntity entity in _initProcessList)
                    {
                        if (entity.PROCESSNAME == processName)
                        {
                            taskid = entity.TASKID;
                            break;
                        }
                    }

                    if (!string.IsNullOrEmpty(taskid))
                    {
                        string rootPath = getRootPath();
                        string url = string.Empty;
                        if (prSource != "")
                        {
                            url = string.Format("{4}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&pccode={3}&prSource={5}", taskid, type.ToUpper(), "", pcCode, rootPath, prSource);
                        }
                        else
                        {
                            url = string.Format("{4}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&pccode={3}", taskid, type.ToUpper(), "", pcCode, rootPath);
                        }
                        Response.Redirect(url);
                    }
                }
                else if (type.ToUpper() == "REPORTS")
                {
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("select NAMESPACE from FRM_DATASCHEMA where name='{0}'", processName));
                    if (dt.Rows.Count == 1)
                    {
                        string rootPath = getRootPath();

                        string url = string.Format("{0}/Solution/{1}/Report/ReportList.aspx?pccode={2}&empNo={3}&loginName={4}", rootPath, dt.Rows[0]["NAMESPACE"], pcCode, empNo, loginName);
                        Response.Redirect(url);
                    }
                }
                else if (type.ToUpper() == "MYTASK")
                {
                    taskid = Request.QueryString["TaskId"];

                    if (!string.IsNullOrEmpty(taskid))
                    {
                        DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(string.Format("SELECT STEPLABEL FROM TASKS WHERE TASKID='{0}'", taskid));
                        if (dt.Rows.Count == 1)
                        {
                            string stepname = dt.Rows[0]["STEPLABEL"].ToString().Trim();
                            string rootPath = getRootPath();
                            string url = string.Format("{4}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&ProcessName={3}", taskid, type.ToUpper(), "", processName, rootPath, stepname);
                            Response.Redirect(url);
                        }
                    }
                }
            }
            else
            {
                try
                {
                    if (login == "gates" && ConfigurationManager.AppSettings["AdLogin"].ToString() == "1")
                    {
                        Response.Write("<script>alert('系统和跳转系统登陆方式不同无法跳转，请联系管理员！');window.close();</script>");
                        return;
                    }
                    else if (login == "ad" && ConfigurationManager.AppSettings["AdLogin"].ToString() == "0") {
                        Response.Write("<script>alert('系统和跳转系统登陆方式不同无法跳转，请联系管理员！');window.close();</script>");
                        return;
                    }
                    if (!string.IsNullOrEmpty(sign)) {
                        if (!CheckToken(sign, timestamp)) {
                            Response.Write("<script>alert('token验证失败！');window.close();</script>");
                        };
                    }
                    #region 验证是否在组织架构中存在
                    if (!string.IsNullOrEmpty(empNo))
                    {
                        DataSet set = DataAccess.Instance("BizDB").ExecuteDataSet("select * from V_ORG_USER where EMPNO='" + empNo + "'");
                        if (set.Tables[0].Rows.Count > 0)
                        {
                            string domain = "CustomOC";
                            string ssoUser = domain + "\\" + loginName.ToLower();
                            string ssoPassword = ConfigurationManager.AppSettings["AdminPwd"].ToString();
                            //int allowAuth = ConvertUtil.ToInt32(ConfigurationManager.AppSettings["ALLOWAUTH"]);
                            //if (allowAuth == 1) //是否启用验证
                            //{
                            //    //IDomain domain1 = ServiceContainer.Instance().GetService<IDomain>();
                            //    //IAuthentication auth = ReflectUtil.GetType(domain1.GetAuthType(domain)) as IAuthentication;
                            //    //if (!auth.CheckUser(ssoUser, pwd))//验证不通过
                            //    //{
                            //    //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ce", "checkError();", true);
                            //    //    return;
                            //    //}

                            //    if (!new ADAuthentication().impersonateValidUser(txtUser.Text, txtPassword.Text))
                            //    {
                            //        Page.ClientScript.RegisterStartupScript(this.GetType(), "ce", "checkError();", true);
                            //        return;
                            //    }
                            //}
                            //UserInfo user = new UserInfo();
                            //user.ADFSLoginUser(loginName);
                            SessionLogic.CheckLicenseExpired();
                            //SessionLogic.Login(ssoUser, ssoPassword);
                            ISession session = ServiceContainer.Instance().GetService<ISession>();
                            session.Login(ssoUser, ssoPassword);

                            LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + Request.UserHostAddress);

                            switch (lang.ToLower())
                            {
                                case "zh-cn":
                                    lang = "zh-CN";
                                    break;
                                case "en-us":
                                    lang = "en-US";
                                    break;
                                default:
                                    lang = "zh-CN";
                                    break;
                            }

                            DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("update ORG_USER set language='{0}' where empno='{1}'", lang, empNo));

                            if (type.ToUpper() == "NEWREQUEST")
                            {
                                _process = DataAccess.Instance("BizDB").ExecuteDataTable("select a.PROCESSNAME,a.icon,b.DISPLAYNAME as CATEGORYNAME,b.CATEGORYNAME as CATEGORYENNAME,'' as SERVERNAME,isnull(a.orderno,9999) as OrderNo from WF_PROCESS a left join WF_Processcategory b on a.categoryid=b.categoryid where  isnull(a.UnEnbleStart,'0')=0 ");
                                //load init process
                                _userAccount = SessionLogic.GetLoginName().Replace("\\", "/");
                                _initProcessList = _workflow.GetInitTaskList(_userAccount, "", null, "", 0, 1000);
                                canStartProcesss();
                                _initProcessList.Sort();
                                foreach (TaskEntity entity in _initProcessList)
                                {
                                    if (entity.PROCESSNAME == processName)
                                    {
                                        taskid = entity.TASKID;
                                        break;
                                    }
                                }

                                if (!string.IsNullOrEmpty(taskid))
                                {
                                    string rootPath = getRootPath();
                                    string url = string.Empty;
                                    if (prSource != "")
                                    {
                                        url = string.Format("{4}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&pccode={3}&CprType={7}&prSource={5}&ArticleList={8}&lang={6}", taskid, type.ToUpper(), "", pcCode, rootPath, prSource, lang, CprType, ArticleList);
                                    }
                                    else
                                    {
                                        url = string.Format("{4}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&pccode={3}&CprTpe={5}&ArticleList={6}", taskid, type.ToUpper(), "", pcCode, rootPath, CprType, ArticleList);
                                    }
                                    Response.Redirect(url);
                                }
                            }
                            else if (type.ToUpper() == "REPORTS")
                            {
                                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("select NAMESPACE from FRM_DATASCHEMA where name='{0}'", processName));
                                if (dt.Rows.Count == 1)
                                {
                                    string rootPath = getRootPath();
                                    string url = "";
                                    if (dt.Rows[0]["NAMESPACE"].ToString() == "CPR_FOOD" || dt.Rows[0]["NAMESPACE"].ToString().ToUpper().Contains("PO_AMENDMENT"))
                                    {
                                        url = string.Format("{0}/Solution/{1}/Report/ReportListAll.aspx?pccode={2}&empNo={3}&loginName={4}", rootPath, dt.Rows[0]["NAMESPACE"], pcCode, empNo, loginName);
                                    }
                                    else if (dt.Rows[0]["NAMESPACE"].ToString().ToUpper().Contains("PR_QUOTATION"))
                                    {
                                        DataTable dr = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("select FORMID,INCIDENT from PROC_PR_QUOTATION where DOCUMENTNO='{0}'", DocumentNo));
                                        if (dr.Rows.Count > 0)
                                        {
                                            DataTable task = DataAccess.Instance("UltDB").ExecuteDataTable(string.Format("select TASKID, ASSIGNEDTOUSER, STEPLABEL from TASKS where incident = '{0}' and PROCESSNAME = 'PR_QUOTATION' and STEPLABEL = 'begin'", dr.Rows[0]["incident"]));
                                            if (task.Rows.Count > 0)
                                            {
                                                url = string.Format("{0}/Solution/{1}//FormV1/Approval.aspx?ProcessName=PR_QUOTATION&StepName=begin&Incident={2}&TaskID={3}&UserName={4}&Type=MYAPPROVAL&ServerName=&t={5}&FORMID={6}&&processStatus=&CprType=&ArticleList=", rootPath, dt.Rows[0]["NAMESPACE"].ToString().Trim(), dr.Rows[0]["incident"].ToString().Trim(), task.Rows[0]["TASKID"].ToString().Trim(), task.Rows[0]["ASSIGNEDTOUSER"].ToString().Trim(), Guid.NewGuid(), dr.Rows[0]["FORMID"].ToString().Trim());
                                            }
                                        }
                                    }
                                    else
                                    {
                                        url = string.Format("{0}/Solution/{1}/Report/ReportList.aspx?pccode={2}&empNo={3}&loginName={4}", rootPath, dt.Rows[0]["NAMESPACE"], pcCode, empNo, loginName);
                                    }
                                    Response.Redirect(url);
                                }
                            }
                            else if (type.ToUpper() == "MYTASK")
                            {
                                taskid = Request.QueryString["TaskId"];

                                if (!string.IsNullOrEmpty(taskid))
                                {
                                    DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(string.Format("SELECT STEPLABEL FROM TASKS WHERE TASKID='{0}'", taskid));
                                    if (dt.Rows.Count == 1)
                                    {
                                        string stepname = dt.Rows[0]["STEPLABEL"].ToString().Trim();
                                        string rootPath = getRootPath();
                                        string url = string.Format("{4}/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&ProcessName={3}", taskid, type.ToUpper(), "", processName, rootPath, stepname);
                                        Response.Redirect(url);
                                    }
                                }
                            }
                            else if (type.ToUpper() == "MYTASKLIST") {
                                string rootPath = getRootPath();
                                string url = string.Format("{0}/Portal/Ultimus.UWF.Home.V3/MyTaskListV3.aspx?PROCESSNAME=PO_AMENDMENT", rootPath,processName );
                                Response.Redirect(url);
                            }
                        }
                        else
                        {
                            //提示信息：此用户没有权限
                            Response.Write("<script>alert('此用户没有权限');window.close();</script>");
                        }
                    }
                    else
                    {
                        //提示信息：此用户没有权限
                        Response.Write("<script>alert('此用户没有权限(员工编号为空)');window.close();</script>");
                    }
                    #endregion
                }
                catch (Exception ex)
                {
                    throw new Exception(Lang.Get("Login_GetLoginfailure") + "（" + ex.Message + "）");
                }

            }
            #endregion

            #region 验证是否在组织架构中存在(已注释)
            //if (!string.IsNullOrEmpty(empNo))
            //{
            //    DataSet set = DataAccess.Instance("BizDB").ExecuteDataSet("select * from V_ORG_USER where EMPNO='" + empNo + "'");
            //    if (set.Tables[0].Rows.Count > 0)
            //    {
            //        string domain = "CustomOC";
            //        string ssoUser = domain + "\\" + loginName.ToLower();
            //        string ssoPassword = ConfigurationManager.AppSettings["AdminPwd"].ToString();
            //        //int allowAuth = ConvertUtil.ToInt32(ConfigurationManager.AppSettings["ALLOWAUTH"]);
            //        //if (allowAuth == 1) //是否启用验证
            //        //{
            //        //    //IDomain domain1 = ServiceContainer.Instance().GetService<IDomain>();
            //        //    //IAuthentication auth = ReflectUtil.GetType(domain1.GetAuthType(domain)) as IAuthentication;
            //        //    //if (!auth.CheckUser(ssoUser, pwd))//验证不通过
            //        //    //{
            //        //    //    Page.ClientScript.RegisterStartupScript(this.GetType(), "ce", "checkError();", true);
            //        //    //    return;
            //        //    //}

            //        //    if (!new ADAuthentication().impersonateValidUser(txtUser.Text, txtPassword.Text))
            //        //    {
            //        //        Page.ClientScript.RegisterStartupScript(this.GetType(), "ce", "checkError();", true);
            //        //        return;
            //        //    }
            //        //}

            //        SessionLogic.CheckLicenseExpired();
            //        //SessionLogic.Login(ssoUser, ssoPassword);
            //        ISession session = ServiceContainer.Instance().GetService<ISession>();
            //        session.Login(ssoUser, ssoPassword);
            //        LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + Request.UserHostAddress);

            //        switch (lang.ToLower())
            //        {
            //            case "zh-cn":
            //                lang = "zh-CN";
            //                break;
            //            case "en-us":
            //                lang = "en-US";
            //                break;
            //            default:
            //                lang = "zh-CN";
            //                break;
            //        }

            //        DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("update ORG_USER set language='{0}' where empno='{1}'", lang, empNo));

            //        if (type.ToUpper() == "NEWREQUEST")
            //        {
            //            _process = DataAccess.Instance("BizDB").ExecuteDataTable("select a.PROCESSNAME,a.icon,b.DISPLAYNAME as CATEGORYNAME,b.CATEGORYNAME as CATEGORYENNAME,'' as SERVERNAME,isnull(a.orderno,9999) as OrderNo from WF_PROCESS a left join WF_Processcategory b on a.categoryid=b.categoryid where  isnull(a.UnEnbleStart,'0')=0 ");
            //            //load init process
            //            _userAccount = SessionLogic.GetLoginName().Replace("\\", "/");
            //            _initProcessList = _workflow.GetInitTaskList(_userAccount, "", null, "", 0, 1000);
            //            canStartProcesss();
            //            _initProcessList.Sort();
            //            foreach (TaskEntity entity in _initProcessList)
            //            {
            //                if (entity.PROCESSNAME == processName)
            //                {
            //                    taskid = entity.TASKID;
            //                    break;
            //                }
            //            }

            //            if (!string.IsNullOrEmpty(taskid))
            //            {
            //                string rootPath = getRootPath();
            //                string url = string.Empty;
            //                if (prSource != "")
            //                {
            //                    url = string.Format("{4}/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&pccode={3}&prSource={5}", taskid, type.ToUpper(), "", pcCode, rootPath, prSource);
            //                }
            //                else
            //                {
            //                    url = string.Format("{4}/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&pccode={3}", taskid, type.ToUpper(), "", pcCode, rootPath);
            //                }
            //                Response.Redirect(url);
            //            }
            //        }
            //        else if (type.ToUpper() == "REPORTS")
            //        {
            //            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("select NAMESPACE from FRM_DATASCHEMA where name='{0}'", processName));
            //            if (dt.Rows.Count == 1)
            //            {
            //                string rootPath = getRootPath();

            //                string url = string.Format("{0}/Solution/{1}/Report/ReportList.aspx?pccode={2}", rootPath, dt.Rows[0]["NAMESPACE"], pcCode);
            //                Response.Redirect(url);
            //            }
            //        }
            //        else if (type.ToUpper() == "MYTASK")
            //        {
            //            taskid = Request.QueryString["TaskId"];

            //            if (!string.IsNullOrEmpty(taskid))
            //            {
            //                DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(string.Format("SELECT STEPLABEL FROM TASKS WHERE TASKID='{0}'", taskid));
            //                if (dt.Rows.Count == 1)
            //                {
            //                    string stepname = dt.Rows[0]["STEPLABEL"].ToString().Trim();
            //                    string rootPath = getRootPath();
            //                    string url = string.Format("{4}/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId={0}&Type={1}&ServerName={2}&ProcessName={3}", taskid, type.ToUpper(), "", processName, rootPath, stepname);
            //                    Response.Redirect(url);
            //                }
            //            }
            //        }
            //    }
            //    else
            //    {
            //        //提示信息：此用户没有权限
            //        Response.Write("<script>alert('此用户没有权限');window.close();</script>");
            //    }
            //}
            #endregion
        }


        void canStartProcesss()
        {
            List<TaskEntity> _nocanProcList = new List<TaskEntity>();
            foreach (TaskEntity te in _initProcessList)
            {
                DataRow[] drs = _process.Select("PROCESSNAME='" + te.PROCESSNAME + "'");
                if (drs == null || drs.Length == 0)
                {
                    _nocanProcList.Add(te);
                }
                else
                {
                    TaskEntity task = _initProcessList.Find(p => p.PROCESSNAME == te.PROCESSNAME);
                    if (task != null)
                    {
                        task.ORDERNO = ConvertUtil.ToInt32(drs[0]["OrderNo"]);
                    }
                }
            }
            foreach (TaskEntity te in _nocanProcList)
            {
                _initProcessList.Remove(te);
            }

        }
        /// <summary>
        /// token验证
        /// </summary>
        /// <param name="sign"></param>
        /// <param name="timestamp"></param>
        /// <returns></returns>
        public static bool CheckToken (string sign, string timestamp)
         {
            string userName = ConfigurationManager.AppSettings["userName"];
            string Pwd = ConfigurationManager.AppSettings["Pwd"];
            string method = ConfigurationManager.AppSettings["method"];
            string token = GetSHA256HashFromString(string.Format("SodexoApi{0}{1}{2}{3}", userName, Pwd, method,timestamp));
            return token == sign;

        }
     /// <summary>
     /// 
     /// </summary>
     /// <param name="data"></param>
     /// <returns></returns>
        public static string GetSHA256HashFromString(string data)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(data);
            byte[] hash = SHA256Managed.Create().ComputeHash(bytes);

            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                builder.Append(hash[i].ToString("X2"));
            }
            return builder.ToString().ToLower();
        }
        private string getRootPath()
        {
            string rootPath = string.Empty;
            string prex = "http";
            if (HttpContext.Current.Request.Url.Scheme == "https")
            {
                prex = "https";
            }
            else if (HttpContext.Current.Request.Url.Scheme == "http")
            {
                prex = "http";
            }
            if (HttpContext.Current.Request.Url.Port == 80)
            {
                rootPath = prex + "://" + HttpContext.Current.Request.Url.Host;
            }
            else
            {
                rootPath = prex + "://" + HttpContext.Current.Request.Url.Host + ":" +
                  HttpContext.Current.Request.Url.Port;
            }

            return rootPath;
        }
    }
}