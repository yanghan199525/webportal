using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.SodexoLogic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetSodexoSD : GetRecipient
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
            //if (string.IsNullOrEmpty(param))
            //{
            //    throw new Exception("获取参数MethodParameters失败,请联系管理员！");
            //}
            //string[] paras = param.Split(',');
            //string DataField = ConvertUtil.ToString(paras[0]);
            //string PostGrades = ConvertUtil.ToString(paras[1]);

            string pccode = ConvertUtil.ToString(bussData.Rows[0]["SITECODE"]);
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
                       
                        if (dr["orgCode"].ToString().StartsWith("ND"))
                        {
                            if (chechDt != null && chechDt.Rows.Count > 0)
                            {
                                var rddata = chechDt.AsEnumerable().Where(r => r["Scope"].ToString() == "ND").Where(x => x["PCCODE"].ToString() == pccode);
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
                         
                                DataTable SODEXO_SegmentDirectorToRD = SdToRd(leaderNumber);
                                if (SODEXO_SegmentDirectorToRD.Rows.Count > 0)
                                {
                                    string rdEmpNo = GetRdLeaderNumber(dt, SODEXO_SegmentDirectorToRD);
                                    if (rdEmpNo != null)
                                    {
                                        leaderNumber = rdEmpNo;
                                        authLog authLog = new authLog
                                        {
                                            siteCode = pccode,
                                            rdEmpNO = leaderNumber,
                                            sdEmpNO = dr["leaderNumber"].ToString(),
                                            DocumentNo= bussData.Rows[0]["FORMID"].ToString()
                                        };
                                        BindAuthLog(authLog);
                                    }
                                }
                            
                            loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                            break;
                        }
                    }

                    if (string.IsNullOrEmpty(rdCode))
                    {
                        throw new Exception(string.Format("事业部总监获取失败：分店编号{0},请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(leaderNumber))
                    {
                        throw new Exception(string.Format("事业部总监获取失败：分店编号{0},事业部总监账号为空，请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(loginName))
                    {
                        throw new Exception(string.Format("事业部总监获取失败：分店编号{0},事业部总监登陆名为空，请联系管理员！", pccode));
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


        /// <summary>
        /// 获取特殊的事业部总监审批放到RD
        /// </summary>
        public DataTable SdToRd(string sdLeaderNumber)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat("select orgCode,startTime,endTime,rdLeaderNumber,sdLeaderNumber,authRange,type from PROC_SDAuth where type=N'已授权/Authorized' AND sdLeaderNumber='{0}'", sdLeaderNumber);
            DataTable SODEXO_SegmentDirectorToRD = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return SODEXO_SegmentDirectorToRD;
        }
        public string GetRdLeaderNumber(DataTable dt, DataTable dr)
        {
            string leaderNumber = null;
            foreach (DataRow dtItem in dt.Rows)
            {
                if (dtItem["orgCode"].ToString().StartsWith("RD"))
                {
                    foreach (DataRow drItem in dr.Rows)
                    {
                        if (dtItem["orgCode"].ToString() == drItem["orgCode"].ToString() && dtItem["leaderNumber"].ToString() == drItem["rdLeaderNumber"].ToString()&& drItem["authRange"].ToString().Contains("单外采购流程审批"))
                        {
                            if (Convert.ToDateTime(drItem["endTime"]) > Convert.ToDateTime(drItem["startTime"])&& Convert.ToDateTime(drItem["endTime"])> DateTime.Now)
                            {
                                leaderNumber= dtItem["leaderNumber"].ToString();
                            }
                        }
                    }
                }
            }
            return leaderNumber;
        }
       public class authLog {
            public string siteCode { get; set; }
            public string sdEmpNO { get; set; }
            public string rdEmpNO { get; set; }
            public string DocumentNo { get; set; }
        }
        public string GetCnname(string empNo) {
            string sql = string.Format("select cnname from org_user where empno='{0}'",empNo);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["cnname"].ToString();
            }
            else {
                return null;
            }
           
        }
        public void BindAuthLog(authLog log) {
            string rdName = GetCnname(log.rdEmpNO);
            string sdName= GetCnname(log.sdEmpNO);
            string sql = string.Format("insert into PROC_AUTH_LOG values(NEWID(),'{0}',N'{1}',N'{2}','{3}','{4}','{5}')",log.siteCode,sdName,rdName,log.sdEmpNO,log.rdEmpNO,log.DocumentNo);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
        }
    }
}