using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyLib;
using Ultimus.UWF.Common.Logic;
using Ultimus.UWF.Workflow.Logic;

namespace UWF.Process.CAPEX_SERVICE
{
    public partial class ReportList : System.Web.UI.Page
    {
    protected void Page_Load(object sender, EventArgs e)
    {
    Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
    ProcessFormLogic process = new ProcessFormLogic();
    rpt.Source = "BizDB.select * from PROC_CAPEX_SERVICE where 1=1 "+process.GetReportViewSql    ("CAPEX_SERVICE",SessionLogic.GetLoginName());
    rpt.Sort = "incident desc";
    }
    protected void lbExport_Click(object sender, EventArgs e)
    {
    Ultimus.UWF.Form.WebControls.Repeater rpt = Page.FindControl("rptList") as Ultimus.UWF.Form.WebControls.Repeater;
    DataTable dt = rpt.GetFullDataTable();
    // dt数据为空不导出Excel
    if (dt.Rows.Count == 0 || dt == null)
    {
    return;
    }
    //dt=ExportLogic.GetExportTable("CAPEX_SERVICE");
    ExcelUtil.Export(dt);
    }


    public string WriteContext(object obj)
    {
    string msg = ConvertUtil.ToString(obj);
    msg = msg.Length > 10 ? msg.Substring(0, 10) : msg;
    return msg;
    }


    public string GetStatus(string status)
    {
    if (status == "1")
    {
    return "处理中";
    }
    else if (status == "2")
    {
    return "已完成";
    }
    else if (status == "4")
    {
    return "终止";
    }
    else if (status == "3")
    {
    return "退回";
    }
    else
    {
    return "未知";
    }
    }

    public string GetStatusClass(string status)
    {
    if (status == "2")
    {
    return "label label-success";
    }
    if (status == "3")
    {
    return "label label-danger";
    }
    if (status == "4")
    {
    return "label label-danger";
    }
    return "label label-default";
    }
    protected void rpSource_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
    try
    {
    if (e.CommandName == "Download")
    {
    try
    {
    string FORMID = null;
    string documentNo = null;
    string incIdent = null;
    string processName = null;
    int len = e.CommandArgument.ToString().Split(',').Length - 1;
    if (len == 3)
    {
    FORMID = e.CommandArgument.ToString().Split(',')[0];
    documentNo = e.CommandArgument.ToString().Split(',')[1];
    incIdent = e.CommandArgument.ToString().Split(',')[2];
    processName = e.CommandArgument.ToString().Split(',')[3]; ;
    }


    string url = string.Format("/Portal/Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?&ProcessName={0}&incident={1}&Type=REPORT&UserName={2}&FORMID={3}", processName, incIdent, SessionLogic.GetLoginName(), FORMID);
    //url,流程名称，pdf名称
    bool html = HtmlToPDF(HttpContext.Current.Request.Url.Authority + "/" + url, processName, incIdent + "_" + documentNo);
    }
    catch (Exception ex)
    {
    MyLib.LogUtil.Error(SessionLogic.GetLoginName() + "下载PDF" + ex.Message);
    }
    }

    }
    catch (System.Exception ex)
    {
    MyLib.LogUtil.Error(ex);
    this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "message", "
    <script language='javascript' defer>alert('" + ex.Message.Replace("\n", " ").Replace("<br/>", " ").Replace("'", "") + "');</script>");
    }
    }
    public bool HtmlToPDF(string url, string processName, string FileName)
    {
    HtmlToPdf toPdf = new HtmlToPdf();
    toPdf.Options.PdfPageSize = PdfPageSize.A4;
    toPdf.Options.MarginRight = 3;
    toPdf.Options.MarginLeft = 3;
    PdfDocument pdf = toPdf.ConvertUrl(url.Trim());

    string strPath = ConfigurationManager.AppSettings["PathPdf"].ToString() + processName + "\\" + FileName + ".pdf";
    bool isOK = true;
    try
    {

    pdf.Save(strPath);
    }
    catch (Exception)
    {

    isOK = false;
    }

    pdf.Close();
    bool success = true;
    if (!System.IO.File.Exists(strPath))
    success = false;
    if (System.IO.File.Exists(strPath))
    {
    FileStream fs = new FileStream(strPath, FileMode.Open);
    byte[] bytes = new byte[(int)fs.Length];
    fs.Read(bytes, 0, bytes.Length);
    fs.Close();
    if (Request.UserAgent != null)
    {

    string userAgent = Request.UserAgent.ToUpper();
    if (userAgent.IndexOf("FIREFOX", StringComparison.Ordinal) <= 0)
    {
    Response.AddHeader("Content-Disposition",
    "attachment;  filename=" + HttpUtility.UrlEncode(FileName + ".pdf", Encoding.UTF8));
    }
    else
    {
    Response.AddHeader("Content-Disposition", "attachment;  filename=" + FileName + ".pdf");
    }
    }

    Response.ContentEncoding = Encoding.UTF8;
    Response.ContentType = "application/octet-stream";

    //通知浏览器下载文件而不是打开
    Response.BinaryWrite(bytes);
    Response.Flush();
    Response.End();
    fs.Close();
    System.IO.File.Delete(strPath);

    }

    return false;
    }
    }
    }
