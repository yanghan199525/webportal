<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPRItemPage.aspx.cs" Inherits="PR.PRProcess.CPRFOOD.AddPRItemPage" %>

<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%--<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachmentsCPR.ascx" TagName="Attachments" TagPrefix="attach" %>--%>
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

        .tdrow {
            padding-top: 2px !important;
            padding-bottom: 2px !important;
        }

        @media screen and (max-width: 500px) {
            .task {
                width: 350px !important;
                display: block !important;
            }
        }

        @media screen and (min-width: 500px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row " id="div_panel_CPR">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.CPRFOOD_Items") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CPRNO" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.APPLYREASON") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:dropdownlist id="ddlApplyReason" title="" onblur="checkExpression(this)" data-field="SUPPLIERTYPE" variable="SUPPLIERTYPE" cssclass="form-control  selector validate[required]" source="DataSource.SODEXO_申请理由" filter="" controlvalue="" runat="server">
                                        </ult:dropdownlist>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Article" style="height: ">
                                <div class="form-label">
                                    <%--<%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.ARTICLENAME") %>:--%>
                                    <%=Lang.Get("PR.PRProcess.CPR_FOOD.HISTORYARTICLELIST") %>:
                                
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <%--<ult:textbox id="fld_SITENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="ARTICLENAME" variable="" controlvalue="" cssclass="form-control   " runat="server">
                                    </ult:textbox>--%>
                                        <select id="sltArticle" class="selectpicker form-control" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.FAMILYNAME") %><span style='color: red' id="ddlFamily_span">*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlFamily" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SUBFAMILYNAME") %><span style='color: red' id="ddlSubFamily_span">*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">

                                        <select id="ddlSubFamily" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUBSUBFAMILYNAME" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SUBSUBFAMILYNAME") %><span style='color: red' id="ddlSubSubFamily_span">*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">

                                        <select id="ddlSubSubFamily" class="selectpicker ignoreMe form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_INCOICETYPE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.InvoiceType") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">

                                        <select id="ddlInvoiceType" class="selectpicker ignoreMe form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SUPPLIERNAME") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlSupplier" class="selectpicker form-control validate[required]" data-live-search="true">
                                            <%--<c:forEach item="${item}" var="item">
                                                <option value="${item.SupplierCode}">${item.SupplierNameCN}</option>
                                            </c:forEach>--%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SUPPLIERCODE") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:textbox id="fld_SupplierCode" data-type='string' title="" onblur="checkExpression(this)" data-field="OTHERARTICLENAME" variable="" controlvalue="" cssclass="form-control  validate[required] ReadOnly" runat="server">
                                        </ult:textbox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_HISTORYARTICLELIST" style="height: ">
                                <div class="form-label">
                                    <%--<%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.ARTICLENAME") %>:--%>
                                    <%=Lang.Get("PR.PRProcess.CPR_FOOD.HISTORYARTICLELIST") %>:
                                
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <%--<ult:textbox id="fld_SITENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="ARTICLENAME" variable="" controlvalue="" cssclass="form-control   " runat="server">
                                    </ult:textbox>--%>
                                        <select id="ddlArticle" class="selectpicker form-control" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="height: ">
                                <div class="form-label">
                                    <%--<%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.OTHERARTICLENAME") %>:--%>
                                    <%--其他物品名称:--%>
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.ARTICLENAME") %>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:textbox id="fld_OTHERARTICLENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="OTHERARTICLENAME" variable="" controlvalue="" cssclass="form-control " runat="server">
                                        </ult:textbox>
                                        <select id="ddlArticles" class="selectpicker form-control" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.UNITINFORMATION") %>
                                <%--单位--%>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CPRNO" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.ORDERUNIT") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlOrderUnit" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                        <%--<ult:textbox id="TextBox3" data-type='string' title="" onblur="checkExpression(this)" data-field="CPRNO" variable="" controlvalue="" cssclass="form-control   ReadOnly" runat="server">
                                    </ult:textbox>--%>
                                        <%--<ult:dropdownlist id="ddlOrderUnit" title="" onblur="checkExpression(this)" data-field="ORDERUNIT" variable="ORDERUNIT" cssclass="form-control  selector validate[required]" source="DataSource.SODEXO_采购单位" filter="" controlvalue="" runat="server">
                                    </ult:dropdownlist>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.UNIT") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlUnit" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                        <%--<ult:dropdownlist id="ddlUnit" title="" onblur="checkExpression(this)" data-field="UNIT" variable="UNIT" cssclass="form-control  selector validate[required]" source="DataSource.SODEXO_库存单位" filter="" controlvalue="" runat="server">
                                    </ult:dropdownlist>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.CONSUMPTIONUNIT") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlConsumptionUnit" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                        <%--<ult:dropdownlist id="DropdownList1" title="" onblur="checkExpression(this)" data-field="SUPPLIERTYPE" variable="SUPPLIERTYPE" cssclass="form-control  selector validate[required]" source="DataSource.SODEXO_采购类型" filter="" controlvalue="" runat="server">
                                    </ult:dropdownlist>--%>
                                        <%--<ult:dropdownlist id="ddlConsumptionUnit" title="" onblur="checkExpression(this)" data-field="CONSUMPTIONUNIT" variable="CONSUMPTIONUNIT" cssclass="form-control  selector validate[required]" source="DataSource.SODEXO_库存单位" filter="" controlvalue="" runat="server">
                                    </ult:dropdownlist>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.CONVERSION") %><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:textbox id="fld_CONVERSION" data-type='string' title="" onblur="checkExpression(this)" data-field="CONVERSION" variable="" controlvalue="" cssclass="form-control validate[required,custom[number],positivenumber,funcCall[checkPositiveInteger5]] " runat="server" data-errormessage-type-mismatch="订购与库存单位转换率必须大于0<br />The order to stock unit conversion rate must be greater than 0">
                                        </ult:textbox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6 col-xs-12 form-cell " id="div_field_STOCK" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.STOCK") %>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:textbox id="fld_STOCK" data-type='string' title="" onblur="checkExpression(this)" data-field="STOCK" variable="" controlvalue="" cssclass="form-control  validate[required,custom[number],positivenumber,funcCall[checkPositiveInteger4]]" runat="server" data-errormessage-type-mismatch="库存与消耗单位转换率必须大于0<br />The stock to consumption conversion rate must be greater than 0">
                                        </ult:textbox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height: ">
                                <div class="form-label">
                                </div>
                                <div class="form-field">
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.NETVOMULE") %>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:textbox id="fld_NETVOMULE" data-type='string' title="" onblur="checkExpression(this)" data-field="NETVOMULE" variable="" controlvalue="" cssclass="form-control  validate[required,custom[number]" runat="server">
                                        </ult:textbox>

                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="height: ">
                                <div class="form-label">
                                    <%--<%=Lang.Get("PR.PRProcess.CPR_FOOD.NETWEIGHTUNIT") %>:--%>
                                    <%=Lang.Get("PR.PRProcess.CPR_FOOD.NETVOMULEUNIT") %>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlNetVomule" class="form-control  selector ">
                                            <option value="KG">KG</option>
                                            <option value="L">L</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height: ">
                                <div class="form-label">
                                </div>
                                <div class="form-field">
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_GROSSWEIGHT" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.GROSSWEIGHT") %>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <ult:textbox id="fld_GROSSWEIGHT" data-type='string' title="" onblur="checkExpression(this)" data-field="GROSSWEIGHT" variable="" controlvalue="" cssclass="form-control validate[required,custom[number],positivenumber] " runat="server" data-errormessage-type-mismatch="毛重必须大于0<br />The gross weight must be greater than 0">
                                        </ult:textbox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.CPR_FOOD.GROSSWEIGHTUNIT") %>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlGrossWeight" class="form-control  selector validate[required]">
                                            <option value="KG">KG</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height: ">
                                <div class="form-label">
                                </div>
                                <div class="form-field">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="panel panel-default">

                            <div class="panel-title">
                                <div class="fa-title">
                                    <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                    <%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERINGINFORMATION") %>
                                    <%--采购信息--%>
                                </div>

                                <ul class="panel-tools">
                                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                                </ul>
                            </div>

                            <div class="panel-body form-table">
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CPRNO" style="height: ">
                                    <div class="form-label">
                                        <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SITEPRICE") %><span style='color: red'>*</span>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                            <ult:textbox id="fld_SITEPRICE" title="" data-type='string' onblur="checkExpression(this)" data-field="SITEPRICE" cssclass="form-control validate[required,custom[number],positivenumber,funcCall[checkPositiveInteger2]] " controlvalue='<%#Eval("SITEPRICE")%>' runat="server" data-errormessage-type-mismatch="采购单价必须大于0<br />Purchase unit price must be greater than 0">
                                            </ult:textbox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_NETNETPRICE" style="height: ">
                                    <div class="form-label">
                                        <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.NETNETPRICE") %><span style='color: red'>*</span>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                            <ult:textbox id="fld_NETNETPRICE" title="" data-type='string' onblur="checkExpression(this)" data-field="NETNETPRICE" cssclass="form-control validate[required,custom[number]] " controlvalue='<%#Eval("NETNETPRICE")%>' runat="server">
                                            </ult:textbox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height: ">
                                    <div class="form-label">
                                        <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.ORDERQUANTITY") %><span style='color: red'>*</span>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                            <ult:textbox id="fld_ORDERQUANTITY" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERQUANTITY" cssclass="form-control  validate[required,custom[number],positivenumber,funcCall[checkPositiveInteger1]] " controlvalue='<%#Eval("ORDERQUANTITY")%>' runat="server" data-errormessage-type-mismatch="采购数量必须大于0<br />Purchase quantity must be greater than 0">
                                            </ult:textbox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height: ">
                                    <div class="form-label">
                                    </div>
                                    <div class="form-field">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="hidden">
                <asp:HiddenField ID="hdCategory" runat="server" />
                <asp:HiddenField ID="hdSiteCode" runat="server" />
                <asp:HiddenField ID="hdSupplierType" runat="server" />
                <asp:HiddenField ID="hdSupplierCode" runat="server" />
                <asp:HiddenField ID="hdFamilyCode" runat="server" />
                <asp:HiddenField ID="hdSupplierName" runat="server" />
                <asp:HiddenField ID="hdUserName" runat="server" />
                <asp:HiddenField ID="hdLanguage" runat="server" />
                <asp:HiddenField ID="hdSubSubFamilyCe" runat="server" />
                 <asp:HiddenField ID="TaxCode" runat="server" />
                 <asp:HiddenField ID="TaxRate" runat="server" />
                <asp:HiddenField ID="hdSubFamilyCode" runat="server" />
                <asp:HiddenField ID="hdAuthorizedSupplierCode" runat="server" />
                <asp:HiddenField ID="hdSubSubFamilyCode" runat="server" />
                <asp:HiddenField ID="hdArticleCode" runat="server" />
                <asp:HiddenField ID="hiddenTAXNOMYLASTCODE" runat="server" />
            </div>
        </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>
    <%--<script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/select2-master/dist/js/select2.full.min.js" type="text/javascript"></script>
    <link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/select2-master/dist/css/select2.min.css" rel="stylesheet" />--%>
    <script type="text/javascript" src='AddPRItemPage_.js?t=dc64a1ef-95e5-4fb4-a793-a14f2004d88479999'></script>
    <script type="text/javascript" src="PurchaseUnit.js"></script>
</body>
</html>
