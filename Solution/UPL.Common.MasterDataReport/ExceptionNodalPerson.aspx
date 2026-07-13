<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExceptionNodalPerson.aspx.cs" Inherits="Ultimus.UWF.CPR.ExceptionNodalPerson" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>BPM-Exception Nodal Person List</title>
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <!-- Start Page Header -->
            <div class="page-header">
                <h1 class="title ">
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-bars"></i></span>
                    异常节点负责人-数据源列表</h1>
                <ol class="breadcrumb">
                    <li class="active"></li>
                </ol>
                <div class="right">
                    <div class="btn-group" role="group" aria-label="...">
                        <a href="javascript:location.href=location.href;" class="btn btn-light"><i class="fa fa-refresh"></i></a>
                    </div>
                </div>
            </div>
            <!-- End Page Header -->

            <!-- //////////////////////////////////////////////////////////////////////////// -->
            <!-- START CONTAINER -->
            <div class="container-default">
                <!-- Start Panel -->
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
                                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                                    <div class="form-group">
                                        <div class="col-md-4">
                                            节点名称:
                                        </div>
                                        <div class="col-md-7">
                                            <ult:TextBox ID="txt_orgCode" runat="server" CssClass="form-control" Destination="orgCode"></ult:TextBox>
                                        </div>
                                        <div class="col-md-1"></div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                                    <div class="form-group">
                                        <div class="col-md-4">
                                            父节点名称:
                                        </div>
                                        <div class="col-md-7">
                                            <ult:TextBox ID="txt_parentOrgCode" runat="server" CssClass="form-control" Destination="parentOrgCode"></ult:TextBox>
                                        </div>
                                        <div class="col-md-1"></div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                                    <ult:Button ID="Button2" runat="server" Text="查询" CssClass="btn btn-default " />
                                </div>
                            </div>

                            <div class="panel-body">
                                <table id="tasklist" class="table table-hover table-nofooter" width="100%">
                                    <thead>
                                        <tr>
                                            <td style="width: 14%;">父节点编号</td>
                                            <td style="width: 14%;">父节点名称</td>
                                            <td style="width: 14%;">节点编号</td>
                                            <td style="width: 14%;">节点名称</td>
                                            <td style="width: 10%;">类型</td>
                                            <td style="width: 14%;">负责人编号</td>
                                            <td style="width: 14%;">负责人名称</td>
                                        </tr>
                                    </thead>

                                    <tbody class="cursor-pointer" id="taskRows">
                                        <ult:Repeater ID="rptList" runat="server" Source="BizDB.SODEXO_ORGANIZATION" PagerID="AspNetPager1">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <%#Eval("parentOrgCode")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("parentOrgName")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("orgCode")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("orgName")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("orgType")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("leaderNumber")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("leaderName")%>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </ult:Repeater>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- End Panel -->

                <div class="pull-right">
                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="asppager" CurrentPageButtonClass="btn btn-small"
                        FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                        NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>" AlwaysShow="true"
                        PageSize="8">
                    </webdiyer:AspNetPager>
                </div>

            </div>
        </div>
    </form>

    <%=WebUtil.IncludeJsV3()%>
    <script src="NodePerson.js" type="text/javascript"></script>
</body>
</html>
