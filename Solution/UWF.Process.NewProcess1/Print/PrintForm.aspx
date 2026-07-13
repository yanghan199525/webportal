<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.NewProcess1.PrintForm" %>
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
    <title>NewProcess1</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="NewProcess1" processpefix="" tablename="PROC_NEWPROCESS1"
   tablenamedetail="PROC_ITEM" runat="server"></ui:userinfo>
                <div class="panel  hidden"><%=Lang.Get("UWF.Process.NewProcess1.NewProcess1") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_PRODUCTNO"><%=Lang.Get("UWF.Process.NewProcess1.ProductNo") %>：</td>
                        <td class="tdtxt tdt_PRODUCTNO">
                                                        <ult:Label ID="read_PRODUCTNO"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>
                <div class="panel  "><%=Lang.Get("UWF.Process.NewProcess1.Item") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="" class=" thlbl td_VENDORCODE"><%=Lang.Get("UWF.Process.NewProcess1.VendorCode") %></td>
                </tr>
                <ult:Repeater ID="read_detail_PROC_ITEM" runat="server">
                  <ItemTemplate>
                    <tr>
                       <td class="Detail_tdtxt   td_VENDORCODE">
                                                        <ult:Label ID="fld_VENDORCODE"   data-field="VENDORCODE" runat="server" Text='<%#Eval("VENDORCODE")%>' Format="" ></ult:Label>

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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=120edd1c-7222-46b1-a46b-522bc4691194'></script>
    <script type='text/javascript' src='PrintForm.js?t=95ff724e-c19c-49ef-a0fc-a94ccd9d6d71'></script>
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
