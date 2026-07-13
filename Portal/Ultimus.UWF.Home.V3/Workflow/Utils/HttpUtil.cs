using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Web.Script.Serialization;
using MyLib;

namespace Ultimus.UWF.Home.V3
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
        public static string HttpPost(string url, string body, string contentType = "application/json")
        {
            Encoding encoding = Encoding.UTF8;
            HttpWebRequest request = null; ;         
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
            request.Method = "POST";
            //request.Accept = "text/html, application/xhtml+xml, */*";
            request.ContentType = contentType;
            byte[] buffer = encoding.GetBytes(body);
            request.ContentLength = encoding.GetByteCount(body);// buffer.Length;
            request.GetRequestStream().Write(buffer, 0, encoding.GetByteCount(body));
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                return reader.ReadToEnd();
            }
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
        /// <summary>
        /// json字符串转json对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="jsonString"></param>
        /// <returns></returns>
        public static T FromJSON<T>(string jsonString)
        {
            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Deserialize<T>(jsonString);
        }
    }
}
