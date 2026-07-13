using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetRecipient : IRecipient
    {
        protected IOrg _Org = ServiceContainer.Instance().GetService<IOrg>();

        private String _MethodParameters = null;
        public String MethodParameters
        {
            get { return _MethodParameters; }
            set { _MethodParameters = value; }
        }
        public void InitMethodParameters(String _Parameters)
        {
            MethodParameters = _Parameters;
        }
        
        public virtual string Execute(DataTable bussData, StepSetting stepConfig)
        {
            return string.Empty;
        }

        public virtual string Execute(DataTable bussData, string methodParameters)
        {
            return string.Empty;
        }
    }
}