using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Ultimus.UWF.Workflow.Entity;

namespace UPL.Common.BussinessControl.Logic
{
    public class VarData
    {

        string _processName;

        public string ProcessName
        {
            get { return _processName; }
            set { _processName = value; }
        }

        string _processCN;

        public string ProcessCN
        {
            get { return _processCN; }
            set { _processCN = value; }
        }

        string _processEN;

        public string ProcessEN
        {
            get { return _processEN; }
            set { _processEN = value; }
        }

        string _tableName;

        public string TableName
        {
            get { return _tableName; }
            set { _tableName = value; }
        }

        string _RootPath;
        public string RootPath
        {
            get { return _RootPath; }
            set { _RootPath = value; }
        }

        string _BodyView;
        public string BodyView
        {
            get { return _BodyView; }
            set { _BodyView = value; }
        }

        string _BodyApprove;
        public string BodyApprove
        {
            get { return _BodyApprove; }
            set { _BodyApprove = value; }
        }
        string _BodyReturn;

        public string BodyReturn
        {
            get { return _BodyReturn; }
            set { _BodyReturn = value; }
        }

        string _BodyReject;

        public string BodyReject
        {
            get { return _BodyReject; }
            set { _BodyReject = value; }
        }


        string _EmailBodyApprove;
        public string EmailBodyApprove
        {
            get { return _EmailBodyApprove; }
            set { _EmailBodyApprove = value; }
        }
        string _EmailBodyReturn;

        public string EmailBodyReturn
        {
            get { return _EmailBodyReturn; }
            set { _EmailBodyReturn = value; }
        }

        string _EmailBodyReject;

        public string EmailBodyReject
        {
            get { return _EmailBodyReject; }
            set { _EmailBodyReject = value; }
        }

        string _stepName;

        public string StepName
        {
            get { return _stepName; }
            set { _stepName = value; }
        }
        string _taskUserLoginName = "";

        public string TaskUserLoginName
        {
            get { return _taskUserLoginName; }
            set { _taskUserLoginName = value; }
        }

        string _taskUserName = "";

        public string TaskUserName
        {
            get { return _taskUserName; }
            set { _taskUserName = value; }
        }

        string _taskID;

        public string TaskID
        {
            get { return _taskID; }
            set { _taskID = value; }
        }

        List<VarEntity> _varList = new List<VarEntity>();

        public List<VarEntity> VarList
        {
            get { return _varList; }
            set { _varList = value; }
        }


        DataSet _businessDS = new DataSet();
        public DataSet BusinessDS
        {
            get { return _businessDS; }
            set { _businessDS = value; }
        }

        public List<DataRowEntity> GetDataRowList(string tablename)
        {
            // DataTable dt = DataAccess.Instance("Biz").ExecuteDataTable("select * from " + tablename);
            DataTable dt = null;
            if (BusinessDS != null && BusinessDS.Tables != null && BusinessDS.Tables.Count > 0)
            {
                dt = BusinessDS.Tables[tablename];
            }
            else
            {
                dt = null;
            }
            if (dt == null)
            {
                dt = new DataTable();
            }

            List<DataRowEntity> list = new List<DataRowEntity>();
            foreach (DataRow row in dt.Rows)
            {
                DataRowEntity re = new DataRowEntity();
                foreach (DataColumn dc in dt.Columns)
                {
                    DataColumnEntity col = new DataColumnEntity();
                    col.ColumnName = dc.ColumnName;
                    col.Value = ConvertUtil.ToString(row[dc.ColumnName]);
                    re.Columns.Add(col);
                }
                list.Add(re);
            }
            return list;
        }

        /// <summary>
        /// 处理循环行 列信息
        /// </summary>
        /// <param name="row"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        public string GetColumnValue(DataRowEntity row, string columnName)
        {
            DataColumnEntity col = row.Columns.Find(p => p.ColumnName.ToUpper().Trim() == columnName.Trim().ToUpper());
            if (col != null)
            {
                return col.Value;
            }
            return "";
        }

        List<ApprovalHistoryEntity> _history = new List<ApprovalHistoryEntity>();

        public List<ApprovalHistoryEntity> ApprovalHistoryList
        {
            get { return _history; }
            set { _history = value; }
        }

    }

    public class DataRowEntity
    {
        List<DataColumnEntity> _columns = new List<DataColumnEntity>();

        public List<DataColumnEntity> Columns
        {
            get { return _columns; }
            set { _columns = value; }
        }
    }

    public class DataColumnEntity
    {
        string _ColumnName;

        public string ColumnName
        {
            get { return _ColumnName; }
            set { _ColumnName = value; }
        }

        string _value;

        public string Value
        {
            get { return _value; }
            set { _value = value; }
        }

        string _type;

        public string Type
        {
            get { return _type; }
            set { _type = value; }
        }
    }

}
