using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.AddSign
{
    public partial class ApprovalHistory_AddSign : System.Web.UI.UserControl
    {
        private IApprovalHistory logic = ServiceContainer.Instance().GetService<IApprovalHistory>();
        public string Comments
        {
            get
            {
                return txtComments.Text;
            }
        }


        /// <summary>
        /// 操作类型 退回1 同意0 
        /// </summary>
        public int ActionType
        {
            get
            {
                return 0;
            }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserInfo_AddSign userInfo = Page.FindControl("UserInfo1") as UserInfo_AddSign;
                int incident = ConvertUtil.ToInt32(userInfo.Incident);
                if (incident <= 0)
                {
                    this.Visible = false;
                }
                string type = Request.QueryString["Type"];
                if (!string.IsNullOrEmpty(type))
                {
                    if (type.ToUpper() == "MYAPPROVAL" || type.ToUpper() == "MYREQUEST") //已完成，不显示提交按钮
                    {
                        trIdear.Visible= false;
                    }
                }
            }
        }

     

    }
}