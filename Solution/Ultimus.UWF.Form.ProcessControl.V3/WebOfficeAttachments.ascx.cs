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
    public partial class WebOfficeAttachments : System.Web.UI.UserControl
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

        public string UnDeleteStep
        {
            get
            {
                return txtUnDeleteStep.Text;
            }
            set
            {
                txtUnDeleteStep.Text = value;
            }
        }
        public string UnLookStep
        {
            get
            {
                return txtUnLookStep.Text;
            }
            set
            {
                txtUnLookStep.Text = value;
            }

        }

        public string UnAlterStep
        {
            get
            {
                return txtUnAlterStep.Text;
            }
            set
            {
                txtUnAlterStep.Text = value;
            }

        }

        public string UnDelete
        {
            get
            {
                return txtUnDelete.Text;
            }
            set
            {
                txtUnDelete.Text = value;
            }
        }
        public string UnLook
        {
            get
            {
                return txtUnLook.Text;
            }
            set
            {
                txtUnLook.Text = value;
            }

        }

        public bool UnAlter
        {            
            get
            {
                if (txtUnAlter.Text == "1")
                {
                    return true;
                }
                return false;
            }
            set
            {               
                if (value)
                {
                    txtUnAlter.Text = "1";
                }
                else
                {
                    txtUnAlter.Text = "0";
                }
            }
        }
        public string AStatus
        {
            get
            {
                return this.txtStatus.Text;
            }
            set
            {
                txtStatus.Text = value;
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
                stepname = ConvertUtil.ToString(Request.QueryString["stepname"]);
            }
            catch (Exception ex)
            { }
            // --------------
            if (string.IsNullOrEmpty(stepname))
            {
                TaskEntity entity = new TaskEntity();
                string taskID = Request.QueryString["taskID"];
                if (!string.IsNullOrEmpty(stepname)&&taskID.StartsWith("S"))
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
                    stepname = entity.STEPLABEL;
                }                
            }
            //---PrintPreview bug  is fixed by david at 20181204
            IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
            StepInfo = stepSettings.GetStep(Request.QueryString["processname"], stepname);
            if (!IsPostBack)
            {
                try
                {
                    CheckDisplayDiv(StepInfo);
                    string type = Request.QueryString["Type"];
                    if (!string.IsNullOrEmpty(type))
                    {
                        CheckDisplayDiv(StepInfo, type);
                    }
                    //this.actionRow.Visible = !ReadOnly;
                    //TextBox lb_Applicant = userInfo.FindControl("fld_APPLICANT") as TextBox;
                    //TextBox2.Text = lb_Applicant.Text;

                    //if (StepInfo.Ext04  == "1")//
                    //{
                    //    ReadOnly = false;
                    //    this.actionRow.Visible = !ReadOnly;
                    //}

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
                DataTable dt = new DataTable();
                if (AStatus == "2")
                {
                    dt = logic.GetAttachmentsByFormID(userInfo.FormID, txtType.Text);
                }
                else
                {
                    dt = logic.GetAttachmentsByFormID(userInfo.FormID, txtType.Text, "1");
                }
                string StepName = userInfo.StepName;
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    string StepNamePage = ConvertUtil.ToString(dt.Rows[i]["STEPNAME"]);
                    if (!string.IsNullOrEmpty(UnLookStep) && StepNamePage != StepName && UnLookStep.Contains(StepNamePage))
                    {
                        dt.Rows.RemoveAt(i);
                    }
                }
                LogUtil.Info("-----" + userInfo.FormID +"---------"+ dt.Rows.Count);
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
                foreach (RepeaterItem item in Repeater1.Items)
                {
                    string StepNamePage = (item.FindControl("lbStepName") as Label).Text;
                    string Status = (item.FindControl("lbStatus") as Label).Text;
                    string NEWNAME = (item.FindControl("NEWNAME") as Label).Text;                   
                    string FileName = (item.FindControl("lbFileName") as Label).Text;
                    string FileType = (item.FindControl("lbFileType") as Label).Text;
                    
                    HtmlTableCell td = item.FindControl("Td1") as HtmlTableCell;                   
                    HtmlGenericControl divOptionDelete = item.FindControl("divOptionDelete") as HtmlGenericControl;
                    HtmlGenericControl divOptionAlter = item.FindControl("divOptionAlter") as HtmlGenericControl;
                    HtmlGenericControl divOptionAlterLog = item.FindControl("divOptionAlterLog") as HtmlGenericControl;
                    //string ftpPath = GetUrl(processName, NEWNAME, FileType, CreateDate);
                    //divOptionDelete.Attributes.Add("onclick", "deleteRowClick('" + NEWNAME + "', this,'" + ftpPath + "')");
                    //divOptionAlter.Attributes.Add("onclick", "openIWebOffice(this,'" + FileName + "','" + ftpPath + "')");
                    //divOptionAlterLog.Attributes.Add("onclick", "showChangerLog(this,'" + FileName + "', '" + ftpPath + "')");  

                    if (this.ReadOnly)
                    {
                        divOptionDelete.Visible = false;
                        divOptionAlter.Visible = false;
                        divOptionAlterLog.Visible = true;
                        //td.InnerText = "";
                    }                                       
                    if (Status == "1")
                    {
                        divOptionDelete.Visible = false;
                    }
                    else
                    {                       
                        divOptionDelete.Visible = true;                        
                    }
                    string type = Request.QueryString["TYPE"];
                    if (FileType == ".doc" || FileType == ".docx")
                    {
                        divOptionAlter.Visible = true;
                        divOptionAlterLog.Visible = true;
                        this.actionRow.Visible = true;
                        if (!string.IsNullOrEmpty(type) && type.ToUpper() == "EDIT")
                        {
                            divOptionAlter.Visible = false;
                        }
                    }
                    else
                    {
                        divOptionAlter.Visible = false;
                        divOptionAlterLog.Visible = false;
                    }
                  
                    if (this.UnAlter)
                    {
                        divOptionDelete.Visible = false;
                        divOptionAlter.Visible = false;
                        continue;
                        //td.InnerText = "";
                    }                   
                    if (!string.IsNullOrEmpty(type)&&type.ToUpper()== "EDIT")
                    {
                        this.actionRow.Visible = true;
                        this.uploadrow.Visible = true;
                        ReadOnly = false;
                        continue;
                    }
                        //add Burt 2017-09-13
                    if (!string.IsNullOrEmpty(UnLookStep) && StepNamePage != StepName && UnLookStep.Contains(StepNamePage))
                    {
                        td.Parent.Visible = false;
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(UnDeleteStep) && StepNamePage != StepName && UnDeleteStep.Contains(StepNamePage))
                        {
                            //td.InnerText = "";
                            divOptionDelete.Visible = false;
                        }
                        if (!string.IsNullOrEmpty(UnAlterStep) && StepNamePage != StepName && UnAlterStep.Contains(StepNamePage))
                        {
                            //td.InnerText = "";
                            divOptionAlter.Visible = false;
                        }
                    }                    
                }
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
                        //if (logic.DeleteAttachmentsByID(e.CommandArgument.ToString()))
                        if (logic.UpdateAttachmentsByID(e.CommandArgument.ToString(),"-1"))
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

                TextBox txt_comments = (TextBox)e.Item.FindControl("txt_comments");
                Label STATUS = (Label)e.Item.FindControl("lbStatus");

                txt_comments.Attributes.Remove("CssClass");
                if (STATUS.Text == "1")
                {
                    txt_comments.Attributes.Add("CssClass", "form-control readonlycss");
                    txt_comments.ReadOnly = true;
                }
                else
                {
                    txt_comments.Attributes.Add("CssClass", "form-control");
                }

                //if (stepName.Trim() != lbStepName.Text.Trim())
                //{
                //    LinkButton1.Visible = false;   //隐藏删除按钮
                //    LinkButton1.Attributes.Add("style", "display:none");
                //}


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
        void CheckDisplayDiv(StepSetting ss)
        {
            if (ss.Ext04 == "0" || string.IsNullOrEmpty(ss.Ext04))//审批步骤是否可上传附件
            {
                ReadOnly = true;
                this.actionRow.Visible = false;
            }
            else
            {
                ReadOnly = false;
                this.actionRow.Visible = true;                
            }
        }
        void CheckDisplayDiv(StepSetting ss,string type)
        {
            bool IsStart = ss.StepType == "2";
            bool isStartByReturn = IsStart && type.ToUpper().Trim() == "MYTASK" && ConvertUtil.ToInt32(Request.QueryString["incident"]) > 0;

            switch (type.ToUpper().Trim())
            {
                case "NEWREQUEST":
                case "DRAFT":                    
                    break;
                case "MYTASK":                    

                    if (isStartByReturn)
                    {
                        
                    }
                    break;
                case "MYREQUEST":
                    this.actionRow.Visible = false;
                    this.uploadrow.Visible = false;
                    ReadOnly = true;
                    break;
                case "MYAPPROVAL":
                    this.actionRow.Visible = false;
                    this.uploadrow.Visible = false;
                    ReadOnly = true;
                    break;
                case "ADDSIGN":
                    this.actionRow.Visible = false;
                    this.uploadrow.Visible = false;
                    ReadOnly = true;
                    break;
                case "MYUNREAD":
                   
                    break;
                case "MYREAD":
                 
                    break;
                case "EDIT":
                    this.actionRow.Visible = true;
                    this.uploadrow.Visible = true;
                    ReadOnly = false;
                    break;
                    
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

       
    }
}