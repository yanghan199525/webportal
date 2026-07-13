using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic
{
    public class sodexoProfitCentersLogic
    {
        /// <summary>
        /// 根据PCCode查询分店名称及公司编号
        /// </summary>
        /// <param name="siteName"></param>
        /// <param name="compCode"></param>
        /// <param name="pcCode"></param>
        public void QuerySiteNameAndCompCode(out string siteName, out string compCode, string pcCode)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat("select cnname,enname,companycode from [dbo].[SODEXO_ProfitCenters] where code='{0}'", pcCode);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            if (dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                siteName = dr["cnname"].ToString();
                compCode = dr["companycode"].ToString();
            }
            else
            {
                siteName = "";
                compCode = "";
            }
        }
    }
}