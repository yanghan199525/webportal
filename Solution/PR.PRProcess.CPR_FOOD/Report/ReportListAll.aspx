<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportListAll.aspx.cs" Inherits="PR.PRProcess.CPR_FOOD.ReportListAll" %>

<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>CPR_FOOD Report</title>
    <link href="../../../common/assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../../../common/assets/css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../../../common/assets/css/shortcuts.css" rel="stylesheet" />
    <link href="../../../common/assets/css/report.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel panel-default">
            <!-- Panel Header -->
            <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                    单外采购审批（食品）报表/Out Of Catalogue Purchase Requisition Request(Food)Report</span>
                <div class="pull-right">
                    <asp:LinkButton ID="lbExport" runat="server" CssClass="btn btn-success" OnClick="lbExport_Click">
                        <i class="fa fa-file-excel-o"></i>导出</asp:LinkButton>
                    <a class="btn" href="javascript:location.href=location.href;"><i class="fa fa-refresh"></i>刷新</a>
                    <asp:Button ID="btnUnderApproval" runat="server" Text="审批中查询" CssClass="btn btn-default " OnClick="btnUnderApproval_Click" />
                </div>

            </div>
            <!-- Panel Search -->
            <div class="panel-body">
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            Document No:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_DOCUMENTNO" runat="server" CssClass="form-control" Destination="DOCUMENTNO"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            申请日期:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_REQUESTDATESTART" data-type="date" runat="server" CssClass="form-control" Destination="Scope.Start.REQUESTDATE"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            -
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_REQUESTDATEEND" data-type="date" runat="server" CssClass="form-control" Destination="Scope.End.REQUESTDATE"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            <%--<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:--%>
                            申请人:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_APPLICANT" runat="server" CssClass="form-control" Destination="APPLICANT"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            申请目的:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_APPLYPURPOSE" runat="server" CssClass="form-control" Destination="APPLYPURPOSETXT"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            采购类型:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_SUPPLIERTYPE" runat="server" CssClass="form-control" Destination="SUPPLIERTYPETXT"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            分店编号:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_SITECODE" runat="server" CssClass="form-control" Destination="SITECODE"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            分店名称:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_SITENAME" runat="server" CssClass="form-control" Destination="SITENAME"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            审批状态:
                        </div>
                        <div class="col-md-8">
                            <%--<ult:TextBox ID="txt_ACTION" runat="server" CssClass="form-control" Destination="ACTION"></ult:TextBox>--%>
                            <ult:DropdownList ID="txt_ACTION" title="" runat="server" CssClass="form-control" Destination="ACTION">
                                <asp:ListItem Value=""></asp:ListItem>
                                <%--<asp:ListItem Value="已完成">已完成</asp:ListItem>
                                <asp:ListItem Value="审批中">审批中</asp:ListItem>--%>
                                <asp:ListItem Value="作废">已作废</asp:ListItem>
                                <asp:ListItem Value="退回">已退回</asp:ListItem>
                            </ult:DropdownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            供应商编号:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_SUPPLIERCODE" runat="server" CssClass="form-control" Destination="SUPPLIERCODE"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                            供应商名称:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_SUPPLIERNAME" runat="server" CssClass="form-control" Destination="SUPPLIERNAME"></ult:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <ult:Button ID="Button1" runat="server" Text="查询" CssClass="btn btn-default " OnBeforeClick="Button1_BeforeClick" />
                </div>
            </div>
            <!-- Table -->
            <div class="padding-l-5 padding-r-5">
                <table class="table table-condensed table-bordered ">
                    <thead>
                        <tr>
                            <th>监控
                            </th>
                            <th>Document No
                            </th>
                            <th>审批状态
                            </th>
                            <th>申请人
                            </th>
                            <th>分店编号
                            </th>
                            <th>分店名称
                            </th>
                            <th>供应商编号
                            </th>
                            <th>供应商名称
                            </th>
                            <th>要求送货日期
                            </th>
                            <th>申请日期
                            </th>
                            <th>申请目的
                            </th>
                            <th>采购类型
                            </th>
                            <th>报价单类型
                            </th>
                            <th>合计金额
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="rptList" Source="" PagerID="AspNetPager1"
                            runat="server">
                            <itemtemplate>
                                <tr>
                                    <td>
                                        <span class="btn btn-icon btn-sm " 
                                                            onclick="window.open('../../../Portal/Ultimus.UWF.Home.V3/TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval("ProcessName").ToString().Trim())%>&Incident=<%#Eval("Incident")%>&ServerName=&t=<%=Guid.NewGuid().ToString()%>');">
                                                            <i class="fa fa-line-chart"></i></span>
                                    </td>
                                    <td>
                                        <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval("FormID") %>','<%#Eval("ProcessName") %>','<%#Eval("Incident") %>');return false;" style="cursor:head">
                                            <%#Eval("DOCUMENTNO")%>
                                            </a>
                                        <%-- <%# JudgmentHandler(Eval("FormID").ToString(),Eval("ProcessName").ToString(),Eval("Incident").ToString(),Eval("ACTION").ToString(),Eval("DOCUMENTNO").ToString()) %>--%>
                                    </td>
                                    <td>
                                        <%#Eval("ACTION").ToString().Contains("退回")?"已退回":Eval("ACTION").ToString().Contains("作废")?"已作废":Eval("COMPLETEDATE")!=DBNull.Value?"已完成":"审批中"%>
                                    </td>
                                    <td>
                                        <%#Eval("APPLICANT")%>
                                    </td>
                                    <td>
                                        <%#Eval("SITECODE")%>
                                    </td>
                                    <td>
                                        <%#Eval("SITENAME")%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERCODE")%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERNAME")%>
                                    </td>
                                     <td>
                                        <%#Eval("DELIVERYDATE")%>
                                    </td>
                                    <td>
                                       <%# Eval("REQUESTDATE")!=DBNull.Value?String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("REQUESTDATE"))):""%>
                                    </td>
                                    <td>
                                        <%#Eval("APPLYPURPOSETXT")%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERTYPETXT")%>
                                    </td>
                                    <td>
                                        <%#Eval("ASSETTYPETXT")%>
                                    </td>
                                    <td>
                                        <%# Eval("AMOUNT")!=DBNull.Value?Convert.ToDouble(Eval("AMOUNT")).ToString("f2"):"0.00"%>
                                    </td>
                                </tr>
                            </itemtemplate>
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

            <br />
            <br />
            <hr />
            <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                    单外审批生成失败记录(食品)/CPR Generate Failed Record(Food)</span>
            </div>
            <div class="padding-l-5 padding-r-5">
                <table class="table table-condensed table-bordered ">
                    <thead>
                        <tr>
                            <th>Document No
                            </th>
                            <th>报价单类型
                            </th>
                            <th>供应商编号
                            </th>
                            <th>供应商名称
                            </th>
                            <th>要求送货日期
                            </th>
                            <th>申请日期
                            </th>
                            <th>PR类型
                            </th>
                            <th>合计金额
                            </th>
                            <th>生成时间
                            </th>
                            <th>生成失败原因
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="ImportFailedRecord" Source="" PagerID="AspNetPager3"
                            runat="server">
                            <itemtemplate>
                                <tr>
                                    <td>
                                        <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval("FormID") %>','<%#Eval("ProcessName") %>','<%#Eval("Incident") %>');return false;" style="cursor:head">
                                            <%#Eval("DOCUMENTNO")%>
                                            </a>
                                    </td>
                                    <td>
                                        <%--test ? expression1 : expression2--%>
                                        <%#Eval("PROCESSNAME").ToString()=="CPR_FOOD"?"食品":Eval("PROCESSNAME").ToString()=="CPR_NONFOOD"?"非食品":"服务"%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERCODE")%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERNAME")%>
                                    </td>
                                    <td>
                                        <%#Eval("DELIVERYDATE")%>
                                    </td>
                                    <td>
                                       <%# Eval("REQUESTDATE")!=DBNull.Value?String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("REQUESTDATE"))):""%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERTYPETXT")%>
                                    </td>
                                    <td>
                                        <%# Eval("AMOUNT")!=DBNull.Value?Convert.ToDouble(Eval("AMOUNT")).ToString("f2"):"0.00"%>
                                        <%--<%#Convert.ToDouble(Eval("AMOUNT")).ToString("f2") %>--%>
                                    </td>
                                    <td>
                                        <%#Eval("CREATEDATE")%>
                                    </td>
                                    <td>
                                        <%--<%#Eval("ERRORMSG")%>--%>
                                        <%# JudgmentCPR_Log(Eval("ERRORMSG").ToString(),Eval("CREATEDATE").ToString()) %>
                                    </td>
                                </tr>
                            </itemtemplate>
                        </ult:Repeater>
                    </tbody>
                </table>
            </div>
            <!-- Pager -->
            <div class="pull-right">
                <webdiyer:AspNetPager ID="AspNetPager3" runat="server" CssClass="asppager"
                    NumericButtonCount="5" CurrentPageButtonClass="btn"
                    FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                    NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                    AlwaysShow="false" PageSize="10">
                </webdiyer:AspNetPager>
            </div>
        </div>
    </form>
    <%=WebUtil.IncludeJsV3() %>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".asppager a").addClass("btn");
            $(".daterangepicker").hide();
        });

        function delConfirm() {
            if (!confirm('<%=Lang.Get("SecurityList_ConfirmDelete")%>')) {
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
