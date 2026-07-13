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
            rpt.Source = "BizDB.SELECT top 200000 AAA.[FORMID],AAA.[PROCESSNAME],AAA.[INCIDENT],[DOCUMENTNO],ADJUSTDOCUMENTNO,[CREATEBY],[CREATEBYACCOUNT],[CREATEBYCODE],[APPLICANT],[APPLICANTACCOUNT],[APPLICANTCODE],[REQUESTDATE],[COMPLETEDATE],[DEPARTMENT],[DEPARTMENTID],[PROCESSSUMMARY],AAA.[STATUS],[PurchasingPurpose],[SITECODE],[SITENAME],[DELIVERYDATE],[Requirement],[APPROVEDATE],[DELIVERY],[APPROVE],[APPLICANTTEL],[COMPANY],[COSTCENTER],[APPREMARK],AMOUNT,ACTION FROM ( SELECT TOP 200000 * FROM(SELECT [FORMID],[PROCESSNAME],[INCIDENT],[DOCUMENTNO],ADJUSTDOCUMENTNO,[CREATEBY],[CREATEBYACCOUNT],[CREATEBYCODE],[APPLICANT],[APPLICANTACCOUNT],[APPLICANTCODE],[REQUESTDATE],[COMPLETEDATE],[DEPARTMENT],[DEPARTMENTID],[PROCESSSUMMARY],[STATUS],[PurchasingPurpose],[SITECODE],[SITENAME],[DELIVERYDATE],[Requirement],[APPROVEDATE],[DELIVERY],[APPROVE],[APPLICANTTEL],[COMPANY],[COSTCENTER],[APPREMARK],AMOUNT FROM PROC_PO_AMENDMENT )T WHERE 1 = 1 ORDER BY T.REQUESTDATE DESC) AAA,(SELECT * FROM WF_APPROVALHISTORY WHERE ID IN(SELECT TOP 200000 MAX(ID) ID FROM WF_APPROVALHISTORY GROUP BY FORMID)) WF WHERE AAA.FORMID=WF.FORMID AND AAA.INCIDENT!='-1' ORDER BY AAA.REQUESTDATE DESC";
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