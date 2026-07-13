using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MyLib;
namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public static class GetDay
    {
        /// <summary>
        /// 获取停滞天数
        /// </summary>
        /// <param name="processName">流程名称</param>
        /// <param name="incident">实例号</param>
        /// <returns></returns>
        public static int GetStagnationDays(string processName, string incident)
        {
            int day=0;
            string sql = "select datediff(DAY,STARTTIME,GETDATE()) as daysum from TASKS where status=1 and PROCESSNAME=@PROCESSNAME and INCIDENT=@INCIDENT";
            object obj= DataAccess.Instance("UltDB").ExecuteScalar(sql, processName, incident);
            if (obj != null)
            {
                 day = Convert.ToInt32(obj);
            }
            
            return day;
        }
    }
}