<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportList.aspx.cs" Inherits="Ultimus.UWF.Home.V3.ReportList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("title_ReportList") %></title>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <!-- Start Page Header -->

            <div class="page-header">

                <h1 class="title ">
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-file-text-o"></i></span>
                    <%=Lang.Get("Report") %></h1>
           <%--     <ol class="breadcrumb">
                    <li class="active"><%=Lang.Get("TaskList_Desc")%></li>
                </ol>--%>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                         <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-th-large"></i><%=Lang.Get("TaskList_ProcessCategory") %> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <asp:Repeater ID="Repeater1" runat="server"  onitemcommand="Repeater1_ItemCommand">
                                <ItemTemplate>
                                <li><asp:LinkButton ID="lbCategory" runat="server" 
                                    CommandArgument='<%#Eval("CATEGORYNAME") %>'>
                                    <%#Eval(Lang.Get("CategoryNameField")) %></asp:LinkButton></li>
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
                            
                            <div class="hidden panel-title">
                                <i class="fa fa-bars"></i>
                                Report <%=Lang.Get("ListInfo") %>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>

                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%">
                                    <thead>
                                        <tr>
                                            <td class="text-center" data-orderable="false">
                                                <input id="Checkbox1" type="checkbox" class="hidden" onclick="selectAll('tasklist', this)"/>

                                            </td>
                                            <td><%=Lang.Get("TaskList_ProcessName") %></td>
                                            <td class="hidden-xs"><%=Lang.Get("TaskList_ProcessCategory")%></td>
                                        </tr>
                                    </thead>
                                    <tbody class="cursor-pointer">
                                        <asp:Repeater ID="rptTask" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="text-center" style="padding-top: 10px" >
                                                        <div class="hidden">
                                                        </div>

                                                        <span class="basic-list image-list">
                                                            <img src="../../Common/Assets/img/site/flow.png" alt="img" class="img">
                                                            <%--<img src="../../Common/Assets/img/site/flow.png<%#GetImage(Eval("PROCESSNAME")) %>" alt="img" class="img">--%>
                                                        </span>
                                                    </td>

                                                    <td onclick="javascript:openForm('<%#GetNamespace(Eval("PROCESSNAME")) %>',this);">
                                                         <%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#GetNamespace(Eval("PROCESSNAME")) %>',this);"><%#GetCategory(Eval("PROCESSNAME")) %></td>

                                                   
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
        function openForm(processName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            //s = window.open('../../Solution/'+processName+'/Report/ReportList.aspx', '', winoption);
            //s.focus();
            let url = '../../Solution/'+processName+'/Report/ReportList.aspx';
            location.href = url;
        }

        $(document).ready(function () {
            $('#tasklist').DataTable({
                "order": [[1, "asc"]],
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

        });

    </script>

</body>
</html>
