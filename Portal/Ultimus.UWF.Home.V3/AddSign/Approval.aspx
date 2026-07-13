<%@ Page Language="C#" AutoEventWireup="true" Inherits="Ultimus.UWF.AddSign.Approval" CodeBehind="Approval.aspx.cs" %>

<%@ Register Src="UserInfo_AddSign.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="ApprovalHistory_AddSign.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="ButtonList_AddSign.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>加签流程</title>
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <script>
        var oldHeight = 0;
        function reinitIframe() {
            oldHeight = document.getElementById("PIframe").style.height.replace('px', '');
            var iframe = document.getElementById("PIframe");
            try {
                var bHeight = iframe.contentWindow.document.body.scrollHeight;
                var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                var height = Math.max(bHeight, dHeight);
                iframe.height = height;
                console.log(height);
                if (oldHeight < height && oldHeight != '') {
                    document.getElementById("PIframe").style.height = '';
                    clearInterval(id);
                }
            } catch (ex) { }
        }
        var id = window.setInterval("reinitIframe()", 200);

    </script>
</head>
<body style="background-color: #f5f5f5">
    <form id="form1" runat="server">
        <div style="display: none;">
            <ui:UserInfo ID="UserInfo1" ProcessTitle="" ProcessPrefix="" TableName="WF_ADDSIGN"
                TableNameDetail="" runat="server" ReadOnly="true"></ui:UserInfo>
        </div>
        <iframe id="PIframe" runat="server" width="100%" scrolling="no" frameborder="0"
            style="background-color: #eaecee; margin: 0 0 -7px;"></iframe>
        <ah:ApprovalHistory ID="ApprovalHistory1" showaction="true" runat="server"></ah:ApprovalHistory>
        <btn:ButtonList ID="ButtonList1" runat="server"></btn:ButtonList>
        <div style="display: none;">
            <asp:Label ID="read_PARENTSUMMARY" runat="server" />
            <asp:Label ID="read_PARENTPROCESSNAME" runat="server" CssClass="" ReadOnly="true"></asp:Label>
            <asp:Label ID="read_PARENTINCIDENT" runat="server" CssClass="" ReadOnly="true"></asp:Label>
            <asp:TextBox ID="read_PARENTTASKID" runat="server"></asp:TextBox>
            <asp:TextBox ID="var_PageURL" runat="server" Text=""></asp:TextBox>

        </div>
    </form>
</body>
</html>
