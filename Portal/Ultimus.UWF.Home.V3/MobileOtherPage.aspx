<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MobileOtherPage.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MobileOtherPage" %>

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
        #MobileDiv {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            height: 100%;
            overflow: hidden;
            background-color:#FFFFFF;
        }

        .MobileLi {
            width: 100%;
            position: relative;
            color:#989898;
        }
            .MobileLi:after {
                content: '';
                height: 1px; /*控制边框宽度*/
                width: 200%; /*  控制边框长度*/
                position: absolute;
                left: 0px;
                top: auto;
                right: auto;
                bottom: 0px;
                background-color: #989898;
                border: 0px solid transparent;
                border-radius: 0px;
                -webkit-border-radius: 0px;
                transform: scale(0.5); /*缩放宽度，达到0.5px的效果*/
                -webkit-transform: scale(0.5);
                -moz-transform: scale(0.5);
                -ms-transform: scale(0.5);
                -o-transform: scale(0.5);
                transform-origin: top left; /*定义缩放基点*/
                -webkit-transform-origin: top left;
                -moz-transform-origin: top left;
                -ms-transform-origin: top left;
                -o-transform-origin: top left;
            }
    </style>

    <script type="text/javascript">


    </script>
</head>
<body id="MobileBody" >
    <form id="form1" runat="server">
        <div id="MobileDiv">
             <ul class="sidebar-panel nav">
                 <li class="MobileLi" style="cursor: pointer;">
                            我的申请
                        </li>
                 <li class="MobileLi" style="cursor: pointer;">
                            草稿箱
                        </li>
                 <li class="MobileLi" style="cursor: pointer;">
                            签呈草稿箱
                        </li>
                 <li class="MobileLi" style="cursor: pointer;">
                            待阅任务
                        </li>
                 <li class="MobileLi" style="cursor: pointer;">
                            已阅任务
                        </li>
                 <li class="MobileLi" style="cursor: pointer;">
                            考勤自助查询
                        </li>
             </ul>
            
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
