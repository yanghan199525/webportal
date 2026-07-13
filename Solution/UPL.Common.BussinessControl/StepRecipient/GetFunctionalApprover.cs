using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.Workflow.Entity;
using Ultimus.UWF.Workflow.Interface;

namespace UPL.Common.BussinessControl.StepRecipient
{
    public class GetFunctionalApprover : GetRecipient
    {
        IFunctional funLogic = ServiceContainer.Instance().GetService<IFunctional>();
        public override string Execute(DataTable bussData,string methodParameters)
        {
            string StepRecipientUser = string.Empty;
            try
            {
                if (string.IsNullOrEmpty(methodParameters))
                {
                    methodParameters = base.MethodParameters;
                }
                if (bussData != null && bussData.Rows.Count > 0)
                {
                    Dictionary<string, string> listParam = new Dictionary<string, string>();
                    listParam= SerializeUtil.JsonDeserialize<Dictionary<string, string>>(methodParameters);

                    string strJobFunCode = listParam["strJobFunCode"];
                    string strWhere = listParam["strWhere"];
                    string strArray = listParam["strArray"];
                    if (String.IsNullOrEmpty(strJobFunCode))
                    {
                        StepRecipientUser = "";
                        return "";
                    }
                    String whereExt = string.Empty;
                    if (!String.IsNullOrEmpty(strWhere))
                    {
                        whereExt = GetSql(bussData,strWhere);                        
                    }

                    DataTable dt_Approver = funLogic.GetFunctionalApproverByJobFunction(strJobFunCode, whereExt);
                    if (dt_Approver != null && dt_Approver.Rows.Count > 0)
                    {
                        if (strArray == "0")
                        {
                            StepRecipientUser = dt_Approver.Rows[0]["LOGINNAME"] != DBNull.Value ? dt_Approver.Rows[0]["LOGINNAME"].ToString() : "";
                            StepRecipientUser = "USER:org=" + SessionLogic.GetDomain(StepRecipientUser) + ",user=" + StepRecipientUser;
                        }
                        else
                        {
                            StepRecipientUser = DataTableToString(dt_Approver, "LOGINNAME", '|');                        
                        }                      
                    }
                    else
                    {
                        StepRecipientUser = "";
                        throw new Exception("没有获取" + strJobFunCode + ",请联系管理员或稍后再试！");
                    }
                    
                }
                StepRecipientUser = StepRecipientUser.Replace("\\","/");
            }
            catch (Exception ex)
            {
                LogUtil.Error(methodParameters,ex);
                throw ex;
            }
           
            return StepRecipientUser;
        }


        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            String whereExt = string.Empty;
            try
            {                
                if (stepConfig != null&&bussData != null && bussData.Rows.Count > 0)
                {
                    
                    Dictionary<string, string> listParam = new Dictionary<string, string>();
                    //listParam = SerializeUtil.JsonDeserialize<Dictionary<string, string>>(methodParameters);
                    string strJobFunCode =stepConfig.Ext03;// listParam["strJobFunCode"];
                    string strWhere = stepConfig.Ext01; //listParam["strWhere"];
                    string strArray = stepConfig.ISRECIPIENTARRAY; //listParam["strArray"];

                    if (String.IsNullOrEmpty(strJobFunCode))
                    {
                        StepRecipientUser = "";
                        return "";
                    }
                   
                    if (!String.IsNullOrEmpty(strWhere))
                    {                                                 
                        strWhere = strWhere.Replace("EXT0","B.EXT0");                                             
                        whereExt =" and "+GetSql(bussData, strWhere);
                    }

                    DataTable dt_Approver = funLogic.GetFunctionalApproverByJobFunction(strJobFunCode, whereExt);
                    if (dt_Approver != null && dt_Approver.Rows.Count > 0)
                    {
                        if (strArray == "0")
                        {
                            StepRecipientUser = dt_Approver.Rows[0]["LOGINNAME"] != DBNull.Value ? dt_Approver.Rows[0]["LOGINNAME"].ToString() : "";
                            StepRecipientUser = "USER:org=" + SessionLogic.GetDomain(StepRecipientUser) + ",user=" + StepRecipientUser;
                        }
                        else
                        {
                            StepRecipientUser = DataTableToString(dt_Approver, "LOGINNAME", '|');
                        }
                    }
                    else
                    {
                        StepRecipientUser = "";
                        throw new Exception("没有获取" + strJobFunCode + ",请联系管理员或稍后再试！");
                    }

                }
                StepRecipientUser = StepRecipientUser.Replace("\\", "/");
            }
            catch (Exception ex)
            {
                if (stepConfig != null)
                {
                    LogUtil.Error(stepConfig.StepName + "--" + stepConfig.Ext03 + "---" + whereExt, ex);
                }
                throw ex;
            }

            return StepRecipientUser;
        }


        /// <summary>
        /// list转带”,“ 字符串
        /// </summary>
        ///  <param name="Prefiix">ConfigurationManager.AppSettings["Domain"] + "/"</param>
        /// <param name="strArr"></param>
        /// <returns></returns>
        public String DataTableToString(DataTable dt, String ColumnName, char Split)
        {
            string a = "";
            if (dt != null)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    a += dt.Rows[i][ColumnName] != DBNull.Value ? "USER:org=" + SessionLogic.GetDomain(dt.Rows[i][ColumnName].ToString()) + ",user=" + dt.Rows[i][ColumnName].ToString() + "|" : "";
                }
            }
            return a.TrimEnd('|');
        }


        public string GetSql(DataTable bussData, string sqltext)
        {
            string result = string.Empty;

            //string Pattern = @"/b{/S*}/b";
            try
            {
                result = sqltext;                
                Regex reg = new Regex("(?<=({))[.\\s\\S]*?(?=(}))", RegexOptions.RightToLeft |RegexOptions.IgnoreCase| RegexOptions.Multiline | RegexOptions.Singleline);

                foreach (Match NextMatch in reg.Matches(sqltext))
                {
                    string temp = NextMatch.Value;                  
                    string value = bussData.Rows[0][temp].ToString();
                    temp = "{" + temp + "}";
                    result = result.Replace(temp, value);
                }
            }
            catch (Exception ex)
            {
                result = string.Empty;
                throw ex;            
            }

            return result;       
        
        }


    }
}