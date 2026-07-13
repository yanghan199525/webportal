<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CorrelationList.aspx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.CorrelationList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_AssociatedProcess")%></title>
    <script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Portal/Ultimus.UWF.Home.V3/js/taskstatus.js" type="text/javascript"></script>
    
    <%=WebUtil.IncludeCssV3() %>
    <style>
        .close_ioc {
            display: inline-block;
            font-size: 3.5rem;
            font-weight: 700;
            line-height: 3.5rem;
            float: right;
            margin-top: -7px;
            cursor: pointer;
            text-shadow: 0 1px 1px rgba(0,0,0,.1);
            -o-transform: rotate(45deg);
            -moz-transform: rotate(45deg);
            -webkit-transform: rotate(45deg);
            -ms-transform: rotate(45deg);
        }

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
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-edit"></i></span>
                    <%=Lang.Get("AP_Form_AssociatedProcess") %>
                </h1>
                <%--         <ol class="breadcrumb">
                    <li class="active"><%=Lang.Get("TaskList_Desc") %></li>
                </ol>--%>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                        <a onclick="$('#searchPanel').toggle();" class="btn btn-light"><i class="fa fa-search"></i></a>
                    </div>
                </div>
            </div>
            <!-- End Page Header -->
            <!-- START CONTAINER -->
            <div class="container-default">
                <!-- Start Row -->
                <div class="row" id="searchPanel">
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
                                <div class="col-md-8 col-sm-6 col-xs-12">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" />
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
                            <div class="panel-title hidden">
                                <i class="fa fa-bars"></i>
                                <%=Lang.Get("ListInfo") %>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>
                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%">
                                    <thead>
                                        <tr>
                                            <td class="text-center hidden-xs" data-orderable="false">
                                                <input id="Checkbox1" type="checkbox" onclick="selectAll('tasklist', this)" />
                                            </td>
                                            <td data-orderable="false" style="min-width: 30px"><%=Lang.Get("TaskList_Monitor") %></td>
                                            <td class="hidden hidden-xs" style="min-width: 50px"><%=Lang.Get("TaskList_Incident") %></td>
                                            <td style="min-width: 150px"><%=Lang.Get("TaskList_ProcessName") %></td>
                                            <td><%=Lang.Get("TaskList_Summary") %></td>
                                            <td class="hidden-xs" style="min-width: 165px"><%=Lang.Get("TaskList_StartTime") %></td>
                                            <td class="hidden-xs" style="min-width: 80px"><%=Lang.Get("TaskList_Applicant")%></td>
                                        </tr>
                                    </thead>
                                    <tbody class="cursor-pointer">
                                        <asp:Repeater ID="rptTask" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="text-center hidden-xs">
                                                        <asp:CheckBox ID="cbSelect" runat="server" />
                                                        <div class="hide">
                                                            <%#Eval("TaskID") %>
                                                            <asp:HiddenField ID="hfTaskid" runat="server" Value='<%# Eval("TaskID") %>' />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="btn btn-icon btn-sm " id='spStep_<%#Eval("TaskID")%>' onmouseover="showTaskSteps(this,'<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>','<%#Eval("INCIDENT")%>','<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(Eval("ServerName")).Trim())%>');" onmouseout="hideTaskSteps(this);"
                                                            onclick="window.open('<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Portal/Ultimus.UWF.Home.V3/TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>&Incident=<%#Eval("INCIDENT")%>&TaskId=<%#Eval("TaskId")%>&ServerName=<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(Eval("ServerName")).ToString().Trim())%>&t=<%=Guid.NewGuid().ToString()%>');">
                                                            <i class="fa fa-line-chart"></i></span>
                                                    </td>
                                                    <td class="hidden hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID") %>','<%=Request.QueryString["Type"] %>','<%#Eval("ServerName") %>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this,'<%#Eval("PROCESSSTATUS").ToString() %>');">
                                                        <%#Eval("INCIDENT")%></td>
                                                    <td onclick="javascript:openForm('<%#Eval("TaskID") %>','<%=Request.QueryString["Type"] %>','<%#Eval("ServerName") %>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this,'<%#Eval("PROCESSSTATUS").ToString() %>');">
                                                        <%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%><br>
                                                    </td>
                                                    <td onclick="javascript:openForm('<%#Eval("TaskID") %>','<%=Request.QueryString["Type"] %>','<%#Eval("ServerName") %>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this,'<%#Eval("PROCESSSTATUS").ToString() %>');">
                                                        <span class="" title='<%#Eval("DisplaySummary")%>'><%#Eval("DisplaySummary").ToString().Length>68?Eval("DisplaySummary").ToString().Substring(0,67)+"...":Eval("DisplaySummary").ToString()%></span></td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID") %>','<%=Request.QueryString["Type"] %>','<%#Eval("ServerName") %>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this,'<%#Eval("PROCESSSTATUS").ToString() %>');">
                                                        <%#Convert.ToDateTime(Eval("STARTTIME")).ToString("yyyy/MM/dd HH:mm:ss")%>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <%#GetUserCN(Eval("INITIATOR").ToString())%></td>
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
        var tasktitle = "<%=Lang.Get("TaskStatus_Title") %>";
        function Abort() {
            var iFlag = true;
            $("#tab tr").each(function () {
                if ($(this).find("td:eq(0)").children().attr("checked")) {
                    if ($(this).find("div[id=status]")[0].innerText == "已完成"
                    || $(this).find("div[id=status]")[0].innerText == "终止"
                    || $(this).find("div[id=status]")[0].innerText == "Completed"
                    || $(this).find("div[id=status]")[0].innerText == "Abort"
                    ) {
                        iFlag = false;
                        alert('<%=Lang.Get("TaskList_CanNotCancel") %>');
                        return false;
                    }
                }
            });
            return window.confirm('<%=Lang.Get("ConfirmAbort") %>');
        }

        function changeStatus() {
            $("input[type='checkbox']").attr("checked", "true");
        }

        function openForm(taskId, type, serverName, processName, stepName, ele, processStatus) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=MYREQUEST&ServerName=' + serverName + '&processStatus=' + processStatus + '&ProcessName=' + encodeURI(processName) + '&StepName=' + encodeURI(stepName), '', winoption);
            s.focus();
            if ($('#txtType').val() == 'mytask') {
                try {
                    ele.parentNode.parentNode.style.display = 'none';
                }
                catch (e) {
                }
            }
        }

        $(document).ready(function () {
            $('#tasklist').DataTable({
                "order": [[6, "asc"]],
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
            $("#tasklist_filter input").focus();
        });

        function correlationList() {
            var taskids = "";
            $("#tasklist tr").each(function () {
                if ($(this).find("td:eq(0)").find("[type=checkbox]").prop("checked")) {
                    taskids += "'" + $(this).find("[type=hidden]").val() + "',";
                }
            });
            if (taskids != "") {
                taskids = taskids.substring(0, taskids.lastIndexOf(","));
            }
            var datat = {
                method: "InsertAssociatedProcess", formid: request("formid"), ProcessName: request("ProcessName"), Incident: request("Incident"),
                StepName: request("StepName"), USERNAME: request("USERNAME"), taskids: taskids, parseInt: request("parseInt")
            };
            $.ajax({
                url: "UploadAssociatedProcessHandler.ashx?t=<%=Guid.NewGuid().ToString()%>",
                type: "POST",
                data: datat,
                cache: false,
                async: false,
                dataType: 'html',
                success: function (data) {
                    if (data != null && data != "") {
                        $(window.parent.document.getElementById("fileinfo_AssociatedProcess")).append(data);;
                    }
                }
            })
        }

        //鼠标移上去显示流程审批详细步骤
        function showTaskSteps(e, processName, incident, serverName) {
            //获取流程详细步骤
            var vDataToHtml = getTaskStepsHtmlData(e.id, processName, incident, serverName);
            //弹出框
            $('#' + e.id).popover({
                html: true,
                title: tasktitle,
                animation: false,
                content: vDataToHtml,//测试：'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
                container: false,
                trigger: 'manual',
                placement: 'right',
                container: 'body'
            });
            $('#' + e.id).popover('show');
        }

        //鼠标离开隐藏流程审批详细步骤
        function hideTaskSteps(e) {
            $('#' + e.id).popover('hide');
        }

        //获取任务表详细步骤，转换为html显示
        function getTaskStepsHtmlData(id, processName, incident, serverName) {
            var shtml;
            $.ajax({
                url: "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Portal/Ultimus.UWF.Home.V3/TaskStepsOverview.ashx?ProcessName=" + processName + "&Incident=" + incident + "&ServerName=" + serverName,
                cache: true,
                async: false,
                dataType: 'html',
                success: function (data) {
                    shtml = data;
                }
            })
            return shtml;
        }

    </script>

</body>
</html>
