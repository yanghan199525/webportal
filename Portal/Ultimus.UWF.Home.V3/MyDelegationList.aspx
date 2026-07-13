<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDelegationList.aspx.cs"
    Inherits="Ultimus.UWF.Home.V3.MyDelegationList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("title_SetupAgent") %></title>
    <%=WebUtil.IncludeCssV3() %>
    <style>
        table.dataTable tbody th, table.dataTable tbody td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
            vertical-align: middle !important;
        }

        .table th, .table tbody td, .table td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
            vertical-align: middle !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <!-- Start Page Header -->
            <div class="page-header">
                <h1 class="title ">
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-save"></i></span>
                    <%=Lang.Get("Delegation") %></h1>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <a href="javascript:location.href='MyDelegation.aspx';" class="btn btn-light"><%=Lang.Get("Delegation") %></a>
                        <asp:LinkButton ID="Button4" runat="server" CssClass="btn btn-light" OnClientClick="return CheckPage()" OnClick="Button4_Click"></asp:LinkButton>
                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                        <a onclick="$('#searchPanel').toggle();" class="btn btn-light"><i class="fa fa-search"></i></a>
                    </div>
                </div>
            </div>
            <div class="container-default">
                <!-- Start Row -->
                <div class="row" id="searchPanel" style="display: none">
                    <div class="col-md-12">
                        <div class="panel panel-default ">
                            <div class="panel-title">
                                <i class="fa fa-search"></i>
                                <%=Lang.Get("SearchCriteria")%>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>

                            <div class="panel-body">
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_ProcessName")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtProcessName" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("Assign_AssignUser1")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtAssignUser" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_Status")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <span class="radio radio-primary inline">
                                                <input runat="server" id="rdActive" type="radio" value="1" checked name="rdStatus">
                                                <label for="rdActive">
                                                    Enable
                                                </label>
                                            </span>
                                            <span class="radio radio-primary inline">
                                                <input runat="server" id="rdDisable" type="radio" value="0" name="rdStatus">
                                                <label for="rdDisable">
                                                    Disable
                                                </label>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_StartTime")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <div class="input-prepend input-group">
                                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="add-on input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            -
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <div class="input-prepend input-group">
                                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="add-on input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" />
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
                <!-- End Row -->
                <!-- Start Panel -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%" style="display: none">
                                    <thead>
                                        <tr>
                                            <td class="text-center hidden-xs" data-orderable="false">
                                                <input type="checkbox" name="cb_SelectAll" onclick="selectAllList('tasklist', this);" />
                                            </td>
                                            <td style="min-width: 140px">
                                                <%=Lang.Get("TaskList_ProcessName")%>
                                            </td>
                                            <td>
                                                <%=Lang.Get("Assign_AssignUser1")%>
                                            </td>
                                            <td class="hidden-xs">
                                                <%=Lang.Get("TaskList_StartTime")%>
                                            </td>
                                            <td class="hidden-xs">
                                                <%=Lang.Get("TaskStatus_EndTime")%>
                                            </td>
                                            <td>
                                                <%=Lang.Get("TaskList_Status")%>
                                            </td>
                                             <td>
                                                原因
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody class="cursor-pointer">
                                        <asp:Repeater ID="ProcessesList" runat="server">
                                            <ItemTemplate>
                                                <tr style="height: 35px;">
                                                    <td class="text-center hidden-xs">
                                                        <input id="Processes_checkbox" class="zgcheck" status='<%# Eval("STATUS")%>' type="checkbox" runat="server" value='<%# Eval("STATUS") %>' />
                                                    </td>
                                                    <td>
                                                        <%#Eval("PROCESSCNNAME")%>
                                                        <asp:Label CssClass="hidden" ID="lblProcessName" runat="server" Text='<%#MyLib.ConvertUtil.ToString(Eval("ProcessName")).Trim()%>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <%# Eval("ASSIGNEDTONAME")%>
                                                        <asp:Label CssClass="hidden" ID="lblASSIGNEDTOUSER" runat="server" Text='<%# Eval("ASSIGNEDTOUSER").ToString()%>'></asp:Label>
                                                    </td>
                                                    <td class="hidden-xs">
                                                        <asp:Label ID="lblASSIGNFROM" runat="server" Text='<%#  Convert.ToDateTime(Eval("ASSIGNFROM")).ToString("yyyy-MM-dd HH:mm:ss")%>'></asp:Label>
                                                    </td>
                                                    <td class="hidden-xs">
                                                        <asp:Label ID="Label1" runat="server" Text=' <%# Convert.ToDateTime(Eval("ASSIGNUNTIL")).ToString("yyyy-MM-dd HH:mm:ss")%>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text=' <%# Eval("STATUS").ToString()=="1"?"启用":Eval("STATUS").ToString()=="0"?"停用":"处理中"%>'></asp:Label>
                                                        <!--启用 停用 处理中-->
                                                    </td>
                                                     <td>
                                                        <asp:Label ID="Label3" runat="server" Text=' <%#Eval("REMARK").ToString()==""?"":Eval("REMARK").ToString()%>'></asp:Label>
                                                        <!--启用 停用 处理中-->
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
                <!-- End Panel -->
            </div>
        </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script type="text/javascript">
        //选择所有行
        function selectAllList(tabId, allCheck) {
            debugger;
            var tabCtl = document.getElementById(tabId);
            var checkBox = tabCtl.getElementsByTagName('input');
            for (var i = 1; i < checkBox.length; i++) {
                if ($(checkBox[i]).attr("status") != "1")
                    continue;
                if (allCheck.checked == true) {
                    checkBox[i].checked = true;
                } else {
                    checkBox[i].checked = false;
                }
            }
        }
        function CheckPage() {
            return confirm('Confirm?');
        }
        $(document).ready(function () {
            $('#tasklist').DataTable({
                "order": [[3, "desc"]],
                "info": true,
                "filter": true,
                "pageLength": 10,
                "lengthChange": false,
                "searching": false,
                "initComplete": function (settings, json) {
                    $("#tasklist").css("display", "");
                },
                "oLanguage": {
                    "sZeroRecords": "<%=Lang.Get("Form_sZeroRecords") %>",
                    "sInfo": "<%=Lang.Get("Form_sInfo") %>", //总记录数
                    "sInfoEmpty": "",
                    "oPaginate": {
                        "sFirst": "<%=Lang.Get("Form_First") %>",
                        "sPrevious": "<%=Lang.Get("Form_Previous") %>",
                        "sNext": "<%=Lang.Get("Form_Next") %>",
                        "sLast": "<%=Lang.Get("Form_Last") %>"
                    }
                }
            });

            $("#tasklist_filter input").focus();
            $('#txtStartDate').daterangepicker({
                singleDatePicker: true,
                "showDropdowns": true,
                "locale": {
                    "format": "YYYY/MM/DD HH/mm/ss"
                }
            });
            $('#txtEndDate').daterangepicker({
                singleDatePicker: true,
                "showDropdowns": true,
                "locale": {
                    "format": "YYYY/MM/DD HH/mm/ss"
                }
            });

            var Text = document.getElementsByClassName("zgcheck");
            for (var i = 0; i < Text.length; i++) {
                if (Text[i].value == "0") {
                    //Text[i].style.display = "none";
                    Text[i].disabled = "disabled";

                }
            }
        });
    </script>
</body>
</html>
