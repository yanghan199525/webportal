<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PO_SUPPLIER_NETPRICE.Approval" %>

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
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(Process);
             Ultimus.UWF.Form.WebControls.Repeater read_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS = Page.FindControl("read_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
        }


    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="PO_SUPPLIER_NETPRICE" processpefix="PON" tablename="PROC_PO_SUPPLIER_NETPRICE"
            tablenamedetail="PROC_PO_SUPPLIER_NETPRICE_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_PO_SUPPLIER_NETPRICE">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PO_SUPPLIER_NETPRICE") %>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_REASONS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.REASONS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_REASONS" title="" data-type='string' Format="" CssClass="form-control ReadOnly" Variable="" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERCODE" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERNAME" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COMPANYCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.COMPANYCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_COMPANYCODE" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TOTALAMOUNTORDER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TOTALAMOUNTORDER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_TOTALAMOUNTORDER" title="" Format="" CssClass="autonumber" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TOTALAMOUNTSUPPLIER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TOTALAMOUNTSUPPLIER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_TOTALAMOUNTSUPPLIER" title="" Format="" CssClass="autonumber" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TOTALAMOUNTDIFFER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TOTALAMOUNTDIFFER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_TOTALAMOUNTDIFFER" title="" Format="" CssClass="autonumber" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-8 col-sm-6 col-xs-12 form-cell hidden" id="div_field_BATCHNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_BATCHNUMBER" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_STATECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.STATECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_STATECODE" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>

                        <!--补充空单元格-->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs addCell1 hidden" style="height: ">
                            <div class="form-label">
                            </div>
                            <div class="form-field">
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs addCell2 hidden" style="height: ">
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
        <div class="row" id="div_panel_PO_SUPPLIER_NETPRICE_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PROC_PO_SUPPLIER_NETPRICE_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <div class="inputContainer padding-t-5" style="width: 100%">
                            <!--Start detail table-->
                            <table id="tb_PO_SUPPLIER_NETPRICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                                <thead>
                                    <tr>
                                        <td class="hidden">
                                            <input id="tb_PO_SUPPLIER_NETPRICE_ITEMS_rowCount" type="text" runat="server" />
                                        </td>
                                        <td style="width: 50px">
                                            <%=Lang.Get("No") %>
                                        </td>
                                        <td style="" class="  td_SUPPLIERCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERCODE") %></td>
                                        <td style="" class="hidden  td_BATCHNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %></td>
                                        <td style="" class="  td_ARTICLECODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLECODE") %></td>
                                        <td style="" class="  td_ARTICLENAME"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLENAME") %></td>
                                        <td style="" class="hidden  td_TAXNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXNUMBER") %></td>
                                        <td style="" class="  td_GRRECEIVINGQUANTITY"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.GRRECEIVINGQUANTITY") %></td>
                                        <td style="" class="  td_TAXRATEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATEORDER") %></td>
                                        <td style="" class="  td_TAXRATESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATESUPPLIER") %></td>
                                        <td style="" class="hidden  td_TAXRATEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATEDIFFER") %></td>
                                        <td style="" class="  td_NETPRICEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICEORDER") %></td>
                                        <td style="" class="  td_NETPRICESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICESUPPLIER") %></td>
                                        <td style="" class="  td_NETPRICEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICEDIFFER") %></td>
                                        <td style="" class="  td_ORDERAMOUNTINT"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ORDERAMOUNTINT") %></td>
                                        <td style="" class="  td_SUPPLIERAMOUNTINT"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERAMOUNTINT") %></td>
                                        <td style="" class="  td_DIFFERAMOUNTINT"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.DIFFERAMOUNTINT") %></td>

                                       <td style="" class="hidden  td_FINALNETPRICE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.FINALNETPRICE") %></td>
                                       <td style="" class="hidden  td_FINALTAXRATE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.FINALTAXRATE") %></td>

                                         <td style="" class="  td_BatchPriceNumber"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BatchPriceNumber") %></td>
                                        <td style="" class="hidden td_CONTRACTPRICEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CONTRACTPRICEORDER") %></td>
                                        <td style="" class="hidden  td_CONTRACTPRICESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CONTRACTPRICESUPPLIER") %></td>
                                        <td style="" class="hidden  td_CONTRACTPRICEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CONTRACTPRICEDIFFER") %></td>

                                    </tr>
                                </thead>
                                <tbody>
                                    <ult:Repeater ID="read_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="hidden">
                                                    <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                </td>
                                                <td data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                    <div class="index"><%#Eval("ROWNO")%> </div>
                                                    <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                    </ult:TextBox>
                                                    <ult:TextBox ID="fld_ROWGUID" data-field="ROWGUID" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWGUID")%>'>
                                                    </ult:TextBox>
                                                </td>
                                                <td class=" td_SUPPLIERCODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERCODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUPPLIERCODE" title="" data-type='string' data-field="SUPPLIERCODE" runat="server" Text='<%#Eval("SUPPLIERCODE")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_BATCHNUMBER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_BATCHNUMBER" title="" data-type='string' data-field="BATCHNUMBER" runat="server" Text='<%#Eval("BATCHNUMBER")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_ARTICLECODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLECODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLECODE" title="" data-type='string' data-field="ARTICLECODE" runat="server" Text='<%#Eval("ARTICLECODE")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLENAME" title="" data-type='string' data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_TAXNUMBER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXNUMBER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TAXNUMBER" title="" data-type='string' data-field="TAXNUMBER" runat="server" Text='<%#Eval("TAXNUMBER")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_GRRECEIVINGQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.GRRECEIVINGQUANTITY").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_GRRECEIVINGQUANTITY" title="" data-type='number' data-field="GRRECEIVINGQUANTITY" runat="server" Text='<%#Eval("GRRECEIVINGQUANTITY")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_TAXRATEORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATEORDER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TAXRATEORDER" title="" data-type='string' data-field="TAXRATEORDER" runat="server" Text='<%#Eval("TAXRATEORDER")%>'CssClass="autonumber"  Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_TAXRATESUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATESUPPLIER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TAXRATESUPPLIER" title="" data-type='string' data-field="TAXRATESUPPLIER" runat="server" Text='<%#Eval("TAXRATESUPPLIER")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_TAXRATEDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATEDIFFER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TAXRATEDIFFER" title="" data-type='string' data-field="TAXRATEDIFFER" runat="server" Text='<%#Eval("TAXRATEDIFFER")%>'CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_NETPRICEORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICEORDER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_NETPRICEORDER" title="" data-type='string' data-field="NETPRICEORDER" runat="server" Text='<%#Eval("NETPRICEORDER")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_NETPRICESUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICESUPPLIER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_NETPRICESUPPLIER" title="" data-type='string' data-field="NETPRICESUPPLIER" runat="server" Text='<%#Eval("NETPRICESUPPLIER")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_NETPRICEDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICEDIFFER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_NETPRICEDIFFER" title="" data-type='string' data-field="NETPRICEDIFFER" runat="server" Text='<%#Eval("NETPRICEDIFFER")%>'CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_ORDERAMOUNTINT" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ORDERAMOUNTINT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERAMOUNTINT" title="" data-type='string' data-field="ORDERAMOUNTINT" runat="server" Text='<%#Eval("ORDERAMOUNTINT")%>' CssClass="autonumber" Format="" Width="90%"></ult:Label>
                                                </td>

                                                <td class="td_SUPPLIERAMOUNTINT" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERAMOUNTINT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUPPLIERAMOUNTINT" title="" data-type='string' data-field="SUPPLIERAMOUNTINT" runat="server" Text='<%#Eval("SUPPLIERAMOUNTINT")%>'CssClass="autonumber"  Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_DIFFERAMOUNTINT" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.DIFFERAMOUNTINT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_DIFFERAMOUNTINT" title="" data-type='string' data-field="DIFFERAMOUNTINT" runat="server" Text='<%#Eval("DIFFERAMOUNTINT")%>'CssClass="autonumber"  Format="" Width="90%"></ult:Label>
                                                </td>

                                                <td class="hidden td_FINALNETPRICE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.FINALNETPRICE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_FINALNETPRICE" title="" data-type='string' data-field="FINALNETPRICE" runat="server" Text='<%#Eval("FINALNETPRICE")%>' CssClass="autonumber" Format="" Width="90%"></ult:TextBox>
                                                </td>
                                                <td class="hidden td_FINALTAXRATE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.FINALTAXRATE").Split('<')[0] %>'>
                                                    <ult:DropDownList ID="fld_FINALTAXRATE" title=""  data-field="FINALTAXRATE"  data-type='string'    ControlValue='<%#Eval("FINALTAXRATE")%>' runat="server">
                                                    <asp:ListItem Text="" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="普票(V0)-0%" Value="普票(V0)-0%"></asp:ListItem>        
                                                    <asp:ListItem Text="专票(V1)-3%" Value="专票(V1)-3%"></asp:ListItem>
                                                    <asp:ListItem Text="专票(V2)-6%" Value="专票(V2)-6%"></asp:ListItem>
                                                    <asp:ListItem Text="专票(V3)-13%" Value="专票(V3)-13%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(V4)-3%" Value="普票(V4)-3%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(V5)-1%" Value="普票(V5)-1%"></asp:ListItem>
                                                    <asp:ListItem Text="专票(V6)-5%" Value="专票(V6)-5%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(农产品免税)(V7)-0%" Value="普票(农产品免税)(V7)-0%">
                                                     </asp:ListItem>          
                                                    <asp:ListItem Text="普票(V8)-6%" Value="普票(V8)-6%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(V9)-9%" Value="普票(V9)-9%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(VA)-13%" Value="普票(VA)-13%"></asp:ListItem>
                                                    <asp:ListItem Text="专票(VB)-9%" Value="专票(VB)-9%"></asp:ListItem>
                                                    <asp:ListItem Text="专票(VC)-1%" Value="专票(VC)-1%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(免税)(VE)-0%" Value="普票(免税)(VE)-0%"></asp:ListItem>
                                                    <asp:ListItem Text="普票(VF)-5%" Value="普票(VF)-5%"></asp:ListItem>
                                                </ult:DropDownList>
                                                </td>
                                                 <td class="hidden td_BatchPriceNumber" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BatchPriceNumber").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_BatchPriceNumber" title="" data-type='string' data-field="BatchPriceNumber" runat="server" Text='<%#Eval("BatchPriceNumber")%>' Format="" Width="90%"></ult:Label>
                                                </td>

                                                <td class="hidden td_CONTRACTPRICEORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CONTRACTPRICEORDER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_CONTRACTPRICEORDER" title="" data-type='string' data-field="CONTRACTPRICEORDER" runat="server" Text='<%#Eval("CONTRACTPRICEORDER")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_CONTRACTPRICESUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CONTRACTPRICESUPPLIER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_CONTRACTPRICESUPPLIER" title="" data-type='string' data-field="CONTRACTPRICESUPPLIER" runat="server" Text='<%#Eval("CONTRACTPRICESUPPLIER")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_CONTRACTPRICEDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CONTRACTPRICEDIFFER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_CONTRACTPRICEDIFFER" title="" data-type='string' data-field="CONTRACTPRICEDIFFER" runat="server" Text='<%#Eval("CONTRACTPRICEDIFFER")%>' Format="" Width="90%"></ult:Label>
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
        </div>
        <!--End Item table-->
        <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=d761c739-9b21-4f18-a021-053ba98ccf3a'></script>
    <script type='text/javascript' src='Approval.js?t=5d997997-98d2-49ca-920f-05ea4fb8b1ce'></script>
</body>
</html>
