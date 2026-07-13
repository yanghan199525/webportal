<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DecentralizationReport.aspx.cs" Inherits="Ultimus.UWF.Home.V3.DecentralizationReport" %>

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
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel panel-default">
            <!-- Panel Header -->
            <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                     <asp:Label ID="log_info" runat="server">单外权力下放日志监控</asp:Label></span>
            </div>
            <!-- Panel Search -->
            <div class="panel-body">
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            <asp:Label ID="Serch_sdName" runat="server">授权操作人名称:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="sdName" runat="server" CssClass="form-control" Destination="sdName"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            <%--<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:--%>
                             <asp:Label ID="Serch_rdName" runat="server">RD姓名:</asp:Label>
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="rdName" runat="server" CssClass="form-control" Destination="rdName"></ult:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <ult:Button ID="btn_serch" runat="server" Text="查询" CssClass="btn btn-default " OnBeforeClick="Button1_BeforeClick" />
                </div>
            </div>
            <!-- Table -->
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
                        <ult:Repeater ID="rptList" Source="" PagerID="AspNetPager1"
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
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="asppager"
                    NumericButtonCount="5" CurrentPageButtonClass="btn"
                    FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                    NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                    AlwaysShow="false" PageSize="10">
                </webdiyer:AspNetPager>
            </div>
        </div>
    </form>
</body>
<script>
</script>
</html>
