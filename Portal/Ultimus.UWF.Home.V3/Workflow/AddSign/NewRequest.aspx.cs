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
    public partial class NewRequest : System.Web.UI.Page
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
                if (string.IsNullOrEmpty(txtJiaqianName.Text))
                {
                    throw new Exception("请选择加签人员 Please Select User！");
                }
                UserEntity ue = SessionLogic.GetLoginUserEntity();
                string UserName = ue.LOGINNAME;

                string FORMID = Guid.NewGuid().ToString();
                string ultsql = @"select SUMMARY from incidents where PROCESSNAME='" + txtProcessName.Text.Trim() + "' and INCIDENT='" + txtIncident.Text.Trim() + "'";
                DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(ultsql);

                string destSummary = string.Empty;
                string SUMMARY = string.Empty;
                string DOCUMENTNO = string.Empty;
                if (dt != null && dt.Rows.Count > 0)
                {
                    SUMMARY = dt.Rows[0]["SUMMARY"].ToString().Trim();
                    try
                    {
                        //var jsonObj = JObject.Parse(SUMMARY);
                        //if (jsonObj != null)
                        //{
                        //    SUMMARY = ConvertUtil.ToString(jsonObj["documentNo"]);
                        //    DOCUMENTNO = ConvertUtil.ToString(jsonObj["documentNo"]);
                        //    //if (!string.IsNullOrEmpty(ConvertUtil.ToString(jsonObj["summary"])))
                        //    //SUMMARY = " ( " + txtJiaQianProcessName.Text.Trim() + " ) " + ConvertUtil.ToString(jsonObj["summary"]);

                        //    string _sum = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar("select EXT18 from WF_PROCESS where processname=N'" + txtJiaQianProcessName.Text.Trim() + "'"));
                        //    if (string.IsNullOrEmpty(_sum))
                        //        _sum = "{\"documentNo\":\"{DOCUMENTNO}\",\"applicant\":\"{APPLICANT}\",\"applicantCode\":\"{APPLICANTACCOUNT}\",\"summary\":\"{PROCESSSUMMARY}\"}";

                        //    Dictionary<string, object> listParam = new Dictionary<string, object>();
                        //    listParam = SerializeUtil.JsonDeserialize<Dictionary<string, object>>(_sum.ToString());
                        //    Dictionary<string, object> listParm = new Dictionary<string, object>();
                        //    listParm.Add("documentNo", ConvertUtil.ToString(DOCUMENTNO));
                        //    listParm.Add("applicant", txtJiaqianName.Text);
                        //    listParm.Add("applicantCode", ConvertUtil.ToString(ue.LOGINNAME));
                        //    listParm.Add("summary", SUMMARY);
                        //    destSummary = SerializeUtil.JsonSerialize(listParm);
                        //}
                        destSummary = SUMMARY;
                    }
                    catch (Exception ex)
                    {
                        MyLib.LogUtil.Info(ex.Message);
                    }
                }

                string sql = @"INSERT INTO WF_ADDSIGN(FORMID,PROCESSNAME,INCIDENT,APPLICANT,APPLICANTACCOUNT,REQUESTDATE,STEPNAME,TABLENAME,PARENTFORMID,PARENTPROCESSNAME,PARENTINCIDENT,PARENTTASKID,SIGNType,SIGNAPPROVER,SIGNAPPROVERACCOUNT,PROCESSSUMMARY,SUBMITAFTER,PARENTSUMMARY,DOCUMENTNO) 
                             VALUES(@FORMID,@PROCESSNAME,@INCIDENT,@APPLICANT,@APPLICANTACCOUNT,@REQUESTDATE,@STEPNAME,@TABLENAME,@PARENTFORMID,@PARENTPROCESSNAME,@PARENTINCIDENT,@PARENTTASKID,@SIGNType,@SIGNAPPROVER,@SIGNAPPROVERACCOUNT,@PROCESSSUMMARY,@SUBMITAFTER,@PARENTSUMMARY,@DOCUMENTNO)";

                DataAccess.Instance("BizDB").ExecuteNonQuery(sql, FORMID, txtJiaQianProcessName.Text, 0, "",
                    ue.LOGINNAME, DateTime.Now, txtStepName.Text,
                      txtTableName.Text, txtFORMID.Text, txtProcessName.Text, txtIncident.Text, txttaskId.Text,
                      (ConvertUtil.ToInt32(rblHQ.SelectedValue) == 0 ? 0 : 1) + "", txtJiaqianName.Text, txtJiaqianId.Text,
                      txtComments.Text, cbxSubmitAfter.Checked ? "1" : "0", SUMMARY, DOCUMENTNO);

                #region 获取审批人

                List<ParameterEntity> listVar = new List<ParameterEntity>();
                ParameterEntity ve1 = new ParameterEntity();
                ve1.Name = "Type";
                ve1.Value = (ConvertUtil.ToInt32(rblHQ.SelectedValue) == 0 ? 0 : 1) + "";
                listVar.Add(ve1);
                string userlist = getLoginname(txtJiaqianId.Text);
                List<string> list = new List<string>(userlist.Split('|'));

                ParameterEntity ve2 = new ParameterEntity();
                ve2.Name = "SignUser";
                ve2.Value = userlist;
                listVar.Add(ve2);

                if (ConvertUtil.ToInt32(rblHQ.SelectedValue) == 0)
                {
                    if (list != null && list.Count > 0)
                    {
                        if (list.Count == 1)
                        {
                            list.Insert(1, "1");
                            list.Insert(2, "1");
                            list.Insert(3, "1");
                            list.Insert(4, "1");
                        }
                        if (list.Count == 2)
                        {

                            list.Insert(2, "1");
                            list.Insert(3, "1");
                            list.Insert(4, "1");
                        }
                        if (list.Count == 3)
                        {
                            list.Insert(3, "1");
                            list.Insert(4, "1");
                        }
                        if (list.Count == 4)
                        {
                            list.Insert(4, "1");
                        }
                        ParameterEntity ve3 = null;
                        for (int i = 0; i < list.Count; i++)
                        {
                            ve3 = new ParameterEntity();
                            ve3.Name = "StepUser" + (i + 1);
                            ve3.Value = list[i];
                            listVar.Add(ve3);
                        }
                    }
                }

                #endregion

                #region 发起流程

                // 发起流程  
                object obj = null;
                string taskId = "";
                if (DatabaseUtil.IsOracle("UltDB"))
                {
                    obj = DataAccess.Instance("UltDB").ExecuteScalar("select INITIATEID from INITIATE where trim(processname)=@processname order by PROCESSVERSION desc",
                        txtJiaQianProcessName.Text);
                }
                else
                {
                    obj = DataAccess.Instance("UltDB").ExecuteScalar("select INITIATEID from INITIATE where processname=@processname order by PROCESSVERSION desc",
                        txtJiaQianProcessName.Text);
                }
                taskId = ConvertUtil.ToString(obj).Trim();
                string error = "";
                TaskEntity entity = new TaskEntity();
                entity.ASSIGNEDTOUSER = UserName;
                entity.TASKID = taskId;
                entity.SUMMARY = destSummary;
                //entity.VarList = listVar;
                //同意
                int outIncident = 0;
                string info = _task.StartProcess("", entity.ASSIGNEDTOUSER, txtJiaQianProcessName.Text, entity.SUMMARY,
                    listVar, "", FORMID, entity.INCIDENT, entity.STEPLABEL);
                if (info.IndexOf("failure") >= 0)
                {
                    error = info;
                }
                else
                {
                    error = "";
                }
                LogUtil.Info("Add Sign:" + info);
                outIncident = ConvertUtil.ToInt32(info.Replace("success:", ""));
                #endregion

                if (string.IsNullOrEmpty(error))
                {
                    SaveApprovalHistroy(txtJiaQianProcessName.Text, outIncident, txtComments.Text, UserName);
                    sql = "Update WF_ADDSIGN set INCIDENT={0} where FORMID='{1}'";
                    sql = string.Format(sql, outIncident, FORMID);
                    DataAccess.Instance("BizDB").ExecuteNonQuery(sql);

                }
                else
                {
                    throw new Exception(error);
                }

            }
            catch (Exception ex)
            {
                //throw ex;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('加签失败!Add Sign failure.错误信息 Summary ：" + ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "") + "');", true);
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
                    loginname += "USER:org=" + dt.Rows[i]["DOMAIN"].ToString() + ",user=" + dt.Rows[i]["loginname"].ToString().Replace("\\", "/") + "|";
                }
            }
            loginname = loginname.Trim('|');
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