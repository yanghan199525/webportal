using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Security.Entity;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Security.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Home.V3.Logic;
using System.IO;
using Microsoft.IdentityModel.Claims;

namespace Ultimus.UWF.Home.V3
{
    public partial class Default : System.Web.UI.Page
    {
        public string Default_LogoutConfirm = "";
        public string User_FullName = "";
        public string DefaultForm = "";
        public string closedsidebar = "";
        public string User_Lang = "CN";

        protected void Page_Load(object sender, EventArgs e)
        {

            var refer = HttpContext.Current.Request.UrlReferrer?.Host;
            if (refer == ConfigurationManager.AppSettings["FederationHost"])
            {
                var ok = ADFSLogin();
                if (!ok)
                {
                    throw new Exception(Lang.Get("Login_GetLoginfailure"));
                }
            }
            UserEntity loginUser = SessionLogic.GetLoginUserEntity();
            User_FullName = loginUser.USERNAME;
            Default_LogoutConfirm = Lang.Get("Default_LogoutConfirm");
            DefaultForm = MyLib.ConfigurationManager.AppSettings["DEFAULT_Home"];
            closedsidebar = MyLib.ConfigurationManager.AppSettings["DEFAULT_closedsidebar"];

            if (loginUser.LANGUAGE == "en-US")
            {
                User_Lang = "GB";
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
                    var upn = claimsIdentity.Claims.FirstOrDefault(c => c.ClaimType == ClaimTypes.NameIdentifier);
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

        /// <summary>
        /// ADFS认证成功后登录
        /// </summary>
        /// <param name="loginName">域登录账户，格式：CustomOC\\kingson.wang</param>
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