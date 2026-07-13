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
using Ultimus.UWF.Form.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class ReportListV7 : BasePage
    {
        DataTable _process = new DataTable();
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        IDataSchema _dataSchema = ServiceContainer.Instance().GetService<IDataSchema>();
        protected void Page_Load(object sender, EventArgs e)
        {
            _process = _workflow.GetAllReportProcessV7();
            rptTask.DataSource = _process;
            rptTask.DataBind();
            BindProcessCategory();

            if (!IsPostBack)
            {
                AuthorizeLogic.CheckAuthorize("C13279F5-0AED-4F18-A010-AB7B1AD38686");
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
            Repeater1.DataSource = nlist;
            Repeater1.DataBind();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            string categoryName = e.CommandArgument.ToString();
            DataTable list = _process.Clone();
            if (categoryName == Lang.Get("NewTask_AllProcess"))
            {
                list = _process;
            }
            else
            {
                DataRow[] rows = _process.Select("CATEGORYNAME='" + categoryName + "'");
                foreach (DataRow row in rows)
                {
                    list.ImportRow(row);
                }
            }
            rptTask.DataSource = list;
            rptTask.DataBind();
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
            return "../../Common/Assets/img/site/flow.png";
        }

        public string GetNamespace(object processName)
        {
            return _dataSchema.GetNameSpace(ConvertUtil.ToString(processName));

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

    }
}