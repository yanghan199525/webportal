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

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetDepartmentManager : GetRecipient
    {
        public override string Execute(DataTable bussData, string methodParameters)
        {
            //暂时不用
            return "";
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

                if (!string.IsNullOrEmpty(base.MethodParameters)&&bussData != null && bussData.Rows.Count > 0)
                {
                    string[] arrPara = base.MethodParameters.Split(';');
                    string ext01 = bussData.Rows[0][arrPara[0]].ToString();
                    int deptId = -1;
                    int.TryParse(ext01, out deptId);
                    StepRecipientDao dao = new StepRecipientDao();
                    DataTable dt = dao.GetDeparmentManager(deptId);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        string LOGINNAME = MyLib.ConvertUtil.ToString(dt.Rows[0][0]);
                        if (!string.IsNullOrEmpty(LOGINNAME))
                        {
                            StepRecipientUser = "USER:org=" + SessionLogic.GetDomain(LOGINNAME) + ",user=" + LOGINNAME;
                        }
                    }

                    if (string.IsNullOrEmpty(StepRecipientUser))
                    {
                        throw new Exception("获取部门ID：" + deptId + " 经理失败,请联系管理员！");
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