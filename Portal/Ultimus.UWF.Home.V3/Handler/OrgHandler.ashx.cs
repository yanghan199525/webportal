using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Home.V3.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Service.Common.Entity;

namespace Ultimus.UWF.OrgChart.Handler
{
    /// <summary>
    /// OrgHandler 的摘要说明
    /// </summary>
    public class OrgHandler : IHttpHandler, IRequiresSessionState
    {

        IOrg _org = ServiceContainer.Instance().GetService<IOrg>();
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                // 判断管理员是否登录
                string enableSSO = ConfigurationManager.AppSettings["EnableSSO"];//是否启用SSO单点登录
                if (enableSSO == "1")
                {
                    string HRLoginUrl = ConfigurationManager.AppSettings["HRLoginForm"];// 获取HR登录页面
                    if (!SSO.SSOLogin(""))
                        throw new Exception("用户信息失效，请重新登陆！"); ;
                }
            }
            catch (Exception ex)
            {
                context.Response.Write(ex.Message);
                throw;
            }

            string method = context.Request.QueryString["method"];
            string returnValue = "";
            switch (method.ToUpper())
            {
                case "GETALLDEPARTMENT":
                    returnValue = GETALLDEPARTMENT(context);
                    break;
                case "GETUSERANDDEPARTMENTLISTBYDEPARTMENTID":
                    returnValue = GetUserAndDepartmentListByDepartmentID(context);
                    break;
                case "COPYDEAPRTMENTORUSER":

                    returnValue = CopyDeaprtmentOrUser(context);
                    break;
                case "GETDEPARTMENT":
                    returnValue = GetDepartment(context);
                    break;

                case "GETGROUP":
                    returnValue = GetGroup(context);
                    break;
                case "GETUSERLISTBYDEPARTMENTID":
                    returnValue = GetUserListByDepartmentID(context);
                    break;
                case "GETUSERLIST":
                    returnValue = GetUserList(context);
                    break;
                case "GETDEPARTMENTLIST":
                    returnValue = GetDepartmentList(context);
                    break;

            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(returnValue);
        }

        string GETALLDEPARTMENT(HttpContext context)
        {
            List<DepartmentEntity> dept = _org.GetDepartmentList();
            return MyLib.SerializeUtil.JsonSerialize(dept);
        }
        /// <summary>
        /// 判断时间段是否重叠
        /// </summary>
        /// <param name="startdate1"></param>
        /// <param name="enddate1"></param>
        /// <param name="startdate2"></param>
        /// <param name="enddate2"></param>
        /// <returns></returns>
        public static bool CheckTimeOverlap(DateTime startdate1, DateTime enddate1, DateTime startdate2, DateTime enddate2)
        {
            //判断两个时间段是否重叠，如：

            //startdate1 — enddate1

            //startdate2 — enddate2

            //两个时间的重叠分4种情况，若你一一列出这四种情况来判断是否重叠那就弱爆了，最简单的方法：

            //startdate1 <=enddate2 and enddate1>=startdate2

            //若你无法理解上面这种方法，那我还有下面的方法提供给你：

            //(startdate1 BETWEEN startdate2 AND enddate2)

            //or (enddate1 BETWEEN startdate2 AND enddate2)

            //or (startdate2 BETWEEN startdate1 AND enddate1)

            //or (enddate2 BETWEEN startdate1 AND enddate1)

            //判断时间不能重叠
            bool isResult = false;
            if (!(startdate1.CompareTo(enddate2) > 0 || enddate1.CompareTo(startdate2) < 0))
            {
                //重合  
                isResult = true;
            }
            return isResult;
        }

        /// <summary>
        /// 获得部门信息
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        string GetDepartment(HttpContext context)
        {

            string str = "";
            int parentid = ConvertUtil.ToInt32(context.Request.QueryString["parentid"]);
            DateTime EFFECTFROM = ConvertUtil.ToDateTime(context.Request.QueryString["EFFECTFROM"]);
            DateTime EFFECTTO = ConvertUtil.ToDateTime(context.Request.QueryString["EFFECTTO"]);

            List<DepartmentEntity> depts = _org.GetChildDepartmentListFirstLevel(parentid).FindAll(p =>
                CheckTimeOverlap(EFFECTFROM, EFFECTTO, ConvertUtil.ToDateTime(p.EFFECTFROM), ConvertUtil.ToDateTime(p.EFFECTTO)) == true ||
            (string.IsNullOrEmpty(p.EFFECTTO.ToString()) && string.IsNullOrEmpty(p.EFFECTFROM.ToString())));
            List<LabelValueEntity> list = new List<LabelValueEntity>();
            foreach (DepartmentEntity dept in depts)
            {
                LabelValueEntity ety = new LabelValueEntity();
                ety.label = dept.DEPARTMENTNAME;
                ety.value = dept.DEPARTMENTID.ToString();
                ety.parentValue = dept.PARENTID.ToString();
                int count = ConvertUtil.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar("select count(1) from org_department where parentid=@parentid",
                    dept.DEPARTMENTID));
                if (count > 0)
                {
                    ety.items = new List<LabelValueEntity> { new LabelValueEntity { label = "Loading...",
                        value = "../Handler/OrgHandler.ashx?method=GetDepartment&parentid="+dept.DEPARTMENTID } };
                }
                list.Add(ety);
            }

