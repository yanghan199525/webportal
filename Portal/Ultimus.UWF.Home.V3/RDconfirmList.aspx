<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RDconfirmList.aspx.cs" Inherits="Ultimus.UWF.Home.V3.RDconfirmList" %>

<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

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
                     <asp:Label ID="lable_info" runat="server">RD授权信息确认列表</asp:Label></span>
            </div>
            <div class="padding-l-5 padding-r-5">
                <table class="table table-condensed table-bordered ">
                    <thead>
                        <tr>                           
                             <th><asp:Label ID="lable_rdName" runat="server">RD姓名</asp:Label>
                            </th>
                            <th><asp:Label ID="label_rdEmpNo" runat="server">RD员工编号</asp:Label>
                            </th>
                             <th><asp:Label ID="label_rdOrgName" runat="server">RD事业部</asp:Label>
                            </th>
                            <th><asp:Label ID="label_sdEpmName" runat="server">SD名称</asp:Label>
                            </th>
                            <th><asp:Label ID="label_sdEpmNo" runat="server">SD编号</asp:Label>
                            </th>
                             <th><asp:Label ID="label_sdOrgName" runat="server">SD事业部</asp:Label>
                            </th>
                            <th><asp:Label ID="label_startTime" runat="server">授权开始时间</asp:Label>
                            </th>
                             <th><asp:Label ID="label_endTime" runat="server">授权结束时间</asp:Label>
                            </th>
                               <th><asp:Label ID="label_Range" runat="server">授权范围</asp:Label>
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
                                     <td>
                                          <%#Eval("rdName")%>
                                    </td>
                                    <td class="rdEmpNo">
                                        <%#Eval("rdLeaderNumber")%>
                                    </td>
                                     <td class="orgCode">
                                        <%#Eval("orgCode")%>
                                    </td>
                                    <td>
                                        <%#Eval("sdName")%>
                                    </td>
                                   
                                    <td class="sdEmpNo">
                                        <%#Eval("sdLeaderNumber")%>
                                    </td>
                                    <td class="sdOrgCode">
                                        <%#Eval("sdOrgCode")%>
                                    </td> 
                                     <td>
                                     <%# Eval("startTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("startTime"))):""%>
                                </td>
                                <td>
                                    <%# Eval("endTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("endTime"))):""%>
                                </td>
                                     <td class="authRange">
                                        <%#Eval("authRange")%>
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
                     <asp:Label ID="log_info" runat="server">RD授权信息操作记录</asp:Label></span>
            </div>
             <div class="padding-l-5 padding-r-5" style="overflow-x: auto; width:98%; ">
              <table class="table table-condensed table-bordered " style="width: 1500px;">
                    <thead>
                             <tr>
                        <th> <asp:Label ID="log_sdName" runat="server">授权操作人名称</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_sdEmpNo" runat="server">授权操作人编号</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_sdCreate" runat="server">授权操作时间</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_orgName" runat="server">事业部</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_rdName" runat="server">RD姓名</asp:Label>
                        </th>
                        <th><asp:Label ID="log_rdempNo" runat="server">RD员工编号</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_rdCreate" runat="server">RD操作时间</asp:Label>
                        </th>
                         <th><asp:Label ID="log_startTime" runat="server">授权开始时间 </asp:Label>
                        </th>
                         <th> <asp:Label ID="log_endTime" runat="server">授权结束时间</asp:Label>
                        </th>
                         <th> <asp:Label ID="log_desc" runat="server">授权说明</asp:Label>
                        </th>
                         <th> <asp:Label ID="log_range" runat="server">授权范围</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_content" runat="server">操作内容</asp:Label>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="rptInfo" Source="" PagerID="AspNetPager2"
                            runat="server">
                            <ItemTemplate>
                                <tr>
                                <td>
                                    <%#Eval("sdName")%>
                                </td>
                                <td>
                                    <%#Eval("sdEmpNo")%>
                                </td>
                                <td>
                                     <%# Eval("sdCreatTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("sdCreatTime"))):""%>
                                </td>
                                <td>
                                    <%#Eval("sdOrgName")%>
                                </td>
                                <td>
                                    <%#Eval("rdName")%>
                                </td>
                                <td>
                                    <%#Eval("rdEmpNo")%>
                                </td>
                                <td>
                                      <%# Eval("rdCreatTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("rdCreatTime"))):""%>
                                </td>
                                <td>
                                     <%# Eval("authStartTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("authStartTime"))):""%>
                                </td>
                                <td>
                                    <%# Eval("authEndTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("authEndTime"))):""%>
                                </td>
                                <td>
                                    <%#Eval("authDesc")%>
                                </td>
                                <td>
                                    <%#Eval("authRange")%>
                                </td>
                                <td>
                                    <%#Eval("comments")%>
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
            var rdLeaderNumber = $(ele).parent().siblings(".rdEmpNo").text().trim();
            var sdLeaderNumber = $(ele).parent().siblings(".sdEmpNo").text().trim();
            var sdOrgName = $(ele).parent().siblings(".sdOrgCode").text().trim();
            var orgName = $(ele).parent().siblings(".orgCode").text().trim();
              var authRange = $(ele).parent().siblings(".authRange").text().trim();
            var url = "https://testingautosmart.sodexo-cn.com//Portal/Ultimus.UWF.Home.V3/RDconfirm.aspx?rdEmpNo=" + rdLeaderNumber + '&sdEmpNo=' + sdLeaderNumber + '&sdOrgName=' + sdOrgName+'&orgName='+orgName+'&authRange='+authRange;
              window.location.href =url
        }
    </script>
</body>
</html>
