using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity; 
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Workflow.Interface;
using Ultimus.UWF.Home.V3.Logic;

namespace Ultimus.UWF.Home.V3
{
    public partial class NewTaskList : System.Web.UI.Page
    {
        List<TaskEntity> _initProcessList = new List<TaskEntity>();
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        string _userAccount = "";
        DataTable _process = new DataTable();
        IUserSettings _userSettings = ServiceContainer.Instance().GetService<IUserSettings>();
        protected void Page_Load(object sender, EventArgs e)
        {
            ////验证单点登录
            //SSO sso = new SSO();
            //sso.CheckSSO(Request["zg_sso_token_temp"], "");

            if (Request["method"] == "addfav")
            {
                AddFav(Request["taskId"], Request["processName"]);
                return;
            }

            if (Request["method"] == "removefav")
            {
                RemoveFav(Request["taskId"], Request["processName"]);
                return;
            }
            //load Favorite
            List<UserSettingsEntity> _userSettingsList = _userSettings.GetUserSettingsList(SessionLogic.GetLoginName(), "Favorite");
            ISession session = ServiceContainer.Instance().GetService<ISession>();
            session.SetSession("UserFavorite", _userSettingsList);

            _process = _workflow.GetAllInitProcess();
            //load init process
            _userAccount = SessionLogic.GetLoginName().Replace("\\", "/");
            _initProcessList = _workflow.GetInitTaskList(_userAccount, "", null, "", 0, 1000);
            canStartProcesss();
            OrderByFavourite();
            _initProcessList.Sort();

            rptTask.DataSource = _initProcessList;
            rptTask.DataBind();

            BindProcessCategory();
        }

        void canStartProcesss()
        {
            List<TaskEntity> _nocanProcList = new List<TaskEntity>();
            foreach (TaskEntity te in _initProcessList)
            {
                DataRow[] drs = _process.Select("PROCESSNAME='" + te.PROCESSNAME + "'");
                if (drs.Length > 0)
                {
                    string UnEnbleStart = ConvertUtil.ToString(drs[0]["UnEnbleStart"]);
                    if (UnEnbleStart == "1")
                    {
                        _nocanProcList.Add(te);
                    }
                }
                else
                {
                    _nocanProcList.Add(te);
                }
            }
            foreach (TaskEntity te in _nocanProcList)
            {
                _initProcessList.Remove(te);
            }
        }

        void BindProcessCategory()
        {
            List<ProcessCategoryEntity> lists = _workflow.GetCategoryList();
            ProcessCategoryEntity[] arlist = new ProcessCategoryEntity[lists.Count];
            lists.CopyTo(arlist);
            List<ProcessCategoryEntity> nlist = new List<ProcessCategoryEntity>();
            nlist.AddRange(arlist);
            if (!nlist.Exists(p => p.CATEGORYNAME == Lang.Get("NewTask_AllProcess")))
            {
                ProcessCategoryEntity pe = new ProcessCategoryEntity();
                pe.CATEGORYNAME = Lang.Get("NewTask_AllProcess");
                pe.CATEGORYENNAME = Lang.Get("NewTask_AllProcess");
                nlist.Insert(0, pe);
            }
            Repeater1.DataSource= nlist;
            Repeater1.DataBind();
        }

        void AddFav(string taskId,string processName)
        {
            _userSettings.SaveUserSettings(SessionLogic.GetLoginName(), "Favorite_" + processName, processName);
            Response.Write("ok");
            Response.End();
        }

        void RemoveFav(string taskId, string processName)
        {
            _userSettings.SaveUserSettings(SessionLogic.GetLoginName(), "Favorite_" + processName, "");
            Response.Write("ok");
            Response.End();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {            
            string categoryName = e.CommandArgument.ToString();
            List<TaskEntity> list = new List<TaskEntity>();
            if (categoryName == Lang.Get("NewTask_AllProcess"))
            {
                list = _initProcessList;
            }
            else
            {
                list = _initProcessList.FindAll(p => GetCategory(p.PROCESSNAME) == categoryName);
            }
            rptTask.DataSource = list;
            rptTask.DataBind();
        }

        void OrderByFavourite()
        {
            List<TaskEntity> tasks=_initProcessList.FindAll(p => IsFavorite(p.PROCESSNAME));
            foreach (TaskEntity task in tasks)
            {
                task.IsFavorite = 1;
            }
            _initProcessList.Sort();
        }

        public string GetImage(object processName)
        {
            DataRow[] rows = _process.Select(" PROCESSNAME='" + ConvertUtil.ToString(processName) + "'");
            if (rows.Length > 0)
            {
                string str= ConvertUtil.ToString(rows[0]["ICON"]);
                if (!string.IsNullOrEmpty(str))
                {
                    return str;
                }
            }
            return "../../Common/Assets/img/site/flow.png";
        }

        public string GetCategory(object processName)
        {
            DataRow[] rows = _process.Select(" PROCESSNAME='" + ConvertUtil.ToString(processName) + "'");
            if (rows.Length > 0)
            {
                return ConvertUtil.ToString(rows[0][Lang.Get("CategoryNameField")]);
            }
            return "";
        }

        public string GetFavorite(object processName)
        {
            ISession session = ServiceContainer.Instance().GetService<ISession>();
            List<UserSettingsEntity> list= session.GetSession("UserFavorite") as List<UserSettingsEntity>;
            bool flag=list.Exists(p => p.VALUE.Equals(ConvertUtil.ToString(processName)));
            if (flag)
            {
                return "fa fa-star color9";
            }
            else
            {
                return "fa fa-star-o";
            }
        }

        public bool IsFavorite(object processName)
        {
            ISession session = ServiceContainer.Instance().GetService<ISession>();
            List<UserSettingsEntity> list = session.GetSession("UserFavorite") as List<UserSettingsEntity>;
            bool flag = list.Exists(p => p.VALUE.Equals(ConvertUtil.ToString(processName)));
            return flag;
        }
    }
}