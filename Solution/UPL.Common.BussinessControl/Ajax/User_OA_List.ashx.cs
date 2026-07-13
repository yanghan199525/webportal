using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using System.Data;
using System.Text;
namespace UPL.Common.BussinessControl.Ajax
{
    /// <summary>
    /// User_OA_List 的摘要说明
    /// </summary>
    public class User_OA_List : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request.Form["action"];
            string sql = "";
            string FORMID = context.Request.Form["FORMID"];
            string Type = context.Request.Form["Type"];
            switch (action)
            {
                case "OA_NewRequest_Load":
                    sql = "select  * from PROC_SCM_OA_JoinName where FORMID=N'" + FORMID + "' order by Convert(int,RowID) ASC";
                    DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i <= dt.Rows.Count; i++)
                    {
                        int j = (i + 1);
                        if (i == dt.Rows.Count)
                        {
                            if (Type != "myrequest")
                            {
                                sb.Append(" <tr id=\"tr_" + j + "\">");
                                sb.Append(" <td class=\"td-content td_hidden\" style=\"width: 50px\">");
                                sb.Append(" <input type=\"hidden\" name=\"hidden\" value=\"\" id=\"hi_" + j + "\" />");
                                sb.Append(" <select style=\"width: 80px\" id=\"sel_" + j + "\"  onchange=\"Sel_Chang(this)\">");
                                sb.Append("<option selected=\"selected\" value=\"审批人\">审批人</option> <option value=\"会签人\">会签人</option>");
                                sb.Append("</select>");
                                sb.Append("</td>");
                                sb.Append(" <td class=\"td-content td_" + j + "\" id=\"t_" + j + "\" style=\"width: 55%\"></td></td>");
                                sb.Append(" <td class=\"td-content\">");
                                sb.Append(" <input type=\"button\" id=\"td_" + j + "\" class=\"layui-btn btn layui-btn-small\" onclick=\"parent.selectUserInfo_OA(1,'sel_" + j + "','t_" + j + "','hi_" + j + "','',null,true)\" name=\"name\" value=\"选择\" />");
                                sb.Append(" </td>");
                                sb.Append("  <td class=\"td-content td_add\">");
                                sb.Append(" <input type=\"button\" name=\"name\" class=\"btn\" value=\"新增\" id=\"btn_" + j + "\" onclick=\"UserAdd(this)\" />");
                                sb.Append(" </td>");
                                sb.Append(" <td class=\"td-content\">");
                                sb.Append(" <input type=\"button\" name=\"name\" class=\"btn btn_" + j + "\" onclick=\"UserDel(this)\" value=\"删除\" />");
                                sb.Append(" </td>");
                                sb.Append("</tr>");
                            }
                        }
                        else
                        {
                            sb.Append(" <tr id=\"tr_" + j + "\">");
                            sb.Append(" <td class=\"td-content td_hidden\" style=\"width: 50px\">");
                            sb.Append(" <input type=\"hidden\" name=\"hidden\" value=\"" + dt.Rows[i]["JoinValue"] + "\" id=\"hi_" + j + "\" />");
                            sb.Append(" <select style=\"width: 80px\" id=\"sel_" + j + "\">");
                            string option = "";
                            if (dt.Rows[i]["JoinType"].ToString() == "审批人")
                            {
                                option = "<option selected=\"selected\" value=\"审批人\">审批人</option> <option value=\"会签人\">会签人</option>";
                            }
                            else
                            {
                                option = "<option  value=\"审批人\">审批人</option> <option selected=\"selected\" value=\"会签人\">会签人</option>";
                            }
                            sb.Append(option);
                            sb.Append("</select>");
                            sb.Append("</td>");
                            string[] str = dt.Rows[i]["JoinValue"].ToString().Split(',');
                            string name = "";
                            for (int k = 0; k < str.Length; k++)
                            {
                                sql = "select  UserName from org_user where loginname=N'" + str[k].Replace("CustomOC\\", "") + "'";
                                object username = DataAccess.Instance("BizDB").ExecuteScalar(sql);
                                if (k == 0)
                                {
                                    name = Convert.ToString(username);
                                }
                                else
                                {
                                    name += "," + username.ToString();
                                }
                            }
                            sb.Append(" <td class=\"td-content td_" + j + "\" id=\"t_" + j + "\" style=\"width: 55%\">" + name + "</td></td>");
                            sb.Append(" <td class=\"td-content\">");
                            sb.Append(" <input type=\"button\" id=\"td_" + j + "\" class=\"layui-btn btn layui-btn-small\" onclick=\"parent.selectUserInfo_OA(1,'sel_" + j + "','t_" + j + "','hi_" + j + "','',null,true)\" name=\"name\" value=\"选择\" />");
                            sb.Append(" </td>");
                            sb.Append("  <td class=\"td-content td_add\">");
                            sb.Append(" <input type=\"button\" name=\"name\" value=\"新增\" class=\"btn\" id=\"btn_" + j + "\" onclick=\"UserAdd(this)\" />");
                            sb.Append(" </td>");
                            sb.Append(" <td class=\"td-content\">");
                            sb.Append(" <input type=\"button\" name=\"name\" class=\"btn btn_" + j + "\" onclick=\"UserDel(this)\" value=\"删除\" />");
                            sb.Append(" </td>");
                            sb.Append("</tr>");
                        }

                    }
                    context.Response.Write(sb.ToString());
                    break;
                case "OA_NewRequest":
                    string TypeName = context.Request.Form["TypeName"];
                    string Value = context.Request.Form["Value"];
                    string PROCESSNAME = context.Server.UrlDecode(context.Request.Form["PROCESSNAME"]);
                    string INCIDENT = context.Request.Form["INCIDENT"];
                    string Name = context.Request.Form["Name"];
                    string Stauts = "1";
                    string ROWGUID = "";
                    string ROWID = context.Request.Form["index"];
                    if (ROWID == "1")
                    {
                        string sqlU = "Delete from PROC_SCM_OA_JoinName  where  FORMID=N'" + FORMID + "'";
                        DataTable dtU = DataAccess.Instance("BizDB").ExecuteDataTable(sqlU);
                    }
                    sql += " insert into PROC_SCM_OA_JoinName values(N'" + FORMID + "',N'" + ROWGUID + "',N'" + PROCESSNAME +
                       "',N'" + INCIDENT + "',N'" + ROWID + "',N'" + Name + "',N'"
                       + Value + "',N'" + TypeName + "',N'" + Stauts + "')";
                    DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                    break;

                case "OA_RECENTTLY":
                    string APPLICANTACCOUNT = "USER:org=CustomOC,user=" + context.Request.Form["Value"].Replace("\\", "/");
                    string INCIDENTT = context.Request.Form["INCIDENT"];
                    sql = @"select  PARENTSTEPNAME from PROC_DICOS_OA_SIGN_RECENTTLY where incident={0}  AND APPLICANTACCOUNT=N'{1}' ";
                    sql = string.Format(sql, INCIDENTT, APPLICANTACCOUNT);
                    object obj = DataAccess.Instance("BizDB").ExecuteScalar(sql);
                    context.Response.Write(obj.ToString());
                    break;
                default:

                    break;
            }
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