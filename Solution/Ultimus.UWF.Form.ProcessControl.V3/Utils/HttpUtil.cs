using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using MyLib;

namespace DES_PSO.Web.Matlab
{
    public class HttpUtil
    {

        /// <summary>
        /// GET
        /// </summary>
        /// <param name="url">接口地址</param>
        /// <returns></returns>
        public static string HttpGet(string url, string contentType = "application/json")
        {
            string result = "";
            HttpWebRequest request = null;
            if (url.StartsWith("https", StringComparison.OrdinalIgnoreCase))
            {
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Ssl3 | (SecurityProtocolType)3072;
                request = WebRequest.Create(url) as HttpWebRequest;
                request.ProtocolVersion = HttpVersion.Version10;
            }
            else
            {
                request = (HttpWebRequest)WebRequest.Create(url);
            }
            request.ContentType = contentType;
            request.Method = "GET";

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (Stream resStream = response.GetResponseStream())
            {
                using (StreamReader reader = new StreamReader(resStream, Encoding.UTF8))
                {
                    result = reader.ReadToEnd().ToString();
                }
            }
            return result;
        }

        private static bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        {
            return true; //总是接受 
        }
        /// <summary>
        /// POST 接口
        /// </summary>
        /// <param name="url"></param>
        /// <param name="parameters"></param>
        /// <param name="text"></param>
        /// <param name="contenttype"></param>
        /// <returns></returns>
        public static string HttpPostWithHeader(string url, Dictionary<string, string> parameters, string text, string contenttype)
        {
            string strres = "";
            HttpWebRequest request = null;
            //如果是发送HTTPS请求 
            if (url.StartsWith("https", StringComparison.OrdinalIgnoreCase))
            {
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Ssl3 | (SecurityProtocolType)3072;
                request = WebRequest.Create(url) as HttpWebRequest;
                request.ProtocolVersion = HttpVersion.Version10;
            }
            else
            {
                request = (HttpWebRequest)WebRequest.Create(url);
            }
            request.Proxy = null;
            request.Method = "POST";
            request.ContentType = contenttype;
            if (parameters != null)
            {
                foreach (var item in parameters)
                {
                    request.Headers.Set(item.Key, item.Value);
                }
            }

            byte[] bytedata = Encoding.UTF8.GetBytes(text);
            request.ContentLength = bytedata.Length;
            Stream rs = request.GetRequestStream();
            rs.Write(bytedata, 0, bytedata.Length);
            rs.Close();
            //Post and get response
            using (WebResponse post = request.GetResponse())
            {
                using (Stream resp = post.GetResponseStream())
                {
                    using (StreamReader sr = new StreamReader(resp))
                    {
                        strres = sr.ReadToEnd();
                    }
                }
            }
            request.Abort();
            return strres;
        }
    }
}
