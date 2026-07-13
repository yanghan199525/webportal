<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.NewProcess1.Approval" %>
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
    <title>NewProcess1</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="NewProcess1" processpefix="" tablename="PROC_NEWPROCESS1"
            tablenamedetail="PROC_ITEM" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_NewProcess1">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.NewProcess1.NewProcess1") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ProductNo" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.NewProcess1.ProductNo") %><span style='color:red'>*</span>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PRODUCTNO" title="" Format=""  runat="server">
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
            <div class="row" id="div_panel_Item">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.NewProcess1.Item") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_ITEM" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_ITEM_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="  td_VENDORCODE"><%=Lang.Get("UWF.Process.NewProcess1.VendorCode") %></td>

                                        <td style="width: 60px"><%=Lang.Get("Action") %></td>

                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="read_detail_PROC_ITEM" runat="server">
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
                                            <td class=" td_VENDORCODE" data-label='<%=Lang.Get("UWF.Process.NewProcess1.VendorCode").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_VENDORCODE" title="" data-field="VENDORCODE" runat="server" Text='<%#Eval("VENDORCODE")%>' Width="90%"></ult:Label>
                                            </td>

                                                <td>
                                                    <a onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_ITEM',this);}return false;"
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

                            <a onclick="addRow('tb_ITEM');return false;" runat="server" id="btn_ITEM"
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
    <script type='text/javascript' src='Approval.js?t=56aa1a81-782e-42cb-982a-46360f6a941c'></script>
</body>
</html>
