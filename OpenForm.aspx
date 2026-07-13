<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpenForm.aspx.cs" Inherits="UWF.Portal.OpenForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
<script>
    $(function () {
        if (!isIE()) {
            alert("提醒：审批流模块在IE浏览器下可能会出现系统错误，请切换至Edge或Chrome浏览器访问。"+<br/>+"Remind：Process approval  module’s system operation may have errors in IE browser, please change to Edge or Chrome.");
        }
    })
    function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window) 
        return true;
    else
        return false;
    }
</script>
