<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PO_Amendment.Approval" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
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
    <title>PO_Amendment</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="PO_Amendment" processpefix="PROC" tablename="PROC_PO_AMENDMENT"
            tablenamedetail="PROC_PO_AMENDMENT_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PO_Amendment">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DOCUMENTNO") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DOCUMENTNO" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITECODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.PurchasingPurpose") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PURCHASINGPURPOSE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_INITDELIVERYDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.INITDELIVERYDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_INITDELIVERYDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DELIVERYDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERYDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITENAME") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITENAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_INITAMOUNT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.INITAMOUNT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                    <ult:Label ID="read_INITAMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.AMOUNT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                    <ult:Label ID="read_AMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPREMARK") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPREMARK" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
            
            <!--补充空单元格-->

                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height:">
                                <div class="form-label">
                                </div>
                                <div class="form-field">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--1.2多行-->
                    <!--Start Item table-->
            <div class="row" id="div_panel_PO_Amendment_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PO_AMENDMENT_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PO_AMENDMENT_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="  td_ARTICLENAME"><%=Lang.Get("UWF.Process.PO_Amendment.ARTICLENAME") %></td>
                                    <td style=""  class="  td_SUBSUBFAMILYCE"><%=Lang.Get("UWF.Process.PO_Amendment.SUBSUBFAMILYCE") %></td>
                                    <td style=""  class="  td_ORDERUNIT"><%=Lang.Get("UWF.Process.PO_Amendment.ORDERUNIT") %></td>
                                    <td style=""  class="  td_SITEPRICE"><%=Lang.Get("UWF.Process.PO_Amendment.SITEPRICE") %></td>
                                    <td style=""  class="  td_INITORDERQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.INITORDERQUANTITY") %></td>
                                    <td style=""  class="  td_ORDERQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.ORDERQUANTITY") %></td>
                                    <td style=""  class="  td_SUBTOTALAMOUNT"><%=Lang.Get("UWF.Process.PO_Amendment.SUBTOTALAMOUNT") %></td>
                                    <td style=""  class="  td_ARTICLECODE"><%=Lang.Get("UWF.Process.PO_Amendment.ARTICLECODE") %></td>
                                    <td style=""  class="  td_ADJUSTMENTQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.AdjustmentQuantity") %></td>

                                        <td style="width: 60px"><%=Lang.Get("Action") %></td>

                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="read_detail_PROC_PO_AMENDMENT_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="hidden">
                                                <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>' >
                                                    </ult:TextBox>
                                                <ult:TextBox ID="fld_ROWGUID" data-field="ROWGUID" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWGUID")%>' >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLENAME" title="" data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYCE" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.SUBSUBFAMILYCE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBSUBFAMILYCE" title="" data-field="SUBSUBFAMILYCE" runat="server" Text='<%#Eval("SUBSUBFAMILYCE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ORDERUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERUNIT" title="" data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.SITEPRICE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SITEPRICE" title="" data-field="SITEPRICE" runat="server" Text='<%#Eval("SITEPRICE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_INITORDERQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.INITORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_INITORDERQUANTITY" title="" data-field="INITORDERQUANTITY" runat="server" Text='<%#Eval("INITORDERQUANTITY")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERQUANTITY" title="" data-field="ORDERQUANTITY" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBTOTALAMOUNT" title="" data-field="SUBTOTALAMOUNT" runat="server" Text='<%#Eval("SUBTOTALAMOUNT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ARTICLECODE" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ARTICLECODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLECODE" title="" data-field="ARTICLECODE" runat="server" Text='<%#Eval("ARTICLECODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ADJUSTMENTQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.AdjustmentQuantity").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ADJUSTMENTQUANTITY" title="" data-field="ADJUSTMENTQUANTITY" runat="server" Text='<%#Eval("ADJUSTMENTQUANTITY")%>' Width="90%"></ult:Label>
                                            </td>

                                                <td>
                                                    <a onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_PO_AMENDMENT_ITEMS',this);}return false;"
                                                       class="btn btn-icon btn-sm">
                                                        <i class="fa fa-trash"></i>
                                                    </a>

                                                </td>
                                            
                                        </tr>
                                    </ItemTemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>

                            <a onclick="addRow('tb_PO_AMENDMENT_ITEMS');return false;" runat="server" id="btn_PO_AMENDMENT_ITEMS"
                               class="btn btn-icon btn-default hidden-print">
                                <%=Lang.Get("Form_AddRow") %>
                            </a>

                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>
        <!--End Item table-->
        <attach:attachments id="Attachments1" runat="server" ReadOnly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=f0fbccc6-933a-4209-b6c8-d8ad52878bc9'></script>
</body>
</html>
