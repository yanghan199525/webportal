using System;
using System.Collections.Generic;
using System.Web;
using System.Linq;
using System.Web.UI;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Security.Interface;
using MyLib;
using System.Data;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Interface;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.IdentityModel;
using System.IdentityModel.Claims;
using System.Threading;
using System.DirectoryServices;
using Microsoft.IdentityModel.Claims;
using Ultimus.UWF.Home.V3.Workflow.Utils;
using MyLib.Json;
using MyLib.Json.Linq;
//using Sodexo.Foundation.Server.WCFContract;

namespace Ultimus.UWF.Home.V3
{
    public partial class Login : System.Web.UI.Page
    {
        ISession session = ServiceContainer.Instance().GetService<ISession>();
        static string encryptKey = "Oyea";
        string UserName = "";
        string passWord = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string name = Request.QueryString["UserName"];
            string PW = Request.QueryString["Password"];
            string URLTYPE = Request.QueryString["URLTYPE"];
            string type= Request.QueryString["type"];
            //引入验证码URL
            if (ConfigurationManager.AppSettings["AdLogin"] == "1")
            {
                ibtn_imgcheckingcode.ImageUrl = "ValidateNum.aspx";
            }
                
            //this.txtUser.Text = UserName;
            //this.txtPassword.Text= passWord;
            if (!string.IsNullOrEmpty(type) && type == "out")
            {
                //默认注销
                session.LogOut("");
                if (!IsPostBack) {
                    this.txtUser.Text = UserName;
                    this.txtPassword.Text = passWord;
                    HttpCookie loginCookie = new HttpCookie("FedAuth");
                    loginCookie.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(loginCookie);
                    Request.Cookies.Clear();
                    //Response.Redirect("Default.aspx");
                    var signOut = ConfigurationManager.AppSettings["FederationSignOut"];
                    Response.Redirect(signOut);
                }

                //if (Request.Cookies.Count > 0)
                //{
                //    foreach (string cookie in Request.Cookies.AllKeys)
                //    {
                //        HttpCookie Cookie = new HttpCookie(cookie);
                //        Cookie.Expires = DateTime.Now.AddDays(-1);
                //        Response.Cookies.Add(Cookie); ;
                //    }
                //}
             
            }
            else {

                Request.Cookies.Clear();

                var refer = HttpContext.Current.Request.UrlReferrer?.Host;
                if (refer == ConfigurationManager.AppSettings["FederationHost"])
                {
                    var ok = ADFSLogin();
                    if (!ok)
                    {
                        throw new Exception(Lang.Get("Login_GetLoginfailure"));
                    }
                }

                //btnSubmit.Text = Lang.Get("Login_Login");
                login_btnSubmit.Value = "登录中";

                string[] str = Request.QueryString.AllKeys;
                string strurl = "";
                foreach (var item in Request.QueryString.AllKeys)
                {
                    if (item != "ReturnUrl")
                    {
                        strurl += "&" + item + "=" + Request.QueryString[item];
                    }
                    else if (Request.QueryString["ReturnUrl"].Contains("OR_CPR"))
                    {
                        strurl = Request.QueryString["ReturnUrl"];
                        strurl += "&" + item + "=" + Request.QueryString[item];
                    }
                    else if (Request.QueryString["ReturnUrl"].Contains("JdOrderDraft") || Request.QueryString["ReturnUrl"].Contains("JdNewRequest"))
                    {
                        strurl = Request.QueryString["ReturnUrl"];
                        strurl += "&" + item + "=" + Request.QueryString[item];
                    }
                    else if (Request.QueryString["ReturnUrl"].Contains("PR_QUOTATION"))
                    {
                        strurl = Request.QueryString["ReturnUrl"];
                        strurl += "&" + item + "=" + Request.QueryString[item];
                    }
                    else
                    {
                        strurl = Request.QueryString["ReturnUrl"];
                        break;
                    }
                }
                if (Request.QueryString["ReturnUrl"] != null)
                {
                    hidReturnUrl.Value = strurl;
                }
                else
                {
                    hidReturnUrl.Value = Request.QueryString["ReturnUrl"];
                }


                if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(PW))
                {
                    if (session.Login(name, PW) != "")
                    {
                        Response.Redirect(strurl);

                    }
                }

