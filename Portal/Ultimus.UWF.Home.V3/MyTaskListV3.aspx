<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyTaskListV3.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MyTaskListV3" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("title_MyTaskList") %></title>
    <script src="js/taskstatus.js" type="text/javascript"></script>
    <script type="text/javascript">
        var tasktitle = "<%=Lang.Get("TaskStatus_Title") %>";
    </script>
    <!-- ========== Css Files ========== -->
    <link href='/common/assets/css/bootstrap4.min.css' type='text/css' rel='stylesheet' />
    <link rel="stylesheet" href="css/matrix-style.css" />
    <link rel="stylesheet" href="css/matrix-media.css" />
    <link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
    <link rel="stylesheet" href="/Common/Assets/css/style.css" />
    <link rel="stylesheet" href="/Common/Assets/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/Common/AdminLTE/css/AdminLTE.css" />
    <link rel="stylesheet" href="/Common/Assets37/css/base.css" />

    <script src="/Common/Assets/js/jquery.min.js"></script>
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

        .four-grid {
            width: 110px;
        }

        .four-text h3 {
            font-size: 13px !important;
        }

        .four-grid i {
            font-size: 24px;
            color: white;
        }

        .four-agileits {
            padding: 0px;
            border-radius: 3px;
            box-shadow: darkgrey 2px 2px 2px 0px;
        }

        .modal-dialog  {
           z-index:1080;

        }
        .close  {
         position:absolute;
         right:18px;
         top:15px;
         padding:2px !important; 
        }
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <!-- Start Page Header -->
            <div class="page-header">
                <h1 class="title ">
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-envelope-o"></i></span>
                    <%=Lang.Get("DEFAULT_MYTASK")%></h1>
                <%--  <ol class="breadcrumb">
                    <li class="active"><%=Lang.Get("MYTASKLIST_DESC")%></li>
                </ol>--%>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <a onclick="javascript:assign();" class="btn btn-light"><i class="fa fa-share padding-r-5"></i><%=Lang.Get("TaskList_Assign") %></a>
                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                        <a onclick="$('#searchPanel').toggle();" class="btn btn-light"><i class="fa fa-search"></i></a>
                    </div>
                </div>
            </div>
            <!-- End Page Header -->
            <!-- //////////////////////////////////////////////////////////////////////////// -->
            <!-- START CONTAINER -->
            <div class="container-default">
                <div class="four-grids  hidden-xs  hidden-sm " style="margin-left: -14px; margin-bottom: 10px; margin-top: -15px;">
                    <asp:Repeater ID="rpProcessCategory" runat="server" OnItemCommand="rpProcessCategory_ItemCommand">
                        <ItemTemplate>
                            <div class="col-md-2 four-grid" style="padding-right: 10px">
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%#Eval("CATEGORYNAME")%>'>
                                <div class='four-agileits <%#Eval("EXT01") %>' id="ctl<%#MyLib.ConvertUtil.ToString( Eval("CATEGORYNAME")).Replace(" ","") %>" >
                                    <div class="four-text" style="padding-top:10px;"><i class='<%#Eval("EXT02") %>'></i></div>
                                    <div class="four-text" style="padding-bottom:5px;">
                                        <h3 class="progress-description">
                                                <%#Eval("MAPCATEGORYNAME")%>
                                            <%--(<%# getProcessCategoryCount(Eval("CATEGORYID").ToString()) %>)--%>
                                            (<%#Eval("CagegoryCount") %>)
                                        </h3>
                                    </div>
                                </div>                                    
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="clearfix"></div>
                </div>

                <!-- End Process Row -->

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
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="col-md-4 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <div class="col-md-5  col-xs-5">
                                                    <%=Lang.Get("TaskList_ProcessCategory")%>:
                                                </div>
                                                <div class="col-md-7  col-xs-7">
                                                    <asp:DropDownList ID="ddlProcessCategory" CssClass="form-control" runat="server"
                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlProcessCategory_SelectedIndexChanged">
                                                    </asp:DropDownList>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <div class="col-md-5  col-xs-5">
                                                    <%=Lang.Get("TaskList_ProcessName")%>:
                                                </div>
                                                <div class="col-md-7  col-xs-7">
                                                    <asp:TextBox ID="txtProcessName" runat="server" CssClass="form-control hidden"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlProcessName" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlProcessName_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <div class="col-md-5  col-xs-5">
                                                    <%=Lang.Get("TaskList_StepName")%>:
                                                </div>
                                                <div class="col-md-7  col-xs-7">
                                                    <asp:TextBox ID="txtStepName" runat="server" CssClass="form-control hidden"></asp:TextBox>
                                                    <asp:DropDownList ID="dllStepName" runat="server" CssClass="form-control"></asp:DropDownList>
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

                                        <div class="col-md-8 col-sm-6 col-xs-12" hidden="hidden">
                                            <div class="form-group">
                                                <div class="col-md-5  col-xs-5">
                                                    <%=Lang.Get("TaskList_Status")%>:
                                                </div>
                                                <div class="col-md-7  col-xs-7">
                                                    <span class="radio radio-primary inline">
                                                        <input runat="server" id="rdAll" type="radio" checked name="rdStatus">
                                                        <label for="rdAll">
                                                            <%=Lang.Get("TaskList_All")%>
                                                        </label>
                                                    </span>
                                                    <span class="radio radio-primary inline">
                                                        <input runat="server" id="rdActive" type="radio" name="rdStatus">
                                                        <label for="rdActive">
                                                            <%=Lang.Get("TaskStatus_Active")%>
                                                        </label>
                                                    </span>
                                                    <span class="radio radio-primary inline">
                                                        <input runat="server" id="rdComplete" type="radio" name="rdStatus">
                                                        <label for="rdComplete">
                                                            <%=Lang.Get("TaskStatus_Completed")%>
                                                        </label>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="center">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnReset" runat="server" CssClass="btn hidden" Text="Reset" OnClick="btnReset_Click" />
                                    <%-- <input type="reset" class="btn hidden" onclick="onReset()"  value="<%=Lang.Get("btn_Reset") %>">--%>
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
                            <div class="hidden panel-title">
                                <i class="fa fa-bars"></i>
                                <%=Lang.Get("ListInfo")%>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a id="li_expand" class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>
                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%" style="display: none">
                                    <thead>
                                        <tr>
                                            <td class="text-center hidden-xs" data-orderable="false" style="min-width: 20px">
                                                <input id="Checkbox1" type="checkbox" onclick="selectAll('tasklist', this)" />
                                            </td>
                                            <td data-orderable="false" style="min-width: 30px"><%=Lang.Get("TaskList_Monitor") %></td>
                                            <%-- <td class="hidden-xs" style="min-width: 50px"><%=Lang.Get("TaskList_Incident") %></td>--%>
                                            <td style="min-width: 140px"><%=Lang.Get("TaskList_ProcessName") %></td>
                                            <td><%=Lang.Get("TaskList_Summary") %></td>
                                            <td class="hidden-xs" style="min-width: 100px"><%=Lang.Get("TaskList_StepName") %></td>
                                            <td class="hidden-xs" style="min-width: 120px"><%=Lang.Get("TaskList_StartTime")%></td>
                                            <td class="hidden-xs" style="min-width: 50px"><%=Lang.Get("TaskList_Applicant")%></td>
                                        </tr>
                                    </thead>

                                    <tbody class="cursor-pointer" id="taskRows">
                                        <asp:Repeater ID="rptTask" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="text-center hidden-xs">
                                                        <asp:CheckBox ID="cbSelect" runat="server" />

                                                        <div class="hide">
                                                            <%#Eval("TaskID")%>
                                                            <asp:HiddenField ID="hfTaskid" runat="server" Value='<%# Eval("TaskID")%>' />
                                                        </div>

                                                    </td>
                                                    <td>
                                                        <span class="btn btn-icon btn-sm " id="spStep_<%#Eval("TaskID")%>" onmouseover="showTaskSteps(this,'<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>','<%#Eval("INCIDENT")%>','<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(Eval("ServerName")).Trim())%>');" onmouseout="hideTaskSteps(this);"
                                                            onclick="window.open('TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval("PROCESSNAME").ToString().Trim())%>&Incident=<%#Eval("INCIDENT")%>&TaskID=<%#Eval("TaskID")%>&ServerName=<%#Server.UrlEncode(MyLib.ConvertUtil.ToString(MyLib.ConvertUtil.ToString(Eval("ServerName")).Trim()))%>&t=<%=Guid.NewGuid().ToString()%>');">
                                                            <i class="fa fa-line-chart"></i></span>
                                                    </td>
                                                    <%--                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <%#Eval("INCIDENT")%>

                                                    </td>--%>
                                                    <td onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%><br>
                                                    </td>
                                                    <td onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <span class="" title='<%#Eval("DisplaySummary")%>'>
                                                            <%#MyLib.ConvertUtil.ToString( Eval("DisplaySummary")).Length>68? StringFilter.FilterHtmls(MyLib.ConvertUtil.ToString(Eval("DisplaySummary")).Substring(0,67))+"...":StringFilter.FilterHtmls(MyLib.ConvertUtil.ToString(Eval("DisplaySummary")))%>
                                                        </span>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <%# GetStepName(Eval("PROCESSNAME"),Eval("STEPLABEL"))%></td>
                                                    <td class="hidden-xs utcdatetime" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <%#Convert.ToDateTime(Eval("STARTTIME")).ToString("yyyy/MM/dd HH:mm:ss")%>
                                                        <%--<span class="color2"><%#Convert.ToDateTime(Eval("OVERDUETIME")) == DateTime.MinValue ? "" : Convert.ToDateTime(Eval("OVERDUETIME")).ToString("yyyy/MM/dd HH:mm:ss")%></span>--%>
                                                    </td>
                                                    <td class="hidden-xs" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName") %>','<%#Eval("StepLabel") %>',this);">
                                                        <%#Eval("APPLICANT")%></td>
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

        function assign() {
            var taskid = "";
            $("#taskRows tr").each(function () {
                if ($(this).find("td:eq(0)").find("[type=checkbox]").prop("checked")) {
                    val = $(this).find("[type=hidden]").val();
                    taskid += val + ",";
                }
            });
            if (taskid != "") {
                taskid = taskid.substring(0, taskid.lastIndexOf(","));
            }
            var PageName = "Assign.aspx";
            if (taskid != "") {
                PageName += "?TaskID=" + encodeURI(taskid);
            }

            //window.open(PageName, "javascript", "top=100,left=200,height=400,width=500");
            showForm({
                url: PageName,
                title: "指派",
                buttons: []
            });

            return false;
        }

        function delegation() {
            var taskid = "";
            $("#taskRows tr").each(function () {
                if ($(this).find("td:eq(0)").find("[type=checkbox]").prop("checked")) {
                    val = $(this).find("[type=hidden]").val();
                    taskid += val + ",";
                }
            });
            if (taskid != "") {
                taskid = taskid.substring(0, taskid.lastIndexOf(","));
            }
            var PageName = "delegation.aspx";
            if (taskid != "") {
                PageName += "?TaskID=" + encodeURI(taskid);
            }
            //window.open(PageName, "javascript", "top=100,left=200,height=400,width=500");
            showForm({
                url: PageName,
                title: "Delegation",
                buttons: [],
                height: 350

            });

            return false;
        }

        function back() {
            var PageName = "AssignmentList.aspx";
            location.href = location.href;
            return false;
        }

        function onReset() {
            $("#ddlProcessCategory").val('');
            $("#txtProcessName").val('');
            $("#txtStepName").val('');
            $("#txtSummary").val('');
            $("#txtIncident").val('');
            $("#txtStartDate").val('');
            $("#txtEndDate").val('');
        }

        function Abort() {
            var iFlag = true;
            $("#tab tr").each(function () {
                if ($(this).find("td:eq(0)").children().attr("checked")) {
                    //alert($(this).find("div[id=status]")[0].innerText);
                    if ($(this).find("div[id=status]")[0].innerText == "已完成"
                        || $(this).find("div[id=status]")[0].innerText == "终止"
                        || $(this).find("div[id=status]")[0].innerText == "Completed"
                        || $(this).find("div[id=status]")[0].innerText == "Abort"
                    ) {
                        iFlag = false;
                        alert('<%=Lang.Get("TaskList_CanNotCancel")%>');
                        return false;
                    }
                }
            });
            return window.confirm('<%=Lang.Get("ConfirmAbort")%>');
        }

        function Callback() {
            return window.confirm('<%=Lang.Get("ConfirmCallback")%>');
        }

        function approve() {
            return window.confirm('<%=Lang.Get("ConfirmApprove")%>');
        }

        function changeStatus() {
            $("input[type='checkbox']").attr("checked", "true");
        }

        //function openForm(taskId, type, serverName, processName, stepName, ele) {
        //    let url = 'Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=MYTASK&ServerName=' + serverName + '&ProcessName=' + encodeURI(processName) + '&StepName=' + encodeURI(stepName);
        //    location.href = url;
        //    try {
        //        ele.parentNode.style.display = 'none';
        //    }
        //    catch (e) {
        //    }
        //}

        function openForm(taskId, type, serverName, processName, stepName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=MYTASK&ServerName=' + serverName + '&ProcessName=' + encodeURI(processName) + '&StepName=' + encodeURI(stepName), '', winoption);
            s.focus();
            try {
                ele.parentNode.style.display = 'none';
            }
            catch (e) {
            }
        }

        $(document).ready(function () {
            let cate = $("#txtProcessCategory").val();
            cate = cate.replace(" ", "");
            if (!cate) {
                cate = "allprocess";
            }
            if (cate == "allprocess") {

            }
            else {
                $(".color21-bg").addClass("color16-bg").removeClass("color21-bg");
                $("#ctl" + cate).removeClass("color16-bg");
                $("#ctl" + cate).addClass("color21-bg");
            }

            $('#tasklist').DataTable({
                "order": [[5, "desc"]],
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

            $('#txtStartDate').daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });
            $('#txtEndDate').daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });

            $("#tasklist_filter input").focus();
            //window.parent.document.getElementById("rptFirstMenu_ctl00_rptSecondMenu_ctl01_spanCount").value = '<%=COUNT%>';
            window.parent.mytaskCount(<%=COUNT%>);
        });

    </script>

</body>
</html>
