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
    <%=WebUtil.IncludeCssV37() %>
    <%=WebUtil.IncludeJsV37() %>
</head>
<body style="background-color: #f5f5f5">
    <form id="form1" runat="server">
        <div style="display: none;">
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
        </div>
            <ui:userinfo id="UserInfo1" processtitle="" processprefix="" tablename="WF_ADDSIGN"
                tablenamedetail="" runat="server" readonly="true"></ui:userinfo>
        <iframe id="PIframe" runat="server" width="100%" scrolling="no" frameborder="0"
            style="background-color: #eaecee; margin: 0 0 -7px;"></iframe>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
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
