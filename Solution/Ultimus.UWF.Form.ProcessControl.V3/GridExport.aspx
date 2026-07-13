<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridExport.aspx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.GridExport" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<%=WebUtil.IncludeCssV3() %>
<%=WebUtil.IncludeJsV3() %>
<%=WebUtil.IncludeFormV3Css()%>
<html>
<head>
    <script>
        $(document).ready(function () {
            var str = window.opener.GetExportString();
            $("#<%=hfExportString.ClientID %>").val(str);
            $("#<%=btnDownload.ClientID %>").click();

            if (!isIE) {
                setTimeout(function () {
                    window.close();
                }, 400);
            }
        });
    </script>
</head>
<body>
    <form runat="server" id="form1">
        <asp:Button ID="btnDownload" style="display:none;" runat="server" Text="下载" 
            onclick="btnDownload_Click" />
    <asp:HiddenField ID="hfFileName" runat="server" />
    <asp:HiddenField ID="hfExportString" runat="server" />
    </form>
</body>
</html>
