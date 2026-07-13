<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportList.aspx.cs" Inherits="PR.PRProcess.OR_CPR_NONFOOD.ReportList" %>
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
    <title>OR_CPR_NONFOOD Report</title>
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
                    OR_CPR_NONFOOD报表</span>
                <div class="pull-right">
                    <asp:LinkButton ID="lbExport" runat="server" CssClass="btn btn-success" OnClick="lbExport_Click">
                        <i class="fa fa-file-excel-o"></i>导出</asp:LinkButton>
                    <a class="btn" href="javascript:location.href=location.href;"><i class="fa fa-refresh"></i>刷新</a>
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
                            采购目的:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_PurchasingPurpose" runat="server" CssClass="form-control" Destination="PurchasingPurpose"></ult:TextBox>
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
                            要求送货时间:
                        </div>
                        <div class="col-md-8">
                            <ult:TextBox ID="txt_DELIVERYDATE" runat="server" CssClass="form-control" Destination="DELIVERYDATE"></ult:TextBox>
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
                    <ult:Button ID="Button1" runat="server" Text="查询" CssClass="btn btn-default " />
                </div>
            </div>
            <!-- Table -->
            <div class="padding-l-5 padding-r-5">
                <table class="table table-condensed table-bordered ">
                    <thead>
                        <tr>
                            <th>Document No
                            </th>
                            <th>申请人
                            </th>
                            <th>部门
                            </th>
                            <th>申请日期
                            </th>
                        <th>采购申请单号
                            </th>
                        <th>采购目的
                            </th>
                        <th>分店编号
                            </th>
                        <th>分店名称
                            </th>
                        <th>要求送货时间
                            </th>
                        <th>供应商编号
                            </th>
                        <th>供应商名称
                            </th>
                        <th>一级加签人
                            </th>
                        <th>二级加签人
                            </th>
                        <th>三级加签人
                            </th>
                        <th>总金额
                            </th>
                        <th>是否固定资产
                            </th>
                        <th>申请备注
                            </th>
                        <th>要求送货日期参数
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <ult:Repeater ID="rptList" Source="BizDB.PROC_OR_CPR_NONFOOD" PagerID="AspNetPager1"
                            runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval("FormID") %>','<%#Eval("ProcessName") %>','<%#Eval("Incident") %>');return false;" style="cursor:head">
                                            <%#Eval("DOCUMENTNO")%>
                                            </a>
                                    </td>
                                    <td>
                                        <%#Eval("APPLICANT")%>
                                    </td>
                                    <td>
                                        <%#Eval("DEPARTMENT")%>
                                    </td>
                                    <td>
                                       <%# Eval("REQUESTDATE")!=DBNull.Value?String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("REQUESTDATE"))):""%>
                                    </td>
                                    <td>
                                        <%#Eval("DOCUMENTNO")%>
                                    </td>
                                    <td>
                                        <%#Eval("PurchasingPurpose")%>
                                    </td>
                                    <td>
                                        <%#Eval("SITECODE")%>
                                    </td>
                                    <td>
                                        <%#Eval("SITENAME")%>
                                    </td>
                                    <td>
                                        <%#Eval("DELIVERYDATE")%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERCODE")%>
                                    </td>
                                    <td>
                                        <%#Eval("SUPPLIERNAME")%>
                                    </td>
                                    <td>
                                        <%#Eval("USER_SIGNEDAPPROVER")%>
                                    </td>
                                    <td>
                                        <%#Eval("USER_SIGNEDAPPROVER2")%>
                                    </td>
                                    <td>
                                        <%#Eval("USER_SIGNEDAPPROVER3")%>
                                    </td>
                                    <td>
                                        <%#Eval("POAmount")%>
                                    </td>
                                    <td>
                                        <%#Eval("IsCapex")%>
                                    </td>
                                    <td>
                                        <%#Eval("APPREMARK")%>
                                    </td>
                                    <td>
                                        <%#Eval("DELIVERY")%>
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
    <%=WebUtil.IncludeJsV3() %>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".asppager a").addClass("btn");
            $(".daterangepicker").hide();
        });
    </script>
    <script type='text/javascript' src='ReportList.js?t=637662656144710390'></script>
</body>
</html>
