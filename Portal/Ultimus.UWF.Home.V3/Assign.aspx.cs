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
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class Assign : System.Web.UI.Page
    {
        public string EnableProcessAssign = "";
        public string onlyselect = "";
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            Button1.Text = Lang.Get("Assign_AssignButton");
            if (Request.QueryString["TaskID"] != null)
            {
                TaskIDs.Value = Request.QueryString["TaskID"].ToString().Trim();
            }
            if (!IsPostBack)
            {
                BindProcess();
            }

            if (Request.QueryString["onlyselect"] == "1")
            {
                onlyselect = "hidden";
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            string pFromUser = SessionLogic.GetLoginName().Replace("\\", "/");
            string pToUser = AssignUserAccount.Value.Replace("|USER", "").Replace("\\", "/");
            string pEndDate = txtFutureTaskDate.Text.Trim() == "" ? DateTime.Now.ToString() : txtFutureTaskDate.Text;
            if (pFromUser.Trim().ToUpper() == ConfigurationManager.AppSettings["taskUser"].Trim().ToUpper())
            {
                MessageBox("alert('您没有指派的权限')");
            }
            else {
              

                int pMode = 0;
                if (this.RadioButton1.Checked)
                {
                    pMode = 1;//仅限选定的任务
                }
                else if (this.RadioButton2.Checked)
                {
                    pMode = 2;//所有现有的任务
                }
                else if (this.RadioButton3.Checked)
                {
                    pMode = 3;//所有将来的任务  
                    pEndDate = this.txtFutureTaskDate.Text;
                }
                else if (this.RadioButton4.Checked)
                {
                    pMode = 4;//按流程指派
                }
                bool result = false;
                if (pMode == 1)
                {
                    string[] TaskIDArray = TaskIDs.Value.Split(',');
                    foreach (string pTaskID in TaskIDArray)
                    {
                        if (pTaskID.Trim() == "")
                            continue;
                        result = this.SetAssign(pTaskID, pFromUser, pToUser, pMode, ConvertUtil.ToDateTime(txtBegin.Text), ConvertUtil.ToDateTime(pEndDate));
                    }
                }
                else if (pMode == 3)
                {
                    string strProcessName = "";
                    string dBegin = DateTime.Now.ToShortDateString();
                    string dEnd = pEndDate + " 23:59:59";
                    if (this.isExistAssign(pFromUser, dBegin))
                    {
                        MessageBox("alert('" + Lang.Get("Assign_Msg1") + "')");
                        return;
                    }
                    result = this.SetProcAssign(strProcessName, pFromUser, pToUser, dBegin, dEnd);
                }
                else if (pMode == 4)
                {
                    string strProcessName = dropProcessName.SelectedItem.Text;
                    string dBegin = this.txtBegin.Text;
                    string dEnd = this.txtEnd.Text + " 23:59:59";
                    if (this.isExistAssign(strProcessName, pFromUser, dBegin))
                    {
                        MessageBox("alert('" + Lang.Get("Assign_Msg1") + "')");
                        return;
                    }
                    result = this.SetProcAssign(strProcessName, pFromUser, pToUser, dBegin, dEnd);
                }
                else
                {
                    //将来指派和所有任务指派不需要循环
                    result = this.SetAssign("", pFromUser, pToUser, pMode, ConvertUtil.ToDateTime(txtBegin.Text), ConvertUtil.ToDateTime(pEndDate));
                }
                if (result)
                {
                    MessageBox("closePage();");
                }
                else
                {
                    MessageBox("alert('" + Lang.Get("Assign_Msg3") + "')");

                }
            }
            LogUtil.Info($"指派操作    taskUser:{pFromUser} assignUser:{pToUser}  date:{pEndDate}");
           
        }

        private void MessageBox(string script)
        {
            this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "clo", script, true);
        }

        private bool isExistAssign(string pFromUser, string dBegin)
        {
            return _workflow.IsExistAssign(pFromUser, ConvertUtil.ToDateTime(dBegin));
        }

        /// <summary>
        /// 是否存在该流程的指派
        /// </summary>
        /// <param name="strProcessName"></param>
        /// <param name="pFromUser"></param>
        /// <param name="dBegin"></param>
        /// <returns></returns>
        private bool isExistAssign(string strProcessName, string pFromUser, string dBegin)
        {
            return _workflow.IsExistAssign(strProcessName, pFromUser, ConvertUtil.ToDateTime(dBegin));
        }

        private bool SetProcAssign(string strProcessName, string pFromUser, string pToUser, string dBegin, string dEnd)
        {
            return _workflow.SetProcessAssign(strProcessName, pFromUser, pToUser, ConvertUtil.ToDateTime(dBegin)
                , ConvertUtil.ToDateTime(dEnd));
        }

        private bool SetAssign(string pTaskID, string pFromUser, string pToUser, int pMode, DateTime start, DateTime end)
        {
            bool result = false;
            try
            {
                switch (pMode)
                {
                    case 1:
                        result = _workflow.AssignTask("",pTaskID, pToUser);
                        break;
                    case 2:
                        result = _workflow.AssignAllTasks(pFromUser, pToUser);
                        break;
                    case 3:
                        result = _workflow.DelegationTask("","","", pFromUser, pToUser, start,end);
                        break;
                }
                return result;

            }
            catch
            {
                return false;
            }
        }
    }
}