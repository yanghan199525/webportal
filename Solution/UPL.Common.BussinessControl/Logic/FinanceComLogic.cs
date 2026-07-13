using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace UPL.Common.BussinessControl.Logic
{
    public class FinanceComLogic
    {
        int Count = 0;
        string Sql = "";
        bool Falg = false;
        DataTable dt = new DataTable();

        /// <summary>
        /// 提交完成后添加数据到科目预算日志表中
        /// </summary>
        /// <param name="ProcessName">流程名称</param>
        /// <param name="FormId">主键ID</param>
        /// <param name="Status">使用抵扣状态 1表示抵扣在途数据，2标示抵扣完成数据，3表示抵扣退回数据，4表示抵扣拒绝或作废数据。</param>
        /// <returns></returns>
        public bool INSERT_BUDGETDEDUCTIONS(string ProcessName, string FormId, string Status)
        {
            try
            {
                Sql = " EXEC USP_INSERT_BUDGETDEDUCTIONS @ProcessName,@FormId,@Status ";
                DataAccess.Instance("BizDB").ExecuteNonQuery(Sql, ProcessName, FormId, Status);
                Falg = true;
            }
            catch (Exception ex)
            {
                Falg = false;
                LogUtil.Error(ex.Message);
                throw new Exception(ex.Message);
            }
            return Falg;
        }

        /// <summary>
        /// 提交完成后添加数据到借款冲销抵扣日志表中
        /// </summary>
        /// <param name="ProcessName">流程名称</param>
        /// <param name="FormId">主键ID</param>
        /// <param name="Status">使用抵扣状态 1表示抵扣在途数据，2标示抵扣完成数据，3表示抵扣退回数据，4表示抵扣拒绝或作废数据。</param>
        /// <returns></returns>
        public bool INSERT_LOANDEDUCTIONS(string ProcessName, string FormId, string Status)
        {
            try
            {
                Sql = " EXEC USP_INSERT_LOANDEDUCTIONS @ProcessName,@FormId,@Status";
                DataAccess.Instance("BizDB").ExecuteNonQuery(Sql, ProcessName, FormId, Status);
                Falg = true;
            }
            catch (Exception ex)
            {
                Falg = false;
                LogUtil.Error(ex.Message);
                throw new Exception(ex.Message);
            }
            return Falg;
        }

        /// <summary>
        /// 检查预算是否超出
        /// </summary>
        /// <param name="Budgetlist">预算号</param>
        /// <param name="LoanAmount">借款金额,没有则传: 0 </param>
        /// <param name="AppAmount">本次申请金额</param>
        /// <param name="deptId">预算部门Id</param>
        /// <param name="year">预算年份</param>
        /// <returns>Ture:超出,False:未超出</returns>
        public bool CheckBugetlist(string Budgetlist, decimal LoanAmount, decimal AppAmount, string deptId, string year)
        {
            bool flag = true;
            try
            {
                string sql = @"select NEW_BUDGETAMOUNT from VW_BUDGETLISTDATASOURCE 
                where BUDGETITEMS=@BudgetItems and BUDGETYEAR=@BUDGETYEAR and DEPARTMENTNO=@DEPARTMENTNO";
                object obj = DataAccess.Instance("BizDB").ExecuteScalar(sql, Budgetlist, year, deptId);
                if (obj != DBNull.Value && obj != null)
                {
                    //实时预算余额
                    decimal BudgetAmount = Convert.ToDecimal(obj);
                    //本次申请金额
                    if (BudgetAmount + LoanAmount >= AppAmount)
                    {
                        flag = false;
                    }
                }
            }
            catch (Exception ex)
            {
                flag = true;
                LogUtil.Error("CheckBugetlist 方法报错:" + ex.Message + ",预算号为:" + Budgetlist);
            }
            return flag;
        }

        /// <summary>
        /// 提交完成后添加数据到价量预算日志表中
        /// </summary>
        /// <param name="ProcessName">流程名称</param>
        /// <param name="FormId">主键ID</param>
        /// <param name="Status">使用状态 1表示在途数据，2标示完成数据，4表示拒绝或作废数据。</param>
        /// <returns></returns>
        public bool INSERT_PRICEQTYBUDGETLIST(string ProcessName, string FormId, string Status)
        {
            try
            {
                Sql = " EXEC USP_INSERT_PRICEQTYBUDGETLIST @ProcessName,@FormId,@Status ";
                DataAccess.Instance("BizDB").ExecuteNonQuery(Sql, ProcessName, FormId, Status);
                Falg = true;
            }
            catch (Exception ex)
            {
                Falg = false;
                LogUtil.Error(ex.Message);
                throw new Exception(ex.Message);
            }
            return Falg;
        }

    }
}
