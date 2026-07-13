<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PO_SUPPLIER_SUMMARY.Approval" %>
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
    <title>PO_SUPPLIER_SUMMARY</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="PO_SUPPLIER_SUMMARY" processpefix="" tablename="PROC_PO_SUPPLIER_SUMMARY"
            tablenamedetail="PROC_PO_SUPPLIER_SUMMARY_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PO_SUPPLIER_SUMMARY">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.PO_SUPPLIER_SUMMARY") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_BATCHNUMBER" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.BATCHNUMBER") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_BATCHNUMBER" title="" Format=""  runat="server">
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
            <div class="row" id="div_panel_PO_SUPPLIER_SUMMARY_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.PO_SUPPLIER_SUMMARY_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PO_SUPPLIER_SUMMARY_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PO_SUPPLIER_SUMMARY_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="  td_ISALLOW"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.IsAllow") %></td>
                                    <td style=""  class="  td_REASONS"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.Reasons") %></td>
                                    <td style=""  class="  td_SUPPLIERCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SupplierCode") %></td>
                                    <td style=""  class="  td_SUPPLIERNAME"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SupplierName") %></td>
                                    <td style=""  class="  td_COMPANYCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.CompanyCode") %></td>
                                    <td style=""  class="  td_TOTALAMOUNTORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TotalAmountOrder") %></td>
                                    <td style=""  class="  td_TOTALAMOUNTDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TotalAmountDiffer") %></td>
                                    <td style=""  class="  td_TOTALAMOUNTSUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TotalAmountSupplier") %></td>
                                    <td style=""  class="  td_STATECODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.STATECODE") %></td>
                                    <td style=""  class="  td_BATCHNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.BATCHNUMBER") %></td>

                                        <td style="width: 60px"><%=Lang.Get("Action") %></td>

                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="read_detail_PROC_PO_SUPPLIER_SUMMARY_ITEMS" runat="server">
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
                                            <td class=" td_ISALLOW" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.IsAllow").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ISALLOW" title="" data-field="ISALLOW" runat="server" Text='<%#Eval("ISALLOW")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_REASONS" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.Reasons").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_REASONS" title="" data-field="REASONS" runat="server" Text='<%#Eval("REASONS")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUPPLIERCODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SupplierCode").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUPPLIERCODE" title="" data-field="SUPPLIERCODE" runat="server" Text='<%#Eval("SUPPLIERCODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUPPLIERNAME" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SupplierName").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUPPLIERNAME" title="" data-field="SUPPLIERNAME" runat="server" Text='<%#Eval("SUPPLIERNAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_COMPANYCODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.CompanyCode").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_COMPANYCODE" title="" data-field="COMPANYCODE" runat="server" Text='<%#Eval("COMPANYCODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_TOTALAMOUNTORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TotalAmountOrder").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TOTALAMOUNTORDER" title="" data-field="TOTALAMOUNTORDER" runat="server" Text='<%#Eval("TOTALAMOUNTORDER")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_TOTALAMOUNTDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TotalAmountDiffer").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TOTALAMOUNTDIFFER" title="" data-field="TOTALAMOUNTDIFFER" runat="server" Text='<%#Eval("TOTALAMOUNTDIFFER")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_TOTALAMOUNTSUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TotalAmountSupplier").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TOTALAMOUNTSUPPLIER" title="" data-field="TOTALAMOUNTSUPPLIER" runat="server" Text='<%#Eval("TOTALAMOUNTSUPPLIER")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_STATECODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.STATECODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_STATECODE" title="" data-field="STATECODE" runat="server" Text='<%#Eval("STATECODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_BATCHNUMBER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.BATCHNUMBER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_BATCHNUMBER" title="" data-field="BATCHNUMBER" runat="server" Text='<%#Eval("BATCHNUMBER")%>' Width="90%"></ult:Label>
                                            </td>

                                                <td>
                                                    <a onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_PO_SUPPLIER_SUMMARY_ITEMS',this);}return false;"
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

                            <a onclick="addRow('tb_PO_SUPPLIER_SUMMARY_ITEMS');return false;" runat="server" id="btn_PO_SUPPLIER_SUMMARY_ITEMS"
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
    <script type='text/javascript' src='Approval.js?t=6d18a4ea-4d2c-4619-9b30-c413a204fa9e'></script>
</body>
</html>
