using MyLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Home.V3.Logic;
using System.Security.Cryptography;
using System.IO;
using DES_PSO.Web.Matlab;
using System.Web.Script.Serialization;
using Ultimus.UWF.EmailNotification;

namespace Ultimus.UWF.Workflow
{
    public partial class EmailSendForm : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnClose.Text = Lang.Get("TaskStatus_Close");
                //获取当前登录人
                string taskid = HttpUtility.UrlDecode(Request.QueryString["taskid"]);
                string username = Request.QueryString["username"];
                string type = Request.QueryString["type"];
                //var_issign.Text = issign;
                //username = Decrypt(username).Replace("/", "\\");
                //string LoginName = SessionLogic.GetLoginName();               

                string LoginName = username;
                ////判断登录人与此链接任务人是否同一人
                //if (username != LoginName)
                //{,
                //    //若不是同一人则跳转登录页
                //    HttpContext.Current.Response.Redirect(WebUtil.GetRootPath() + ConfigurationManager.AppSettings["LoginForm"]);
                //}              
                DataTable dt = GetTask(taskid);
                if (dt == null || dt.Rows.Count == 0)
                {
                    lbResultFail.Text = "Can not found the taskid!";// Lang.Get("EmailPageApproval_LinkError");// "此连接已失效或无权限审批！";
                    divApproveResult.Visible = true;
                    divApproveResultFail.Visible = true;
                    return;
                }
                else
                {
                    string processname = ConvertUtil.ToString(dt.Rows[0]["processname"]).Trim();
                    txtProcessNameS.Text = Lang.Get(processname);
                    string steplabel = ConvertUtil.ToString(dt.Rows[0]["steplabel"]).Trim();
                    txtprocessname.Text = processname;
                    txtsteplabel.Text = steplabel;

                    string sLoginName = string.IsNullOrEmpty(LoginName) ? "" : LoginName.Replace("\\", "/").ToUpper().Trim();
                    string ASSIGNEDTOUSER = ConvertUtil.ToString(dt.Rows[0]["ASSIGNEDTOUSER"]).Trim();
                    ASSIGNEDTOUSER = string.IsNullOrEmpty(ASSIGNEDTOUSER) ? "" : ASSIGNEDTOUSER.ToUpper().Trim();
                    string status = ConvertUtil.ToString(dt.Rows[0]["status"]);
                    if (status == "1")//&& ASSIGNEDTOUSER == sLoginName
                    {

                    }
                    else
                    {
                        lbResultFail.Text = "This task have already approved!<br>此链接已经审批过!";// Lang.Get("EmailPageApproval_LinkError");// "此连接已失效或无权限审批！";
                        divApproveResult.Visible = true;
                        divApproveResultFail.Visible = true;
                        this.ChechBox.Visible = false;
                        return;
                    }
                }
                dev_SIGNNAME.Visible = false;
                butSIGN.Visible = false;
                btTransfer.Visible = false;
                if (ISSIGN(1))
                {
                    butSIGN.Text = Lang.Get("SIGN");
                    dev_SIGNNAME.Visible = true;
                    butSIGN.Visible = true;
                    BindSIGNNAME(1);
                }
                if (ISSIGN(2))
                {
                    btTransfer.Text = Lang.Get("Transfer");
                    dev_SIGNNAME.Visible = true;
                    btTransfer.Visible = true;
                    BindSIGNNAME(2);
                }
                string processName = ConvertUtil.ToString(dt.Rows[0]["PROCESSNAME"]).Trim();
                string incident = ConvertUtil.ToString(dt.Rows[0]["incident"]);
                GetShow(processName, int.Parse(incident));
                txttaskid.Text = taskid;
                //this.txtusername.Text = user.USERNAME;
                txttype.Text = type;
                txtincident.Text = incident;
                //txtLoginAccount.Text = LoginName;
                txtLoginAccount.Text = username;
                appOC.Visible = false;                
                InitPage();

