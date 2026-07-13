using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.OrgChart.Interface;
using MyLib;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Common.Logic;
using System.DirectoryServices;
using System.Data;

namespace Ultimus.UWF.Home.V3
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtLoginName.Text = Request.QueryString["LoginName"];
            if (string.IsNullOrEmpty(txtLoginName.Text))
            {
                txtLoginName.Text = SessionLogic.GetLoginName();

            }

            btnSearch.Text = Lang.Get("Save");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            bool flag = false;
            IOrg org = ServiceContainer.Instance().GetService<IOrg>();



            if (!string.IsNullOrEmpty(txtPwd.Text))
            {
                try
                {
                    if (txtPwd.Text != txtPwd2.Text)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + Lang.Get("ErrorPassword1") + "');", true);
                        return;
                    }
                    ReturnEntity rt = org.ChangePassword(txtLoginName.Text, txtOldPwd.Text, txtPwd.Text);
                    if (!rt.Success)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + rt.Message + "');", true);
                        return;
                    }
                    flag = true;
                }
                catch
                {
                    throw new Exception("Password or Directory Path config error!");
                }

            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + Lang.Get("ErrorPassword2") + "');", true);
                return;
            }


            if (flag)
            {
                if (Request.QueryString["type"] == "1")
                {
                    //首页上调整密码，需要跳转待办
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + Lang.Get("SucessPassword") + "'); window.location.href='../MyTaskListV3.aspx';", true);
                }
                else
                {
                    //首次登录，需要跳转首页
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + Lang.Get("SucessPassword") + "'); window.location.href='../../../';", true);
                }
            }
        }

    }
}