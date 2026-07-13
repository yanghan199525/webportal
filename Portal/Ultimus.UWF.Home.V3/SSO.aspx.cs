using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Home.V3.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class SSO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
                string code = txt_DingTalk_Code.Text;
                DingTalkLogic dingtalk = new DingTalkLogic();
                string loginname = ConvertUtil.ToString(dingtalk.GetJobNumber(code));
                if (loginname.IndexOf("\\") < 0)
                {
                    loginname = "CustomOC" + "\\" + loginname;
                }
                //验证通过
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.Login(loginname, "");
          

            //string home = ConfigurationManager.AppSettings["DefaultForm"];
            //if (!string.IsNullOrEmpty(home))
            //{
            //    Response.Redirect(home);
            //}
            //else
            //{
            //    Response.Redirect("~/Portal/Ultimus.UWF.Home.V3/Default.aspx");
            //}
        }
    }
}