                if (Decrypt(URLTYPE) == "URL_Email")
                {
                    string str1 = session.Login(Decrypt(name), Decrypt(PW));
                    if (!string.IsNullOrEmpty(str1))
                    {
                        //LogUtil.Info(typeof(Login), "Login,User:" + Decrypt(name) + ", IP:" + Request.UserHostAddress);
                        Response.Redirect(strurl);
                    }



                }


                string ssoUser = Request.QueryString["ssoUserName"];
                string ssoPassword = Request.QueryString["Password"];

                if (HttpContext.Current.Session["LoginName"] != null)
                    HttpContext.Current.Session["LoginName"] = null;


                if (!string.IsNullOrEmpty(ssoUser))
                {
                    //ssoUser = StringUtil.FromBase64String(ssoUser);
                    ssoPassword = StringUtil.FromBase64String(ssoPassword);
                    if (ssoPassword != ConfigurationManager.AppSettings["webservice.token"])
                    {
                        throw new Exception("error");
                    }
                    SessionLogic.CheckLicenseExpired();
                    session.Login(ssoUser, ssoPassword);

                    string stepname = Request.QueryString["stepname"];
                    string incident = Request.QueryString["incident"];
                    string url = hidReturnUrl.Value + "&stepname=" + stepname + "&incident=" + incident;
                    if (!string.IsNullOrEmpty(url))
                    {
                        Response.Redirect(url);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                    return;
                }

                IDomain domain = ServiceContainer.Instance().GetService<IDomain>();
                List<string> strs = domain.GetDomains();
                ddlDomains.DataSource = strs;
                ddlDomains.DataBind();
            }
            //FederationSignOut
            //Response.Redirect(ConfigurationManager.AppSettings["FederationSignOut"]);

        }
        //private WCFClientConfig _wcfClientSetting = null;
        ///// <summary>
        ///// WCF Client配置。
        ///// </summary>
        //public WCFClientConfig WCFClientSetting
        //{
        //    get
        //    {
        //        if (_wcfClientSetting == null)
        //        {
        //            _wcfClientSetting = new WCFClientConfig();
        //            _wcfClientSetting.ReaderWebConfig("");      //默认Foundation WCF Host配置

