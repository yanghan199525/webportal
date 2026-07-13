using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Dao;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetSuperiorDepartmentManager : GetRecipient
    {
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string user = string.Empty;
            try
            {
                StepRecipientDao dao = new StepRecipientDao();
                string[] paras = stepConfig.MethodParameters.Split(',');
                string deptfield = paras[0];
                int level = ConvertUtil.ToInt32( paras[1]);

                string deptId = bussData.Rows[0][deptfield].ToString();

                deptId = dao. GetParentDeptID(deptId, level);
                string account = "";
                string jobfunction = "";
                //获取不到上级部门。
                if (string.IsNullOrEmpty(deptId))
                {
                    user = "SkipStep";
                    return user;
                }
                user = dao.GetDepartmentManager(deptId, out account, out jobfunction);
                if (String.IsNullOrEmpty(user))
                {
                    user = "SkipStep";
                    return user;
                }

                //如果发起人等于部门负责人，那么找上一层部门负责人
                if (ConvertUtil.ToString(bussData.Rows[0]["APPLICANTACCOUNT"]).Equals(account.Replace("/", "\\")))
                {
                    deptId = dao.GetParentDeptID(deptId, level + 1);
                    //获取不到上级部门。
                    if (string.IsNullOrEmpty(deptId))
                    {
                        user = "SkipStep";
                        return user;
                    }
                    user = dao.GetDepartmentManager(deptId, out account, out jobfunction);
                    if (String.IsNullOrEmpty(user))
                    {
                        user = "SkipStep";
                        return user;
                    }
                }

            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                throw ex;
            }
            return user;
        }

        

        public override string Execute(DataTable bussData, string methodParameters)
        {
            throw new NotImplementedException();
        }


    }
}