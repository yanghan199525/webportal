<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskStatus.aspx.cs" 
    Inherits="Ultimus.UWF.Home.V3.TaskStatus" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
        <%=WebUtil.IncludeFiles() %>
    <link href="../../common/assets/css/bootstrap3.3.2.css" rel="stylesheet" />
    <title>
        <%=Lang.Get("TaskStatus_Title") %>-<%=MyLib.ConvertUtil.ToInt32(Request.QueryString["Incident"])%>,<%=Server.UrlDecode(Request.QueryString["ProcessName"])%></title>

    <script language="javascript" type="text/javascript">
        self.moveTo(0, 0)
        self.resizeTo(screen.availWidth, screen.availHeight)
        function closeWin() {
            window.opener = null;
            window.open('', '_self');
            window.close();
            return false;
        }
    </script>
    <style>

        .strong
        {
        }
        body
        {
            font-family:微软雅黑;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
        <fieldset>
            <legend  class="<%=HIDDEN %>"><strong>
                <%=Lang.Get("TaskStatus_ApprovalHistory") %>
            </strong></legend>
            <div class="row-fluid">
            <table class="table table-striped table-condensed <%=HIDDEN %>" >
                <tr>
                    <th>
                        <span class=""><%=Lang.Get("TaskStatus_StepName")  %></span>
                    </th>
                    <th>
                        <span class=""><%=Lang.Get("TaskStatus_TaskUser") %></span>
                    </th>
                    <th>
                        <span class=""><%=Lang.Get("TaskStatus_Approver") %></span>
                    </th>
                    <th class="hidden-xs">
                        <span class=""><%=Lang.Get("TaskStatus_StartTime") %></span>
                    </th>
                    <th class="hidden-xs">
                        <span class=""><%=Lang.Get("TaskStatus_EndTime") %></span>
                    </th>
                    <th>
                        <span class=""><%=Lang.Get("TaskStatus_Status") %></span>
                    </th>
                    <th>
                        <span class=""><%=Lang.Get("Action") %></span>
                    </th>
                </tr>
                <asp:Repeater ID="rptTaskList" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td >
                                <%# Eval("StepName")%>
                            </td>
                             <td>
                                <%# Eval("TaskUserName")%>
                            </td>
                            <td>
                                <%# Eval("StepUser")%>
                            </td>
                            <td class="hidden-xs utcdatetime" >
                                <%# Eval("StartTime")%>
                            </td>
                            <td class="hidden-xs utcdatetime">
                                <%# Eval("EndTime")%>
                            </td>
                            <td>
                                <%# Eval("Status")%>
                            </td>
                            <td>
                                <%# Eval("CopyLink")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table></div>
            <div class="row-fluid center"> 
            <asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="btn btn-primary  "  OnClientClick="return closeWin();" />

            </div>
        </fieldset>
        <fieldset>
            <legend><strong>
                <%=Lang.Get("TaskStatus_FlowChart")%>
            </strong></legend>
            <iframe id="rightframe" name="rightframe" hspace="0" vspace="0" src='Workflow/GraphicalView.aspx?ProcessName=<%=Server.UrlEncode(Request.QueryString["ProcessName"]) %>&Incident=<%=Request.QueryString["Incident"] %>'
                frameborder="0" width="98%" height="600"></iframe>
        </fieldset>
    </div>

        <div hidden="hidden" class="" style="">
            <input type="text" id="txtCopyLink" />
        </div>
    </form>

    <script type="text/javascript">


        $(document).ready(function () {
            //$("#rightframe").attr("src", '../Ultimus.UWF.Workflow/GraphicalView.aspx?ProcessName=<%=Server.UrlEncode(Request.QueryString["ProcessName"]) %>&Incident=<%=Request.QueryString["Incident"] %>');
        });

        function copyLink(path, taskid, user)
        {
            var clipBoardContent = "";
            clipBoardContent = path + "Workflow/OpenForm.aspx?taskid=" + taskid + "&username=" + user + "&type=mytask";
            $("#txtCopyLink").val(clipBoardContent);
            $("#txtCopyLink")[0].select(); // 选择对象
            document.execCommand("Copy"); // 执行浏览器复制命令
            alert("Copy link success!");
        }

    </script>

</body>
</html>


