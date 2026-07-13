using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MyLib;
using System.Timers;

namespace UPL.Common.BussinessControl.Ajax
{
    /// <summary>
    /// Summary description for HandlerFinanceCommon
    /// </summary>
    public class HandlerSealsBorrow : IHttpHandler
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
                string sql = string.Empty;
                DataTable dt = new DataTable();
                string StrJosn = string.Empty;

                switch (method)
                {
                    case "getSeals":
                        getSeals(context);
                        break;
                    //case "getTime":
                    //    getTime(context);
                    //    break;
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
        }

        //获取印章，判断印章是否借出
        public void getSeals(HttpContext context)
        {
            try
            {
                string value = ConvertUtil.ToString(context.Request["value"]);
                string column = ConvertUtil.ToString(context.Request["column"]);
                string StartTime = ConvertUtil.ToString(context.Request["StartTime"]);
                string EndTime = ConvertUtil.ToString(context.Request["EndTime"]);
                if (!string.IsNullOrEmpty(StartTime) && !string.IsNullOrEmpty(EndTime))
                {
                    string sql = @"select T403TA001DATE,T403TA002DATE," + column.Trim().Replace("'", "''") + "_NAME" + " from PROC_403TA where " + column.Replace("'", "''") + "=@value and status = 1";
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, value);
                    if (dt.Rows.Count > 0)
                    {
                        string msgs = string.Empty;
                        string msg = string.Empty;
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (CheckTimeOverlap(ConvertUtil.ToDateTime(StartTime), ConvertUtil.ToDateTime(EndTime), ConvertUtil.ToDateTime(dr["T403TA001DATE"]), ConvertUtil.ToDateTime(dr["T403TA002DATE"])))
                            {
                                msg = "以下时间段(" + dt.Rows[0][column.Trim().Replace("'", "''") + "_NAME"] + ")印章已被借出：\n";
                                msgs += Convert.ToDateTime(dr["T403TA001DATE"]).ToShortDateString() + "-" + Convert.ToDateTime(dr["T403TA002DATE"]).ToShortDateString() + ";";
                            }
                        }
                        msgs = msg + msgs;
                        if (!string.IsNullOrEmpty(msgs))
                            context.Response.Write(msgs);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 判断时间是否重叠
        /// </summary>
        /// <param name="startdate1">新开始</param>
        /// <param name="enddate1">新结束</param>
        /// <param name="startdate2">旧开始</param>
        /// <param name="enddate2">旧结束</param>
        /// <returns></returns>
        public bool CheckTimeOverlap(DateTime startdate1, DateTime enddate1, DateTime startdate2, DateTime enddate2)
        {
            //判断时间不能重叠
            bool isResult = false;
            //if (!(startdate1.CompareTo(enddate2) >= 0 || enddate1.CompareTo(startdate2) <= 0))
            //{
            //    //重合  
            //    isResult = true;
            //}

            // 旧开始 <= 新开始 <= 旧结束
            if (startdate1.CompareTo(startdate2) >= 0 && startdate1.CompareTo(enddate2) <= 0)
            {
                //重合  
                return isResult = true;
            }
            // 旧开始 <= 新结束 <= 旧结束
            if (enddate1.CompareTo(startdate2) >= 0 && enddate1.CompareTo(enddate2) <= 0)
            {
                //重合  
                return isResult = true;
            }
            // 新开始 <= 旧开始 <= 新结束
            if (startdate2.CompareTo(startdate1) >= 0 && startdate2.CompareTo(enddate1) <= 0)
            {
                //重合  
                return isResult = true;
            }
            // 新开始 <= 旧结束 <= 新结束
            if (enddate2.CompareTo(startdate1) >= 0 && enddate2.CompareTo(enddate1) <= 0)
            {
                //重合  
                return isResult = true;
            }
            return isResult;
        }

        ////判断时间是否超出7个自然日
        //public void getTime(HttpContext context)
        //{
        //    try
        //    {
        //        TimeSpan t1 = new TimeSpan(Convert.ToDateTime(this.request["value1"]).Ticks);
        //        TimeSpan t2 = new TimeSpan(Convert.ToDateTime(this.request["value2"]).Ticks);
        //        TimeSpan t3 = t2.Subtract(t1);
        //        if (t3.Days > 6) {
        //            context.Response.Write("借用时间不可超过7个自然日！");
        //        }
        //        else if(t3.Days<0)
        //        {
        //            context.Response.Write("时间选择错误，归还日期需大于借用日期！");
        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //        throw new Exception(ex.Message);
        //    }

        //}


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

}


