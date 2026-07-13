using DotNetCasClient;
using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie ticketCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (ticketCookie != null)
            {
                if (!string.IsNullOrEmpty(ticketCookie.Value))
                {
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(ticketCookie.Value);

                    if (CasAuthentication.ServiceTicketManager != null)
                    {
                        CasAuthenticationTicket casTicket = CasAuthentication.ServiceTicketManager.GetTicket(ticket.UserData);
                        /*nt Count = ConvertUtil.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(@"select top(1) 1 from org_User where loginname = '" + casTicket.Assertion.PrincipalName.Replace("CustomOC\\", "") + "'"));
*/
                        string logSQL = "select loginname from org_user where gid='" + casTicket.Assertion.PrincipalName.ToString().Trim() + "'";
                        DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(logSQL);
                        if (dt.Rows.Count > 0 && dt != null)
                        {
                            Login("CustomOC\\" + casTicket.Assertion.PrincipalName, "");
                            Response.Redirect("Default.aspx");
                        }
                    }
                }
            }
        }


        public static string Login(string loginName, string password)
        {
            //根据接口获取登录账号，因为区分账号大小写，所以必须再次获取
            UserEntity userEntity = GetUserEntity(loginName);
            loginName = userEntity.LOGINNAME;

            //设置登录人
            HttpContext.Current.Session["LoginName"] = loginName;
            HttpContext.Current.Session["LoginPassword"] = password;

            if (ConfigurationManager.AppSettings["SaveLoginUserToCookie"] == "1")
            {
                string str = StringUtil.ToBase64String(loginName + "&" + password);
                HttpCookie cookie = new HttpCookie("LoginName");
                cookie.Value = str;
                cookie.Expires = DateTime.Now.AddMonths(1);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
            return loginName;
        }

        public static UserEntity GetUserEntity(string loginName)
        {

            string domain = GetDomain(loginName);
            IOrg org = GetOrgType(domain);
            string orgName = GetOrgName(domain);
            UserEntity userEntity = org.GetUserEntity(loginName);

            if (userEntity == null || userEntity.USERID == 0)
            {
                userEntity = new UserEntity();
                if (string.IsNullOrEmpty(loginName))
                {
                    userEntity.EXT30 = "获取登陆名失败！";
                }
                else
                {
                    userEntity.LOGINNAME = loginName;
                    userEntity.EXT30 = string.Format("您[{0}]当前无权限访问该系统,请联系管理员!", loginName);
                }
            }
            List<DepartmentEntity> depts = org.GetUserDepartments(loginName);
            if (depts.Count > 0)
            {
                userEntity.DEPARTMENT = depts[0].DEPARTMENTNAME;
                userEntity.DEPARTMENTID = depts[0].DEPARTMENTID;
            }
            string langName;
            langName = userEntity.LANGUAGE;
            if (string.IsNullOrEmpty(langName))
            {
                langName = ConfigurationManager.AppSettings["Language"];
            }
            if (string.IsNullOrEmpty(langName))
            {
                langName = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            }
            userEntity.LANGUAGE = langName;
            HttpContext.Current.Session["LoginUser"] = userEntity;
            return userEntity;
        }

        public static string GetDomain(string loginName)
        {
            loginName = loginName.Replace("/", "\\");
            return loginName.Split('\\')[0];
        }

        public static IOrg GetOrgType(string domain)
        {
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT ORGTYPE FROM ORG_DOMAIN WHERE DOMAINNAME like @DOMAINNAME+'%' AND ISACTIVE='1'", domain);
            if (dt.Rows.Count > 0)
            {
                string type = ConvertUtil.ToString(dt.Rows[0]["ORGTYPE"]);
                object obj = ReflectUtil.CreateInstance(Type.GetType(type));
                if (obj is IOrg)
                {
                    return obj as IOrg;
                }
            }
            throw new AppException("GetOrgType", "Can not found the domain:{0} in domain list.", domain);
        }

        public static string GetOrgName(string domain)
        {
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable("SELECT ORGANIZATION FROM ORG_DOMAIN WHERE DOMAINNAME like @DOMAINNAME+'%' AND ISACTIVE='1'", domain);
            if (dt.Rows.Count > 0)
            {
                string type = ConvertUtil.ToString(dt.Rows[0]["ORGANIZATION"]);
                return type;
            }
            return "";
        }
    }
}