using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Security.Entity;
using Ultimus.UWF.Security.Interface;

namespace Ultimus.UWF.Home.V3
{
    /// <summary>
    /// DefaultHandler 的摘要说明
    /// </summary>
    public class DefaultHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request.Form["action"];
            switch (action)
            {
                case "HeaderList":
                    HeaderList(context);
                    break;
                case "changeLang":
                    ChangeLang(context);
                    break;
                default:
                    break;
            }
        }
        void HeaderList(HttpContext context) 
        {
            try
            {
                IMenu _menu = ServiceContainer.Instance().GetService<IMenu>();
                List<MenuEntity> _list;
                _list = _menu.GetMenuList(SessionLogic.GetLoginName());
                //string adminSite = ConfigurationManager.AppSettings["AdminSite"];
                //foreach(MenuEntity menu in _list)
                //{
                //    string url = ConvertUtil.ToString(menu.URL);
                //    if (url.IndexOf("{AdminSite}")>=0)
                //    {
                //        menu.URL = url.Replace("{AdminSite}", adminSite);
                //    }
                //}
               var jsonString = MyLib.SerializeUtil.JsonSerialize(_list);
                context.Response.Write(jsonString);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        void ChangeLang(HttpContext context)
        {
            try
            {
                string jsonString = "{}";
                string lang = context.Request.Form["lang"];
                string loginname = SessionLogic.GetLoginName();
                string domain = "";
                string name = "";
                domain = loginname.Split('\\')[0];
                name = loginname.Split('\\')[1];

                DataAccess.Instance("BizDB").ExecuteNonQuery
                    ("update org_user set language=@p1 where domain=@p2 and loginname=@p3",lang,
                    domain,name);
                HttpContext.Current.Session["UserLang"] = null;

                context.Response.Write(jsonString);
            }
            catch (Exception ex)
            {

                throw ex;
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