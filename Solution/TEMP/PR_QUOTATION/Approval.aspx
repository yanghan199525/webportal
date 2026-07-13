<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PR_QUOTATION.Approval" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>PR_QUOTATION</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="PR_QUOTATION" processprefix="PR" tablename="PROC_PR_QUOTATION"
            tablenamedetail="" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PR_QUOTATION">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.PR_QUOTATION.PR_QUOTATION") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_VendorCode" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.VendorCode") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_VENDORCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ProductNo" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.ProductNo") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PRODUCTNO" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_OrderingUnit" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.OrderingUnit") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_ORDERINGUNIT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_siteCode" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.siteCode") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ValidFrom" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.ValidFrom") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_VALIDFROM" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ValidTo" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.ValidTo") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_VALIDTO" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Region" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.Region") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_REGION" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingZone" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.PurchasingZone") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PURCHASINGZONE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TaxRate" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.TaxRate") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_TAXRATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_LogisticCategory" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.LogisticCategory") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_LOGISTICCATEGORY" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_LogisticsWithholding" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.LogisticsWithholding") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_LOGISTICSWITHHOLDING" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CatalogPrice" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.CatalogPrice") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_CATALOGPRICE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CalculationUntaxedPrice" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.CalculationUntaxedPrice") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_CALCULATIONUNTAXEDPRICE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PaymentSupplier" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PR_QUOTATION.PaymentSupplier") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PAYMENTSUPPLIER" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
            
            <!--补充空单元格-->

                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height:">
                                <div class="form-label">
                                </div>
                                <div class="form-field">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <attach:attachments id="Attachments1" runat="server" ReadOnly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=6dc44f82-9704-4151-bcf7-427da79989d4'></script>
</body>
</html>
