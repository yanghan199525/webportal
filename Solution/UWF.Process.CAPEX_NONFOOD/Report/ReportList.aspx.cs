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

namespace UWF.Process.CAPEX_NONFOOD
{
    public partial class ReportList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = @"BizDB.SELECT 
    AAA.[FORMID], AAA.[PROCESSNAME], AAA.[INCIDENT], AAA.[DOCUMENTNO], 
     AAA.CAPEXNUMBER ADJUSTDOCUMENTNO, AAA.[CREATEBY], AAA.[CREATEBYACCOUNT], AAA.[CREATEBYCODE], 
    AAA.[APPLICANT], AAA.[APPLICANTACCOUNT], AAA.[APPLICANTCODE], AAA.[REQUESTDATE], 
    AAA.[COMPLETEDATE], AAA.[DEPARTMENT], AAA.[DEPARTMENTID], AAA.[PROCESSSUMMARY], 
    AAA.[STATUS], ''[PurchasingPurpose], AAA.[SITECODE], AAA.[SITENAME], 
    ''[DELIVERYDATE], ''[Requirement], ''[APPROVEDATE], ''[DELIVERY], 
    AAA.[APPROVE], AAA.[APPLICANTTEL], AAA.[COMPANY], AAA.[COSTCENTER], 
    AAA.[APPREMARK], AAA.AMOUNT,
    WF.ACTION
FROM [dbo].[PROC_CAPEX_NONFOOD] AS AAA
-- 依然使用 CROSS APPLY 高效关联最新的审批历史
CROSS APPLY (
    SELECT TOP (1) ACTION
    FROM WF_APPROVALHISTORY
    WHERE FORMID = AAA.FORMID
    ORDER BY ID DESC
) AS WF
WHERE AAA.[INCIDENT] <> -1 
";
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
            dt=ExportLogic.GetSchemaTable("CAPEX_NONFOOD", dt);
            ExcelUtil.Export(dt);
        }
    }
}