using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Security.Interface;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Home.V3.Logic;

namespace Ultimus.UWF.Home.V3
{
    /// <summary>
    /// LoginHandler 的摘要说明
    /// </summary>
    public class LoginHandler : IHttpHandler, IRequiresSessionState
    {
        HttpRequest request;
        HttpResponse response;
        string StrJosn = "";
        int success = -1;
        string str = "";
        string loginAuthentication = "";
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            this.request = context.Request;
            this.response = context.Response;
            string Method = ConvertUtil.ToString(this.request.Form["Method"]);
            switch (Method)
            {
                case "BPMLogin":
                    try
                    {
                        string user = ConvertUtil.ToString(this.request.Form["UserName"]);
                        string domain = ConvertUtil.ToString(this.request.Form["Domain"]);
                        string Password = ConvertUtil.ToString(this.request.Form["Password"]);

                        if (string.IsNullOrEmpty(user))
                        {
                            throw new ArgumentNullException("user");
                        }

                        if (HttpContext.Current != null && HttpContext.Current.Session != null)
                        {
                            HttpContext.Current.Session["UserLang"] = null;
                        }

                        if (string.IsNullOrEmpty(domain))
                        {
                            domain = "CustomOC";
                        }
                        if (user.IndexOf("\\") < 0)
                        {
                            user = domain + "\\" + user;
                        }

                        int allowAuth = ConvertUtil.ToInt32(ConfigurationManager.AppSettings["ALLOWAUTH"]);
                        if (allowAuth == 1) //是否启用验证
                        {
                            IDomain domain1 = ServiceContainer.Instance().GetService<IDomain>();
                            //IAuthentication auth = ReflectUtil.GetType(domain1.GetAuthType(domain)) as IAuthentication;
                            IAuthentication auth = GetAuthType(domain);
                            if (!auth.CheckUser(user, Password))//验证不通过
                            {
                                success = 0;
                                StrJosn = MyLib.SerializeUtil.JsonSerialize(new { success = success, msg = "" + str + "" });
                            }
                            else
                            {
                                success = 1;
                                loginAuthentication = auth.ToString();
                            }
                        }
                        else
                        {
                            success = 1;

                        }

                        if (success == 1)
                        {
                            UserEntity userEntity;
                            userEntity = SessionLogic.GetUserEntity(user);
                            //判断用户信息是否存在
                            if (userEntity.USERID != 0)
                            {
                                //验证通过
                                LoginUser(user, Password, domain);
                                success = 1;

                                //判断如果是基于数据库密码验证，判断是否需要修改密码
                                if (loginAuthentication.ToString() == "Ultimus.UWF.Security.Impl.DatabaseAuthenticationImpl")
                                {
                                    if (userEntity != null && userEntity.CHANGEPASSWORD == "1") //如果需要修改密码，那么则修改密码
                                    {
                                        success = 2;
                                    }
                                }
                                StrJosn = MyLib.SerializeUtil.JsonSerialize(new { success = success, msg = "" + str + "" });
                            }
                            else
                            {
                                str = "用户名不存在";
                                success = 0;
                                StrJosn = MyLib.SerializeUtil.JsonSerialize(new { success = success, msg = "" + str + "" });
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LogUtil.Error("登录失败：" + ex.Message);
                        success = 0;
                        throw ex;
                        //StrJosn = MyLib.SerializeUtil.JsonSerialize(new { success = success, msg = "" + str + "" });
                    }
                    response.Write(StrJosn);
                    break;
                case "DingTalk_SSO":
                    try
                    {
                        //钉钉单点登录
                        string Appkey = ConfigurationManager.AppSettings["DingTalk_Appkey"].ToString();
                        if (!string.IsNullOrEmpty(Appkey))
                        {
                            string code = ConvertUtil.ToString(this.request.Form["code"]);
                            DingTalkLogic dingtalk = new DingTalkLogic();
                            string loginname = dingtalk.GetJobNumber(code);
                            if (loginname.IndexOf("\\") < 0)
                            {
                                loginname = "CustomOC" + "\\" + loginname;
                            }
                            UserEntity userEntity;
                            userEntity = SessionLogic.GetUserEntity(loginname);
                            //判断用户信息是否存在
                            if (userEntity.USERID != 0)
                            {
                                //验证通过
                                LoginUser(loginname, "", "CustomOC");
                                success = 1;
                            }
                            else
                            {
                                str = "用户名不存在";
                                success = 0;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        str = "登录失败：" + ex.Message;
                        LogUtil.Error(str);
                        success = 0;
                    }
                    StrJosn = MyLib.SerializeUtil.JsonSerialize(new { success = success, msg = "" + str + "" });
                    response.Write(StrJosn);
                    break;
                default:
                    break;
            }

        }

        public static IAuthentication GetAuthType(string domain)
        {
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT AUTHTYPE FROM ORG_DOMAIN WHERE DOMAINNAME like @DOMAINNAME+'%' AND ISACTIVE='1'", domain);
            if (dt.Rows.Count > 0)
            {
                string authType = ConvertUtil.ToString(dt.Rows[0]["AUTHTYPE"]);
                object obj = ReflectUtil.CreateInstance(Type.GetType(authType));
                if (obj is IAuthentication)
                {
                    return obj as IAuthentication;
                }
            }
            return null;
        }

        void LoginUser(string loginName, string password, string domain)
        {
            SessionLogic.CheckLicenseExpired();
            ISession session = ServiceContainer.Instance().GetService<ISession>();
            session.Login(loginName, password);
            LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + request.UserHostAddress);
            str = DESEncrypt.Encrypt(loginName + "&" + password); ;
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