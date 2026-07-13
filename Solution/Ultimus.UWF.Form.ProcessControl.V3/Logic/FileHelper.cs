using MyLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Ultimus.UWF.Form.ProcessControl.V3.Logic
{
    public static class FileHelper
    {
        public static string GetFileType()
        {
            string MimeType = string.Empty;
            string appConfig = ConvertUtil.ToString(ConfigurationManager.AppSettings["FileType"]);
            if (!string.IsNullOrEmpty(appConfig))
            {
                DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable("select MIMETYPE from COM_FILETYPE where filetype in (" + appConfig + ")");
                foreach (DataRow dr in dt.Rows)
                {
                    MimeType += "'" + dr["MIMETYPE"] + "',";
                }
            }
            return MimeType.TrimEnd(',');
        }
    }
}