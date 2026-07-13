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

namespace UWF.Process.PO_SUPPLIER_SUMMARY
{
    public partial class ReportList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
            ProcessFormLogic process = new ProcessFormLogic();
            rpt.Source = @"BizDB.SELECT 
    AAA.[FORMID], AAA.[PROCESSNAME], AAA.[INCIDENT], AAA.[DOCUMENTNO], 
    AAA.[PROCESSVERSION], AAA.[CREATEBYACCOUNT], AAA.[CREATEBYCODE], AAA.[CREATEBY], 
    AAA.[APPLICANTACCOUNT], AAA.[APPLICANTCODE], AAA.[APPLICANT], AAA.[APPLICANTTEL], 
    AAA.[REQUESTDATE], AAA.[COMPLETEDATE], AAA.[COMPANYID], AAA.[COMPANY], 
    AAA.[DEPARTMENTLEVEL], AAA.[DEPARTMENTID], AAA.[DEPARTMENT], AAA.[COSTCENTERID], 
    AAA.[COSTCENTER], AAA.[JOBLEVEL], AAA.[GRADECODE], AAA.[GRADE], AAA.[JOBFUNCTION], 
    AAA.[EMAIL], AAA.[PROCESSSUMMARY], AAA.[STATUS], AAA.[JUDGELOGIC1], 
    AAA.[JUDGELOGIC2], AAA.[JUDGELOGIC3], AAA.[SIGNATURE], AAA.[PURPOSE], 
    AAA.[EXECUTIONDATE], AAA.[DATE], AAA.[BATCHNUMBER], AAA.[APPROVE], 
    AAA.[ASSIGNEDTOUSER],
    WF.ACTION
FROM [dbo].[PROC_PO_SUPPLIER_SUMMARY] AS AAA
-- 依然使用 CROSS APPLY 高效关联最新的审批历史
CROSS APPLY (
    SELECT TOP (1) ACTION
    FROM WF_APPROVALHISTORY
    WHERE FORMID = AAA.FORMID
    ORDER BY ID DESC
) AS WF
WHERE AAA.[INCIDENT] <> -1  
-- 全量输出时，必须显式指定排序规则以保证结果集有序
--ORDER BY AAA.[REQUESTDATE] DESC;
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
            dt=ExportLogic.GetSchemaTable("PO_SUPPLIER_SUMMARY", dt);
            ExcelUtil.Export(dt);
        }
    }
}