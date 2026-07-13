<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.NewProcess3.PrintForm" %>
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
    <title>NewProcess3</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="NewProcess3" processprefix="" tablename="PROC_TESTING"
    tablenamedetail="" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.NewProcess3.Testing") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
                    <tr class="">
                        <td class="tdlbl tdl_CREATER"><%=Lang.Get("UWF.Process.NewProcess3.Creater") %>：</td>
                        <td class="tdtxt tdt_CREATER">
                                                        <ult:Label ID="read_CREATER"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_EMPNO"><%=Lang.Get("UWF.Process.NewProcess3.EmpNo") %>：</td>
                        <td class="tdtxt  tdt_EMPNO">
                                                        <ult:Label ID="read_EMPNO"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_CTEATEDATE"><%=Lang.Get("UWF.Process.NewProcess3.CteateDate") %>：</td>
                        <td class="tdtxt tdt_CTEATEDATE">
                                                        <ult:Label ID="read_CTEATEDATE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl  tdl_AMOUNT"><%=Lang.Get("UWF.Process.NewProcess3.AMOUNT") %>：</td>
                        <td class="tdtxt  tdt_AMOUNT">
                                                        <ult:Label ID="read_AMOUNT"  Format=""  runat="server"></ult:Label>
</td>
                    </tr>
                    <tr class="">
                        <td class="tdlbl tdl_SUPPLIERTYPE"><%=Lang.Get("UWF.Process.NewProcess3.SUPPLIERTYPE") %>：</td>
                        <td class="tdtxt tdt_SUPPLIERTYPE">
                                                        <ult:Label ID="read_SUPPLIERTYPE"  Format="" runat="server"></ult:Label>
</td>
                        <td class="tdlbl"></td>
                        <td class="tdtxt"></td>
                    </tr>
            </table>

            <cir:circulationuserinfo id="Circulation1" runat="server"></cir:circulationuserinfo>
            <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>

        </div>
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=8c229b9d-9bc6-4031-b53a-01c4d5557737'></script>
    <script type='text/javascript' src='PrintForm.js?t=8b0d0792-5ddb-4ab9-bfc4-7f964767a9a6'></script>
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
