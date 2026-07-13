using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.IO; 
using MyLib; 
using Ultimus.UWF.Form.ProcessControl; 
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using System.Data;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class MultiAttachmentsOC : System.Web.UI.UserControl
    {

        /// <summary>
        /// 是否可以上传
        /// </summary>
        // private bool ReadOnly;
        public bool ReadOnly
        {
            get {
                if (txtReadonly.Text == "1")
                {
                    return true;
                }
                return false;
            }
            set
            {
                uploadrow.Visible = !value;
                if (value)
                {
                    txtReadonly.Text = "1";
                }
                else
                {
                    txtReadonly.Text = "0";
                }
            }
        }

        public bool Required
        {
            get
            {
                if (this.txtMust.Text == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            set
            {
                if (value)
                {
                    txtMust.Text = "1";
                }
                else
                {
                    txtMust.Text = "0";
                }
            }
        }

        public bool Single
        {
            get
            {
                if (this.txtSingle.Text == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            set
            {
                if (value)
                {
                    txtSingle.Text = "1";
                }
                else
                {
                    txtSingle.Text = "0";
                }
            }
        }


        private IAttachment logic = ServiceContainer.Instance().GetService<IAttachment>();
        public string __SINGLEHIDDEN = "hidden";
        public string __MULTIHIDDEN = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            userInfo.AfterLoadData += userInfo_AfterLoadData;
            if (!IsPostBack)
            {
                try
                {
                    string type = Request.QueryString["Type"];
                    if (!string.IsNullOrEmpty(type))
                    {
                        if (type.ToUpper() == "MYAPPROVAL" || type.ToUpper() == "MYREQUEST") //已完成，不显示上传按钮
                        {
                            this.actionRow.Visible = false;
                            this.uploadrow.Visible = false;
                        }
                    }
                    this.actionRow.Visible = !ReadOnly;

                    TextBox lb_Applicant = userInfo.FindControl("fld_APPLICANT") as TextBox;
                    TextBox2.Text = lb_Applicant.Text;
                    

                }
                catch (System.Exception ex)
                {
                    MyLib.LogUtil.Error(ex);
                    this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "message", "<script language='javascript' defer>alert('" + ex.Message.Replace("\n", " ").Replace("<br/>", " ").Replace("'", "") + "');</script>");
                }

            }

            if (Single)
            {
                __SINGLEHIDDEN = "";
                __MULTIHIDDEN = "hidden";
                uploadrow.Attributes.Add("class", "hidden");
            }
        }

        void userInfo_AfterLoadData(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            TextBox1.Text = userInfo.FormID;

            BindAttachments();


        }


        void BindAttachments()
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                string processName = userInfo.ProcessName;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                DataTable dt= logic.GetAttachmentsByFormID(userInfo.FormID, "supper");

                Repeater2.DataSource = dt;
                Repeater2.DataBind();
                if (dt.Rows.Count == 0)
                {
                    if (this.ReadOnly)
                    {
                        rowAtt.Visible = false;
                    }
                }
               // TextBox1.Text = userInfo.FormId;
            }
            catch (System.Exception ex)
            {
                MyLib.LogUtil.Error(ex);
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "message", "<script language='javascript' defer>alert('" + ex.Message.Replace("\n", " ").Replace("<br/>", " ").Replace("'", "") + "');</script>");
            }
        }

        protected void Repeater2_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Download")
                {
                    try
                    {
                        logic.Download(this.Page, e.CommandArgument.ToString());
                    }
                    catch (Exception ex)
                    {
                        LogUtil.Error(ex);
                    }
                }
                if (e.CommandName == "Delete")
                {
                    try
                    {
                        if (logic.DeleteAttachmentsByID(e.CommandArgument.ToString()))
                        {
                            BindAttachments();
                        }
                        else
                        {
                            throw new Exception("Delete Attachments Error.");
                        }
                    }
                    catch (Exception ex)
                    {
                        LogUtil.Error(ex);
                    }
                }
            }
            catch (System.Exception ex)
            {
                MyLib.LogUtil.Error(ex);
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "message", "<script language='javascript' defer>alert('" + ex.Message.Replace("\n", " ").Replace("<br/>", " ").Replace("'", "") + "');</script>");
            }
        }

        public void fresh()
        {
            BindAttachments();
        }

        public void getuserinfo(out string username, out string formid)
        {
            //IOrg _org = ServiceContainer.Instance().GetService<IOrg>();
            //UserEntity user = _org.GetCurrentUserEntity();
            //if (user != null)
            //{
            //    username = user.USERNAME;
            //}
            //else
            //{
                username = "";
            //}

            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            formid = userInfo.FormID;


             
        }

        public string GetUrl(object processname, object newname, object fileType,object createDate)
        {
            string path = MyLib.ConfigurationManager.AppSettings["AttachmentOpenPath"];
            string p = ConvertUtil.ToString(processname).TrimEnd();
            string s =  ConvertUtil.ToDateTime(createDate).ToString("yyyyMM")+"\\" +p + "\\" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
            return path + s;
        }

        public void btn_fresh_Click(object sender, EventArgs e)
        {
            BindAttachments();
        }
    }
}