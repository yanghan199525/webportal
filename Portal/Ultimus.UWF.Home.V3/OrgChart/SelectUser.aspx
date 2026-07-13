<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectUser.aspx.cs" Inherits="Ultimus.UWF.OrgChart.SelectUser" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <base target="_self"/>
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="PRAGMA" content="NO-CACHE" />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <title><%=Lang.Get("SelectUser") %></title>

    <%=WebUtil.IncludeFiles() %>
    <script type="text/javascript">
        $(function () {
            $("input[id$=RadioButton1]").attr("name", "username");
        });

        function SinglePersonConfirm(tnJson) {
            if ($("#hidSelectType").val() == "1") {
            }
            else {
                return true;
            }
            var returnJson = "";
            returnJson += "[";

            var isok = false;
            $("#tbody").find("tr").each(function () {
                if ($(this).find("td:eq(0)").children().attr("checked")) {
                    returnJson += "{'Name':'" + $.trim($(this).find("td:eq(1)").text()) + "',";
                    returnJson += "'Type':'USER',";
                    returnJson += "'LoginName':'" + $.trim($(this).find("td:eq(4)").text()).replace(/\\/g, "/") + "',";
                    returnJson += "'ID':'" + $.trim($(this).find("td:eq(5)").children().val()) + "'},";
                }
            });

            returnJson = returnJson + tnJson;
            if (returnJson.lastIndexOf(",") > 0) {
                returnJson = returnJson.substring(0, returnJson.lastIndexOf(","));
            }

            returnJson += "]";
        if (window.opener != undefined) {
                setValue(returnJson);
		//create by bai 2017/12/13
		if ('<%=Request.QueryString["IsMethod"]%>' === 'DIY') {
                    window.opener.ReturnPageDIY();
                }
                if ('<%=Request.QueryString["IsMethod"]%>' == 'True') {	
                   window.opener.ReturnPageIsMethod();
                }

                window.close();
            }
        }

        function Confirm(tnJson) {
            var returnJson = "";
            returnJson += "[";
            $("#tab tr").each(function () {
                returnJson += "{'Name':'" + $.trim($(this).find("td:eq(1)").text()) + "',";
                returnJson += "'Type':'USER',";
                returnJson += "'LoginName':'" + $.trim($(this).find("td:eq(4)").text()) + "',";
                returnJson += "'ID':'" + $.trim($(this).find("td:eq(5)").children().val()) + "'},";
            });
            returnJson = returnJson + tnJson;
            if (returnJson.lastIndexOf(",") > 0) {
                returnJson = returnJson.substring(0, returnJson.lastIndexOf(","));
            }

            returnJson += "]";
            if (window.opener != undefined) {
                setValue(returnJson);
                window.close();
            }
        }

        function setValue(val) {
            if (val) {
                val = val.replace(/\\/g, "/");
                var obj = eval(val);
                var names = "";
                var ids = "";
                var accs = "";
                if (obj) {
                    for (i = 0; i < obj.length; i++) {
                        if (i == 0) {
                            names += obj[i].Name;
                            ids += obj[i].ID + "|" + obj[i].Type;
                            accs += obj[i].LoginName;
                        }
                        else {
                            names += "," + obj[i].Name;
                            ids += "," + obj[i].ID + "|" + obj[i].Type;
                            accs += "," + obj[i].LoginName;
                        }
                    }
                }
                try {
                    window.opener.document.getElementById('<%=Request.QueryString["nameCtl"]%>').value = names;
                }
                catch (e) {
                }
                try {
                    window.opener.document.getElementById('<%=Request.QueryString["idCtl"]%>').value = ids;
                }
                catch (e) {
                }
                try {
                    window.opener.document.getElementById('<%=Request.QueryString["accountCtl"]%>').value = accs;
                }
                catch (e) {
                }
                try {
                    window.opener.setUser('<%=Request.QueryString["nameCtl"]%>',names);
                 }
                 catch (e) {
                 }
            }
        }

        function CheckSelectItem() {
            var isok = false;
            $("#tbody").find("tr").each(function () {
                if ($(this).find("td:eq(0)").children().attr("checked")) {
                    isok = true;
                }
            });
            if (!isok) {
                return false;
            } else {
                return true;
            }
        }

        function Cancel() {
            var isok = false;


            $("#tab").find("tr").each(function () {
                if ($(this).find("td:eq(0)").children().attr("checked")) {
                    isok = true;
                }
            });
            if (!isok) {
            } else {
                if (confirm('<%=Lang.Get("ConfirmCancel") %>')) {
                                                return true;
                                            }
                                        }
                                        return false;
        }

        function CloseForm() {
            window.close();
        }

        function setScroll() {
            document.getElementById("txtTVScroll").value = document.getElementById("divTv").scrollTop;
            document.getElementById("txtUserScroll").value = document.getElementById("divUser").scrollTop;
        }

        function restoreScroll() {
            document.getElementById("divTv").scrollTop = "<%=__tvScroll%>";    
            document.getElementById("divUser").scrollTop = "<%=__userScroll%>";    
        }
        

    </script>
