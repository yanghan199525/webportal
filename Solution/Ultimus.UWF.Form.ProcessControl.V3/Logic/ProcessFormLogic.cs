using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Workflow.Logic
{
    public class ProcessFormLogic
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        public void AddBlankRow(Control container, Control repeater, int rowNumber)
        {
            _workflow.AddBlankRow(container, repeater, rowNumber);
        }

        public string GetReportViewSql(string processName, string loginName)
        {
            return _workflow.GetReportViewSql(processName, loginName);
        }

        public void AddHiddenRow(Control container, Control repeater, int rowNumber)
        {
            IWorkflow workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            workflow.AddHiddenRow(container, repeater, rowNumber);
        }
    }
}
