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
using UPL.Common.BussinessControl.Logic;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class MultiAttachments : System.Web.UI.UserControl
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
        protected Ultimus.UWF.Workflow.Entity.StepSetting StepInfo;
        public string __SINGLEHIDDEN = "hidden";
        public string __MULTIHIDDEN = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            userInfo.AfterLoadData += userInfo_AfterLoadData;
 string stepname = null;
            try
            {
                stepname = Request.QueryString["stepname"].ToString();
            }
            catch (Exception ex)
            { }
           // --------------
            if (string.IsNullOrEmpty(stepname))
            {
                TaskEntity entity = new TaskEntity();
                string taskID = Request.QueryString["taskID"];
                if (taskID.StartsWith("S"))
                {
                    if (DatabaseUtil.IsOracle("UltDB"))
                    {
                        entity = DataAccess.Instance("UltDB").ExecuteEntity<TaskEntity>
                           ("SELECT INITIATEID AS TASKID,PROCESSNAME,STEPLABEL,PROCESSVERSION FROM INITIATE WHERE trim(INITIATEID)=@INITIATEID", taskID);

                    }
                    else
                    {
                        entity = DataAccess.Instance("UltDB").ExecuteEntity<TaskEntity>
                            ("SELECT INITIATEID AS TASKID,PROCESSNAME,STEPLABEL,PROCESSVERSION FROM INITIATE WHERE INITIATEID=@INITIATEID", taskID);

                    }
                }
                stepname = entity.STEPLABEL;
            }
            //---PrintPreview bug  is fixed by david at 20181204
            IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
            StepInfo = stepSettings.GetStep(Request.QueryString["processname"], stepname);            if (!IsPostBack)
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
                            ReadOnly = true;
                        }
                    }
                    //this.actionRow.Visible = !ReadOnly;

                    TextBox lb_Applicant = userInfo.FindControl("fld_APPLICANT") as TextBox;
                    TextBox2.Text = lb_Applicant.Text;
                    if (getApproverStepIsUploadAtt() == "1")
                    {
                        ReadOnly = false;
                        this.actionRow.Visible = !ReadOnly;
                    }

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
                DataTable dt = logic.GetAttachmentsByFormID(userInfo.FormID, txtType.Text);

                Repeater1.DataSource = dt;
                Repeater1.DataBind();
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

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Download")
                {
                    try
                    {
                        string CommandArgument = ConvertUtil.ToString(e.CommandArgument);
                        string[] com = CommandArgument.Split('&');
                        string p = com[0];
                        string newname = com[1];
                        string fileType = com[2];
                        string createDate = com[3];

                        FTP ftp = new FTP();
                        string path = MyLib.ConfigurationManager.AppSettings["FTPAttachmentServerIP"];
                        string s = "\\Ultimus BPM\\" + ConvertUtil.ToDateTime(createDate).ToString("yyyy") + "\\" + ConvertUtil.ToDateTime(createDate).ToString("MM") + "\\" + ConvertUtil.ToDateTime(createDate).ToString("dd") + "\\" + p + "\\" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
                        string ftpPath = path + s;
                        ftp.Download(ftpPath);
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

        /// <summary>
        /// 附件删除操作
        /// 只能删除本人自己上传的附件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater1_ItemDataCommand(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemIndex != -1)
            {
                Label lbCreateByAccount = (Label)e.Item.FindControl("lbCreateByAccount");  //上传附件用户账号
                Label lbStepName = e.Item.FindControl("lbStepName") as Label;  //上传附件用户的步骤名
                LinkButton LinkButton1 = (LinkButton)e.Item.FindControl("LinkButton1");

                UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo; ;
                string stepName = userInfo.StepName;    //当前流程步骤名

                if (stepName.Trim() != lbStepName.Text.Trim())
                {
                    LinkButton1.Visible = false;   //隐藏删除按钮
                    LinkButton1.Attributes.Add("style", "display:none");
                }
                //albert 2014-7-28 add 由于保存草稿时，插入WF_ATTACHMENT表中UPLOADSTEPNAME的值为空，默认当前用户可以删除
                if (userInfo.StepName == "Start" || userInfo.StepName == "Begin")
                {
                    if (lbStepName.Text == "")
                    {
                        LinkButton1.Visible = true;
                    }
                }
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

        public string GetUrl(object processname, object newname, object fileType, object createDate)
        {
            string path = string.Empty;
            if (MyLib.ConfigurationManager.AppSettings["AttachmentOptions"] == "1")
                path = MyLib.ConfigurationManager.AppSettings["FTPAttachmentServerIP"];
            else
                path = MyLib.ConfigurationManager.AppSettings["AttachmentOpenPath"];

            string p = ConvertUtil.ToString(processname).TrimEnd();
            string s = ConvertUtil.ToDateTime(createDate).ToString("yyyy\\\\MM\\\\dd") + "\\" + p + "\\" + ConvertUtil.ToString(newname) + ConvertUtil.ToString(fileType);
            return DESEncrypt.Encrypt(HttpUtility.UrlEncode(path + s));
           
        }

        public string GetFileName(object FileName)
        {
            return DESEncrypt.Encrypt(HttpUtility.UrlEncode(ConvertUtil.ToString(FileName)));
        }

        public void btn_fresh_Click(object sender, EventArgs e)
        {
            BindAttachments();
        }

        /// <summary>
        /// 判断审批步骤是否可上传附件
        /// </summary>
        /// <returns></returns>
        public string getApproverStepIsUploadAtt()
        {
            string result = "";
            try
            {
                result = Convert.ToString(DataAccess.Instance("BizDB").ExecuteScalar(" SELECT EXT04 FROM WF_PROCESSSTEP WHERE PROCESSNAME=@PROCESSNAME AND STEPNAME=@STEPNAME ", Request.QueryString["processname"], Request.QueryString["stepname"]));
            }
            catch (Exception)
            {
            }
            return result;
        }
    }
}