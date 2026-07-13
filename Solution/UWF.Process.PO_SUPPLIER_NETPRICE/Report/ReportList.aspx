<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportList.aspx.cs" Inherits=" UWF.Process.CAPEX_NONFOOD.ReportList" %>
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
    <title>PO SUPPLIER NETPRICE Report</title>
    <link href="../../../common/assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../../../common/assets/css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../../../common/assets/css/shortcuts.css" rel="stylesheet" />
    <link href="../../../common/assets/css/report.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel panel-default">
            <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>供应商净价报表</span>
                <div class="pull-right">
                    <asp:LinkButton ID="lbExport" runat="server" CssClass="btn btn-success" OnClick="lbExport_Click">
                        <i class="fa fa-file-excel-o"></i>导出</asp:LinkButton>
                    <a class="btn" href="javascript:location.href=location.href;"><i class="fa fa-refresh"></i>刷新</a>
                </div>
            </div>

            <div class="panel-body">
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">Document No:</div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_DOCUMENTNO" runat="server" CssClass="form-control" Destination="DOCUMENTNO"></ult:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">供应商名称:</div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_SUPPLIERNAME" runat="server" CssClass="form-control" Destination="SUPPLIERNAME"></ult:TextBox>
                        </div>
                    </div>
                </div>
                  <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">PO号:</div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_PONumber" runat="server" CssClass="form-control" Destination="PONumber"></ult:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">申请日期:</div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_REQUESTDATESTART" data-type="date" runat="server" CssClass="form-control" Destination="Scope.Start.REQUESTDATE"></ult:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-xs-12">
                    <div class="form-group">
                        <div class="col-md-4">-</div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_REQUESTDATEEND" data-type="date" runat="server" CssClass="form-control" Destination="Scope.End.REQUESTDATE"></ult:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:</div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_APPLICANT" runat="server" CssClass="form-control" Destination="APPLICANT"></ult:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <ult:Button ID="Button1" runat="server" Text="查询" CssClass="btn btn-default " />
                </div>
            </div>

            <div class="padding-l-5 padding-r-5">
                <table class="table table-condensed table-bordered ">
                    <thead>
                        <tr>
                            <th>单据号</th>
                            <th>流程名称</th>
                            <th>状态</th>
                            <th>申请人</th>
                            <th>部门</th>
                            <th>申请日期</th>
                            <th>供应商编码</th>
                            <th>供应商名称</th>
                            <th>订单总金额</th>
                            <th>供应商总金额</th>
                            <th>差异金额</th>
                            <th>PO号</th>
                            <th>BATCHNUMBER</th>
                        </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="rptList" Source="BizDB.PO_SUPPLIER_NETPRICE" PagerID="AspNetPager1" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval("FormID") %>','<%#Eval("ProcessName") %>','<%#Eval("Incident") %>');return false;" style="cursor:pointer">
                                            <%#Eval("DOCUMENTNO")%>
                                        </a>
                                    </td>
                                    <td><%#Eval("PROCESSNAME")%></td>
                                  <td>
                                        <%#Eval("ACTION").ToString().Contains("退回")?"已退回":Eval("ACTION").ToString().Contains("作废")?"已作废":Eval("COMPLETEDATE")!=DBNull.Value?"已完成":"审批中"%>
                                    </td>
                                    <td><%#Eval("APPLICANT")%></td>
                                    <td><%#Eval("DEPARTMENT")%></td>
                                    <td><%# Eval("REQUESTDATE")!=DBNull.Value ? String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("REQUESTDATE"))) : ""%></td>
                                    <td><%#Eval("SUPPLIERCODE")%></td>
                                    <td><%#Eval("SUPPLIERNAME")%></td>
                                    <td><%#Eval("TOTALAMOUNTORDER")%></td>
                                    <td><%#Eval("TOTALAMOUNTSUPPLIER")%></td>
                                    <td><%#Eval("TOTALAMOUNTDIFFER")%></td>
                                    <td><%#Eval("PONumber")%></td>
                                    <td><%#Eval("BATCHNUMBER")%></td>
                                </tr>
                            </ItemTemplate>
                        </ult:Repeater>
                    </tbody>
                </table>
            </div>

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

    <%=WebUtil.IncludeJsV3() %>
    <script type="text/javascript">
         $(document).ready(function () {
            $(".asppager a").addClass("btn");
            $(".daterangepicker").hide();
        });
    </script>
    <script type='text/javascript' src='ReportList.js?t=637449425394846796'></script>
</body>
</html>