                //BingApprovalHistory(processname,ConvertUtil.ToInt32(incident));
                if (type == "agree" || type == "0")
                {
                    if (ConfigurationManager.AppSettings["EmailApproveOpinion"] == "0")
                    {
                        dt = GetTask(txttaskid.Text, txtLoginAccount.Text);
                        if (dt.Rows.Count == 0)
                        {
                            // Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('此连接已失效！');window.opener=null;window.open('','_self');window.close()", true);
                            lbResultFail.Text = "Current user has no permission to approve!";// Lang.Get("EmailPageApproval_LinkError"); //"此连接已失效或无权限审批！";
                            divApproveResult.Visible = true;
                            divApproveResultFail.Visible = true;
                            return;
                        }
                        Submit();

                    }
                    else
                    {
                        //add yang.han time 2021-06-15
                        Getapplypurpose(processName, Convert.ToInt32(incident), taskid);
                        btnSubmit.Text = Lang.Get("Approve");
                        btnSubmit.Visible = true;
                        divApprove.Visible = true;
                    }
                }
                else
                {
                    btnSubmit.Visible = true;
                    divApprove.Visible = true;
                }
                if (type == "1")
                {
                    //add yang.han time 2021-06-15
                    this.Check_values.Text = "hidden";
                    btnSubmit.Text = Lang.Get("Return");
                }
                if (type == "2")
                {
                    //add yang.han time 2021-06-15
                    this.Check_values.Text = "hidden";
                    btnSubmit.Text = Lang.Get("Reject");
                }
                if (ConvertUtil.ToString(dt.Rows[0]["steplabel"]).Trim() == "OC"|| ConvertUtil.ToString(dt.Rows[0]["steplabel"]).Trim() == "FPA" || ConvertUtil.ToString(dt.Rows[0]["steplabel"]).Trim() == "GL" || ConvertUtil.ToString(dt.Rows[0]["steplabel"]).Trim() == "GNL")
                {
                    var newUsername = HttpContext.Current.Server.UrlEncode(username.Replace('/', '\\'));
                    var systemConnection = ConfigurationManager.AppSettings["SystemConnection"] + "Solution/";
                    var prdName = "PR.PRProcess." + processName + "/Form/";
                    if (processName == "PR_ALL" || processName == "CPR_ALL" || processName == "PO_SUPPLIER_NETPRICE" || processName == "PO_SUPPLIER_SUMMARY" || processName == "CAPEX_SERVICE" || processName == "HK_CAPEX_SERVICE" || processName == "CAPEX_ALL")
                    {
                        prdName = "UWF.Process." + processName + "/FormV1/";
                    }
                    else if (processName == "CAPEX_NONFOOD" || processName == "HK_CAPEX_NONFOOD")
                    {
                        prdName = "UWF.Process." + processName + "/FormV2/";
                    }
                    var href = systemConnection + prdName;
                    appdetails.HRef = href + "Approval.aspx?ProcessName=" + processName + "&StepName=" + ConvertUtil.ToString(dt.Rows[0]["steplabel"]).Trim() + "&Incident=" + int.Parse(incident) + "&TaskID=" + taskid + "&UserName=" + newUsername + "&Type=MYTASK&EmailType=email";
                    appOC.Visible = true;
                    if (processName == "CAPEX_NONFOOD" || processName == "CAPEX_SERVICE")
                        btnSubmit.Visible = false;
                }
            }
            else
            {
                //add yang.han time 2021-06-15
                this.Check_values.Text = "0";
            }
            

        }

        /// <summary>
        ///代采购处理逻辑
        /// </summary>
        /// <param name="processName">流程名称</param>
        /// <param name="incident">流程实例号</param>
        /// <param name="UserName">登录名</param>
        public void Getapplypurpose(string processName, int incident, string taskid)
        {
            string applypurpose = null;
            decimal amount = 0;
            string steplabel = null;
            if (processName == "CPR_FOOD" || processName == "CPR_NONFOOD" || processName == "CPR_SERVICE")
            {
                StringBuilder sSql = new StringBuilder();
                sSql.Append("SELECT APPLYPURPOSE,AMOUNT FROM [dbo].[PROC_" + processName + "]  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "'");
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count > 0)
                {
                    applypurpose = dt.Rows[0]["APPLYPURPOSE"].ToString();
                    amount = Convert.ToDecimal(dt.Rows[0]["AMOUNT"]);
                }
                sSql.Length = 0;
                sSql.Append("SELECT STEPLABEL FROM [dbo].[TASKS]  WHERE TASKID='" + taskid + "'");
                DataTable task = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
                if (task.Rows.Count > 0)
                {

                    steplabel = task.Rows[0]["STEPLABEL"].ToString().Trim();

                }
                //测试 使用条件
                if (applypurpose == "2" && amount > 100000 && steplabel == "Segment Director")
                {
                    this.Check_values.Text = "block";
                }
                else
                {
                    this.Check_values.Text = "hidden";
                }
            }
            else
            {
                this.Check_values.Text = "hidden";
            }
        }
        private void InitPage()
        {
            string tableName = getTableNameByProcess(txtprocessname.Text);
            txttableName.Text = tableName;
            getdocumentNo(txtprocessname.Text, txtincident.Text, tableName);

        }

        IWorkflow _form = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Submit(bool isSIGN = false)
        {
            try
            {
                bool flag = false;
                int incident = ConvertUtil.ToInt32(txtincident.Text);
                string type = "MYTASK";
                string processName = txtprocessname.Text;
                string stepName = txtsteplabel.Text;
                string formID = txtFORMID.Text;
                string tableName = txttableName.Text;
                string summary = "";
                string taskID = txttaskid.Text;
                string applicant = txtLoginAccount.Text;
                int typeInt = ConvertUtil.ToInt32(txttype.Text);
                int actionType = -1;
                if (typeInt == 0)
                {
                    actionType = 0;
                }
                else if (typeInt == 1)
                {
                    actionType = 1;
                }
                else if (typeInt == 2)
                {
                    actionType = 2;
                }
                string comments = "";
                if (this.CheckBoxText.Text.Trim() == "")
                {
                    comments = txtComments.Text;
                }
                else
                {
                    comments = txtComments.Text + "\n" + this.CheckBoxText.Text;
                }
                string error = "";

                //1.获取当前登录用户
                string loginname = txtLoginAccount.Text;
                if (string.IsNullOrEmpty(loginname))
                {
                    return;
                }
                if (processName == "PO_SUPPLIER_NETPRICE" &&string.IsNullOrWhiteSpace(comments))
                {
                    lbResultFail.Text = "审批理由为必填项,请输入审批理由!";// "流程提交失败，请联系管理员！";  
                    divApproveResult.Visible = true;
                    divApproveResultFail.Visible = true;
                    return;
                }

                TextBox var_APPROVE = (TextBox)Page.FindControl("var_APPROVE");
                var_APPROVE.Text = DateTime.Now.ToString("yyyyMMddHHmm");
                DataTable CPR_TASK = DataAccess.Instance("UltDB").ExecuteDataTable("SELECT PROCESSNAME,INCIDENT,STEPLABEL,TASKUSER FROM TASKS WHERE TASKID='" + taskID + "'");
                string PROCESSNAME = CPR_TASK.Rows[0]["PROCESSNAME"].ToString();
                int INCIDENT = Convert.ToInt32(CPR_TASK.Rows[0]["INCIDENT"].ToString());
                string STEPLABEL = CPR_TASK.Rows[0]["STEPLABEL"].ToString();
                string TASKUSER = CPR_TASK.Rows[0]["TASKUSER"].ToString();

                int res = DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("UPDATE PROC_{0} SET APPROVE='{1}' WHERE INCIDENT={2}", PROCESSNAME, var_APPROVE.Text, INCIDENT));
                Hashtable vars = new Hashtable();
                vars = _workflow.GetFormVars(var_APPROVE, ref vars);//获取变量  
                var signName = string.Empty;
                vars.Add("STEPNAME", stepName);
                if (isSIGN)
                {
                    var fld_SIGNNAME = (DropDownList)Page.FindControl("fld_SIGNNAME");
                    signName = string.Format("{0}", FormatUltimusUser(fld_SIGNNAME.SelectedItem.Text));
                    var isSign = GETISSIGN(1);
                    vars.Add("ISSIGN", isSign);
                    vars.Add("USER_SIGNNAME", signName);
                }
                if (processName.ToUpper().Trim() == "PO_AMENDMENT" && actionType == 0 && STEPLABEL.Trim() == "supplier" && btnSubmit.Text != "Reject" && btnSubmit.Text != "拒绝")
                {
                    string documentNo = DataAccess.Instance("BizDB").ExecuteScalar("SELECT  ADJUSTDOCUMENTNO  FROM PROC_PO_AMENDMENT WHERE INCIDENT='" + INCIDENT + "'").ToString();
                    Result result = CheckBeforeAdjuestPO(documentNo);
                    if (result.ResultCode == "0000")
                    {
                        flag = _form.SubmitForm(new DataSet(), vars, loginname, "", taskID, processName,
                    incident, stepName, tableName, formID, "", false, type,
                    summary, actionType, "", comments, ref error, "", false);
                    }
                    else
                    {
                        lbResultFail.Text = result.ResultMessage + "请点击拒绝!";// "流程提交失败，请联系管理员！";              
                        divApproveResult.Visible = true;
                        divApproveResultFail.Visible = true;
                        btnSubmit.Text = Lang.Get("Reject");
                        actionType = 2;
                        return;
                    }

                }
                else if (processName.ToUpper().Trim() == "PO_AMENDMENT" && actionType == 1 && (STEPLABEL.Trim() == "SCM OC" || STEPLABEL.Trim() == "Regional Director"))
                {
                    flag = _form.SubmitForm(new DataSet(), vars, loginname, "", taskID, processName,
                    incident, stepName, tableName, formID, "", false, type,
                    summary, actionType, "", comments, ref error, "", false);
                    ReturnResultPO(processName, incident);

                }
                else if (processName.ToUpper().Trim() == "PO_AMENDMENT" && (btnSubmit.Text == "Reject" || btnSubmit.Text == "拒绝") && STEPLABEL.Trim() == "supplier")
                {
                    flag = _form.SubmitForm(new DataSet(), vars, loginname, "", taskID, processName,
                    incident, stepName, tableName, formID, "", false, type,
                    summary, 2, "", comments, ref error, "", false);
                    actionType = 2;

                }
                else
                {
                    flag = _form.SubmitForm(new DataSet(), vars, loginname, "", taskID, processName,
                     incident, stepName, tableName, formID, "", false, type,
                     summary, actionType, "", comments, ref error, "", false);

                }
                //flag = _workflow.SubmitForm(formData, vars, loginname, applicant, taskID, processName,
                //   incident, stepName, tableName, formID, prefix, isCreateForm, type,
                //   summary, actionType, returnStep, comments, ref error, userInfo.DOCUMENTNO, true);
                if (!flag || !string.IsNullOrEmpty(error))
                {
                    //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('流程提交失败，请联系管理员！');window.opener=null;window.open('','_self');window.close();</script>");
                    lbResultFail.Text = Lang.Get("SubmitFailure");// "流程提交失败，请联系管理员！";              
                    divApproveResult.Visible = true;
                    divApproveResultFail.Visible = true;
                    return;
                }
                if (actionType == 2 && processName.Contains("OR"))
                {
                    GetDocumentNo(processName, incident, tableName);
                }
                lbResult.Text = Lang.Get("SubmitSuccess");// "提交成功！";
                divApproveResult.Visible = true;
                divApproveResultSuss.Visible = true;
                divApprove.Visible = false;
                if (processName.Contains("PO"))
                {
                    UpdateApprovalHistroy(actionType, txtprocessname.Text, incident, stepName, loginname);
                }
                else if (STEPLABEL.Trim() == "Segment Director")
                {
                    DataTable table = GetSiteCode(PROCESSNAME, INCIDENT);
                    if (table.Rows.Count > 0)
                    {
                        DataTable dt = GetAuthInfo(loginname, table);
                        if (dt.Rows.Count > 0)
                        {
                            string name = string.Format("{0} (事业部总监授权区域总监)", loginname);
                            // string name = string.Format("{0} (SD){1}权力下放", loginname, dt.Rows[0]["sdName"].ToString());
                            UpdateApprovalHistroy(actionType, txtprocessname.Text, incident, stepName, name);
                        }
                    }


                }
                else
                {
                    UpdateApprovalHistroy(actionType, txtprocessname.Text, incident, stepName);
                }

                //Thread.Sleep(3000);
                BingApprovalHistory(txtprocessname.Text, incident);
                divApproveLog.Visible = true;
                btnSubmit.Visible = false;
                if (isSIGN)
                    UpdateSIGN(processName, incident, signName);

            }
            catch (Exception ex) //意外终止
            {
                LogUtil.Error("提交失败!", ex);
                lbResultFail.Text = Lang.Get("SubmitFailure");// "流程提交失败，请联系管理员！";              
                divApproveResult.Visible = true;
                divApproveResultFail.Visible = true;
                return;
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DataTable dt = GetTask(txttaskid.Text, txtLoginAccount.Text);
            if (dt.Rows.Count == 0)
            {
                // Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('此连接已失效！');window.opener=null;window.open('','_self');window.close()", true);
                lbResultFail.Text = Lang.Get("EmailPageApproval_LinkError"); //"此连接已失效或无权限审批！";
                divApproveResult.Visible = true;
                divApproveResultFail.Visible = true;
                return;
            }
            Submit();
        }
        public bool GetApproveHistory(string processnamme, int incident)
        {
            try
            {
                int result = Convert.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(string.Format("SELECT * FROM WF_APPROVALHISTORY WHERE EXT02=3 and STEPNAME='supplier' and INCIDENT='{0}' AND PROCESSNAME='{1}'", processnamme, incident)).ToString());
                if (result > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {

                throw;
            }


        }
        /// <summary>
        /// 解密方法
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string Decrypt(string str)
        {
            try
            {
                if (string.IsNullOrEmpty(str))
                {
                    return str;
                }
                else
                {
                    DESCryptoServiceProvider descsp = new DESCryptoServiceProvider();   //实例化加/解密类对象    

                    byte[] key = Encoding.Unicode.GetBytes("Oyea"); //定义字节数组，用来存储密钥    

                    byte[] data = Convert.FromBase64String(str);//定义字节数组，用来存储要解密的字符串  

                    MemoryStream MStream = new MemoryStream(); //实例化内存流对象      

                    //使用内存流实例化解密流对象       
                    CryptoStream CStream = new CryptoStream(MStream, descsp.CreateDecryptor(key, key), CryptoStreamMode.Write);

                    CStream.Write(data, 0, data.Length);      //向解密流中写入数据     

                    CStream.FlushFinalBlock();               //释放解密流      

                    return Encoding.Unicode.GetString(MStream.ToArray()).Replace("%2B", "+");       //返回解密后的字符串  
                }
            }
            catch (Exception)
            {

                return str;
            }

        }

        /// <summary>
        /// 获取documentno
        /// </summary>
        /// <param name="processname"></param>
        /// <param name="incident"></param>
        /// <param name="tablename"></param>
        /// <returns></returns>
        private bool getdocumentNo(string processname, string incident, string tablename)
        {
            string sql = "select FORMID,documentno from " + tablename +
                " where processname=N'" + processname + "' and incident='" + incident + "'";
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                lblDocumentNo.Text = ConvertUtil.ToString(dt.Rows[0]["documentno"]);
                txtFORMID.Text = ConvertUtil.ToString(dt.Rows[0]["FORMID"]);
                return true;
            }
            return false;
        }

        List<ParameterEntity> GetParameterList(Hashtable table)
        {
            List<ParameterEntity> list = new List<ParameterEntity>();
            foreach (DictionaryEntry ety in table)
            {
                ParameterEntity p = new ParameterEntity();
                p.Name = Convert.ToString(ety.Key);
                p.Value = Convert.ToString(ety.Value);
                list.Add(p);
            }
            return list;
        }

        bool Submit(int actionType, string taskId, string processName, ref int incident, string stepLabel,
            string userName, string summary, Hashtable vars, string type, string tableName, string formID)
        {
            string error = "";
            TaskEntity entity = new TaskEntity();
            entity.ASSIGNEDTOUSER = userName;
            entity.TASKID = taskId;
            entity.SUMMARY = summary;
            // entity.FORMID = formID;
            entity.PROCESSNAME = processName;
            entity.STEPLABEL = stepLabel;
            entity.INCIDENT = incident;
            
            //  entity.TABLENAME = "";
            //entity.VarList = GetVarList(vars);
            switch (actionType)
            {
                case 0: //同意
                    int outIncident = 0;
                    string info = _workflow.ApproveTask(entity.SERVERNAME, entity.TASKID, entity.ASSIGNEDTOUSER, entity.SUMMARY, entity.COMMENTS, GetParameterList(vars), formID, processName, incident, stepLabel);
                    outIncident = ConvertUtil.ToInt32(info.Replace("success:", ""));
                    if (info.IndexOf("failure") > 0)
                    {
                        error = info;
                    }
                    else
                    {
                        error = "";
                    }
                    incident = outIncident;
                    break;
                case 1: //退回
                    //删除会签任务
                    string strSql = string.Format("delete from tasks  where taskid<>'{0}' and steplabel=N'{1}' and processname=N'{2}' and incident={3} ",
                        taskId, stepLabel, processName, incident);
                    DataAccess.Instance("UltDB").ExecuteNonQuery(strSql);
                    strSql = string.Format("update tasks set recipienttype=0  where    steplabel=N'{1}' and processname=N'{2}' and incident={3} ",
                        taskId, stepLabel, processName, incident);
                    DataAccess.Instance("UltDB").ExecuteNonQuery(strSql);

                    string info1 = _workflow.ReturnTask(entity.SERVERNAME, entity.TASKID, entity.ASSIGNEDTOUSER, entity.SUMMARY, entity.COMMENTS, GetParameterList(vars), formID, processName, incident, stepLabel);
                    error = info1;
                    if (info1.IndexOf("failure") >= 0)
                    {
                        error = info1;
                    }
                    else
                    {
                        error = "";
                    }
                    break;
                case 2: //拒绝
                    //删除会签任务
                    strSql = string.Format("delete from tasks  where taskid<>'{0}' and steplabel=N'{1}' and processname=N'{2}' and incident={3} ",
                        taskId, stepLabel, processName, incident);
                    DataAccess.Instance("UltDB").ExecuteNonQuery(strSql);
                    strSql = string.Format("update tasks set recipienttype=0  where    steplabel=N'{1}' and processname=N'{2}' and incident={3} ",
                        taskId, stepLabel, processName, incident);
                    DataAccess.Instance("UltDB").ExecuteNonQuery(strSql);

                    string info2 = _workflow.AbortProcess(entity.SERVERNAME, entity.PROCESSNAME, entity.INCIDENT, entity.ASSIGNEDTOUSER, entity.REASON, formID, stepLabel);
                    error = info2;
                    if (info2.IndexOf("failure") >= 0)
                    {
                        error = info2;
                    }
                    else
                    {
                        error = "";
                    }
                    break;
            }

            if (!string.IsNullOrEmpty(error)) //2.1提交失败
            {
                DataAccess.Instance("BizDB").ExecuteNonQuery(string.Format("update {0} set INCIDENT={1},  STATUS=0 where FORMID='{2}'",
                    tableName, -1, formID));
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('提交失败：" + error + "');", true);
                return false;
            }
            //2.2提交成功            
            return true;
        }

        //判断流程是否有效
        public DataTable GetTask(string taskid, string username)
        {
            username = string.IsNullOrEmpty(username) ? "" : username.Replace("\\", "/");
            string sql = "";
            if (IsOracle("UltDB"))
            {
                sql = "select * from TASKS where trim(TASKID)='" + taskid + "' and status=1 and trim(ASSIGNEDTOUSER)=N'" + username + "'";
            }
            else
            {
                sql = "select * from TASKS where TASKID ='" + taskid + "' and status=1 and ASSIGNEDTOUSER =N'" + username + "'";
            }
            DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(sql);
            return dt;
        }
        public Result CheckBeforeAdjuestPO(string documentNo)
        {
            try
            {
                string baseUrl = ConfigurationManager.AppSettings["WEB_API_URL"].Trim();
                string value;
                value = HttpUtil.HttpGet(string.Format("{0}/api/po/POValidationCheck?poNumber={1}", baseUrl, documentNo), "application/json;charset=UTF-8");
                PUshPoNumber result = FromJSON<PUshPoNumber>(value);

                return result.result;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        public void ReturnResultPO(string strProcessName, int nIncident)
        {
            try
            {
                string baseUrl = ConfigurationManager.AppSettings["WEB_API_URL"].Trim();
                string result;
                result = HttpUtil.HttpGet(string.Format("{0}/api/po/POPushApprovalResult?processName={1}&incident={2}&approvalResult={3}", baseUrl, strProcessName, nIncident, 2), "application/json;charset=UTF-8");
                LogUtil.Error("测试退回SodexoCPRLogicSubscription：" + result + "DOCUMENTNO:" + strProcessName + "INCIDENT:" + nIncident);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        private void GetDocumentNo(string processname, int incident, string tablename)
        {
            try
            {
                string sql = "select FORMID,documentno from " + tablename +
               " where processname=N'" + processname + "' and incident='" + incident + "'";
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["documentno"].ToString().Contains("YG") || dt.Rows[0]["documentno"].ToString().Contains("JD"))
                    {
                        string baseUrl = ConfigurationManager.AppSettings["WEB_API_URL"].Trim();
                        string result;
                        result = HttpUtil.HttpGet(string.Format("{0}/api/order/AutomaticApproval?DocumentNo={1}", baseUrl, dt.Rows[0]["documentno"].ToString()), "application/json;charset=UTF-8");
                    }
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error($"自动拒绝：{ex.Message}");
                throw;
            }

        }
        public class PUshPoNumber
        {
            public Result result { get; set; }

        }
        public class Result
        {

            /// <summary>
            /// 成功或者失败
            /// </summary>
            public bool Success { get; set; }
            /// <summary>
            /// 可提交或者不可提交
            /// </summary>
            public string ResultCode { get; set; }
            /// <summary>
            /// 可提交或者不可提交具体原因
            /// </summary>
            public string ResultMessage { get; set; }
        }

        /// <summary>
        /// json字符串转json对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="jsonString"></param>
        /// <returns></returns>
        public static T FromJSON<T>(string jsonString)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Deserialize<T>(jsonString);
        }
        public DataTable GetTask(string taskid)
        {
            string sql = "";
            if (IsOracle("UltDB"))
            {
                sql = "select * from TASKS where trim(TASKID)='" + taskid + "' ";
            }
            else
            {
                sql = "select * from TASKS where TASKID ='" + taskid + "' ";
            }
            DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(sql);
            return dt;
        }

        /// <summary>
        /// 获取流程摘要
        /// </summary>
        /// <param name="taskid"></param>
        /// <returns></returns>
        public string getSummary(string processname, string incident)
        {
            string summary = "";
            string sql = "";
            if (IsOracle("UltDB"))
            {
                sql = "select  SUMMARY from INCIDENTS where trim(PROCESSNAME)=N'" + processname + "' and INCIDENT=" + incident + "";
            }
            else
            {
                sql = "select  SUMMARY from INCIDENTS where PROCESSNAME =N'" + processname + "' and INCIDENT=" + incident + "";
            }
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                summary = dt.Rows[0]["SUMMARY"].ToString();
            }
            return summary;
        }

        public DataTable GetAuthInfo(string loginName, DataTable table)
        {
            string sql = string.Format("select rdName,sdName,sdEmpNO,rdEmpNo  from proc_auth_log where  rdEmpNo in (select EMPNO from ORG_USER where CNNAME = N'{1}') and  siteCode = '{0}' and DocumentNo = '{2}'", table.Rows[0]["siteCode"], loginName, table.Rows[0]["FORMID"]);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            return dt;
        }
        public DataTable GetSiteCode(string processName, int incident)
        {
            string sql = string.Format("select sitecode,FORMID from proc_{0} where incident='{1}' ", processName, incident);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }
        /// <summary>
        /// 插入历史审批记录
        /// </summary>
        /// <param name="processname">流程名称</param>
        /// <param name="incident">实例号</param>
        /// <param name="approve">审批人</param>
        /// <param name="action">审批动作</param>      
        bool UpdateApprovalHistroy(int actionType, string processName, int incident, string stepLabel)
        {
            string sql = "update WF_APPROVALHISTORY set ACTION=N'{0}' where PROCESSNAME=N'{1}' AND INCIDENT={2} AND STEPNAME=N'{3}'";

            string ACTION = "Approve by email";
            if (actionType == 0)
            {
                ACTION = Lang.Get("History_ApproveByEmail");// "同意（邮件审批）";// Lang.Get("Approve");
            }
            if (actionType == 1)
            {
                ACTION = Lang.Get("History_ReturnByEmail");// "退回（邮件审批）"; //Lang.Get("Return");
            }
            if (actionType == 2)
            {
                ACTION = Lang.Get("History_RejectByEmail");// "拒绝（邮件审批）"; //Lang.Get("Reject");
            }
            sql = string.Format(sql, ACTION, processName, incident, stepLabel);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
            return true;
        }

        /// <summary>
        /// 插入历史审批记录
        /// </summary>
        /// <param name="processname">流程名称</param>
        /// <param name="incident">实例号</param>
        /// <param name="approve">审批人</param>
        /// <param name="action">审批动作</param>      
        bool UpdateApprovalHistroy(int actionType, string processName, int incident, string stepLabel, string loginName)
        {
            string sSql = string.Format("select cnname from org_user where loginname='{0}'", loginName.Split('/')[1]);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql);
            if (dt.Rows.Count > 0)
            {
                if (processName.Contains("OR"))
                {
                    loginName = dt.Rows[0]["cnname"].ToString();
                }
            }
            string sql = "update WF_APPROVALHISTORY set ACTION=N'{0}',APPROVERNAME=N'{4}' where PROCESSNAME=N'{1}' AND INCIDENT={2} AND STEPNAME=N'{3}'";

            string ACTION = "Approve by email";
            if (actionType == 0)
            {
                ACTION = Lang.Get("History_ApproveByEmail");// "同意（邮件审批）";// Lang.Get("Approve");
            }
            if (actionType == 1)
            {
                ACTION = Lang.Get("History_ReturnByEmail");// "退回（邮件审批）"; //Lang.Get("Return");
            }
            if (actionType == 2)
            {
                ACTION = Lang.Get("History_RejectByEmail");// "拒绝（邮件审批）"; //Lang.Get("Reject");
            }
            sql = string.Format(sql, ACTION, processName, incident, stepLabel, loginName);
            DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
            return true;
        }

        /// <summary>
        /// 获取流程对应的表名
        /// </summary>
        /// <param name="processname"></param>
        /// <returns></returns>
        private string getTableNameByProcess(string processname)
        {
            string tablename = "";
            string sql = "select * from WF_PROCESS where processname=N'" + processname.Trim() + "'";
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                tablename = dt.Rows[0]["TABLENAME"].ToString();
            }
            return tablename;
        }

        /*系统日志表
        */
        public static void insertUltimusLog(string requestaccount, string requestmark, string requesttype)
        {
            string insertSql = "insert into COM_LOG(MODULE, LOGTYPE,  FORMNAME, FORMID, LOGCONTENT,BEFOREUPDATE) values('Ultimus.UWF.Workflow','EmailSendForm','" + requestaccount + "','" + requestmark + "','" + requestmark + "','" + ConvertUtil.ToShortDateTimeString(DateTime.Now) + "')";

            DataAccess.Instance("BizDB").ExecuteNonQuery(insertSql);

        }

        private IApprovalHistory logic = ServiceContainer.Instance().GetService<IApprovalHistory>();
        void BingApprovalHistory(string processname, int incident)
        {
            try
            {

                List<ApprovalHistoryEntity> list = logic.GetApprovalHistory("", processname, incident);
                string sql = "";
                if (IsOracle("UltDB"))
                {
                    sql = @"select status,endtime from incidents where trim(processname)=@processname and incident=@incident";
                }
                else
                {
                    sql = @"select status,endtime from incidents where processname = @processname and incident=@incident";
                }
                DataTable dt = DataAccess.Instance("UltDB").ExecuteDataTable(sql, processname, incident);
                if (dt.Rows.Count > 0)
                {
                    if (ConvertUtil.ToInt32(dt.Rows[0][0]) == 2)//已完成
                    {
                        ApprovalHistoryEntity app = new ApprovalHistoryEntity();
                        app.STEPNAME = "Complete";
                        app.CREATEDATE = ConvertUtil.ToDateTime(dt.Rows[0][1]);
                        list.Add(app);
                    }
                }
                ApprovalHistoryList.DataSource = list;
                ApprovalHistoryList.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        bool IsOracle(string dbName)
        {
            string provider = MyLib.ConfigurationManager.ConnectionStrings[dbName].ProviderName;
            if (ConvertUtil.ToString(provider).ToUpper().IndexOf("ORACLE") >= 0)
            {
                return true;

            }
            return false;
        }
        private void BindSIGNNAME(int type)
        {
            string processName = txtprocessname.Text;
            string stepName = txtsteplabel.Text;
            DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_SIGNNAME");
            DataTable PRPurpose = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("SELECT EMPNO,EMPNAME FROM PROC_PROCESS_SIGN WHERE PROCESSNAME='{0}' AND  STEPNAME='{1}'and TYPE={2}", processName, stepName, type));
            fld_APPLYPURPOSE.Items.Clear();
            fld_APPLYPURPOSE.DataSource = PRPurpose;
            fld_APPLYPURPOSE.DataTextField = "EMPNAME";
            fld_APPLYPURPOSE.DataValueField = "EMPNO";
            fld_APPLYPURPOSE.DataBind();
            fld_APPLYPURPOSE.Items.Insert(0, new ListItem("", ""));

            //SELECT Code,ENName FROM [dbo].[SODEXO_t_PRPurpose] WHERE [StateCode]=1
        }
        protected void btnSIGN_Click(object sender, EventArgs e)
        {
            DataTable dt = GetTask(txttaskid.Text, txtLoginAccount.Text);
            if (dt.Rows.Count == 0)
            {
                // Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('此连接已失效！');window.opener=null;window.open('','_self');window.close()", true);
                lbResultFail.Text = Lang.Get("EmailPageApproval_LinkError"); //"此连接已失效或无权限审批！";
                divApproveResult.Visible = true;
                divApproveResultFail.Visible = true;
                return;
            }
            Submit(true);

            butSIGN.Visible = false;
            btTransfer.Visible = false;
        }
        private bool ISSIGN(int type)
        {
            string processName = txtprocessname.Text;
            string stepName = txtsteplabel.Text;
            DataTable PRPurpose = DataAccess.Instance("BizDB").ExecuteDataTable(string.Format("SELECT EMPNO,EMPNAME FROM PROC_PROCESS_SIGN WHERE PROCESSNAME='{0}' AND  STEPNAME='{1}' and TYPE={2}", processName, stepName, type));
            if (PRPurpose == null || PRPurpose.Rows.Count == 0)
                return false;
            return true;
        }
        private string GETISSIGN(int type)
        {
            string processName = txtprocessname.Text;
            string stepName = txtsteplabel.Text;
            return DataAccess.Instance("BizDB").ExecuteScalar(string.Format("SELECT ISSIGN FROM PROC_PROCESS_SIGN WHERE PROCESSNAME='{0}' AND  STEPNAME='{1}' and TYPE={2}", processName, stepName, type)).ToString();

        }
        protected void btnTransfer_Click(object sender, EventArgs e)
        {
            string processName = txtprocessname.Text;
            int incident = ConvertUtil.ToInt32(txtincident.Text);
            var fld_SIGNNAME = (DropDownList)Page.FindControl("fld_SIGNNAME");
            var signName = "CustomOC/" + fld_SIGNNAME.SelectedItem.Text;
            DataTable dt = GetTask(txttaskid.Text, txtLoginAccount.Text);
            if (dt.Rows.Count == 0)
            {
                // Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('此连接已失效！');window.opener=null;window.open('','_self');window.close()", true);
                lbResultFail.Text = Lang.Get("EmailPageApproval_LinkError"); //"此连接已失效或无权限审批！";
                divApproveResult.Visible = true;
                divApproveResultFail.Visible = true;
                return;
            }
            var sql = "update TASKS set ASSIGNEDTOUSER= N'" + signName + "' where TASKID = '" + txttaskid.Text + "' and status = 1 and ASSIGNEDTOUSER = N'" + txtLoginAccount.Text + "'";
            DataAccess.Instance("UltDB").ExecuteNonQuery(sql);
            SaveStartAddSignApprovalHistroy();
            Reminders();
            UpdateSIGN(processName, incident, signName);
            divApproveLog.Visible = true;
            butSIGN.Visible = false;
            btTransfer.Visible = false;

        }
        public bool SaveStartAddSignApprovalHistroy()
        {
            try
            {
                string processName = txtprocessname.Text;
                string stepName = txtsteplabel.Text;
                int incident = ConvertUtil.ToInt32(txtincident.Text);
                var fld_SIGNNAME = (DropDownList)Page.FindControl("fld_SIGNNAME");
                var signName = "CustomOC/" + fld_SIGNNAME.SelectedItem.Text;
                string sql = @"INSERT INTO WF_APPROVALHISTORY
                (PROCESSNAME ,INCIDENT,STEPNAME,APPROVERNAME ,APPROVERACCOUNT
                ,ACTION,COMMENTS,CREATEDATE,CHILDPROCESSNAME,CHILDINCIDENT,EXT01,ID)
                 VALUES(@PROCESSNAME ,@INCIDENT,@STEPNAME,@APPROVERNAME ,@APPROVERACCOUNT
                ,@ACTION,@COMMENTS,@CREATEDATE,@CHILDPROCESSNAME,@CHILDINCIDENT,@EXT01,@ID)"; DataAccess.Instance("BizDB").ExecuteNonQuery(sql, processName, incident, stepName, fld_SIGNNAME.SelectedItem.Text, signName, "", "转办人:" + txtLoginAccount.Text.Split('/')[1], DateTime.Now, "", "", "", SerialNoLogic.GetMaxNo("WF_APPROVALHISTORY", "ID"));
            }
            catch (Exception ex)
            {
                LogUtil.Error("Error:" + ex.Message);
                throw;
            }
            return true;
        }

        private void Reminders()
        {
            EmailNotificationSubscription emailNotification = new EmailNotificationSubscription();
            string processName = txtprocessname.Text;
            int incident = ConvertUtil.ToInt32(txtincident.Text);
            StringBuilder sSql = new StringBuilder();
            sSql.AppendFormat(@"SELECT TASKID,a.PROCESSNAME,a.INCIDENT,b.SUMMARY,b.INITIATOR,a.STEPLABEL,a.TASKUSER,a.ASSIGNEDTOUSER,a.STATUS,      a.SUBSTATUS,a.STARTTIME,a.ENDTIME,a.STEPID,a.OVERDUETIME,b.STATUS as PROCESSSTATUS,'' as SERVERNAME  FROM TASKS a WITH(NOLOCK) inner join INCIDENTS b WITH(NOLOCK) on a.processname=b.processname and a.incident=b.incident WHERE 1=1 and a.processname=N'{0}' and a.incident={1} and a.status=1 ", processName, incident);
            DataTable dtTask = DataAccess.Instance("UltDB").ExecuteDataTable(sSql.ToString());
            if (dtTask.Rows.Count > 0)
            {
                string stepLabel = string.Empty;
                string taskUser = string.Empty;
                string ti = string.Empty;
                foreach (DataRow row in dtTask.Rows)
                {
                    string hwProcessname = processName;
                    int nStepType = ConvertUtil.ToInt32(row["StepId"]);
                    string strTaskId = ConvertUtil.ToString(row["TaskID"]);

                    stepLabel = string.Format("{0};", ConvertUtil.ToString(row["STEPLABEL"]).Trim());
                    taskUser = string.Format("{0};", ConvertUtil.ToString(row["TASKUSER"]).Trim());
                    ti = string.Format("{0};", ConvertUtil.ToString(row["TASKID"]).Trim());

                    emailNotification.TaskActivated(hwProcessname, ConvertUtil.ToInt32(incident), nStepType, strTaskId);
                }

            }

        }
        private string FormatUltimusUser(string userCode)
        {
            string domain = "CustomOC";
            return string.Format("USER:org={0},user={0}/{1}", domain, userCode);
        }
        private void UpdateSIGN(string processName, int incident, string signName)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.Append(" update  [dbo].[PROC_" + processName + "] set USER_SIGNNAME='" + signName + "'  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "' and DOCUMENTNO is not null");
            DataAccess.Instance("BizDB").ExecuteNonQuery(sSql.ToString());

        }
        public void GetShow(string processName, int incident)
        {
            if ((processName == "CPR_FOOD" || processName == "OR_CPR_FOOD") && incident != -1)
            {
                StringBuilder sSql = new StringBuilder();
                sSql.Append("SELECT USER_SIGNNAME FROM [dbo].[PROC_" + processName + "]  WHERE PROCESSNAME='" + processName + "' AND INCIDENT='" + incident + "' and DOCUMENTNO is not null");
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
                if (dt.Rows.Count > 0)
                {
                    if (!string.IsNullOrWhiteSpace(dt.Rows[0]["USER_SIGNNAME"].ToString()))
                    {
                        dev_SIGNNAME.Visible = false;
                        butSIGN.Visible = false;
                        btTransfer.Visible = false;
                    }
                }

            }

        }

    }
}