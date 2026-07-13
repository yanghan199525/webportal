<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NodalPersonDetails.aspx.cs" Inherits="Ultimus.UWF.CPR.NodalPersonDetails" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>NodalPerson Detail</title>
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <!-- Start Page Header -->
            <div class="page-header">
                <h1 class="title ">
                    <span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-th-large"></i></span>
                    节点负责人详细信息</h1>
            </div>
            <!-- End Page Header -->

            <!-- //////////////////////////////////////////////////////////////////////////// -->
            <!-- START CONTAINER -->
            <%--<div class="container-default"></div>--%>
            <div class="container-default">
                <!-- Start Row -->
                <div class="row" id="searchPanel">
                    <div class="col-md-12">
                        <div class="panel panel-default ">
                            <div class="panel-title">
                                <i class="fa fa-check-square-o"></i>
                                详细信息
                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>

                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="col-md-2  col-xs-5">
                                            节点名称*:
                                        </div>
                                        <div class="col-md-4  col-xs-7">
                                            <select id="ddlNodeName" class="selectpicker form-control" data-live-search="true">
                                            </select>
                                            <ult:Label ID="read_NodeName" title="" Style="display: none" Format="" runat="server">
                                            </ult:Label>
                                        </div>
                                        <div class="col-md-7  col-xs-12"></div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="col-md-2  col-xs-5">
                                            节点负责人*:
                                        </div>
                                        <div class="col-md-4  col-xs-7">
                                            <ult:Label ID="read_NodePerson" title="" Style="display: none" Format="" runat="server">
                                            </ult:Label>
                                            <br />
                                            <select id="ddlNodePersonNumber" class="selectpicker form-control" data-live-search="true">
                                            </select>
                                        </div>
                                        <div class="col-md-7  col-xs-12"></div>
                                    </div>
                                </div>
                                
                                <div class="col-md-12">
                                    <div class="panel-body padding-b-20 col-md-6" style="text-align: right">
                                        <br />
                                        <asp:Button ID="btnSave" runat="server" Text="保存 Save" CssClass="btn btn-default" OnClientClick="return validate();" OnClick="btnSave_Click" />
                                        <asp:Button ID="btnClose" runat="server" Text="关闭 Close" CssClass="btn hidden-xs" OnClientClick="window.close();return false;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hidden">
                <asp:HiddenField ID="hdNodeName" runat="server" />
                <asp:HiddenField ID="hdNodePersonNumber" runat="server" />
                <asp:HiddenField ID="hdNodePersonName" runat="server" />
            </div>
        </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script src="NodePerson.js" type="text/javascript"></script>
</body>
</html>
