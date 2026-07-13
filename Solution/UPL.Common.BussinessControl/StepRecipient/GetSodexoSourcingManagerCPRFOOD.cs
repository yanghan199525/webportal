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
    public class GetSodexoSourcingManagerCPRFOOD : GetRecipient
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

            string compCode = ConvertUtil.ToString(bussData.Rows[0]["PCCOMPCODE"]);
            //string familyCode = string.Empty;
            string supplerCode = ConvertUtil.ToString(bussData.Rows[0]["SUPPLIERCODE"]);
            StringBuilder sSql = new StringBuilder();
            DataAccess db = DataAccess.Instance("BizDB");

            if (bussData.Rows.Count > 0)
            {
                sSql.Length = 0;
                //DataAccess db = DataAccess.Instance("BizDB");
                DataSet ds = new DataSet();
                sSql.Append(@"
select APPROVER from PROC_PROCESSSTEPAPPROVER where ProcessName=@processName and StepName=@StepName and ext01=@compCode and ext02='';
select APPROVER from PROC_PROCESSSTEPAPPROVER where ProcessName=@processName and StepName=@StepName  and ext02=@supplerCode;
");
                using (DbCommand cmd = db.CreateCommand())
                {
                    cmd.CommandText = sSql.ToString();
                    cmd.CommandType = CommandType.Text;

                    db.AddInParameter(cmd, "@compCode", DbType.String, compCode);
                    db.AddInParameter(cmd, "@StepName", DbType.String, stepConfig.StepName);
                    db.AddInParameter(cmd, "@supplerCode", DbType.String, supplerCode);
                    db.AddInParameter(cmd, "@processName", DbType.String, stepConfig.Process);
                    ds = db.ExecuteDataSet(cmd);
                }

                string domain = "CustomOC";
                DataTable ApproverWithOutFamilyCodeDt = ds.Tables[0];
                DataTable ApproverWithFamilyCodeDt = ds.Tables[1];
                OrgLogic OrgLogic = new OrgLogic();
                if (ApproverWithFamilyCodeDt.Rows.Count > 0)
                {
                    foreach (DataRow dr in ApproverWithFamilyCodeDt.Rows)
                    {
                        if (!string.IsNullOrEmpty(dr["APPROVER"].ToString()))
                        {
                            string loginName = OrgLogic.GetUserLoginNameByEmpNo(dr["APPROVER"].ToString());
                            if (!string.IsNullOrEmpty(loginName))
                            {
                                StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
                            }
                        }
                    }
                    StepRecipientUser = !string.IsNullOrEmpty(StepRecipientUser) ? StepRecipientUser.TrimEnd('|') : StepRecipientUser;
                }
                else
                {
                    if (ApproverWithOutFamilyCodeDt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in ApproverWithOutFamilyCodeDt.Rows)
                        {
                            if (!string.IsNullOrEmpty(dr["APPROVER"].ToString()))
                            {
                                string loginName = OrgLogic.GetUserLoginNameByEmpNo(dr["APPROVER"].ToString());
                                if (!string.IsNullOrEmpty(loginName))
                                {
                                    StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, loginName));
                                }
                            }
                        }
                        StepRecipientUser = !string.IsNullOrEmpty(StepRecipientUser) ? StepRecipientUser.TrimEnd('|') : StepRecipientUser;
                    }
                    else
                    {
                        throw new Exception(string.Format("采购经理审批人不存在：分店编号{0}请联系管理员！", ConvertUtil.ToString(bussData.Rows[0]["SITECODE"])));
                    }
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