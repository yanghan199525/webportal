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

namespace UWF.Process.PO_AMENDMENT
{
    public partial class ReportList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = @"BizDB.SELECT 
    AAA.[FORMID], AAA.[PROCESSNAME], AAA.[INCIDENT], AAA.[DOCUMENTNO], AAA.[ADJUSTDOCUMENTNO],
    AAA.[CREATEBY], AAA.[CREATEBYACCOUNT], AAA.[CREATEBYCODE], AAA.[APPLICANT], AAA.[APPLICANTACCOUNT],
    AAA.[APPLICANTCODE], AAA.[REQUESTDATE], AAA.[COMPLETEDATE], AAA.[DEPARTMENT], AAA.[DEPARTMENTID],
    AAA.[PROCESSSUMMARY], AAA.[STATUS], AAA.[PurchasingPurpose], AAA.[SITECODE], AAA.[SITENAME],
    AAA.[DELIVERYDATE], AAA.[Requirement], AAA.[APPROVEDATE], AAA.[DELIVERY], AAA.[APPROVE],
    AAA.[APPLICANTTEL], AAA.[COMPANY], AAA.[COSTCENTER], AAA.[APPREMARK], AAA.[AMOUNT], AAA.[ACTION],
    WF.* --强烈建议将 WF.* 替换为实际需要的具体字段，避免回表开销
FROM PROC_PO_AMENDMENT AAA
-- 【核心优化】：使用 CROSS APPLY 逐行动态关联，精准获取每个 FORMID 的最新审批记录
CROSS APPLY(
    SELECT TOP 1 *
    FROM WF_APPROVALHISTORY
    WHERE FORMID = AAA.FORMID
    ORDER BY ID DESC
) WF
WHERE AAA.INCIDENT != '-1'
ORDER BY AAA.REQUESTDATE DESC";
            rpt.Sort = "REQUESTDATE DESC";
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
            dt=ExportLogic.GetSchemaTable("PO_AMENDMENT", dt);
            ExcelUtil.Export(dt);
        }
    }
}