using DingTalk.Api;
using DingTalk.Api.Request;
using DingTalk.Api.Response;
using MyLib;
using MyLib.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;

namespace Ultimus.UWF.Home.V3.Logic
{
    /// <summary>
    /// 钉钉接口获取
    /// </summary>
    public class DingTalkLogic
    {
        public string Appkey = ConfigurationManager.AppSettings["DingTalk_Appkey"].ToString(); //
        public string Appsecret = ConfigurationManager.AppSettings["DingTalk_Appsecret"].ToString(); //

        /// <summary>
        /// 获取钉钉Token
        /// </summary>
        /// <returns></returns>
        protected string GetTokentest()
        {
            string access_token = "";
            try
            {
                IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/gettoken");
                OapiGettokenRequest req = new OapiGettokenRequest();
                req.Appkey = "dingcwlm92mtubphtsar";
                req.Appsecret = "c9oBdD1VAtYLAXTWPW-XL2W3ULK9AReHMA6JXQssZprVQS8BFe2MSGCR8Mu_nFUf";
                req.SetHttpMethod("GET");
                OapiGettokenResponse rsp = client.Execute(req, access_token);
                access_token = rsp.AccessToken;
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                throw;
            }
            return access_token;
        }

        public string GetToken()
        {
            string access_token = null;
            string Selectsql = "select top 1 * from [DingTalk_TokenLog] where getdate()<ExpiresData  order by id desc";
            System.Data.DataTable t = DataAccess.Instance("BizDB").ExecuteDataTable(Selectsql);
            if (t.Rows.Count <= 0)
            {
                //post请求
                string Url = "https://oapi.dingtalk.com/gettoken?appkey={0}&appsecret={1}";
                string GetUrl = string.Format(Url, Appkey, Appsecret);
                HttpClient _httpClient = new HttpClient();
                var response = _httpClient.GetAsync(GetUrl);
                DateTime DataNow = DateTime.Now;
                DateTime ExpiresData = DataNow.AddSeconds(7200);
                //分析返回数据
                var responseValue = response.Result.Content.ReadAsStringAsync().Result;
                access_token = JObject.Parse(responseValue)["access_token"].Value<string>();
                //string token_type = JObject.Parse(responseValue)["token_type"].Value<string>();
                string expires_in = JObject.Parse(responseValue)["expires_in"].Value<string>();
                string sql = @"INSERT INTO [dbo].[DingTalk_TokenLog]([corpsecret],[access_token],[expires_in],[CreateData],[ExpiresData])
                VALUES(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}')";
                sql = string.Format(sql, Appkey, access_token, expires_in, DataNow, ExpiresData);
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                return access_token;
            }
            else
            {
                string sql1 = "select top 1 * from [DingTalk_TokenLog] order by id desc";
                System.Data.DataTable m = DataAccess.Instance("BizDB").ExecuteDataTable(sql1);
                if (m.Rows.Count > 0)
                {
                    access_token = m.Rows[0]["access_token"].ToString();
                }
                return access_token;
            }
        }

        /// <summary>
        /// 获取钉钉用户ID
        /// </summary>
        /// <param name="access_token"></param>
        /// <param name="Code">免登授权码</param>
        /// <returns></returns>
        protected string Getuserinfo(string access_token, string Code)
        {
            string Userid = "";
            try
            {
                IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/user/getuserinfo");
                OapiUserGetuserinfoRequest req = new OapiUserGetuserinfoRequest();
                req.Code = Code;
                req.SetHttpMethod("GET");
                OapiUserGetuserinfoResponse rsp = client.Execute(req, access_token);
                Userid = rsp.Userid;
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                throw;
            }
            return Userid;
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="access_token"></param>
        /// <param name="Code">免登授权码</param>
        /// <returns></returns>
        public OapiUserGetResponse Getuser(string Code)
        {
            OapiUserGetResponse rsp = new OapiUserGetResponse();
            string access_token = GetToken();
            string Userid = Getuserinfo(access_token, Code);
            try
            {
                IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/user/get");
                OapiUserGetRequest req = new OapiUserGetRequest();
                req.Userid = Userid;
                req.SetHttpMethod("GET");
                rsp = client.Execute(req, access_token);
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                throw;
            }
            return rsp;
        }

        /// <summary>
        /// 获取钉钉工号
        /// </summary>
        /// <param name="Code">免登授权码</param>
        /// <returns></returns>
        public string GetJobNumber(string Code)
        {
            string JobNumber = string.Empty;
            try
            {
                OapiUserGetResponse rsp = new OapiUserGetResponse();
                rsp = Getuser(Code);
                JobNumber = rsp.Jobnumber;
            }
            catch (Exception ex)
            {
                LogUtil.Error(ex.Message);
                throw;
            }
            return JobNumber;
        }

    }
}