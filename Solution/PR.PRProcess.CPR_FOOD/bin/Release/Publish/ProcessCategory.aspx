<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessCategory.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessCategory" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <base target="_self" />
    <%=WebUtil.IncludeFiles() %>
</head>
<body>
    <form id="form1" runat="server">
    <div class="row-fluid" style="overflow:auto;height:600px;"  >
        <table class="table table-bordered table-hover table-condensed" id="tab">
            <thead>
                <tr>
                    <th>
                        流程名
                    </th>
                     <th>
                        分类
                    </th>
                     <th>
                        英文分类
                    </th>
                    <th>
                        ICON
                    </th>
                    <th>
                    </th>
                </tr>
            </thead>
        <tbody>
            <asp:Repeater ID="rptTask" runat="server" OnItemCommand="rptTask_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <td >
                            <asp:Label ID="cbSelect" runat="server" Text='<%#Eval("ProcessName") %>' />
                        </td>
                     <td >
                            <asp:TextBox ID="Label1" runat="server" Text='<%#Eval("CategoryName") %>' />
                        </td>
                        <td >
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%#Eval("CategoryENName") %>' />
                        </td>
                        <td >
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%#Eval("ICON") %>' />
                        </td>
                        <td  >
                             <asp:Button ID="btnSet" runat="server" Text="保存" CssClass="btn" CommandName="set"
                                                ClientIDMode="Static"    />
                                                 <%--<asp:Button ID="btnCreateForm" Visible="false" runat="server" Text="生成表单" CssClass="btn" CommandName="form"
                                                ClientIDMode="Static"    />
                                                 <asp:Button ID="btnCreateFormAgain" runat="server" Text="生成表单" CssClass="btn" CommandName="formAgain"
                                                ClientIDMode="Static"  OnClientClick="return confirm('是否继续?');"   />--%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
        </table>
    </div>
    </form>
</body>
</html>
