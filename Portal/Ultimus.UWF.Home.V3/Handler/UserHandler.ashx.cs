using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Service.Common.Entity;

namespace Ultimus.UWF.OrgChart.Handler
{
    /// <summary>
    /// UserHandler 的摘要说明
    /// </summary>
    public class UserHandler : IHttpHandler
    {
        IOrg _org = ServiceContainer.Instance().GetService<IOrg>();
        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request.QueryString["method"];
            string returnValue = "";
            switch (method.ToUpper())
            {
                //case "GETALLUSER":
                //    returnValue = GetAllUser(context);
                //    break;
                case "GETUSERLIST":
                    returnValue = GetUserList(context);
                    break;
                    //case "GETDEPARTMENT":
                    //    returnValue = GetDepartment(context);
                    //    break;
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(returnValue);
        }

        string GetAllUser(HttpContext context)
        {
            List<UserEntity> user = GetUserList();
            return MyLib.SerializeUtil.JsonSerialize(user);
        }

        string GetUserList(HttpContext context)
        {
            string str = "";
            string text = ConvertUtil.ToString(context.Request.QueryString["text"]).Trim();
            string lan = ConvertUtil.ToString(context.Request.QueryString["lan"]).Trim();
            List<UserEntity> list = new List<UserEntity>();
            if (!string.IsNullOrEmpty(text))
            {
                list = GetUserListBySearch(text, lan);
            }
            else
            {
                list = GetUserList();
            }

            foreach (UserEntity user in list)
            {
                user.TYPE = "USER";
                if (lan == "en-us")
                {
                    user.EXT30 = "User";
                }
                else
                {
                    user.EXT30 = "用户";
                }
            }

            str = MyLib.SerializeUtil.JsonSerialize(list);
            return str;
        }

        //public List<UserEntity> GetUserList()
        //{
        //    List<UserEntity> _list;
        //    _list = new List<UserEntity>();
        //    List<UserEntity> list = DataAccess.Instance("BizDB").
        //        ExecuteList<UserEntity>("SELECT * FROM ORG_USER");
        //    _list.AddRange(list);

        //    return _list;
        //}

        public virtual List<UserEntity> GetUserList()
        {
            List<UserEntity> list = DataAccess.Instance("BizDB").ExecuteList<UserEntity>
                ("SELECT * FROM ORG_USER");
            return list;
        }

        //public List<UserEntity> GetUserList()
        //{
        //    List<UserEntity> _list;
        //    _list = new List<UserEntity>();
        //    List<UserEntity> list = DataAccess.Instance("BizDB").
        //        ExecuteList<UserEntity>("SELECT * FROM ORG_USER");
        //    _list.AddRange(list);

        //    return _list;
        //}

        public virtual List<UserEntity> GetUserListBySearch(string searchText, string lan)
        {
            List<UserEntity> list;
            if (lan == "en-us")
            {
                list = DataAccess.Instance("BizDB").ExecutePagedList<UserEntity>
                    ("SELECT * FROM ORG_USER WHERE username  like  '%'+@username+'%' or loginname  like  '%'+@username+'%' or cnname  like  '%'+@username+'%' or empno  like  '%'+@username+'%'", 0, 999, searchText);
            }
            else
            {
                list = DataAccess.Instance("BizDB").ExecutePagedList<UserEntity>
                    ("SELECT * FROM V_ORG_USER WHERE username  like  '%'+@username+'%' or jobfunction  like '%'+@username+'%' or loginname  like  '%'+@username+'%' or cnname  like  '%'+@username+'%' or empno  like  '%'+@username+'%'", 0, 999, searchText);
            }
            return list;
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