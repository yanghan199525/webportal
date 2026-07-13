using MyLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ultimus.UWF.Common.Interface;
using System.Data;

namespace UPL.Common.BussinessControl.SubmitEvent
{
    public class CustomProcessSubEvent
    {
        public void SubEvent(bool isCreateForm, string formID, string StepName, string documentNo, int actionType, string returnStep, string SubmitType, string type)
        {
            if (SubmitType == "AfterSubmit")
            {
                AfterSubmit(isCreateForm, formID, StepName, documentNo, actionType, returnStep, type);
            }
            else
            {
                BeforeSubmit(isCreateForm, formID, StepName, documentNo, actionType, returnStep, type);
            }
        }

        /// <summary>
        /// 提交前触发的事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BeforeSubmit(bool isCreateForm, string formID, string StepName, string documentNo, int actionType, string returnStep, string type)
        {
            try
            {
                
                
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 提交后触发的事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AfterSubmit(bool isCreateForm, string formID, string StepName, string documentNo, int actionType, string returnStep, string type)
        {
            try
            {
                //if (isCreateForm && (type.ToUpper() == "DRAFT" || type.ToUpper() == "NEWREQUEST"))
                //{
                //    ISerialNo sn = MyLib.ServiceContainer.Instance().GetService<ISerialNo>();
                //    string No = string.Format("{0}{1}",
                //       DateTime.Now.ToString("yy"),
                //       sn.GetSerialNo("MROT003TA020", DateTime.Now.Year, 0, 0).ToString().PadLeft(6, '0'));
                //    string sql = @"update PROC_003TA set T003TA020=N'" + No + "',DOCUMENTNO=N'" + No + "' WHERE FORMID='" + formID + "'";
                //    DataAccess.Instance("BizDB").ExecuteNonQuery(sql);

                //    string str = @"select * from PROC_003TA where FORMID = @FORMID";
                //    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(str, formID);
                //    if (dt !=null && dt.Rows.Count > 0)
                //    {
                //        string applicant = ConvertUtil.ToString(dt.Rows[0]["APPLICANT"]);
                //        string loginname = ConvertUtil.ToString(dt.Rows[0]["APPLICANTACCOUNT"]);
                //        string summary = ConvertUtil.ToString(dt.Rows[0]["PROCESSSUMMARY"]);
                //        string destSummary = "{documentNo:\"" + No.Replace("\\", "/") + "\",applicant:\"" + applicant.Replace("\\", "/") + "\",loginname:\"" + loginname.Replace("\\", "/") + "\",summary:\"" + summary.Replace("\\", "/") + "\"}";
                //        string PROCESSNAME = ConvertUtil.ToString(dt.Rows[0]["PROCESSNAME"]);
                //        string INCIDENT = ConvertUtil.ToString(dt.Rows[0]["INCIDENT"]);
                //        sql = @"update incidents set SUMMARY=@SUMMARY where PROCESSNAME=@PROCESSNAME and INCIDENT=@INCIDENT";
                //        DataAccess.Instance("UltDB").ExecuteNonQuery(sql, destSummary, PROCESSNAME, INCIDENT);
                //    }
                //}
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                throw new Exception(ex.Message);
            }
        }

    }
}
