using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace UPL.Common.BussinessControl.StepRecipient
{
  public  class DoSpecialProcessed
    {
        public static bool CheackPC(string pccode)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = db.ExecuteDataTable(string.Format("SELECT PCCODE FROM PROC_PO_PCCODETOAM WHERE PCCODE='{0}'", pccode));
            return dt.Rows.Count > 0;
        }

        public static DataTable GetEmpnoByPCCode(string pccode)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = db.ExecuteDataTable(string.Format("SELECT CXCODE,EMPNO,Scope,PCCODE FROM PROC_ALL_CXTORD WHERE PCCODE='{0}'", pccode));
            return dt;
        }

        public static DataTable GetDirector(string sourcingMgr)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = db.ExecuteDataTable(string.Format("SELECT TOP 1 [SOURCINGMGR] ,[SOURCINGDIRECTOR] FROM [dbo].[PROC_SOURCININFO] WHERE SOURCINGMGR='{0}'", sourcingMgr));
            return dt;
        }
    }
}
