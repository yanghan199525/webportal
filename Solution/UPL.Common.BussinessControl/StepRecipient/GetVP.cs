using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MyLib;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Workflow.Dao;
using Ultimus.UWF.Workflow.Entity;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetVP : GetRecipient
    {
        public override string Execute(DataTable bussData,string methodParameters)
        {
            //暂时不用
            return "";
        }



        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            if (bussData.Rows.Count > 0)
            {
                //获取申请人
                string CREATEBYACCOUNT = ConvertUtil.ToString(bussData.Rows[0]["CREATEBYACCOUNT"]).Replace("\\", "/");
                int dep = ConvertUtil.ToInt32(bussData.Rows[0]["DEPARTMENTID"]);
                StepRecipientDao dao = new StepRecipientDao();
                string VP = dao.GetVP(dep);
                if (CREATEBYACCOUNT == VP)
                {
                    StepRecipientUser = "SkipStep";
                    return StepRecipientUser;
                }
                StepRecipientUser = "USER:org=" + VP.Split('/')[0] + ",user=" + VP;
            }
            return StepRecipientUser;
        }
    }
}