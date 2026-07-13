<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UPMNewRequest.aspx.cs" Inherits="UWF.Process.DemoProcess.UPMNewRequest" %>
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
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_DemoProcess_DT = Page.FindControl("fld_detail_PROC_DemoProcess_DT") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_DemoProcess_DT.AfterBind += new System.EventHandler(AfterBind);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_DemoProcess002_DT = Page.FindControl("fld_detail_PROC_DemoProcess002_DT") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_DemoProcess002_DT.AfterBind += new System.EventHandler(AfterBind);
            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_DemoProcess_DT = Page.FindControl("fld_detail_PROC_DemoProcess_DT") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_DemoProcess_DT.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_DemoProcess_DT,1);
            }
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_DemoProcess002_DT = Page.FindControl("fld_detail_PROC_DemoProcess002_DT") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_DemoProcess002_DT.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_DemoProcess002_DT,1);
            }
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
                                <ui:userinfo id="UserInfo1" processtitle="Demo Process" processprefix="DPT" tablename="PROC_DEMOPROCESS" tablenamedetail="PROC_DEMOPROCESS_DT,PROC_DEMOPROCESS002_DT" runat="server"></ui:userinfo>
                        </div>
                    </div>

                    <div class="formData mr-3 ml-3">
                        <!--1.对Table做循环，判断单行,多行-->
                        <!--   取余判断插入form-row标签-->
                            <div class="main-card mb-2 card form_card">
                                <div class="card-body form_row" id="div_panel_DemoProcess">
                                    <h5 class="card-title form-title" data-toggle="collapse" data-target="#tabDemoProcess" aria-expanded="true" aria-controls="tabDemoProcess" 
                                            style="cursor: pointer;" onclick="tabFormTitle(this)">
                                        <span><i class="fa fa-fw"></i><%=Lang.Get("UWF.Process.DemoProcess.DemoProcess") %></span>
                                        <div class="btn-actions-pane-right">
                                            <i class="fa fa-chevron-down ml-2 opacity-8 fa-angle"></i>
                                        </div>
                                    </h5>
                                    <!--1.对Table做循环，判断单行,多行-->
                                    <div class="form-row collapse show" id="tabDemoProcess">
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_APPLICATIONTYPE">
                                                        <label for="fld_APPLICATIONTYPE"><%=Lang.Get("UWF.Process.DemoProcess.ApplicationType") %></label>
                                                            <ult:RadioButtonList ID="fld_APPLICATIONTYPE" title="radionButtonList" data-field="APPLICATIONTYPE"  Variable="" Source="DataSource.Resource" Filter="TYPE='PRApplicationType' and ISACTIVE=1" ControlValue="Capex" CssClass="form-control validate[required]" RepeatDirection="Horizontal" runat="server">
                                                    </ult:radiobuttonlist>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_APPOINTEDVENDOR">
                                                        <label for="fld_APPOINTEDVENDOR"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_APPOINTEDVENDOR" title="" data-field="APPOINTEDVENDOR"  Variable="" CssClass="form-control validate[required] border-left-color" ControlValue="" 
                                                            onclick="selectDataSource({element:this,title:'',fields:'',dataSource:'Swatch - InvoiceMatchList 供应商查询',filter:'',single:true,IsMethod:true});" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text" style="cursor:pointer" onclick="$('#fld_APPOINTEDVENDOR').click()"><i class="fa fa-search"></i></span>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 hidden">

                                                    <div class="position-relative form-group" id="div_field_APPOINTEDVENDORHIDE">
                                                        <label for="fld_APPOINTEDVENDORHIDE"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendorhide") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_APPOINTEDVENDORHIDE" title="popupWindow" data-field="APPOINTEDVENDORHIDE"  Variable="" CssClass="form-control validate[required] border-left-color" ControlValue="" 
                                                            onclick="selectDataSource({element:this,title:'',fields:'',dataSource:'Swatch - InvoiceMatchList 供应商查询',filter:'',single:true,IsMethod:true});" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text" style="cursor:pointer" onclick="$('#fld_APPOINTEDVENDORHIDE').click()"><i class="fa fa-search"></i></span>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_TIME">
                                                        <label for="fld_TIME"><%=Lang.Get("UWF.Process.DemoProcess.time") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_TIME" title="time" data-field="TIME"  data-type="time" Format="" Variable="" CssClass="form-control " ControlValue="" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-prepend datepicker-trigger">
                                                                    <div class="input-group-text" onclick="$('#fld_TIME').click()">
                                                                        <i class="fa fa-calendar-alt"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_SINGLESELECTUSER">
                                                        <label for="fld_SINGLESELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.singleselectuser") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_SINGLESELECTUSER" data-type='string' title="singleselectuser" data-field="SINGLESELECTUSER"   Variable="" CssClass="form-control " ControlValue="" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text" onclick="selectUser(1,'fld_SINGLESELECTUSER','','fld_SINGLESELECTUSER_VALUE');"><i class="fa fa-user"></i></span>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-8 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_CHECKBOXLIST">
                                                        <label for="fld_CHECKBOXLIST"><%=Lang.Get("UWF.Process.DemoProcess.checkboxList") %></label>
                                                            <ult:CheckBoxList ID="fld_CHECKBOXLIST" title="checkboxList" data-field="CHECKBOXLIST"  Variable="" Source="DataSource.Resource" Filter="TYPE='Type_Of_Account'ORDER BY OrderNo" ControlValue="" CssClass="form-control " RepeatDirection="Horizontal" runat="server">
                                                    </ult:checkboxlist>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_LINK">
                                                        <label for="fld_LINK"><%=Lang.Get("UWF.Process.DemoProcess.link") %></label>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_ATTACHMENT">
                                                        <label for="fld_ATTACHMENT"><%=Lang.Get("UWF.Process.DemoProcess.attachment") %></label>
                                                            <div class="input-prepend input-group">
                                                                <div class="input-group-prepend">
                                                                    <div id='att_ATTACHMENT' runat="server" class="attachment" style="display:inline-block !important;"></div>
                                                                </div>
                                                                <div class="input-group-prepend attachment_show">
                                                                    <div class="btn-icon btn-icon-only btn btn-shadow btn-outline-light" title="attachment"
                                                                onclick="showForm({title:'',url:'<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/AttachmentShow.aspx?processname=<%=Server.UrlEncode(Request.QueryString["processname"])%>&incident=<%=Request.QueryString["incident"]%>&formid=<%=Request.QueryString["formid"]%>&type=att_ATTACHMENT&readonly=0'});" >
                                                                        <i class="fa fa-fw btn-icon-wrapper"></i>
                                                                    </div>
                                                                </div>
                                                                <div class="input-group-append ml-2" style="padding-top: .3rem;">
                                                                    <%if (Convert.ToInt32(Request["Incident"]) > 0){
                                                                    Response.Write(Ultimus.UWF.Common.Logic.AttachmentLogic.GetSingleUrlByType(Request.QueryString["ProcessName"] ,MyLib.ConvertUtil.ToInt32(Request.QueryString["Incident"]),"att_ATTACHMENT"));} %>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_MULTISELECTWINDOW">
                                                        <label for="fld_MULTISELECTWINDOW"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectWindow") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_MULTISELECTWINDOW" title="MultiSelectWindow" data-field="MULTISELECTWINDOW"  Variable="" CssClass="form-control " ControlValue="" 
                                                             onclick="selectDataSource({element:this,title:'',fields:'',dataSource:'费用分摊成本中心',filter:'',single:false,IsMethod:true});" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text" style="cursor:pointer" onclick="$('#fld_MULTISELECTWINDOW').click()"><i class="fa fa-search"></i></span>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-12 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_MULTITEXTBOX">
                                                        <label for="fld_MULTITEXTBOX"><%=Lang.Get("UWF.Process.DemoProcess.MultiTextBox") %></label>
                                                            <ult:TextBox ID="fld_MULTITEXTBOX" data-type='string' title="MultiTextBox" input-type="textarea" Rows="3" data-field="MULTITEXTBOX"   Variable="" ControlValue="" TextMode="Multiline" CssClass="form-control " runat="server" >
                                                    </ult:textbox>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_DATE">
                                                        <label for="fld_DATE"><%=Lang.Get("UWF.Process.DemoProcess.date") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_DATE" title="date" data-field="DATE"  data-type="date" Format="" Variable="" CssClass="form-control validate[custom[date]]" ControlValue="" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-prepend datepicker-trigger">
                                                                    <div class="input-group-text" onclick="$('#fld_DATE').click()">
                                                                        <i class="fa fa-calendar-alt"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_LABEL">
                                                        <label for="fld_LABEL"><%=Lang.Get("UWF.Process.DemoProcess.label") %></label>
                                                            <asp:Label ID="txt_LABEL" title="label" runat="server">
                                                    </asp:label>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_DROPDOWNLIST">
                                                        <label for="fld_DROPDOWNLIST"><%=Lang.Get("UWF.Process.DemoProcess.dropdownList") %></label>
                                                            <ult:DropdownList ID="fld_DROPDOWNLIST" title="dropdownList" onchange="setddlName(this)" data-field="DROPDOWNLIST" Variable=""  CssClass="form-control  selector " Source="DataSource.Resource" Filter="TYPE='TYPE-SUPPLIER-PaymentTerm' and ISACTIVE=1 ORDER BY ORDERNO" ControlValue="" runat="server" >
                                                    </ult:dropdownlist>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_DATETIMEDATE">
                                                        <label for="fld_DATETIMEDATE"><%=Lang.Get("UWF.Process.DemoProcess.datetimedate") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_DATETIMEDATE" title="datetimedate" data-field="DATETIMEDATE"  data-type="datetime" Format="" Variable="" CssClass="form-control validate[custom[dateTimeFormat]]" ControlValue="" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-prepend datepicker-trigger">
                                                                    <div class="input-group-text" onclick="$('#fld_DATETIMEDATE').click()">
                                                                        <i class="fa fa-calendar-alt"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_MULTISELECTUSER">
                                                        <label for="fld_MULTISELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectUser") %></label>
                                                            <div class="input-prepend input-group">
                                                                <ult:TextBox ID="fld_MULTISELECTUSER" data-type='string' title="MultiSelectUser" data-field="MULTISELECTUSER"   Variable="" CssClass="form-control " ControlValue="" runat="server" >
                                                        </ult:textbox>
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text" onclick="selectUser(2,'fld_MULTISELECTUSER','','fld_MULTISELECTUSER_VALUE');"><i class="fa fa-user"></i></span>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_BUTTONLIST">
                                                        <label for="fld_BUTTONLIST"><%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %></label>
                                                            <div class="position-relative form-group" id="div_field_BUTTONLIST">
                                                                <div title="buttonlist" id="Button_BUTTONLIST"
                                                                     class="mt-1 btn-icon btn btn-light hidden-print btnJson" data-prompt-position="bottomLeft">
                                                                    <%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %>
                                                                </div>
                                                            </div>
                                                    </div>
                                            </div>
                                            <div class="col-lg-4 col-sm-6 col-xs-12 ">

                                                    <div class="position-relative form-group" id="div_field_CHECKBOX">
                                                        <label for="fld_CHECKBOX"><%=Lang.Get("UWF.Process.DemoProcess.checkbox") %></label>
                                                            <ult:CheckBox ID="fld_CHECKBOX" title="checkbox" data-field="CHECKBOX"  Variable="" CssClass="form-control " runat="server">
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
                                                        <td style="width: 120px" class="batchRe">
                                                            <asp:CheckBox ID="selectall_tb_DEMOPROCESS_DT" runat="server" onclick="formBatchSelDe('tb_DEMOPROCESS_DT');" />
                                                        </td>
                                                        <td nowrap="nowrap" class="hidden">
                                                            <input id="tb_DEMOPROCESS_DT_rowCount" type="text" runat="server" />
                                                        </td>
                                                        <td nowrap="nowrap" class="th_no" style="width: 50px">
                                                            <%=Lang.Get("No") %>
                                                        </td>
                                                                <td nowrap="nowrap" style=""  class=" td_APPLICATIONTYPE"><%=Lang.Get("UWF.Process.DemoProcess.ApplicationType") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_APPOINTEDVENDOR"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor") %></td>
                                                                <td nowrap="nowrap" style=""  class="hidden td_APPOINTEDVENDORHIDE"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendorhide") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_TIME"><%=Lang.Get("UWF.Process.DemoProcess.time") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_SINGLESELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.singleselectuser") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_CHECKBOXLIST"><%=Lang.Get("UWF.Process.DemoProcess.checkboxList") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_LINK"><%=Lang.Get("UWF.Process.DemoProcess.link") %></td>
                                                                <td nowrap="nowrap" style="width:150px;"  class="hidden td_ATTACHMENT"><%=Lang.Get("UWF.Process.DemoProcess.attachment") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_MULTISELECTWINDOW"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectWindow") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_MULTITEXTBOX"><%=Lang.Get("UWF.Process.DemoProcess.MultiTextBox") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_DATE"><%=Lang.Get("UWF.Process.DemoProcess.date") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_LABEL"><%=Lang.Get("UWF.Process.DemoProcess.label") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_DROPDOWNLIST"><%=Lang.Get("UWF.Process.DemoProcess.dropdownList") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_DATETIMEDATE"><%=Lang.Get("UWF.Process.DemoProcess.datetimedate") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_MULTISELECTUSER"><%=Lang.Get("UWF.Process.DemoProcess.MultiSelectUser") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_BUTTONLIST"><%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_CHECKBOX"><%=Lang.Get("UWF.Process.DemoProcess.checkbox") %></td>
                                                        <td nowrap="nowrap" class="th_Action hidden" style="width: 60px"><%=Lang.Get("Action") %></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <ult:Repeater ID="fld_detail_PROC_DEMOPROCESS_DT" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td style="text-align:center" class="batchRe">
                                                                    <asp:CheckBox ID="sel" runat="server" GroupName="sel" onclick="formBatchOneSelDe(this)" />
                                                                </td>
                                                                <td class="hidden">
                                                                    <ult:TextBox ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                                </td>
                                                                <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                                    <div class="index"><%#Eval("ROWNO")%> </div>
                                                                    <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                                    </ult:TextBox>
                                                                </td>
                                                                <td class=" td_APPLICATIONTYPE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.ApplicationType").Split('<')[0] %>'>
                                                                        <ult:RadioButtonList ID="fld_APPLICATIONTYPE" title="radionButtonList" DefaultValue="Capex"  data-field="APPLICATIONTYPE" CssClass="validate[required]" Source="DataSource.Resource" Filter="TYPE='PRApplicationType' and ISACTIVE=1" RepeatDirection="Horizontal" runat="server" ControlValue='<%#Eval("APPLICATIONTYPE")%>'>
                                                                        </ult:RadioButtonList>
                                                                </td>
                                                                <td class=" td_APPOINTEDVENDOR" data-label='<%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_APPOINTEDVENDOR" title="" data-field="APPOINTEDVENDOR"  Variable=""
                                                                                         CssClass="form-control validate[required]  border-left-color" ControlValue=""
                                                                                         onclick="selectDataSource({element:this,title:'',fields:'',dataSource:'Swatch - InvoiceMatchList 供应商查询',filter:'',single:true});" runat="server" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-append" style="cursor:pointer" onclick="selectDataSource({element:this.previousElementSibling,title:'',fields:'',dataSource:'Swatch - InvoiceMatchList 供应商查询',filter:'',single:true});">
                                                                                <span class="input-group-text"><i class="fa fa-search"></i></span>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class="hidden td_APPOINTEDVENDORHIDE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.AppointedVendorhide").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_APPOINTEDVENDORHIDE" title="popupWindow" data-field="APPOINTEDVENDORHIDE"  Variable=""
                                                                                         CssClass="form-control validate[required]  border-left-color" ControlValue=""
                                                                                         onclick="selectDataSource({element:this,title:'',fields:'',dataSource:'Swatch - InvoiceMatchList 供应商查询',filter:'',single:true});" runat="server" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-append" style="cursor:pointer" onclick="selectDataSource({element:this.previousElementSibling,title:'',fields:'',dataSource:'Swatch - InvoiceMatchList 供应商查询',filter:'',single:true});">
                                                                                <span class="input-group-text"><i class="fa fa-search"></i></span>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_TIME" data-label='<%=Lang.Get("UWF.Process.DemoProcess.time").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_TIME" title="time" data-type="time" Format=""  data-field="TIME"
                                                                                         CssClass="form-control  " ControlValue='<%#Eval("TIME")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-prepend datepicker-trigger" onclick="$(this.previousElementSibling).click()">
                                                                                <div class="input-group-text">
                                                                                    <i class="fa fa-calendar-alt"></i>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_SINGLESELECTUSER" data-label='<%=Lang.Get("UWF.Process.DemoProcess.singleselectuser").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:textbox id="fld_SINGLESELECTUSER" title="singleselectuser" data-type='string'  data-field="SINGLESELECTUSER" Variable=""
                                                                                         CssClass="form-control  " controlvalue='<%#Eval("SINGLESELECTUSER")%>' runat="server" >
                                                                            </ult:textbox>
                                                                            <div class="input-group-append" style="cursor:pointer" onclick="selectUser(1, $(this).prev().attr('id'), '', $(this).prev().attr('id')+'_VALUE');">
                                                                                <span class="input-group-text"><i class="fa fa-user"></i></span>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_CHECKBOXLIST" data-label='<%=Lang.Get("UWF.Process.DemoProcess.checkboxList").Split('<')[0] %>'>
                                                                        <ult:CheckBoxList ID="fld_CHECKBOXLIST" title="checkboxList"  data-field="CHECKBOXLIST" CssClass="" Source="DataSource.Resource" Filter="TYPE='Type_Of_Account'ORDER BY OrderNo" RepeatDirection="Horizontal" runat="server" ControlValue='<%#Eval("CHECKBOXLIST")%>'>
                                                                        </ult:CheckBoxList>
                                                                </td>
                                                                <td class=" td_LINK" data-label='<%=Lang.Get("UWF.Process.DemoProcess.link").Split('<')[0] %>'>
                                                                </td>
                                                                <td class="hidden td_ATTACHMENT" data-label='<%=Lang.Get("UWF.Process.DemoProcess.attachment").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <div class="input-group-prepend">
                                                                                <div id='att_ATTACHMENT' runat="server" class="attachment" style="display:inline-block !important;"></div>
                                                                            </div>
                                                                            <div class="input-group-prepend attachment_show">
                                                                            </div>
                                                                            <div class="input-group-append">
                                                                                <%#Ultimus.UWF.Common.Logic.AttachmentLogic.GetSingleUrl(MyLib.ConvertUtil.ToString(Eval("FORMID")),Request.QueryString["ProcessName"],"fld_detail_PROC_DemoProcess_DT",MyLib.ConvertUtil.ToString(Eval("ROWNO"))) %>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_MULTISELECTWINDOW" data-label='<%=Lang.Get("UWF.Process.DemoProcess.MultiSelectWindow").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_MULTISELECTWINDOW" title="MultiSelectWindow"  data-field="MULTISELECTWINDOW" CssClass="form-control  " runat="server" ControlValue='<%#Eval("MULTISELECTWINDOW")%>' onclick="selectDataSource({element:this,title:'',fields:'',dataSource:'费用分摊成本中心',filter:'',single:false});" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-append" style="cursor:pointer" onclick="selectDataSource({element:this.previousElementSibling,title:'',fields:'',dataSource:'费用分摊成本中心',filter:'',single:true});">
                                                                                <span class="input-group-text"><i class="fa fa-search"></i></span>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_MULTITEXTBOX" data-label='<%=Lang.Get("UWF.Process.DemoProcess.MultiTextBox").Split('<')[0] %>'>
                                                                        <ult:TextBox ID="fld_MULTITEXTBOX" data-type='string' title="MultiTextBox" input-type="textarea" Rows="3" data-field="MULTITEXTBOX"   Variable="" 
                                                                                     ControlValue='<%#Eval("MULTITEXTBOX")%>' TextMode="Multiline" CssClass="form-control  " runat="server" >
                                                                        </ult:TextBox>
                                                                </td>
                                                                <td class=" td_DATE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.date").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_DATE" title="date" data-type="date" Format=""  data-field="DATE"
                                                                                         CssClass="form-control validate[custom[date]] " ControlValue='<%#Eval("DATE")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-prepend datepicker-trigger" onclick="$(this.previousElementSibling).click()">
                                                                                <div class="input-group-text">
                                                                                    <i class="fa fa-calendar-alt"></i>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_LABEL" data-label='<%=Lang.Get("UWF.Process.DemoProcess.label").Split('<')[0] %>'>
                                                                </td>
                                                                <td class=" td_DROPDOWNLIST" data-label='<%=Lang.Get("UWF.Process.DemoProcess.dropdownList").Split('<')[0] %>'>
                                                                        <ult:DropdownList ID="fld_DROPDOWNLIST" title="dropdownList" DefaultValue="" onblur="setddlName(this)"  data-field="DROPDOWNLIST" CssClass="form-control  selector
                                                                                    }" Source="DataSource.Resource" Filter="TYPE='TYPE-SUPPLIER-PaymentTerm' and ISACTIVE=1 ORDER BY ORDERNO" runat="server" ControlValue='<%#Eval("DROPDOWNLIST")%>' >
                                                                        </ult:DropdownList>
                                                                </td>
                                                                <td class=" td_DATETIMEDATE" data-label='<%=Lang.Get("UWF.Process.DemoProcess.datetimedate").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_DATETIMEDATE" title="datetimedate" data-type="datetime" Format=""  data-field="DATETIMEDATE"
                                                                                         CssClass="form-control validate[custom[dateTimeFormat]] " ControlValue='<%#Eval("DATETIMEDATE")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-prepend datepicker-trigger" onclick="$(this.previousElementSibling).click()">
                                                                                <div class="input-group-text">
                                                                                    <i class="fa fa-calendar-alt"></i>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_MULTISELECTUSER" data-label='<%=Lang.Get("UWF.Process.DemoProcess.MultiSelectUser").Split('<')[0] %>'>
                                                                        <div class="input-prepend input-group">
                                                                            <ult:TextBox ID="fld_MULTISELECTUSER" title="MultiSelectUser" data-type='string'  data-field="MULTISELECTUSER" Variable=""
                                                                                         CssClass="form-control  " ControlValue='<%#Eval("MULTISELECTUSER")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                            <div class="input-group-append" style="cursor:pointer" onclick="selectUser(2, $(this).prev().attr('id'), '', $(this).prev().attr('id')+'_VALUE');">
                                                                                <span class="input-group-text"><i class="fa fa-user"></i></span>
                                                                            </div>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_BUTTONLIST" data-label='<%=Lang.Get("UWF.Process.DemoProcess.buttonlist").Split('<')[0] %>'>
                                                                        <ult:TextBox ID="fld_BUTTONLIST" title="buttonlist" data-type='string' onblur="checkExpression(this)"  data-field="BUTTONLIST" CssClass="hidden " ControlValue='<%#Eval("BUTTONLIST")%>' runat="server" >
                                                                        </ult:TextBox>
                                                                        <div title="buttonlist" id="Button_BUTTONLIST" class="btn-icon btn btn-light hidden-print btnJson" data-prompt-position="bottomLeft">
                                                                            <%=Lang.Get("UWF.Process.DemoProcess.buttonlist") %>
                                                                        </div>
                                                                </td>
                                                                <td class=" td_CHECKBOX" data-label='<%=Lang.Get("UWF.Process.DemoProcess.checkbox").Split('<')[0] %>'>
                                                                        <ult:CheckBox ID="fld_CHECKBOX" title="checkbox"  data-field="CHECKBOX" CssClass="" runat="server" ControlValue='<%#Eval("CHECKBOX")%>'>
                                                                        </ult:CheckBox>
                                                                </td>
                                                                <td class="th_Action hidden">
                                                                    <a onclick="if(confirm(' <%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_DEMOPROCESS_DT',this);}return false;"
                                                                       href="javascript:void(0);" class="btn-icon btn-icon-only btn btn-light btn-sm">
                                                                        
                                                                        <i class="fa fa-trash opacity-8 fa-angle"></i>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </ult:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="padding-t-5"></div>

                                        <a id="btn_DEMOPROCESS_DT" class="mt-2 mb-2 mr-2 btn-icon btn btn-light" onclick="addRow('tb_DEMOPROCESS_DT');iFrameHeight();return false;" href="javascript:void(0);">
                                            <i class="mr-1 fa fa-plus hidden-print"></i><%=Lang.Get("Form_AddRow") %>
                                        </a>
                                        <a class="mt-2 mb-2 mr-2 btn-icon btn btn-light" onclick="formBatchDelete('tb_DEMOPROCESS_DT');" id="btnRemove_tb_DEMOPROCESS_DT" href="javascript:void(0);" style="display: none;">
                                            <i class="fa fa-trash opacity-8 fa-angle"></i> <%=Lang.Get("Form_BatchDelete") %>
                                        </a>
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
                                                        <td style="width: 120px" class="batchRe">
                                                            <asp:CheckBox ID="selectall_tb_DEMOPROCESS002_DT" runat="server" onclick="formBatchSelDe('tb_DEMOPROCESS002_DT');" />
                                                        </td>
                                                        <td nowrap="nowrap" class="hidden">
                                                            <input id="tb_DEMOPROCESS002_DT_rowCount" type="text" runat="server" />
                                                        </td>
                                                        <td nowrap="nowrap" class="th_no" style="width: 50px">
                                                            <%=Lang.Get("No") %>
                                                        </td>
                                                                <td nowrap="nowrap" style=""  class=" td_MONEY001"><%=Lang.Get("UWF.Process.DemoProcess.money001") %></td>
                                                                <td nowrap="nowrap" style=""  class=" td_MONEY002"><%=Lang.Get("UWF.Process.DemoProcess.money002") %></td>
                                                                <td nowrap="nowrap" style="" data-expression="{MONEY001}*{MONEY002}" class=" td_MONEY003"><%=Lang.Get("UWF.Process.DemoProcess.money003") %></td>
                                                        <td nowrap="nowrap" class="th_Action hidden" style="width: 60px"><%=Lang.Get("Action") %></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <ult:Repeater ID="fld_detail_PROC_DEMOPROCESS002_DT" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td style="text-align:center" class="batchRe">
                                                                    <asp:CheckBox ID="sel" runat="server" GroupName="sel" onclick="formBatchOneSelDe(this)" />
                                                                </td>
                                                                <td class="hidden">
                                                                    <ult:TextBox ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                                </td>
                                                                <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                                    <div class="index"><%#Eval("ROWNO")%> </div>
                                                                    <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                                    </ult:TextBox>
                                                                </td>
                                                                <td class=" td_MONEY001" data-label='<%=Lang.Get("UWF.Process.DemoProcess.money001").Split('<')[0] %>'>
                                                                            <ult:TextBox ID="fld_MONEY001" title="money001" data-type='number'  data-field="MONEY001"
                                                                                         CssClass="form-control text-right validate[custom[number]] "
                                                                                         ControlValue='<%#Eval("MONEY001")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                </td>
                                                                <td class=" td_MONEY002" data-label='<%=Lang.Get("UWF.Process.DemoProcess.money002").Split('<')[0] %>'>
                                                                            <ult:TextBox ID="fld_MONEY002" title="money002" data-type='number'  data-field="MONEY002"
                                                                                         CssClass="form-control text-right validate[custom[number]] "
                                                                                         ControlValue='<%#Eval("MONEY002")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                </td>
                                                                <td class=" td_MONEY003" data-label='<%=Lang.Get("UWF.Process.DemoProcess.money003").Split('<')[0] %>'>
                                                                            <ult:TextBox ID="fld_MONEY003" title="money003" data-type='number'  data-field="MONEY003"
                                                                                         CssClass="form-control text-right validate[custom[number]] "
                                                                                         ControlValue='<%#Eval("MONEY003")%>' runat="server" >
                                                                            </ult:TextBox>
                                                                </td>
                                                                <td class="th_Action hidden">
                                                                    <a onclick="if(confirm(' <%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_DEMOPROCESS002_DT',this);}return false;"
                                                                       href="javascript:void(0);" class="btn-icon btn-icon-only btn btn-light btn-sm">
                                                                        
                                                                        <i class="fa fa-trash opacity-8 fa-angle"></i>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </ult:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="padding-t-5"></div>

                                        <a id="btn_DEMOPROCESS002_DT" class="mt-2 mb-2 mr-2 btn-icon btn btn-light" onclick="addRow('tb_DEMOPROCESS002_DT');iFrameHeight();return false;" href="javascript:void(0);">
                                            <i class="mr-1 fa fa-plus hidden-print"></i><%=Lang.Get("Form_AddRow") %>
                                        </a>
                                        <a class="mt-2 mb-2 mr-2 btn-icon btn btn-light" onclick="formBatchDelete('tb_DEMOPROCESS002_DT');" id="btnRemove_tb_DEMOPROCESS002_DT" href="javascript:void(0);" style="display: none;">
                                            <i class="fa fa-trash opacity-8 fa-angle"></i> <%=Lang.Get("Form_BatchDelete") %>
                                        </a>
                                    </div>
                                    <!--End detail table-->
                                </div>
                            </div>
                            <!--End Item table-->
                    </div>
                </div>

                <attach:attachments id="Attachments1" runat="server"></attach:attachments>
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

            <div class="hidden">
                <asp:textbox id="txt_Judge1" runat="server"></asp:textbox>
                <asp:textbox id="txt_Judge2" runat="server"></asp:textbox>
                <asp:textbox id="txt_Judge3" runat="server"></asp:textbox>
            </div>
        </form>
    </div>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.3.7.js?t=0c5f14f2-33dd-4de8-bd8d-2d37f045329f'></script>
    <script type='text/javascript' src='UPMNewRequest.js?t=32202771-94f0-44a5-9c1a-eb7070a6e7e0'></script>
</body>

</html>
