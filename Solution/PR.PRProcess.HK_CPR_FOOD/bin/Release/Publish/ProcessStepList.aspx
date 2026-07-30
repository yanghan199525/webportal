<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessStepList.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessStepList" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls"
    TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程步骤列表</title>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <%=WebUtil.IncludeCss()%>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12 breadcrumb mb0">
                
                <table width="100%">
                    <tr>
                        <td width="10">
                            <i class="icon-th-list"></i>
                        </td>
                        <td width="200">
                            <span class="pl5 strong inline">流程步骤列表</span>
                        </td>
                        <td class="pull-right">
                            <a class="btn btn-primary" target="_blank" href="ProcessStepDetail.aspx?ProcessName=<%=Request.QueryString["ProcessName"] %>"><i class="icon-plus icon-white">
                            </i>新增</a> <a class="btn btn-default" href="ProcessStepList.aspx?ProcessName=<%=Request.QueryString["ProcessName"] %>"><i class="icon-refresh">
                            </i>刷新</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span1">
                流程名称</div>
            <div class="span3">
                <ult:TextBox ID="TextBox4" runat="server" CssClass="" Destination="PROCESSNAME"></ult:TextBox></div>
            <div class="span1">
                 步骤名称</div>
            <div class="span3">
                <ult:TextBox ID="TextBox1" runat="server" CssClass="" Destination="STEPNAME"></ult:TextBox></div>
            <div class="span4">
                <ult:Button ID="BtnQuery2" runat="server" Text="查询" CssClass="btn btn-default " /> 
                <a class="btn " href="javascript:window.close();"><i class="icon-chevron-left">
                            </i>关闭</a> 
            </div>
        </div>
        <div class="row-fluid">
            <table class="table table-bordered table-condensed">
                <thead>
                    <tr>
                         <th>
                            序号
                        </th>
                        <th>
                            流程名称
                        </th>
                        <th>
                            步骤名称
                        </th>
                        <th>
                            表单Url
                        </th>
                       
                        <th>
                            编辑
                        </th>
                          
                    </tr>
                </thead>
                <tbody>
                    <ult:Repeater ID="repeat1"  PagerID="AspNetPager1"
                        runat="server">
                        <ItemTemplate>
                            <tr>
                                 <td>
                                    <%#Eval("ORDERNO")%>
                                </td>
                                <td>
                                    <%#Eval("PROCESSNAME")%>
                                </td>
                                <td>
                                    <%#Eval("STEPNAME")%>
                                </td>
                                 
                                <td>
                                    <%#Eval("PCFORM")%>
                                </td>
                               
                                <td>
                                    <a class="btn btn-warning" target="_blank" href="ProcessStepDetail.aspx?ID=<%#Eval("ID")%>&ProcessName=<%#Eval("PROCESSNAME")%>">
                                        <i class="icon-edit icon-white"></i></a>
                                </td>
                                 
                            </tr>
                        </ItemTemplate>
                    </ult:Repeater>
                </tbody>
            </table>
        </div>
        <div class="pull-right">
            <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="asppager" CurrentPageButtonClass="btn btn-small" 
                FirstPageText="<i class='icon-step-backward'></i>" PrevPageText="<i class='icon-chevron-left'></i>" 
                NextPageText="<i class='icon-chevron-right'></i>" LastPageText="<i class='icon-step-forward'></i>" AlwaysShow="true"
                PageSize="10">
            </webdiyer:AspNetPager>
        </div>
    </div>
    </form>
    <%=WebUtil.IncludeJs()%>
</body>
</html>
