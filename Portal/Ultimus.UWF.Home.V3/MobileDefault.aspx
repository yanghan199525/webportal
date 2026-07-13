<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MobileDefault.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MobileDefault" %>

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

        #MobileBody {
            background-color: #FFFFFF;
        }
        #MobileDiv {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            height: 100%;
            overflow: hidden;
        }
        #MobileTop {
            width: 100%;
            top: 0;
            height: 25%;
            /*background-color: #00A1F2;*/
            /*border-color: black;
            border-style: solid;*/
        }
        #MobileTop2 {
            width:100%;
            height:10%;

        }
        #MobileCenter {
            width: 100%;
            height: 50%;
            margin-top: 5%;
            /*border-color: black;
            border-style: solid;*/
        }
        #MobileMyTask {
            border-color: #00A1F2;
            border-style: solid;
            background-color: #FFFFFF;
            width: 80%;
            height: 20%;
            margin: 0 auto;
            margin-top: 10px;
            border-radius: 1em;
            background-color: #00A1F2;
        }
        #MobileNewRequest {
            border-color: #00A1F2;
            border-style: solid;
            background-color: #FFFFFF;
            width: 80%;
            height: 20%;
            margin: 0 auto;
            margin-top: 10%;
            border-radius: 1em;
        }
        #MobileMyRequest {
            border-color: #00A1F2;
            border-style: solid;
            background-color: #FFFFFF;
            width: 80%;
            height: 20%;
            margin: 0 auto;
            margin-top: 10%;
            border-radius: 1em;
        }
        #txtMyTaskDiv {
            margin-top: 5%;
           
        }
        .txtDiv {
            margin-top: 10%;
        }
        
        .CenterDiv {
            width:70%;
            height:100%;
            float:left;
            
        }
        .CenterImg {
            width: 30%;
            height: 100%;
            float: left;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            /*line-height:62px;*/
        }
        #txtMyTask {
                margin-left: 10%;
                font-size: 18px;
                color:#FFFFFF;
        }
        #txtNewRequest {
                margin-left: 10%;
                font-size: 18px;
                color:#00A1F2;
        }
        #txtMyRequest {
                margin-left: 10%;
                font-size: 18px;
                color:#00A1F2;
        }
        #txtJob {
            margin-left: 10%;
            color:#FFFFFF;
        }
       
        .ImgTop {
            width:100%;
            height:100%;
        }
        #ImgTop1 img {
            width:100%;
            height:100%;
        }
        #ImgTop2 {
            width:100%;
            height:100%;
            display:none;
        }
        #ImgTop3 {
            width:100%;
            height:100%;
            display:none;
        }
        #ImgMyTask1 {
            /*width: 60%;
            height: 60%;*/
            margin-top: 4%;
            margin-left: 25%;
        }
         #ImgNewRequest {
            /*width: 60%;
            height: 60%;*/
            margin-top: 4%;
            margin-left: 25%;
        }
         #ImgMyRequest {
            /*width: 60%;
            height: 60%;*/
            margin-top: 4%;
            margin-left: 25%;
        }
        #Top1 {
            margin-left: 40%;
            background-color: #989898;
            border-radius: 50%;
            margin-top: 2%;
        }

        
    </style>

    <script type="text/javascript">

        function OpenMyTask()
        {
            location.href = "MyTaskListV3.aspx?OpenType=Mobile";
        }
        function OpenNewRequest() {
            location.href = "NewTaskListV3.aspx?OpenType=Mobile&MobileType=Mobile";
        }
        function OpenMyRequest() {
            location.href = "MyRequestList.aspx?OpenType=Mobile";
        }

       
    </script>
</head>
<body id="MobileBody">
    <form id="form1" runat="server">
        
        <div id="MobileDiv">

            <!-- top -->
            <div id="MobileTop">
                <div id="ImgTop1" class="ImgTop">
                     <img src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/top1.png" />
                </div>
            </div>
            <!-- center -->
            <div id="MobileCenter">
                <div id="MobileMyTask" onclick="OpenMyTask()">
                    <div class="CenterDiv">
                        <div id="txtMyTaskDiv" >
                            <span id="txtMyTask">待办任务</span>
                            </br>
                            <span id="txtJob">任务反馈(<%=MYTASK_COUNT %>)</span>
                        </div>
                    </div>
                    <div class="CenterImg" >
                        <img id="ImgMyTask1" src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/box01.png" />
                    </div>
                </div>
                <div id="MobileNewRequest" onclick="OpenNewRequest()">
                    <div class="CenterDiv">
                        <div class="txtDiv" >
                            <span id="txtNewRequest">新建申请</span>

                        </div>
                    </div>
                    <div class="CenterImg">
                        <img id="ImgNewRequest" src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/box06.png" />
                    </div>
                </div>
                <div id="MobileMyRequest" onclick="OpenMyRequest()">
                    <div class="CenterDiv">
                        <div class="txtDiv" >
                            <span id="txtMyRequest">我的申请</span>
                        </div>
                    </div>
                    <div class="CenterImg">
                        <img id="ImgMyRequest" src="<%=WebUtil.GetRootPath()%>/Common/Assets/image/box04.png" />
                    </div>
                </div>
            </div>
            <!--bottom -->
            
        </div>

        <!-- End CONTENT -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->

    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script type="text/javascript">

        $(function () {

            var browser = {
                version: function () {
                    var u = navigator.userAgent;
                    var app = navigator.appVersion;
                    return {
                        trident: u.indexOf('Trident') > -1, //IE内核 
                        presto: u.indexOf('Presto') > -1, //opera内核 
                        webkit: u.indexOf('AppleWebkit') > -1, //苹果
                        gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核 
                        mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端 
                        ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
                        android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器 
                        iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器 
                        iPad: u.indexOf('iPad') > -1, //是否iPad 
                        Chrome: u.indexOf('Chrome') > -1,//谷歌内核
                        webApp: u.indexOf('Safari') == -1 //是否web应用程序,没有头部和底部 
                    };
                }(),
                language: (navigator.browserLanguge || navigator.language).toLowerCase()
            }
            //alert("trident:" + browser.version.trident + ",presto:" + browser.version.presto + ",webkit:" + browser.version.webkit + ",gecko:" + browser.version.gecko
            //    + ",mobile:" + browser.version.mobile + ",ios:" + browser.version.ios + ",android:" + browser.version.android + ",iPhone:" + browser.version.iPhone + ",iPad:" + browser.version.iPad
            //    + ",webApp:" + browser.version.webApp);
            if (browser.version.android || browser.version.ios || browser.version.iPhone || browser.version.iPad) {
                $("#homelogo").attr("src", "");
            }
        })

        function openSearch() {
            var s = $("#searchbox").val();
            var url = "MyApprovalList.aspx?s=" + s;
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

        $(document).ready(function () {
            //判断是否移动端打开
            var CenterHeight = window.parent.document.getElementById("MobileDiv").clientHeight + "px";
            var CenterWidth = window.parent.document.getElementById("MobileDiv").clientWidth + "px"; 
                //更改父页面div高度
            window.parent.document.getElementById("frmContent").style.height = CenterHeight;
            window.parent.document.getElementById("frmContent").style.width = CenterWidth;
                // $("#MobileDiv", parent.document).css("height", height + "px");
                //var height = document.body.scrollHeight;
        })

        function refreshCount() {
            //延迟3秒刷新
            setTimeout("AsyncRefreshCount();", 3000);
        }




    </script>
</body>
</html>
