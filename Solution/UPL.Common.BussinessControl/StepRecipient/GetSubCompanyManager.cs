using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Workflow.Entity;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetSubCompanyManager : GetRecipient
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

                }
            }
            catch (Exception ex)
            {
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

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return StepRecipientUser;
        }

    }
}