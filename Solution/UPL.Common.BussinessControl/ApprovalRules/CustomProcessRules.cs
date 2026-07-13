using MyLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace UPL.Common.BussinessControl.ApprovalRules
{
    public class CustomProcessRules
    {
        /// <summary>
        /// 自定义流程添加流程变量
        /// </summary>
        /// <param name="isCreateForm">是否新建表单</param>
        /// <param name="formID">单据Guid</param>
        /// <param name="StepName">步骤名</param>
        /// <param name="vars">流程变量</param>
        public void CustomProcessA(bool isCreateForm, string formID, string StepName, ref Hashtable vars)
        {
            if (isCreateForm)
            {
                vars.Remove("Rule_ProcessGo");
                vars.Add("Rule_ProcessGo", "申请人");
            }
            else
            {
                string rowId = StepName.Replace("审核人", "");
                if (!string.IsNullOrEmpty(rowId))
                {
                    vars.Remove("Rule_ProcessGo");
                    int num = ConvertUtil.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar("select count(*) from PROC_CUSTOMPROCESS_DT where formid=@formid AND ROWNO=@ROWNO "
                        , ConvertUtil.ToString(formID).Trim(), (Convert.ToInt32(rowId) + 1)));

                    if (num > 0)
                        vars.Add("Rule_ProcessGo", "审核人" + rowId);
                    else
                        vars.Add("Rule_ProcessGo", "完成");
                }
            }
        }
    }
}
