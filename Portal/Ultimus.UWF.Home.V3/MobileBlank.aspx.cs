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
using Microsoft.IdentityModel.Claims;

namespace Ultimus.UWF.Home.V3
{
    public partial class MobileBlank : System.Web.UI.Page
    {

        public string Default_LogoutConfirm = "";
        public string User_FullName = "";
        IMenu _menu = ServiceContainer.Instance().GetService<IMenu>();
        //public string DEFAULT_Home = "MyTaskList.aspx";
        List<MenuEntity> _list;
        public string MYTASK_COUNT = "";
        public string READS_COUNT = "";
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        ISession _session = ServiceContainer.Instance().GetService<ISession>();
        IUserSettings usl = ServiceContainer.Instance().GetService<IUserSettings>();
        //public string HEIGTH = "180";

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
            //验证单点登录
            //SSO.CheckSSO(Request["zg_sso_token_temp"], "");

            //Default_LogoutConfirm = Lang.Get("Default_LogoutConfirm");
            //UserEntity loginUser = SessionLogic.GetLoginUserEntity();
            //User_FullName = loginUser.USERNAME;
            //if (string.IsNullOrEmpty(User_FullName))
            //{
            //    //throw new Exception("Get Login Name failure! Can not get login name or emp no from organization.");
            //    //throw new Exception(Lang.Get("Login_GetLoginfailure"));


            //}

            //_list = _menu.GetMenuList(SessionLogic.GetLoginName());
            ////保存有权限的菜单到Session
            //_session.SetSession("SecurityMenu", _list);

            //List<MenuEntity> toplist = _list.FindAll(p => (p.PARENTID.Trim() == "0" || p.MENUID == "08E0CB24-1A89-4CFB-84D8-1C037D0A7FDB") && p.MENUID != "21682D25-3F0E-4577-A28D-57920C076C80");
            //rptFirstMenu.DataSource = toplist;
            //rptFirstMenu.DataBind();
            //加载待办任务数量
            SqlFilterUtil filter = new SqlFilterUtil();
            filter.AddEqual("a.STATUS", 1);
            MYTASK_COUNT = _workflow.GetTaskCount(SessionLogic.GetLoginName(), filter.GetFilterList()).ToString();
            ////加载待阅任务数量
            //string sql = "SELECT Count(ID) FROM WF_READS  WHERE READFLAG = 0 and STATUS=1 AND READER = '" + loginUser.LOGINNAME.Replace("CustomOC\\", "CustomOC/").ToString() + "'";//READFLAG=0 => 待阅
            //READS_COUNT = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar(sql));
            ////加载收藏
            ////List<UserSettingsEntity> fav = usl.GetUserSettingsList(SessionLogic.GetLoginName(), "Favorite");
            ////foreach (UserSettingsEntity ety in fav)
            ////{
            ////    ety.EXT01 = ety.SETTINGTYPE.Replace("Favorite_", "");
            ////}
            ////rptFav.DataSource = fav;
            ////rptFav.DataBind();

            //if (ConfigurationManager.AppSettings["AllowWindowsAuth"] == "1")
            //{
            //    liLogout.Visible = false;
            //}

            ////if (WebUtil.IsMobileBrowser())
            ////{
            ////    HEIGTH = "260";
            ////}
            //string enableSSO = ConfigurationManager.AppSettings["EnableSSO"];
            //if (enableSSO == "1") { liLogout.Visible = false; }

            //string home = ConfigurationManager.AppSettings["DEFAULT_Home"];
            //if (!string.IsNullOrEmpty(home))
            //{
            //    DEFAULT_Home = home;
            //}
        }

