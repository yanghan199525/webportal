using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MyLib;
using Ultimus.UWF.Form.Entity;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Interface;
using MyLib.Json;
using System.IO;

namespace Ultimus.UWF.Home.V3
{
    public partial class SelectPageStrengthen : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                hidDataSource.Value = Request.QueryString["dataSource"]; //数据源标识
                hidFilter.Value = Request.QueryString["filter"];
                hidSingle.Value = Request.QueryString["single"]; //单选或多选
                if (!string.IsNullOrEmpty(hidDataSource.Value))
                {
                    Ultimus.UWF.Form.Interface.IDataSource ds = ServiceContainer.Instance().GetService<Ultimus.UWF.Form.Interface.IDataSource>();
                    DataSourceEntity entity = ds.GetDataSourceEntity(hidDataSource.Value);
                    if (entity != null)
                    {
                        //弹出框字段描述
                        hidCaption.Value = entity.DATATEXTFIELDTITLE;//显示字段描述（中文）
                        hidCaption_EN.Value = entity.EXT03;//显示字段描述（英文）
                        hidHidden.Value = entity.EXT01; //隐藏值
                        hidValue.Value = entity.DATAVALUEFIELD; //值
                    }
                }
            }
        }

        /// <summary>
        /// 表单展现td
        /// </summary>
        /// <returns></returns>
        public string GetTitle()
        {
            string Title = "";
            //显示的字段
            if (Lang.GetLang().ToLower() == "zh-cn")
            {
                foreach (string item in hidCaption.Value.Split(','))
                {
                    if (!string.IsNullOrEmpty(item))
                    {
                        Title += "<td>" + item.Trim() + "</td>";
                    }
                }
            }
            else
            {
                foreach (string item in hidCaption_EN.Value.Split(','))
                {
                    if (!string.IsNullOrEmpty(item))
                    {
                        Title += "<td>" + item.Trim() + "</td>";
                    }
                }
            }

            //隐藏字段
            foreach (string item in hidHidden.Value.Split(','))
            {
                if (!string.IsNullOrEmpty(item))
                {
                    Title += "<td class=\"hidden\">" + item.Trim() + "</td>";
                }
            }
            return Title;
        }
        /// <summary>
        /// 表单值
        /// </summary>
        /// <returns></returns>
        public string GetValue()
        {
            string[] Query = hidHidden.Value.Split(',');
            string Value = "";
            if (Query.Length > 0)
            {
                Value = "{ \"data\": \"" + ConvertUtil.ToString(Query[0]).Trim() + "\" },";
            }
            else
            {
                Query = hidValue.Value.Split(',');
                if (Query.Length > 0)
                {
                    Value = "{ \"data\": \"" + ConvertUtil.ToString(Query[0]).Trim() + "\" },";
                }
            }

            //显示的字段
            foreach (string item in hidValue.Value.Split(','))
            {
                if (!string.IsNullOrEmpty(item))
                {
                    Value += "{ \"data\": \"" + item.Trim() + "\" },";
                }
            }
            //隐藏字段
            foreach (string item in hidHidden.Value.Split(','))
            {
                if (!string.IsNullOrEmpty(item))
                {
                    Value += "{ \"data\": \"" + item.Trim() + "\",\"sClass\": \"hidden\" },";
                }
            }
            return Value;
        }

    }
}