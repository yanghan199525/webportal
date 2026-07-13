using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace UWF.Process.TestProcess
{
    /// <summary>
    /// FormHandler 的摘要说明
    /// </summary>
    public class FormHandler : IHttpHandler {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string method = context.Request["method"];
            switch (method)
            {
                case "getUserCompany":
                    getUserCompany(context);
                    break;
                case "getItems":
                    getItems(context);
                    break;
                case "changeOption":
                    changeOption(context);
                    break;
            }
        }

        void getUserCompany(HttpContext context)
        {
            string userAccount= context.Request["userAccount"];
            string company = ConvertUtil.ToString(DataAccess.Instance("BizDB").
                ExecuteScalar("select username from org_user where loginname=@p1",userAccount));
            context.Response.Write(company);
        }

        void getItems(HttpContext context)
        {
            string userAccount = context.Request["userAccount"];
            DataTable dt =DataAccess.Instance("BizDB").
                ExecuteDataTable("select top 10 departmentname,departmentid from org_department", userAccount);
            string str = SerializeUtil.JsonSerialize(dt);
            context.Response.Write(str);
        }

        public void changeOption(HttpContext context)
        {
            string type = context.Request["type"];
            string value = context.Request["value"];
            try
            {
                string jsonStr = string.Empty;
                string sql = @"select VALUE,NAME from COM_RESOURCE where PARENTID=(
                                select RESOURCEID from COM_RESOURCE where VALUE=@VALUE AND ISACTIVE=1) AND ISACTIVE=1 order by orderno";

                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, value.Trim());
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