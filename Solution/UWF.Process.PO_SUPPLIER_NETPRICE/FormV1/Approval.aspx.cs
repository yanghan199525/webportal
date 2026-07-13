using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data;
using Ultimus.UWF.Form.ProcessControl.V3;
using MyLib;
using Ultimus.UWF.Workflow.Interface;
using System.Data.Common;

namespace UWF.Process.PO_SUPPLIER_NETPRICE
{
    public partial class Approval : System.Web.UI.Page
    {
        protected void AfterLoad()
        {
            
        }
        protected void Process(object sender, System.ComponentModel.CancelEventArgs e)
        {
            //    UserInfo UserInfo = Page.FindControl("UserInfo1") as UserInfo;
            //    Label read_APPLICANTCODE = (Label)UserInfo.FindControl("read_APPLICANTCODE");//工号ok
            //    Ultimus.UWF.Form.WebControls.Repeater items = Page.FindControl("read_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            //    IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            //    DataTable dt2 = _workflow.GetDetailData(UserInfo, items, UserInfo.FormID);
            //StringBuilder sSql = new StringBuilder();
            //DataAccess db = DataAccess.Instance("BizDB");
            //var FORMID = string.Empty;

            //var TOTALAMOUNTSUPPLIER = 0m;
            //var TOTALAMOUNTDIFFER = 0m;
            //var falg = false;
            //foreach (DataRow item in dt2.Rows)
            //    {
            //    var GRRECEIVINGQUANTITY = Convert.ToDecimal(item["GRRECEIVINGQUANTITY"].ToString());
            //    var NETPRICEORDER = Convert.ToDecimal(item["NETPRICEORDER"].ToString());
            //    var NETPRICESUPPLIER = Convert.ToDecimal(item["NETPRICESUPPLIER"].ToString());
            //    var NETPRICEDIFFER = NETPRICEORDER - NETPRICESUPPLIER;

            //    //if (string.IsNullOrWhiteSpace(item["FINALNETPRICE"].ToString()) && string.IsNullOrWhiteSpace(item["FINALTAXRATE"].ToString()))
            //    //    continue;
            //     FORMID = item["FORMID"].ToString();
            //     string rowGuID = item["ROWGUID"].ToString();
            //    var reasonsStr = string.Empty;
            //    if (!string.IsNullOrWhiteSpace(item["FINALNETPRICE"].ToString()))
            //    {
            //        reasonsStr = " NETPRICESUPPLIER='" + item["FINALNETPRICE"].ToString() + "',FINALNETPRICE='" + item["FINALNETPRICE"].ToString() + "',";
            //         NETPRICEDIFFER = NETPRICEORDER - Convert.ToDecimal(item["FINALNETPRICE"].ToString());
            //        var DIFFERAMOUNTINT = NETPRICEDIFFER * GRRECEIVINGQUANTITY;
            //        var SUPPLIERAMOUNTINT = Convert.ToDecimal(item["FINALNETPRICE"].ToString()) * GRRECEIVINGQUANTITY;
            //        reasonsStr += " NETPRICEDIFFER='" + NETPRICEDIFFER + "',DIFFERAMOUNTINT='" + DIFFERAMOUNTINT + "',SUPPLIERAMOUNTINT='" + SUPPLIERAMOUNTINT + "',";
            //        NETPRICESUPPLIER = Convert.ToDecimal(item["FINALNETPRICE"].ToString());

            //    }
            //    TOTALAMOUNTSUPPLIER += NETPRICESUPPLIER * GRRECEIVINGQUANTITY;
            //    TOTALAMOUNTDIFFER += NETPRICEDIFFER * GRRECEIVINGQUANTITY;
               
            //    if (!string.IsNullOrWhiteSpace(item["FINALNETPRICE"].ToString()))
            //    {
            //        var finalnetprice = Convert.ToDecimal(item["FINALNETPRICE"].ToString());
            //        if (finalnetprice > 0)
            //        {
            //            reasonsStr += " TAXRATESUPPLIER=N'" + item["FINALTAXRATE"].ToString() + "',FINALTAXRATE=N'" + item["FINALTAXRATE"].ToString() + "'";
            //        }
            //    }
            //    if (!string.IsNullOrWhiteSpace(reasonsStr))
            //    {
            //        reasonsStr.EndsWith(",");
            //        sSql.Append(@"update [dbo].[PROC_PO_SUPPLIER_NETPRICE_ITEMS] set " + reasonsStr + " WHERE FORMID='" + FORMID + "'  AND ROWGUID= '" + rowGuID + "';");
            //        falg = true;
            //    }
            //}
            //if (!falg)return;
            // sSql.Append(@"update [dbo].[PROC_PO_SUPPLIER_NETPRICE] set ISCHANGE=1,TOTALAMOUNTSUPPLIER='" + TOTALAMOUNTSUPPLIER + "', TOTALAMOUNTDIFFER='" + TOTALAMOUNTDIFFER + "' WHERE FORMID='" + FORMID + "' ;");
            //if (string.IsNullOrWhiteSpace(sSql.ToString())) return;
            //using (DbCommand cmd = db.CreateCommand())
            //{
            //    cmd.CommandText = sSql.ToString();
            //    cmd.CommandType = CommandType.Text;
            //    db.ExecuteNonQuery(cmd);
            //}

        }
    }
}