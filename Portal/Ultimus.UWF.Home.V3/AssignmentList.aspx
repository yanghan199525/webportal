<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssignmentList.aspx.cs"
    Inherits="Ultimus.UWF.Home.V3.AssignmentList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Lang.Get("AssignmentList_Title")  %></title>
    <%=WebUtil.IncludeFiles() %>
    <%--<script type="text/javascript" src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/Assets/js/selectorNew.js"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <div class="container-default">
                <table border="0" class="table table-border">
                    <tr class="banner hidden">
                        <td rowspan="1" colspan="4" style="text-align: left;" class="well">
                            <%=Lang.Get("AssignmentList_Title")   %>
                        </td>
                    </tr>
                    <tr align="center" valign="middle" class=" hidden">
                        <td rowspan="2" class="td-label" valign="middle">
                            <%=Lang.Get("AssignmentList_AssignType")   %>
                        </td>
                        <td rowspan="2">
                            <div>
                                <table border="0">
                                    <tr style="border: 0;">
                                        <td style="border: 0;">
                                            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="AssignType" Checked="true" />
                                        </td>
                                        <td style="border: 0;">
                                            <label for="RadioButton1">
                                                <%= Lang.Get("AssignmentList_SelectTaskAssign") %></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: 0;">
                                            <asp:RadioButton ID="RadioButton3" runat="server" GroupName="AssignType" />
                                        </td>
                                        <td style="border: 0;">
                                            <label for="RadioButton3">
                                                <%=Lang.Get("AssignmentList_FutureTasksAssign")  %></label>
                                        </td>
                                    </tr>
                                    <tr class="<%=EnableProcessAssign%>">
                                        <td style="border: 0;">
                                            <asp:RadioButton ID="RadioButton4" runat="server" GroupName="AssignType" />
                                        </td>
                                        <td style="border: 0;">
                                            <label for="RadioButton4">
                                                <%=Lang.Get("AssignmentList_ProcessAssign")  %></label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                        <td rowspan="1" class="hidden">
                            <%=Lang.Get("frm_Queue_process")   %>
                        </td>
                        <td rowspan="1" class="hidden">
                            <asp:DropDownList ID="dropProcessName" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="1" class="hidden">
                            <%=Lang.Get("Assign_AssignUser")  %>
                        </td>
                        <td rowspan="1" class="hidden">
                            <input id="txtAssignUser" type="text" runat="server" class="inputborder160" readonly="readonly" />
                            <input class="btn" type="button" value="..." onclick="SelectUser({ type: '1', txtName: 'txtAssignUser', txtId: 'txtAssignUserAccount' });" />
                            <input id="txtAssignUserAccount" type="hidden" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:Button ID="Button1" runat="server" CssClass="btn Button hidden" OnClick="Button1_Click" />
                            <asp:Button ID="Button3" runat="server" CssClass="btn Button hidden" OnClientClick="return ResetSearchValue()" />
                            <script type="text/javascript">
                                function ResetSearchValue() {
                                    document.getElementById("RadioButton1").setAttribute("checked", "checked");
                                    var options = document.getElementById("dropProcessName").children;
                                    options[0].setAttribute("selected", "selected");
                                    document.getElementById("txtAssignUser").value = "";
                                    document.getElementById("txtAssignUserAccount").value = "";
                                    document.getElementById("Button1").click();
                                    return false;
                                }
                            </script>
                            <asp:Button ID="Button4" runat="server" CssClass="btn Button" OnClientClick="return confirm('Confirm callback?');"
                                OnClick="Button4_Click" />
                            <asp:Button ID="Button5" runat="server" CssClass="btn Button hidden" OnClientClick="return GoBack()" />
                            <script type="text/javascript">
                                function GoBack() {
                                    window.location.href = "MyTasklist.aspx";
                                    return false;
                                }

                                function changeStatus(ele) {
                                    $("input[type='checkbox']").attr("checked", ele.checked);
                                }
                            </script>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="task" runat="server" Visible="false">
                    <table class="table table-border">
                        <tr class="TableHeader">
                            <th align="left">
                                <input type="checkbox" runat="server" onclick="changeStatus(this)" />
                            </th>
                            <th>
                                <%=Lang.Get("TaskList_ProcessName")%>
                            </th>
                            <th>
                                <%=Lang.Get("TaskList_Summary")%>
                            </th>
                            <th>
                                <%=Lang.Get("TaskList_StepName")%>
                            </th>
                            <th>
                                <%=Lang.Get("Assign_AssignUser1")%>
                            </th>
                        </tr>
                        <tbody id="tbody1">
                            <asp:Repeater ID="TaskList" runat="server">
                                <ItemTemplate>
                                    <tr class="TableDataRow">
                                        <td>
                                            <input type="checkbox" runat="server" id="Task_checkbox" value='<%# Eval("TASKID") %>' />
                                        </td>
                                        <td>
                                            <%# Eval("PROCESSNAME")%>
                                        </td>
                                        <td>
                                            <%# GetDisplaySummary(MyLib.ConvertUtil.ToString( Eval("SUMMARY")))%>
                                        </td>
                                        <td>
                                            <%# Eval("STEPLABEL")%>
                                        </td>
                                        <td>
                                            <%#GetUserCN(Eval("ASSIGNEDTOUSER").ToString())%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </asp:Panel>
                <asp:Panel ID="FutureTasks" runat="server" Visible="false">
                    <table class="table table-border">
                        <tr class="TableHeader">
                            <th></th>
                            <th>流程名 Process Name
                            </th>
                            <th>步骤名称 Step Name
                            </th>
                            <th>代理人 Assignee
                            </th>
                            <th>到期时间 Due Time
                            </th>
                        </tr>
                        <tbody id="tbody3">
                            <asp:Repeater ID="FutureTasksList" runat="server">
                                <ItemTemplate>
                                    <tr class="TableDataRow">
                                        <td>
                                            <input type="checkbox" runat="server" id="FutureTasksList_checkbox" />
                                        </td>
                                        <td>
                                            <asp:Label ID="FutureTasksList_ProcessName" runat="server" Text='<%# Eval("PROCESSNAME")%>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="FutureTasksList_StepName" runat="server" Text='<%# Eval("STEPLABEL")%>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="FutureTasksList_AssignedToUser" runat="server" Text='<%# Eval("ASSIGNEDTOUSER")%>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="FutureTasksList_Assignuntil" runat="server" Text='<%# Eval("ASSIGNUNTIL")%>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </asp:Panel>
                <asp:Panel ID="Processes" runat="server" Visible="false">
                    <table class="table table-condensed table-bordered">
                        <tr>
                            <th></th>
                            <th>流程名 Process Name
                            </th>
                            <th>代理人 Assignee
                            </th>
                            <th>开始时间 Begin Date
                            </th>
                            <th>结束时间 End date
                            </th>
                        </tr>
                        <tbody id="tbody4">
                            <asp:Repeater ID="ProcessesList" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <input id="Processes_checkbox" type="checkbox" runat="server" value='<%# Eval("ID") %>' />
                                        </td>
                                        <td>
                                            <%# Eval("ProcessName")%>
                                        </td>
                                        <td>
                                            <%# Eval("TskAssignUser")%>
                                        </td>
                                        <td>
                                            <%# Eval("BgDate")%>
                                        </td>
                                        <td>
                                            <%# Eval("EdDate")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </asp:Panel>
            </div>

        </div>
    </form>
</body>
</html>
