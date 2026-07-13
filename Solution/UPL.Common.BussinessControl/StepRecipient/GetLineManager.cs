using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetLineManager : GetRecipient
    {
        public override string Execute(DataTable bussData, string methodParameters)
        {
            string StepRecipientUser = string.Empty;
            try
            {
                if (string.IsNullOrEmpty(methodParameters))
                {
                    methodParameters = base.MethodParameters;
                }

                if (bussData != null && bussData.Rows.Count > 0)
                {
                    string[] arrPara = methodParameters.Split(';');

                    string ext01 = bussData.Rows[0][arrPara[0]].ToString();
                    string domain = SessionLogic.GetDomain(ext01);
                    UserEntity curr = _Org.GetUserEntity( ext01);
                    if (curr != null && curr.USERID > 0)
                    {
                        int userId = curr.USERID;
                        UserEntity user = base._Org.GetUserSupervisor(userId);
                        if (user != null && user.USERID > 0)
                        {
                            if (string.IsNullOrEmpty(user.LOGINNAME))
                            {
                                throw new Exception("获取直属领导出错！");
                            }
                            StepRecipientUser = "USER:org=" + user.DOMAIN + ",user=" + user.DOMAIN + "/" + user.LOGINNAME;
                        }
                    }
                    else
                    {
                        throw new Exception("获取直属领导出错！");
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                throw ex;
            }
            return StepRecipientUser;
        }

        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            try
            {
                if (stepConfig != null)
                {
                    base.MethodParameters = stepConfig.MethodParameters;
                }               

                if (!string.IsNullOrEmpty(base.MethodParameters) && bussData != null && bussData.Rows.Count > 0)
                {
                    string[] arrPara = base.MethodParameters.Split(';');

                    string ext01 = bussData.Rows[0][arrPara[0]].ToString();
                    string domain = SessionLogic.GetDomain(ext01);
                    UserEntity curr = _Org.GetUserEntity( ext01);
                    if (curr != null && curr.USERID > 0)
                    {
                        int userId = curr.USERID;
                        UserEntity user = base._Org.GetUserSupervisor(userId);
                        if (user != null && user.USERID > 0)
                        {
                            if (string.IsNullOrEmpty(user.LOGINNAME))
                            {
                                throw new Exception("获取直属领导出错！");
                            }
                            StepRecipientUser = "USER:org=" + user.DOMAIN + ",user=" + user.DOMAIN + "/" + user.LOGINNAME;
                        }
                    }
                    else
                    {
                        throw new Exception("获取直属领导出错！");
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex);
                throw ex;
            }
            return StepRecipientUser;
        }
    }
}