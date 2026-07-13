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
    public class GetSodexoSourcingDirector : GetRecipient 
    {
        /// <summary>
        /// 获取sodexo食品采购总监
        /// </summary>
        /// <param name="bussData"></param>
        /// <param name="stepConfig"></param>
        /// <returns></returns>
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            string param = stepConfig.MethodParameters.Trim();
            string processName = stepConfig.Process;

            //string BatchNo = ConvertUtil.ToString(bussData.Rows[0]["BatchNo"]);
            //string str = BatchNo.Substring(BatchNo.Length - 4, 1);
            //string processName= string.Empty;
            //switch (str)
            //{
            //    case "1":
            //        processName = "CPR_FOOD";
            //        break;
            //    case "2":
            //        processName = "CPR_NONFOOD";
            //        break;
            //    case "3":
            //        processName = "CPR_SERVICE";
            //        break;
            //    default:
            //        break;
            //}

            if (bussData.Rows.Count > 0)
            {
                StringBuilder sSql = new StringBuilder();
                DataAccess db = DataAccess.Instance("BizDB");
                DataTable dt = new DataTable();
                sSql.Append(@"
select * from PROC_PROCESSSTEPAPPROVER where ProcessName=@processName and StepName=@StepName
");
                using (DbCommand cmd = db.CreateCommand())
                {
                    cmd.CommandText = sSql.ToString();
                    cmd.CommandType = CommandType.Text;

                    db.AddInParameter(cmd, "@StepName", DbType.String, stepConfig.StepName);
                    db.AddInParameter(cmd, "@processName", DbType.String, processName);
                    dt = db.ExecuteDataTable(cmd);
                }

                string domain = "CustomOC";
                OrgLogic OrgLogic = new OrgLogic();
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
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
                    throw new Exception(string.Format("采购总监审批人获取失败,请联系管理员！"));
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