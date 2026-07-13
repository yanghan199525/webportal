using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Security.Interface;
using MyLib;
using System.Data;
using Ultimus.UWF.OrgChart.Entity;
using Ultimus.UWF.OrgChart.Interface;
using Ultimus.UWF.Common.Interface;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Net;
using MyLib.Json;

namespace Ultimus.UWF.Home.V3
{
    public partial class MobileLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Redirect("MobileBlank.aspx?OpenType=Moblie", false);
                //string Ras = "704d617774794d6c5a4d7656586b4d46777333637959702f7073657844746e317554484e6d56696b63703677745143765963627741724a586668646c336952764d6e5368447967706645613233784f2f7a6a416b4d4272736365514335595a354d58316e574870524c4f494c4130702f43636168724f54796f385a7445527754526d756e5a4345307846685a434f533732366c6c39416c4a724c744b3553656b636b75354e6165537753673d";
                //RSACryptoServiceProvider ras = new RSACryptoServiceProvider();
                //string bbb = "";
                //ras.FromXmlString(Ras);
                //var cipherbytes = ras.Decrypt(Convert.FromBase64String(bbb), true);
                //string aaa= Encoding.UTF8.GetString(cipherbytes);

                string ssoUser = "";
                //string type = "text/html;charset=UTF-8";
                try
                {
                    //string id = Request.QueryString["userToken"];
                    //string id = "7032323157734F556B722F542F3239434F70656D6C513D3D";

                    //string url = "http://octopus.chinafamilymart.com.cn:40129/sys/bpmRelative/aesDecode?id=" + id + "&version=familymartV3";
                   // string url = "http://10.0.100.17:40126/joinEmpMobileEidt/aesDecode?id=" + id + "&version=familymartV3";
                   // HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                   // request.Method = "GET";
                   // request.ContentType = "text/html;charset=UTF-8";
                   // HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                   // Stream myResponseStream = response.GetResponseStream();
                   // StreamReader myStreamReader = new StreamReader(myResponseStream, Encoding.UTF8);
                   // string ssoUser = "CustomOC\\" + myStreamReader.ReadToEnd();
                   //// Userdata json = JsonConvert.DeserializeObject<Userdata>(myStreamReader.ReadToEnd());
                   // myStreamReader.Close();
                   // myResponseStream.Close();
                   // string ssoPassword = "";

                    if (HttpContext.Current.Session["LoginName"] != null)
                        HttpContext.Current.Session["LoginName"] = null;

                    if (!string.IsNullOrEmpty(ssoUser))
                    {
                        string sql = "select COUNT(*) from V_ORG_USER where loginname='" + ssoUser + "'";
                        int count = ConvertUtil.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(sql));
                        //ssoUser = StringUtil.FromBase64String(ssoUser);
                        if (count > 0)
                        {
                            SessionLogic.CheckLicenseExpired();
                            ISession session = ServiceContainer.Instance().GetService<ISession>();
                            //session.QuitLogin(ssoUser, ssoPassword);
                            try
                            {
                                string EmpNo =ConvertUtil.ToString(DataAccess.Instance("BizDB").ExecuteScalar("select EMPNO FROM V_org_user where loginname=N'" + ssoUser + "'"));
                                string loginSql = "insert into MNG_FM_Login_Log (EmpNo,CreateDate,WhereFrom) values('" + EmpNo + "',CONVERT(datetime,CONVERT(varchar, getdate(), 120)),1)";
                                count = DataAccess.Instance("BizDB").ExecuteNonQuery(loginSql);
                            }
                            catch (Exception)
                            {
                            }
                            Response.Redirect("MobileBlank.aspx?OpenType=Moblie",false);
                            return;
                        }
                        else
                        {
                            Response.Redirect("Login.aspx?OpenType=Moblie", false);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("Login.aspx?OpenType=Moblie", false);
                }
                

                //data dd = new data();
                // foreach (var item in json.data)
                // {
                //     dd.username = item.username;
                // }
               

            }
        }



          public class Userdata
          {
            public string ProductId { get; set; }
 
            public string ItemId { get; set; }
 
            public List<data> data {  get; set; }
          }
            
    public class data
    {
        public string username { get; set; }
    }


        
        //public static string RsaPrivateKeyToXml(string privateKey)
        //{
           
        //}
    }
}