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
    public partial class ExceptionNodalPerson : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptList.Source = "BizDB.SELECT TOP 20000 parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName FROM SODEXO_ORGANIZATION WHERE leaderNumber IN(SELECT leaderNumber FROM SODEXO_ORGANIZATION GROUP BY leaderNumber HAVING leaderNumber NOT IN (SELECT employeeNumber FROM SODEXO_EMPLOYEE GROUP BY employeeNumber)) AND orgCode NOT LIKE '%CN%' ORDER BY orgCode";
            }
        }
    }
}