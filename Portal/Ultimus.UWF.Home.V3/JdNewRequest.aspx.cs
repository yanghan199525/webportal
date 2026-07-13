
using DES_PSO.Web.Matlab;
using MyLib;
using MyLib.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultimus.UWF.Common.Interface;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Form.ProcessControl.V3.userdefinedLogic;
using Ultimus.UWF.Workflow.Interface;

namespace Ultimus.UWF.Home.V3
{
    public partial class JdNewRequest : System.Web.UI.Page
    {
        IWorkflow _workflow = ServiceContainer.Instance().GetService<IWorkflow>();
        string applypurpose;
        string fixedassets_value;
        string appRemark;
        string documentNo;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                DropDownList fld_APPLYPURPOSE = (DropDownList)Page.FindControl("fld_APPLYPURPOSE");
                RadioButtonList fld_FIXEDASSETS = (RadioButtonList)Page.FindControl("fld_FIXEDASSETS");
                 applypurpose = fld_APPLYPURPOSE.SelectedItem.Text;
                 fixedassets_value = fld_FIXEDASSETS.SelectedItem.Text;
                 documentNo = this.txt_DOCUMENTNO.Text;
                 appRemark = this.fld_APPREMARK.Text;

                
                    string loginName;
                    if (Request["orderID"] != null && Request["loginName"] != null)
                    {
                        LogUtil.Info($"京东数据documentNo");
                        documentNo = Request["orderID"];
                         loginName = Request["loginName"];
                        if (GetProcessName(documentNo))
                        {
                            Response.Write("<script>alert('当前京东订单审批流已经创建，无法再次创建!');window.location.href='info/info.aspx';window.close(); </script>");
                        }
                        else {
                            BindJdOrderData(documentNo);
                            string languageCE = GetLanguage(loginName);
                            ////多语言显示下拉框
                            PersonInfo pr = new PersonInfo();
                            pr.Loding(GetCname(loginName), languageCE);
                        }
                    }
                    else {
                    string uid = Request["uid"].Replace(" ", "+");
                    string submitOrderTime = Request["submitOrderTime"].Replace(" ", "+");
                    string orderId = Request["orderId"].Replace(" ", "+");
                    string totalMoney = Request["totalMoney"].Replace(" ", "+");
                    string freight = Request["freight"].Replace(" ", "+");
                    string sign = Request["sign"].Replace(" ", "+");
                   // string platType = Request["platType"].Replace(" ", "+");

                    JDOrderReq jDOrderReq = new JDOrderReq
                    {
                        uid = uid,
                        submitOrderTime = submitOrderTime,
                        orderId = orderId,
                        totalMoney = totalMoney,
                        freight = freight,
                        sign = sign,
                        //platType= platType
                    };
                    bool result = SaveOrder(jDOrderReq, out string message, out string orderInfo);
                        LogUtil.Info($"京东数据:{result}{message}{orderInfo}");
                        if (result)
                        {
                            documentNo = orderInfo.Split('-')[0];
                            loginName = orderInfo.Split('-')[1];

                        string domain = "CustomOC";
                        string ssoUser = domain + "\\" + loginName.ToLower();
                        string ssoPassword = ConfigurationManager.AppSettings["AdminPwd"].ToString();
                        SessionLogic.CheckLicenseExpired();
                        ISession session = ServiceContainer.Instance().GetService<ISession>();
                        session.Login(ssoUser, ssoPassword);

                        LogUtil.Info(typeof(Login), "Login,User:" + loginName + ", IP:" + Request.UserHostAddress);

                        if (GetProcessName(documentNo))
                            {
                                Response.Write("<script>alert('当前京东订单审批流已经创建，无法再次创建!');window.location.href='info/info.aspx';window.close(); </script>");
                            }
                            else
                            {
                                BindJdOrderData(documentNo);
                                string languageCE = GetLanguage(loginName);
                                ////多语言显示下拉框
                                PersonInfo pr = new PersonInfo();
                                pr.Loding(GetCname(loginName), languageCE);
                            }
                        }
                        else
                        {
                            Response.Write("<script>alert('提交失败！失败原因:" + message.Replace("'", "\\'").Replace("\r\n", "\\r\\n") + "');window.location.href='info/info.aspx';window.close(); </script>");
                        }
                    }
                    
                
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('"+ex.Message.Replace("'", "\\'").Replace("\r\n", "\\r\\n") + "');window.location.href='info/info.aspx';window.close(); </script>");
                throw;
            }
          
        }

        public bool SaveOrder(JDOrderReq jDOrderReq, out string message, out string orderInfo)
        {
            orderInfo = "";
            message = "";
            try
            {
                string SodexoWebApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["WEB_API_URL"].ToString();
                string url = string.Format("{0}/api/bpmOrder/OROrder", SodexoWebApiUrl);
                LogUtil.Info($"京东订单接口数据:{jDOrderReq}");
                string response = HttpUtil.HttpPostWithHeader(url, null, JsonConvert.SerializeObject(jDOrderReq), "application/json;charset=UTF-8");
                LogUtil.Info($"京东订单接口返回数据:{response}");
                Result<string> r = FromJSON<Result<string>>(response);
                if (r.code == 0)
                {
                    message = r.message+"--"+ r.data;
                    return false;
                }
                else
                {
                    orderInfo = r.data;
                    return true;
                }
            }
            catch (Exception ex)
            {
                message = ex.Message;
                return false;
            }
          
        }
        public static string GetCname(string loginName)
        {
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT USERNAME FROM ORG_USER WHERE LOGINNAME='" + loginName + "' ");
            DataTable db = DataAccess.Instance("BizDB").ExecuteDataTable(sSql.ToString());
            return db.Rows[0]["USERNAME"].ToString();
        }
        private string GetLanguage(string loginName)
        {
            string language = "";
            StringBuilder sSql = new StringBuilder();
            sSql.Append("SELECT LANGUAGE FROM ORG_USER WHERE LOGINNAME='" + loginName + "'");
            language = DataAccess.Instance("BizDB").ExecuteScalar(sSql.ToString()).ToString();
            return language;
        }

        public bool GetProcessName(string orderID) {
            string sql = string.Format("SELECT COUNT(OrderID) FROM PROC_YG_DOCUMENTNO WHERE OrderID='{0}'", orderID);
            int result=Convert.ToInt32(DataAccess.Instance("BizDB").ExecuteScalar(sql));
            return result > 0;
        }
        public void BindJdOrderData(string documentNo)
        {
            string sql = string.Format("select INCIDENT,CREATEBY,CREATEBYCODE,REQUESTDATE, DOCUMENTNO,PurchasingPurpose,SITECODE,SITENAME,DELIVERYDATE,SUPPLIERCODE,SUPPLIERNAME,POAmount,IsCapex,APPREMARK,USER_SIGNEDAPPROVER,USER_SIGNEDAPPROVER2,USER_SIGNEDAPPROVER3,freight from PROC_JD_ORDER WHERE DOCUMENTNO='{0}'", documentNo);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                this.fld_APPLICANT.Text = dt.Rows[0]["CREATEBY"].ToString();
                this.fld_APPLICANTCODE.Text = dt.Rows[0]["CREATEBYCODE"].ToString();
                this.fld_REQUESTDATE.Text = dt.Rows[0]["REQUESTDATE"].ToString();
                this.txt_DOCUMENTNO.Text = dt.Rows[0]["DOCUMENTNO"].ToString();
                this.fld_DELIVERYDATE.Text = dt.Rows[0]["DELIVERYDATE"].ToString();
                this.fld_SITECODE.Text = dt.Rows[0]["SITECODE"].ToString();
                this.fld_SITENAME.Text = dt.Rows[0]["SITENAME"].ToString();
                this.fld_SUPPLIERCODE.Text = dt.Rows[0]["SUPPLIERCODE"].ToString();
                this.fld_SUPPLIERNAME.Text = dt.Rows[0]["SUPPLIERNAME"].ToString();
                this.fld_POAMOUNT.Text = dt.Rows[0]["POAmount"].ToString();
                this.fld_APPREMARK.Text = dt.Rows[0]["APPREMARK"].ToString();
                this.fld_freight.Text = dt.Rows[0]["freight"]!= DBNull.Value? Convert.ToDouble(dt.Rows[0]["freight"]).ToString("f2") : "0.00";
                string incident = dt.Rows[0]["INCIDENT"].ToString();
                BindJdOrderDetail(incident);
            }
        }

        public void BindJdOrderDetail(string incident)
        {
            string sql = string.Format("select SKUCode,SKUName,MaterialType,OrderUnit,OrderQuantity,Price,TaxRate,GoodsAmount from PROC_JD_ORDER_ITEMS where INCIDENT='{0}'", incident);
            DataTable dt = DataAccess.Instance("BizDB").ExecuteDataTable(sql);
            List<Jd_Order_Item> list = new List<Jd_Order_Item>();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Jd_Order_Item jd_Order_Item = new Jd_Order_Item();
                    jd_Order_Item.ROWNO = i + 1;
                    jd_Order_Item.SKUCode = dt.Rows[i]["SKUCode"].ToString();
                    jd_Order_Item.SKUName = dt.Rows[i]["SKUName"].ToString();
                    jd_Order_Item.MaterialType = dt.Rows[i]["MaterialType"].ToString();
                    jd_Order_Item.OrderUnit = dt.Rows[i]["OrderUnit"].ToString();
                    jd_Order_Item.OrderQuantity = dt.Rows[i]["OrderQuantity"].ToString();
                    jd_Order_Item.Price = dt.Rows[i]["Price"].ToString();
                    jd_Order_Item.TaxRate = dt.Rows[i]["TaxRate"].ToString();
                    jd_Order_Item.GoodsAmount = dt.Rows[i]["GoodsAmount"].ToString();
                    list.Add(jd_Order_Item);
                }
            }
            this.fld_detail_PROC_JD_ORDER_ITEMS.DataSource = list;
            this.DataBind();
        }
        public class Jd_Order_Item
        {
            public int ROWNO { get; set; }
            public string SKUCode { get; set; }
            public string SKUName { get; set; }
            public string MaterialType { get; set; }
            public string OrderUnit { get; set; }
            public string OrderQuantity { get; set; }
            public string Price { get; set; }
            public string TaxRate { get; set; }
            public string GoodsAmount { get; set; }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                this.btnSend.Visible = false;
                string sql = string.Format("UPDATE PROC_JD_ORDER SET PurchasingPurpose=N'{0}',IsCapex=N'{1}',APPREMARK=N'{3}' WHERE DOCUMENTNO='{2}'", applypurpose, fixedassets_value, documentNo, appRemark);
                DataAccess.Instance("BizDB").ExecuteNonQuery(sql);
                string SodexoWebApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["WEB_API_URL"].ToString();
                string urls = string.Format("{0}/api/bpmOrder/CreatProcess?documentNo={1}", SodexoWebApiUrl, documentNo);
                Encoding encoding = Encoding.UTF8;
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(urls.ToString());
                request.Method = "GET";
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                string result = "";
                using (StreamReader reader = new StreamReader(response.GetResponseStream(), encoding))
                {
                    result = reader.ReadToEnd();
                }
                Result<string> r = FromJSON<Result<string>>(result);
                if (r.code == 1)
                {
                    Response.Write("<script>alert('提交成功！');window.location.href='info/info.aspx';window.close();  </script>");
                    this.btnSend.Visible = false;
                }
                else
                {
                    Response.Write("<script>alert('提交失败！失败原因:" + r.message + "'); window.location.href='info/info.aspx';window.close();</script>");
                    this.btnSend.Visible = false;
                }
            }
            catch (Exception ex)
            {
                LogUtil.Error($"提交失败！失败原因：{ex.Message}");
                throw;
            }
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
        /// <summary>
        /// 统一返回结果
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class Result<T>
        {
            public int code { get; set; }
            public T data { get; set; }
            public string message { get; set; }
        }

        public class JDOrderReq
        {
            public string uid { get; set; }
            public string submitOrderTime { get; set; }
            public string orderId { get; set; }
            public string totalMoney { get; set; }
            public string freight { get; set; }
            public string sign { get; set; }
            public string platType { get; set; }
        }
    }
}