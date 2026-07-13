using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data;
using MyLib;
using Ultimus.UWF.Form.ProcessControl.V3;
using System.Data.Common;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Home.V3;

namespace UWF.Process.PO_SUPPLIER_SUMMARY
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void AfterLoad()
        {

        }
        protected void Process(object sender, System.ComponentModel.CancelEventArgs e)
        {
            HiddenField approvalType = (HiddenField)Page.FindControl("approvalType");
            if (approvalType.Value == "1")
            {
                UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
                Label read_APPLICANTCODE = (Label)UserInfo.FindControl("read_APPLICANTCODE");//工号ok
                Ultimus.UWF.Form.WebControls.Repeater items = Page.FindControl("read_detail_PROC_PO_SUPPLIER_SUMMARY_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
                IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
                DataTable dt2 = _workflow.GetDetailData(UserInfo, items, UserInfo.FormID);
                var falg = false;
                var batchnumber = string.Empty;
                var formId = string.Empty;
                foreach (DataRow item in dt2.Rows)
                {
                    string isAllow = item["IsAllow"].ToString();
                    string reasons = item["Reasons"].ToString();
                    string supplierCode = item["SupplierCode"].ToString();
                     batchnumber = item["BATCHNUMBER"].ToString();
                    string rowGuID = item["ROWGUID"].ToString();
                    formId = item["FORMID"].ToString();
                    if (isAllow == "1")
                    {
                        falg = true;
                        StringBuilder sSql = new StringBuilder();
                        DataAccess db = DataAccess.Instance("BizDB");
                        var reasonsStr = "";
                        if (!string.IsNullOrWhiteSpace(reasons))
                        {
                            reasonsStr = "Reasons = CASE WHEN ISNULL(Reasons, '') = N'" + reasons + "' THEN N'" + reasons + "' ELSE ISNULL(Reasons, '') + N', ' + N'" + reasons + "' END,IsAllow='" + isAllow + "'";
                            sSql.Append(@"update [dbo].[PROC_PO_SUPPLIER_SUMMARY_ITEMS] set " + reasonsStr + " WHERE SupplierCode='" + supplierCode + "'  and BATCHNUMBER='" + batchnumber + "' AND ROWGUID= '" + rowGuID + "';");                      
                            sSql.Append(@"update [dbo].[PROC_PO_SUPPLIER_NETPRICE] set " + reasonsStr + " WHERE SupplierCode='" + supplierCode + "' and BATCHNUMBER='" + batchnumber + "'");
                            using (DbCommand cmd = db.CreateCommand())
                            {
                                cmd.CommandText = sSql.ToString();
                                cmd.CommandType = CommandType.Text;
                                db.ExecuteNonQuery(cmd);
                            }
                        }
                    }
                    else
                    {
                        StringBuilder sSql = new StringBuilder();
                        DataAccess db = DataAccess.Instance("BizDB");
                        sSql.Append(@"delete [dbo].[PROC_PO_SUPPLIER_SUMMARY_ITEMS]  WHERE SupplierCode='" + supplierCode + "'  and BATCHNUMBER='" + batchnumber + "' AND ROWGUID= '" + rowGuID + "';");
                        var reasonsStr = "";
                        if (!string.IsNullOrWhiteSpace(reasons))
                        {
                            reasonsStr = "Reasons = CASE WHEN ISNULL(Reasons, '') = N'" + reasons + "' THEN N'" + reasons + "' ELSE ISNULL(Reasons, '') + N', ' + N'" + reasons + "' END,";
                        }
                        sSql.Append(@"update [dbo].[PROC_PO_SUPPLIER_NETPRICE] set " + reasonsStr + " STATECODE=4  WHERE SupplierCode='" + supplierCode + "' and BATCHNUMBER='" + batchnumber + "' ");

                        using (DbCommand cmd = db.CreateCommand())
                        {
                            cmd.CommandText = sSql.ToString();
                            cmd.CommandType = CommandType.Text;
                            db.ExecuteNonQuery(cmd);
                        }
                        var sql01 = "select INCIDENT from [dbo].[PROC_PO_SUPPLIER_NETPRICE] WHERE SupplierCode='" + supplierCode + "' and BATCHNUMBER='" + batchnumber + "' ";
                        var dt =new DataTable();
                        using (DbCommand cmd = db.CreateCommand())
                        {
                            cmd.CommandText = sql01.ToString();
                            cmd.CommandType = CommandType.Text;        
                            dt = db.ExecuteDataTable(cmd);
                        }
                        string baseUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["BPM_WEB_API_URL"].Trim();
                        string result;
                        result = HttpUtil.HttpGet(string.Format("{0}/api/bpmNetprice/PushResult?processName={1}&incident={2}&approvalResult={3}", baseUrl, "PO_SUPPLIER_NETPRICE", dt.Rows[0][0].ToString(), 4), "application/json;charset=UTF-8");

                    }
                    if (!falg)
                    {
                        StringBuilder sSql = new StringBuilder();
                        DataAccess db = DataAccess.Instance("BizDB");
                        sSql.Append(@"update [dbo].[PROC_PO_SUPPLIER_SUMMARY] set STATUS=4  WHERE BATCHNUMBER='" + batchnumber + "' AND FORMID='" + formId + "';");
                       
                        sSql.Append(@" UPDATE e SET e.STATUS = 7 FROM UltimusServer..TASKS e INNER JOIN [dbo].[PROC_PO_SUPPLIER_SUMMARY] d ON e.PROCESSNAME = d.PROCESSNAME and e.INCIDENT=d.INCIDENT  WHERE  BATCHNUMBER='" + batchnumber + "'  AND FORMID='" + formId + "'");

                        using (DbCommand cmd = db.CreateCommand())
                        {
                            cmd.CommandText = sSql.ToString();
                            cmd.CommandType = CommandType.Text;
                            db.ExecuteNonQuery(cmd);
                        }
                    }

                }
            }
        }
    }
   
}