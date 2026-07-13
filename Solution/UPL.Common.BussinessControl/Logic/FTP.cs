using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using MyLib;
using System.Web;
using Ultimus.UWF.Workflow.Entity;
using System.Data.Common;
using System.Data;

namespace UPL.Common.BussinessControl.Logic
{
    public class FTP
    {
        private string ftpServerIP = MyLib.ConfigurationManager.AppSettings["FTPAttachmentServerIP"];//服务器ip：ftp://ftp.inside.zhaogangrentest.com
        private string ftpUserID = MyLib.ConfigurationManager.AppSettings["FTPAttachmentUserID"];//"ultimus";//用户名
        private string ftpPassword = MyLib.ConfigurationManager.AppSettings["FTPAttachmentPassword"];// "ZHaogang@#";//密码

        #region 上传文件

        /// <summary>
        /// 上传文件
        /// </summary>
        /// <param name="localFile">要上传到FTP服务器的本地文件</param>
        /// <param name="ftpPath">FTP地址</param>
        public void UpLoadFile(string localFile, string ftpPath)
        {
            if (!File.Exists(localFile))
            {
                LogUtil.Info("文件：“" + localFile + "” 不存在！");
                return;
            }
            FileInfo fileInf = new FileInfo(localFile);
            FtpWebRequest reqFTP;

            reqFTP = (FtpWebRequest)FtpWebRequest.Create(ftpPath);// 根据uri创建FtpWebRequest对象 
            reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);// ftp用户名和密码
            reqFTP.KeepAlive = false;// 默认为true，连接不会被关闭 // 在一个命令之后被执行
            reqFTP.Method = WebRequestMethods.Ftp.UploadFile;// 指定执行什么命令
            reqFTP.UseBinary = true;// 指定数据传输类型
            reqFTP.ContentLength = fileInf.Length;// 上传文件时通知服务器文件的大小
            int buffLength = 2048;// 缓冲大小设置为2kb
            byte[] buff = new byte[buffLength];
            int contentLen;

            // 打开一个文件流 (System.IO.FileStream) 去读上传的文件
            FileStream fs = fileInf.OpenRead();
            try
            {
                Stream strm = reqFTP.GetRequestStream();// 把上传的文件写入流
                contentLen = fs.Read(buff, 0, buffLength);// 每次读文件流的2kb

                while (contentLen != 0)// 流内容没有结束
                {
                    // 把内容从file stream 写入 upload stream
                    strm.Write(buff, 0, contentLen);
                    contentLen = fs.Read(buff, 0, buffLength);
                }
                // 关闭两个流
                strm.Close();
                fs.Close();
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
            }
        }

        /// <summary>
        /// 上传文件
        /// </summary>
        /// <param name="localFile">要上传到FTP服务器的本地文件</param>
        /// <param name="ftpPath">FTP地址</param>
        public void ftpfile(string localFile, string ftpPath)
        {
            string ftphost = "127.0.0.1";
            //here correct hostname or IP of the ftp server to be given  

            string ftpfullpath = "ftp://" + ftphost + ftpPath;
            FtpWebRequest ftp = (FtpWebRequest)FtpWebRequest.Create(ftpPath);
            ftp.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
            //userid and password for the ftp server to given  

            ftp.KeepAlive = true;
            ftp.UseBinary = true;
            ftp.Method = WebRequestMethods.Ftp.UploadFile;
            FileStream fs = File.OpenRead(localFile);
            byte[] buffer = new byte[fs.Length];
            fs.Read(buffer, 0, buffer.Length);
            fs.Close();
            Stream ftpstream = ftp.GetRequestStream();
            ftpstream.Write(buffer, 0, buffer.Length);
            ftpstream.Close();
        }

