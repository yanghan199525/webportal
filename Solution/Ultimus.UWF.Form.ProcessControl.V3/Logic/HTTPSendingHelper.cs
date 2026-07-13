using MyLib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;

namespace Ultimus.UWF.Form.ProcessControl.V3.Logic
{
    public class HTTPSendingHelper
    {
        #region
        /// <summary>
        /// GET调用Http外网接口
        /// </summary>
        /// <param name="path">GET地址</param>
        /// <returns></returns>
        public string GetFunction(string path)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(path);
            request.Method = "GET";
            request.ContentType = "text/html;charset=UTF-8";
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            Stream myResponseStream = response.GetResponseStream();
            StreamReader myStreamReader = new StreamReader(myResponseStream, Encoding.UTF8);
            string retString = myStreamReader.ReadToEnd();
            myStreamReader.Close();
            myResponseStream.Close();
            return retString;
        }

        /// <summary>
        /// HttpClient Post请求接口
        /// </summary>
        /// <param name="url"></param>
        /// <param name="json"></param>
        /// <returns></returns>
        public static string PostGetJsonData(string url, string json, string jiraBasic)
        {
            HttpContent httpContent = new StringContent(json);
            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            var httpClient = new HttpClient();
            if (!string.IsNullOrEmpty(jiraBasic))
            {
                System.Net.Http.Headers.AuthenticationHeaderValue authValue = new AuthenticationHeaderValue("Basic", jiraBasic);
                httpClient.DefaultRequestHeaders.Authorization = authValue;
            }
            string responseJson = string.Empty;
            HttpResponseMessage response = httpClient.PostAsync(url, httpContent).Result;

            if (response.IsSuccessStatusCode)
                responseJson = response.Content.ReadAsStringAsync().Result;
            else
                responseJson = MyLib.SerializeUtil.JsonSerialize(new { code = -1, message = "PostGetJsonData：Error,StatusCode:" + response.StatusCode.ToString() });

            return responseJson;
        }
        #endregion
    }
}