using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MyLib;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetApplicantConfirm : GetRecipient
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
                string applicant = ConvertUtil.ToString(bussData.Rows[0]["APPLICANTACCOUNT"]).Replace("\\", "/");
                StepRecipientUser = "USER:org=" + applicant.Split('/')[0] + ",user=" + applicant;
            }
            return StepRecipientUser;
        }
    }
}