<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MobileBlank.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MobileBlank" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title><%=Lang.Get("Default_ProjectTitle") %></title>
    <script type="text/javascript" src='<%=WebUtil.GetRootPath()%>/Common/Assets/js/jquery.min.js'></script>

    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <style>
        #MobileDiv {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            height: 700px;
            /*overflow: hidden;*/
        }

        #spanCount {
            position: absolute;
            right: 0;
            top: 5px;
        }
    </style>

    <script type="text/javascript">

        $(function () {
            var bottomHeight = document.getElementById("bottomNav").clientHeight;
            var CenterHeight = document.documentElement.clientHeight - bottomHeight + "px";
            //var TitelHeight = document.getElementById("MobileTitel").clientHeight;
            //var CenterHeight = document.documentElement.clientHeight - bottomHeight - TitelHeight + "px";
            $("#MobileDiv").css("height", CenterHeight);
            window.addEventListener('message', function (e) {
                document.getElementById("frmContent").style.height = e.data["height"];
            }, false);
        })


        function loadBottomHeight(obj) {
            obj.style.height = document.getElementById("bottomNav").offsetHeight + "px";
        }
        //待办
        function OpenNewTask() {
            var width = document.body.clientWidth + "px";
            $("#frmContent").attr("src", "MyTaskListV3.aspx?OpenType=Mobile");
            $("#frmContent").css("width", width);
            $("#txtMainPage").css("color", "#989898");
            $("#txtNewTask").css("color", "black");
            $("#txtMyApproval").css("color", "#989898");
            $("#txtOtherPage").css("color", "#989898");
            $("#NewTask").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/NewTask2.png");
            $("#NewTask").find("img").css("width", "20px");
            $("#NewTask").find("img").css("height", "20px");
            $("#MainPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MainPage.png");
            $("#MyApprovl").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyTask.png");
            $("#OtherPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyRequest.png");

        }
        //新建申请
        function OpenManinPage() {
            var width = document.body.clientWidth + "px";
            $("#frmContent").attr("src", "NewTaskListV3.aspx?OpenType=Mobile&MobileType=Mobile");
            $("#frmContent").css("width", width);
            $("#txtMainPage").css("color", "black");
            $("#txtNewTask").css("color", "#989898");
            $("#txtMyApproval").css("color", "#989898");
            $("#txtOtherPage").css("color", "#989898");
            $("#NewTask").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/NewTask.png");
            $("#MainPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MainPage2.png");
            $("#MyApprovl").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyTask.png");
            $("#OtherPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyRequest.png");

        }
        //已办
        function OpenMyApprovl() {
            var width = document.body.clientWidth + "px";
            $("#frmContent").attr("src", "MyApprovalList.aspx?OpenType=Mobile");
            $("#frmContent").css("width", width);
            $("#txtMainPage").css("color", "#989898");
            $("#txtNewTask").css("color", "#989898");
            $("#txtMyApproval").css("color", "black");
            $("#txtOtherPage").css("color", "#989898");
            $("#NewTask").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/NewTask.png");
            $("#MainPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MainPage.png");
            $("#MyApprovl").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyTask2.png");
            $("#OtherPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyRequest.png");
        }
        function OpenOtherPage() {
            var width = document.body.clientWidth + "px";
            $("#frmContent").attr("src", "MyRequestList.aspx?OpenType=Mobile");
            $("#frmContent").css("width", width);
            $("#txtMainPage").css("color", "#989898");
            $("#txtNewTask").css("color", "#989898");
            $("#txtMyApproval").css("color", "#989898");
            $("#txtOtherPage").css("color", "black");
            $("#NewTask").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/NewTask.png");
            $("#MainPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MainPage.png");
            $("#MyApprovl").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyTask.png");
            $("#OtherPage").find("img").attr("src", "<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyRequest2.png");
        }

    </script>
</head>
<body id="MobileBody">
    <form id="form1" runat="server">
        <div id="MobileDiv" style="overflow-y: scroll;">
            <%-- <div id="MobileTitel" style=" width: 100%;height:25px;background-color:#00A1F2" >
                <div onclick="Return()"><img src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/return.png"  /></div>
                <div></div>
            </div>--%>
            <div id="Mobiletop" style="width: 100%; height: 100%;">
                <iframe id="frmContent" name="content" src="MobileDefault.aspx" style="width: 100%; height: 100%" scrolling="yes" frameborder="0"></iframe>
            </div>
            <%--<div id="bottom" style="width:100%">--%>
            <nav class="navbar  navbar-fixed-bottom" id="bottomNav" style="height: 55px; width: 100%; margin-bottom: unset; bottom: unset;">
                <div class="container">
                    <ul class="nav nav-tabs nav-tabs-justified">
                        <div class="row" style="background: #E9E9E9;">
                            <div class="col-md-3 col-sm-3 col-xs-3" id="NewTask" onclick="OpenNewTask()" style="margin-top: 5px; margin-bottom: 5px; text-align: center">
                                <li class="bottomtext">
                                    <a href="#" class="bottomtext" style="color:#989898">
                                        <div class="textdiv">
                                            <img src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/NewTask.png" />
                                        </div>
                                        <div id="txtNewTask" class="textdiv">待办任务(<span style="color: red"><%=MYTASK_COUNT %></span>)</div>
                                    </a>
                                </li>
                            </div>
                            <div class="col-md-3 col-sm-3 col-xs-3" id="MainPage" onclick="OpenManinPage()" style="margin-top: 5px; margin-bottom: 5px; text-align: center">
                                <li>
                                    <a href="#" class="bottomtext" style="color:#989898">
                                        <div class="textdiv">
                                            <img src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/MainPage.png" />
                                        </div>
                                        <div id="txtMainPage" class="textdiv">新建申请</div>
                                    </a>
                                </li>
                            </div>
                            <div class="col-md-3 col-sm-3 col-xs-3" id="MyApprovl" onclick="OpenMyApprovl()" style="margin-top: 5px; margin-bottom: 5px; text-align: center">
                                <li>
                                    <a href="#" class="bottomtext" style="color:#989898">
                                        <div class="textdiv">
                                            <img src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyTask.png" />
                                        </div>
                                        <div id="txtMyApproval" class="textdiv">已办任务</div>
                                    </a>
                                </li>
                            </div>
                            <div class="col-md-3 col-sm-3 col-xs-3" id="OtherPage" onclick="OpenOtherPage()" style="margin-top: 5px; margin-bottom: 5px; text-align: center">
                                <li>
                                    <a href="#" class="bottomtext" style="color:#989898">
                                        <div class="textdiv">
                                            <img src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/MyRequest.png" />
                                        </div>
                                        <div id="txtOtherPage" class="textdiv">我的申请</div>
                                    </a>
                                </li>
                            </div>
                        </div>
                    </ul>
                </div>
            </nav>
            <%--</div>--%>
        </div>

        <!-- End CONTENT -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->

    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script type="text/javascript">

        function refreshCount() {
            //延迟3秒刷新
            setTimeout("AsyncRefreshCount();", 3000);
        }




    </script>
</body>
</html>
