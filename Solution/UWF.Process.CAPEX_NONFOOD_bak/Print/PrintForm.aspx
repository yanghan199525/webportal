<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.CAPEX_NONFOOD.PrintForm" %>
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
    <title>CAPEX_NONFOOD</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="CAPEX_NONFOOD" processpefix="" tablename="PROC_CAPEX_NONFOOD"
   tablenamedetail="PROC_CAPEX_NONFOOD_ITEMS" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.CAPEX_NONFOOD") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_SITECODE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SITECODE") %>：</td>
                        <td class="tdtxt tdt_SITECODE">
                                                        <ult:Label ID="read_SITECODE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SITENAME"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SITENAME") %>：</td>
                        <td class="tdtxt  tdt_SITENAME">
                                                        <ult:Label ID="read_SITENAME"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_AMOUNT"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.AMOUNT") %>：</td>
                        <td class="tdtxt tdt_AMOUNT">
                                                        <ult:Label ID="read_AMOUNT"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_DOCUMENTNO"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.DOCUMENTNO") %>：</td>
                        <td class="tdtxt  tdt_DOCUMENTNO">
                                                        <ult:Label ID="read_DOCUMENTNO"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_SUPPLIERCODE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SupplierCode") %>：</td>
                        <td class="tdtxt tdt_SUPPLIERCODE">
                                                        <ult:Label ID="read_SUPPLIERCODE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SUPPLIERNAME"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SupplierName") %>：</td>
                        <td class="tdtxt  tdt_SUPPLIERNAME">
                                                        <ult:Label ID="read_SUPPLIERNAME"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_CONTRACTDATE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.ContractDate") %>：</td>
                        <td class="tdtxt tdt_CONTRACTDATE">
                                                        <ult:Label ID="read_CONTRACTDATE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_DEPRECIATIONDATE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.DepreciationDate") %>：</td>
                        <td class="tdtxt  tdt_DEPRECIATIONDATE">
                                                        <ult:Label ID="read_DEPRECIATIONDATE"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_UPLOADS"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.Uploads") %>：</td>
                        <td class="tdtxt tdt_UPLOADS">
                                                        <ult:Label ID="read_UPLOADS"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>
                <div class="panel  "><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.CAPEX_NONFOOD_ITEMS") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="" class=" thlbl td_ARTICLECODE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.ArticleCode") %></td>
                    <td style="" class=" thlbl td_ARTICLENAME"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.ArticleName") %></td>
                    <td style="" class=" thlbl td_FAMILYNAME"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.FamilyName") %></td>
                    <td style="" class=" thlbl td_PCPRICE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.PCPrice") %></td>
                    <td style="" class=" thlbl td_ORDERQTY"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.OrderQty") %></td>
                    <td style="" class=" thlbl td_ORDERUNIT"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.OrderUnit") %></td>
                    <td style="" class=" thlbl td_AMOUNT"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.Amount") %></td>
                    <td style="" class=" thlbl td_DELIVERYDATE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.DeliveryDate") %></td>
                    <td style="" class=" thlbl td_NEEDACCEPT"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.NeedAccept") %></td>
                    <td style="" class=" thlbl td_ASSETCLASS"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.AssetClass") %></td>
                    <td style="" class=" thlbl td_ACCEPTMARK"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.AcceptMark") %></td>
                    <td style="" class=" thlbl td_FAMILYCODE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.FamilyCode") %></td>
                    <td style="" class=" thlbl td_DEPRECIATIONSTARTDATE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.DepreciationStartDate") %></td>
                    <td style="" class=" thlbl td_BUYBACKTERM"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.BuybackTerm") %></td>
                    <td style="" class=" thlbl td_REMOVABLE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.Removable") %></td>
                    <td style="" class=" thlbl td_USEFULLIFE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.UsefulLife") %></td>
                    <td style="" class=" thlbl td_ACCEPTANCEREQUIRED"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.AcceptanceRequired") %></td>
                    <td style="" class=" thlbl td_COMMODITYCODE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.CommodityCode") %></td>
                    <td style="" class=" thlbl td_CONTRACTCLOSUREDATE"><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.ContractClosureDate") %></td>
                </tr>
                <ult:Repeater ID="read_detail_PROC_CAPEX_NONFOOD_ITEMS" runat="server">
                  <ItemTemplate>
                    <tr>
                       <td class="Detail_tdtxt   td_ARTICLECODE">
                                                        <ult:Label ID="fld_ARTICLECODE"   data-field="ARTICLECODE" runat="server" Text='<%#Eval("ARTICLECODE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ARTICLENAME">
                                                        <ult:Label ID="fld_ARTICLENAME"   data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_FAMILYNAME">
                                                        <ult:Label ID="fld_FAMILYNAME"   data-field="FAMILYNAME" runat="server" Text='<%#Eval("FAMILYNAME")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_PCPRICE">
                                                       <ult:Label ID="fld_PCPRICE"   data-field="PCPRICE" runat="server" Text='<%#Eval("PCPRICE")%>' Format=""  CssClass="autonumber"  ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ORDERQTY">
                                                       <ult:Label ID="fld_ORDERQTY"   data-field="ORDERQTY" runat="server" Text='<%#Eval("ORDERQTY")%>' Format=""  CssClass="autonumber"  ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ORDERUNIT">
                                                        <ult:Label ID="fld_ORDERUNIT"   data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_AMOUNT">
                                                       <ult:Label ID="fld_AMOUNT"   data-field="AMOUNT" runat="server" Text='<%#Eval("AMOUNT")%>' Format=""  CssClass="autonumber"  ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_DELIVERYDATE">
                                                        <ult:Label ID="fld_DELIVERYDATE"   data-field="DELIVERYDATE" runat="server" Text='<%#Eval("DELIVERYDATE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_NEEDACCEPT">
                                                        <ult:Label ID="fld_NEEDACCEPT"   data-field="NEEDACCEPT" runat="server" Text='<%#Eval("NEEDACCEPT")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ASSETCLASS">
                                                        <ult:Label ID="fld_ASSETCLASS"   data-field="ASSETCLASS" runat="server" Text='<%#Eval("ASSETCLASS")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ACCEPTMARK">
                                                        <ult:Label ID="fld_ACCEPTMARK"   data-field="ACCEPTMARK" runat="server" Text='<%#Eval("ACCEPTMARK")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_FAMILYCODE">
                                                        <ult:Label ID="fld_FAMILYCODE"   data-field="FAMILYCODE" runat="server" Text='<%#Eval("FAMILYCODE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_DEPRECIATIONSTARTDATE">
                                                        <ult:Label ID="fld_DEPRECIATIONSTARTDATE"   data-field="DEPRECIATIONSTARTDATE" runat="server" Text='<%#Eval("DEPRECIATIONSTARTDATE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_BUYBACKTERM">
                                                        <ult:Label ID="fld_BUYBACKTERM"   data-field="BUYBACKTERM" runat="server" Text='<%#Eval("BUYBACKTERM")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_REMOVABLE">
                                                        <ult:Label ID="fld_REMOVABLE"   data-field="REMOVABLE" runat="server" Text='<%#Eval("REMOVABLE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_USEFULLIFE">
                                                        <ult:Label ID="fld_USEFULLIFE"   data-field="USEFULLIFE" runat="server" Text='<%#Eval("USEFULLIFE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ACCEPTANCEREQUIRED">
                                                        <ult:Label ID="fld_ACCEPTANCEREQUIRED"   data-field="ACCEPTANCEREQUIRED" runat="server" Text='<%#Eval("ACCEPTANCEREQUIRED")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_COMMODITYCODE">
                                                        <ult:Label ID="fld_COMMODITYCODE"   data-field="COMMODITYCODE" runat="server" Text='<%#Eval("COMMODITYCODE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_CONTRACTCLOSUREDATE">
                                                        <ult:Label ID="fld_CONTRACTCLOSUREDATE"   data-field="CONTRACTCLOSUREDATE" runat="server" Text='<%#Eval("CONTRACTCLOSUREDATE")%>' Format="" ></ult:Label>

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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=739652fd-992c-47ff-9713-dd94e9f8ad4a'></script>
    <script type='text/javascript' src='PrintForm.js?t=ce61e3d8-3344-4009-a604-ba95a8caafd7'></script>
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
