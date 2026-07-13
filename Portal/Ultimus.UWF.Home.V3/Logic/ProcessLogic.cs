using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3.Logic
{
    public class ProcessLogic
    {
        public string GetProcessName(string text)
        {
            IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            List<ProcessEntity> processes = _workflow.GetAllProcessList();
            ProcessEntity proc = processes.Find(p => p.PROCESSCNNAME.Contains(text) || p.PROCESSENNAME.Contains(text));
            if (proc != null)
            {
                return proc.PROCESSNAME;
            }
            return text;
        }
    }
}