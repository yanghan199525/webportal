<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.CAPEX_ALL.PrintForm" %>
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
    <title>CAPEX_ALL</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="CAPEX_ALL" processpefix="" tablename="PROC_CAPEX_ALL"
   tablenamedetail="PROC_CAPEX_ALL_ITEMS" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.CAPEX_ALL.CAPEX_ALL") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_SITECODE"><%=Lang.Get("UWF.Process.CAPEX_ALL.SITECODE") %>：</td>
                        <td class="tdtxt tdt_SITECODE">
                                                        <ult:Label ID="read_SITECODE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_SITENAME"><%=Lang.Get("UWF.Process.CAPEX_ALL.SITENAME") %>：</td>
                        <td class="tdtxt  tdt_SITENAME">
                                                        <ult:Label ID="read_SITENAME"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
            </table>
                <div class="panel  "><%=Lang.Get("UWF.Process.CAPEX_ALL.CAPEX_ALL_ITEMS") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="" class=" thlbl td_USEFULLIFE"><%=Lang.Get("UWF.Process.CAPEX_ALL.USEFULLIFE") %></td>
                </tr>
                <ult:Repeater ID="read_detail_PROC_CAPEX_ALL_ITEMS" runat="server">
                  <ItemTemplate>
                    <tr>
                       <td class="Detail_tdtxt   td_USEFULLIFE">
                                                        <ult:Label ID="fld_USEFULLIFE"   data-field="USEFULLIFE" runat="server" Text='<%#Eval("USEFULLIFE")%>' Format="" ></ult:Label>

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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=af1418f3-8ae0-49c8-baf9-c2fbe6cd3f6f'></script>
    <script type='text/javascript' src='PrintForm.js?t=671e9d43-cd36-4a27-a7ee-de5d691fa699'></script>
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
