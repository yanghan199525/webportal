<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.CPR_ALL.PrintForm" %>
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
    <title>CPR_ALL</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="CPR_ALL" processpefix="" tablename="PROC_CPR_ALL"
   tablenamedetail="PROC_CPR_ALL_ITEMS" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.CPR_ALL.CPR_ALL") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_SITECODE"><%=Lang.Get("UWF.Process.CPR_ALL.SITECODE") %>：</td>
                        <td class="tdtxt tdt_SITECODE">
                                                        <ult:Label ID="read_SITECODE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SITENAME"><%=Lang.Get("UWF.Process.CPR_ALL.SITENAME") %>：</td>
                        <td class="tdtxt  tdt_SITENAME">
                                                        <ult:Label ID="read_SITENAME"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_DELIVERYDATE"><%=Lang.Get("UWF.Process.CPR_ALL.DELIVERYDATE") %>：</td>
                        <td class="tdtxt tdt_DELIVERYDATE">
                                                        <ult:Label ID="read_DELIVERYDATE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SUPPLIERCODE"><%=Lang.Get("UWF.Process.CPR_ALL.SUPPLIERCODE") %>：</td>
                        <td class="tdtxt  tdt_SUPPLIERCODE">
                                                        <ult:Label ID="read_SUPPLIERCODE"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_SUPPLIERNAME"><%=Lang.Get("UWF.Process.CPR_ALL.SUPPLIERNAME") %>：</td>
                        <td class="tdtxt tdt_SUPPLIERNAME">
                                                        <ult:Label ID="read_SUPPLIERNAME"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>
                <div class="panel  "><%=Lang.Get("UWF.Process.CPR_ALL.CPR_all_Items") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="" class=" thlbl td_APPLYREASON"><%=Lang.Get("UWF.Process.CPR_ALL.APPLYREASON") %></td>
                </tr>
                <ult:Repeater ID="read_detail_PROC_CPR_ALL_ITEMS" runat="server">
                  <ItemTemplate>
                    <tr>
                       <td class="Detail_tdtxt   td_APPLYREASON">
                                                        <ult:Label ID="fld_APPLYREASON"   data-field="APPLYREASON" runat="server" Text='<%#Eval("APPLYREASON")%>' Format="" ></ult:Label>

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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=54ef0692-f6a8-4d7f-ab0b-97243b986e83'></script>
    <script type='text/javascript' src='PrintForm.js?t=6c2fc2a3-07bb-479b-9681-30f58bf37bb1'></script>
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
