<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JdNewRequest.aspx.cs" Inherits="Ultimus.UWF.Home.V3.JdNewRequest" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="Ultimus.UWF.Form.ProcessControl.V3" %>
<%@ Import Namespace="Ultimus.UWF.Workflow.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>JD ORDER</title>
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <%=WebUtil.IncludeFormV3Css()%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-headersodexo " style="">
            <div class="left hidden-xs">
                <a href="../../../">
                    <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/form_logo.png" alt="logo" /></a>
            </div>
            <h1 class="title center"><strong>京东电商审批</strong></h1>
            <ol class="breadcrumb center">
            </ol>
            <div class="right">
                <div class="btn-group">
                    <div id="barcode2" class="hidden-xs">
                    </div>
                    <div id="documentno" style="text-align: center" class="hidden-xs">
                        <asp:Label ID="lblDocumentNo" runat="server"></asp:Label>
                        <asp:Label ID="fld_DOCUMENTNO" runat="server"></asp:Label>

                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_BasicInfo")%>
                        </div>
                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="fld_APPLICANT" runat="server" Text='' CssClass=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_AccountNo")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="fld_APPLICANTCODE" CssClass="" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_RequestDate")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="fld_REQUESTDATE" CssClass="utcdatetime" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="div_panel_OR_JD_ORDER">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.CPR_FOOD.CPR_FOOD") %>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" id="div_field_DOCUMENTNO" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.DOCUMENTNO") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="txt_DOCUMENTNO" title="" runat="server">
                                    </asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.PurchasingPurpose") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:DropDownList ID="fld_APPLYPURPOSE"  runat="server" Width="100%">
                                        <asp:ListItem>营运生产</asp:ListItem>
                                        <asp:ListItem>代采购</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_SITECODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SITECODE" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_SITENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SITENAME" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.DELIVERYDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                     <asp:TextBox ID="fld_DELIVERYDATE" data-type='string' title="" onblur="checkExpression(this)" data-field="DELIVERYDATE" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_SUPPLIERCODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_SUPPLIERNAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_POAmount" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.POAmount") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_POAMOUNT" data-type='string' title="" onblur="checkExpression(this)" data-field="POAMOUNT" variable="POAMOUNT" controlvalue="" CssClass="form-control ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_IsCapex" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.FIXEDASSETS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:RadioButtonList ID="fld_FIXEDASSETS" title="" data-field="FIXEDASSETS" Variable="" CssClass="" Source="DataSource." Filter="" ControlValue="" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="是" Value="01"></asp:ListItem>
                                        <asp:ListItem Text="否" Value="02" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_freight" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.freight") %>:
                                 
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_freight" data-type='string' title=""  data-field="freight" variable="" controlvalue="" CssClass="form-control ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.APPREMARK") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_APPREMARK" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <%--   <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.USER_SIGNEDAPPROVER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_USER_SIGNEDAPPROVER" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER2" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.USER_SIGNEDAPPROVER2") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_USER_SIGNEDAPPROVER2" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER2" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER3" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.USER_SIGNEDAPPROVER3") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_USER_SIGNEDAPPROVER3" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER3" variable="" controlvalue="" CssClass="form-control   ReadOnly" runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.DELIVERY") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_DELIVERY" data-type='string' title="" onblur="checkExpression(this)" data-field="DELIVERY" variable="DELIVERY" controlvalue="" CssClass="form-control  " runat="server">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
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
                        <table id="tb_OR_CPR_FOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_OR_CPR_FOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width: 50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style="" class=" td_SKUCODE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SKUCode") %></td>
                                    <td style="" class=" td_SKUNAME"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.SKUName") %></td>
                                    <td style="" class=" td_MATERIALTYPE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.MaterialType") %></td>
                                    <td style="" class=" td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OrderUnit") %></td>
                                    <td style="" class=" td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.OrderQuantity") %></td>
                                    <td style="" class=" td_PRICE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.Price") %></td>
                               <%--     <td style="" class=" td_TAXRATE"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.TaxRate") %></td>--%>
                                    <td style="" class=" td_GOODSAMOUNT"><%=Lang.Get("PR.PRProcess.OR_CPR_FOOD.GoodsAmount") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="fld_detail_PROC_JD_ORDER_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%#Eval("ROWNO")%>
                                            </td>
                                            <td><%#Eval("SKUCODE")%></td>
                                            <td class=" td_SKUNAME">
                                                <%#Eval("SKUNAME")%>
                                            </td>
                                            <td class=" td_MATERIALTYPE">
                                                <%#Eval("MATERIALTYPE")%>
                                            </td>
                                            <td class=" td_ORDERUNIT">
                                                <%#Eval("ORDERUNIT")%>
                                            </td>
                                            <td class=" td_ORDERQUANTITY">
                                                <%#Eval("ORDERQUANTITY")%>
                                            </td>
                                            <td class=" td_PRICE" d>
                                                <%#Eval("PRICE")%>
                                            </td>
                                       <%--     <td class=" td_TAXRATE">
                                                <%#Eval("TAXRATE")%>
                                            </td>--%>
                                            <td class=" td_GOODSAMOUNT">
                                                <%#Eval("GOODSAMOUNT")%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>
         <div class="panel-body padding-b-20" style="text-align: center">
                <asp:LinkButton ID="btnSend" runat="server" OnClick="btnSubmit_Click" OnClientClick="return approveForm();" CssClass="btn btn-default">提交</asp:LinkButton>
             </div>
    </form>
</body>
<script type='text/javascript' src='My97DatePicker/WdatePicker.js?t=e005db86-f756-42ef-afc6-af444545f4w30'></script>
<script type='text/javascript' src='My97DatePicker/dayjs.min.js?t=e005db86-f756-42ef-afc6-af444545f4w30'></script>
<script>
    function code128() {
        $("#barcode2").empty().barcode($("#lblDocumentNo").text(), "code128", { barWidth: 1, barHeight: 30, showHRI: false });
       
    }
    $(function () {
          var Amount = $("#fld_POAMOUNT").val();
             $("#fld_POAMOUNT").val(thousands(Amount));
             $("#fld_POAMOUNT").next("span").text($("#fld_POAMOUNT").val());
    })
    function thousands(num) {
    var Amount = num.split(".");
    var number = Amount.length > 1 ? Amount[1].substring(0, 2) : "00";
    if (number.length <= 1) {
        number += "0";
    }
    return Amount[0].replace(/\B(?=(?:\d{3})+\b)/g, ',') + "." + number;
}
</script>
</html>
