using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using MyLib;

namespace UPL.Common.BussinessControl.SubmitEvent
{
    public class ProcessSubmitEvent
    {
        /// <summary>
        /// 提交事件
        /// </summary>
        /// <param name="formData">表单数据</param>
        /// <param name="vars">流程变量</param>
        /// <param name="users">流程审批人变量</param>
        /// <param name="loginname">登录用户账号</param>
        /// <param name="applicant"></param>
        /// <param name="taskID">Task ID</param>
        /// <param name="processName">流程名</param>
        /// <param name="incident">实例号</param>
        /// <param name="stepName">步骤名</param>
        /// <param name="tableName">对应的表名</param>
        /// <param name="formID">单据Guid</param>
        /// <param name="prefix">前缀</param>
        /// <param name="isCreateForm">是否新建表单</param>
        /// <param name="type">类型:MyTask,NewRequest等</param>
        /// <param name="summary">流程摘要</param>
        /// <param name="actionType">操作类型 0同意 1退回 2拒绝 3选择性退回</param>
        /// <param name="returnStep">选择性退回的步骤</param>
        /// <param name="comments">审批意见</param>
        /// <param name="error">错误信息</param>
        /// <param name="documentNo">流程单号</param>
        public bool SubmitEvent(DataSet formData, ref Hashtable vars, ref Hashtable users, string loginname, string applicant, string taskID, string processName,
            int incident, string stepName, string tableName, string formID, string prefix, bool isCreateForm, string type, string summary,
            int actionType, string returnStep, string comments, ref string error, string documentNo, string SubmitType)
        {
            bool isResult = false;
            try
            {
                switch (processName)
                {
                    case "自定义流程":
                        CustomProcessSubEvent CustomSub = new CustomProcessSubEvent();
                        CustomSub.SubEvent(isCreateForm, formID, stepName, documentNo, actionType, returnStep, SubmitType, type);
                        break;
                    default:
                        break;
                }
                isResult = true;
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
            return isResult;

        }
    }
}
