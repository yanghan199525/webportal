using MyLib;
using System;
using System.Data;
using Ultimus.UWF.Workflow.Entity;


namespace UPL.Common.BussinessControl.StepRecipient
{
    public class Get_QunBenBuRenBen_Fin : GetRecipient
    {
        public override string Execute(DataTable bussData, string methodParameters)
        {
            //暂时不用
            return "";
        }
        /// <summary>
        /// 获取群本部人本(财务流程)
        /// </summary>
        /// <param name="bussData"></param>
        /// <param name="stepConfig"></param>
        /// <returns></returns>
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            string NoApproverToOperate = string.Empty;
            string TableName = string.Empty;
            string[] strColumns = null;
            string[] strTables = null;
            try
            {
                if (stepConfig != null)
                {
                    //多表截取，若是主表则传值MainTable
                    strTables = stepConfig.MethodParameters.Split('&');
                    NoApproverToOperate = stepConfig.Ext10;
                }

                if (bussData != null && bussData.Rows.Count > 0)
                {
                    DataTable dt = new DataTable();
                    var login = ConvertUtil.ToString(bussData.Rows[0]["APPLICANTACCOUNT"]).Replace("CustomOC\\", "");
                    if (login != null)
                    {
                        string sql = @"select d.* from org_user u,ORG_DEPARTMENT d  
                        where loginname=@login and d.ext02=u.ext04";
                        dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql, login);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            //获取群本部顶汇下面部门功能别为HR部门主管
                            string sql2 = @"select U.* from V_ORG_USER U,
                                (Select S.* from ORG_DEPARTMENT S,ORG_DEPARTMENT E where s.PARENTID=e.DEPARTMENTID and e.EXT02='A00000000000000' and S.EXT12='HR') C
                                where U.EMPNO=C.EXT05";
                            DataTable dt_user = DataAccess.Instance("BizDB").ExecuteDataTable(sql2);
                            if (dt_user != null && dt_user.Rows.Count > 0)
                            {
                                string DOMAIN = ConvertUtil.ToString(dt_user.Rows[0]["DOMAIN"]);
                                string ACCOUNT = ConvertUtil.ToString(dt_user.Rows[0]["ACCOUNT"]);
                                CommonHelp com = new CommonHelp();
                                //排除组里面的人
                                if (com.GetGroupBYLoginName("GYL-001", DOMAIN + "/" + ACCOUNT) || ACCOUNT.ToLower() == login.ToLower())
                                {
                                    StepRecipientUser = "SkipStep";
                                }
                                else
                                {
                                    StepRecipientUser += "USER:org=" + DOMAIN + ",user=" + DOMAIN + "/" + ACCOUNT + "|";
                                }
                            }
                        }
                    }
                }
                StepRecipientUser = StepRecipientUser.TrimEnd('|');
                if (string.IsNullOrEmpty(StepRecipientUser))
                {
                    switch (NoApproverToOperate)
                    {
                        case "Skip":
                            StepRecipientUser = "SkipStep";
                            break;
                        case "Hold Up":
                            throw new Exception("获取群本部人本失败，请联系管理员或表单重新选择对应审批人！");
                        case "System User":
                            StepRecipientUser = "System User";
                            break;
                        default:
                            throw new Exception("获取群本部人本失败，请联系管理员或表单重新选择对应审批人！");
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                throw new Exception("获取群本部人本审批人失败:" + ex.Message);
            }
            return StepRecipientUser;
        }

    }
}
