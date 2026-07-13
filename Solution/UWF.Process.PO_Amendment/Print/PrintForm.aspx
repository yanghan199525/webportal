<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.PO_Amendment.PrintForm" %>
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
    <title>PO_Amendment</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="PO_Amendment" processpefix="PROC" tablename="PROC_PO_AMENDMENT"
   tablenamedetail="PROC_PO_AMENDMENT_ITEMS" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_DOCUMENTNO"><%=Lang.Get("UWF.Process.PO_Amendment.DOCUMENTNO") %>：</td>
                        <td class="tdtxt tdt_DOCUMENTNO">
                                                        <ult:Label ID="read_DOCUMENTNO"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SITECODE"><%=Lang.Get("UWF.Process.PO_Amendment.SITECODE") %>：</td>
                        <td class="tdtxt  tdt_SITECODE">
                                                        <ult:Label ID="read_SITECODE"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_PURCHASINGPURPOSE"><%=Lang.Get("UWF.Process.PO_Amendment.PurchasingPurpose") %>：</td>
                        <td class="tdtxt tdt_PURCHASINGPURPOSE">
                                                        <ult:Label ID="read_PURCHASINGPURPOSE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_INITDELIVERYDATE"><%=Lang.Get("UWF.Process.PO_Amendment.INITDELIVERYDATE") %>：</td>
                        <td class="tdtxt  tdt_INITDELIVERYDATE">
                                                        <ult:Label ID="read_INITDELIVERYDATE"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_DELIVERYDATE"><%=Lang.Get("UWF.Process.PO_Amendment.DELIVERYDATE") %>：</td>
                        <td class="tdtxt tdt_DELIVERYDATE">
                                                        <ult:Label ID="read_DELIVERYDATE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SITENAME"><%=Lang.Get("UWF.Process.PO_Amendment.SITENAME") %>：</td>
                        <td class="tdtxt  tdt_SITENAME">
                                                        <ult:Label ID="read_SITENAME"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_INITAMOUNT"><%=Lang.Get("UWF.Process.PO_Amendment.INITAMOUNT") %>：</td>
                        <td class="tdtxt tdt_INITAMOUNT">
                                                       <ult:Label ID="read_INITAMOUNT"  Format="" CssClass="autonumber"  runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_AMOUNT"><%=Lang.Get("UWF.Process.PO_Amendment.AMOUNT") %>：</td>
                        <td class="tdtxt  tdt_AMOUNT">
                                                       <ult:Label ID="read_AMOUNT"  Format=""  CssClass="autonumber"  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_APPREMARK"><%=Lang.Get("UWF.Process.PO_Amendment.APPREMARK") %>：</td>
                        <td class="tdtxt tdt_APPREMARK">
                                                        <ult:Label ID="read_APPREMARK"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>
                <div class="panel  "><%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment_ITEMS") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="" class=" thlbl td_ARTICLENAME"><%=Lang.Get("UWF.Process.PO_Amendment.ARTICLENAME") %></td>
                    <td style="" class=" thlbl td_SUBSUBFAMILYCE"><%=Lang.Get("UWF.Process.PO_Amendment.SUBSUBFAMILYCE") %></td>
                    <td style="" class=" thlbl td_ORDERUNIT"><%=Lang.Get("UWF.Process.PO_Amendment.ORDERUNIT") %></td>
                    <td style="" class=" thlbl td_SITEPRICE"><%=Lang.Get("UWF.Process.PO_Amendment.SITEPRICE") %></td>
                    <td style="" class=" thlbl td_INITORDERQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.INITORDERQUANTITY") %></td>
                    <td style="" class=" thlbl td_ORDERQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.ORDERQUANTITY") %></td>
                    <td style="" class=" thlbl td_SUBTOTALAMOUNT"><%=Lang.Get("UWF.Process.PO_Amendment.SUBTOTALAMOUNT") %></td>
                </tr>
                <ult:Repeater ID="read_detail_PROC_PO_AMENDMENT_ITEMS" runat="server">
                  <ItemTemplate>
                    <tr>
                       <td class="Detail_tdtxt   td_ARTICLENAME">
                                                        <ult:Label ID="fld_ARTICLENAME"   data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_SUBSUBFAMILYCE">
                                                        <ult:Label ID="fld_SUBSUBFAMILYCE"   data-field="SUBSUBFAMILYCE" runat="server" Text='<%#Eval("SUBSUBFAMILYCE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ORDERUNIT">
                                                        <ult:Label ID="fld_ORDERUNIT"   data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_SITEPRICE">
                                                        <ult:Label ID="fld_SITEPRICE"   data-field="SITEPRICE" runat="server" Text='<%#Eval("SITEPRICE")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_INITORDERQUANTITY">
                                                        <ult:Label ID="fld_INITORDERQUANTITY"   data-field="INITORDERQUANTITY" runat="server" Text='<%#Eval("INITORDERQUANTITY")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_ORDERQUANTITY">
                                                        <ult:Label ID="fld_ORDERQUANTITY"   data-field="ORDERQUANTITY" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Format="" ></ult:Label>

                          </td>
                       <td class="Detail_tdtxt   td_SUBTOTALAMOUNT">
                                                        <ult:Label ID="fld_SUBTOTALAMOUNT"   data-field="SUBTOTALAMOUNT" runat="server" Text='<%#Eval("SUBTOTALAMOUNT")%>' Format="" ></ult:Label>

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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=d45913a0-d526-42f7-8c46-4a6469841b62'></script>
    <script type='text/javascript' src='PrintForm.js?t=f9c32116-1d91-4284-9d76-378dd2cc2966'></script>
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
