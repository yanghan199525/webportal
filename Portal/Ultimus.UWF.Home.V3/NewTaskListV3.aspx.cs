using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Entity;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class NewTaskListV3 : System.Web.UI.Page
    {
        #region "全局变量"
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        IUserSettings usl = ServiceContainer.Instance().GetService<IUserSettings>();
        List<TaskEntity> _initProcessList = new List<TaskEntity>();
        DataTable _process = new DataTable();
        IUserSettings _userSettings = ServiceContainer.Instance().GetService<IUserSettings>();
        ISession session = ServiceContainer.Instance().GetService<ISession>();
        #endregion

        #region "页面事件"
        protected void Page_Load(object sender, EventArgs e)
        {
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
            if (!IsPostBack)
            {
                List<UserSettingsEntity> _userSettingsList = usl.GetUserSettingsList(SessionLogic.GetLoginName(), "Favorite");
                ISession session = ServiceContainer.Instance().GetService<ISession>();
                session.SetSession("UserFavorite", _userSettingsList);
                //绑定流程分类
                rpProcessCategory.DataSource = ProcessCategoryInit();
                rpProcessCategory.DataBind();
                //绑定流程列表
                rptTask.DataSource = ProcessInit();
                rptTask.DataBind();
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string categoryName = e.CommandArgument.ToString();
            List<TaskEntity> list = ProcessInit();
            txtProcessCategory.Text = categoryName;
            if (categoryName == "所有流程" || categoryName.ToLower() == "all process")
            {

            }
            else if (categoryName == "收藏" || categoryName.ToLower() == "favorite")
            {
                List<UserSettingsEntity> favs = usl.GetUserSettingsList(SessionLogic.GetLoginName(), "Favorite");
                list = (from fav in favs
                        join item in list
                        on fav.VALUE equals item.PROCESSNAME
                        select item).ToList();
            }
            else
            {
                list = list.FindAll(p => GetCategory(p.PROCESSNAME) == categoryName);
            }
            rptTask.DataSource = list;
            rptTask.DataBind();
        }
        #endregion

        #region "辅助方法"

        /// <summary>
        /// 流程分类初始化
        /// </summary>
        /// <returns></returns>
        private DataTable ProcessCategoryInit()
        {
            var processCategoryTable = new DataTable();
            var sql = "select * from WF_PROCESSCATEGORY order by ORDERNO asc";
            processCategoryTable = MyLib.DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            DataRow row = processCategoryTable.NewRow();
            row["CATEGORYNAME"] = Lang.Get("NewTask_AllProcess");
            row["DISPLAYNAME"] = "所有流程";
            row["ORDERNO"] = "0";
            row["EXT01"] = "color21-bg";
            row["EXT02"] = "icon-th-large";
            processCategoryTable.Rows.InsertAt(row, 0);
            DataRow favoriteRow = processCategoryTable.NewRow();
            favoriteRow["CATEGORYNAME"] = Lang.Get("Default_Fav");
            favoriteRow["DISPLAYNAME"] = "收藏";
            favoriteRow["ORDERNO"] = "0";
            favoriteRow["EXT01"] = "color16-bg";
            favoriteRow["EXT02"] = "icon-star-empty";
            processCategoryTable.Rows.Add(favoriteRow);
            return processCategoryTable;
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
        /// <summary>
        /// 流程初始化
        /// </summary>
        /// <returns></returns>
        private List<TaskEntity> ProcessInit()
        {
            _process = _workflow.GetAllInitProcess();
            var _userAccount = SessionLogic.GetLoginName().Replace("\\", "/");
            _initProcessList = _workflow.GetInitTaskList(_userAccount, "", null, "", 0, 1000);
            canStartProcesss();
            _initProcessList.Sort((a, b) => a.ORDERNO.CompareTo(b.ORDERNO));
            return _initProcessList;
        }

        /// <summary>
        /// 获取当前账户可以发起的流程
        /// </summary>
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
                    te.ORDERNO = ConvertUtil.ToInt32(drs[0]["ORDERNO"]);
                    te.PROCESSCNNAME = ConvertUtil.ToString(drs[0]["CNNAME"]);
                    te.PROCESSENNAME = ConvertUtil.ToString(drs[0]["ENNAME"]);
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

        /// <summary>
        /// 收藏
        /// </summary>
        /// <param name="processName"></param>
        /// <returns></returns>
        public string GetFavorite(object processName)
        {
            List<UserSettingsEntity> list = session.GetSession("UserFavorite") as List<UserSettingsEntity>;
            if (list != null && list.Count > 0)
            {
                bool flag = list.Exists(p => p.VALUE.Equals(ConvertUtil.ToString(processName)));
                if (flag)
                {
                    return "icon-star";
                }
                else
                {
                    return "icon-star-empty";
                }
            }
            else
                return "icon-star-empty";
        }

        void AddFav(string taskId, string processName)
        {
            _userSettings.SaveUserSettings(SessionLogic.GetLoginName(), "Favorite_" + processName, processName);
            List<UserSettingsEntity> _userSettingsList = _userSettings.GetUserSettingsList(SessionLogic.GetLoginName(), "Favorite");
            session.SetSession("UserFavorite", _userSettingsList);
            Response.Write("ok");
            Response.End();
        }

        void RemoveFav(string taskId, string processName)
        {
            _userSettings.SaveUserSettings(SessionLogic.GetLoginName(), "Favorite_" + processName, "");
            List<UserSettingsEntity> list = session.GetSession("UserFavorite") as List<UserSettingsEntity>;
            if (list != null && list.Count > 0)
            {
                UserSettingsEntity temp = list.Find(t => t.VALUE.Equals(ConvertUtil.ToString(processName)));
                list.Remove(temp);
            }
            Response.Write("ok");
            Response.End();

        }

       

        public string Getbg(object processName)
        {
            //获取流程类型
            string CATEGORYENNAME = string.Empty;
            DataRow[] Crows = _process.Select(" PROCESSNAME='" + ConvertUtil.ToString(processName) + "'");
            if (Crows.Length > 0)
            {
                CATEGORYENNAME = ConvertUtil.ToString(Crows[0]["CATEGORYENNAME"]);
            }
            DataRow[] rows = ProcessCategoryInit().Select(" CATEGORYNAME='" + ConvertUtil.ToString(CATEGORYENNAME) + "'");
            if (rows.Length > 0)
            {
                string str = ConvertUtil.ToString(rows[0]["EXT01"]);
                if (!string.IsNullOrEmpty(str))
                {
                    return str;
                }
            }
            return "color16-bg";
        }

        public string GetProcessbg(object processName)
        {
            //var sql = "select EXT09 from WF_PROCESS where PROCESSNAME=@PROCESSNAME";
            //string bg = ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar(sql, processName));
            //if (!string.IsNullOrEmpty(bg))
            //{
            //    return bg;
            //}
            //return "color16-bg";

            DataRow[] rows = _process.Select(" PROCESSNAME='" + ConvertUtil.ToString(processName) + "'");
            if (rows.Length > 0)
            {
                string str = ConvertUtil.ToString(rows[0]["EXT09"]);
                if (!string.IsNullOrEmpty(str))
                {
                    return str;
                }
            }
            return "icon-wrapper-bg opacity-10 bg-warning";

        }

        public string GetImage(object processName)
        {
            DataRow[] rows = _process.Select(" PROCESSNAME='" + ConvertUtil.ToString(processName) + "'");
            if (rows.Length > 0)
            {
                string str = ConvertUtil.ToString(rows[0]["ICON"]);
                if (!string.IsNullOrEmpty(str))
                {
                    return str;
                }
            }
            return "lnr-file-empty text-white opacity-8";
        }

        #endregion

        /// <summary>
        /// 通过流程名查询
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            List<TaskEntity> list = ProcessInit();
            string processname = txt_process.Text;
            try
            {
                if (!string.IsNullOrEmpty(processname))
                {
                    list = list.FindAll(p => 
                    p.PROCESSNAME.ToUpper().Contains(ConvertUtil.ToString(processname.ToUpper())) 
                    || p.PROCESSENNAME.ToUpper().Contains(ConvertUtil.ToString(processname.ToUpper())) 
                    || p.PROCESSCNNAME.ToUpper().Contains(ConvertUtil.ToString(processname.ToUpper())));
                }
            }
            catch (Exception ex)
            {
                MyLib.LogUtil.Error(ex.Message);
            }
            rptTask.DataSource = list;
            rptTask.DataBind();
        }
    }
}