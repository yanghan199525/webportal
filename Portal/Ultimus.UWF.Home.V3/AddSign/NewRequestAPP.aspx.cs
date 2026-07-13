using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Workflow.Interface;
using MyLib.Json.Linq;
using System.Text.RegularExpressions;

namespace Ultimus.UWF.AddSign
{
    public partial class NewRequestAPP : System.Web.UI.Page
    {
        IWorkflow _task = ServiceContainer.Instance().GetService<IWorkflow>();
        protected global::Ultimus.UWF.Form.WebControls.RadioButtonList rblHQ;
        protected void Page_Load(object sender, EventArgs e)
        {
            string ProcessName = Request.QueryString["ProcessName"];
            string Incident = Request.QueryString["Incident"];
            string taskId = Request.QueryString["taskId"];
            string StepName = Request.QueryString["StepName"];
            string TableName = Request.QueryString["TableName"];
            string FORMID = Request.QueryString["FORMID"];
            selectuser.Value = Lang.Get("Selection_Staff");
            btnSubmit.Text = Lang.Get("Form_Submit");
            btnClose.Text = Lang.Get("Form_Close");
            rblHQ.Items[0].Text = Lang.Get("Countersign");
            rblHQ.Items[1].Text = Lang.Get("Sign_On");
            if (!IsPostBack)
            {
                txtProcessName.Text = ProcessName;
                txtIncident.Text = Incident;
                txttaskId.Text = taskId;
                txtStepName.Text = StepName;
                txtTableName.Text = TableName;
                txtFORMID.Text = FORMID;
                txtJiaQianProcessName.Text = ConfigurationManager.AppSettings["AddSignProcess"];
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string StepName = Request.QueryString["StepName"].ToString();
                string StepType = "";
                string FORMID = Request.QueryString["FORMID"];
                string PROCESSNAME = Request.QueryString["PROCESSNAME"];
                string INCIDENT = Request.QueryString["INCIDENT"];
                //string ROWID = (Convert.ToInt32(Request.QueryString["StepName"].Replace("审批人", ""))) + "";
                string ROWID = (Convert.ToInt32(Request.QueryString["INCIDENT"])) + "";
                string UpdateSql = "SET XACT_ABORT ON; begin TRANSACTION;  Update MNG_SCM_OA_SIGNLIST set ROWID =CONVERT(INT,ROWID)+1 where  incident=N'{0}' and PROCESSNAME=N'{1}' AND PARENTFORMID=N'{2}' and CONVERT(INT,ROWID)>N'{3}'";
                UpdateSql = string.Format(UpdateSql, INCIDENT, PROCESSNAME, FORMID, ROWID);
                if (Request.QueryString["obj"].ToString() == "1")
                {
                    StepType = "审批人";
                }
                else
                {
                    StepType = "会签";
                }

                string[] JoinValue = txtJiaqianId.Text.Split(',');
                string[] JoinName = txtJiaqianName.Text.Split(',');
                string sql = "";
                for (int m = 0; m < JoinName.Length; m++)
                {
                    sql += @"INSERT INTO [MNG_SCM_OA_SIGNLIST] VALUES
                                      ('{7}',N'{0}',N'{1}' ,N'{2}',0, N'{8}',N'{3}' ,N'{4}' ,N'{5}' ,getdate() ,N'' ,'' ,N'{6}' ,'','{9}')";
                    sql = string.Format(sql, FORMID, PROCESSNAME, INCIDENT, StepType, JoinName[m], getLoginname(JoinValue[m]),
                        StepType, Guid.NewGuid(), ConvertUtil.ToInt32(ROWID) + 1, "1");

                }
                sql += ";commit TRANSACTION;";
                UpdateSql += sql;
                DataAccess.Instance("BizDB").ExecuteNonQuery(UpdateSql.ToString());
            }
            catch (Exception ex)
            {
                //throw ex;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('增加签核人失败!Add Sign failure.错误信息 Summary ：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
                return;
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "submitSuccess();", true);

        }

        /// <summary>
        /// 根据员工id获取员工账号
        /// </summary>
        /// <param name="loginname">//396|USER,747|USER</param>
        /// <returns></returns>
        public string getLoginname(string userid)
        {
            string loginname = "";
            userid = userid.Replace("|USER", "");
            string sql = "select * from v_org_user where userid in (" + userid + ")";
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            string org = ConvertUtil.ToString(ConfigurationManager.AppSettings["Org"]);
            //CN/CN03696|USER
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    loginname += dt.Rows[i]["DOMAIN"].ToString() + "\\" + dt.Rows[i]["loginname"].ToString();
                }
            }
            return loginname;
        }

        bool SaveApprovalHistroy(string processName, int incident, string comments,
           string userName)
        {
            ApprovalHistoryEntity approval = new ApprovalHistoryEntity();
            UserEntity user = SessionLogic.GetLoginUserEntity();
            string sql = @"INSERT INTO WF_APPROVALHISTORY
           (PROCESSNAME ,INCIDENT,STEPNAME,APPROVERNAME ,APPROVERACCOUNT
           ,ACTION,COMMENTS,CREATEDATE,CHILDPROCESSNAME,CHILDINCIDENT,EXT01,ID)
            VALUES(@PROCESSNAME ,@INCIDENT,@STEPNAME,@APPROVERNAME ,@APPROVERACCOUNT
           ,@ACTION,@COMMENTS,@CREATEDATE,@CHILDPROCESSNAME,@CHILDINCIDENT,@EXT01,@ID)";

            DataAccess.Instance("BizDB").ExecuteNonQuery(sql, txtProcessName.Text, txtIncident.Text, Lang.Get("History_AddSignStep"), user.USERNAME, "",
                Lang.Get("History_AddSign") + txtJiaqianName.Text, comments, DateTime.Now, processName, incident, userName
                , SerialNoLogic.GetMaxNo("WF_APPROVALHISTORY", "ID"));

            return true;
        }
    }
}