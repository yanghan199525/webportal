<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.PO_SUPPLIER_NETPRICE.PrintForm" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/PrintUserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/PrintApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/PrintCirculationUserInfo.ascx" TagName="CirculationUserInfo" TagPrefix="cir" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>PO_SUPPLIER_NETPRICE</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="PO_SUPPLIER_NETPRICE" processpefix="PON" tablename="PO_SUPPLIER_NETPRICE"
   tablenamedetail="PROC_PO_SUPPLIER_NETPRICE_ITEMS" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PO_SUPPLIER_NETPRICE") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_ISALLOW"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.IsAllow") %>：</td>
                        <td class="tdtxt tdt_ISALLOW">
                                                        <ult:Label ID="read_ISALLOW"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_REASONS"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.Reasons") %>：</td>
                        <td class="tdtxt  tdt_REASONS">
                                                        <ult:Label ID="read_REASONS"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_SUPPLIERCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SupplierCode") %>：</td>
                        <td class="tdtxt tdt_SUPPLIERCODE">
                                                        <ult:Label ID="read_SUPPLIERCODE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SUPPLIERNAME"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SupplierName") %>：</td>
                        <td class="tdtxt  tdt_SUPPLIERNAME">
                                                        <ult:Label ID="read_SUPPLIERNAME"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_COMPANYCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.CompanyCode") %>：</td>
                        <td class="tdtxt tdt_COMPANYCODE">
                                                        <ult:Label ID="read_COMPANYCODE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_TOTALAMOUNTORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TotalAmountOrder") %>：</td>
                        <td class="tdtxt  tdt_TOTALAMOUNTORDER">
                                                       <ult:Label ID="read_TOTALAMOUNTORDER"  Format=""  CssClass="autonumber"  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_TOTALAMOUNTSUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TotalAmountSupplier") %>：</td>
                        <td class="tdtxt tdt_TOTALAMOUNTSUPPLIER">
                                                       <ult:Label ID="read_TOTALAMOUNTSUPPLIER"  Format="" CssClass="autonumber"  runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_TOTALAMOUNTDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TotalAmountDiffer") %>：</td>
                        <td class="tdtxt  tdt_TOTALAMOUNTDIFFER">
                                                       <ult:Label ID="read_TOTALAMOUNTDIFFER"  Format=""  CssClass="autonumber"  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_BATCHNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %>：</td>
                        <td class="tdtxt tdt_BATCHNUMBER">
                                                        <ult:Label ID="read_BATCHNUMBER"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_STATECODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.STATECODE") %>：</td>
                        <td class="tdtxt  tdt_STATECODE">
                                                        <ult:Label ID="read_STATECODE"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
            </table>
                <div class="panel  "><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PROC_PO_SUPPLIER_NETPRICE_ITEMS") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="" class=" thlbl td_SUPPLIERCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SupplierCode") %></td>
                    <td style="" class=" thlbl td_BATCHNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %></td>
                    <td style="" class=" thlbl td_PRARTICLECODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PRArticleCode") %></td>
                    <td style="" class=" thlbl td_ARTICLENAME"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLENAME") %></td>
                    <td style="" class=" thlbl td_TAXNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxNumber") %></td>
                    <td style="" class=" thlbl td_GRRECEIVINGQUANTITY"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.GRReceivingQuantity") %></td>
                    <td style="" class=" thlbl td_TAXRATEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateOrder") %></td>
                    <td style="" class=" thlbl td_TAXRATESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateSupplier") %></td>
                    <td style="" class=" thlbl td_TAXRATEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateDiffer") %></td>
                    <td style="" class=" thlbl td_NETPRICEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceOrder") %></td>
                    <td style="" class=" thlbl td_NETPRICESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceSupplier") %></td>
                    <td style="" class=" thlbl td_NETPRICEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceDiffer") %></td>
                    <td style="" class=" thlbl td_CONTRACTPRICEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceOrder") %></td>
                    <td style="" class=" thlbl td_CONTRACTPRICESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceSupplier") %></td>
                    <td style="" class=" thlbl td_CONTRACTPRICEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceDiffer") %></td>
                </tr>
                <ult:Repeater ID="read_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS" runat="server">
                  <ItemTemplate>
                    <tr>
                       <td class="Detail_tdtxt   td_SUPPLIERCODE">
                                                        <ult:Label ID="fld_SUPPLIERCODE"   data-field="SUPPLIERCODE" runat="server" Text='<%#Eval("SUPPLIERCODE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_BATCHNUMBER">
                                                        <ult:Label ID="fld_BATCHNUMBER"   data-field="BATCHNUMBER" runat="server" Text='<%#Eval("BATCHNUMBER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_PRARTICLECODE">
                                                        <ult:Label ID="fld_PRARTICLECODE"   data-field="PRARTICLECODE" runat="server" Text='<%#Eval("PRARTICLECODE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ARTICLENAME">
                                                        <ult:Label ID="fld_ARTICLENAME"   data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_TAXNUMBER">
                                                        <ult:Label ID="fld_TAXNUMBER"   data-field="TAXNUMBER" runat="server" Text='<%#Eval("TAXNUMBER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_GRRECEIVINGQUANTITY">
                                                       <ult:Label ID="fld_GRRECEIVINGQUANTITY"   data-field="GRRECEIVINGQUANTITY" runat="server" Text='<%#Eval("GRRECEIVINGQUANTITY")%>' Format=""  CssClass="autonumber"  ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_TAXRATEORDER">
                                                        <ult:Label ID="fld_TAXRATEORDER"   data-field="TAXRATEORDER" runat="server" Text='<%#Eval("TAXRATEORDER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_TAXRATESUPPLIER">
                                                        <ult:Label ID="fld_TAXRATESUPPLIER"   data-field="TAXRATESUPPLIER" runat="server" Text='<%#Eval("TAXRATESUPPLIER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_TAXRATEDIFFER">
                                                        <ult:Label ID="fld_TAXRATEDIFFER"   data-field="TAXRATEDIFFER" runat="server" Text='<%#Eval("TAXRATEDIFFER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_NETPRICEORDER">
                                                        <ult:Label ID="fld_NETPRICEORDER"   data-field="NETPRICEORDER" runat="server" Text='<%#Eval("NETPRICEORDER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_NETPRICESUPPLIER">
                                                        <ult:Label ID="fld_NETPRICESUPPLIER"   data-field="NETPRICESUPPLIER" runat="server" Text='<%#Eval("NETPRICESUPPLIER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_NETPRICEDIFFER">
                                                        <ult:Label ID="fld_NETPRICEDIFFER"   data-field="NETPRICEDIFFER" runat="server" Text='<%#Eval("NETPRICEDIFFER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_CONTRACTPRICEORDER">
                                                        <ult:Label ID="fld_CONTRACTPRICEORDER"   data-field="CONTRACTPRICEORDER" runat="server" Text='<%#Eval("CONTRACTPRICEORDER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_CONTRACTPRICESUPPLIER">
                                                        <ult:Label ID="fld_CONTRACTPRICESUPPLIER"   data-field="CONTRACTPRICESUPPLIER" runat="server" Text='<%#Eval("CONTRACTPRICESUPPLIER")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_CONTRACTPRICEDIFFER">
                                                        <ult:Label ID="fld_CONTRACTPRICEDIFFER"   data-field="CONTRACTPRICEDIFFER" runat="server" Text='<%#Eval("CONTRACTPRICEDIFFER")%>' Format="" ></ult:Label>

                          </td>
                    </tr>
                  </ItemTemplate>
                </ult:Repeater>
            </table>

            <cir:circulationuserinfo id="Circulation1" runat="server"></cir:circulationuserinfo>
            <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>

        </div>
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=2c52b594-430b-49eb-8d25-f0baa172aaa0'></script>
    <script type='text/javascript' src='PrintForm.js?t=25b37b64-328d-441b-9940-766fe8392c8a'></script>
    <script type="text/javascript">
$(function () {
            $("body").find("input[type*=radio]").attr("disabled", "false");
    $("body").find("input[type*=checkbox]").attr("disabled", "false");
    setTimeout();
})
        setTimeout(function () {
            window.print();
        }, 2000);
    </script>
    </script>
</body>
</html>
