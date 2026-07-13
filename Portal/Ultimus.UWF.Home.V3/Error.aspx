<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Ultimus.UWF.Home.V3.Error" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%=WebUtil.IncludeFiles() %>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <br />
            <strong><%=Lang.Get("Error_SystemError")%> </strong>
            <hr />
            <strong><%=Lang.Get("Error_info")%> :</strong>
            <asp:Literal ID="ltError" runat="server"></asp:Literal>
            <div class="<%=hidden %>">
                Stack Description :<br />
                <asp:Literal ID="ltStack" runat="server"></asp:Literal>
            </div>
        </div>
    </form>
</body>
</html>
