using MyLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Security.Interface;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.Logic
{
    public class DataSecurityLogic
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        ISecurity sec = ServiceContainer.Instance().GetService<ISecurity>();
        IOrg org = ServiceContainer.Instance().GetService<IOrg>();

        /// <summary>
        ///  获取某人对某报表的权限sqlwhere 超级管理员可以无限制
        /// </summary>
        /// <param name="Report"></param>
        /// <param name="currUsers">Page.User.Identity.Name.ToString();</param>
        /// <param name="hash"></param>
        /// <param name="sqlwhere"></param>
        /// <returns></returns>
        public ReportReturnEnum GetSqlWhere(String ProcesNam, string loginName, String Report, List<ReportColumn> hash, out String sqlwhere)
        {
            ReportReturnEnum isResult = ReportReturnEnum.NOTKnow;
            String quxianSqlWhere = string.Empty;
            try
            {                
                int userid = SessionLogic.GetUserEntity(loginName).USERID;
                // 验证当前人员是否为超级管理员
                bool flag = _workflow.IsProcessOwner(ProcesNam, loginName);

                bool isadmin = sec.CheckSuperAdmin(loginName);
                if (flag || isadmin)
                {
                    quxianSqlWhere = "";//and (INCIDENT > 0 or INCIDENT =-99)
                    isResult = ReportReturnEnum.SuperAdmin;
                    sqlwhere = quxianSqlWhere;
                    return isResult;
                }
                //本部门及下属部门
                string depts = string.Empty;
                JobEntity job = org.GetJobEntityByUserID(userid);
                if (job != null)
                {
                    if (job.ISMANAGER == "1") //部门负责人
                    {
                        depts = job.DEPARTMENTID + ",";
                        //获取部门ID及下级部门ID
                        List<DepartmentEntity> list = org.GetChildDepartmentList(ConvertUtil.ToInt32(job.DEPARTMENTID));
                        foreach (DepartmentEntity dept in list)
                        {
                            depts += dept.DEPARTMENTID + ",";
                        }
                        //sql = " and (INCIDENT > 0 or INCIDENT =-99) and departmentid in (" + depts.TrimEnd(',') + ")";
                        //return sql;
                    }
                }

                //权限数据 Sql
                

                List<ReportColumn> hashx1 = hash;
                foreach (ReportColumn temp in hashx1)
                {
                    //所有人可以查询自己的申请单  我参与过的(发起和审批)
                    if (temp.ColumnKey == ReportColumnEnum.ProcIncident)
                    {
                        //quxianSqlWhere = "and (" +  + "=N'" + userAccount + "' ";
                        //INCIDENT
                        quxianSqlWhere = string.Format(" {0} in ( select incident from WF_ApprovalHistory  where ext01='" + loginName + "' and processname=N'" + ProcesNam.Replace("'", "''") + "')",
                        temp.ColumnName);
                    }
                    if (temp.ColumnKey == ReportColumnEnum.Tianbiao)
                    {
                        quxianSqlWhere += " or " + temp.ColumnName + "=N'" + loginName + "' ";
                    }
                    if (temp.ColumnKey == ReportColumnEnum.DepartmentID && !string.IsNullOrEmpty(depts))
                    {
                        //departmentid
                        quxianSqlWhere += string.Format(" or  {0} in (" + depts.TrimEnd(',') + ")", temp.ColumnName);
                    }
                }
                if (!string.IsNullOrEmpty(quxianSqlWhere))
                {
                    quxianSqlWhere = string.Format(" and ({0})", quxianSqlWhere);
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error("DataSecurityLogic () Failed" + ex);
                quxianSqlWhere = " and 1=2";
                isResult = ReportReturnEnum.Error;
            }
            sqlwhere = quxianSqlWhere;
            return isResult;
        }

        
   
    }
    public enum ReportReturnEnum
    {
        NOTKnow = 0,//未知
        SuperAdmin = 1, //超管
        R1 = 2, //x1
        R2 = 3,//X2
        R3 = 4,//X3
        Error = 5
    }
    public enum ReportColumnEnum
    {
        APPLICANT = 1,  // 值格式 ：Global/bpmadmin
        CC = 2,  // 值格式 ：CCCODE
        Tianbiao = 3, // 值格式 ：Global/bpmadmin
                      // CCKeyUser = 4, // 值格式 ：CCCODE
        Customer = 5,// 值格式 CustomerCode
        IKA = 6,
        Industry = 7,
        Agents = 8,
        IT = 9,
        Plant = 10,
        ProcIncident = 11,
        InsideSaleCode = 12,
        DepartmentID = 13
    }
    public class ReportColumn
    {

        private ReportColumnEnum _columnKey;
        /// <summary>
        /// 表名
        /// </summary>
        public ReportColumnEnum ColumnKey
        {
            get { return _columnKey; }
            set { _columnKey = value; }
        }

        private string _columnName;
        /// <summary>
        /// 表名
        /// </summary>
        public string ColumnName
        {
            get { return _columnName; }
            set { _columnName = value; }
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            if (obj.GetType() != typeof(ReportColumn)) return false;
            ReportColumn hcc = obj as ReportColumn;
            return this.ColumnKey == hcc.ColumnKey;

        }

    }
}
