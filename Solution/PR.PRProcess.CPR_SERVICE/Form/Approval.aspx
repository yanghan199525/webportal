<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="PR.PRProcess.CPR_SERVICE.Approval" %>

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
    <title>CPR_SERVICE</title>
      <style>
        .item-control-invoice-path {
            display: block;
            width: 0;
            height: 0;
            opacity: 0;
        }

        .invoice-path-link {
            display: none;
            margin-left: 8px;
            color: #409EFF;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="CPR_SERVICE" processpefix="CPRS" tablename="PROC_CPR_SERVICE"
            tablenamedetail="PROC_CPR_SERVICE_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_CPR_SERVICE">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.CPR_SERVICE.CPR_SERVICE") %>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPLYPURPOSE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_APPLYPURPOSETXT" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERTYPE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERTYPETXT" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SITECODE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SITENAME" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.DELIVERYDATE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group" id="edit_DELIVERYDATE">
                                        <%--<ult:TextBox ID="fld_DELIVERYDATESHOW" title="" data-field="DELIVERYDATESHOW" data-type="date" Format="" Variable="DELIVERYDATESHOW" CssClass="form-control validate[required,custom[dateFormat],futureDateTime[#hdDate]]" runat="server"  data-errormessage-type-mismatch="要求送货日期必须为明天下午6点以后，默认时间为早上6点<br/>Required delivery date must be after 6pm tomorrow, default time is 6am">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_DELIVERYDATE" title="" data-field="DELIVERYDATE" data-type="datetime" Format="" Variable="DELIVERYDATE" CssClass="form-control hidden validate[required,custom[dateTimeFormat]]" runat="server">
                                        </ult:TextBox>--%>
                                        <ult:TextBox ID="fld_DELIVERYDATE" data-type='text' title="" onblur="checkExpression(this)" data-field="DELIVERYDATE" Variable="" ControlValue="" CssClass="form-control Wdate validate[required,funcCall[futureDateTime]]" runat="server" data-errormessage-type-mismatch="要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am" onClick="WdatePicker({readOnly:false,startDate:'%y-%M-%d 06:30:00',dateFmt:'yyyy-MM-dd HH:mm:00',alwaysUseStartDate:false})">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon hidden-xs"><i class="fa fa-calendar"></i></span>
                                    </div>
                                    <ult:Label ID="read_DELIVERYDATE" title="" Format="" runat="server">
                                    </ult:Label>
                                    <%--<ult:Label ID="read_DELIVERYDATESHOW" class="hidden" title="" Format="" runat="server">
                                    </ult:Label>--%>
                                </div>
                            </div>
                        </div>
                        <%--<div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.DELIVERYDATE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group" id="edit_DELIVERYDATE">
                                        <ult:TextBox ID="fld_DELIVERYDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="DELIVERYDATE" Variable="" ControlValue="" CssClass="form-control validate[required,custom[dateTimeFormat],futureDateTime[#hdDatetime]]" runat="server" data-errormessage-type-mismatch="要求送货日期必须为明天下午6点以后">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon hidden-xs"><i class="fa fa-calendar"></i></span>
                                    </div>
                                    <ult:Label ID="read_DELIVERYDATE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>--%>
                        <!--补充空单元格-->
                        <%--<div class="col-lg-4 col-sm-6 col-xs-12 form-cell" style="border-left: 0px; height: ">
                            <div class="form-label" style="background-color: transparent;">
                            </div>
                            <div class="form-field">
                            </div>
                        </div>--%>
                        <div class="hidden col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_FIXEDASSETS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.FIXEDASSETS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_FIXEDASSETS" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <%--<div class="col-lg-4 col-sm-6 col-xs-12 form-cell" style="height: ">
                            <div class="form-label">
                            </div>
                            <div class="form-field">
                            </div>
                        </div>--%>
                        <%--<div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ONLINEORSUPERMARKET" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.ONLINEORSUPERMARKET") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_ONLINEORSUPERMARKET" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERCODE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERNAME" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.ASSETTYPE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_ASSETTYPE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.AMOUNT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_AMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                                    </ult:Label>
                                    <%--  <span style="color:red" id="span_read_ORIGINALAMOUNT">(SSP: <ult:Label ID="read_ORIGINALAMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                                    </ult:Label>)
                                    </span>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PURCHASINGAGENT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.PURCHASINGAGENT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_PURCHASINGAGENT" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApproverName" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApproverName") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SIGNEDAPPROVERNAME" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover2Name" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover2Name") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SIGNEDAPPROVER2NAME" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover3Name" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover3Name") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SIGNEDAPPROVER3NAME" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SignedApprover" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SIGNEDAPPROVER" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SignedApprover2" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover2") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SIGNEDAPPROVER2" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SignedApprover3" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover3") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SIGNEDAPPROVER3" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-8 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPREMARK") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_APPREMARK" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="hidden col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SHOWREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_NONFOOD.SHOWREMARK") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SHOWREMARK" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPROVEDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <%--<ult:Label ID="read_APPROVEDATE" title="" Format="" runat="server">
                                    </ult:Label>--%>
                                    <ult:TextBox ID="var_APPROVEDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="APPROVEDATE" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PCCOMPCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.PCCOMPCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_PCCOMPCODE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLYPURPOSETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPLYPURPOSETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_APPLYPURPOSE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SUPPLIERTYPETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERTYPETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERTYPE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.ASSETTYPETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_ASSETTYPETXT" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CPRFAMILYCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.CPRFAMILYCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_CPRFAMILYCODE" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ONLINEORSUPERMARKETTXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.ONLINEORSUPERMARKETTXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_ONLINEORSUPERMARKETTXT" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SIGNEDAPPROVERNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.SIGNEDAPPROVERNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SIGNEDAPPROVERNUMBER" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.DELIVERY") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="var_DELIVERY" title="" Format="" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPROVE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="var_APPROVE" title="" Format="" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SEGMENTDIRECTOR_1" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SEGMENTDIRECTOR_1") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_USER_SEGMENTDIRECTOR_1" title="" Format="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>
                        </div>
                        <!--补充空单元格-->

                    </div>
                </div>
            </div>
        </div>
        <!--1.2多行-->
        <!--Start Item table-->
        <div class="row" id="div_panel_CPR_SERVICE_Items">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CPR_SERVICE_Items") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_CPR_SERVICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_CPR_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                      <td class="th_ch" style="width: 50px">勾选
                                    </td>
                                    <td class="th_no" style="width: 50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style="" class=" td_APPLYREASON"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPLYREASON") %><span style='color: red'>*</span></td>
                                    <td style="" class=" td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYNAME") %></td>
                                    <td style="" class=" td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLENAME") %></td>
                                    <td style="" class=" td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERUNIT") %></td>
                                    <td style="" class=" td_SITEPRICE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITEPRICE") %><span style='color: red'>*</span></td>
                                    <td style="" class=" td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERQUANTITY") %> <span style='color: red'>*</span></td>
                                    <td style="" class="td_INVOICENUMBER"><%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICENUMBER") %><span style='color: red'>*</span></td>
                                    <td style="" class="td_BUYERNAME"><%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERNAME") %><span style='color: red'>*</span></td>
                                    <td style="" class="td_BUYERTAXID"><%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERTAXID") %><span style='color: red'>*</span></td>
                                    <td style="" class="td_INVOICEPATH"><%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICEPATH") %></td>

                                    <td style="" class="hidden td_FAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.FAMILYCODE") %></td>
                                    <td style="" class="hidden td_FAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.FAMILYNAME") %></td>
                                    <td style="" class="hidden td_SUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBFAMILYCODE") %></td>
                                    <td style="" class="hidden td_SUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBFAMILYNAME") %></td>
                                    <td style="" class="hidden td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYCODE") %></td>
                                    <td style="" class="hidden td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLECODE") %></td>
                                    <td style="" class="hidden td_UNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.UNIT") %></td>
                                    <td style="" class="hidden td_CONSUMPTIONUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONSUMPTIONUNIT") %></td>
                                    <td style="" class="hidden td_CONVERSION"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONVERSION") %></td>
                                    <td style="" class="hidden td_STOCK"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.STOCK") %></td>
                                    <td style="" class="hidden td_NETVOMULE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETVOMULE") %></td>
                                    <td style="" class="hidden td_GROSSWEIGHT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.GROSSWEIGHT") %></td>
                                    <td style="" class="hidden td_NETVOMULEUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETVOMULEUNIT") %></td>
                                    <td style="" class="hidden td_GROSSWEIGHTUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.GROSSWEIGHTUNIT") %></td>
                                    <td style="" class="hidden InvoiceType"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.InvoiceType") %></td>
                                    <td style="" class="hidden td_TAXCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.TAXCODE") %></td>
                                    <td style="" class="hidden td_TAXRATE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.TAXRATE") %></td>
                                    <td style="" class="hidden InitOrderLimt"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.InitOrderLimt") %></td>

                                    <td style="" class="hidden td_ORDERUNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERUNITVALUE") %></td>
                                    <td style="" class="hidden td_UNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.UNITVALUE") %></td>
                                    <td style="" class="hidden td_CONSUMPTIONUNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONSUMPTIONUNITVALUE") %></td>
                                    <td style="" class="hidden td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBTOTALAMOUNT") %></td>
                                    <td style="" class="hidden td_SUBSUBFAMILYCE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYCE") %></td>
                                    <td style="" class="hidden td_NETNETPRICE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETNETPRICE") %></td>
                                    <td style="" class="hidden td_ARTICLEID"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLEID") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_CPR_SERVICE_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="hidden">
                                                <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td class="th_ch">
                                                <ult:CheckBox ID="fld_CHECKED" data-field="CHECKED" runat="server" ControlValue='<%#Eval("CHECKED")%>'></ult:CheckBox>
                                            </td>
                                            <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:Label ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                </ult:Label>
                                            </td>
                                            <td class=" td_APPLYREASON" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPLYREASON").Split('<')[0] %>'>
                                                <ult:Label ID="fld_APPLYREASON" title="" data-type='string' onblur="checkExpression(this)" data-field="APPLYREASON" CssClass="item-control  ReadOnly" ControlValue='<%#Eval("APPLYREASON")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBSUBFAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYNAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SUBSUBFAMILYNAME")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLENAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ARTICLENAME" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLENAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ARTICLENAME")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERUNIT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ORDERUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNIT")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITEPRICE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SITEPRICE" title="" data-type='string' onblur="checkExpression(this)" data-field="SITEPRICE" CssClass="item-control validate[custom[number]] ReadOnly " ControlValue='<%#Eval("SITEPRICE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERQUANTITY").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ORDERQUANTITY" title="" data-type='number' onblur="checkExpression(this)" data-field="ORDERQUANTITY" CssClass="item-control ReadOnly validate[required,custom[number]] " ControlValue='<%#Eval("ORDERQUANTITY")%>' runat="server" onchange="SumAmount(this)" data-errormessage-type-mismatch="采购数量必须大于0<br />Purchase quantity must be greater than 0">
                                                </ult:Label>
                                            </td>
                                            <td class="td_INVOICENUMBER" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICENUMBER").Split('<')[0] %>'>
                                                <ult:Label ID="fld_INVOICENUMBER" title="" data-type='string' onblur="checkExpression(this)" data-field="INVOICENUMBER" CssClass="item-control validate[required]" ControlValue='<%#Eval("INVOICENUMBER")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="td_BUYERNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERNAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_BUYERNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="BUYERNAME" CssClass="item-control validate[required]" ControlValue='<%#Eval("BUYERNAME")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="td_BUYERTAXID" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERTAXID").Split('<')[0] %>'>
                                                <ult:Label ID="fld_BUYERTAXID" title="" data-type='string' onblur="checkExpression(this)" data-field="BUYERTAXID" CssClass="item-control validate[required]" ControlValue='<%#Eval("BUYERTAXID")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="td_INVOICEPATH" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICEPATH").Split('<')[0] %>'>
                                                <ult:Label ID="fld_INVOICEPATH" title="" data-type='string' onblur="checkExpression(this)" data-field="INVOICEPATH" CssClass="item-control-invoice-path hidden" ControlValue='<%#Eval("INVOICEPATH")%>' runat="server">
                                                     
                                                </ult:Label>
                                                <a href="" class="invoice-path-link" target="_blank" style="display: none"></a>
                                            </td>
                                            <td class="hidden td_FAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.FAMILYCODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_FAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="FAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("FAMILYCODE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_FAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.FAMILYNAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_FAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="FAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("FAMILYNAME")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_SUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBFAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBFAMILYCODE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_SUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBFAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBFAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("SUBFAMILYNAME")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBSUBFAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCODE")%>' runat="server">
                                                </ult:Label>
                                            </td>

                                            <td class="hidden td_ARTICLECODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLECODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ARTICLECODE" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLECODE" CssClass="item-control  " ControlValue='<%#Eval("ARTICLECODE")%>' runat="server">
                                                </ult:Label>
                                            </td>

                                            <td class="hidden td_UNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.UNIT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_UNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="UNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("UNIT")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONSUMPTIONUNIT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_CONSUMPTIONUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="CONSUMPTIONUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONSUMPTIONUNIT")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_CONVERSION" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONVERSION").Split('<')[0] %>'>
                                                <ult:Label ID="fld_CONVERSION" title="" data-type='string' onblur="checkExpression(this)" data-field="CONVERSION" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONVERSION")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_STOCK" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.STOCK").Split('<')[0] %>'>
                                                <ult:Label ID="fld_STOCK" title="" data-type='string' onblur="checkExpression(this)" data-field="STOCK" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("STOCK")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_NETVOMULE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETVOMULE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_NETVOMULE" title="" data-type='string' onblur="checkExpression(this)" data-field="NETVOMULE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("NETVOMULE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.GROSSWEIGHT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_GROSSWEIGHT" title="" data-type='string' onblur="checkExpression(this)" data-field="GROSSWEIGHT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GROSSWEIGHT")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_NETVOMULEUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETVOMULEUNIT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_NETVOMULEUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="NETVOMULEUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("NETVOMULEUNIT")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHTUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.GROSSWEIGHTUNIT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_GROSSWEIGHTUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="GROSSWEIGHTUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GROSSWEIGHTUNIT")%>' runat="server">
                                                </ult:Label>
                                            </td>

                                            <td class="hidden InvoiceType" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.InvoiceType").Split('<')[0] %>'>
                                                <ult:Label ID="InvoiceType" title="" data-type='text' onblur="checkExpression(this)" data-field="InvoiceType" CssClass="item-control ReadOnly " ControlValue='<%#Eval("INVOICETYPE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_TAXCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.TAXCODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_TAXCODE" title="" data-type='text' onblur="checkExpression(this)" data-field="TAXCODE" CssClass="item-control ReadOnly " ControlValue='<%#Eval("TAXCODE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_TAXRATE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.TAXRATE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_TAXRATE" title="" data-type='text' onblur="checkExpression(this)" data-field="TAXRATE" CssClass="item-control ReadOnly " ControlValue='<%#Eval("TAXRATE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden InitOrderLimt" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.InitOrderLimt").Split('<')[0] %>'>
                                                <ult:Label ID="InitOrderLimt" title="" data-type='text' onblur="checkExpression(this)" data-field="InitOrderLimt" CssClass="item-control ReadOnly " runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_ORDERUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERUNITVALUE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ORDERUNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERUNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNITVALUE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_UNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.UNITVALUE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_UNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="UNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("UNITVALUE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONSUMPTIONUNITVALUE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_CONSUMPTIONUNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="CONSUMPTIONUNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONSUMPTIONUNITVALUE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBTOTALAMOUNT" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBTOTALAMOUNT" CssClass="item-control  " ControlValue='<%#Eval("SUBTOTALAMOUNT")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYCE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBSUBFAMILYCE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYCE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCE")%>' runat="server">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_NETNETPRICE" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETNETPRICE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_NETNETPRICE" title="" data-type='number' onblur="checkExpression(this)" data-field="NETNETPRICE" CssClass="item-control validate[custom[number]] " ControlValue='<%#Eval("NETNETPRICE")%>' runat="server">
                                                </ult:Label>
                                            </td>

                                            <td class="hidden td_ARTICLEID" data-label='<%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLEID").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ARTICLEID" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLEID" CssClass="item-control" ControlValue='<%#Eval("ARTICLEID")%>' runat="server">
                                                </ult:Label>
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
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=9119cb80-5cf5-45f6-9d3c-20f1ed3e3161'></script>
    <script type='text/javascript' src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>
