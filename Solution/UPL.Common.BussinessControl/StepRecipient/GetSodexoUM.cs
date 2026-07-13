using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using Ultimus.UWF.Common.SodexoLogic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetSodexoUM : GetRecipient
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
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["orgCode"].ToString() == pccode)
                        {
                            string parentOrgCode = dr["parentOrgCode"].ToString();
                            foreach (DataRow item in dt.Rows)
                            {
                                //CX
                                if (item["orgCode"].ToString() == parentOrgCode)
                                {
                                    if (item["leaderNumber"].ToString() == "")
                                    {


                                        #region 未上线分店
                                        StringBuilder sSql_pc = new StringBuilder();
                                        sSql_pc.AppendFormat(@"SELECT employeeNumber FROM SODEXO_NoOnlineBranch WHERE organizeName='{0}'", pccode);
                                        DataTable dt_NoOnlineBranch = db.ExecuteDataTable(sSql_pc.ToString());
                                        if (dt_NoOnlineBranch.Rows.Count > 0)
                                        {
                                            leaderNumber = dt_NoOnlineBranch.Rows[0][0].ToString();
                                            loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                                            StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
                                        }
                                        #endregion
                                    }
                                    else
                                    {
                                        if (item["leaderNumber"].ToString().Contains(","))
                                        {
                                            string[] leaderNumbers = item["leaderNumber"].ToString().Split(',');

                                            foreach (var leaderNumberStr in leaderNumbers)
                                            {
                                                leaderNumber = leaderNumberStr;
                                                loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                                                StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
                                            }
                                        }
                                        else {
                                            leaderNumber = item["leaderNumber"].ToString();
                                            loginName = new OrgLogic().GetUserLoginNameByEmpNo(leaderNumber);
                                            StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
                                        }


                                    }
                                }
                            }
                            break;
                        }
                    }

                    if (string.IsNullOrEmpty(leaderNumber))
                    {
                        throw new Exception(string.Format("营运点经理获取失败：分店编号{0}，账号为空，请联系管理员！", pccode));
                    }
                    if (string.IsNullOrEmpty(loginName))
                    {
                        throw new Exception(string.Format("营运点经理获取失败：分店编号{0},登录名为空，请联系管理员！", pccode));
                    }
                    StepRecipientUser = !string.IsNullOrEmpty(StepRecipientUser) ? StepRecipientUser.TrimEnd('|') : StepRecipientUser;
                }
            }
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
