using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class CirculationUserInfo : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            userInfo.AfterLoadData += userInfo_AfterLoadData;
        }
        void userInfo_AfterLoadData(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            int incident = ConvertUtil.ToInt32(userInfo.Incident);
            if (incident <= 0)
            {
                this.Visible = false;
            }
        }

    }
}