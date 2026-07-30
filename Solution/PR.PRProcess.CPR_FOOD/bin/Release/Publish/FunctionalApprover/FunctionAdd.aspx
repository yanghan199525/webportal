<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FunctionAdd.aspx.cs" Inherits="Ultimus.UWF.Workflow.FunctionalApprover.FunctionAdd" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Functional Approver Add Conditions</title>
    <%--<script src="../../../../js/jquery.js" type="text/javascript"></script>
    <script src="../js/selector.js" type="text/javascript"></script>
    <script src="../../../../Js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="../../../../js/languages/jquery.validationEngine-zh_CN.js" type="text/javascript"></script>
    <script src="../../../../js/jquery.validationEngine.js" type="text/javascript"></script>--%>
     <%=WebUtil.IncludeFiles() %>
    <script type="text/javascript">
        //self.moveTo(0, 0);
        //self.resizeTo(screen.availWidth, screen.availHeight);

        function closeWin() {
            window.opener.$("#btnLoadList").click();
            window.opener = null;
            window.open('', '_self');
            window.close();
            return false;
        }

        function Delete() {
            if (confirm("是否确认删除")) {
                return true;
            } else {
                return false;
            }
        }
        function Ceshi() {
            alert("测试");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <br />
        <div class="container">
            <div class="row">
                <table class="table table-condensed table-bordered">
                    <tr>
                        <td class="banner" colspan="2">岗位信息/ Functionnal Info
                        </td>
                    </tr>
                    <tr>


                        <td class="td-label">岗位名称/Function Name:
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="lblFunctionName" runat="server" Enabled="false"  ></asp:TextBox> 
                        </td>
                    </tr>
                    <tr>
                        <td class="td-label"><span style="color: red">*</span>用户ID/User ID:
                        </td>
                        <td class="td-content">

                            <asp:TextBox ID="txtUSERID" runat="server"></asp:TextBox>
                            <button type="button" class="btn" onclick="selectUser1(1,'txtCNNAME','txtUSERID','txtLoginName');__doPostBack('lbSelectUser','');">
                                ...</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-label"><span style="color: red">*</span>姓名/Name:
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtCNNAME" runat="server" CssClass="validate[required]"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-label"><span style="color: red">*</span>登录账号/Account:
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtLoginName" runat="server" CssClass="validate[required]"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="td-label"><span style="color: red">*</span>公司/Company:
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtCOMPANYSUBID" runat="server" CssClass="validate[required]"></asp:TextBox>
                            <asp:TextBox ID="txtCompany" runat="server" CssClass="validate[required]"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr runat="server" id="tr1" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT01" runat="server" Text="EXT01"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT01" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr2" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT02" runat="server" Text="EXT02"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT02" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr3" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT03" runat="server" Text="EXT03"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT03" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr4" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT04" runat="server" Text="EXT04"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT04" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr5" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT05" runat="server" Text="EXT05"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT05" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr6" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT06" runat="server" Text="EXT06"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT06" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr7" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT07" runat="server" Text="EXT07"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT07" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr8" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT08" runat="server" Text="EXT08"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT08" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr9" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT09" runat="server" Text="EXT09"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT09" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr10" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT10" runat="server" Text="EXT10"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT10" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr11" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT11" runat="server" Text="EXT11"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT11" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr12" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT12" runat="server" Text="EXT12"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT12" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr13" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT13" runat="server" Text="EXT13"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT13" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr14" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT14" runat="server" Text="EXT14"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT14" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr15" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT15" runat="server" Text="EXT15"></asp:Label>
                        </td>
                        <td class="td-content">
                            <asp:TextBox ID="txtEXT15" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    
                </table>
                <div>
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="保存/Save" OnClick="btnSave_Click" />
                    <asp:Button ID="btnBack" runat="server" CssClass="btn" Text="关闭/Close" OnClientClick="closeWin();return false;" />
                </div>
            </div>

            <div class="hidden">
                <asp:LinkButton ID="lbSelectUser" runat="server" OnClick="lbSelectUser_Click"></asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>