</head>
<body style="overflow-x: hidden; overflow-y: hidden;" onload="restoreScroll()">
    <form id="form1" runat="server" defaultbutton="btnSearch"  onsubmit="setScroll()">
        <div>
            <div class="pt10 pb10 pl10">
                <asp:TextBox ID="txtSearch" runat="server" Width="500"></asp:TextBox>
                <asp:Button
                    ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
            </div>
            <div id="divTv" style="float: left; width: 240px; margin-left: 5px; height: 450px; overflow: scroll;">
                <asp:TreeView ID="tvDepartment" runat="server" 
                    ShowExpandCollapse="true" ShowLines="true" OnSelectedNodeChanged="tvDepartment_SelectedNodeChanged">
                    <NodeStyle BorderStyle="None" ImageUrl="../../common/assets/img/DepartIcon.png" />
                    <SelectedNodeStyle Font-Bold="True" ImageUrl="../../common/assets/img/DepartIcon.png" />
                </asp:TreeView>
            </div>
            <div style="float: left; width: 545px; height: 450px;" >
                <div style="overflow-x: hidden; overflow-y: scroll; height: 230px;" id="divUser"
                    runat="server">
                    <table class=" table table-hover table-bordered table-condensed listTable" style="width: 545px; overflow: hidden;">
                        <thead>
                            <tr class="bg">
                                <th width="50px">
                                    <%=Lang.Get("Select") %>
                                </th>
                                <th width="150px">
                                    <%=Lang.Get("Login_UserName")%>
                                </th>
                                <th width="150px">
                                    <%=Lang.Get("PersonInfo_JobFunction")%>
                                </th>
                                <th width="200px">
                                    <%=Lang.Get("Department")%>

                                </th>
                            </tr>
                        </thead>
                        <tbody id="tbody">
                            <asp:Repeater ID="rptUser" runat="server" OnItemDataBound="rptUser_ItemDataBound">
                                <ItemTemplate>
                                    <tr id='<%# Container.ItemIndex+1 %>' class="TableDataRow">
                                        <td width="29px">
                                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="Button1_Click" />
                                            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="username" />
                                        </td>
                                        <td width="148px">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                        </td>
                                        <td width="156px">
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("JobFunction") %>'></asp:Label>
                                        </td>
                                        <td width="212px">
                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                        </td>
                                        <td style="display: none;">
                                            <asp:Label ID="UserAccount" runat="server" Text='<%# Eval("LoginName") %>' />
                                        </td>
                                        <td style="display: none;">
                                            <asp:HiddenField ID="UserID" runat="server" Value='<%# Eval("UserID") %>' />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div style="overflow: hidden;   width: 545px;">
                    <table class="listTable" style="width: 545px; overflow: hidden;">
                        <tr>
                            <td>
                                <asp:Button ID="btnSelect" runat="server" CssClass="btn btn-warning" OnClientClick="return CheckSelectItem()"
                                     Visible="false" />
                                
                                <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClientClick="return Cancel()"
                                    OnClick="btnCancel_Click"  Visible="false" />
                                 
                                <div class="right">
                                    <asp:Button ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="btn btn-primary "
                                         OnClientClick="return SinglePersonConfirm('');" />
                                    <input type="button" class="btn" id="btnClose" runat="server" onclick="CloseForm()"  />
                                </div>
                                 
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="SelectedList" runat="server" visible="false"   class="pt5">
                    <div style="height: 185px; overflow-x: hidden; overflow-y: scroll;">
                        <table class="table table-hover table-bordered table-condensed listTable" style="width: 545px; overflow: hidden;">
                            <thead>
                                <tr class="bg">
                                    <th width="50px">
                                    <%=Lang.Get("Select") %>
                                </th>
                                <th width="150px">
                                    <%=Lang.Get("Login_UserName")%>
                                </th>
                                <th width="150px">
                                    <%=Lang.Get("PersonInfo_JobFunction")%>
                                </th>
                                <th width="200px">
                                    <%=Lang.Get("Department")%>

                                </th>
                                </tr>
                            </thead>
                            <tbody id="tab">
                                <asp:Repeater ID="rptSelected" runat="server">
                                    <ItemTemplate>
                                        <tr id='<%# Container.ItemIndex+1 %>' class="TableDataRow">
                                            <td>
                                                <asp:CheckBox ID="CheckBox2" runat="server" />
                                            </td>
                                            <td>
                                                <%# Eval("UserName")%>
                                            </td>
                                            <td>
                                                <%# Eval("JobFunction")%>
                                            </td>
                                            <td>
                                                <%# Eval("Department") %>
                                            </td>
                                            <td style="display: none;">
                                                <asp:Label ID="UserAccount" runat="server" Text='<%# Eval("LoginName") %>' />
                                            </td>
                                            <td style="display: none;">
                                                <asp:HiddenField ID="UserID" runat="server" Value='<%# Eval("UserID") %>' />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hidSelectType" runat="server" />
        <div class="hidden">
            <asp:TextBox ID="txtTVScroll" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtUserScroll" runat="server"></asp:TextBox>
        </div>
    </form>
</body>
</html>
