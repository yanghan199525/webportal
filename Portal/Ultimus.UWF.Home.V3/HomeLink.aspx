<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeLink.aspx.cs" Inherits="Ultimus.UWF.Home.V3.HomeLink" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Home</title>
    <!-- ========== Css Files ========== -->
    <link rel="stylesheet" href="../../common/assets/css/bootstrap.2.3.0.css" />
    <link rel="stylesheet" href="css/matrix-style.css" />
    <link rel="stylesheet" href="css/matrix-media.css" />
    <link rel="stylesheet" href="font-awesome/css/font-awesome.css"  />
     <style type="text/css">
        body
        {
            font-family:微软雅黑;
            background-color:rgb(238, 238, 238);
        }
    </style>
    <script type="text/ecmascript">
        function delegation() {
            var taskid = "";
            var PageName = "delegation.aspx";
            if (taskid != "") {
                PageName += "?TaskID=" + encodeURI(taskid);
            }
            showForm({
                url: PageName,
                title: "Delegation",
                buttons: []
            });

            return false;
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
    <!--Action boxes-->
  <div class="container-fluid">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
        <li class="bg_lb"> <a href="newtasklist.aspx" target="content"> <i class="icon-edit"></i> <%=Lang.Get("NewRequest") %> </a> </li>
        <li class="bg_lg span3"> <a href="mytasklist.aspx" target="content"> <i class="icon-envelope"></i> <span class="label label-important" id="lblCount"><%=MYTASK_COUNT %></span><%=Lang.Get("DEFAULT_MYTASK") %></a> </li>
        <li class="bg_ly"> <a href="myapprovallist.aspx" target="content"> <i class=" icon-check"></i> <%=Lang.Get("MyApproval") %> </a> </li>
        <li class="bg_lo"> <a href="myrequestlist.aspx" target="content"> <i class="icon-file-alt"></i> <%=Lang.Get("MyRequest") %></a> </li>
        <li class="bg_ls"> <a href="draftlist.aspx" target="content"> <i class="icon-save"></i><%=Lang.Get("DraftList_Title") %></a> </li>
        <li class="bg_lo span3"> <a href="reportlist.aspx" target="content"> <i class="icon-th-list"></i><%=Lang.Get("Report") %></a> </li>
        <li class="bg_ls"> <a href="mydelegationlist.aspx" target="content"> <i class="icon-time"></i><%=Lang.Get("Delegation") %></a> </li>
        <li class="bg_lb"> <a href="../Ultimus.UWF.OrgChart/PersonInfo.aspx" target="content"> <i class="icon-cog"></i><%=Lang.Get("Settings") %></a> </li>
        <li class="bg_lg"> <a href="TaskList.aspx" target="content"> <i class="icon-signal"></i> <%=Lang.Get("ProcessSearch") %></a> </li>
        <li class="bg_lr"> <a href="<%=MyLib.ConfigurationManager.AppSettings["HelpUrl"] %>" target="_blank"> <i class="icon-info-sign"></i> <%=Lang.Get("Default_Help") %></a> </li>

      </ul>
    </div>
      </div>

<!--End-Action boxes--> 
    </form>
</body>
</html>
