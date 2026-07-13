<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Ultimus.UWF.Home.V3.ChangePassword" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <%=WebUtil.IncludeFiles() %>
    <script type="text/javascript">
        function openDetail(id) {
            window.location.href = "SecurityDetail.aspx";
            //returnValue = window.showModalDialog("PermissionDetail.aspx", "detail", "dialogWidth:800px;dialogHeight:600px");
            return false;
        }
    </script>
</head>
<body>
    
    <form id="form1" runat="server">
    <fieldset>
        <legend> <% =Lang.Get("ChangePassword") %></legend>
        <div style="width:80%;padding-left:20px;">
        <table class="table  table-bordered table-condensed" >
             <tr  >
                <td class="td-label">
                   <%= Lang.Get("Oldpassword") %>   
                </td>
                <td class="td-content">
                    <asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr  >
                <td class="td-label">
                    <% = Lang.Get("newpassword") %>   
                </td>
                <td class="td-content">
                    <asp:TextBox ID="txtPwd" runat="server" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr  >
                <td class="td-label">
                   <%= Lang.Get("Repeatnewpassword") %>  
                </td>
                <td class="td-content">
                    <asp:TextBox ID="txtPwd2" runat="server" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr align="center">
            <td colspan="2" align="center"><asp:Button
                ID="btnSearch" runat="server" Text="保存" CssClass="btn  btn-primary" 
                    onclick="btnSave_Click"   />
                
                </td>
             
            </tr>
        </table></div>
    </fieldset>

        <div class="hidden">

                    <asp:TextBox ID="txtLoginName" runat="server" TextMode="Password"></asp:TextBox>

        </div>
    </form>
</body>
</html>
