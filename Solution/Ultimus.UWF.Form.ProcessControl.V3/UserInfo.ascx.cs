using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using MyLib;
using System.Collections;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Form.Interface;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Common.Interface;

namespace Ultimus.UWF.Form.ProcessControl.V3
{
    public partial class UserInfo : System.Web.UI.UserControl
    {
        public event EventHandler AfterLoadData;
        IOrg _org = ServiceContainer.Instance().GetService<IOrg>(); //TODOSessionLogic.GetOrgType();
        IWorkflow _form = ServiceContainer.Instance().GetService<IWorkflow>();
        public string TASKHIDDEN = "";

        #region Properties
        /// <summary>
        /// 表单标题
        /// </summary>
        public string ProcessTitle
        {
            get
            {
                return lblProcessName.Text;
            }
            set
            {
                lblProcessName.Text = value;
            }
        }

        /// <summary>
        /// 流程名称
        /// </summary>
        public string ProcessName
        {
            get
            {
                return fld_PROCESSNAME.Text;
            }
            set
            {
                fld_PROCESSNAME.Text = value;
            }
        }

        public string DOCUMENTNO
        {
            get
            {
                return fld_DOCUMENTNO.Text;
            }
        }

        public string Type
        {
            get
            {
                return txtType.Text;
            }
            set
            {
                txtType.Text = value;
            }
        }

