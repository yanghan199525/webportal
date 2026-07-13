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
    public class HandlerCommon : IHttpHandler
    {
        HttpRequest request;
        HttpResponse response;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            this.request = context.Request;
            this.response = context.Response;
            try
            {
                string method = this.request["Method"];
                string tablename = this.request["Table"];
                string Document = this.request["Doc"];
                string sql = string.Empty;
                DataTable dt = new DataTable();
                string StrJosn = string.Empty;

                switch (method)
                {
                    // 审批页打开对应表单
                    case "OpenForm":
                        sql = "select FORMID,PROCESSNAME,INCIDENT from " + tablename.Replace("'", "''") + " where DOCUMENTNO=@Document";
                        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, Document);
                        if (dt.Rows.Count > 0 && dt != null)
                        {
                            StrJosn = MyLib.SerializeUtil.JsonSerialize(dt);
                            this.response.Write(StrJosn);
                        }
                        break;
                    // 合同编号打开合同表单
                    case "OpenContract":
                        OpenContract(context);
                        break;
                    // 获取下拉框的联动数据源
                    case "GetDropLinkAgeData":
                        GetDropLinkAgeData(context);
                        break;
                    // 获取下拉框的拓展数据
                    case "GetDropEXTData":
                        GetDropEXTData(context);
                        break;
                    // 获取下拉框的值
                    case "GetDropValue":
                        GetDropValue(context);
                        break;
                    // 检查子流程是否完成
                    case "CheckChildrenProcessStatus":
                        CheckChildrenProcessStatus(context);
                        break;
                }
            }
            catch (Exception)
            {


            }

        }

        #region 合同编号打开合同表单
        /// <summary>
        /// 合同编号打开合同表单
        /// </summary>
        /// <param name="context"></param>
        public void OpenContract(HttpContext context)
        {
            string ContractNo = context.Request["ContractNo"];
            string sql = "select FORMID,PROCESSNAME,INCIDENT from PROC_UPL_PURCHASE_CONTRACTPOEVALUATION where CONTRACTNO=@CONTRACTNO";
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, ContractNo);
            if (dt.Rows.Count > 0 && dt != null)
            {
                string StrJosn = MyLib.SerializeUtil.JsonSerialize(dt);
                this.response.Write(StrJosn);
            }
        }
        #endregion

        #region 获取下拉框的联动数据源
        /// <summary>
        /// 获取下拉框的联动数据源
        /// </summary>
        /// <param name="context"></param>
        public void GetDropLinkAgeData(HttpContext context)
        {
            string type = context.Request["type"];
            string value = context.Request["value"];
            try
            {
                string jsonStr = string.Empty;
                string sql = @"select VALUE,NAME from COM_RESOURCE where PARENTID=(
                                select RESOURCEID from COM_RESOURCE where TYPE=@TYPE AND VALUE=@VALUE AND ISACTIVE=1) AND ISACTIVE=1 order by orderno";

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, type.Trim(), value.Trim());
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

        #region 获取下拉框的拓展数据
        /// <summary>
        /// 获取下拉框的拓展数据
        /// </summary>
        /// <param name="context"></param>
        public void GetDropEXTData(HttpContext context)
        {
            string type = context.Request["type"];
            string value = context.Request["value"];
            try
            {
                string jsonStr = string.Empty;
                string sql = "select * from COM_RESOURCE where TYPE=@TYPE AND VALUE=@VALUE AND ISACTIVE=1";

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, type.Trim(), value.Trim());
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

        #region 获取下拉框的值
        /// <summary>
        /// 获取下拉框的值
        /// </summary>
        /// <param name="context"></param>
        public void GetDropValue(HttpContext context)
        {
            string tableName = context.Request["tableName"];
            string formId = context.Request["formId"];
            string rowId = context.Request["rowId"];
            string field = context.Request["field"];
            try
            {
                string sql = "select " + field.Replace("'", "''") + " from " + tableName.Replace("'", "''") + @" 
                        where FORMID=@formId and ROWID=@rowId";
                string msg = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar(sql, formId, rowId));
                if (!string.IsNullOrEmpty(msg))
                    context.Response.Write(msg);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        #endregion

        #region 检查子流程是否完成
        /// <summary>
        /// 检查子流程是否完成
        /// </summary>
        /// <param name="context"></param>
        public void CheckChildrenProcessStatus(HttpContext context)
        {
            try
            {
                string jsonStr = string.Empty;
                string formId = ConvertUtil.ToString(context.Request["formId"]);
                string tableName = ConvertUtil.ToString(context.Request["tableName"]);

                if (string.IsNullOrEmpty(formId))
                {
                    jsonStr = MyLib.SerializeUtil.JsonSerialize(new { status = -1, msg = "formId不能为空！" });
                }
                else
                {
                    string sql = "select t.status from " + tableName + " t where trim(t.parentformid)=@formId group by t.status ";
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, formId.Trim());
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        DataRow[] dr = dt.Select("status <> 2");
                        if (dr.Length > 0)
                            jsonStr = MyLib.SerializeUtil.JsonSerialize(new { status = 1, msg = "未完成" });
                        else
                            jsonStr = MyLib.SerializeUtil.JsonSerialize(new { status = 2, msg = "已完成" });
                    }
                    else
                    {
                        jsonStr = MyLib.SerializeUtil.JsonSerialize(new { status = 0, msg = "子流程信息未找到！" });
                    }
                }
                context.Response.Write(jsonStr);
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