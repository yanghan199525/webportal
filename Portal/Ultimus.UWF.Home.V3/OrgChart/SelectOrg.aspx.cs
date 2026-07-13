using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ultimus.UWF.OrgChart
{
    public partial class SelectOrg : System.Web.UI.Page
    {
        public        string __olddatas = "[";
        protected void Page_Load(object sender, EventArgs e)
        {
            string type =ConvertUtil.ToString( Request.QueryString["type"]).ToLower();
            string data = Request.QueryString["data"];
            data = data.Replace("|USER","").Replace("undefined", "");
            try
            {
                string[] sz = data.Split('|')[0].Split(';');
                List<string> usernames = new List<string>();
                List<string> userids = new List<string>();
                List<string> useraccounts = new List<string>();
                if (!string.IsNullOrEmpty(sz[0]))
                {
                    string[] ss = sz[0].Split(',');
                    foreach (string name in ss)
                    {
                        usernames.Add(name);
                    }

                    ss = sz[1].Split(',');
                    foreach (string name in ss)
                    {
                        userids.Add(name.Replace("|USER", ""));
                    }

                    ss = data.Split('|')[1].Split(',');
                    foreach (string name in ss)
                    {
                        if (!string.IsNullOrEmpty(name))
                        {
                            useraccounts.Add(name.Replace("CustomOC", "").Replace("\\", ""));
                        }
                    }

                    for (int i = 0; i < usernames.Count; i++)
                    {
                        string account = "";
                        if (useraccounts.Count > i)
                        {
                            account ="CustomOC\\"+ useraccounts[i];
                        }
                        string id = "0";
                        if (userids.Count > i)
                        {
                            id = userids[i];
                        }
                        if(ConvertUtil.ToInt32(id)==0)
                        {
                            id =ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar(
                                "select userid from v_org_user where loginname=@p1",account));
                        }
                        string olddata = "{\"USERNAME\":\"" + usernames[i] + "\",\"LOGINNAME\":\"" +
                            account+ "\",\"TYPE\":\"USER\",\"EXT30\":\"User\",\"USERID\":" + id
                            + ",\"uid\":\"" + id + "\"}";
                        if (i == 0)
                        {
                            __olddatas += olddata;
                        }
                        else
                        {
                            __olddatas += "," + olddata;

                        }
                    }
                    __olddatas += "]";
                }
                else
                {
                    __olddatas = "[]";
                }
                
            }
            catch(Exception ex)
            {
                LogUtil.Error(ex);
            }

            switch (type)
            {
                case "1":
                case "user":
                    ddlType.Items.RemoveAt(2);
                    ddlType.Items.RemoveAt(1);
                    txtType.Text = "user";
                    break;
                case "2":
                case "users":
                    ddlType.Items.RemoveAt(2);
                    ddlType.Items.RemoveAt(1);
                    txtType.Text = "users";
                    break;
                case "3":
                case "dept":
                    ddlType.Items.RemoveAt(2);
                    ddlType.Items.RemoveAt(0);
                    txtType.Text = "dept";
                    break;
                case "4":
                case "depts":
                    ddlType.Items.RemoveAt(2);
                    ddlType.Items.RemoveAt(0);
                    txtType.Text = "depts";
                    break;
                case "5":
                case "group":
                    ddlType.Items.RemoveAt(1);
                    ddlType.Items.RemoveAt(0);
                    ddlOrg.Items.RemoveAt(0);
                    txtType.Text = "group";
                    break;
            }
        }
    }
}