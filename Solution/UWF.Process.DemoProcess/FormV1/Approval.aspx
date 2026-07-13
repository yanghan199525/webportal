<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.DemoProcess.Approval" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="Ultimus.UWF.Form.ProcessControl.V3" %>
<%@ Import Namespace="Ultimus.UWF.Workflow.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get(Request.QueryString["ProcessName"]) %></title>
    <style type="text/css">
        #formData table tbody td {
            padding: .3rem !important;
        }
    </style>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
        }
    </script>
</head>
<body>
    <div class="app-container app-theme-white fixed-header fixed-sidebar body-tabs-line">
        <form id="form1" runat="server">
            <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
            <div class="tab-content">
                <div class="tab-pane tabs-animation fade show active" id="tab-content-0" role="tabpanel">
                    <div class="main-card mb-2 card mr-3 ml-3">
                        <div class="card-body">
                            <!--定义UserInfo-->
                                <ui:userinfo id="UserInfo1" processtitle="Demo Process" processprefix="DPT" tablename="PROC_DEMOPROCESS"
    tablenamedetail="" runat="server"></ui:userinfo>
                        </div>
                    </div>

                    <div class="formData mr-3 ml-3">
                        <!--End main table-->
                        <!--1.对Table做循环，判断单行,多行-->
                            <!--1.1单行-->
                            <div class="main-card mb-2 card form_card">
                                <div class="card-body form_row" id="div_panel_DemoProcess">
                                    <h5 class="card-title form-title" data-toggle="collapse" data-target="#tabDemoProcess" aria-expanded="true" aria-controls="tabDemoProcess" 
                                            style="cursor: pointer;" onclick="tabFormTitle(this)">
                                        <span><i class="fa fa-fw"></i><%=Lang.Get("UWF.Process.DemoProcess.DemoProcess") %></span>
                                        <div class="btn-actions-pane-right">
                                            <i class="fa fa-chevron-down ml-2 opacity-8 fa-angle"></i>
                                        </div>
                                    </h5>
                                    <div class="form-row collapse show" id="tabDemoProcess">
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_APPLICATIONTYPE">
                                                        <label for="fld_APPLICATIONTYPE"><%=Lang.Get("UWF.Process.DemoProcess.ApplicationType") %></label>
                                                            <ult:RadioButtonList ID="read_APPLICATIONTYPE" title="" data-field="APPLICATIONTYPE"  Variable="" Source="DataSource.Resource" Filter="TYPE='PRApplicationType' and ISACTIVE=1" ControlValue="Capex" CssClass="form-control validate[required]" RepeatDirection="Horizontal" runat="server">
                                                                </ult:radiobuttonlist>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_APPOINTEDVENDOR">
                                                        <label for="fld_APPOINTEDVENDOR"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor") %></label>
                                                            <asp:TextBox name="read_APPOINTEDVENDOR" ID="read_APPOINTEDVENDOR" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
                <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
                <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
                <div class="tab-pane tabs-animation fade mr-3 ml-3" id="tab-content-3" role="tabpane3">
                    <div class="main-card mb-3 card">
                        <div class="card-body">
                            <%--TAB3--%>
                            <iframe id="rightframe" name="rightframe" hspace="0" vspace="0" src='../../Ultimus.UWF.Form.ProcessControl.V3/GraphicalView.aspx?ProcessName=<%=Server.UrlEncode(Request.QueryString["ProcessName"]) %>&Incident=<%=Request.QueryString["Incident"] %>&TaskId=<%=Request.QueryString["TaskId"] %>&ServerName=<%=Request.QueryString["ServerName"] %>' frameborder="0" width="98%" height="600"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=2f5705e0-88f7-4555-8985-167a47f176a7'></script>
    <script type='text/javascript' src='Approval.js?t=76d77a1d-245e-4194-8b74-3bd05394ff5b'></script>
</body>
</html>
