<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDelegationConfirmList.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MyDelegationConfirmList" %>

<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Decentralization Report</title>
    <link href="../../../common/assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../../../common/assets/css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../../../common/assets/css/shortcuts.css" rel="stylesheet" />
    <link href="../../../common/assets/css/report.css" rel="stylesheet" />
    <%=WebUtil.IncludeJsV3() %>
    <style>
        table tr td {
        text-align:center;
        }
    </style>
</head>
<body>
     <form id="form1" runat="server">
        <div class="panel panel-default">
            <!-- Panel Header -->
            <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                     <asp:Label ID="lable_info" runat="server">代理信息确认列表</asp:Label></span>
            </div>
            <div class="padding-l-5 padding-r-5">
                <table class="table table-condensed table-bordered ">
                    <thead>
                        <tr>                           
                             <th><asp:Label ID="lable_TaskUser" runat="server">被代理人姓名</asp:Label>
                            </th>
                            <th><asp:Label ID="label_assignToUser" runat="server">代理人姓名</asp:Label>
                            </th>
                             <th><asp:Label ID="label_Process" runat="server">代理流程</asp:Label>
                            </th>
                            <th><asp:Label ID="label_startTime" runat="server">开始时间</asp:Label>
                            </th>
                             <th><asp:Label ID="label_endTime" runat="server">结束时间</asp:Label>
                            </th>
                             <th><asp:Label ID="label_operation" runat="server">操作</asp:Label>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="rptList" Source="" PagerID="AspNetPager1"
                            runat="server">
                            <ItemTemplate>
                                <tr>
                                     <td class="taskuser">
                                          <%#Eval("taskuser")%>
                                    </td>
                                    <td class="assignedtouser">
                                        <%#Eval("assignedtouser")%>
                                    </td>
                                     <td class="processname">
                                        <%#Eval("processname")%>
                                    </td>
                                    <td class="assignfrom"> 
                                        <%#Eval("assignfrom")%>
                                    </td>
                                   
                                    <td class="assignuntil">
                                        <%#Eval("assignuntil")%>
                                    </td>
                                    <td>
                                        <input type="button" class="btn btn-success" onclick="getUrlParam(this)" value="查看"/>
                                    </td>                           
                                </tr>
                            </ItemTemplate>
                        </ult:Repeater>
                    </tbody>
                </table>
            </div>
            <!-- Pager -->
            <div class="pull-right">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="asppager"
                    NumericButtonCount="5" CurrentPageButtonClass="btn"
                    FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                    NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                    AlwaysShow="false" PageSize="10">
                </webdiyer:AspNetPager>
            </div>

             <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                     <asp:Label ID="log_info" runat="server">代理信息操作记录</asp:Label></span>
            </div>
             <div class="padding-l-5 padding-r-5" style="overflow-x: auto; width:98%; ">
              <table class="table table-condensed table-bordered " style="width: 1500px;">
                    <thead>
                             <tr>
                         <th><asp:Label ID="Label1" runat="server">被代理人姓名</asp:Label>
                            </th>
                            <th><asp:Label ID="label2" runat="server">代理人姓名</asp:Label>
                            </th>
                             <th><asp:Label ID="label3" runat="server">代理流程</asp:Label>
                            </th>
                            <th><asp:Label ID="label4" runat="server">开始时间</asp:Label>
                            </th>
                             <th><asp:Label ID="label5" runat="server">结束时间</asp:Label>
                            </th>
                                 <th><asp:Label ID="label6" runat="server">状态</asp:Label>
                            </th>
                                 <th><asp:Label ID="label7" runat="server">备注</asp:Label>
                            </th>
                        
                    </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="rptInfo" Source="" PagerID="AspNetPager2"
                            runat="server">
                            <ItemTemplate>
                                <tr>
                                <td>
                                    <%#Eval("taskuser")%>
                                </td>
                                <td>
                                    <%#Eval("assignedtouser")%>
                                </td>
                                <td>
                                     <%# Eval("processname")%>
                                </td>
                                <td>
                                     <%# Eval("assignfrom")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("assignfrom"))):""%>
                                </td>
                                <td>
                                     <%# Eval("assignuntil")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("assignuntil"))):""%>
                                </td>
                                <td>
                                   <%# Eval("STATUS").ToString()=="1"?"启用":Eval("STATUS").ToString()=="0"?"停用":"处理中"%>
                                </td>
                                <td>
                                    <%#Eval("remark")%>
                                </td>
                               
                            </tr>
                            </ItemTemplate>
                        </ult:Repeater>
                    </tbody>
                </table>
            </div>
            <!-- Pager -->
            <div class="pull-right">
                <webdiyer:AspNetPager ID="AspNetPager2" runat="server" CssClass="asppager"
                    NumericButtonCount="5" CurrentPageButtonClass="btn"
                    FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                    NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                    AlwaysShow="false" PageSize="10">
                </webdiyer:AspNetPager>
            </div>
        </div>
    </form>
    <script>
        function getUrlParam(ele) {
            var taskUser = $(ele).parent().siblings(".taskuser").text().trim();
            var assignToUser = $(ele).parent().siblings(".assignedtouser").text().trim();
            var processName = $(ele).parent().siblings(".processname").text().trim();
            var beginTime = $(ele).parent().siblings(".assignfrom").text().trim();
              var endTime = $(ele).parent().siblings(".assignuntil").text().trim();
            var url = "https://testingautosmart.sodexo-cn.com//Portal/Ultimus.UWF.Home.V3/MyDelegationConfirm.aspx?taskUser=" + taskUser + '&assignToUser=' + assignToUser + '&processName=' + processName+'&beginTime='+beginTime+'&endTime='+endTime+'&type=page';
              window.location.href =url
        }
    </script>
</body>
</html>
