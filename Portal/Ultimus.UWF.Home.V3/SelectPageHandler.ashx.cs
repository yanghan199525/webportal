using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Form.Entity;

namespace Ultimus.UWF.Home.V3
{
    /// <summary>
    /// demo11 的摘要说明
    /// </summary>
    public class SelectPageHandler : IHttpHandler
    {
        HttpRequest request;
        HttpResponse response;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            this.request = context.Request;
            this.response = context.Response;
            string data = string.Empty;
            int start = 0;
            int limit = 10;
            int page = 0;
            int Count = 0;
            try
            {
                start = ConvertUtil.ToInt16(this.request["start"]);
                limit = ConvertUtil.ToInt16(this.request["limit"]);
                page = ConvertUtil.ToInt16(this.request["page"]);
                string search = ConvertUtil.ToString(this.request["search"]);
                string hidDataSource = ConvertUtil.ToString(this.request["hidDataSource"]);
                string hidFilter = ConvertUtil.ToString(this.request["hidFilter"]);
                string fields = string.Empty;
                string hidSql = string.Empty;
                string hidQuery = string.Empty;
                string hidDBName = string.Empty;
                string hidOrder = string.Empty;

                Ultimus.UWF.Form.Interface.IDataSource ds = ServiceContainer.Instance().GetService<Ultimus.UWF.Form.Interface.IDataSource>();
                DataSourceEntity entity = ds.GetDataSourceEntity(hidDataSource);
                if (entity != null)
                {
                    hidQuery = entity.DATATEXTFIELD;
                    fields = entity.DATATEXTFIELD;
                    if (!string.IsNullOrEmpty(entity.EXT01))
                    {
                        fields = entity.DATATEXTFIELD + "," + entity.EXT01;
                    }
                    hidSql = ds.GetDataSourceSql(entity, fields, hidFilter);
                    hidDBName = entity.DATABASENAME;
                    hidOrder = entity.SORTFIELD;
                }
                string sql = "select " + fields + " from ( " + hidSql + " ) A where 1=1 " + GetSearch(hidQuery, search) + GetOrder(hidOrder);
                DataTable dt = DataAccess.Instance("" + hidDBName + "").ExecutePagedDataTable(sql, start, limit);
                data = MyLib.SerializeUtil.JsonSerialize(dt);
                DataTable dts = DataAccess.Instance("" + hidDBName + "").ExecuteDataTable(sql);
                if (dts != null && dt.Rows.Count > 0)
                {
                    Count = ConvertUtil.ToInt32(dts.Rows.Count);
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            string StrJosn = "{\"start\":" + start + ",\"limit\":" + limit + ",\"page\":" + page + ",\"recordsTotal\":" + Count + ",\"recordsFiltered\":" + Count + ",\"data\":" + data + "}";
            response.Write(StrJosn);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 查询条件
        /// </summary>
        /// <param name="hidQuery"></param>
        /// <param name="search"></param>
        /// <returns></returns>
        public string GetSearch(string hidQuery, string search)
        {
            string Search = "";
            if (!string.IsNullOrEmpty(search))
            {
                Search += " and( ";
                foreach (string item in hidQuery.Split(','))
                {
                    Search += "A." + item + " like N'%" + search + "%' or ";
                }
                Search += " 1=2 ) ";
            }
            return Search;
        }

        /// <summary>
        /// 排序
        /// </summary>
        /// <param name="hidOrder"></param>
        /// <returns></returns>
        public string GetOrder(string hidOrder)
        {
            string order = "";
            if (string.IsNullOrEmpty(hidOrder))
            {
                return order = "";
            }
            order = "ORDER BY ";
            try
            {
                foreach (string item in hidOrder.Split(','))
                {
                    order += "A." + item + " ,";
                }
                order = order.TrimEnd(',');
            }
            catch (Exception)
            {
                order = "";
            }
            return order;
        }
    }
}