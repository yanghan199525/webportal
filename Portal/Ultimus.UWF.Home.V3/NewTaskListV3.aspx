<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewTaskListV3.aspx.cs" Inherits="Ultimus.UWF.Home.V3.NewTaskListV3" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Lang.Get("title_NewTaskList")%></title>
    <link href='/common/assets/css/bootstrap4.min.css' type='text/css' rel='stylesheet' />
    <link rel="stylesheet" href="css/matrix-style.css" />
    <link rel="stylesheet" href="css/matrix-media.css" />
    <link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
    <link rel="stylesheet" href="/Common/Assets/css/style.css" />
    <link rel="stylesheet" href="/Common/Assets/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/Common/AdminLTE/css/AdminLTE.css" />
    <link rel="stylesheet" href="/Common/Assets37/css/base.css" />

    <script src="/Common/Assets/js/jquery.min.js"></script>
    <%--<script src="../../Common/Assets37/js/jquery-3.3.1.min.js"></script>--%>
    <%--<script src="../../Common/Assets37/js/bootstrap.bundle.min.js"></script>--%>
    <%--<script src="../../Common/Assets37/js/metismenu.js"></script>
        <script src="../../Common/Assets37/js/scripts-init/app.js"></script>
        <script src="../../Common/Assets37/js/scripts-init/themes-option.js"></script>--%>


    <style type="text/css">
        body {
            font-family: 微软雅黑;
            background-color: rgb(238, 238, 238);
        }

        #rpProcessCategory li {
            border-radius: 50% !important;
        }

        #divTask li {
            min-height: 0px !important;
        }

        @media (min-width: 900px) {
            #divTask li {
                min-width: 20% !important;
            }
        }

        #divTask i[class^="icon-"] {
            float: left !important;
            margin-right: 10px !important;
            font-size: 20px !important;
        }

        .btn-liht {
            background-color: #fff;
            float: right !important;
            margin-top: 10px;
            margin-bottom: 7px;
            margin-right: 10px;
        }

        .btn-light:hover, .btn-light:focus {
            background-color: #f9f9f9 !important;
            color: inherit;
        }

        .btn-radius-left {
            border-top-left-radius: 3px !important;
            border-bottom-left-radius: 3px !important;
        }

        .btn-radius-right {
            border-top-right-radius: 3px !important;
            border-bottom-right-radius: 3px !important;
        }

        .txt-box:focus {
            outline: none !important;
            box-shadow: none !important;
            -moz-box-shadow: none !important;
        }

        .four-agileits {
            padding: 0px;
            border-radius: 3px;
            box-shadow: darkgrey 2px 2px 2px 0px;
            width: 100px;
        }

        .quick-actions li {
            min-width: 3%;
            margin-bottom: 0px;
        }

        .quick-actions {
            padding-left: 10px;
            padding-right: 10px;
        }


            .quick-actions li a i[class^="icon-"], .quick-actions li a i[class*=" icon-"] {
                font-size: 24px !important;
            }

            .quick-actions li a {
                padding: 12px 0px 0px 0px !important;
                font-size: 13px;
            }

        @media (max-width: 767px) {
            .hidden-xs {
                display: none !important;
            }
        }

        @media (min-width: 768px) and (max-width: 991px) {
            .hidden-sm {
                display: none !important;
            }
        }

        a:hover {
            text-decoration: none;
        }

        a:visited {
            text-decoration: none;
        }

        .btn-link:hover {
            text-decoration: none;
        }

        .btn-link:visited {
            text-decoration: none;
        }

        .widget-heading {
            font-size: 16px;
            color: #000;
        }

            .widget-heading:hover {
                color: #0056b3;
            }

        .card.mb-3 {
            margin-bottom: 20px !important;
        }

        .btn-link {
            font-weight: 400;
            color: #3f6ad8;
            padding-left: 0px;
            padding-right: 0px;
            padding-top: 0px;
            text-decoration: none;
            opacity: 0.6 !important;
        }

        .btn-link:hover {
                color: #0056b3;
                text-decoration: none;
        }

        .widget-chart:hover .widget-chart-actions .btn-link, .widget-content:hover .widget-chart-actions .btn-link {
            opacity: 1 !important;
        }

        .btn-link:hover {
            background-color: #fff;
        }

        .widget-chart-actions {
            top: 2px !important;
            /*right:0px !important;*/
        }

        .nav-item:hover {
            background-color: #fff !important;
        }

        .task {
            padding-left: 0px !important;			
        }

        input, select {
            height: 34px;
            border-radius: 3px;
            padding-left: 10px;
            font-size: 14px;
            background: #fff;
            border: 1px solid #BDC4C9;
            box-shadow: inset 0px 1px 0px #F1F0F1;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <!-- Start Page Header -->
        <div class="page-header " style="margin: 0px 0 -10px 0;">
            <h1 class="title">
                <span class="btn btn-rounded btn-default btn-icon cursor-default" style="border-radius: 999px; background-color: #399bff; color: #fff;">
                    <i class="fa fa-edit"></i></span>
                <span class="btn" style="font-size:14px;"> <%=Lang.Get("NewRequest")%></span></h1>
            <div class="right">
                <div class="btn-group" role="group" aria-label="...">
                    <%--<button type="button" class="btn btn-light btn-radius-left dropdown-toggle" data-toggle="dropdown" aria-expanded="false" >
                        <i class="fa fa-th-large"></i><%=Lang.Get("TaskList_ProcessCategory")%> <span class="caret"></span>
                    </button>--%>

                    <asp:TextBox runat="server" ID="txt_process"
                        Style="height: 34px; margin: 0; border: 1px solid #E8EBED; border-right: 0px;width:80px;" CssClass="txt-box"
                        placeholder="流程名称"></asp:TextBox>
                    <asp:LinkButton ID="LinkButton1" Style="background-color: #fff" runat="server" CssClass="btn btn-light" OnClick="LinkButton1_Click">
                        <i class="fa fa-search"></i></asp:LinkButton>
                    <a href="javascript:location.href=location.href;" class="btn btn-light" style="background-color: #fff"><i class="fa fa-refresh"></i></a>
                </div>
            </div>
            <!-- End Page Header -->
        </div>
        <div class="container-default">
            <div class="row">
                <div class="col-md-12" style="padding-right: 0px;">
                    <div class="" style="border: 0; border-radius: 4px; /*min-height: 500px; */">
                        <div class="container-fluid hidden-xs hidden-sm  hidden-md" style="padding-left: 10px;">
                            <div class="quick-actions_homepage">
                                <ul class="quick-actions">
                                    <asp:Repeater ID="rpProcessCategory" runat="server" OnItemCommand="Repeater1_ItemCommand">
                                        <ItemTemplate>
                                            <li class='<%#Eval("EXT01") %> four-agileits' id="ctl<%#Lang.GetLang().ToLower() == "en-us" ?MyLib.ConvertUtil.ToString( Eval("CATEGORYNAME")).Replace(" ","") :MyLib.ConvertUtil.ToString( Eval("DISPLAYNAME")).Replace(" ","")%>">
                                                <asp:LinkButton ID="lbCategory" runat="server" CommandArgument='<%#Lang.GetLang().ToLower() == "en-us" ? Eval("CATEGORYNAME") : Eval("DISPLAYNAME")%>'>
                                                <i class='<%#Eval("EXT02") %>'></i> <%#Lang.GetLang().ToLower() == "en-us" ? Eval("CATEGORYNAME") : Eval("DISPLAYNAME")%>
                                                </asp:LinkButton>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                       
                        <div class="container-fluid task" id="divTask"      style="padding-left:10px;margin-top:14px;background-color:white;">
                            <div class="quick-actions_homepage" style="padding-left:10px;margin-top:3px;background-color:rgb(238, 238, 238);">
                                <ul class="quick-actions">
                                    <asp:Repeater ID="rptTask" runat="server">
                                        <ItemTemplate>
                                            <div class="col-md-4 col-lg-3">
                                                <div class="card mb-3 widget-chart text-left">
                                                    <div class="widget-chart-actions">
                                                        <div class="btn-group dropdown hidden">
                                                            <button type="button" aria-haspopup="true" style="z-index: 100;"
                                                                aria-expanded="false" data-toggle="dropdown" class="btn btn-link " title=""
                                                                onclick="addFav(this,'<%# Eval("TaskID")%>','<%# Eval("PROCESSNAME")%>');">
                                                                <i class="fav <%#GetFavorite(Eval("PROCESSNAME"))%>"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <div class="icon-wrapper rounded-circle" style="cursor: pointer" onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName")%>','<%#Eval("StepLabel")%>',this);">
                                                        <div class="<%#GetProcessbg(Eval("PROCESSNAME")) %>"></div>
                                                        <i class="<%#GetImage(Eval("PROCESSNAME"))%>"></i>
                                                    </div>
                                                    <div class="widget-chart-content" style="cursor: pointer"
                                                        onclick="javascript:openForm('<%#Eval("TaskID")%>','<%=Request.QueryString["Type"]%>','<%#Eval("ServerName")%>','<%#Eval("ProcessName")%>','<%#Eval("StepLabel")%>',this);">
                                                        <div class="widget-heading">
                                                            <%# Lang.GetLang().ToString().ToUpper() == "EN-US" ? MyLib.ConvertUtil.ToString(Eval("PROCESSENNAME")) : MyLib.ConvertUtil.ToString(Eval("PROCESSCNNAME")) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: none;">
            <asp:TextBox runat="server" ID="txtProcessCategory"></asp:TextBox>
        </div>
    </form>

    <script type="text/javascript">
        $(function () {

            $("#rpProcessCategory li").each(function (i, dom) {
                $(dom).attr("width", $(dom).attr("height"));
            });

            if ('<%=Lang.GetLang()%>'.toUpperCase() == "EN-US") {
                $("#txt_process").attr("placeholder", "Process Name");
            }
        })

        $(document).ready(function () {
            $(".icon-star").parent().css("opacity", "1 !important");

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
        });

        function addFav(ele, taskId, processName) {
            css = $(ele).find(".fav").attr("class");
            if (css == "fav icon-star-empty") {

                //$.ajax({
                //    url: "newtasklistv3",
                //    type: "post",
                //    dataType: "json",
                //    data: { method: "addfav", taskId: taskId, processName: processName },
                //    success: function (text) {
                //        if (text == "ok") {
                //            $(ele).find(".fav").attr("class", "fav icon-star");
                //        }
                //    },
                //    error: function (e) {
                //    }
                //});

                $.post('newtasklistv3', { method: "addfav", taskId: taskId, processName: processName },
                    function (text, status) {
                        if (text == "ok") {
                            $(ele).find(".fav").attr("class", "fav icon-star");
                        }
                    });

            }
            else {
                if ($("#txtProcessCategory").val() == "收藏" || $("#txtProcessCategory").val() == "Favorite")
                    $(ele).parent().hide();
                $.post('newtasklistv3', { method: "removefav", taskId: taskId, processName: processName },
                    function (text, status) {
                        if (text == "ok") {
                            $(ele).find(".fav").attr("class", "fav icon-star-empty");
                        }
                    });
            }
        }

        //function openForm(taskId, type, serverName, processName, stepName, ele) {
        //    var sheight = screen.height - 150;
        //    var swidth = screen.width - 10;
        //    var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";

        //    let url = 'Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=NEWREQUEST&ServerName=' + serverName + '&ProcessName=' + encodeURI(processName) + '&StepName=' + encodeURI(stepName);
        //    location.href = url;
        //    //s = window.open(url, '', winoption);
        //    //s.focus();
        //}

        function openForm(taskId, type, serverName, processName, stepName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=NEWREQUEST&ServerName=' + serverName + '&ProcessName=' + encodeURI(processName) + '&StepName=' + encodeURI(stepName), '', winoption);

            s.focus();
        }
    </script>
</body>
</html>
