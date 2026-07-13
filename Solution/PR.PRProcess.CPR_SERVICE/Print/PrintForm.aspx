<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="PR.PRProcess.CPR_SERVICE.PrintForm" %>
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
    <title>CPR_SERVICE</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divmain">

             <ui:userinfo id="UserInfo1" processtitle="CPR_SERVICE" processpefix="CPRS" tablename="PROC_CPR_SERVICE"
                tablenamedetail="PROC_CPR_SERVICE_ITEMS" runat="server"></ui:userinfo>
            <div class="panel  hidden"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CPR_SERVICE") %></div>
            <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPLYPURPOSE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_APPLYPURPOSE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERTYPE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SUPPLIERTYPE"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITECODE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SITECODE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITENAME") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SITENAME"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.DELIVERYDATE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_DELIVERYDATE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ONLINEORSUPERMARKET") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_ONLINEORSUPERMARKET"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERCODE") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SUPPLIERCODE"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUPPLIERNAME") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_SUPPLIERNAME"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.AMOUNT") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_AMOUNT"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApproverName") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_USER_SIGNEDAPPROVERNAME"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover2Name") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_USER_SIGNEDAPPROVER2NAME"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.USER_SignedApprover3Name") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_USER_SIGNEDAPPROVER3NAME"   Format=""  runat="server">                </ult:Label></td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPREMARK") %>：</td>
                        <td class="tdtxt"><ult:Label ID="read_APPREMARK"  Format=""  runat="server">                </ult:Label></td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>
            <div class="panel  "><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CPR_SERVICE_Items") %></div>
            <table border="1" style="width: 100%; border-collapse: collapse;">
            <tr>
                <td style="" class=" thlbl td_APPLYREASON"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.APPLYREASON") %></td>
                <td style="" class="hidden thlbl td_FAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.FAMILYCODE") %></td>
                <td style="" class="hidden thlbl td_FAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.FAMILYNAME") %></td>
                <td style="" class="hidden thlbl td_SUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBFAMILYCODE") %></td>
                <td style="" class="hidden thlbl td_SUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBFAMILYNAME") %></td>
                <td style="" class="hidden thlbl td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYCODE") %></td>
                <td style="" class=" thlbl td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBSUBFAMILYNAME") %></td>
                <td style="" class=" thlbl td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLENAME") %></td>
                <td style="" class="hidden thlbl td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ARTICLECODE") %></td>
                <td style="" class=" thlbl td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERUNIT") %></td>
                <td style="" class="hidden thlbl td_UNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.UNIT") %></td>
                <td style="" class="hidden thlbl td_CONSUMPTIONUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONSUMPTIONUNIT") %></td>
                <td style="" class="hidden thlbl td_CONVERSION"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONVERSION") %></td>
                <td style="" class="hidden thlbl td_STOCK"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.STOCK") %></td>
                <td style="" class="hidden thlbl td_NETVOMULE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETVOMULE") %></td>
                <td style="" class="hidden thlbl td_GROSSWEIGHT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.GROSSWEIGHT") %></td>
                <td style="" class="hidden thlbl td_NETVOMULEUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.NETVOMULEUNIT") %></td>
                <td style="" class="hidden thlbl td_GROSSWEIGHTUNIT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.GROSSWEIGHTUNIT") %></td>
                <td style="" class=" thlbl td_SITEPRICE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SITEPRICE") %></td>
                <td style="" class=" thlbl td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERQUANTITY") %></td>
                <td style="" class="hidden thlbl td_ORDERUNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.ORDERUNITVALUE") %></td>
                <td style="" class="hidden thlbl td_UNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.UNITVALUE") %></td>
                <td style="" class="hidden thlbl td_CONSUMPTIONUNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.CONSUMPTIONUNITVALUE") %></td>
                <td style="" class=" thlbl td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.CPR_SERVICE.SUBTOTALAMOUNT") %></td>
            </tr>
        <ult:Repeater ID="read_detail_PROC_CPR_SERVICE_ITEMS" runat="server">
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
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_UNITVALUE"   data-field="UNITVALUE" runat="server" Text='<%#Eval("UNITVALUE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt hidden"><ult:Label ID="fld_CONSUMPTIONUNITVALUE"   data-field="CONSUMPTIONUNITVALUE" runat="server" Text='<%#Eval("CONSUMPTIONUNITVALUE")%>' Format="" ></ult:Label></td>
                <td class="Detail_tdtxt "><ult:Label ID="fld_SUBTOTALAMOUNT"   data-field="SUBTOTALAMOUNT" runat="server" Text='<%#Eval("SUBTOTALAMOUNT")%>' Format="" ></ult:Label></td>
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
