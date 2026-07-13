using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
//using Newtonsoft.Json;
////using Newtonsoft.Json.Converters;
//using Newtonsoft.Json.Linq;

namespace Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic
{
    public class JsonHelper
    {
        #region Json格式转换
        //public string NewTonsotDataTableToJson(DataTable dt)
        //{
        //    string JsonString = string.Empty;
        //    JsonString = JsonConvert.DeserializeObject(dt,new DataTableConverter());
        //}

        public string DataTableToJson(DataTable dt)
        {
            var JsonString = new StringBuilder();
            if (dt.Rows.Count > 0)
            {
                JsonString.Append("[");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    JsonString.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (j < dt.Columns.Count - 1)
                        {
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + dt.Rows[i][j].ToString() + "\",");
                        }
                        else if (j == dt.Columns.Count - 1)
                        {
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + dt.Rows[i][j].ToString() + "\"");
                        }
                    }
                    if (i == dt.Rows.Count - 1)
                    {
                        JsonString.Append("}");
                    }
                    else
                    {
                        JsonString.Append("},");
                    }
                }
                JsonString.Append("]");
            }
            return JsonString.ToString();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public string CreateJsonParameters(DataTable dt)
        {
            /**/
            /**/
            /**/
            /* /****************************************************************************
      * Without goingin to the depth of the functioning of this Method, i will try to give an overview
      * As soon as this method gets a DataTable it starts to convert it into JSON String,
      * it takes each row and in each row it grabs the cell name and its data.
      * This kind of JSON is very usefull when developer have to have Column name of the .
      * Values Can be Access on clien in this way. OBJ.HEAD[0].<ColumnName>
      * NOTE: One negative point. by this method user will not be able to call any cell by its index.
     * *************************************************************************/
            StringBuilder JsonString = new StringBuilder();
            //Exception Handling        
            if (dt != null && dt.Rows.Count > 0)
            {
                JsonString.Append("{ ");
                JsonString.Append("\"T_blog\":[ ");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    JsonString.Append("{ ");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (j < dt.Columns.Count - 1)
                        {
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + dt.Rows[i][j].ToString() + "\",");
                        }
                        else if (j == dt.Columns.Count - 1)
                        {
                            JsonString.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":" + "\"" + dt.Rows[i][j].ToString() + "\"");
                        }
                    }
                    /*end Of String*/
                    if (i == dt.Rows.Count - 1)
                    {
                        JsonString.Append("} ");
                    }
                    else
                    {
                        JsonString.Append("}, ");
                    }
                }
                JsonString.Append("]}");
                return JsonString.ToString();
            }
            else
            {
                return null;
            }
        }
        #endregion

        /// <summary>
        /// 异常json
        /// </summary>
        /// <param name="exMsg"></param>
        /// <returns></returns>
        public string GetExceptionJson(string exMsg)
        {
            DataTable tbData = new DataTable("Datas");
            DataColumn dc = null;
            dc = tbData.Columns.Add("QUERYSTATUS", Type.GetType("System.String"));
            dc = tbData.Columns.Add("ERROR", Type.GetType("System.String"));
            DataRow newRow;
            newRow = tbData.NewRow();
            newRow["QUERYSTATUS"] = "FAILURE";
            newRow["ERROR"] = exMsg;
            tbData.Rows.Add(newRow);
            return CreateJsonParameters(tbData);
        }

        /// <summary>
        /// 异常json
        /// </summary>
        /// <param name="exMsg"></param>
        /// <returns></returns>
        public string GetSuccessJson()
        {
            DataTable tbData = new DataTable("Datas");
            DataColumn dc = null;
            dc = tbData.Columns.Add("QUERYSTATUS", Type.GetType("System.String"));
            DataRow newRow;
            newRow = tbData.NewRow();
            newRow["QUERYSTATUS"] = "SUCCESS";
            tbData.Rows.Add(newRow);
            return CreateJsonParameters(tbData);
        }

    }
}
