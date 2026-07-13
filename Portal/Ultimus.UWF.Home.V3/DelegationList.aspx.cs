using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Ultimus.UWF.Common.Logic;
using MyLib;
using System.Data;
using System.Web.UI.HtmlControls;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class DelegationList : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public string EnableProcessAssign = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Button1.Text = Lang.Get("btn_Search");
            Button3.Text = Lang.Get("btn_Reset");
            Button4.Text = Lang.Get("Cancel_Delegation");
            Button5.Text = Lang.Get("Assign_BackButton");
            if (!IsPostBack)
            {
                //BindProcess();
                BindList();
            }

            if (ConfigurationManager.AppSettings["EnableProcessAssign"] == "0")
            {
                EnableProcessAssign = "hidden";
            }
        }

        private void BindProcess()
        {
            dropProcessName.DataSource = _workflow.GetProcessList();
            dropProcessName.DataTextField = "PROCESSNAME";
            dropProcessName.DataValueField = "PROCESSNAME";
            dropProcessName.DataBind();
            dropProcessName.Items.Insert(0, new ListItem("", ""));
        }

        private void BindList()
        {
            try
            {
                DataTable dt;
                dt = _workflow.GetDelegationTable(SessionLogic.GetUltimusLoginName(), "");
                ProcessesList.DataSource = dt;
                ProcessesList.DataBind();
                
            }
            catch (Exception ex)
            {
                MessageBox("alert('" + ex.Message + "');");
            }
        }

        private void MessageBox(string script)
        {
            this.Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "javascript", "<script language='javascript' defer>" + script + "</script>");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            BindList();
        }
        
        protected void Button4_Click(object sender, EventArgs e)
        {
            try
            {
                int count = 0;
                foreach (RepeaterItem item in ProcessesList.Items)
                {
                    HtmlInputCheckBox cb = item.FindControl("Processes_checkbox") as HtmlInputCheckBox;
                    if (cb.Checked)
                    {
                        string ProcessNames = (item.FindControl("lblProcessName") as Label).Text.Trim();
                        string ASSIGNEDTOUSER = (item.FindControl("lblASSIGNEDTOUSER") as Label).Text.Trim();
                        string ASSIGNFROM = (item.FindControl("lblASSIGNFROM") as Label).Text.Trim();

                        DateTime dtASSIGNFROM = ConvertUtil.ToDateTime(ASSIGNFROM);
                        _workflow.WithdrawDelegationTask(ProcessNames, ASSIGNEDTOUSER, ASSIGNFROM);
                        count++;

                    }
                }
                if (count > 0)
                {
                    BindList();
                    MessageBox("alert('" + Lang.Get("SubmitSuccess") + "');");
                }

            }
            catch (Exception ex)
            {
                MessageBox("alert('" + ex.Message + "');");
            }
        }
    }
}