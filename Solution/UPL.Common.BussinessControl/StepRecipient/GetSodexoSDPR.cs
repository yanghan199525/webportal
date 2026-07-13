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
    public class GetSodexoSDPR : GetRecipient
    {
        /// <summary>
        /// 获取部门负责人20、分管副总30、总经理40(单内流程使用)
        /// </summary>
        /// <param name="bussData"></param>
        /// <param name="stepConfig"></param>
        /// <returns></returns>
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            string param = stepConfig.MethodParameters.Trim();     //
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
                            loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                            break;
                        }
                    }

                    if (string.IsNullOrEmpty(rdCode))
                    {
                        throw new Exception(string.Format("事业部总监(单内流程)获取失败：分店编号{0},请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(leaderNumber))
                    {
                        throw new Exception(string.Format("事业部总监(单内流程)获取失败：分店编号{0},事业部总监账号为空，请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(loginName))
                    {
                        throw new Exception(string.Format("事业部总监(单内流程)获取失败：分店编号{0},事业部总监登陆名为空，请联系管理员！", pccode));
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
        public DataTable SdToRd()
        {
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT * FROM SODEXO_SegmentDirectorToRD");
            DataTable SODEXO_SegmentDirectorToRD = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return SODEXO_SegmentDirectorToRD;
        }
    }
}