        public string flag = "@";
        public bool Upload(HttpServerUtility server, HttpPostedFile file, AttachmentEntity item)
        {
            try
            {
                //保存文件
                string path = MyLib.ConfigurationManager.AppSettings["AttachmentPath"];
                string dir = path + "/" + item.CreateDate.ToString("yyyy/MM/dd") + "/" + item.ProcessName;
                if (path.Contains("\\"))
                {
                    dir = dir.Replace("/", "\\");
                }
                else
                {
                    dir = server.MapPath(dir);
                }
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                string filePath = dir + "/" + item.NewName + item.FileType;
                file.SaveAs(filePath);

                if (item.TYPE == null)
                {
                    item.TYPE = "";
                }
                #region 同步到FTP

                FTP ftp = new FTP();
                string ftpPath = ftpServerIP + item.CreateDate.ToString("yyyy") + "/" + item.CreateDate.ToString("MM") + "/" + item.CreateDate.ToString("dd") + "/" + item.ProcessName + "/";
                //检测FTP的目录路径是否存在
                if (!ftp.CheckDirectoryExist(ftpPath))
                {
                    //创建文件路径
                    ftp.MakeDir(ftpPath);
                }
                //将本地文件同步到ftp上，然后删除本地文件
                string ftpPaths = ftpPath + item.NewName + item.FileType;
                ftp.UpLoadFile(filePath, ftpPaths);

                #endregion

                //保存数据库
                DataAccess db = new DataAccess("BizDB");
                StringBuilder strsql = new StringBuilder();
                strsql.Append("INSERT INTO WF_Attachment(ID,ProcessName,Incident,STEPNAME,FileName,NewName,FileSize,FileType,Comments,CreateBy,CreateDate,Status,TASKID,FORMID,TYPE,Ext01,Ext02,Ext03,Ext04,Ext05)");
                strsql.Append(" values ");
                strsql.Append("(" + flag + "ID," + flag + "ProcessName," + flag + "Incident," + flag + "UploadStepName," + flag + "FileName," + flag + "NewName," + flag + "FileSize," + flag + "FileType," + flag + "Comments," + flag + "CreateBy," + flag + "CreateDate," + flag + "Status," + flag + "TASKID," + flag + "FORMID," + flag + "TYPE," + flag + "Ext01," + flag + "Ext02," + flag + "Ext03," + flag + "Ext04," + flag + "Ext05)");
                DbCommand dbcom = db.CreateCommand(strsql.ToString());
                db.AddInParameter(dbcom, flag + "ID", DbType.Int32, item.ID);
                db.AddInParameter(dbcom, flag + "ProcessName", DbType.String, item.ProcessName);
                db.AddInParameter(dbcom, flag + "Incident", DbType.Int32, item.Incident);
                db.AddInParameter(dbcom, flag + "UploadStepName", DbType.String, item.UploadStepName);
                db.AddInParameter(dbcom, flag + "FileName", DbType.String, item.FileName);
                db.AddInParameter(dbcom, flag + "NewName", DbType.String, item.NewName);
                db.AddInParameter(dbcom, flag + "FileSize", DbType.Decimal, item.FileSize);
                db.AddInParameter(dbcom, flag + "FileType", DbType.String, item.FileType);
                db.AddInParameter(dbcom, flag + "Comments", DbType.String, item.Comments);
                db.AddInParameter(dbcom, flag + "CreateBy", DbType.String, item.CreateByName);
                db.AddInParameter(dbcom, flag + "CreateDate", DbType.DateTime, item.CreateDate);
                db.AddInParameter(dbcom, flag + "Status", DbType.String, item.Status);
                db.AddInParameter(dbcom, flag + "FORMID", DbType.String, item.FORMID);
                db.AddInParameter(dbcom, flag + "TYPE", DbType.String, item.TYPE);
                db.AddInParameter(dbcom, flag + "TASKID", DbType.String, item.TASKID);
                db.AddInParameter(dbcom, flag + "EXT01", DbType.String, item.Ext01);
                db.AddInParameter(dbcom, flag + "EXT02", DbType.String, item.Ext02);
                db.AddInParameter(dbcom, flag + "EXT03", DbType.String, item.Ext03);
                db.AddInParameter(dbcom, flag + "EXT04", DbType.String, item.Ext04);
                db.AddInParameter(dbcom, flag + "EXT05", DbType.String, item.Ext05);

                foreach (DbParameter param in dbcom.Parameters)
                {
                    if (param.Value == null)
                    {
                        param.Value = DBNull.Value;
                    }
                }
                if (db.ExecuteNonQuery(dbcom) > 0)
                {
                    return true;
                }
                else
                {
                    File.Delete(path);
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region 上传文件夹

        /// <summary>
        /// 上传整个目录
        /// </summary>
        /// <param name="localDir">要上传的目录的上一级目录</param>
        /// <param name="ftpPath">FTP路径</param>
        /// <param name="dirName">要上传的目录名</param>
        /// <param name="ftpUser">FTP用户名（匿名为空）</param>
        /// <param name="ftpPassword">FTP登录密码（匿名为空）</param>
        public void UploadDirectory(string localDir, string ftpPath, string dirName)
        {
            string dir = localDir + dirName + @"\"; //获取当前目录（父目录在目录名）
            //检测本地目录是否存在
            if (!Directory.Exists(dir))
            {
                //Response.Write("本地目录：“" + dir + "” 不存在！<br/>");
                return;
            }
            //检测FTP的目录路径是否存在
            if (!CheckDirectoryExist(ftpPath))
            {
                MakeDir(ftpPath, dirName);//不存在，则创建此文件夹
            }
            List<List<string>> infos = GetDirDetails(dir); //获取当前目录下的所有文件和文件夹

            //先上传文件
            //Response.Write(dir + "下的文件数：" + infos[0].Count.ToString() + "<br/>");
            for (int i = 0; i < infos[0].Count; i++)
            {
                Console.WriteLine(infos[0][i]);
                UpLoadFile(dir + infos[0][i], ftpPath + dirName + @"/" + infos[0][i]);
            }
            //再处理文件夹
            //Response.Write(dir + "下的目录数：" + infos[1].Count.ToString() + "<br/>");
            for (int i = 0; i < infos[1].Count; i++)
            {
                UploadDirectory(dir, ftpPath + dirName + @"/", infos[1][i]);
                //Response.Write("文件夹【" + dirName + "】上传成功！<br/>");
            }
        }

        /// <summary>
        /// 判断ftp服务器上该目录是否存在
        /// </summary>
        /// <param name="ftpPath">FTP路径目录</param>
        /// <returns></returns>
        public bool CheckDirectoryExist(string ftpPath)
        {
            bool flag = true;
            try
            {
                //实例化FTP连接
                FtpWebRequest ftp = (FtpWebRequest)FtpWebRequest.Create(ftpPath);
                ftp.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                ftp.Method = WebRequestMethods.Ftp.ListDirectory;
                FtpWebResponse response = (FtpWebResponse)ftp.GetResponse();
                response.Close();
            }
            catch (Exception)
            {
                flag = false;
            }
            return flag;
        }

        /// <summary>
        /// 创建全路径文件夹
        /// </summary>
        /// <param name="ftpPath">FTP路径：ftp://ftp.inside.zhaogangrentest.com/test1/test0 </param>
        public void MakeDir(string ftpPath)
        {
            string fullDir = ftpPath.Replace(ftpServerIP, "");
            string[] dirs = fullDir.Split('/');
            string curDir = "/";
            for (int i = 0; i < dirs.Length; i++)
            {
                string dir = dirs[i];
                //如果是以/开始的路径,第一个为空    

                if (!string.IsNullOrEmpty(dir))
                {
                    try
                    {
                        curDir += dir + "/";
                        MakeDir(ftpServerIP, curDir);//不存在，则创建此文件夹
                    }
                    catch (Exception)
                    { }
                }
            }
        }

        /// <summary>
        /// 创建文件夹  
        /// </summary>  
        /// <param name="ftpPath">FTP路径</param>  
        /// <param name="dirName">要上传的目录名</param>
        public void MakeDir(string ftpPath, string dirName)
        {
            string ui = (ftpPath + dirName).Trim();
            if (!CheckDirectoryExist(ui))   // 检查文件是否存在
            {
                try
                {
                    FtpWebRequest reqFTP;
                    reqFTP = (FtpWebRequest)FtpWebRequest.Create(ui);
                    reqFTP.Method = WebRequestMethods.Ftp.MakeDirectory;
                    reqFTP.UseBinary = true;
                    reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                    FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                    Stream ftpStream = response.GetResponseStream();
                    ftpStream.Close();
                    response.Close();
                }
                catch (Exception ex)
                {
                    LogUtil.Error("新建文件夹时，发生错误：" + ex.Message);
                }
            }
        }

        /// <summary>
        /// 获取目录下的详细信息
        /// </summary>
        /// <param name="localDir">本机目录</param>
        /// <returns></returns>
        public List<List<string>> GetDirDetails(string localDir)
        {
            List<List<string>> infos = new List<List<string>>();
            try
            {
                infos.Add(Directory.GetFiles(localDir).ToList()); //获取当前目录的文件

                infos.Add(Directory.GetDirectories(localDir).ToList()); //获取当前目录的目录

                for (int i = 0; i < infos[0].Count; i++)
                {
                    int index = infos[0][i].LastIndexOf(@"\");
                    infos[0][i] = infos[0][i].Substring(index + 1);
                }
                for (int i = 0; i < infos[1].Count; i++)
                {
                    int index = infos[1][i].LastIndexOf(@"\");
                    infos[1][i] = infos[1][i].Substring(index + 1);
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            return infos;
        }

        #endregion

        #region ftp 下载文件
        //从ftp服务器上下载文件的功能  
        public void Download(string ftpPath)
        {
            FtpWebRequest reqFTP;
            try
            {
                //string filePath = Application.StartupPath;
                FileStream outputStream = new FileStream(ftpPath, FileMode.Create);
                reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(ftpPath));
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UseBinary = true;
                reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                reqFTP.UsePassive = false;
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
                ftpStream.Close();
                outputStream.Close();
                response.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //从ftp服务器上下载文件的功能  
        public void Download(HttpResponse Response, string ftpPath, string fileName)
        {
            try
            {
                ftpPath = ftpPath.Replace("\\", "/");
                Uri ftpUrl = new Uri(ftpPath);
                if (ftpUrl.Scheme == Uri.UriSchemeFtp)
                {
                    WebClient request = new WebClient();
                    request.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                    try
                    {
                        byte[] newFileData = request.DownloadData(ftpUrl.ToString());
                        MemoryStream ms = new MemoryStream(newFileData);
                        BinaryReader br = new BinaryReader(ms);
                        newFileData = ms.ToArray();
                        Response.AddHeader("Accept-Ranges", "bytes");
                        Response.ContentType = "application/octet-stream";
                        Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                        Response.BinaryWrite(newFileData);
                        Response.End();
                    }
                    catch (WebException e)
                    {
                        Console.WriteLine(e.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                MyLib.LogUtil.Info(ex.Message);
                throw;
            }
        }
        #endregion

        #region ftp 删除文件
        public void Delete(string filePath)
        {
            try
            {
                filePath = filePath.Replace("\\", "/");
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(new Uri(filePath));
                request.Method = WebRequestMethods.Ftp.DeleteFile;
                request.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
            }
            catch (Exception ex)
            {
                MyLib.LogUtil.Info(ex.Message);
                throw;
            }
        }
        #endregion
    }
}
