using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.SodexoLogic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetSodexoSegmentHead : GetRecipient
    {
        /// <summary>
        ///
        /// </summary>
        /// <param name="bussData"></param>
        /// <param name="stepConfig"></param>
        /// <returns></returns>
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            string param = stepConfig.MethodParameters.Trim();

            //string compCode = ConvertUtil.ToString(bussData.Rows[0]["PCCOMPCODE"]);
            //string processName = stepConfig.Process;
            string pccode = ConvertUtil.ToString(bussData.Rows[0]["SITECODE"]);
            //string isCOR = ConvertUtil.ToString(bussData.Rows[0]["ISCOR"]);
            //var isCORNEW = false;
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
                   // var chechDt = DoSpecialProcessed.GetEmpnoByPCCode(pccode);
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["orgCode"].ToString().ToUpper().StartsWith("DH"))
                        {
                            rdCode = dr["orgCode"].ToString();
                            leaderNumber = dr["leaderNumber"].ToString();
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
            //if (isCOR == "0")
            //{
            //    isCORNEW = GetSodexoSD_Head.IsCORNEW(pccode);
            //}
            //if (bussData.Rows.Count > 0)
            //{
            //    if (isCOR == "1" || isCORNEW)
            //    {
            //        StringBuilder sSql = new StringBuilder();
            //        DataAccess db = DataAccess.Instance("BizDB");
            //        DataTable dt = new DataTable();
            //        sSql.Append(string.Format(@" WITH locs(
            //            parentOrgCode, parentOrgName, orgCode, 
            //            orgName, orgType, leaderNumber, leaderName, 
            //            orgStartDate, orgEndDate, siteCode, 
            //            companyCode, isDeploy, deployDate, 
            //            modifyDate, orgAddress, siteEmail, 
            //            leaderContact, leaderEmail) AS (
            //            SELECT 
            //              parentOrgCode, 
            //              parentOrgName, 
            //              orgCode, 
            //              orgName, 
            //              orgType, 
            //              leaderNumber, 
            //              leaderName, 
            //              orgStartDate, 
            //              orgEndDate, 
            //              siteCode, 
            //              companyCode, 
            //              isDeploy, 
            //              deployDate, 
            //              modifyDate, 
            //              orgAddress, 
            //              siteEmail, 
            //              leaderContact, 
            //              leaderEmail 
            //            FROM 
            //              SODEXO_ORGANIZATION 
            //            WHERE 
            //              orgcode = '{0}' 
            //            UNION ALL 
            //            SELECT 
            //              A.parentOrgCode, 
            //              A.parentOrgName, 
            //              A.orgCode, 
            //              A.orgName, 
            //              A.orgType, 
            //              A.leaderNumber, 
            //              A.leaderName, 
            //              A.orgStartDate, 
            //              A.orgEndDate, 
            //              A.siteCode, 
            //              A.companyCode, 
            //              A.isDeploy, 
            //              A.deployDate, 
            //              A.modifyDate, 
            //              A.orgAddress, 
            //              A.siteEmail, 
            //              A.leaderContact, 
            //              A.leaderEmail 
            //            FROM 
            //              SODEXO_ORGANIZATION A, 
            //              locs B 
            //            WHERE 
            //              A.orgCode = B.PARENTORGCODE) 
            //          select 
            //            o.LOGINNAME 
            //          from 
            //            locs l 
            //            inner join PROC_PROCESSSTEPAPPROVER_COO c on l.orgCode = c.ND 
            //            and l.orgCode like 'ND%' 
            //            inner join ORG_USER o on c.EMPNO = o.EMPNO", pccode));
            //        dt = db.ExecuteDataTable(sSql.ToString());

            //        string domain = "CustomOC";
            //        OrgLogic OrgLogic = new OrgLogic();

            //        if (dt != null && dt.Rows.Count > 0)
            //        {
            //            var chechDt = DoSpecialProcessed.GetEmpnoByPCCode(pccode);
            //            var loginName = "";
            //            foreach (DataRow dr in dt.Rows)
            //            {
            //                if (chechDt != null && chechDt.Rows.Count > 0)
            //                {
            //                    var oD = chechDt.AsEnumerable().Where(r => r["Scope"].ToString() == "Chief Operation Office").Where(x => x["PCCODE"].ToString() == pccode);
            //                    if (oD != null && oD.Any())
            //                    {
            //                        var leaderNumber = oD.FirstOrDefault()["EMPNO"].ToString();
            //                        loginName = OrgLogic.GetUserLoginNameByEmpNo(leaderNumber);
            //                        if (!string.IsNullOrEmpty(loginName))
            //                        {
            //                            StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
            //                            break;
            //                        }

            //                    }
            //                }
            //                loginName = dt.AsEnumerable().FirstOrDefault()["LOGINNAME"].ToString();
            //                if (!string.IsNullOrEmpty(loginName))
            //                {
            //                    StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
            //                }
            //            }
            //            StepRecipientUser = !string.IsNullOrEmpty(StepRecipientUser) ? StepRecipientUser.TrimEnd('|') : StepRecipientUser;
            //        }
            //        else
            //        {
            //            throw new Exception(string.Format("获取事业部负责人失败：分店编号{0},请联系管理员！", ConvertUtil.ToString(bussData.Rows[0]["SITECODE"])));
            //        }


            //    }
            //    else
            //    {
            //        StringBuilder sSql = new StringBuilder();
            //        DataAccess db = DataAccess.Instance("BizDB");
            //        DataTable dt = new DataTable();
            //        sSql.Append(@"select * from PROC_PROCESSSTEPAPPROVER where ProcessName=@processName and StepName=@StepName");
            //        using (DbCommand cmd = db.CreateCommand())
            //        {
            //            cmd.CommandText = sSql.ToString();
            //            cmd.CommandType = CommandType.Text;

            //            db.AddInParameter(cmd, "@StepName", DbType.String, stepConfig.StepName);
            //            db.AddInParameter(cmd, "@processName", DbType.String, stepConfig.Process);
            //            dt = db.ExecuteDataTable(cmd);
            //        }

            //        string domain = "CustomOC";
            //        OrgLogic OrgLogic = new OrgLogic();
            //        if (dt != null && dt.Rows.Count > 0)
            //        {
            //            var chechDt = DoSpecialProcessed.GetEmpnoByPCCode(pccode);
            //            foreach (DataRow dr in dt.Rows)
            //            {
            //                if (chechDt != null && chechDt.Rows.Count > 0)
            //                {
            //                    var segmentHead = chechDt.AsEnumerable().Where(r => r["Scope"].ToString() == "SegmentHead").Where(x => x["PCCODE"].ToString() == pccode);
            //                    if (segmentHead != null && segmentHead.Any())
            //                    {
            //                        var leaderNumber = segmentHead.FirstOrDefault()["EMPNO"].ToString();
            //                        var loginName = OrgLogic.GetUserLoginNameByEmpNo(leaderNumber);
            //                        if (!string.IsNullOrEmpty(loginName))
            //                        {
            //                            StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
            //                            break;
            //                        }

            //                    }
            //                }
            //                if (!string.IsNullOrEmpty(dr["APPROVER"].ToString()))
            //                {
            //                    string loginName = OrgLogic.GetUserLoginNameByEmpNo(dr["APPROVER"].ToString());
            //                    if (!string.IsNullOrEmpty(loginName))
            //                    {
            //                        StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
            //                    }
            //                }
            //                StepRecipientUser = !string.IsNullOrEmpty(StepRecipientUser) ? StepRecipientUser.TrimEnd('|') : StepRecipientUser;
            //            }
            //        }
            //        else
            //        {
            //            throw new Exception(string.Format("获取事业部负责人失败：分店编号{0},请联系管理员！", ConvertUtil.ToString(bussData.Rows[0]["SITECODE"])));
            //        }
            //    }
            //}
            else
            {
                throw new Exception("业务数据为空，请联系管理员");
            }
            return StepRecipientUser;

        }



        private string FormatUltimusUser(string domain, string userCode)
        {
            return string.Format("USER:org={0},user={0}/{1}", domain, userCode);
        }

        public override string Execute(DataTable bussData, string methodParameters)
        {
            //暂时不用
            return "";
        }


    }
}