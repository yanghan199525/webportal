using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.CPR
{
    public partial class NodalPersonManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptList.Source = "BizDB.SELECT Id,orgCode,leaderNumber,leaderName,createUser,PRO.createDate,USERNAME FROM SODEXO_PROCESSSTEPAPPROVER PRO,ORG_USER USERS WHERE PRO.createUser=USERS.EMPNO";
            }
        }

        [WebMethod]
        public static string DeleteNodalPerson(string NodalPersonID)
        {
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");

            sSql.Length = 0;
            sSql.AppendFormat(@"SELECT orgCode FROM SODEXO_PROCESSSTEPAPPROVER WHERE Id={0}", NodalPersonID);
            string orgCode = db.ExecuteDataTable(sSql.ToString()).Rows[0][0].ToString();
            sSql.Length = 0;
            sSql.AppendFormat(@"UPDATE SODEXO_ORGANIZATION SET leaderNumber='',leaderName=N'' WHERE orgCode='{0}';", orgCode);
            sSql.Append(@"DELETE FROM SODEXO_PROCESSSTEPAPPROVER WHERE Id='" + NodalPersonID + "'");

            int res = DataAccess.Instance("BizDB").ExecuteNonQuery(sSql.ToString());
            if (res > 0)
            {
                return "{\"state\":\"1\"}";
            }
            else
            {
                return "{\"state\":\"0\"}";
            }
        }

        public string JudgmentHandler(string Id)
        {
            //<a class="btn btn-icon btn-sm btn-warning" target="_blank" disabled="disabled" href="NodalPersonDetails.aspx?Type=Edit&NodalPersonID=<%#Eval("Id")%>">编辑</a>
            //<a class="btn btn-icon btn-sm btn-warning" target="_blank" onclick="if(confirm('确认删除此配置？')){deleteNodalPerson('<%#Eval("Id")%>');}return false;">删除</a>

            string url = string.Empty;
            return url;
        }
    }
}