            str = MyLib.SerializeUtil.JsonSerialize(list);
            return str;
        }

        string CopyDeaprtmentOrUser(HttpContext context)
        {
            try
            {
                //需要复制的部门id 或人员ID
                string _id = context.Request.QueryString["id"];
                //复制到这个部门id下
                string _selectparentid = context.Request.QueryString["SelectParentId"];
                //_type   user:用户  department:部门
                string _type = context.Request.QueryString["type"];
                //是否复制下级 1：复制  否则不复制
                string _copychildren = context.Request.QueryString["copychildren"];
                string _effectfrom = context.Request.QueryString["effectfrom"];
                string _effectto = context.Request.QueryString["effectto"];
                //获得需要复制的部门 只复制当前部门下的子部门

                if (_type.ToUpper() == "USER")
                {
                    JobEntity _job = _org.GetJobEntityByUserID(ConvertUtil.ToInt32(_id));
                    _job.JOBID = SerialNoLogic.GetMaxNo("ORG_JOB", "JOBID");
                    _job.DEPARTMENTID = ConvertUtil.ToInt32(_selectparentid);
                    _org.InsertJob(_job);
                }
                else
                {
                    DepartmentEntity _oldDpartment = _org.GetDepartmentEntity(ConvertUtil.ToInt32(_id));
                    _oldDpartment.OLDDEPARTMENTID = _oldDpartment.DEPARTMENTID;
                    _oldDpartment.DEPARTMENTID = SerialNoLogic.GetMaxNo("ORG_DEPARTMENT", "DEPARTMENTID");
                    _oldDpartment.PARENTID = ConvertUtil.ToInt32(_selectparentid);
                    //不复制子部门
                    if (_copychildren != "1")
                    {
                        _org.InsertDepartment(_oldDpartment);
                        List<JobEntity> _jobListForDepartment = _org.GetALLJob().FindAll(p => p.DEPARTMENTID == _oldDpartment.OLDDEPARTMENTID);
                        foreach (JobEntity jobitem in _jobListForDepartment)
                        {
                            jobitem.JOBID = SerialNoLogic.GetMaxNo("ORG_JOB", "JOBID");
                            jobitem.DEPARTMENTID = _oldDpartment.DEPARTMENTID;
                            _org.InsertJob(jobitem);
                        }
                    }
                    //复制子部门
                    else
                    {
                        int DEPARTMENTID = _oldDpartment.DEPARTMENTID + 1;
                        int JOBID = SerialNoLogic.GetMaxNo("ORG_JOB", "JOBID");
                        //获得当前部门和所有子部门
                        List<DepartmentEntity> _newList = _org.GetChildDepartmentList(ConvertUtil.ToInt32(_id)).FindAll(delegate(DepartmentEntity dmodel)
                        {
                            dmodel.OLDDEPARTMENTID = dmodel.DEPARTMENTID;
                            dmodel.DEPARTMENTID = DEPARTMENTID;
                            DEPARTMENTID += 1;
                            return true;
                        });
                        _newList.Add(_oldDpartment);
                        //获得当前部门和所有子部门 下的岗位
                        List<JobEntity> _joblist = _org.GetALLJob().FindAll(delegate(JobEntity jobmodel)
                        {
                            if (_newList.FindAll(p => p.OLDDEPARTMENTID == ConvertUtil.ToInt32(jobmodel.DEPARTMENTID)).Count > 0)
                                return true;
                            else
                                return false;

                        });
                        //新增部门与岗位到数据库
                        foreach (DepartmentEntity item in _newList)
                        {
                            if (item != _oldDpartment)
                            {
                                item.PARENTID = _newList.Find(p => p.OLDDEPARTMENTID == item.PARENTID).DEPARTMENTID;
                            }
                            _org.InsertDepartment(item);
                            List<JobEntity> _jobListForDepartment = _joblist.FindAll(p => ConvertUtil.ToInt32(p.DEPARTMENTID) == item.OLDDEPARTMENTID);
                            foreach (JobEntity jobitem in _jobListForDepartment)
                            {
                                jobitem.JOBID = JOBID;
                                jobitem.DEPARTMENTID = item.DEPARTMENTID;
                                JOBID += 1;
                                _org.InsertJob(jobitem);
                            }
                        }


                    }
                }
                return "1";
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        string GetGroup(HttpContext context)
        {
            string str = "";
            List<GroupEntity> groups = _org.GetGroupList();
            List<LabelValueEntity> list = new List<LabelValueEntity>();
            List<LabelValueEntity> items = new List<LabelValueEntity>();
            LabelValueEntity ety = new LabelValueEntity();
            ety.label = "所有组";
            ety.value = "0";

            foreach (GroupEntity group in groups)
            {
                LabelValueEntity ety1 = new LabelValueEntity();
                ety1.label = group.GROUPNAME;
                ety1.value = group.GROUPID.ToString();
                items.Add(ety1);
            }
            ety.items = items;
            list.Add(ety);

            str = MyLib.SerializeUtil.JsonSerialize(list);
            return str;
        }

        string ConertDateToString(DateTime time)
        {
            string _strTime = ConvertUtil.ToDateTime(time).ToString("yyyy/MM/dd");
            return _strTime == "0001/01/01" ? "" : _strTime;
        }


        //获得当前部门下面所有的子部门与用户
        string GetUserAndDepartmentListByDepartmentID(HttpContext context)
        {
            string str = "";
            List<OrganizationUserAndDepartment> OrgList = new List<OrganizationUserAndDepartment>();
            int id = ConvertUtil.ToInt32(context.Request.QueryString["departmentid"]);
            DateTime EFFECTFROM = ConvertUtil.ToDateTime(context.Request.QueryString["EFFECTFROM"]);
            DateTime EFFECTTO = ConvertUtil.ToDateTime(context.Request.QueryString["EFFECTTO"]);
            #region 不管如何 先把选中的部门加载到右边的列表中

            DepartmentEntity _departmentEntity = _org.GetDepartmentEntity(id);
            OrganizationUserAndDepartment Org = new OrganizationUserAndDepartment();
            Org.departmenttype = _departmentEntity.DEPARTMENTTYPE;
            Org.endtime = ConertDateToString(ConvertUtil.ToDateTime(_departmentEntity.EFFECTTO));
            Org.id = _departmentEntity.DEPARTMENTID.ToString();
            Org.name = _departmentEntity.DEPARTMENTNAME;
            Org.parentid = _departmentEntity.PARENTID.ToString();
            if (_departmentEntity.PARENTID != 0)
            {
                DepartmentEntity _parentDepartmentEntity = _org.GetDepartmentEntity(_departmentEntity.PARENTID);
                Org.parentdepartment = _parentDepartmentEntity.DEPARTMENTNAME;
                OrgList.Add(Org);
            }
            #endregion

            //获得开始游戏期或者结束有效期为空或者符合帅选条件（名称，开始有效期，结束有效期）的数据
            List<DepartmentEntity> depts = _org.GetChildDepartmentListFirstLevel(id).FindAll(p =>
                CheckTimeOverlap(EFFECTFROM, EFFECTTO, ConvertUtil.ToDateTime(p.EFFECTFROM), ConvertUtil.ToDateTime(p.EFFECTTO)) == true ||
                (string.IsNullOrEmpty(p.EFFECTTO.ToString()) && string.IsNullOrEmpty(p.EFFECTFROM.ToString())));
            List<UserEntity> Userlist = _org.GetUserListByDepartmentID(ConvertUtil.ToInt32(id)).FindAll(p =>
                CheckTimeOverlap(EFFECTFROM, EFFECTTO, ConvertUtil.ToDateTime(p.EFFECTFROM), ConvertUtil.ToDateTime(p.EFFECTTO)) == true ||
                (string.IsNullOrEmpty(p.EFFECTTO.ToString()) && string.IsNullOrEmpty(p.EFFECTFROM.ToString())));
            foreach (DepartmentEntity dept in depts)
            {
                Org = new OrganizationUserAndDepartment();
                Org.departmenttype = dept.DEPARTMENTTYPE;
                Org.endtime = ConertDateToString(ConvertUtil.ToDateTime(dept.EFFECTTO));
                Org.id = dept.DEPARTMENTID.ToString();
                Org.name = dept.DEPARTMENTNAME;
                Org.parentid = dept.PARENTID.ToString();
                DepartmentEntity depaentity = _org.GetDepartmentEntity(dept.PARENTID);
                Org.parentdepartment = depaentity.DEPARTMENTNAME;
                OrgList.Add(Org);
            }
            foreach (UserEntity User in Userlist)
            {
                Org = new OrganizationUserAndDepartment();
                Org.endtime = ConertDateToString(ConvertUtil.ToDateTime(User.EFFECTFROM));
                Org.jobfunction = User.JOBFUNCTION;
                Org.departmenttype = "User";
                Org.id = User.USERID.ToString();
                Org.name = User.USERNAME;
                Org.parentid = id.ToString();
                Org.starttime = ConertDateToString(ConvertUtil.ToDateTime(User.EFFECTTO));
                DepartmentEntity depaentity = _org.GetDepartmentEntity(id);
                Org.parentdepartment = depaentity.DEPARTMENTNAME;
                OrgList.Add(Org);
            }

            str = MyLib.SerializeUtil.JsonSerialize(OrgList);
            return str;
        }

        string GetUserListByDepartmentID(HttpContext context)
        {
            string str = "";
            int id = ConvertUtil.ToInt32(context.Request.QueryString["departmentid"]);
            List<UserEntity> list = _org.GetUserListByDepartmentID(ConvertUtil.ToInt32(id));

            foreach (UserEntity user in list)
            {
                user.TYPE = "USER";
                user.EXT30 = "User";
            }

            str = MyLib.SerializeUtil.JsonSerialize(list);
            return str;
        }

        string GetUserList(HttpContext context)
        {
            string str = "";
            string text = ConvertUtil.ToString(context.Request.QueryString["text"]).Trim();
            string org = ConvertUtil.ToString(context.Request.QueryString["org"]).Trim().ToLower();
            int id = ConvertUtil.ToInt32(context.Request.QueryString["departmentid"]);

            string url = context.Request.Url.ToString();
            url = url.Substring(url.IndexOf("?") + 1, url.Length - url.IndexOf("?") - 1);
            if (StringFilter.IsSafeSqlString(url))
            {
                if (id == 0)
                {
                    id = -1;
                }
                List<UserEntity> list = new List<UserEntity>();
                if (!string.IsNullOrEmpty(text))
                {
                    list = _org.GetUserListBySearch(text);
                }
                else
                {
                    if (org.ToUpper() == "GROUP")
                    {
                        DataTable dt = _org.GetGroupMember(id.ToString());
                        foreach (DataRow row in dt.Rows)
                        {
                            int membertype = ConvertUtil.ToInt32(row["GROUPMEMBERTYPE"]);
                            if (membertype == 1)
                            {
                                UserEntity user = new UserEntity();
                                user.USERID = ConvertUtil.ToInt32(row["GROUPMEMBERID"]);
                                user.USERNAME = ConvertUtil.ToString(row["GROUPMEMBERNAME"]);
                                user.TYPE = "USER";
                                user.EXT30 = "User";
                                list.Add(user);
                            }
                        }
                    }
                    else
                    {
                        list = _org.GetUserListByDepartmentID(ConvertUtil.ToInt32(id));
                    }
                }

                foreach (UserEntity user in list)
                {
                    user.TYPE = "USER";
                    user.EXT30 = "User";
                }

                str = MyLib.SerializeUtil.JsonSerialize(list);
            }
            return str;
        }

        string GetDepartmentList(HttpContext context)
        {
            string str = "";
            string text = ConvertUtil.ToString(context.Request.QueryString["text"]).Trim();
            string org = ConvertUtil.ToString(context.Request.QueryString["org"]).Trim();
            int id = ConvertUtil.ToInt32(context.Request.QueryString["departmentid"]);
            if (id == 0)
            {
                id = -1;
            }
            List<DepartmentEntity> depts = new List<DepartmentEntity>();
            List<UserEntity> list = new List<UserEntity>();
            if (!string.IsNullOrEmpty(text))
            {
                depts = DataAccess.Instance("BizDB").
                ExecutePagedList<DepartmentEntity>("SELECT * FROM ORG_DEPARTMENT WHERE DEPARTMENTNAME like N'%" + text.Replace("'", "''") + "%'", 0, 999);
            }
            else
            {
                if (org.ToUpper() == "GROUP")
                {
                    DataTable dt = _org.GetGroupMember(id.ToString());
                    foreach (DataRow row in dt.Rows)
                    {
                        int membertype = ConvertUtil.ToInt32(row["GROUPMEMBERTYPE"]);
                        if (membertype == 3)
                        {
                            UserEntity user = new UserEntity();
                            user.USERID = ConvertUtil.ToInt32(row["GROUPMEMBERID"]);
                            user.USERNAME = ConvertUtil.ToString(row["GROUPMEMBERNAME"]);
                            user.TYPE = "DEPT";
                            user.EXT30 = "Department";
                            list.Add(user);
                        }
                    }
                }
                else
                {
                    depts = _org.GetChildDepartmentListFirstLevel(ConvertUtil.ToInt32(id));
                }
            }

            foreach (DepartmentEntity dept in depts)
            {
                UserEntity user = new UserEntity();
                user.USERNAME = dept.DEPARTMENTNAME;
                user.TYPE = "DEPT";
                user.EXT30 = "Department";
                user.USERID = dept.DEPARTMENTID;
                list.Add(user);
            }

            str = MyLib.SerializeUtil.JsonSerialize(list);
            return str;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}