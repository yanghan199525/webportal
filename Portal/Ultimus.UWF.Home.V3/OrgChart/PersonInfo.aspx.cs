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
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Interface;
using System.IO;
using System.Text;

namespace Ultimus.UWF.Home.V3
{
    public partial class PersonInfo : System.Web.UI.Page
    {
        IOrg _org = ServiceContainer.Instance().GetService<IOrg>();
        protected void Page_Load(object sender, EventArgs e)
        {
            IOrg org = ServiceContainer.Instance().GetService<IOrg>();
            if (!IsPostBack)
            {
                UserEntity user = SessionLogic.GetLoginUserEntity();
                lblAccount.Text = SessionLogic.GetLoginName();


                lblName.Text = user.USERNAME;

                lblDirectReport.Text = user.DIRECTREPORTNAME;

                JobEntity job = org.GetJobEntityByUserID(user.USERID);
                if (job != null)
                {
                    DepartmentEntity dept = org.GetDepartmentEntity(ConvertUtil.ToInt32(job.DEPARTMENTID));
                    if (dept != null)
                    {
                        lblDepartment.Text = dept.DEPARTMENTNAME;
                    }
                    lblTitle.Text = job.JOBFUNCTION;
                }
                txtEmail.Text = user.EMAIL;
                lblEmpNo.Text = user.EMPNO;
                txtTel.Text = user.TEL;

                IResource res = ServiceContainer.Instance().GetService<IResource>();
                List<ResourceEntity> list = res.GetResourceList("Language");
                ddlLanguage.Items.Clear();
                ddlLanguage.Items.Add("");
                foreach (ResourceEntity ety in list)
                {
                    ddlLanguage.Items.Add(new ListItem(ety.NAME, ety.VALUE));
                }

                UserEntity ue = SessionLogic.GetLoginUserEntity();
                if (ue != null)
                {
                    ddlLanguage.SelectedValue = ue.LANGUAGE;
                }

                btnSearch.Text = Lang.Get("Save");
                btnChangePassword.Text = Lang.Get("ChangePassword");

                string domain = lblAccount.Text.Split('\\')[0];
                //if (ConfigurationManager.AppSettings["AllowWindowsAuth"] != "1")
                //{
                //    //是否需要验证
                //    DataTable dt = _org.GetAuthType(domain);
                //    if (dt.Rows.Count > 0)
                //    {
                //        string auth = ConvertUtil.ToString(dt.Rows[0][0]);
                //        if (auth.IndexOf("Database") >= 0)
                //        {
                btnChangePassword.Visible = true;
                //        }
                //    }
                //}

                lblAccount.Text = lblAccount.Text.Replace(domain + "\\", "");

                Image1.ImageUrl = GetImageUrl();
            }
        }

        public bool isImage(string str)
        {
            bool isimage = false;
            string thestr = str.ToLower();
            string[] allowExtension = { ".jpg", ".gif", ".bmp", ".png" };
            for (int i = 0; i < allowExtension.Length; i++)
            {
                if (thestr == allowExtension[i])
                {
                    isimage = true;
                    break;
                }
            }
            return isimage;
        }

        protected void btnUploadFile_Click(object sender, EventArgs e)
        {
            if (!this.FileUpload.HasFile)
            {
                WebUtil.Alert(Page, "Please select photo！");
                return;
            }
            string fileExtension = Path.GetExtension(this.FileUpload.FileName).ToLower();
            if (!isImage(fileExtension))
            {
                WebUtil.Alert(Page, "Photo format is error！");
                return;
            }

            string loginname = SessionLogic.GetLoginName().Replace("CustomOC\\", "");
            string virpath = "/File/ProfileImg/";
            if (!Directory.Exists(Server.MapPath(virpath)))
            {
                Directory.CreateDirectory(Server.MapPath(virpath));
            }

            string[] sz = Directory.GetFiles(Server.MapPath(virpath), loginname + "*");
            foreach(string str in sz)
            {
                FileInfo file = new FileInfo(str);
                File.Delete(file.FullName);
            }

            string mappath = Server.MapPath(virpath + loginname+fileExtension);
            FileUpload.SaveAs(mappath);
            Image1.ImageUrl = virpath + loginname + fileExtension;
        }

        public string GetImageUrl()
        {
            string loginname = SessionLogic.GetLoginName().Replace("CustomOC\\", "");
            string virpath = Server.MapPath("/File/ProfileImg/");
            string[] sz= Directory.GetFiles(virpath, loginname + "*");
            if(sz.Length>0)
            {
                FileInfo file=new FileInfo( sz[0]);
                return "/File/ProfileImg/" + file.Name;
            }

            return "/common/assets/img/profileimg.jpg";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            bool flag = false;
            _org.SaveLanguage(SessionLogic.GetLoginName(), lblName.Text, ddlLanguage.SelectedValue);

            DataAccess.Instance("BizDB").ExecuteNonQuery
                ("update ORG_USER set tel=@tel where loginname=@loginname ", txtTel.Text, lblAccount.Text);

            flag = true;
            Session["LoginUser"] = null;
            Session["UserLang"] = null;

            if (flag)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert('" + Lang.Get("SaveSuccess") + "');parent.location.reload();", true);
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx?type=1");
        }

        /// <summary>
        /// 3.2V版本方法
        /// </summary>
        /// <param name="name"></param>
        /// <param name="language"></param>
        public void Loding(string name, string language)
        {
            string loginName = "CustomOC\\" + GetUserName(name);
            _org.SaveLanguage(loginName, name, language);
            Session["LoginUser"] = null;
            Session["UserLang"] = null;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "aa", "parent.location.reload();", true);
        }
        /// <summary>
        /// 解决首次加载多语言报错
        /// </summary>
        public string GetUserName(string name) {
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT LOGINNAME FROM ORG_USER WHERE CNName=N'" + name + "' ");
            DataTable db = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return db.Rows[0]["LOGINNAME"].ToString();
        }
    }
}