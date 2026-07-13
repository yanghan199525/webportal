<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UPMApproval.aspx.cs" Inherits="UWF.Process.DemoProcess.UPMApproval" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UPMUserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UPMApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UPMMultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UPMButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
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
                                <ui:userinfo id="UserInfo1" processtitle="Demo Process" processpefix="DPT" tablename="PROC_DEMOPROCESS"
   tablenamedetail="PROC_DEMOPROCESS_DT,PROC_DEMOPROCESS002_DT" runat="server"></ui:userinfo>
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
                                                            <ult:RadioButtonList ID="read_APPLICATIONTYPE" title="radionButtonList" data-field="APPLICATIONTYPE"  Variable="" Source="DataSource.Resource" Filter="TYPE='PRApplicationType' and ISACTIVE=1" ControlValue="Capex" CssClass="form-control validate[required]" RepeatDirection="Horizontal" runat="server">
                                                                </ult:radiobuttonlist>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_APPOINTEDVENDOR">
                                                        <label for="fld_APPOINTEDVENDOR"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor") %></label>
                                                            <asp:TextBox name="read_APPOINTEDVENDOR" ID="read_APPOINTEDVENDOR" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 hidden">
                                                    <div class="position-relative form-group" id="div_field_APPOINTEDVENDORHIDE">
                                                        <label for="fld_APPOINTEDVENDORHIDE"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendorhide") %></label>
                                                            <asp:TextBox name="read_APPOINTEDVENDORHIDE" ID="read_APPOINTEDVENDORHIDE" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_TIME">
                                                        <label for="fld_TIME"><%=Lang.Get("UWF.Process.DemoProcess.time") %></label>
                                                            <asp:TextBox name="read_TIME" ID="read_TIME" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_SINGLESELECTUSER">
                                                        <label for="fld_SINGLESELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.singleselectuser") %></label>
                                                            <asp:TextBox name="read_SINGLESELECTUSER" ID="read_SINGLESELECTUSER" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-8 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_CHECKBOXLIST">
                                                        <label for="fld_CHECKBOXLIST"><%=Lang.Get("UWF.Process.DemoProcess.checkboxList") %></label>
                                                            <ult:CheckBoxList ID="read_CHECKBOXLIST" title="checkboxList" data-field="CHECKBOXLIST"  Variable="" Source="DataSource.Resource" Filter="TYPE='Type_Of_Account'ORDER BY OrderNo" ControlValue="" CssClass="form-control " RepeatDirection="Horizontal" runat="server">
                                                                </ult:checkboxlist>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_LINK">
                                                        <label for="fld_LINK"><%=Lang.Get("UWF.Process.DemoProcess.link") %></label>
                                                            <asp:TextBox name="read_LINK" ID="read_LINK" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_ATTACHMENT">
                                                        <label for="fld_ATTACHMENT"><%=Lang.Get("UWF.Process.DemoProcess.attachment") %></label>
                                                            <div class="input-prepend input-group">
                                                                <div class="attachment_show input-group-prepend">
                                                                    <div class="btn-icon btn-icon-only btn btn-shadow btn-outline-light" title="attachment"
                                                                            onclick="showForm({title:'',url:'<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/AttachmentShow.aspx?processname=<%=Server.UrlEncode(Request.QueryString["processname"])%>&incident=<%=Request.QueryString["incident"]%>&formid=<%=Request.QueryString["formid"]%>&type=att_ATTACHMENT&readonly=0'});" >
                                                                        <i class="fa fa-fw btn-icon-wrapper"></i>
                                                                    </div>
                                                                </div>
                                                                <div class="input-group-append ml-2" style="padding-top: .3rem;">
                                                                    <%=Ultimus.UWF.Common.Logic.AttachmentLogic.GetSingleUrlByType(Request.QueryString["ProcessName"] ,MyLib.ConvertUtil.ToInt32(Request.QueryString["Incident"]),"att_ATTACHMENT") %>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_MULTISELECTWINDOW">
                                                        <label for="fld_MULTISELECTWINDOW"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectWindow") %></label>
                                                            <asp:TextBox name="read_MULTISELECTWINDOW" ID="read_MULTISELECTWINDOW" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-12 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_MULTITEXTBOX">
                                                        <label for="fld_MULTITEXTBOX"><%=Lang.Get("UWF.Process.DemoProcess.MultiTextBox") %></label>
                                                            <asp:TextBox name="read_MULTITEXTBOX" ID="read_MULTITEXTBOX" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_DATE">
                                                        <label for="fld_DATE"><%=Lang.Get("UWF.Process.DemoProcess.date") %></label>
                                                            <asp:TextBox name="read_DATE" ID="read_DATE" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_LABEL">
                                                        <label for="fld_LABEL"><%=Lang.Get("UWF.Process.DemoProcess.label") %></label>
                                                            <asp:TextBox name="read_LABEL" ID="read_LABEL" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_DROPDOWNLIST">
                                                        <label for="fld_DROPDOWNLIST"><%=Lang.Get("UWF.Process.DemoProcess.dropdownList") %></label>
                                                            <asp:TextBox name="read_DROPDOWNLIST" ID="read_DROPDOWNLIST" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_DATETIMEDATE">
                                                        <label for="fld_DATETIMEDATE"><%=Lang.Get("UWF.Process.DemoProcess.datetimedate") %></label>
                                                            <asp:TextBox name="read_DATETIMEDATE" ID="read_DATETIMEDATE" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_MULTISELECTUSER">
                                                        <label for="fld_MULTISELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectUser") %></label>
                                                            <asp:TextBox name="read_MULTISELECTUSER" ID="read_MULTISELECTUSER" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_BUTTONLIST">
                                                        <label for="fld_BUTTONLIST"><%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %></label>
                                                            <asp:TextBox name="read_BUTTONLIST" ID="read_BUTTONLIST" class="form-control" Format="" runat="server" type="text" ReadOnly></asp:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">
                                                    <div class="position-relative form-group" id="div_field_CHECKBOX">
                                                        <label for="fld_CHECKBOX"><%=Lang.Get("UWF.Process.DemoProcess.checkbox") %></label>
                                                            <ult:CheckBox ID="read_CHECKBOX" title="checkbox" Enabled="false" data-field="CHECKBOX"  Variable="" CssClass="form-control " runat="server">
                                                                </ult:checkbox>   
                                                    </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                            <!--1.2多行-->
                            <!--Start Item table-->
                            <div class="main-card mb-2 card form_card ">
                                <div class="card-body form_row" id="div_panel_DemoProcess_DT">
                                    <h5 class="card-title form-title" data-toggle="collapse" data-target="#tabDemoProcess_DT" aria-expanded="true" aria-controls="tabDemoProcess_DT" 
                                            style="cursor: pointer;" onclick="tabFormTitle(this)">
                                        <span><i class="fa fa-fw"></i><%=Lang.Get("UWF.Process.DemoProcess.DemoProcess_DT") %></span>
                                        <div class="btn-actions-pane-right">
                                            <i class="fa fa-chevron-down ml-2 opacity-8 fa-angle"></i>
                                        </div>
                                    </h5>
                                    <!--Start detail table-->
                                    <div class="form-row collapse show" id="tabDemoProcess_DT">
                                        <div class="div_DemoProcess_DT" style="width: 100%; overflow-x: scroll;">
                                            <table id="tb_DEMOPROCESS_DT" class="table table-bordered form-detail-table" width="100%">
                                                <thead>
                                                    <tr>
                                                        <td nowrap="nowrap" class="hidden">
                                                            <input id="tb_DEMOPROCESS_DT_rowCount" type="text" runat="server" />
                                                        </td>
                                                        <td nowrap="nowrap" style="width: 50px">
                                                            <%=Lang.Get("No") %>
                                                        </td>
                                                                <td nowrap="nowrap" style=""  class="  td_APPLICATIONTYPE"><%=Lang.Get("UWF.Process.DemoProcess.ApplicationType") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_APPOINTEDVENDOR"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor") %></td>
                                                                <td nowrap="nowrap" style=""  class="hidden  td_APPOINTEDVENDORHIDE"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendorhide") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_TIME"><%=Lang.Get("UWF.Process.DemoProcess.time") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_SINGLESELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.singleselectuser") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_CHECKBOXLIST"><%=Lang.Get("UWF.Process.DemoProcess.checkboxList") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_LINK"><%=Lang.Get("UWF.Process.DemoProcess.link") %></td>
                                                                <td nowrap="nowrap" style="width:150px;"  class="hidden  td_ATTACHMENT"><%=Lang.Get("UWF.Process.DemoProcess.attachment") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_MULTISELECTWINDOW"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectWindow") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_MULTITEXTBOX"><%=Lang.Get("UWF.Process.DemoProcess.MultiTextBox") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_DATE"><%=Lang.Get("UWF.Process.DemoProcess.date") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_LABEL"><%=Lang.Get("UWF.Process.DemoProcess.label") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_DROPDOWNLIST"><%=Lang.Get("UWF.Process.DemoProcess.dropdownList") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_DATETIMEDATE"><%=Lang.Get("UWF.Process.DemoProcess.datetimedate") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_MULTISELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectUser") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_BUTTONLIST"><%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_CHECKBOX"><%=Lang.Get("UWF.Process.DemoProcess.checkbox") %></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <ult:Repeater ID="read_detail_PROC_DEMOPROCESS_DT" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="hidden">
                                                                    <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                                </td>
                                                                <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                                    <div class="index"><%#Eval("ROWNO")%> </div>
                                                                    <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                                    </ult:TextBox>
                                                                    <ult:TextBox ID="fld_ROWGUID" data-field="ROWGUID" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWGUID")%>'>
                                                                    </ult:TextBox>
                                                                </td>
                                                                        <td class="  td_APPLICATIONTYPE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.ApplicationType").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_APPLICATIONTYPE" title="radionButtonList" data-field="APPLICATIONTYPE" runat="server" Text='<%#Eval("APPLICATIONTYPE")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_APPOINTEDVENDOR" data-label='<%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_APPOINTEDVENDOR" title="" data-field="APPOINTEDVENDOR" runat="server" Text='<%#Eval("APPOINTEDVENDOR")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="hidden  td_APPOINTEDVENDORHIDE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.AppointedVendorhide").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_APPOINTEDVENDORHIDE" title="popupWindow" data-field="APPOINTEDVENDORHIDE" runat="server" Text='<%#Eval("APPOINTEDVENDORHIDE")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_TIME" data-label='<%=Lang.Get("UWF.Process.DemoProcess.time").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_TIME" title="time" data-field="TIME" Format="" runat="server" Text='<%#Eval("TIME")%>' Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_SINGLESELECTUSER" data-label='<%=Lang.Get("UWF.Process.DemoProcess.singleselectuser").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_SINGLESELECTUSER" title="singleselectuser" data-field="SINGLESELECTUSER" runat="server" Text='<%#Eval("SINGLESELECTUSER")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_CHECKBOXLIST" data-label='<%=Lang.Get("UWF.Process.DemoProcess.checkboxList").Split('<')[0] %>'>
                                                                                    <ult:CheckBoxList ID="fld_CHECKBOXLIST" title="checkboxList"  data-field="CHECKBOXLIST" CssClass="" Source="DataSource.Resource" Filter="TYPE='Type_Of_Account'ORDER BY OrderNo" RepeatDirection="Horizontal" runat="server" ControlValue='<%#Eval("CHECKBOXLIST")%>' Enabled="false"> </ult:CheckBoxList>
                                                                        </td>
                                                                        <td class="  td_LINK" data-label='<%=Lang.Get("UWF.Process.DemoProcess.link").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_LINK" title="link" data-field="LINK" runat="server" Text='<%#Eval("LINK")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="hidden  td_ATTACHMENT" data-label='<%=Lang.Get("UWF.Process.DemoProcess.attachment").Split('<')[0] %>'>
