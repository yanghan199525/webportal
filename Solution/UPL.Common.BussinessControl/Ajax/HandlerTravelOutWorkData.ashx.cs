using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace UPL.Common.BussinessControl
{
    /// <summary>
    /// FormHandler 的摘要说明
    /// </summary>
    public class HandlerTravelOutWorkData : IHttpHandler {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string DocumentNo = context.Request["DocumentNo"];
            try
            {
                string jsonStr = string.Empty;
                string sql = @"select b.FORMID,b.PROCESSNAME,b.INCIDENT,b.ROWNO,b.ROWGUID,b.PLACEOFDEPARTURE,b.DESTINATION,b.TOOL,SUBSTRING(REPLACE(CONVERT(varchar, b.BEGINDATE, 120 ),'-','/'),0,17) as BEGINDATE,SUBSTRING(REPLACE(CONVERT(varchar, b.ENDDATE, 120 ),'-','/'),0,17) as ENDDATE,b.HOURS,b.CAUSE,b.TOOL_NAME from PROC_SCM_TRAVELOUTWORK a left join PROC_SCM_TRAVELOUTWORK_DT b on a.FORMID=b.FORMID where a.DOCUMENTNO=@DocumentNo ";
                
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, DocumentNo.Trim());
                if (dt.Rows.Count > 0 && dt != null)
                {
                    jsonStr = MyLib.SerializeUtil.JsonSerialize(dt);
                    context.Response.Write(jsonStr);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool IsReusable {
            get {
                return false;
            }
        }
    }
}