<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="PR.PRProcess.HK_CPR_FOOD.PrintForm" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/PrintUserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/PrintApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
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
    <title>HK_CPR_FOOD</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divmain">

             <ui:userinfo id="UserInfo1" processtitle="HK_CPR_FOOD" processpefix="HK_CPR" tablename="PROC_HK_CPR_FOOD"
                tablenamedetail="PROC_HK_CPR_FOOD_ITEMS" runat="server"></ui:userinfo>
            <div class="panel  hidden"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.HK_CPR_FOOD") %></div>
            <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.APPLYPURPOSE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_APPLYPURPOSE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUPPLIERTYPE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SUPPLIERTYPE"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SITECODE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SITECODE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SITENAME") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SITENAME"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.DELIVERYDATE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_DELIVERYDATE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUPPLIERCODE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SUPPLIERCODE"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUPPLIERNAME") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SUPPLIERNAME"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ASSETTYPE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_ASSETTYPE"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.AMOUNT") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_AMOUNT"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.APPREMARK") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_APPREMARK"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.CPRFAMILYCODE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_CPRFAMILYCODE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.USER_SignedApprover") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_USER_SIGNEDAPPROVER"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.USER_SignedApprover2") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_USER_SIGNEDAPPROVER2"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.USER_SignedApprover3") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_USER_SIGNEDAPPROVER3"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SIGNEDAPPROVERNUMBER") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SIGNEDAPPROVERNUMBER"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.APPROVE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_APPROVE"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.FIXEDASSETS") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_FIXEDASSETS"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>
            <div class="panel  "><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.HK_CPR_FOOD_Items") %></div>
            <table border="1" style="width: 100%; border-collapse: collapse;">
            <tr>
                <td style="" class=" thlbl td_APPLYREASON"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.APPLYREASON") %></td>
                <td style="" class="hidden thlbl td_FAMILYCODE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.FAMILYCODE") %></td>
                <td style="" class="hidden thlbl td_FAMILYNAME"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.FAMILYNAME") %></td>
                <td style="" class="hidden thlbl td_SUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUBFAMILYCODE") %></td>
                <td style="" class="hidden thlbl td_SUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUBFAMILYNAME") %></td>
                <td style="" class="hidden thlbl td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUBSUBFAMILYCODE") %></td>
                <td style="" class=" thlbl td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUBSUBFAMILYNAME") %></td>
                <td style="" class=" thlbl td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ARTICLENAME") %></td>
                <td style="" class="hidden thlbl td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ARTICLECODE") %></td>
                <td style="" class=" thlbl td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ORDERUNIT") %></td>
                <td style="" class="hidden thlbl td_UNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.UNIT") %></td>
                <td style="" class="hidden thlbl td_CONSUMPTIONUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.CONSUMPTIONUNIT") %></td>
                <td style="" class="hidden thlbl td_CONVERSION"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.CONVERSION") %></td>
                <td style="" class="hidden thlbl td_STOCK"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.STOCK") %></td>
                <td style="" class="hidden thlbl td_NETVOMULE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.NETVOMULE") %></td>
                <td style="" class="hidden thlbl td_GROSSWEIGHT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.GROSSWEIGHT") %></td>
                <td style="" class="hidden thlbl td_NETVOMULEUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.NETVOMULEUNIT") %></td>
                <td style="" class="hidden thlbl td_GROSSWEIGHTUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.GROSSWEIGHTUNIT") %></td>
                <td style="" class=" thlbl td_SITEPRICE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SITEPRICE") %></td>
                <td style="" class=" thlbl td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ORDERQUANTITY") %></td>
                <td style="" class="hidden thlbl td_ORDERUNITVALUE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ORDERUNITVALUE") %></td>
                <td style="" class=" thlbl td_UNITVALUE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.UNITVALUE") %></td>
                <td style="" class="hidden thlbl td_CONSUMPTIONUNITVALUE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.CONSUMPTIONUNITVALUE") %></td>
                <td style="" class=" thlbl td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.SUBTOTALAMOUNT") %></td>
                <td style="" class="hidden thlbl td_NETNETPRICE"><%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.NETNETPRICE") %></td>
            </tr>
        <ult:Repeater ID="read_detail_PROC_HK_CPR_FOOD_ITEMS" runat="server">
                            <ItemTemplate>
            <tr>
                <td class="Detail_tdtxt "><ult:Label ID="fld_APPLYREASON"   data-field="APPLYREASON" runat="server" Text='<%#Eval("APPLYREASON")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_FAMILYCODE"   data-field="FAMILYCODE" runat="server" Text='<%#Eval("FAMILYCODE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_FAMILYNAME"   data-field="FAMILYNAME" runat="server" Text='<%#Eval("FAMILYNAME")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_SUBFAMILYCODE"   data-field="SUBFAMILYCODE" runat="server" Text='<%#Eval("SUBFAMILYCODE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_SUBFAMILYNAME"   data-field="SUBFAMILYNAME" runat="server" Text='<%#Eval("SUBFAMILYNAME")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_SUBSUBFAMILYCODE"   data-field="SUBSUBFAMILYCODE" runat="server" Text='<%#Eval("SUBSUBFAMILYCODE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_SUBSUBFAMILYNAME"   data-field="SUBSUBFAMILYNAME" runat="server" Text='<%#Eval("SUBSUBFAMILYNAME")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_ARTICLENAME"   data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_ARTICLECODE"   data-field="ARTICLECODE" runat="server" Text='<%#Eval("ARTICLECODE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_ORDERUNIT"   data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_UNIT"   data-field="UNIT" runat="server" Text='<%#Eval("UNIT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_CONSUMPTIONUNIT"   data-field="CONSUMPTIONUNIT" runat="server" Text='<%#Eval("CONSUMPTIONUNIT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_CONVERSION"   data-field="CONVERSION" runat="server" Text='<%#Eval("CONVERSION")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_STOCK"   data-field="STOCK" runat="server" Text='<%#Eval("STOCK")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_NETVOMULE"   data-field="NETVOMULE" runat="server" Text='<%#Eval("NETVOMULE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_GROSSWEIGHT"   data-field="GROSSWEIGHT" runat="server" Text='<%#Eval("GROSSWEIGHT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_NETVOMULEUNIT"   data-field="NETVOMULEUNIT" runat="server" Text='<%#Eval("NETVOMULEUNIT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_GROSSWEIGHTUNIT"   data-field="GROSSWEIGHTUNIT" runat="server" Text='<%#Eval("GROSSWEIGHTUNIT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_SITEPRICE"   data-field="SITEPRICE" runat="server" Text='<%#Eval("SITEPRICE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_ORDERQUANTITY"   data-field="ORDERQUANTITY" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_ORDERUNITVALUE"   data-field="ORDERUNITVALUE" runat="server" Text='<%#Eval("ORDERUNITVALUE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_UNITVALUE"   data-field="UNITVALUE" runat="server" Text='<%#Eval("UNITVALUE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_CONSUMPTIONUNITVALUE"   data-field="CONSUMPTIONUNITVALUE" runat="server" Text='<%#Eval("CONSUMPTIONUNITVALUE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_SUBTOTALAMOUNT"   data-field="SUBTOTALAMOUNT" runat="server" Text='<%#Eval("SUBTOTALAMOUNT")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_NETNETPRICE"   data-field="NETNETPRICE" runat="server" Text='<%#Eval("NETNETPRICE")%>' Format="" ></ult:Label></td>
            </tr>
                                </ItemTemplate>
            </ult:Repeater>
            </table>
        
       <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>

    </div>
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type="text/javascript">
        window.print();
    </script>
</body>
</html>
