using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class DecentralizationReport : System.Web.UI.Page
    {
        public static string languaes;
        protected void Page_Load(object sender, EventArgs e)
        {
            string LoginName = SessionLogic.GetLoginName().Split('\\')[1];
            languaes = GetLanguaes(LoginName);
            BindPageTxt(languaes);
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            //ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = string.Format("BizDB.select sdName,sdEmpNo,sdCreatTime,sdOrgName,rdName,rdEmpNo,rdCreatTime,authStartTime,authEndTime,authDesc,authRange ,comments  from PROC_Decentralization_Log");
            rpt.Sort = " sdCreatTime DESC";
        }
        public string GetLanguaes(string loginName)
        {
            string sql = string.Format("select LANGUAGE from ORG_USER where LOGINNAME='{0}'", loginName);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt.Rows[0]["LANGUAGE"].ToString();
        }
        protected void Button1_BeforeClick(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            //ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = string.Format("BizDB.select sdName,sdEmpNo,sdCreatTime,sdOrgName,rdName,rdEmpNo,rdCreatTime,authStartTime,authEndTime,authDesc,authRange ,comments  from PROC_Decentralization_Log");
            rpt.Sort = " sdCreatTime DESC";
        }

        public void BindPageTxt(string type)
        {
            switch (type)
            {
                case "zh-CN":
                    this.Serch_sdName.Text = "授权操作人名称:";
                    this.Serch_rdName.Text = "RD姓名:";
                  

                    this.btn_serch.Text = "查询";

                    this.log_info.Text = "单外权力下放日志监控";
                    this.log_sdName.Text = "授权操作人名称";
                    this.log_sdEmpNo.Text = "授权操作人编号";
                    this.log_sdCreate.Text = "授权操作时间";
                    this.log_orgName.Text = "事业部";
                    this.log_rdName.Text = "RD姓名";
                    this.log_rdempNo.Text = "RD员工编号";
                    this.log_rdCreate.Text = "RD操作时间";
                    this.log_startTime.Text = "授权开始时间";
                    this.log_endTime.Text = "授权结束时间";
                    this.log_desc.Text = "授权说明";
                    this.log_range.Text = "授权范围";
                    this.log_content.Text = "操作内容";
                    break;

                case "en-US":
                    this.Serch_sdName.Text = "SD Name:";
                    this.Serch_rdName.Text = "RD Name:";
                    this.btn_serch.Text = "Search";
                    this.log_info.Text = "Out-of-Catalogue decentralization log monitor";
                    this.log_sdName.Text = "SD Name";
                    this.log_sdEmpNo.Text = "SD Staff No.";
                    this.log_sdCreate.Text = "Operating Time of Authorization";
                    this.log_orgName.Text = "Business Unit";
                    this.log_rdName.Text = "RD Name";
                    this.log_rdempNo.Text = "RD Staff No.";
                    this.log_rdCreate.Text = "Operating Time of RD";
                    this.log_startTime.Text = "Start Time of Authorization";
                    this.log_endTime.Text = "End Time of Authorization";
                    this.log_desc.Text = "Authorization Discription";
                    this.log_range.Text = "Scope of Authorization";
                    this.log_content.Text = "Operation content";
                    break;
                default:
                    break;
            }
        }
    }
}