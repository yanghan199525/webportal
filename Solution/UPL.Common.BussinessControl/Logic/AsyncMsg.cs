using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace UPL.Common.BussinessControl.Logic
{

    /// <summary>
    /// 当前类用于处理无刷新分页返回值
    /// </summary>
    public class AsyncMsg
    {
        /// <summary>
        /// 状态码
        /// </summary>
        public int Code { get; set; }
        /// <summary>
        /// 返回数据
        /// </summary>
        public object Data { get; set; }
        /// <summary>
        /// 总页数
        /// </summary>
        public int Pages { get; set; }
        /// <summary>
        /// 页数大小
        /// </summary>
        public int PageSize { get; set; }
    }
}