        /// <summary>
        /// 所对应的表名
        /// </summary>
        public string TableName
        {
            get
            {
                if (string.IsNullOrEmpty(txtTableName.Text))
                {
                    txtTableName.Text = "PROC_" + ProcessName;
                }
                return txtTableName.Text;
            }
            set
            {
                txtTableName.Text = value;
            }
        }
        /// <summary>
        /// 所对应的子表表名，多个以逗号分隔
        /// </summary>
        public string TableNameDetail
        {
            get
            {
                return txtTableNameDetail.Text;
            }
            set
            {
                txtTableNameDetail.Text = value;
            }
        }
        /// <summary>
        /// 是否提交开始步骤流程变量
        /// </summary>
        public bool IsSubmitBeginStepVars
        {
            get
            {
                if (txtIsVarSubmit.Text == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            set
            {
                if (value)
                {
                    txtIsVarSubmit.Text = "1";
                }
                else
                {
                    txtIsVarSubmit.Text = "0";
                }

            }
        }

        /// <summary>
        /// 是否新建
        /// </summary>
        public bool IsCreateForm
        {
            get
            {
                if (txtIsCreateForm.Text == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            set
            {
                if (value)
                {
                    txtIsCreateForm.Text = "1";
                }
                else
                {
                    txtIsCreateForm.Text = "0";
                }

            }
        }
        /// <summary>
        /// 是否只读
        /// </summary>
        public bool ReadOnly
        {
            get
            {
                if (txtReadOnly.Text == "1")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            set
            {
                if (value)
                {
                    txtReadOnly.Text = "1";
                }
                else
                {
                    txtReadOnly.Text = "0";
                }
                //fld_COMPANY.Visible = !value;
                fld_PROCESSSUMMARY.Visible = !value;
                lblCOMPANY.Visible = value;
                lblSummary.Visible = value;
            }
        }

        /// <summary>
        /// 实例号
        /// </summary>
        public string Incident
        {
            get
            {
                return fld_INCIDENT.Text;
            }
            set
            {
                fld_INCIDENT.Text = value;
            }
        }

        /// <summary>
        /// 表单Guid，唯一键
        /// </summary>
        public string FormID
        {
            get
            {
                return fld_FORMID.Text;
            }
            set
            {
                fld_FORMID.Text = value;
            }
        }

        /// <summary>
        /// 流程前缀，一般用于流程编号
        /// </summary>
        public string ProcessPrefix
        {
            get
            {
                return txtProcessPrefix.Text;
            }
            set
            {
                txtProcessPrefix.Text = value;
            }
        }

        /// <summary>
        /// 流程摘要
        /// </summary>
        public string Summary
        {
            get
            {
                return StringFilter.FilterHtmls(StringFilter.FilterSql(ConvertUtil.ToString(fld_PROCESSSUMMARY.Text)));
            }
            set
            {
                fld_PROCESSSUMMARY.Text = StringFilter.FilterHtmls(StringFilter.FilterSql(ConvertUtil.ToString(value)));
            }
        }

        /// <summary>
        /// 任务号
        /// </summary>
        public string TaskID
        {
            get
            {
                return txtTaskId.Text;
            }
            set
            {
                txtTaskId.Text = value;
            }
        }

        /// <summary>
        /// 步骤名
        /// </summary>
        public string StepName
        {
            get
            {
                return txtStepName.Text;
            }
            set
            {
                txtStepName.Text = value;
            }
        }

        public string CompanyID
        {
            get { return fld_COMPANYID.Text; }
        }

        public string Applicant
        {
            get { return fld_APPLICANT.Text; }
        }

        public string ApplicantAccount
        {
            get { return fld_APPLICANTACCOUNT.Text; }
        }


        #endregion
        public void Alert(string msg)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert(\"" + msg.Replace("\r\n", " ").Replace("\n", "").Replace("'", "") + "\");</script>");
        }
        protected void Page_Load(object sender, EventArgs e)
        {


            if (string.IsNullOrEmpty(Request.QueryString["TaskId"]) && Request.QueryString["hasformid"] == "0")
            {
                throw new Exception("Current user have no rights to view it!");
            }
            //判断访问路径与配置路径一至性，否则无权限访问
            IStepSettings stepSettings = ServiceContainer.Instance().GetService<IStepSettings>();
            //清除缓存
            stepSettings.ClearCache();
            StepSetting stepPage = stepSettings.GetStep(ConvertUtil.ToString(Request.QueryString["ProcessName"]), ConvertUtil.ToString(Request.QueryString["StepName"])); //.net表单
            txtSetpType.Text = stepPage.StepType;
            string type = ConvertUtil.ToString(Request.QueryString["Type"]).ToUpper();
            if (type != "PRINT" && type != "REPORT")
            {
                // if ("/" + stepPage.PageName != Request.Url.AbsolutePath)
                //{
                //   throw new Exception("Current user have no rights to view it!");
                // }
            }
            Page.LoadComplete += Page_LoadComplete;
            if (!IsPostBack)
            {

                string emailType = ConvertUtil.ToString(Request.QueryString["EmailType"]);
                string username = ConvertUtil.ToString(Request.QueryString["username"]);
                if (emailType.ToLower() == "email")
                {
                    ISession session = ServiceContainer.Instance().GetService<ISession>();
                    session.Login(username, "");
                }

                fld_PROCESSNAME.Text = Request.QueryString["ProcessName"];
                fld_INCIDENT.Text = Request.QueryString["Incident"];
                incident.Text = Request.QueryString["Incident"];
                txtTaskId.Text = Request.QueryString["TaskId"];
                txtStepName.Text = Request.QueryString["StepName"];
                txtType.Text = type;
                txtApplicantAccount.Text = Request.QueryString["UserName"];
                fld_FORMID.Text = Request.QueryString["FORMID"];
                if (string.IsNullOrEmpty(fld_FORMID.Text))
                {
                    fld_FORMID.Text = Guid.NewGuid().ToString();
                }

                if (string.IsNullOrEmpty(fld_PROCESSNAME.Text))
                {
                    return;
                }

                var_ApplicantAccount.Text = SessionLogic.GetLoginName().Replace("\\", "/");
                UserEntity user = SessionLogic.GetUserEntity(SessionLogic.GetLoginName());
                //新建流程
                if (ConvertUtil.ToInt32(fld_INCIDENT.Text) == 0)
                {
                    //如果是新建给FormID重新赋值 //新建流程openForm的时候已经取得值了。从新取会导致内存和URL不一致。
                   //fld_FORMID.Text = Guid.NewGuid().ToString();
                  
                    //填表人姓名\工号
                    fld_CREATEBY.Text = user.USERNAME + "(" + user.CNNAME + ")";
                    fld_CREATEBYCODE.Text = user.EMPNO;//工号
                    fld_CREATEBYACCOUNT.Text = user.LOGINNAME;//账号
                    fld_PROCESSVERSION.Text = ConvertUtil.ToString(_form.GetTaskEntity("", txtTaskId.Text.Trim()).PROCESSVERSION);
                    //new
                    //员工职级
                    read_JOBLEVEL.Text = user.EXT16;
                    fld_JOBLEVEL.Text = user.EXT16;

                    //员工职等
                    read_GRADE.Text = user.EXT17;
                    fld_GRADE.Text = user.EXT17;
                    read_GRADECODE.Text = user.EXT19;
                    fld_GRADECODE.Text = user.EXT19;
                    fld_JUDGELOGIC1.Text = user.EXT09;
                    fld_JUDGELOGIC2.Text = user.EXT26;
                    //部门等级

                    fld_DEPARTMENTLEVEL.Text = user.EXT29;

                    //申请人姓名\工号
                    //fld_APPLICANT_VALUE.Text = user.DOMAIN.ToString() + "\\" + user.LOGINNAME.ToString();
                    //Alert(user.DOMAIN.ToString() + "\\" + user.LOGINNAME.ToString());
                    fld_APPLICANT.Text = user.USERNAME;//姓名
                    //txt_APPLICANT.Text = user.USERNAME;
                    read_APPLICANT.Text = user.USERNAME;
                    fld_APPLICANTCODE.Text = user.EMPNO;//工号
                    read_APPLICANTCODE.Text = user.EMPNO;//工号
                    fld_APPLICANTACCOUNT.Text = user.LOGINNAME;//账号
                    fld_APPLICANTTEL.Text = user.MOBILENO; //电话
                    read_APPLICANTTEL.Text = user.MOBILENO;
                    //公司
                    //fld_COMPANY.Text = user.COMPANY;
                    //岗位信息
                    read_JOBFUNCTION.Text = user.FUNCTIONAL;
                    fld_JOBFUNCTION.Text = user.FUNCTIONAL;
                    //邮箱
                    read_EMAIL.Text = user.EMAIL;
                    fld_EMAIL.Text = user.EMAIL;
                    //岗位信息
                    fld_JUDGELOGIC3.Text = user.ENNAME;
                    read_ENNAME.Text = user.ENNAME;
                    //申请人成本中心
                    //fld_COSTCENTER.Text = user.COSTCENTER;
                    fld_COSTCENTERID.Text = user.EXT05;
                    read_COSTCENTER.Text = user.COSTCENTER;

                    // fld_COMPANYID.Text = user.EXT03;
                    //公司 
                    // read_COMPANY.Text = user.COMPANY;
                    //申请日期


                    //部门ID
                    //fld_DEPARTMENTID.Text = user.DEPARTMENTID+"";
                    ////部门
                    //fld_DEPARTMENT.Text = user.DEPARTMENT;
                    //read_DEPARTMENT.Text = user.DEPARTMENT;



                    //fld_UTCREQUESTDATE.Text = DateTime.Now.ToUniversalTime().ToString("r");//UTC时间
                    fld_REQUESTDATE.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
                    //申请人部门
                    List<DepartmentEntity> Depts = _org.GetUserDepartments(SessionLogic.GetLoginName());
                    if (Depts != null && Depts.Count > 0)
                    {
                        fld_DEPARTMENTID.Text = Depts[0].DEPARTMENTID + "";
                        IOrg org = ServiceContainer.Instance().GetService<IOrg>();
                        string DEPARTMENTNAME = org.GetUserDepartment(Depts[0].DEPARTMENTID);

                        fld_DEPARTMENT.Text = Depts[0].DEPARTMENTNAME;
                        read_DEPARTMENT.Text = Depts[0].DEPARTMENTNAME;

                    }
                    fld_DOCUMENTNO.Visible = false;
                    lblDocumentNo.Visible = false;
                    this.IsCreateForm = true;
                    //lblIncident.Visible = false;
                    //lblStatus.Visible = false;
                }
                else //打开待办或已办
                {                  
                    lblDocumentNo.Visible = true;
                    fld_DOCUMENTNO.Visible = true;
                    this.IsCreateForm = false;
                    lblSummary.Text = fld_PROCESSSUMMARY.Text;
                    TASKHIDDEN = "hidden";
                    fld_APPLICANTTEL.CssClass = "hidden";
                    
                  
                }

                //从草稿或者重发起打开
                if (txtType.Text.ToUpper().Trim() == "DRAFT" || (stepSettings.GetFirstStep(ProcessName) != null &&
                    stepSettings.GetFirstStep(ProcessName).Equals(StepName) && txtType.Text.ToUpper().Trim() == "MYTASK"))
                {
                    var_ApplicantAccount.Text = SessionLogic.GetLoginName().Replace("\\", "/");
                    this.IsCreateForm = true;
                }
                if (txtType.Text.ToUpper().Trim() == "DRAFT")
                {
                    TaskEntity task = _form.GetTaskEntity("", txtTaskId.Text.Trim());
                    if (task != null)
                        fld_PROCESSVERSION.Text = ConvertUtil.ToString(task.PROCESSVERSION);
                }

                //显示编辑页面按钮
                IWorkflow pl = ServiceContainer.Instance().GetService<IWorkflow>();
                if (!string.IsNullOrEmpty(SessionLogic.GetLoginName()) && pl.IsProcessOwner(Request.QueryString["ProcessName"], SessionLogic.GetLoginName()))
                {
                    editBtn.Visible = true;
                }

            }
        }

        void Page_LoadComplete(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ConvertUtil.ToInt32(fld_INCIDENT.Text) > 0 || txtType.Text.ToUpper().Trim() == "DRAFT" || txtType.Text.ToUpper().Trim() == "PRINT")
                {
                    //加载表单数据
                    _form.SetFormData(this, fld_FORMID.Text);
                    var_ApplicantAccount.Text = SessionLogic.GetLoginName().Replace("\\", "/");
                    UserEntity user = SessionLogic.GetUserEntity(SessionLogic.GetLoginName());
                    if (fld_CREATEBY.Text == "systemAuto")
                    {
                        var enName = SessionLogic.GetLoginName().Replace("CustomOC\\", "");
                        fld_CREATEBY.Text = enName + "(" + enName + ")";
                        fld_CREATEBYCODE.Text = user.EMPNO;//工号
                        fld_CREATEBYACCOUNT.Text = user.LOGINNAME;//账号
                        //fld_PROCESSVERSION.Text = ConvertUtil.ToString(_form.GetTaskEntity("", txtTaskId.Text.Trim()).PROCESSVERSION);
                        fld_APPLICANT.Text = user.USERNAME;//姓名
                                                           //txt_APPLICANT.Text = user.USERNAME;
                        read_APPLICANT.Text = enName + "(" + enName + ")";
                        fld_APPLICANTCODE.Text = user.EMPNO;//工号
                        read_APPLICANTCODE.Text = user.EMPNO;//工号
                        fld_APPLICANTACCOUNT.Text = user.LOGINNAME;//账号
                        fld_APPLICANTTEL.Text = user.MOBILENO; //电话
                        read_APPLICANTTEL.Text = user.MOBILENO;
                    }
                    //QRCodeLogic qr=new QRCodeLogic();
                    //imgQRCode.ImageUrl = qr.CreateQRCode(fld_DOCUMENTNO.Text, 1);
                }

                if (txtType.Text.ToUpper().Trim() == "DRAFT")
                {
                    fld_REQUESTDATE.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
                }
                read_APPLICANTACCOUNT.Text = fld_APPLICANTACCOUNT.Text.Replace("CustomOC\\", "");
            }

            if (AfterLoadData != null)
            {
                AfterLoadData(sender, e);
            }
        }

        #region 表单明细数据

        /// <summary>
        /// 明细行新增一行
        /// </summary>
        /// <param name="ctl"></param>
        public void AddNewRow(Control ctl)
        {
            DataTable dt = null;
            dt = _form.GetDetailData(this, ctl, FormID);// GetDetailData(ctl);获取明细行中的数据           
            dt.Rows.Add(dt.NewRow());
            _form.BindListValue(ctl, dt);
        }
        /// <summary>
        /// 明细行删除一行
        /// </summary>
        /// <param name="ctl"></param>
        /// <param name="e"></param>
        public void DeleteRow(Control ctl, int ItemIndex)
        {
            DataTable dt = null;
            dt = _form.GetDetailData(this, ctl, FormID);// GetDetailData(ctl);获取明细行中的数据   
            if (dt != null && dt.Rows.Count > ItemIndex)
                dt.Rows[ItemIndex].Delete();
            dt.AcceptChanges();
            _form.BindListValue(ctl, dt);
        }

        /// <summary>
        /// 明细行删除多行
        /// </summary>
        /// <param name="ctl"></param>
        /// <param name="e"></param>
        public void DeleteRow(Control ctl, List<int> ItemIndexs)
        {
            DataTable dt = null;
            dt = _form.GetDetailData(this, ctl, FormID);// GetDetailData(ctl);获取明细行中的数据  
            foreach (int i in ItemIndexs)
            {
                if (dt != null && dt.Rows.Count > i)
                    dt.Rows[i].Delete();
            }
            dt.AcceptChanges();
            _form.BindListValue(ctl, dt);
        }

        #endregion


    }
}