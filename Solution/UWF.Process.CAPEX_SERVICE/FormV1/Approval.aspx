<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.CAPEX_SERVICE.Approval" %>

<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachmentsOC.ascx" TagName="AttachmentAdd" TagPrefix="ath" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>CAPEX_SERVICE</title>
    <style>
        .disabled-checkbox {
            pointer-events: none; /* 阻止鼠标点击/悬停 */
            opacity: 0.6;
            cursor: not-allowed;
        }
        /* 自定义bootstrap-select宽度 */
        .bootstrap-select:not([class*="col-"]):not([class*="form-control"]):not(.input-group-btn) {
            width: 80px !important; /* 强制设置宽度为120px */
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="CAPEX_SERVICE" processpefix="CPRS" tablename="PROC_CAPEX_SERVICE"
            tablenamedetail="PROC_CAPEX_SERVICE_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_CAPEX_SERVICE">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CAPEX_SERVICE") %>
                        </div>

                        <ul class="panel-tools">
                            <li>
                                <a class="icon minimise-tool">
                                    <i class="fa fa-minus"></i>
                                </a>
                            </li>
                            <li>
                                <a class="icon expand-tool">
                                    <i class="fa fa-expand"></i>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">

                        <!-- SITECODE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITECODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SITECODE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- SITENAME -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SITENAME" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- AMOUNT -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.AMOUNT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_AMOUNT" data-type='number' title="" onblur="checkExpression(this)" data-field="AMOUNT" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- SUPPLIERCODE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERCODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- SUPPLIERNAME -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERNAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- CAPEXNUMBER -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CAPEXNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CAPEXNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_CAPEXNUMBER" data-type='string' title="" onblur="checkExpression(this)" data-field="CAPEXNUMBER" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- CONTRACTDATE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CONTRACTDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CONTRACTDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                  <%--  <ult:TextBox ID="fld_CONTRACTDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="CONTRACTDATE" Variable="" ControlValue="" CssClass="form-control" runat="server">
                                    </ult:TextBox>--%>
                                       <ult:TextBox ID="fld_CONTRACTDATE" title="" data-field="CONTRACTDATE" data-type="text" Format="" Variable="CONTRACTDATE" CssClass="form-control validate[required]" runat="server" onClick="WdatePicker({readOnly:false,startDate:'%y-%M-%d 06:30:00',dateFmt:'yyyy-MM-dd HH:mm:00',alwaysUseStartDate:false})">
                                        </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- DEPRECIATIONDATE 
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DEPRECIATIONDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.DEPRECIATIONDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                  <%--  <ult:TextBox ID="fld_DEPRECIATIONDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="DEPRECIATIONDATE" Variable="" ControlValue="" CssClass="form-control" runat="server">
                                    </ult:TextBox>--%>
                                     <ult:TextBox ID="fld_DEPRECIATIONDATE" title="" data-field="DEPRECIATIONDATE" data-type="text" Format="" Variable="DEPRECIATIONDATE" CssClass="form-control" runat="server" onClick="WdatePicker({readOnly:false,startDate:'%y-%M-%d 06:30:00',dateFmt:'yyyy-MM-dd HH:mm:00',alwaysUseStartDate:false})">
                                        </ult:TextBox>
                                </div>
                            </div>
                        </div>-->

                       <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" id="div_field_APPREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.APPREMARK") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPREMARK" data-type='string' title="" onblur="checkExpression(this)" data-field="APPREMARK" Variable="APPREMARK" ControlValue="" CssClass="form-control  ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-sm-6 col-xs-12 form-cell" id="div_uploads_show" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.UPLOADS") %>:
                            </div>
                            <div class="form-field">
                                <div id="div_uploads">
                                </div>
                            </div>
                        </div>

                        <!-- UPLOADS -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_UPLOADS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.UPLOADS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_UPLOADS" data-type='string' title="" onblur="checkExpression(this)" data-field="UPLOADS" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        

                        <!-- ISCOR -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISCOR" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ISCOR") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISCOR" data-type='string' title="" onblur="checkExpression(this)" data-field="ISCOR" Variable="ISCOR" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <!-- ISCORName -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISCORName" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ISCORName") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISCORName" data-type='string' title="" onblur="checkExpression(this)" data-field="ISCORName" Variable="ISCORName" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--1.2多行-->
        <!--Start Item table-->
        <div class="row" id="div_panel_CAPEX_SERVICE_Items">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-bars"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CAPEX_SERVICE_Items") %>
                        </div>

                        <ul class="panel-tools">
                            <li>
                                <a class="icon minimise-tool">
                                    <i class="fa fa-minus"></i>
                                </a>
                            </li>
                            <li>
                                <a class="icon expand-tool">
                                    <i class="fa fa-expand"></i>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <table id="tb_CAPEX_SERVICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_CAPEX_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width: 50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLECODE") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLENAME") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.FAMILYNAME") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.PCPRICE") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERQTY") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERUNIT") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.AMOUNT") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.DELIVERYDATE") %>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle;">
                                        <input style="cursor: pointer; margin-right: 0px; vertical-align: middle;" type="checkbox" id="ch_needaccept" onclick="ckneedaccept_click()" name="checkBox" /><span style="vertical-align: middle;"><%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.NEEDACCEPT") %></span>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ASSETCLASS") %>
                                         <span style='color: red'>*</span>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ACCEPTMARK") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.USEFULLIFE") %>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle;">
                                        <input style="cursor: pointer; margin-right: 0px; vertical-align: middle;" type="checkbox" id="ch_buybackterm" onclick="ckbuybackterm_click()" name="checkBox" /><span style="vertical-align: middle;"><%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.BUYBACKTERM") %></span>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle;">
                                        <input style="cursor: pointer; margin-right: 0px; vertical-align: middle;" type="checkbox" id="ch_removable" onclick="ckremovable_click()" name="checkBox" /><span style="vertical-align: middle;"><%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.REMOVABLE") %></span>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_CAPEX_SERVICE_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="hidden">
                                                <ult:TextBox ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                </ult:TextBox>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLECODE") %>'>
                                                <ult:Label ID="fld_ARTICLECODE" data-field="ARTICLECODE" runat="server" ControlValue='<%#Eval("ARTICLECODE")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLENAME") %>'>
                                                <ult:Label ID="fld_ARTICLENAME" data-field="ARTICLENAME" runat="server" ControlValue='<%#Eval("ARTICLENAME")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.FAMILYNAME") %>'>
                                                <ult:Label ID="fld_FAMILYNAME" data-field="FAMILYNAME" runat="server" ControlValue='<%#Eval("FAMILYNAME")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.PCPRICE") %>'>
                                                <ult:Label ID="fld_PCPRICE" data-field="PCPRICE" runat="server" ControlValue='<%#Eval("PCPRICE")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERQTY") %>'>
                                                <ult:Label ID="fld_ORDERQTY" data-field="ORDERQTY" runat="server" ControlValue='<%#Eval("ORDERQTY")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERUNIT") %>'>
                                                <ult:Label ID="fld_ORDERUNIT" data-field="ORDERUNIT" runat="server" ControlValue='<%#Eval("ORDERUNIT")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.AMOUNT") %>'>
                                                <ult:Label ID="fld_AMOUNT" data-field="AMOUNT" runat="server" ControlValue='<%#Eval("AMOUNT")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.DELIVERYDATE") %>'>
                                                <ult:Label ID="fld_DELIVERYDATE" data-field="DELIVERYDATE" runat="server" ControlValue='<%#Eval("DELIVERYDATE")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.NEEDACCEPT") %>'>
                                                <ult:CheckBox ID="fld_NEEDACCEPT" data-field="NEEDACCEPT" CssClass="ckneedacceptItem" runat="server" ControlValue='<%#Eval("NEEDACCEPT")%>'></ult:CheckBox>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ASSETCLASS") %>'>
                                                <ult:DropDownList ID="fld_ASSETCLASS" title="" onblur="checkExpression(this)" data-field="ASSETCLASS" Variable="" CssClass="selector validate[required]" Source="DataSource.SODEXO_资产类别" Filter="" ControlValue='<%#Eval("ASSETCLASS")%>' runat="server">
                                                </ult:DropDownList>

                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ACCEPTMARK") %>'>
                                                <ult:DropDownList ID="fld_ACCEPTMARK" title="" onblur="checkExpression(this)" data-field="ACCEPTMARK" Variable="" CssClass="stassetclass" Source="DataSource." Filter="" ControlValue='<%#Eval("ACCEPTMARK")%>' runat="server">
                                                    <asp:ListItem Text="" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="验收点" Value="AcceptancePoint"></asp:ListItem>
                                                    <asp:ListItem Text="质保点" Value="AssurancePoint"></asp:ListItem>
                                                </ult:DropDownList>
                                            </td>
                                            <%-- <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.USEFULLIFE") %>'>
                                                <ult:TextBox ID="fld_USEFULLIFE" CssClass="tbusefullife" data-field="USEFULLIFE" runat="server" Style="width: 100px" ControlValue='<%#Eval("USEFULLIFE")%>' />
                                            </td>--%>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.USEFULLIFE") %>'>
                                                <ult:DropDownList ID="fld_USEFULLIFE" title="" onblur="checkExpression(this)" data-field="USEFULLIFE" Variable="" CssClass="selector validate[required]" Filter="" ControlValue='<%#Eval("USEFULLIFE")%>' runat="server">
                                                    <asp:ListItem Text="1年" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2年" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3年" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4年" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5年" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text="6年" Value="6"></asp:ListItem>
                                                    <asp:ListItem Text="7年" Value="7"></asp:ListItem>
                                                    <asp:ListItem Text="8年" Value="8"></asp:ListItem>
                                                    <asp:ListItem Text="9年" Value="9"></asp:ListItem>
                                                    <asp:ListItem Text="10年" Value="10"></asp:ListItem>
                                                </ult:DropDownList>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.BUYBACKTERM") %>'>
                                                <ult:CheckBox ID="fld_BUYBACKTERM" data-field="BUYBACKTERM" CssClass="ckbuybacktermitem" runat="server" ControlValue='<%#Eval("BUYBACKTERM")%>'></ult:CheckBox>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.REMOVABLE") %>'>
                                                <ult:CheckBox ID="fld_REMOVABLE" data-field="REMOVABLE" CssClass="ckremovableitem" runat="server" ControlValue='<%#Eval("REMOVABLE")%>'></ult:CheckBox>
                                            </td>

                                        </tr>
                                    </ItemTemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>
        <!--End Item table-->
        <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
        <ath:attachmentadd id="AttachmentsAdd" runat="server" readonly="True"></ath:attachmentadd>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
        <asp:HiddenField ID="hdDatetime" runat="server" />
        <%--<asp:HiddenField ID="hdDate" runat="server" />--%>
        <asp:HiddenField ID="hdLanguage" runat="server" />
        <asp:HiddenField ID="approvalType" Value="0" runat="server" />
        <asp:HiddenField ID="isGL" Value="0" runat="server" />
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=9119cb80-5cf5-45f6-9d3c-20f1ed3e3163'></script>
    <script type='text/javascript' src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>