        //        }
        //        return _wcfClientSetting;
        //    }
        //}
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ConfigurationManager.AppSettings["AdLogin"] == "1")
            {
                //byte re = (byte)ADHelper.LoginByAccount(txtUser.Text, txtPassword.Text);
                //string responseMsg;
                //bool isValid = false;
                //using (ServiceManager<ILoginManager> loginManager = new ServiceManager<ILoginManager>(null, this.WCFClientSetting))
                //{
                //    isValid = loginManager.Service.BPMValidateUser(txtUser.Text, txtPassword.Text, out responseMsg);
                //    loginManager.Close();
                //}

                UserName = txtUser.Text;
                passWord = txtPassword.Text;
                //string txtCheckingcode = this.tbx_imgcheckingcode.Text.ToUpper().ToString();
                //string scode = Session["ValidateNum"].ToString().ToUpper();
                //if (scode.Trim() != txtCheckingcode.Trim())
                //{
                //    txtUser.Text = UserName;
                //    txtPassword.Text = passWord;
                //    this.CodeMsg.Text = "验证码输入不正确";
                //    this.tbx_imgcheckingcode.Text = "";
                //    return;
                //}
                //else {
                //    this.CodeMsg.Text = "";
                //}

                string SodexoWebApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["BS_WEB_API_URL"].ToString();
                string url = string.Format("{0}/api/services/app/bPMApiService/Login", SodexoWebApiUrl);
                url += "?txtLoginName=" + System.Web.HttpUtility.UrlEncode(EncryptDES(txtUser.Text))  + "&txtPassword=" + System.Web.HttpUtility.UrlEncode(EncryptDES(txtPassword.Text));
             
                string response = HttpUtil.HttpPost(url,"");
                AdLogin r =HttpUtil.FromJSON<AdLogin>(response);
                if (!r.result.isSuccess) {
                  
                    Response.Write("<script>alert('提交失败！失败原因:" + r.result.friendlyMsg + "'); </script>");
                    
                    return;
                }

                //switch (re)
                //{
                //    case 1:
                //        responseMsg = "用户不存在!";
                //        break;
                //    case 2:
                //        responseMsg = "该帐号在Active Directory中已被禁用!"; break;
                //    case 3:
                //        responseMsg = "用户态码不正确!"; break;
                //    default:
                //        responseMsg = "验证失败!"; break;
                //}
                //if (re!=0)
                //{
                //    Response.Write("<script>alert('提交失败！失败原因:" + responseMsg + "'); </script>");

                //    return;
                //}
               

            }

            if (HttpContext.Current != null && HttpContext.Current.Session != null)
            {
                HttpContext.Current.Session["UserLang"] = null;
            }
            string user = txtUser.Text;
            string domain = ddlDomains.SelectedValue;
            if (string.IsNullOrEmpty(domain))
            {
                domain = "CustomOC";
            }
            if (user.IndexOf("\\") < 0)
            {
                user = domain + "\\" + txtUser.Text;
            }

            int allowAuth = ConvertUtil.ToInt32(ConfigurationManager.AppSettings["ALLOWAUTH"]);
            if (allowAuth == 1) //是否启用验证
            {
                IDomain domain1 = ServiceContainer.Instance().GetService<IDomain>();
                //IAuthentication auth = ReflectUtil.GetType(domain1.GetAuthType(domain)) as IAuthentication;
                IAuthentication auth = GetAuthType(domain);
                if (!auth.CheckUser(user, txtPassword.Text))//验证不通过
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "ce", "checkError();", true);
                    return;
                }
            }

            //验证通过
            LoginUser(user, txtPassword.Text, domain);

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
            LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + Request.UserHostAddress);

            if (!string.IsNullOrEmpty(hidReturnUrl.Value))
            {
                Response.Redirect(hidReturnUrl.Value);
            }
            else
            {
                Response.Redirect("Default.aspx");
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
        /// DES加密
        /// </summary>
        /// <param name="encryptString">待加密的字符串，未加密成功返回原串</param>
        /// <returns></returns>
        public static string EncryptDES(string encryptString)
        {
            //DES加密秘钥，要求为8位
            string desKey = "sodexobs";
            //默认密钥向量
            byte[] Keys = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
            try
            {
                byte[] rgbKey = Encoding.UTF8.GetBytes(desKey);
                byte[] rgbIV = Keys;
                byte[] inputByteArray = Encoding.UTF8.GetBytes(encryptString);
                DESCryptoServiceProvider dCSP = new DESCryptoServiceProvider();
                MemoryStream mStream = new MemoryStream();
                CryptoStream cStream = new CryptoStream(mStream, dCSP.CreateEncryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
                cStream.Write(inputByteArray, 0, inputByteArray.Length);
                cStream.FlushFinalBlock();
                return Convert.ToBase64String(mStream.ToArray());
            }
            catch
            {
                return encryptString;
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


        private bool ADFSLogin()
        {
            try
            {
                IClaimsPrincipal claimsPrincipal = Page.User as IClaimsPrincipal;
                IClaimsIdentity claimsIdentity = (IClaimsIdentity)claimsPrincipal.Identity;
                if (claimsIdentity != null)
                {
                    var upn = claimsIdentity.Claims.FirstOrDefault(c => c.ClaimType == Microsoft.IdentityModel.Claims.ClaimTypes.NameIdentifier);
                    ADFSLoginUser(upn.Value.Split('@')[0]);
                    return true;
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
            }
            return false;
        }
        class AdLogin {
            public result result { get; set; }
        }
        class result
        {
           public bool isSuccess { get; set; }
           public string friendlyMsg { get; set; }
        }

        void ADFSLoginUser(string loginName)
        {
            var domain = ConfigurationManager.AppSettings["DefaultDomain"];
            if (string.IsNullOrEmpty(domain))
            {
                domain = "CustomOC";
            }

            SessionLogic.CheckLicenseExpired();

            ISession session = ServiceContainer.Instance().GetService<ISession>();

            session.LoginADFS(string.Concat(domain, "\\", loginName));

            LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + Request.UserHostAddress);
        }
      

    }
}