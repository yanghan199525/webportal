using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class PrintCirculationUserInfo : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;
            userInfo.AfterLoadData += userInfo_AfterLoadData;
        }
        void userInfo_AfterLoadData(object sender, EventArgs e)
        {
            BindOldReadsRep();
        }
        //绑定历史记录传阅
        void BindOldReadsRep()
        {
            UserInfo userInfo = Page.FindControl("UserInfo1") as UserInfo;

            string strSql = "";
            //if (userInfo.Type != "MYREQUEST" && userInfo.Type != "MYAPPROVAL")
            //{
            //    strSql = string.Format(" select OPINION,READUSERNAME,READER,READFLAG from WF_READS where PROCESSNAME=N'{0}' and INCIDENT='{1}'", userInfo.ProcessName, userInfo.Incident);
            //}
            //else
            //{
            //    string applicant = SessionLogic.GetAccount(SessionLogic.GetLoginName());
            //    strSql = string.Format(" select OPINION,READUSERNAME,READER,READFLAG from WF_READS where PROCESSNAME=N'{0}' and INCIDENT='{1}' and APPLICANT!=N'{2}' ", userInfo.ProcessName, userInfo.Incident, applicant);
            //}
            strSql = string.Format(" select OPINION,READUSERNAME,READER,READFLAG,APPLICANTNAME,STARTTIME from WF_READS where STATUS=1 and PROCESSNAME=N'{0}' and INCIDENT='{1}'", userInfo.ProcessName, userInfo.Incident);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(strSql);
            OldReadsRep.DataSource = dt;
            OldReadsRep.DataBind();
        }
    }
}