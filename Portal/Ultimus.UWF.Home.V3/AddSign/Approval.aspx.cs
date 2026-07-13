using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data;
using Ultimus.UWF.AddSign;
using MyLib;

namespace Ultimus.UWF.AddSign
{
    public partial class Approval : System.Web.UI.Page
    {
        public string ProcessUrl;
        protected void Page_Load(object sender, EventArgs e)
        {
            ((ButtonList_AddSign)ButtonList1).BeforeSubmit += Approval_BeforeSubmit;
            ((ButtonList_AddSign)ButtonList1).AfterSubmit += Approval_AfterSubmit;
            ((UserInfo_AddSign)UserInfo1).AfterFormDataLoad += Approval_AfterFormDataLoad;

            
            if(!IsPostBack)
            {
                //ApprovalHistory AppHistory = Page.FindControl("ApprovalHistory1") as ApprovalHistory;
                //RadioButton rbApprove = AppHistory.FindControl("rbApprove") as RadioButton;
                //RadioButton rbReturn= AppHistory.FindControl("rbReturn") as RadioButton;
                //RadioButton rbAddSign= AppHistory.FindControl("rbAddSign") as RadioButton;
                //rbApprove.Checked = true;
                //rbReturn.Visible = false;
                //rbAddSign.Visible = false;
            }
        }
        private void Approval_AfterFormDataLoad(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!IsPostBack)
            {
                string taskId = read_PARENTTASKID.Text;// "0906149201bd30b8112492ef2f1b0a";
                if (!string.IsNullOrEmpty(taskId)) taskId = taskId.TrimEnd();
                string type = "ADDSIGN";
                string serverName = Request.QueryString["ServerName"];
                string incident = Request.QueryString["incident"];
                DataTable dt=DataAccess.Instance("BizDB").ExecuteDataTable
                    ("select parentformid,PARENTPROCESSNAME,PARENTINCIDENT from WF_ADDSIGN where incident=@incident",incident);
                string parentParentName = "";
                string parentIncident = "";
                string formid = "";
                if (dt.Rows.Count > 0)
                {
                    formid = ConvertUtil.ToString(dt.Rows[0][0]);
                    parentParentName = ConvertUtil.ToString(dt.Rows[0][1]);
                    parentIncident = ConvertUtil.ToString(dt.Rows[0][2]);
                }
                PIframe.Attributes.Add("onload", " this.style.height=Math.max(this.contentWindow.document.body.scrollHeight,this.contentWindow.document.documentElement.scrollHeight,200)+'px'; ");
                PIframe.Attributes.Add("src", 
                    "../Workflow/OpenForm.aspx?TaskId=" + taskId + 
                    "&Type=" + type + "&ServerName=" + serverName + "&Formid=" + formid + "&ProcessName=" + 
                    parentParentName + "&incident=" + parentIncident);


            }
        }
        private void Approval_BeforeSubmit(object sender, System.ComponentModel.CancelEventArgs e)
        {
             

             
        }

        private void Approval_AfterSubmit(object sender, System.ComponentModel.CancelEventArgs e)
        {
          
        
        }

        void initParent()
        {
            string taskId = "0906149201bd30b8112492ef2f1b0a";
            string type = "ADDSIGN";
            string serverName = Request.QueryString["ServerName"];
            //Response.Redirect("/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId=" + taskId + "&Type=" + type + "&ServerName="+serverName);

            PIframe.Attributes.Add("src","/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId=" + taskId + "&Type=" + type + "&ServerName="+serverName);
        }

    }
}