<%#Ultimus.UWF.Common.Logic.AttachmentLogic.GetSingleUrl(MyLib.ConvertUtil.ToString(Eval("FORMID")),Request.QueryString["ProcessName"],"fld_detail_PROC_DemoProcess_DT",MyLib.ConvertUtil.ToString(Eval("ROWNO"))) %>                                                                        </td>
                                                                        <td class="  td_MULTISELECTWINDOW" data-label='<%=Lang.Get("UWF.Process.DemoProcess.MultiSelectWindow").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_MULTISELECTWINDOW" title="MultiSelectWindow" data-field="MULTISELECTWINDOW" runat="server" Text='<%#Eval("MULTISELECTWINDOW")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_MULTITEXTBOX" data-label='<%=Lang.Get("UWF.Process.DemoProcess.MultiTextBox").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_MULTITEXTBOX" title="MultiTextBox" data-field="MULTITEXTBOX" runat="server" Text='<%#Eval("MULTITEXTBOX")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_DATE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.date").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_DATE" title="date" data-field="DATE" Format="" runat="server" Text='<%#Eval("DATE")%>' Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_LABEL" data-label='<%=Lang.Get("UWF.Process.DemoProcess.label").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_LABEL" title="label" data-field="LABEL" runat="server" Text='<%#Eval("LABEL")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_DROPDOWNLIST" data-label='<%=Lang.Get("UWF.Process.DemoProcess.dropdownList").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_DROPDOWNLIST" title="dropdownList" data-field="DROPDOWNLIST" runat="server" Text='<%#Eval("DROPDOWNLIST")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_DATETIMEDATE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.datetimedate").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_DATETIMEDATE" title="datetimedate" data-field="DATETIMEDATE" Format="" runat="server" Text='<%#Eval("DATETIMEDATE")%>' Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class="  td_MULTISELECTUSER" data-label='<%=Lang.Get("UWF.Process.DemoProcess.MultiSelectUser").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_MULTISELECTUSER" title="MultiSelectUser" data-field="MULTISELECTUSER" runat="server" Text='<%#Eval("MULTISELECTUSER")%>' Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class=" td_BUTTONLIST" data-label='<%=Lang.Get("UWF.Process.DemoProcess.buttonlist").Split('<')[0] %>'>
                                                                            <ult:TextBox ID="fld_BUTTONLIST" title="buttonlist" data-type='string' onblur="checkExpression(this)"  data-field="BUTTONLIST" CssClass="hidden " ControlValue='<%#Eval("BUTTONLIST")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                            <div title="buttonlist" id="Button_BUTTONLIST" class="btn-icon btn btn-light hidden-print btnJson" data-prompt-position="bottomLeft">
                                                                               <%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %>
                                                                            </div>
                                                                        </td>
                                                                        <td class="  td_CHECKBOX" data-label='<%=Lang.Get("UWF.Process.DemoProcess.checkbox").Split('<')[0] %>'>
                                                                                    <ult:CheckBox ID="fld_CHECKBOX" title="checkbox"  data-field="CHECKBOX" CssClass="" runat="server" ControlValue='<%#Eval("CHECKBOX")%>' Enabled="false"></ult:CheckBox>
                                                                        </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </ult:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="padding-t-5"></div>
                                    </div>
                                    <!--End detail table-->
                                </div>
                            </div>
                            <!--End Item table-->
                            <!--1.2多行-->
                            <!--Start Item table-->
                            <div class="main-card mb-2 card form_card ">
                                <div class="card-body form_row" id="div_panel_DemoProcess002_DT">
                                    <h5 class="card-title form-title" data-toggle="collapse" data-target="#tabDemoProcess002_DT" aria-expanded="true" aria-controls="tabDemoProcess002_DT" 
                                            style="cursor: pointer;" onclick="tabFormTitle(this)">
                                        <span><i class="fa fa-fw"></i><%=Lang.Get("UWF.Process.DemoProcess.DemoProcess002_DT") %></span>
                                        <div class="btn-actions-pane-right">
                                            <i class="fa fa-chevron-down ml-2 opacity-8 fa-angle"></i>
                                        </div>
                                    </h5>
                                    <!--Start detail table-->
                                    <div class="form-row collapse show" id="tabDemoProcess002_DT">
                                        <div class="div_DemoProcess002_DT" style="width: 100%; overflow-x: scroll;">
                                            <table id="tb_DEMOPROCESS002_DT" class="table table-bordered form-detail-table" width="100%">
                                                <thead>
                                                    <tr>
                                                        <td nowrap="nowrap" class="hidden">
                                                            <input id="tb_DEMOPROCESS002_DT_rowCount" type="text" runat="server" />
                                                        </td>
                                                        <td nowrap="nowrap" style="width: 50px">
                                                            <%=Lang.Get("No") %>
                                                        </td>
                                                                <td nowrap="nowrap" style=""  class="  td_MONEY001"><%=Lang.Get("UWF.Process.DemoProcess.money001") %></td>
                                                                <td nowrap="nowrap" style=""  class="  td_MONEY002"><%=Lang.Get("UWF.Process.DemoProcess.money002") %></td>
                                                                <td nowrap="nowrap" style="" data-expression="{MONEY001}*{MONEY002}" class="  td_MONEY003"><%=Lang.Get("UWF.Process.DemoProcess.money003") %></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <ult:Repeater ID="read_detail_PROC_DEMOPROCESS002_DT" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="hidden">
                                                                    <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                                </td>
                                                                <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                                    <div class="index"><%#Eval("ROWNO")%> </div>
                                                                    <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                                    </ult:TextBox>
                                                                    <ult:TextBox ID="fld_ROWGUID" data-field="ROWGUID" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWGUID")%>'>
                                                                    </ult:TextBox>
                                                                </td>
                                                                        <td class=" text-right td_MONEY001" data-label='<%=Lang.Get("UWF.Process.DemoProcess.money001").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_MONEY001" title="money001" data-field="MONEY001" runat="server" Text='<%#Eval("MONEY001")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class=" text-right td_MONEY002" data-label='<%=Lang.Get("UWF.Process.DemoProcess.money002").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_MONEY002" title="money002" data-field="MONEY002" runat="server" Text='<%#Eval("MONEY002")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                                        <td class=" text-right td_MONEY003" data-label='<%=Lang.Get("UWF.Process.DemoProcess.money003").Split('<')[0] %>'>
                                                                                    <ult:Label ID="fld_MONEY003" title="money003" data-field="MONEY003" runat="server" Text='<%#Eval("MONEY003")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                                        </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </ult:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="padding-t-5"></div>
                                    </div>
                                    <!--End detail table-->
                                </div>
                            </div>
                            <!--End Item table-->
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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=6a12356e-240e-4725-b9ea-85ea86217b75'></script>
    <script type='text/javascript' src='Approval.js?t=7ecefde4-c1c6-4667-9ee3-32e722878204'></script>
</body>
</html>
