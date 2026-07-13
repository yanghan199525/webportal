using MyLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Workflow
{
    public partial class ShowNextApprover : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            IWorkflow workflow = ServiceContainer.Instance().GetService<IWorkflow>();
            // string formID = Session["FormID"] as string;
            string formID = Request.QueryString["FORMID"];
            string processName = Request.QueryString["ProcessName"];
            string taskId = Request.QueryString["taskId"];
            int incident = ConvertUtil.ToInt32(Request.QueryString["Incident"]);
            string stepName = GetStepName(processName, incident);
            Hashtable vars = new Hashtable();
            Hashtable users = new Hashtable();

            DataTable dtApprover = new DataTable();
            dtApprover.Columns.Add("StepName");
            dtApprover.Columns.Add("Approver");
            if (formID != null)
            {
                if (!string.IsNullOrEmpty(stepName))
                {
                    workflow.GetStepRecipientVariable(processName, formID, ref vars, out users);

                    Hashtable automatic_users = new Hashtable();
                    for (int i = 0; i <= 30; i++)
                    {
                        workflow.GetDOANextStepVariable(processName, stepName,
                            formID, taskId, ref vars, users, ref automatic_users);
                        string nextStep = ConvertUtil.ToString(vars["DOANEXTSTEP"]);
                        stepName = nextStep;
                        if (WebUtil.CompareString(nextStep, "Complete"))
                        {
                            break;
                        }

                        DataRow row = dtApprover.NewRow();
                        row[0] = nextStep;

                        string[] userStep = users[nextStep].ToString().Split('|');
                        string user = ConvertUtil.ToString(users[nextStep]);
                        string username = string.Empty;
                        if (string.IsNullOrEmpty(user))
                        {
                            user = "复杂审批人，未能模拟显示";
                            row[0] = nextStep;
                            row[1] = "未能模拟显示,请联系管理员"; ;
                            dtApprover.Rows.Add(row);
                            continue;
                        }
                        else
                        {
                            try
                            {
                                for (int u = 0; u < userStep.Length; u++)
                                {   //user = user.Split(',')[1].Split('=')[1];
                                    user = userStep[u].Split(',')[1].Split('=')[1];
                                    DataTable dtuser = DataAccess.Instance("BizDB").ExecuteDataTable
                                        ("select username,empno,account from v_org_user where loginname=@loginname", user.Replace("/", "\\"));
                                    if (dtuser.Rows.Count > 0)
                                    {
                                        DataRow dr = dtuser.Rows[0];
                                        user = ConvertUtil.ToString(dr[0]) + "(" + ConvertUtil.ToString(dr[1]) + ")";
                                        username += user + ",";
                                    }
                                }
                            }
                            catch
                            {
                                
                            }
                        }
                        username = username.Substring(0, username.Length - 1);
                        row[1] = username;
                        dtApprover.Rows.Add(row);
                    }
                }

                if (dtApprover.Rows.Count == 0)
                {
                    DataRow row = dtApprover.NewRow();
                    row[0] = "后续无审批步骤";
                    row[1] = "...";
                    dtApprover.Rows.Add(row);
                }

                rptList.DataSource = dtApprover;
                rptList.DataBind();
            }
        }

        public static string GetStepName(string processName, int incident)
        {
            object obj = DataAccess.Instance("UltDB").ExecuteScalar($@"select STEPLABEL from tasks where processname='{processName}' and incident={incident} and status='1' ");
            if (obj != null)
            {
                return obj.ToString();
            }
            else
            {
                return "";
            }

        }

    }
}