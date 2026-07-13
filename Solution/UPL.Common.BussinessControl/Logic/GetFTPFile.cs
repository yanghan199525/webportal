using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using MyLib;
using System.Data;
using System.Xml;
using System.Data.Common;
using System.Net;
using Ultimus.UWF.Common.Logic;

namespace UPL.Common.BussinessControl.Logic
{
    public class GetFTPFile
    {
        /// <summary>
        /// 通过FTP获取文件
        /// </summary>
        /// <param name="formid">单号</param>
        /// <param name="processname">流程名</param>
        /// <param name="User">用户登录名</param>
        /// <param name="fileName">数据源</param>
        public void GetFtp(string formid, string processname, string User, string BussinessXml)
        {
            DataSet ds = ConvertXMLToDataSet(BussinessXml);
            string fileName = string.Empty;
            foreach (DataTable dt in ds.Tables)
            {
                if (dt.TableName == "MainTable" && dt != null)
                {
                    //SAP传入附件字段名
                    if (dt.Columns.Contains("Attachment"))
                    {
                        fileName = ConvertUtil.ToString(dt.Rows[0]["Attachment"]);
                        break;
                    }
                }
            }
            if (!string.IsNullOrEmpty(fileName))
            {
                fileName = fileName.TrimStart('|');
                string[] FileName = fileName.Split('|');
                foreach (string item in FileName)
                {
                    fileName = item;
                    fileName = fileName.Replace("/", "");
                    string RootPath = MyLib.ConfigurationManager.AppSettings["RootPhysicalPath"].ToString(); //网址的根路径。用于页面文件引用及邮件提醒。
                    if (!Directory.Exists(RootPath + "/File/" + DateTime.Now.Year + DateTime.Now.Month.ToString().PadLeft(2, '0') + "/" + processname))
                    {
                        Directory.CreateDirectory(RootPath + "/File/" + DateTime.Now.Year + DateTime.Now.Month.ToString().PadLeft(2, '0') + "/" + processname);
                    }
                    string dir = RootPath + "/File/" + DateTime.Now.Year + DateTime.Now.Month.ToString().PadLeft(2, '0') + "/" + processname + "/";

                    string newfile = Guid.NewGuid().ToString() + "~" + fileName;

                    Download(dir, newfile, "192.168.60.233", "E00622", "E00622@123", fileName);

                    string newPath = dir + newfile;
                    if (File.Exists(newPath))
                    {
                        FileInfo f = new FileInfo(newPath);
                        string FileSize = f.Length.ToString();

                        SqlInsert(formid, processname, newfile, fileName, FileSize, User);
                    }
                }
            }
        }
        /// <summary>
        /// 数据插入附件表
        /// </summary>
        /// <param name="formid"></param>
        /// <param name="processname">流程名</param>
        /// <param name="localfileName">新文件名字（带后缀）</param>
        /// <param name="fileName">源文件名称（带后缀）</param>
        /// <param name="FileSize">文件大小</param>
        /// <param name="CreateUser">上传人</param>
        public void SqlInsert(string formid, string processname, string localfileName, string fileName, string FileSize, string CreateUser)
        {
            string Type = fileName.Substring(fileName.LastIndexOf("."));
            string NewName = localfileName.Substring(0, localfileName.LastIndexOf("."));
            string SqlInsert = "insert into WF_ATTACHMENT (ID,FORMID,PROCESSNAME,INCIDENT,STEPNAME,FILENAME,NEWNAME,FILETYPE,FILESIZE,TYPE,CREATEDATE,CREATEBY,EXT01) ";
            SqlInsert += " Values(@ID,@FORMID,@PROCESSNAME,@INCIDENT,@STEPNAME,@FILENAME,@NEWNAME,@FILETYPE,@FILESIZE,@TYPE,@CREATEDATE,@CREATEBY,@EXT01);";
            int maxid = SerialNoLogic.GetMaxNo("WF_ATTACHMENT", "ID");
            int a = DataAccess.Instance("BizDB").ExecuteNonQuery(SqlInsert, maxid, formid, processname, "0", "Begin", fileName,
                NewName, Type, FileSize, "", ConvertUtil.ToString(DateTime.Now), CreateUser, formid);
        }

        /// <summary>
        /// 通过FTP下载文件
        /// </summary>
        /// <param name="filePath">新路径</param>
        /// <param name="newName">新名称（带后缀）</param>
        /// <param name="host">FTP地址</param>
        /// <param name="user">账户</param>
        /// <param name="pwd">密码</param>
        /// <param name="fileName">老文件名</param>
        public void Download(string filePath, string newName, string host, string user, string pwd, string fileName)
        {
            string newname = filePath + "\\" + newName;
            string ftpURI = "ftp://" + host + "/";

            FtpWebRequest reqFTP;

            try
            {
                FileStream outputStream = new FileStream(newname, FileMode.Create);

                reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(ftpURI + fileName));

                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;

                reqFTP.UseBinary = true;

                reqFTP.Credentials = new NetworkCredential(user, pwd);

                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();

                Stream ftpStream = response.GetResponseStream();

                long cl = response.ContentLength;

                int bufferSize = 2048;

                int readCount;

                byte[] buffer = new byte[bufferSize];

                readCount = ftpStream.Read(buffer, 0, bufferSize);

                while (readCount > 0)
                {

                    outputStream.Write(buffer, 0, readCount);

                    readCount = ftpStream.Read(buffer, 0, bufferSize);

                }

                outputStream.Close();

                response.Close();

            }

            catch (Exception ex)
            {

                throw ex;
            }

        }

        /// <summary>
        /// 将xml结构生成dataset
        /// </summary>
        /// <param name="xmlData">xml结构</param>
        /// <returns></returns>
        public DataSet ConvertXMLToDataSet(string xmlData)
        {
            //通过xml生成dataset
            StringReader stream = null;
            XmlTextReader reader = null;
            DataSet xmlDS = new DataSet();
            try
            {
                stream = new StringReader(xmlData);
                //从stream装载到XmlTextReader  
                reader = new XmlTextReader(stream);
                xmlDS.ReadXml(reader);
            }
            catch (Exception ex)
            {
                LogUtil.Error("failure,xmlDS:" + ex.Message);
            }
            finally
            {
                if (reader != null) reader.Close();
            }
            return xmlDS;
        }
    }
}
