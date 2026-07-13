using System.Data;
using MyLib;
using Ultimus.UWF.Workflow.Entity;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetApplicant : GetRecipient
    {
        public override string  Execute(DataTable bussData,string methodParameters)
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