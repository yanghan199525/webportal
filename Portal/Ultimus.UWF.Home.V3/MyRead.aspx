<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyRead.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MyRead" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("title_MyTaskList1")%></title>
    <script src="js/taskstatus.js" type="text/javascript"></script>
    <script type="text/javascript">
        var tasktitle = "<%=Lang.Get("TaskStatus_Title") %>";
    </script>
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
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-eye"></i></span>
                    <%=Lang.Get("MyRead")%></h1>
                <%--   <ol class="breadcrumb">
                    <li class="active"><%=Lang.Get("MYTASKLIST_DESC")%></li>
                </ol>--%>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                        <a onclick="$('#searchPanel').toggle();" class="btn btn-light"><i class="fa fa-search"></i></a>

                    </div>
                </div>
            </div>
            <!-- End Page Header -->

            <!-- //////////////////////////////////////////////////////////////////////////// -->
            <!-- START CONTAINER -->
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

                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_StepName")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtStepName" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-xs-12" hidden="hidden">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_Incident")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtIncident" runat="server" CssClass="form-control"></asp:TextBox>
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
                                            <%=Lang.Get("TaskList_Summary")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <asp:TextBox ID="txtSummary" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8 col-sm-8 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-3  col-xs-3">
                                            <%=Lang.Get("TaskList_Status")%>:
                                        </div>
                                        <div class="col-md-9  col-xs-9">
                                            <ult:radiobuttonlist id="rdStatus" runat="server">
                                               
                                            </ult:radiobuttonlist>
                                        </div>
                                    </div>
                                </div>
                                <div class="center">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" />
                                    <%--<input type="reset" class="btn"  value="<%=Lang.Get("btn_Reset") %>">--%>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- End Row -->

                <!-- Start Panel -->
                <div class="row" id="div_taskList">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <%--   <div class="panel-title">
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
                                            <td class="text-center hidden" data-orderable="false">
                                                <input id="Checkbox1" type="checkbox" onclick="selectAll('tasklist', this)" />
                                            </td>
                                            <td data-orderable="false" style="min-width: 35px"><%=Lang.Get("TaskList_Monitor")%></td>
                                            <td class="hidden"><%--<%=Lang.Get("TaskList_Incident")%>--%></td>
                                            <td style="min-width: 140px"><%=Lang.Get("TaskList_ProcessName")%></td>
                                            <td><%=Lang.Get("TaskList_Summary") %></td>
                                            <td class="hidden-xs" style="min-width: 90px"><%=Lang.Get("TaskList_StepName")%></td>
                                            <td class="hidden-xs" style="min-width: 120px"><%=Lang.Get("TaskList_StartTime")%></td>
                                            <td class="hidden-xs" style="min-width: 50px"><%=Lang.Get("TaskList_Status")%></td>
                                            <td class="hidden-xs" style="min-width: 80px"><%=Lang.Get("TaskList_Applicant")%></td>
                                        </tr>
                                    </thead>

                                    <tbody class="cursor-pointer" id="taskRows">
                                        <asp:Repeater ID="rptTask" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="text-center hidden">
                                                        <asp:CheckBox ID="cbSelect" runat="server" />
                                                        <div class="hide">
                                                            <%#Eval("TaskID")%>
                                                            <asp:HiddenField ID="hfTaskid" runat="server" Value='<%# Eval("TaskID")%>' />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="btn btn-icon btn-sm " id='spStep_<%# Container.ItemIndex+1 %>' onmouseover="showTaskSteps(this,'<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>','<%#Eval("INCIDENT")%>','<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(Eval("ServerName")).Trim())%>');" onmouseout="hideTaskSteps(this);"
                                                            onclick="window.open('TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>&Incident=<%#Eval("INCIDENT")%>&TaskId=<%#Eval("TaskId") %>&ServerName=<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(Eval("ServerName")).ToString().Trim())%>&t=<%=Guid.NewGuid().ToString()%>');">
                                                            <i class="fa fa-line-chart"></i></span>
                                                    </td>
                                                    <td class="hidden" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                        <%--  <%#Eval("INCIDENT")%>--%>

                                                    </td>
                                                    <td onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                        <%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%><br>
                                                        <td onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                            <span class="" title='<%#Eval("SUMMARY")%>'><%#Eval("SUMMARY").ToString().Trim().Length>68?Eval("SUMMARY").ToString().Trim().Substring(0,67)+"...":Eval("SUMMARY").ToString().Trim()%></span></td>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                        <%#Eval("STEPLABEL")%></td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                        <%#Convert.ToDateTime(Eval("STARTTIME")).ToString("yyyy/MM/dd HH:mm:ss")%>
                                                        <%--<span class="color2"><%#Convert.ToDateTime(Eval("OVERDUETIME")) == DateTime.MinValue ? "" : Convert.ToDateTime(Eval("OVERDUETIME")).ToString("yyyy/MM/dd HH:mm:ss")%></span>--%>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                        <%# getIncidentsStatus(Eval("PROCESSNAME").ToString(),Eval("INCIDENT").ToString()) %></td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>',this);">
                                                        <span><%#Eval("APPLICANTNAME")%></span></td>
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
        function openForm(taskId, type, serverName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=MYREAD&ServerName=' + serverName, '', winoption);

            s.focus();

            try {
                //ele.parentNode.style.display = 'none';
            }
            catch (e) {
            }

        }

        $(document).ready(function () {
            $('#tasklist').DataTable({
                "order": [[6, "asc"]],
                "info": false,
                "filter": true,
                "pageLength": 10,
                "lengthChange": false,
                "searching": false,
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

    </script>

</body>
</html>
