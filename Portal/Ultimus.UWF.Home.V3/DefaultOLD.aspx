<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultOLD.aspx.cs" Inherits="Ultimus.UWF.Home.V3.DefaultOLD" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("Default_ProjectTitle") %></title>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <style>
        body {
            background: #3d464d;
        }
    </style>

    <script type="text/javascript">
	 $(function () {

				localStorage.setItem("bpmSSO", 1);
			});
        function loadHeigth(ele) {
            ele.style.height = Math.max(ele.contentWindow.document.body.scrollHeight, ele.contentWindow.document.documentElement.scrollHeight, 600) + "px";
            document.getElementById("divContent").style.height = ele.style.height;
            document.getElementById("sidebar").style.height = ele.style.height;
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }

        function delCookies() {
            var keys=document.cookie.match(/[^ =;]+(?=\=)/g); 
            if (keys) {
                for (var i = keys.length; i--;)
                    document.cookie = keys[i] + '=0;expires=' + new Date(0).toUTCString()
            }
        }

        function confirms() {
            if (window.confirm('<%=Default_LogoutConfirm %>')) {
                //清除cookie
                delCookies();
                //清除后台添加的cookie
                return true;
            } else {
                return false;
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Start Page Loading -->
        <%--<div class="loading">
            <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/loading.gif" alt="loading-img">
        </div>--%>
        <!-- End Page Loading -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->
        <!-- START TOP -->
        <div id="top" class="clearfix">

            <!-- Start App Logo -->
            <div class="applogo" style="padding-top: 0px;">
                <a href="<%=DEFAULT_Home %>" target="content" class="logo">
                    <img src="<%=WebUtil.IncludeAssets("home_logo")%>" alt="Logo"></a>
            </div>
            <!-- End App Logo -->

            <!-- Start Sidebar Show Hide Button -->
            <a href="#" class="sidebar-open-button"><i class="fa fa-bars"></i></a>
            <a href="#" class="sidebar-open-button-mobile"><i class="fa fa-bars"></i></a>
            <!-- End Sidebar Show Hide Button -->

            <!-- Start Searchbox -->
            <div class="searchform">
                <input type="text" class="searchbox" id="searchbox" placeholder="<%=Lang.Get("btn_Search") %>">
                <a id="search" href="javascript:void(0);" onclick="openSearch();" target="content"><span class="searchbutton"><i class="fa fa-search"></i></span></a>
            </div>
            <%=GetTitle() %>
            <!-- End Searchbox -->

            <!-- Start Top Menu -->
            <!-- <ul class="topmenu">
      <li><a href="#">Files</a></li>
      <li><a href="#">Authors</a></li>
      <li class="dropdown">
        <a href="#" data-toggle="dropdown" class="dropdown-toggle">My Files <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">Videos</a></li>
          <li><a href="#">Pictures</a></li>
          <li><a href="#">Blog Posts</a></li>
        </ul>
      </li>
    </ul> -->
            <!-- End Top Menu -->

            <!-- Start Top Right -->
            <ul class="top-right" style="display: block">
       <%--         <li class="dropdown link hidden">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle hdbutton"><%=Lang.Get("Create New") %><span class="caret"></span></a>
                    <ul class="dropdown-menu dropdown-menu-list">
                        <asp:Repeater ID="rptFav" runat="server">
                            <ItemTemplate>
                                <li><a href="javascript:openForm('<%#Eval("VALUE") %>','<%=Request.QueryString["Type"] %>','',this);"><i class="fa falist fa-file-image-o"></i><%#Lang.Get(MyLib.ConvertUtil.ToString(Eval("Value")))%></a></li>
                            </ItemTemplate>
                        </asp:Repeater>

                        <li class="divider"></li>
                        <li><a href="NewTaskList.aspx" target="content"><i class="fa falist fa-list"></i><%=Lang.Get("Show All") %></a></li>
                    </ul>
                </li>--%>

                <%--<li class="link">
                    <a href="Default.aspx" class="notifications"><%=MYTASK_COUNT %></a>
                </li>--%>

                <li class="dropdown link ">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle profilebox">
                        <img src="../../common/assets/img/profileimg.jpg" id="profileimg" runat="server" alt="img">
                        <b class="hidden-xs"><%=User_FullName %></b><span class="caret"></span></a>
                    <ul class="dropdown-menu dropdown-menu-list dropdown-menu-right">
                        <li role="presentation" class="dropdown-header"><%=Lang.Get("PROFILE") %></li>
                        <li><a href="../Ultimus.UWF.OrgChart/PersonInfo.aspx" target="content"><i class="fa falist fa-wrench"></i><%=Lang.Get("Settings") %></a></li>
                        <li class="divider"></li>
                        <li id="liLogout" runat="server"><a href="login.aspx" onclick="return confirms();"><i class="fa falist fa-power-off"></i><%=Lang.Get("Default_Logout") %></a></li>
                    </ul>
                </li>

            </ul>
            <!-- End Top Right -->

        </div>
        <!-- END TOP -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->

        <%--<span class="caret"></span>--%>
        <!-- //////////////////////////////////////////////////////////////////////////// -->
        <!-- START SIDEBAR -->
        <div class="sidebar sidebar-colorful clearfix" id="sidebar">
            <asp:Repeater ID="rptFirstMenu" runat="server" OnItemDataBound="rptFirstMenu_ItemDataBound">
                <ItemTemplate>
                    <ul class="sidebar-panel nav <%#Eval("EXT04") %>">
                        <li class="sidetitle " style="cursor: pointer;" id="ul_<%#Container.ItemIndex+1 %>"><%#Eval("MappingName") %></li>
                        <asp:Repeater ID="rptSecondMenu" runat="server" OnItemDataBound="rptSecondMenu_ItemDataBound">
                            <ItemTemplate>
                                <li class="<%#Eval("EXT04") %>"><a onclick="showSidebar(this);" href="<%#GetUrl(Eval("URL"),Eval("EXT01"),Eval("MappingName")) %>" target="<%#Eval("TARGET") %>"><span class="<%#Eval("EXT02") %>"><i class="<%#Eval("EXT03") %>"></i></span><%#Eval("MappingName") %><span class='caret' id="spanArrow" runat="server"></span><span class="label label-danger" id="spanCount" runat="server"><%=MYTASK_COUNT %></span><span class="label label-danger" id="readsCount" runat="server"><%=READS_COUNT %></span></a>
                                    <asp:Repeater ID="rptThirdMenu" runat="server">
                                        <HeaderTemplate>
                                            <ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li class="<%#Eval("EXT04") %>"><a onclick="showSidebar(this);" href="<%#GetUrl(Eval("URL"),Eval("EXT01"),Eval("MappingName")) %>" target="<%#Eval("TARGET") %>"><%#Eval("MappingName") %></a></li>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </ItemTemplate>
            </asp:Repeater>

        </div>

        <!-- END SIDEBAR -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->


        <!-- //////////////////////////////////////////////////////////////////////////// -->
        <!-- START CONTENT -->
        <div class="content" id="divContent">
            <iframe id="frmContent" name="content" src="Blank.aspx" style="width: 100%;" height="600" scrolling="no" frameborder="0" onload='loadHeigth(this);'></iframe>
        </div>
        <!-- End CONTENT -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->

    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script type="text/javascript">


        function openSearch() {
            var s = $("#searchbox").val();
            var url = "TaskList.aspx?s=" + s;
            $("#search").attr("href", url);
        }

        $("#searchbox").keydown(function (event) {
            if (event.keyCode == 13) {
                openSearch();
                event.preventDefault();
                //return false;
            }
        });

        function openForm(taskId, type, serverName, ele) {
            var sheight = screen.height - 150;
            var swidth = screen.width - 10;
            var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
            s = window.open('../Ultimus.UWF.Workflow/OpenForm.aspx?ProcessName=' + encodeURI(taskId) + '&Type=NEWREQUEST&ServerName=', '', winoption);

            s.focus();
        }

        function showSidebar(ele) {
            if (ele.href.indexOf("javascript:void(0)") >= 0) {
            }
            else {
                if ($(".sidebar-open-button-mobile").is(":visible") == false) {
                }
                else {
                    $("#sidebar").hide();
                }
            }

        }

        $(document).ready(function () {
            $("#frmContent").attr("src", "<%=DEFAULT_Home%>");
            //左边菜单栏点击事件
            clickMenuEvent();
        });

        //左边菜单栏显示、隐藏控制   albert by 2017/12/12 add
        var clickMenuEvent = function () {
            $('.sidetitle').on('click', function (e) {
                var currClickId = $(this).attr('id');
                $('.sidetitle').each(function (index, item) {
                    var eulId = 'ul_' + (index + 1);
                    //判断当前点击菜单Id与菜单列表Id是否相同
                    if (eulId == currClickId) {
                        $(item).nextAll().toggle();//.css('display', 'none');
                    }
                })
            })
        }

        function refreshCount() {
            //延迟3秒刷新
            setTimeout("AsyncRefreshCount();", 3000);
        }

        function AsyncRefreshCount() {
            $.get("Handler/TaskRefresh.ashx", function (data) {
                $("#rptFirstMenu_ctl00_rptSecondMenu_ctl01_spanCount").text(data);
                try {
                    document.getElementById("frmContent").contentWindow.document.getElementById("frmLink").contentWindow.document.getElementById("lblCount").innerText = data;
                } catch (e) { }
            });
        }


    </script>
</body>
</html>
