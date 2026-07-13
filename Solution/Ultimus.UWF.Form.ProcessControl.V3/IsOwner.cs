using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using MyLib;
namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public class IsOwner
    {
        /// <summary>
        /// 查询owenr
        /// </summary>
        /// <param name="processName">流程名称</param>
        /// <param name="loginName">登录账号</param>
        /// <returns></returns>
        public bool IsYes(string processName, string loginName)
        {
            bool isOK = IsAdmin(loginName);

            if (isOK)//是管理员直接返回;
            {
                return true;
            }

            DataTable dt = new DataTable();
            string sql = "select PROCESSOWNER from WF_PROCESS where PROCESSNAME =@PROCESSNAME";
            string owenr = MyLib.DataAccess.Instance("BizDB").ExecuteScalar(sql, processName).ToString();

            if (!string.IsNullOrEmpty(owenr))
            {
                sql = @"select LOGINNAME from ORG_GROUP a inner
                 join ORG_GROUPMEMBER b on a.GROUPID = b.GROUPID
                 join V_ORG_USER c on b.MEMBERID = c.USERID
                 where GROUPNAME =@GROUPNAME and LOGINNAME =@LOGINNAME";

                dt = MyLib.DataAccess.Instance("BizDB").ExecuteDataTable(sql, owenr, loginName);
            }
            if (dt.Rows.Count>0)
            {
                isOK = true;
            }

            return isOK;
        }



        /// <summary>
        /// 是否管理员
        /// </summary>
        /// <param name="loginName"></param>
        /// <returns></returns>
        private bool IsAdmin(string loginName)
        {
            string sql = @"select LOGINNAME from ORG_GROUP a inner
                 join ORG_GROUPMEMBER b on a.GROUPID = b.GROUPID
                 join V_ORG_USER c on b.MEMBERID = c.USERID
                 where GROUPNAME =@GROUPNAME and LOGINNAME =@LOGINNAME";

            DataTable dt = MyLib.DataAccess.Instance("BizDB").ExecuteDataTable(sql, "Admin", loginName);
            if (dt.Rows.Count>0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}