        //protected void rptFirstMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        Repeater rpControl = (Repeater)e.Item.FindControl("rptSecondMenu");
        //        MenuEntity ety = (MenuEntity)e.Item.DataItem;
        //        List<MenuEntity> list = _list.FindAll(p => p.PARENTID.Trim() == ety.MENUID.Trim());
        //        //权限菜单扩展字段5如果为v3  表单跳转到2.0平台
        //        list = list.FindAll(delegate(MenuEntity me)
        //        {
        //            if (me.EXT05 == "V3")
        //            {
        //                if (me.EXT06 != "")
        //                {
        //                    if (me.EXT06.IndexOf("?") > -1)
        //                    {
        //                        me.URL = me.EXT06 + "&loginname=" + SessionLogic.GetAccount(SessionLogic.GetLoginName());
        //                    }
        //                    else
        //                    {
        //                        me.URL = me.EXT06 + "?loginname=" + SessionLogic.GetAccount(SessionLogic.GetLoginName());
        //                    }
        //                }
        //                else
        //                {
        //                    me.URL = me.URL + "&loginname=" + SessionLogic.GetAccount(SessionLogic.GetLoginName());
        //                }
        //            }
        //            return true;
        //        });
        //        rpControl.DataSource = list;
        //        rpControl.DataBind();
        //    }
        //}

        //protected void rptSecondMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        Repeater rpControl = (Repeater)e.Item.FindControl("rptThirdMenu");
        //        MenuEntity ety = (MenuEntity)e.Item.DataItem;
        //        List<MenuEntity> list = _list.FindAll(p => p.PARENTID.Trim() == ety.MENUID.Trim());
        //        //权限菜单扩展字段5如果为v3  表单跳转到2.0平台
        //        list = list.FindAll(delegate(MenuEntity me)
        //        {
        //            if (me.EXT05 == "V3")
        //            {
        //                if (me.EXT06 != "")
        //                {
        //                    if (me.EXT06.IndexOf("?") > -1)
        //                    {
        //                        me.URL = me.EXT06 + "&loginname=" + SessionLogic.GetAccount(SessionLogic.GetLoginName());
        //                    }
        //                    else
        //                    {
        //                        me.URL = me.EXT06 + "?loginname=" + SessionLogic.GetAccount(SessionLogic.GetLoginName());
        //                    }
        //                }
        //                else
        //                {
        //                    me.URL = me.URL + "&loginname=" + SessionLogic.GetAccount(SessionLogic.GetLoginName());
        //                }
        //            }
        //            return true;
        //        });
        //        Control arrow = e.Item.FindControl("spanArrow");
        //        if (list.Count > 0)
        //        {
        //            arrow.Visible = true;
        //        }
        //        else
        //        {
        //            arrow.Visible = false;
        //        }
        //        Control count = e.Item.FindControl("spanCount");
        //        if (ety.MENUID == "9E91C1EA-0321-4CD7-8704-359EFB2A9E1A") //待办任务
        //        {
        //            count.Visible = true;
        //        }
        //        else
        //        {
        //            count.Visible = false;
        //        }
        //        Control readsCount = e.Item.FindControl("readsCount");
        //        if (ety.DISPLAYNAME == "待阅任务") //待办任务
        //        {
        //            readsCount.Visible = true;
        //        }
        //        else
        //        {
        //            readsCount.Visible = false;
        //        }
        //        rpControl.DataSource = list;
        //        rpControl.DataBind();
        //    }
        //}

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
        public string GetUrl(object url, object ext01, object mappingName, object EXT05)
        {
            string str = "";
            if (!string.IsNullOrEmpty(ConvertUtil.ToString(ext01)))
            {
                str = ConvertUtil.ToString(ext01);
            }
            else
            {
                str = ConvertUtil.ToString(url);
            }
            if (ConvertUtil.ToString(mappingName).IndexOf('?') > 0)
            {
                return str = str + "&menuname=" + ConvertUtil.ToString(mappingName);
            }
            if (str.IndexOf("void(0)") >= 0)
            {
                return str;
            }
            if (EXT05.ToString() == "V3")
            {
                return str = str + "&menuname=" + ConvertUtil.ToString(mappingName);
            }
            else
            {
                return str = str + "?menuname=" + ConvertUtil.ToString(mappingName);
            }
        }
    }
}