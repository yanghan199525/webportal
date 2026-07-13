<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonInfo.aspx.cs" Inherits="Ultimus.UWF.Home.V3.PersonInfo" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Person Info</title>
   <%=WebUtil.IncludeFiles() %>
    <script type="text/javascript">
        function openDetail(id) {
            window.location.href = "SecurityDetail.aspx";
            //returnValue = window.showModalDialog("PermissionDetail.aspx", "detail", "dialogWidth:800px;dialogHeight:600px");
            return false;
        }


        function uploadFile(filePath) {
            if (filePath.length > 0) {
                __doPostBack('btnUploadFile', '');
                formReset();
            }
        }
        function formReset() {
            document.getElementById("form1").reset()
        }

    </script>
</head>
<body>
    
    <form id="form1" runat="server">
    <div class="container-fluid">

        <div style="display: none">
                                        <asp:FileUpload ID="FileUpload" runat="server" accept="image/*" onchange="uploadFile(this.value)" />
                                    </div>
                                    <div style="display: none">
                                        <asp:LinkButton ID="btnUploadFile" runat="server" OnClick="btnUploadFile_Click">upload</asp:LinkButton>
                                    </div>

    <fieldset>
        <legend> <%=Lang.Get("PersonInfo_Title") %></legend>
        <div style="width:80%;padding-left:20px;">

        <table class="table  table-bordered table-condensed" >
            <tr style="display:none;">
                <td class="td-label">
                     
                </td>
                <td class="td-content">
                   <asp:Image ID="Image1" runat="server" ImageAlign="Middle" 
                       onclick="document.getElementById('FileUpload').click();"  
                       Style="width: 80px; height: 80px; border-radius: 50px; cursor: pointer" />                                    
                </td>
            </tr>
            <tr>
                <td class="td-label">
                     <%=Lang.Get("Form_AccountNo")%>：
                </td>
                <td class="td-content">
                    <asp:Label ID="lblEmpNo" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="td-label">
                      <%=Lang.Get("PersonInfo_Name")%>： 
                </td>
                <td class="td-content">
                    <asp:Label ID="lblName" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="td-label">
                     <%=Lang.Get("PersonInfo_LoginName")%>：
                </td>
                <td class="td-content">
                    <asp:Label ID="lblAccount" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            
            <tr>
                <td class="td-label">
                      <%=Lang.Get("PersonInfo_JobFunction")%>： 
                </td>
                <td class="td-content">
                    <asp:Label ID="lblTitle" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            <tr class="hidden">
                <td class="td-label">
                     <%=Lang.Get("PersonInfo_Email")%>： 
                </td>
                <td class="td-content">
                    <asp:Label ID="lblEmail" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="td-label">
                     <%=Lang.Get("PersonInfo_Department")%>： 
                </td>
                <td class="td-content">
                    <asp:Label ID="lblDepartment" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            <tr class="hidden">
                <td class="td-label">
                     <%=Lang.Get("PersonInfo_DirectReport")%>：  
                </td>
                <td class="td-content">
                    <asp:Label ID="lblDirectReport" runat="server" CssClass="  "></asp:Label>
                </td>
            </tr>
            <tr  >
                <td class="td-label">
                     Email：  
                </td>
                <td class="td-content">
                    <asp:Label ID="txtEmail" runat="server"></asp:Label>
                </td>
            </tr>
            <tr  >
                <td class="td-label">
                     <%=Lang.Get("Form_ApplicantTel")%>：  
                </td>
                <td class="td-content">
                    <asp:TextBox ID="txtTel" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr  >
                <td class="td-label">
                    <%=Lang.Get("Language")%> ：  
                </td>
                <td class="td-content">
                    <asp:DropDownList ID="ddlLanguage" runat="server">
                    <%--<asp:ListItem></asp:ListItem>
                    <asp:ListItem Text="中文" Value="zh-CN"></asp:ListItem>
                    <asp:ListItem Text="English" Value="en-US"></asp:ListItem>--%>
                    </asp:DropDownList>
                </td>
            </tr>
             
            <tr align="center">
            <td colspan="2" align="center"><asp:Button
                ID="btnSearch" runat="server" Text="保存" CssClass="btn  btn-primary" 
                    onclick="btnSave_Click"   />
                <asp:Button ID="btnChangePassword" runat="server" Text="修改密码" Visible="false" CssClass="btn " onclick="btnChangePassword_Click" style="display:none;" />
                </td>
             
            </tr>
        </table></div>
    </fieldset></div>
    </form>
</body>
</html>
