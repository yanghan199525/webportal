<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DraftList.aspx.cs" Inherits="Ultimus.UWF.Home.V3.DraftList" %>


<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("title_DraftList") %></title>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <style>
        table.dataTable tbody th, table.dataTable tbody td {
            padding-top: 7px !important;
            padding-bottom: 7px !important;
            vertical-align: middle !important;
        }

        .table th, .table tbody td, .table td {
            padding-top: 7px !important;
            padding-bottom: 7px !important;
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
                    <%=Lang.Get("DraftList_Title") %></h1>
                <%--  <ol class="breadcrumb">
                    <li class="active"><%=Lang.Get("DraftList_Desc") %></li>
                </ol>--%>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">

                        <%--<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-location-arrow"></i><%=Lang.Get("Action") %> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#"><i class="fa fa-share padding-r-5"></i><%=Lang.Get("TaskList_Assign") %></a></li>
                            <li><a href="#"><i class="fa fa-reply padding-r-5"></i><%=Lang.Get("TaskList_AssignCallback") %></a></li>
                            <li class="divider"></li>
                            <li><a href="javascript:changeStatus();"><i class="fa fa-check-square-o padding-r-5"></i><%=Lang.Get("SelectAll") %></a></li>
                        </ul>--%>

                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                        <a onclick="$('#searchPanel').toggle();" class="btn btn-light"><i class="fa fa-search"></i></a>
                    </div>
                </div>


            </div>
            <!-- End Page Header -->

            <!-- //////////////////////////////////////////////////////////////////////////// -->
            <!-- START CONTAINER -->
            <div class="container-default">
                <div class="row" id="searchPanel" style="display: none">
                    <div class="col-md-12">
                        <div class="panel panel-default ">
                            <div class="panel-title">
                                <i class="fa fa-search"></i>
                                <%=Lang.Get("SearchCriteria") %>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>

                            <div class="panel-body">
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_ProcessCategory")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:DropDownList ID="ddlProcessCategory" CssClass="form-control" runat="server"></asp:DropDownList>

                                        </div>
                                    </div>
                                </div>

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

                                <%-- <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_StepName")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtStepName" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>--%>

                                <%--                                <div class="col-md-4 col-sm-6 col-xs-12" hidden="hidden">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_Incident")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtIncident" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>--%>


                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_Summary")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtSummary" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("DraftBox_SaveTime")%>:
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
                                <%--                     <div class="col-md-8 col-sm-6 col-xs-12 hidden">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5" style="width: 155px;">
                                            <%=Lang.Get("TaskList_Status")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <span class="radio radio-primary inline">
                                                <input runat="server" id="rdAll" type="radio" checked name="rdStatus">
                                                <label for="rdAll">
                                                    <%=Lang.Get("TaskList_All") %>
                                                </label>
                                            </span>
                                            <span class="radio radio-primary inline">
                                                <input runat="server" id="rdActive" type="radio" name="rdStatus">
                                                <label for="rdActive">
                                                    <%=Lang.Get("TaskStatus_Active") %>
                                                </label>
                                            </span>
                                            <span class="radio radio-primary inline">
                                                <input runat="server" id="rdComplete" type="radio" name="rdStatus">
                                                <label for="rdComplete">
                                                    <%=Lang.Get("TaskStatus_Completed") %>
                                                </label>
                                            </span>
                                        </div>
                                    </div>
                                </div>--%>


                                <div class="center">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" />
                                    <%--<input type="reset" class="btn" value="<%=Lang.Get("btn_Reset") %>">--%>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Start Panel -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">

                            <%--                            <div class="panel-title">
                                <i class="fa fa-bars"></i>
                                <%=Lang.Get("ListInfo") %>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>--%>

                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%" style="display: none">
                                    <thead>
                                        <tr>
                                            <td class="text-center hidden" data-orderable="false">
                                                <input id="Checkbox1" type="checkbox" onclick="selectAll('tasklist', this)" />
                                            </td>
                                            <td data-orderable="false" style="min-width: 50px"><%=Lang.Get("TaskList_Monitor") %></td>
                                            <td style="min-width: 140px"><%=Lang.Get("TaskList_ProcessName") %></td>
                                            <td><%=Lang.Get("TaskList_Summary") %></td>
                                            <td class="hidden-xs" style="min-width: 160px"><%=Lang.Get("DraftBox_SaveTime") %></td>
                                            <td class="hidden-xs" style="min-width: 80px"><%=Lang.Get("Action")%></td>
                                        </tr>
                                    </thead>
                                    <tbody class="cursor-pointer">
                                        <asp:Repeater ID="rptTask" runat="server" OnItemCommand="rptTask_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="text-center hidden">
                                                        <asp:CheckBox ID="cbSelect" runat="server" />

                                                    </td>
                                                    <td>
                                                        <span class="btn btn-icon btn-sm " onclick="window.open('TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim()) %>&Incident=<%#Eval("INCIDENT") %>&TaskId=<%#Eval("TaskId") %>&ServerName=&t=<%=Guid.NewGuid().ToString() %>');"><i class="fa fa-line-chart"></i></span>
                                                    </td>

                                                    <td onclick="javascript:openForm('<%#Eval("TASKID") %>','<%#Eval("ProcessName") %>','<%#Eval("FORMID") %>','<%#Eval("Incident") %>','Draft','<%#Eval("ProcessName") %>','<%#Eval("StepName") %>',this);">
                                                        <%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%>
                                                    </td>
                                                    <td onclick="javascript:openForm('<%#Eval("TASKID") %>','<%#Eval("ProcessName") %>','<%#Eval("FORMID") %>','<%#Eval("Incident") %>','Draft','<%#Eval("ProcessName") %>','<%#Eval("StepName") %>',this);">
                                                        <span class="" title='<%#Eval("Summary")%>'>
                                                            <%#MyLib.ConvertUtil.ToString(Eval("Summary")).Length>50? StringFilter.FilterHtmls(Eval("Summary").ToString().Substring(0,49))+"...":StringFilter.FilterHtmls(MyLib.ConvertUtil.ToString(Eval("Summary")))%>
                                                        </span>
                                                    </td>
                                                    <%-- <%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("Summary")))%>--%>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TASKID") %>','<%#Eval("ProcessName") %>','<%#Eval("FORMID") %>','<%#Eval("Incident") %>','Draft','<%#Eval("ProcessName") %>','<%#Eval("StepName") %>',this);">
                                                        <%#Convert.ToDateTime(Eval("CREATEDATE")).ToString("yyyy/MM/dd HH:mm:ss")%>
                                                    </td>
                                                    <td class="hidden-xs">

                                                        <%-- <asp:Button ID="btnDelete" runat="server" Text='<%#GetDelName() %>'   CssClass="btn" CommandName="del"
                                    CommandArgument='<%#Eval("FormID") %>' ClientIDMode="Static" OnClientClick='return delConfirm();' ></asp:Button>--%>

                                                        <asp:LinkButton ID="lbDelete" runat="server" CssClass="btn btn-icon btn-sm"
                                                            CommandName="del"
                                                            CommandArgument='<%#Eval("FormID") %>' OnClientClick="return delConfirm();">
                                                    <i class="fa fa-trash"></i></asp:LinkButton>

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

                <!-- END CONTAINER -->
                <!-- //////////////////////////////////////////////////////////////////////////// -->

            </div>
            <!-- END CONTAINER -->
        </div>

        <div style="display: none">
            <asp:TextBox ID="txtSort" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtProcessCategory" runat="server"></asp:TextBox>
        </div>

    </form>
    <%=WebUtil.IncludeJsV3()%>

    <script type="text/javascript">

        //function openForm(taskId, processName, formId, incident, type, processName, stepName, ele) {
        //    let url = '../Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=' + type + '&ProcessName=' + escape(processName) + '&FORMID=' + formId + "&incident=" + incident + '&StepName=' + encodeURI(stepName);
        //    location.href = url;
        //}

        function openForm(taskId, processName, formId, incident, type, processName, stepName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('../Ultimus.UWF.Home.V3/Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=' + type + '&ProcessName=' + escape(processName) + '&FORMID=' + formId + "&incident=" + incident + '&StepName=' + encodeURI(stepName), '', winoption);
            s.focus();
        }

        $(document).ready(function () {
            $('#tasklist').DataTable({
                "order": [[4, "desc"]],
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
            $('#txtStartDate').daterangepicker({
                singleDatePicker: true,
                "showDropdowns": true,
                "locale": {
                    "format": "YYYY/MM/DD"
                }
            });
            $('#txtEndDate').daterangepicker({
                singleDatePicker: true,
                "showDropdowns": true,
                "locale": {
                    "format": "YYYY/MM/DD"
                }
            });
        });


        function delConfirm() {
            if (!confirm('<%=Lang.Get("SecurityList_ConfirmDelete")%>')) {
                return false;
            }

            return true;
        }
    </script>

</body>
</html>
