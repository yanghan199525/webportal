<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cataLogInfo.aspx.cs" Inherits="UWF.Process.PR_QUOTATION.FormV1.cataLogInfo" %>

<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>CPR Report</title>
    <%--   <link href="../css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/report.css" rel="stylesheet" />
    <link href="../css/shortcuts.css" rel="stylesheet" />--%>

    <link href="../../../common/assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../../../common/assets/css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../../../common/assets/css/shortcuts.css" rel="stylesheet" />
    <link href="../../../common/assets/css/report.css" rel="stylesheet" />

    <%--   <link href="../css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/report.css" rel="stylesheet" />
    <link href="../css/shortcuts.css" rel="stylesheet" />--%>
    <link href="../../../common/assets/css/root.css" rel="stylesheet" />
    <style>
        body {
            background-color: white;
        }

        .CataLogArticle {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed; /* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */
        }

        .CataLogArticle tr td {
            width: 200px;
            text-align: center;
            height: 15px;
            line-height: 15px;
            overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
            white-space: nowrap; /* 不换行 */
            text-overflow: ellipsis; /* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/
        }

        .CataLogArticle tr th {
            width: 200px;
            text-align: center;
            height: 15px;
            line-height: 15px;
        }

        /*table tr td:hover {
                    overflow: visible;
                }*/
    </style>
</head>
<body style="overflow-x: auto;">
    <form id="form1" runat="server">
        <div style="width: 100%; height: 50px; line-height: 50px; background-color: #6699CC; text-align: center !important">
            <h4 style="line-height: 50px;">报价单物料信息</h4>
        </div>
        <div class="panel panel-default" id="CataLog_list">

            <!-- Panel Search -->
            <div class="panel-body">
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4" style="text-align:right">
                            议价供应商:
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txt_upstreamSupplierCode" runat="server" CssClass="form-control" Destination="upstreamSupplierCode"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4"style="text-align:right">
                            物料:
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txt_ArticleCode" runat="server" CssClass="form-control" Destination="ArticleCode"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4"style="text-align:right">
                            物料子类:
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txt_FamilyName" runat="server" CssClass="form-control" Destination="FamilyName"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4"style="text-align:right">
                            负责人:
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txt_Purchaser" runat="server" CssClass="form-control" Destination="Purchaser"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4"style="text-align:right">
                            城市:
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txt_City" runat="server" CssClass="form-control" Destination="City"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4"style="text-align:right">
                            区域:
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txt_Region" runat="server" CssClass="form-control" Destination="Region"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-xs-12 padding-b-5">
                    <asp:Button ID="btn_Serch" runat="server" Text="查询" CssClass="btn btn-default " OnBeforeClick="Button1_BeforeClick" OnClick="btn_Serch_Click" />
                </div>
            </div>

            <%--        <div class="panel-heading padding-t-5 padding-b-15">
                <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                    报价单信息</span>
            </div>--%>
            <div class="padding-l-5 padding-r-5" style="width: 100%; height: 400px; overflow-y: auto; overflow-x: auto;">
                <table class="table table-condensed table-bordered CataLogArticle" id="cataLogTable" >
                    <thead>
                        <tr>
                            <th>状态
                                <span style="font-size: 12px; color: blue; font-weight: normal" id="radioBtn">
                                    <input type="radio" name="CheckApproved" id="CheckAgreeRadio" value="0" checked onclick="CheckAgree()" />同意
                                     <input type="radio" id="CheckRejectRadio" name="CheckApproved" value="1" onclick="CheckReject()" />拒绝
                                </span>

                            </th>
                            <th>备注
                            </th>
                            <th>议价供应商编号
                            </th>
                            <th>议价供应商名称
                            </th>
                            <%-- <th>物流供应商编号
                            </th>
                            <th>物流供应商名称
                            </th>
                            <th>付款供应商编号
                            </th>
                            <th>付款供应商名称
                            </th>--%>
                            <th>物料编号
                            </th>
                            <th>物料名称
                            </th>
                            <%--<th>物料子子类别
                            </th>--%>
                            <th>物料分类
                            </th>
                            <th>单位
                            </th>
                            <%--  <th>分店编号
                            </th>
                            <th>分店名称
                            </th>--%>
                            <th>负责人
                            </th>
                            <%--  <th>物流分类
                            </th>
                            <th>供应商扣点
                            </th>
                            <th>物流扣点
                            </th>--%>
                            <th>城市
                            </th>
                            <th>区域
                            </th>
                            <th>本期目录价
                            </th>
                            <th>产品利润
                            </th>
                            <th>供应商价格
                            </th>
                            <th>本期未税结算价
                            </th>
                            <th>票种
                            </th>
                            <th>税率
                            </th>
                            <th>供应商扣点
                            </th>
                            <th>物流扣点
                            </th>
                            <th>开始时间
                            </th>
                            <th>结束时间
                            </th>
                            <%-- <th>ZDS1
                            </th>--%>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="CataLogReport"
                            runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td style="display: none" class="ApprovalNo">
                                        <%#Eval("ApprovalNo")%>
                                    </td>
                                    <td style="display: none" class="PreviewId">
                                        <%#Eval("PreviewId")%>
                                    </td>
                                    <td>
                                        <input class="checkBtn" type="button" value=" <%#Eval("isAgree")%>" style="color: blue; border: none" />
                                    </td>
                                    <td>
                                        <input type="text" class="Remark" value="<%#Eval("remark")%>" />
                                    </td>
                                    <td>
                                        <%#Eval("isAgree")%>
                                    </td>
                                    <td>
                                        <%#Eval("remark")%>
                                    </td>
                                    <%-- <td>
                                       <%#Eval("PricingNo")%>
                                    </td>--%>
                                    <td>
                                        <%#Eval("upstreamSupplierCode")%>
                                    </td>
                                    <td>
                                        <%#Eval("UpstreamSupplierName")%>
                                    </td>
                                    <%--  <td>
                                       <%#Eval("DeliverySupplierCode")%>
                                    </td>
                                     <td>
                                       <%#Eval("DeliverySupplierName")%>
                                    </td>
                                     <td>
                                       <%#Eval("PaymentSupplierCode")%>
                                    </td>
                                      <td>
                                       <%#Eval("PaymentSupplierName")%>
                                    </td>--%>
                                    <td>
                                        <%#Eval("articleCode")%>
                                    </td>
                                    <td>
                                        <%#Eval("ArticleName")%>
                                    </td>
                                    <%-- <td>
                                       <%#Eval("subSubFy")%>
                                    </td>--%>
                                    <td>
                                        <%#Eval("FamilyName")%>-<%#Eval("subSubFyName")%>
                                    </td>
                                    <td>
                                        <%#Eval("unit")%>
                                    </td>
                                    <%-- <td>
                                       <%#Eval("siteCode")%>
                                    </td>
                                     <td>
                                       <%#Eval("SiteName")%>
                                    </td>--%>
                                    <td>
                                        <%#Eval("Purchaser")%>
                                    </td>

                                    <%-- <td>
                                       <%#Eval("LogisticCategory")%>
                                    </td>
                                    <td>
                                       <%#Eval("SupplierDeduction")%>
                                    </td>
                                    <td>
                                       <%#Eval("DeliveryDeduction")%>
                                    </td>--%>
                                    <td class="cityClass">
                                        <%#Eval("City")%>
                                    </td>
                                    <td>
                                        <%#Eval("Region")%>
                                    </td>
                                    <td>
                                        <%#Eval("CurrentCatalogCalPrice")%>
                                    </td>
                                    <td>
                                        <%#Eval("productProfit")%>
                                    </td>
                                    <td>
                                        <%#Eval("supplierPrice")%>
                                    </td>
                                    <td>
                                        <%#Eval("CurrentUntaxedUpPrice")%>
                                    </td>
                                    <td>
                                        <%#Eval("TaxCode")%>
                                    </td>
                                    <td>
                                        <%#Eval("TaxRate")%>
                                    </td>
                                    <td>
                                        <%#Eval("SupplierDeduction")%>
                                    </td>
                                    <td>
                                        <%#Eval("DeliveryDeduction")%>
                                    </td>
                                    <td>
                                        <%#Eval("startTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("startTime"))):""%>
                                    </td>
                                    <td>
                                        <%#Eval("endTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("endTime"))):""%>
                                    </td>
                                    <%-- <td>
                                      <%#Eval("ZDS1")%>
                                    </td>--%>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <!-- Pager -->
            <div class="pull-right">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" PageSize="500" CssClass="asppager"
                    AlwaysShow="true" OnPageChanged="AspNetPager1_PageChanged"
                    ShowCustomInfoSection="Right" FirstPageText="首页" LastPageText="尾页"
                    PrevPageText="上一页" NextPageText="下一页">
                </webdiyer:AspNetPager>
            </div>
            <div class="panel-body padding-b-20" style="text-align: center">
                <asp:LinkButton ID="btnSend" runat="server" OnClick="btnSubmit_Click" OnClientClick="returnValue1();" CssClass="btn btn-default">保存</asp:LinkButton>
                <asp:LinkButton ID="btnClose" runat="server" OnClick="closeForm_Click" OnClientClick="closeForm();" CssClass="btn btn-default">关闭</asp:LinkButton>
            </div>
        </div>
        <asp:HiddenField ID="hdIncident" runat="server" />
        <asp:HiddenField ID="hdCheckApproved" runat="server" />
        <%=WebUtil.IncludeJsV3() %>
        <script src="js/colResizable-1.6.min.js"></script>
        <script src='js/CataLogInfo.js?t=f6de543f9-e5a5-4e5S4-edn-86ds2weyd3srgf209eesf5789w76566d'></script>

    </form>
</body>
</html>
