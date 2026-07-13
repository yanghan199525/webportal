<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintForm.aspx.cs" Inherits="UWF.Process.TestProcess.PrintForm" %>
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
    <title>TestProcess</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divmain">

                <ui:userinfo id="UserInfo1" processtitle="TestProcess" processprefix="CS" tablename="PROC_TESTPROCESS"
    tablenamedetail="" runat="server"></ui:userinfo>
                <div class="panel  "><%=Lang.Get("UWF.Process.TestProcess.TestProcess") %></div>
                <table border="1" style="width: 100%; border-collapse: collapse;">
            </table>

            <cir:circulationuserinfo id="Circulation1" runat="server"></cir:circulationuserinfo>
            <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>

        </div>
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=cc350b5c-af55-418a-85ad-bcce113a47e0'></script>
    <script type='text/javascript' src='PrintForm.js?t=8fa89be5-e8d0-4c6e-9bc2-bbdcb2289dc1'></script>
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
