using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using Ultimus.UWF.Workflow.Entity;
using System.Data.Common;


namespace UPL.Common.BussinessControl.StepRecipient
{
    class GetSupplier : GetRecipient
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="bussData"></param>
        /// <param name="stepConfig"></param>
        /// <returns></returns>
        public override string Execute(DataTable bussData, StepSetting stepConfig)
        {
            string StepRecipientUser = string.Empty;
            string param = stepConfig.MethodParameters.Trim();

            //string compCode = ConvertUtil.ToString(bussData.Rows[0]["PCCOMPCODE"]);
            //string processName = stepConfig.Process;
            if (bussData.Rows.Count > 0)
            {
                if (stepConfig.StepName == "supplier")
                {
                    StringBuilder sSql = new StringBuilder();
                    DataAccess db = DataAccess.Instance("BizDB");
                    DataTable dt = new DataTable();
                    sSql.Append(@"
select * from PROC_PO_SUPPLIER where DocumentNo=@DocumentNo and ADJUSTDOCUMENTNO=@ADJUSTDOCUMENTNO
");
                    using (DbCommand cmd = db.CreateCommand())
                    {
                        cmd.CommandText = sSql.ToString();
                        cmd.CommandType = CommandType.Text;
                        string PROCESSNAME = bussData.Rows[0]["DOCUMENTNO"].ToString();
                        string ADJUST = bussData.Rows[0]["ADJUSTDOCUMENTNO"].ToString();
                        db.AddInParameter(cmd, "@DocumentNo", DbType.String, bussData.Rows[0]["DOCUMENTNO"]);
                        db.AddInParameter(cmd, "@ADJUSTDOCUMENTNO", DbType.String, bussData.Rows[0]["ADJUSTDOCUMENTNO"]);
                        dt = db.ExecuteDataTable(cmd);
                    }

                    string domain = "CustomOC";
                    bool bargaining=false;
                    bool material=false;
                    Compare(dt);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (!string.IsNullOrEmpty(dr["supplierCode"].ToString()))
                            {
                                if (dr["type"].ToString() == "1") {
                                    if (dr["supplierName"].ToString().Contains("搭载") || dr["supplierName"].ToString().ToUpper().Contains("DZ"))
                                    {
                                        bargaining = true;
                                    }
                                    if (dr["supplierName"].ToString().Contains("寄售") || dr["supplierName"].ToString().Contains("买断") || dr["supplierName"].ToString().ToUpper().Contains("JS") || dr["supplierName"].ToString().ToUpper().Contains("MD"))
                                    {
                                        material = true;
                                    }
                                    if (!dr["supplierName"].ToString().Contains("搭载") && !dr["supplierName"].ToString().Contains("寄售") && !dr["supplierName"].ToString().Contains("买断") && !dr["supplierName"].ToString().ToUpper().Contains("DZ") && !dr["supplierName"].ToString().ToUpper().Contains("JS") && !dr["supplierName"].ToString().ToUpper().Contains("MD"))
                                    {
                                        bargaining = true;
                                    }
                                }
                            }
                        }
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (!string.IsNullOrEmpty(dr["supplierCode"].ToString()))
                            {
                                if (bargaining)
                                {
                                    if (dr["type"].ToString() == "1")
                                    {
                                        StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, dr["supplierCode"].ToString()));
                                    }
                                }
                                if (material)
                                {
                                    if (dr["type"].ToString() == "2")
                                    {
                                        StepRecipientUser += string.Format("{0}|", FormatUltimusUser(domain, dr["supplierCode"].ToString()));
                                    }
                                }

                            }
                           
                        }
                        StepRecipientUser = !string.IsNullOrEmpty(StepRecipientUser) ? StepRecipientUser.TrimEnd('|') : StepRecipientUser;

                    }
                    else
                    {
                        throw new Exception(string.Format("供应商审批人查询失败！,请联系管理员！", ConvertUtil.ToString(bussData.Rows[0]["SITECODE"])));
                    }
                }
            }
            else
            {
                throw new Exception("业务数据为空，请联系管理员");
            }
            return StepRecipientUser;

        }
        private string FormatUltimusUser(string domain, string userCode)
        {
            return string.Format("USER:org={0},user={0}/{1}", domain, userCode);
        }
        public DataTable Compare(DataTable dt)
        {

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = dt.Rows.Count - 1; j > i; j--)
                {
                    if (dt.Rows[i]["supplierCode"] == dt.Rows[j]["supplierCode"])
                    {
                        dt.Rows.RemoveAt(j);
                    }
                }
            }
            return dt;
        }
        public override string Execute(DataTable bussData, string methodParameters)
        {
            //暂时不用
            return "";
        }
    }
}
