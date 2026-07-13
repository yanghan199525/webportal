<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MobileLogin.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MobileLogin" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title></title>
    <script>
    </script>
    <script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/js/jquery.js" type="text/javascript"></script>
    <script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/js/jquery.cookie.js" type="text/javascript"></script>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <style type="text/css">
    </style>

    <script type="text/javascript">

    </script>

</head>
<body>
    <div class="topbanner">
        <div class="poswrap">
            <h1 class="toptitle"></h1>
        </div>
    </div>

    <div class="login-form">
        <form id="form1" class="form" runat="server" style="border: 0">
        </form>
    </div>




</body>
</html>
