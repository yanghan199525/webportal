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

namespace Ultimus.UWF.Home.V3
{
    public partial class SelectPage : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //hidSql.Value = Request.QueryString["SQL"];
                hidQuery.Value = Request.QueryString["Query"];
                hidCaption.Value = Request.QueryString["Caption"];
                hidWidth.Value = Request.QueryString["Width"];
                hidOrder.Value = Request.QueryString["Order"];
                hidDBName.Value = Request.QueryString["dbName"];
                hidDataSource.Value = Request.QueryString["dataSource"];
                hidFilter.Value = Request.QueryString["filter"];
                hidSingle.Value = Request.QueryString["single"]; //单选或多选
                if (!string.IsNullOrEmpty(hidDataSource.Value))
                {
                    Ultimus.UWF.Form.Interface.IDataSource ds = ServiceContainer.Instance().GetService<Ultimus.UWF.Form.Interface.IDataSource>();
                    DataSourceEntity entity =ds.GetDataSourceEntity(hidDataSource.Value);
                    hidSql.Value = ds.GetDataSourceSql(entity, entity.DATATEXTFIELD, hidFilter.Value);
                    hidQuery.Value = entity.DATATEXTFIELD;
                    hidCaption.Value = entity.DATATEXTFIELDTITLE;
                    hidOrder.Value = entity.SORTFIELD;
                    hidDBName.Value = entity.DATABASENAME;
                }
                BindHeader();
                BindGrid();
            }
        }

        /// <summary>
        /// 绑定表头
        /// </summary>
        void BindHeader()
        {
            string[] strArrName = hidCaption.Value.Split(',');
            DataTable dt = new DataTable();
            dt.Columns.Add("DisplayName");
            foreach (string str in strArrName)
            {
                if (!string.IsNullOrEmpty(str))
                {
                    DataRow row = dt.NewRow();
                    row[0] = str;
                    dt.Rows.Add(row);
                }
            }
            rptCols.DataSource = dt;
            rptCols.DataBind();
            
        }

        /// <summary>
        /// 绑定表内容
        /// </summary>
        void BindGrid()
        {
            string sql = hidSql.Value;
            if(string.IsNullOrEmpty(sql))
            {
                return;
            }
            
            if (!string.IsNullOrEmpty(hidOrder.Value))
            {
                sql += " order by " + hidOrder.Value;
            }
            string dbName = "BizDB";
            if (!string.IsNullOrEmpty(hidDBName.Value))
            {
                dbName = hidDBName.Value;
            }
            DataTable data = _workflow.GetDataTable(dbName, sql);
            //把多个列组成一个列，以"|"号分隔
            DataTable dt = new DataTable();
            dt.Columns.Add("RowData");
            foreach (DataRow dr in data.Rows)
            {
                DataRow row = dt.NewRow();
                row[0] = GetRowData(dr);
                dt.Rows.Add(row);
            }

            rptList.DataSource = dt;
            rptList.DataBind();

        }

        string GetRowData(DataRow dr)
        {
            string str = "{";
            DataTable dt = dr.Table;
            foreach (DataColumn col in dt.Columns)
            {
                str += col.ColumnName + ":'" + ConvertUtil.ToString(dr[col]).Replace("'", "").Replace("\"", "").Replace("\r", "").Replace("\n", "").Replace("\t", "").Trim() + "'|";
            }
            str = str.TrimEnd('|');
            str += "}";
            return str;
        }

        /// <summary>
        /// 获取每列，根据RowData进行拆分
        /// </summary>
        /// <param name="rowData"></param>
        /// <returns></returns>
        public string GetCols(object rowData)
        {
            string[] sz = ConvertUtil.ToString(rowData).Replace("{", "").Replace("}", "").Replace("'", "").Split('|');
            string text = "";
            string[] names = hidQuery.Value.Split(',');
            List<string> list = new List<string>();
            list.AddRange(names);
            int width = ConvertUtil.ToInt32(100 / (list.Count));
            foreach (string str in sz)
            {
                if (list.Exists(p=>ConvertUtil.ToString( p).Trim().ToUpper()== str.Split(':')[0].Trim().ToUpper()))
                {
                    text += "<td onclick='selRow(this);'  class='tdrow' style='width:"+ width + "%'>" + str.Split(':')[1] + "</td>";
                }
                else
                {
                    //text += "<td onclick='selRow(this);'  class='tdrow hidden'>" + str.Split(':')[1] + "</td>";
                }
            }
            return text;
        }

        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //(e.Item.FindControl("cbxSelect") as CheckBox).Visible = false;
            //(e.Item.FindControl("rbSelect") as RadioButton).Visible = false;
            //switch (this.hidSingle.Value)
            //{
            //    case "true":
            //        (e.Item.FindControl("rbSelect") as CheckBox).Visible = true;
            //        break;
            //    default:
            //        (e.Item.FindControl("cbxSelect") as CheckBox).Visible = true;
            //        break;
            //}
        }

        public string GetControl()
        {
            if (hidSingle.Value == "true")
            {
                return "<input id='radSel' name='sel' type='radio' class='radio ' />";
            }

            return "<input id='chxSelect' type='checkbox'  class='checkbox '  />";
        }

    }

}