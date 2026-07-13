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

namespace UWF.Process.HK_HK_CAPEX_SERVICE
{
    public partial class ReportList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = @"BizDB.SELECT TOP 200 
    AAA.[FORMID],
    AAA.[PROCESSNAME],
    AAA.[INCIDENT],
    AAA.[DOCUMENTNO],
    AAA.ADJUSTDOCUMENTNO,
    AAA.[CREATEBY],
    AAA.[CREATEBYACCOUNT],
    AAA.[CREATEBYCODE],
    AAA.[APPLICANT],
    AAA.[APPLICANTACCOUNT],
    AAA.[APPLICANTCODE],
    AAA.[REQUESTDATE],
    AAA.[COMPLETEDATE],
    AAA.[DEPARTMENT],
    AAA.[DEPARTMENTID],
    AAA.[PROCESSSUMMARY],
    AAA.[STATUS],
    AAA.[PurchasingPurpose],
    AAA.[SITECODE],
    AAA.[SITENAME],
    AAA.[DELIVERYDATE],
    AAA.[Requirement],
    AAA.[APPROVEDATE],
    AAA.[DELIVERY],
    AAA.[APPROVE],
    AAA.[APPLICANTTEL],
    AAA.[COMPANY],
    AAA.[COSTCENTER],
    AAA.[APPREMARK],
    AAA.AMOUNT,
    WF.ACTION
FROM (
    -- 从PROC_PO_AMENDMENT取最新20万条记录（按REQUESTDATE降序）
    SELECT TOP 200 
        [FORMID], [PROCESSNAME], [INCIDENT], [DOCUMENTNO],  CAPEXNUMBER ADJUSTDOCUMENTNO,
        [CREATEBY], [CREATEBYACCOUNT], [CREATEBYCODE], [APPLICANT], [APPLICANTACCOUNT],
        [APPLICANTCODE], [REQUESTDATE], [COMPLETEDATE], [DEPARTMENT], [DEPARTMENTID],
        [PROCESSSUMMARY], [STATUS], ''[PurchasingPurpose], [SITECODE], [SITENAME],
        ''[DELIVERYDATE], ''[Requirement],'' [APPROVEDATE], ''[DELIVERY], [APPROVE],
        [APPLICANTTEL], [COMPANY], [COSTCENTER], [APPREMARK], AMOUNT
    FROM PROC_HK_HK_CAPEX_SERVICE
    WHERE [INCIDENT] != '-1'  -- 提前过滤无效INCIDENT，减少后续处理数据量
    ORDER BY [REQUESTDATE] DESC
) AAA
INNER JOIN (
    -- 取WF_APPROVALHISTORY中每个FORMID的最新记录（最大ID），并限制前20万条
    SELECT *
    FROM (
        SELECT 
            *,
            -- 按FORMID分组，ID降序排序，取每组第一条（即最大ID记录）
            ROW_NUMBER() OVER (PARTITION BY FORMID ORDER BY ID DESC) AS RN
        FROM WF_APPROVALHISTORY
    ) T
    WHERE RN = 1  -- 只保留每个FORMID的最新记录
) WF ON AAA.FORMID = WF.FORMID
ORDER BY AAA.[REQUESTDATE] DESC";
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
            dt=ExportLogic.GetSchemaTable("HK_HK_CAPEX_SERVICE", dt);
            ExcelUtil.Export(dt);
        }
    }
}