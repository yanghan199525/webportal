using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.Sevice
{
    /// <summary>
    /// 自定义流程处理业务逻辑
    /// </summary>
    public class CustomProcessSubscription : ISubscription
    {

        public void CompletedTaskDeleted(string strProcessName, int nIncident, string strTaskId)
        {

        }

        /// <summary>
        /// 任务终止，拒绝
        /// </summary>
        /// <param name="strProcessName">流程名</param>
        /// <param name="nIncident">实例号</param>
        /// <param name="strReason"></param>
        public void IncidentAborted(string strProcessName, int nIncident, string strReason)
        {
            MyLib.LogUtil.Info("IncidentAborted", strProcessName + "Test............");
            try
            {
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                //throw ex;
            }
        }

        /// <summary>
        /// 流程完成事件
        /// </summary>
        /// <param name="strProcessName">流程名</param>
        /// <param name="nIncident">实例号</param>
        public void IncidentCompleted(string strProcessName, int nIncident)
        {
            MyLib.LogUtil.Info("IncidentCompleted", strProcessName + "Test............");
            try
            {
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                //throw ex;
            }
        }

        public void IncidentInitiated(string strProcessName, int nIncident)
        {

        }

        public void QueueTaskActivated(string strProcessName, int nIncident, string strTaskId)
        {

        }

        public void StepAborted(string strProcessName, int nIncident, int nStepType, string strStepId, string strStepLabel)
        {

        }

        /// <summary>
        /// 节点激活事件
        /// </summary>
        /// <param name="strProcessName">流程名</param>
        /// <param name="nIncident">实例号</param>
        /// <param name="nStepType">节点号</param>
        /// <param name="strTaskId">TaskId</param>
        public void TaskActivated(string strProcessName, int nIncident, int nStepType, string strTaskId)
        {
            MyLib.LogUtil.Info("TaskActivated", strProcessName + "Test............");
            try
            {
                if (nStepType == 0) //Begin 节点被激活
                {
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                //throw ex;
            }
        }

        public void TaskAssigned(string strProcessName, int nIncident, string strTaskId, string strAssignedUser)
        {

        }

        /// <summary>
        /// 节点完成事件
        /// </summary>
        /// <param name="strProcessName">流程名</param>
        /// <param name="nIncident">实例号</param>
        /// <param name="nStepType">节点编号</param>
        /// <param name="strTaskId">TaskId</param>
        public void TaskCompleted(string strProcessName, int nIncident, int nStepType, string strTaskId)
        {
            MyLib.LogUtil.Info("TaskCompleted", strProcessName + "Test............");
            try
            {
                if (nStepType == 0) //Begin 完成之后执行的业务逻辑
                {
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                //throw ex;
            }
        }

        public void TaskConferred(string strProcessName, int nIncident, string strTaskId, string strUser)
        {

        }

        public void TaskDelayed(string strProcessName, int nIncident, string strTaskId)
        {

        }

        public void TaskDeletedOnMinResponseComplete(string strProcessName, int nIncident, string strTaskId)
        {

        }

        public void TaskLate(string strProcessName, int nIncident, string strTaskId)
        {

        }

        public void TaskResubmitted(string strProcessName, int nIncident, string strTaskId)
        {

        }

        /// <summary>
        /// 节点退回事件
        /// </summary>
        /// <param name="strProcessName">流程名</param>
        /// <param name="nIncident">实例号</param>
        /// <param name="nStepType">节点编号</param>
        /// <param name="strTaskId">TaskId</param>
        public void TaskReturned(string strProcessName, int nIncident, int nStepType, string strTaskId)
        {
            try
            {

            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                //throw ex;
            }
        }

        public void TaskSubmitFailed(string strTaskId)
        {

        }

        public void TasksPerDayThresholdReached(long lTasksPerDayLimit, long lThreshold)
        {

        }

        public void CheckInTask(string strTaskId)
        {

        }

        public void CheckOutTask(string strTaskId)
        {

        }

        public void FindReplaceIncident(string strProcessName, int nIncident)
        {

        }

        public void FindReplaceTask(string strTaskId)
        {

        }

        public void SaveTask(string strTaskId)
        {

        }

        public void defaultSendEmail(System.Data.DataRow row)
        {

        }
    }
}
