using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MyLib;

namespace UPL.Common.BussinessControl.Ajax
{
    /// <summary>
    /// Summary description for HandlerFinanceCommon
    /// </summary>
    public class HandlerCustomProcess : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            try
            {
                string method = context.Request["Method"];
                switch (method)
                {
                    // 获取自定义流程主表数据
                    case "GetProcData":
                        GetProcData(context);
                        break;

                }
            }
            catch (Exception)
            {


            }

        }

        #region 获取自定义流程主表数据
        /// <summary>
        /// 获取自定义流程主表数据
        /// </summary>
        /// <param name="context"></param>
        public void GetProcData(HttpContext context)
        {
            try
            {
                string Formid = context.Request["Formid"];
                string jsonStr = string.Empty;
                string sql = "select * from PROC_CUSTOMPROCESS where Formid=@Formid";

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, Formid.Trim());
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
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}