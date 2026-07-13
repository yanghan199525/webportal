using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Logic;

namespace UWF.Process.DemoProcess
{
    public partial class ReportList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = "BizDB.select * from PROC_DEMOPROCESS where 1=1 "+process.GetReportViewSql("Demo Process",SessionLogic.GetLoginName());
            rpt.Sort = "incident desc";
        }
        protected void lbExport_Click(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            DataTable dt = rpt.GetFullDataTable();
            // dt数据为空不导出Excel
            if (dt.Rows.Count == 0 || dt == null)
            {
                return;
            }
            dt=ExportLogic.GetSchemaTable("Demo Process", dt);
            ExcelUtil.Export(dt);
        }
    }
}