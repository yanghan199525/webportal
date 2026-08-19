<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ArticleList.aspx.cs" Inherits="PR.PRProcess.CPR_SERVICE.ArticleList" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="Ultimus.UWF.Form.ProcessControl.V3" %>
<%@ Import Namespace="Ultimus.UWF.Workflow.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Add CPR Items</title>
    <!-- ========== Css Files ========== -->

    <link href="../../../common/assets/css/root.css" rel="stylesheet" />
     <style>
        body {
            background-color: #fff;
           
        }
         .SearchNumber {
             margin-top:1%;
             margin-left:4%;
             margin-bottom:1%;
         }
        .tdrow {
            padding-top: 2px !important;
            padding-bottom: 2px !important;
        }

        @media screen and (max-width: 1024px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }

        @media screen and (min-width: 1024px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="background-color:white;">
    <div style="width:100%;height:50px;">
            <div class="panel-body SearchNumber" style="margin: 10%,15%; height: 30px; line-height: 30px;">
                <div style="padding: 5%,10%;">
                    <div class="col-md-11 col-sm-6 col-xs-12">
                    <div class="col-md-4 col-sm-6 col-xs-12" >
                        <div class="form-group">
                            <div class="col-md-4" style=" width:100px">
                                <%=Lang.Get("Ultimus.UWF.Form.RFQ_Number") %>
                            </div>
                            <div class="col-md-8">
                                <select id="RFQ_Number" class="selectpicker form-control validate[required]" data-live-search="true" data-width="200px">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12" >
                        <div class="form-group">
                            <div class="col-md-4"  style=" width:100px">
                                <%=Lang.Get("Ultimus.UWF.Form.supplerName") %>
                            </div>
                            <div class="col-md-8">
                                <select id="supplerName" class="selectpicker form-control validate[required]" data-live-search="true" data-width="200px">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12" style="padding-right: 8%">
                        <div class="form-group">
                            <div class="col-md-4" style="padding: 3%,3%;">
                                物品名称：
                            </div>
                            <div class="col-md-8">
                                <input type="text" id="ArticleName" />
                            </div>
                        </div>
                    </div>
                   </div>
                    <div class="col-md-1 col-sm-6 col-xs-12">
                        <asp:Button ID="btn_add" Text="查询" OnClick="btn_Add_Click" OnClientClick="fun()" class="btn btn-icon btn-default hidden-print" runat="server" />
                    </div>
                </div>
            </div>
        </div>
             <div class="ArticleTable">
                <table class="table table-condensed table-bordered ArticleList" id="AtricleList">
                    <thead>
                        <tr>
                            <th>
                                勾选
                            </th>
                            <th>
                                询价单号
                            </th>
                            <th>
                                物料名称
                            </th>
                            <th>
                                物料子类别
                            </th>
                            <th>
                                物料子子类别
                            </th>
                            <th>
                                采购单位
                            </th>
                            <th>
                                采购单价
                            </th>
                            <th style="display:none">
                                 税率  
                            </th>
                            <th>
                                采购数量
                            </th>
                            <th style="display:none">
                               税率  
                            </th>
                            <th style="display:none">
                                税码
                            </th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                            <th style="display:none"></th>
                        </tr>
                    </thead>
                    <tbody class="Articles">
                        <asp:Repeater ID="ArticleSource" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><input style="cursor:pointer" type="checkbox" class="CheckNumber" name="checkBox" value=""/></td>
                                    <td><%#Eval("RFQ_Number")%></td>
                                    <td class="ArticleName"><%#Eval("ArticleName")%></td>
                                    <td><%#Eval("SubFamilyNameCN")%></td>
                                    <td><%#Eval("SubSubFamilyNameCN")%></td>
                                    <td><%#Eval("OrderUnitCN")%></td>
                                    <td><%#Eval("SitePrice")!=DBNull.Value?Convert.ToDouble(Eval("SitePrice")).ToString("f2"):"0.00"%></td>
                                       <td style="display:none" class="InvoiceType"><%#Eval("InvoiceTypeDesc")%></td>
                                    <td>
                                        <input type="text" style="border-style:none;cursor:pointer" class="OrderLimt" value="<%#Eval("OrderLimit")!=DBNull.Value?Convert.ToDouble(Eval("OrderLimit")).ToString("f2"):"0.00"%>" />
                                    </td>
                                    <td style="display:none"><%#Eval("FamilyCode")%></td>
                                    <td style="display:none"><%#Eval("FamilyName")%></td>
                                    <td style="display:none"><%#Eval("ArticleCode")%></td>
                                    <td style="display:none"><%#Eval("SubFamilyCode")%></td>
                                    <td style="display:none"><%#Eval("SubSubFamilyCode")%></td>
                                     <td style="display:none"><%#Eval("SupplierCode")%></td>
                                     <td style="display:none"><%#Eval("SupplierName")%></td>
                                    <td style="display:none"><%#Eval("OrderUnitAbbr")%></td>
                                    <td style="display:none"><%#Eval("BaseUnitAbbr")%></td>
                                    <td style="display:none"><%#Eval("BaseUnitCN")%></td>
                                    <td style="display:none"><%#Eval("UOM_Pur2InvRate")%></td>
                                    <td style="display:none"><%#Eval("UOM_Inv2UseRate")%></td>
                                    <td style="display:none"><%#Eval("NetVolume")%></td>
                                    <td style="display:none"><%#Eval("NetVolumeUnit")%></td>
                                    <td style="display:none"><%#Eval("Gross_weight")%></td>
                                    <td style="display:none"><%#Eval("NetNetPrice")%></td>
                                    <td style="display:none" class="initOrderLimt"><%#Eval("OrderLimit")%></td>
                                   
                                     <td style="display:none" class="TaxCode"><%#Eval("TaxCode")%></td>
                                     <td style="display:none" class="TaxRate"><%#Eval("TaxRate")%></td>
                                     <td style="display:none" class="ID"><%#Eval("ID")%></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        <div class="hidden">
                <asp:HiddenField ID="hdSiteCode" runat="server" />
                <asp:HiddenField ID="hdSupplierCode" runat="server"/>
                <asp:HiddenField ID="hdLanguage" runat="server" />
                <asp:HiddenField ID="HdRFQ_Number" runat="server" />
                <asp:HiddenField ID="HdsupplerName" runat="server" />
                <asp:HiddenField ID="HdFamilyName" runat="server" />
                <asp:HiddenField ID="HdArticleName" runat="server" />
               <asp:HiddenField ID="supplierNameCN" runat="server" />
            </div>
    </form>  
<%=WebUtil.IncludeJsV3() %>
<script src='ArticleList.js?t=feb6e0a6-7bd6-4bb1-9a2b-df8439e327ds'></script>
</body>
</html>
