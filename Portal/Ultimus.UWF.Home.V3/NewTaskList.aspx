<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewTaskList.aspx.cs" Inherits="Ultimus.UWF.Home.V3.NewTaskList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("title_NewTaskList")%></title>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <style>
        table.dataTable tbody th, table.dataTable tbody td {
            padding-top: 5px !important;
            padding-bottom: 5px !important;
            vertical-align: middle !important;
        }

        .table th, .table tbody td, .table td {
            padding-top: 5px !important;
            padding-bottom: 5px !important;
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
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-edit"></i></span>
                    <%=Lang.Get("NewRequest")%></h1>
              <%--  <ol class="breadcrumb">
                    <li class="active"><%=Lang.Get("NewTaskList_Desc")%></li>
                </ol>--%>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-th-large"></i><%=Lang.Get("TaskList_ProcessCategory")%> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                                <ItemTemplate>
                                    <li>
                                        <asp:LinkButton ID="lbCategory" runat="server"
                                            CommandArgument='<%#Lang.GetLang().ToLower() == "en-us" ? Eval("CATEGORYENNAME") : Eval("CATEGORYNAME")%>'>
                                    <%#Eval(Lang.Get("CategoryNameField"))%></asp:LinkButton></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>

                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                    </div>
                </div>


            </div>
            <!-- End Page Header -->

            <!-- //////////////////////////////////////////////////////////////////////////// -->
            <!-- START CONTAINER -->
            <div class="container-default">

                <!-- Start Panel -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">

            <%--                <div class="panel-title">
                                <i class="fa fa-bars"></i>
                                <%=Lang.Get("ListInfo")%>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>--%>

                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%">
                                    <thead>
                                        <tr>
                                            <td class="text-center" data-orderable="false"></td>
                                            <td><%=Lang.Get("TaskList_ProcessName")%></td>
                                            <td class="hidden-xs" ></td>
                                            <td class="hidden-xs"><%=Lang.Get("TaskList_ProcessCategory")%></td>
                                            <td data-orderable="false"><%=Lang.Get("Default_Fav")%></td>
                                            <td data-orderable="false"><%=Lang.Get("Help")%></td>
                                        </tr>
                                    </thead>
                                    <tbody class="cursor-pointer">
                                        <asp:Repeater ID="rptTask" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="text-center" style="padding-top: 10px" onclick="window.open('TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>&Incident=<%#Eval("INCIDENT")%>&TaskId=<%#Eval("TaskId") %>&ServerName=<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(Eval("ServerName")).Trim())%>&t=<%=Guid.NewGuid().ToString()%>');">
                                                        <div class="hidden">
                                                            <%#Eval("TaskID")%>
                                                            <asp:HiddenField ID="hfTaskid" runat="server" Value='<%# Eval("TaskID")%>' />
                                                        </div>

                                                        <span class="basic-list image-list">
                                                            <img src="<%#GetImage(Eval("PROCESSNAME"))%>" alt="img" class="img">
                                                        </span>
                                                    </td>

                                                    <td onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName")%>','<%#Eval("StepLabel")%>',this);"><%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%></td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName")%>','<%#Eval("StepLabel")%>',this);"><%#Eval("Summary")%></td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName")%>','<%#Eval("StepLabel")%>',this);"><%#GetCategory(Eval("PROCESSNAME"))%></td>

                                                    <td>
                                                        <span class="btn btn-icon btn-sm btn-light" onclick="addFav(this,'<%# Eval("TaskID")%>','<%# Eval("PROCESSNAME")%>');"><i class="<%#GetFavorite(Eval("PROCESSNAME"))%>"></i></span>

                                                    </td>
                                                    <td>
                                                        <span class="btn btn-icon btn-sm btn-light" onclick="openHelp(this,'<%# Eval("TaskID")%>','<%# Eval("PROCESSNAME")%>');"><i class="fa fa-question"></i></span>

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
        </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>

    <script type="text/javascript">
        function openForm(taskId, type, serverName, processName, stepName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=NEWREQUEST&ServerName=' + serverName + '&ProcessName=' + encodeURI(processName) + '&StepName=' + encodeURI(stepName), '', winoption);

            s.focus();
        }

        $(document).ready(function () {
            $('#tasklist').DataTable({
                //"order": [[1, "asc"]],
                "ordering": false, // 禁止排序
                "info": true,
                "filter": true,
                "pageLength": 7,
                "searching": false,
                "lengthChange": false,
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
        });

        function addFav(ele, taskId, processName) {
            css = $(ele).find(".fa").attr("class");
            if (css == "fa fa-star-o") {
                $.post('newtasklist.aspx', { method: "addfav", taskId: taskId, processName: processName },
                    function (text, status) {
                        if (text == "ok") {
                            $(ele).find(".fa").attr("class", "fa fa-star color9");
                        }
                    });
            }
            else {
                $.post('newtasklist.aspx', { method: "removefav", taskId: taskId, processName: processName },
                    function (text, status) {
                        if (text == "ok") {
                            $(ele).find(".fa").attr("class", "fa fa-star-o");
                        }
                    });
            }
        }

        function openHelp(ele, taskId, processName) {
            window.open("OpenHelp.aspx?processname=" + processName);
        }

    </script>

</body>
</html>
