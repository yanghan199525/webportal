<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="PR.PRProcess.OR_CPR_FOOD.Approval" %>
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
    <title>OR_CPR_FOOD</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="OR_CPR_FOOD" processpefix="OR_CPR" tablename="PROC_OR_CPR_FOOD"
            tablenamedetail="PROC_OR_CPR_FOOD_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_OR_CPR_FOOD">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OR_CPR_FOOD") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.DOCUMENTNO") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DOCUMENTNO" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.PurchasingPurpose") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PURCHASINGPURPOSE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SITECODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SITENAME") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITENAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.DELIVERYDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERYDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SUPPLIERCODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SUPPLIERCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SUPPLIERNAME") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SUPPLIERNAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.USER_SIGNEDAPPROVER") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER2" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.USER_SIGNEDAPPROVER2") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER2" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER3" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.USER_SIGNEDAPPROVER3") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER3" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_POAmount" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.POAmount") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                    <ult:Label ID="read_POAMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_IsCapex" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.IsCapex") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_ISCAPEX" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.APPREMARK") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPREMARK" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.DELIVERY") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERY" title="" Format=""  runat="server">
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
            <div class="row" id="div_panel_OR_CPR_FOOD_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OR_CPR_FOOD_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_OR_CPR_FOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_OR_CPR_FOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="  td_SKUCODE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SKUCode") %></td>
                                    <td style=""  class="  td_SKUNAME"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SKUName") %></td>
                                    <td style=""  class="  td_MATERIALTYPE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.MaterialType") %></td>
                                    <td style=""  class="  td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OrderUnit") %></td>
                                    <td style=""  class="  td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OrderQuantity") %></td>
                                    <td style=""  class="  td_PRICE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.Price") %></td>
                                    <td style=""  class="  td_TAXRATE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.TaxRate") %></td>
                                    <td style=""  class="  td_GOODSAMOUNT"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.GoodsAmount") %></td>


                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="read_detail_PROC_OR_CPR_FOOD_ITEMS" runat="server">
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
                                            <td class=" td_SKUCODE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SKUCode").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SKUCODE" title="" data-field="SKUCODE" runat="server" Text='<%#Eval("SKUCODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SKUNAME" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SKUName").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SKUNAME" title="" data-field="SKUNAME" runat="server" Text='<%#Eval("SKUNAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_MATERIALTYPE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.MaterialType").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_MATERIALTYPE" title="" data-field="MATERIALTYPE" runat="server" Text='<%#Eval("MATERIALTYPE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OrderUnit").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERUNIT" title="" data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OrderQuantity").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERQUANTITY" title="" data-field="ORDERQUANTITY" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_PRICE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.Price").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_PRICE" title="" data-field="PRICE" runat="server" Text='<%#Eval("PRICE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_TAXRATE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.TaxRate").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TAXRATE" title="" data-field="TAXRATE" runat="server" Text='<%#Eval("TAXRATE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_GOODSAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.GoodsAmount").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_GOODSAMOUNT" title="" data-field="GOODSAMOUNT" runat="server" Text='<%#Eval("GOODSAMOUNT")%>' Width="90%"></ult:Label>
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
        <attach:attachments id="Attachments1" runat="server" ReadOnly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=dddd41d6-9f9e-4446-b2c2-6c29db50ed95'></script>
</body>
</html>
