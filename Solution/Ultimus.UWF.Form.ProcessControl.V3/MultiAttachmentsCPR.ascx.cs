using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class MultiAttachmentsCPR : System.Web.UI.UserControl
    {
        /// <summary>
        /// 是否可以上传
        /// </summary>
        // private bool ReadOnly;
        public bool ReadOnly
        {
            get
            {
                if (txtReadonly.Text == "1")
                {
                    return true;
                }
                return false;
            }
            set
            {
                uploadrow_Supplier.Visible = !value;
                uploadrow_Approver.Visible = !value;
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
            //txtTypeSupplier.Text = "SUPPLIER";
            //txtTypeApprover.Text = "APPROVER";

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
                            this.actionRow_Supplier.Visible = false;
                            this.uploadrow_Supplier.Visible = false;
                            this.actionRow_Approver.Visible = false;
                            this.uploadrow_Approver.Visible = false;
                            getAttachsType();
                        }
                        else if (type.ToUpper() == "NEWREQUEST" || type.ToUpper() == "REPORT")
                        {
                            txtTypeSupplier.Text = "SUPPLIER";
                            txtTypeApprover.Text = "APPROVER";
                        }
                        else if (type.ToUpper() == "MYTASK")
                        {
                            txtTypeSupplier.Text = "";
                            txtTypeApprover.Text = "APPROVER";
                        }
                    }
                    this.actionRow_Supplier.Visible = !ReadOnly;
                    this.actionRow_Approver.Visible = !ReadOnly;

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
                uploadrow_Supplier.Attributes.Add("class", "hidden");
                uploadrow_Approver.Attributes.Add("class", "hidden");
            }

        }

        void userInfo_AfterLoadData(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            TextBox1.Text = userInfo.FormID;

            BindAttachments_Supplier();
            BindAttachments_Approver();


        }


        void BindAttachments_Supplier()
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                string processName = userInfo.ProcessName;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                DataTable dt = logic.GetAttachmentsByFormID(userInfo.FormID, txtTypeSupplier.Text);

                Repeater_Supplier.DataSource = dt;
                Repeater_Supplier.DataBind();
                if (dt.Rows.Count == 0)
                {
                    if (this.ReadOnly)
                    {
                        rowAtt_Supplier.Visible = false;
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

        void BindAttachments_Approver()
        {
            try
            {
                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
                string processName = userInfo.ProcessName;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                DataTable dt = logic.GetAttachmentsByFormID(userInfo.FormID, txtTypeApprover.Text);

                Repeater_Approver.DataSource = dt;
                Repeater_Approver.DataBind();
                if (dt.Rows.Count == 0)
                {
                    if (this.ReadOnly)
                    {
                        rowAtt_Approver.Visible = false;
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

        protected void Repeater_Supplier_ItemCommand(object source, RepeaterCommandEventArgs e)
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
                            BindAttachments_Supplier();
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

        protected void Repeater_Approver_ItemCommand(object source, RepeaterCommandEventArgs e)
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
                            BindAttachments_Approver();
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
            BindAttachments_Supplier();
            BindAttachments_Approver();
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

        public string GetUrl(object processname, object newname, object fileType, object createDate)
        {
            string path = MyLib.ConfigurationManager.AppSettings["AttachmentOpenPath"];
            string p = ConvertUtil.ToString(processname).TrimEnd();
            string s = ConvertUtil.ToDateTime(createDate).ToString("yyyyMM") + "\\" + p + "\\" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
            return path + s;
        }

        public void btn_fresh_Click(object sender, EventArgs e)
        {
            BindAttachments_Supplier();
        }

        public void getAttachsType()
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            string formid = userInfo.FormID;
            string incident = userInfo.Incident;
            StringBuilder sSql = new StringBuilder();
            if (incident == "0")
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"SELECT [TYPE] FROM WF_ATTACHMENT WHERE FORMID='{0}'", formid.Trim());
            }
            else
            {
                sSql.Length = 0;
                sSql.AppendFormat(@"SELECT [TYPE] FROM WF_ATTACHMENT ATTACHS,PROC_CPR_NONFOOD NONFOOD WHERE ATTACHS.FORMID=NONFOOD.FORMID AND NONFOOD.INCIDENT={0}", incident.Trim());
            }

            DataTable dt_type = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            if (dt_type.Rows.Count > 0)
            {
                foreach (DataRow item in dt_type.Rows)
                {
                    string type_ = item["TYPE"].ToString();
                    switch (type_)
                    {
                        case "SUPPLIER":
                            txtTypeSupplier.Text = "SUPPLIER";
                            break;
                        case "APPROVER":
                            txtTypeApprover.Text = "APPROVER";
                            break;
                        default:
                            txtTypeSupplier.Text = "SUPPLIER";
                            //txtTypeSupplier.Text = "";
                            txtTypeApprover.Text = "";
                            break;
                    }
                }
            }
        }
    }
}