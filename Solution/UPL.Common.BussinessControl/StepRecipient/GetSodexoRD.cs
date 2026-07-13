using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.SodexoLogic;
using Ultimus.UWF.Workflow.Interface;
using UPL.Common.BussinessControl.StepRecipient;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetSodexoRD : GetRecipient
    {
        /// <summary>
        /// 获取部门负责人20、分管副总30、总经理40等
        /// </summary>
        /// <param name="bussData"></param>
        /// <param name="stepConfig"></param>
        /// <returns></returns>
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            string param = stepConfig.MethodParameters.Trim();

            string pccode = ConvertUtil.ToString(bussData.Rows[0]["SITECODE"]);
            string processName = stepConfig.Process;
            if (bussData.Rows.Count > 0)
            {
                StringBuilder sSql = new StringBuilder();
                DataAccess db = DataAccess.Instance("BizDB");
                DataTable dt = new DataTable();
                sSql.Append(@"
  WITH locs(parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail)
AS
(
SELECT parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail FROM SODEXO_ORGANIZATION WHERE orgcode=@orgcode
UNION ALL
SELECT A.parentOrgCode,A.parentOrgName,A.orgCode,A.orgName,A.orgType,A.leaderNumber,A.leaderName,A.orgStartDate,A.orgEndDate,A.siteCode,A.companyCode,A.isDeploy,A.deployDate,A.modifyDate,A.orgAddress,A.siteEmail,A.leaderContact,A.leaderEmail FROM SODEXO_ORGANIZATION A,locs B WHERE
A.orgCode = B.PARENTORGCODE
)
select  parentOrgCode,parentOrgName,orgCode,orgName,orgType,leaderNumber,leaderName,orgStartDate,orgEndDate,siteCode,companyCode,isDeploy,deployDate,modifyDate,orgAddress,siteEmail,leaderContact,leaderEmail from locs 
");
                using (DbCommand cmd = db.CreateCommand())
                {
                    cmd.CommandText = sSql.ToString();
                    cmd.CommandType = CommandType.Text;

                    db.AddInParameter(cmd, "@orgcode", DbType.String, pccode);
                    dt = db.ExecuteDataTable(cmd);
                }

                string rdCode = string.Empty;
                string leaderNumber = string.Empty;
                string loginName = string.Empty;
                string domain = "CustomOC";
               
                if (dt != null && dt.Rows.Count > 0)
                {
                    var chechDt = DoSpecialProcessed.GetEmpnoByPCCode(pccode);
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (processName.ToUpper() == "PO_AMENDMENT" && CheackPC(pccode)) {
                            if (dr["orgCode"].ToString().StartsWith("AM"))
                            {
                                rdCode = dr["orgCode"].ToString();
                                leaderNumber = dr["leaderNumber"].ToString();
                                loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                                break;
                            }
                        }
                       
                            if (dr["orgCode"].ToString().StartsWith("RD"))
                            {
                               if (chechDt != null && chechDt.Rows.Count > 0)
                               {
                                var rddata = chechDt.AsEnumerable().Where(r=>r["Scope"].ToString()=="RD").Where(x=>x["PCCODE"].ToString()== pccode);                            
                               if (rddata != null && rddata.Any())
                                {
                                    leaderNumber = rddata.FirstOrDefault()["EMPNO"].ToString();
                                    rdCode = dr["orgCode"].ToString();
                                    loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                                    break;
                                }
                               }
                            
                                rdCode = dr["orgCode"].ToString();
                                leaderNumber = dr["leaderNumber"].ToString();
                                loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                                break;
                            
                               
                            }
                        if (dr["orgCode"].ToString() == "SCCN") break;
                    }

                    if (string.IsNullOrEmpty(rdCode))
                    {
                        throw new Exception(string.Format("区域总监获取失败：分店编号{0},请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(leaderNumber))
                    {
                        throw new Exception(string.Format("区域总监获取失败：分店编号{0},区域总监员工号为空，请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(loginName))
                    {
                        throw new Exception(string.Format("区域总监获取失败：分店编号{0},区域总监登录名为空，请联系管理员！", pccode));
                    }
                    StepRecipientUser = "USER:org=" + domain + ",user=" + string.Format("{0}/{1}", domain, loginName);
                }
            }
            else
            {
                throw new Exception("业务数据为空，请联系管理员");
            }
            return StepRecipientUser;

        }

        public override string Execute(DataTable bussData, string methodParameters)
        {
            //暂时不用
            return "";
        }
        public bool CheackPC(string pccode) {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt =db.ExecuteDataTable(string.Format("SELECT PCCODE FROM PROC_PO_PCCODETOAM WHERE PCCODE='{0}'",pccode));
            return dt.Rows.Count>0;
        }

        public DataTable CheackCX(string cxcode)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = db.ExecuteDataTable(string.Format("SELECT CXCODE,EMPNO,Scope,PCCODE FROM PROC_ALL_CXTORD WHERE CXCODE='{0}'", cxcode));
            return dt;
        }
        public DataTable GetOrg(string leaderNumber)
        {
            DataAccess db = DataAccess.Instance("BizDB");
            DataTable dt = db.ExecuteDataTable(string.Format("SELECT orgCode ,leaderNumber,orgName FROM SODEXO_ORGANIZATION leaderNumber ='{0}'", leaderNumber));
            return dt;
        }
        //public void InitMethodParameters(string _Parameters)
        //{
        //}
    }
}