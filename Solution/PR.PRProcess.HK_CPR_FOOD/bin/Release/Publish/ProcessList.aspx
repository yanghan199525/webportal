<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessList.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls"
    TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程列表</title>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <%--<%=WebUtil.IncludeCss()%>--%>
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <!-- Start Page Header -->
            <div class="page-header">
                <h1 class="title ">
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-bars"></i></span>
                    流程列表</h1>
                <ol class="breadcrumb">
                    <li class="active"></li>
                </ol>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <a class="btn btn-default" target="_blank"
                            href="ProcessDetail.aspx?namespace=<%=Request.QueryString["namespace"] %>">
                            <i class="icon-plus icon-white"></i>新增</a>
                        <ult:Button ID="Button1" runat="server" Text="清除缓存" OnClick="Button1_Click" CssClass="btn btn-light " />
                        <a class="btn btn-light" href="ProcessList.aspx"><i class="icon-refresh"></i>查询所有流程</a>

                        <a href="javascript:location.href=location.href;" class="btn btn-light">刷新</a>
                    </div>
                </div>
            </div>
            <!-- End Page Header -->

            <div class="container-default">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-title">
                                <i class="fa fa-bars"></i>
                                <%=Lang.Get("ListInfo")%>
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>

                            <div class="panel-body">
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            流程名称:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <ult:TextBox ID="TextBox4" runat="server" CssClass="" Destination="PROCESSNAME"></ult:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <ult:Button ID="BtnQuery2" runat="server" Text="查询" CssClass="btn btn-success " />
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <table class="table table-hover table-nofooter">
                                        <thead>
                                            <tr>
                                                <th>模块
                                                </th>
                                                <th>流程名称
                                                </th>
                                                 <th>流程中文名
                                                </th>
                                                <th>分类
                                                </th>
                                                <th>默认表单Url
                                                </th>

                                                <th>编辑
                                                </th>
                                                <th>查看步骤
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <ult:Repeater ID="repeat1" Source="BizDB.WF_PROCESS" PagerID="AspNetPager1"
                                                runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%#Eval("MODULE")%>
                                                        </td>
                                                        <td>
                                                            <%#Eval("PROCESSNAME")%>
                                                        </td>
                                                         <td>
                                                            <%#Eval("CNNAME")%>
                                                        </td>
                                                        <td>
                                                            <%#GetCategory(Eval("CATEGORYID"))%>
                                                        </td>

                                                        <td>
                                                            <%#Eval("DEFAULTPCFORM")%>
                                                        </td>
                                                        <td>
                                                            <a class="btn btn-icon btn-sm btn-warning" target="_blank" href="ProcessDetail.aspx?ID=<%#Eval("ID")%>&namespace=<%=Request.QueryString["namespace"] %>">
                                                                <i class="fa fa-edit"></i></a>
                                                        </td>
                                                        <td>
                                                            <a class="btn btn-icon btn-sm btn-warning" target="_blank" href="ProcessStepList.aspx?PROCESSNAME=<%# System.Web.HttpUtility.UrlEncode(Eval("PROCESSNAME").ToString())%>">
                                                                <i class="fa fa-share"></i></a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </ult:Repeater>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="pull-right">
                                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="asppager" CurrentPageButtonClass="btn btn-small"
                                        FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                                        NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>" AlwaysShow="true"
                                        PageSize="8">
                                    </webdiyer:AspNetPager>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>
</body>
</html>
