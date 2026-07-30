<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowNextApprover.aspx.cs" Inherits="Ultimus.UWF.Workflow.ShowNextApprover" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <%=Ultimus.UWF.Common.Logic.WebUtil.IncludeCss() %>
</head>
<body>
    <form id="form1" runat="server">
        <div style="overflow:auto;height:300px;">
        <table id="tasklist" class="table  " >
            <thead>
                <tr>
                    
                    <td class="">No.</td>
                    <td class="">步骤名称</td>
                    <td class="">审批人</td>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptList" runat="server" >
                    <ItemTemplate>
                        <tr>
                            <td> <%# Container.ItemIndex+1 %></td>
                            <td><%#Eval("StepName") %></td>
                            <td><%#Eval("Approver") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table></div>
    </form>
</body>
</html>
