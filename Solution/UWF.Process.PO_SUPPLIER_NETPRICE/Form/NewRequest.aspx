<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.PO_SUPPLIER_NETPRICE.NewRequest" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="Ultimus.UWF.Form.ProcessControl.V3" %>
<%@ Import Namespace="Ultimus.UWF.Workflow.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>PO_SUPPLIER_NETPRICE</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS = Page.FindControl("fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS = Page.FindControl("fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="PO_SUPPLIER_NETPRICE" processprefix="" tablename="PROC_PO_SUPPLIER_NETPRICE"
   tablenamedetail="PROC_PO_SUPPLIER_NETPRICE_ITEMS" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PO_SUPPLIER_NETPRICE">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PO_SUPPLIER_NETPRICE") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table" >
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ISALLOW" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ISALLOW") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_ISALLOW" data-type='string'  title="" onblur="checkExpression(this)" data-field="ISALLOW"   Variable="ISALLOW" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_REASONS" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.REASONS") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_REASONS" data-type='string'  title="" onblur="checkExpression(this)" data-field="REASONS"   Variable="REASONS" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SUPPLIERCODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE"   Variable="SUPPLIERCODE" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SUPPLIERNAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SUPPLIERNAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME"   Variable="SUPPLIERNAME" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COMPANYCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.COMPANYCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_COMPANYCODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="COMPANYCODE"   Variable="COMPANYCODE" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TOTALAMOUNTORDER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TOTALAMOUNTORDER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_TOTALAMOUNTORDER" data-type='number'  title="" onblur="checkExpression(this)" data-field="TOTALAMOUNTORDER"   Variable="TOTALAMOUNTORDER" ControlValue="" CssClass="form-control validate[custom[number]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TOTALAMOUNTSUPPLIER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TOTALAMOUNTSUPPLIER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_TOTALAMOUNTSUPPLIER" data-type='number'  title="" onblur="checkExpression(this)" data-field="TOTALAMOUNTSUPPLIER"   Variable="TOTALAMOUNTSUPPLIER" ControlValue="" CssClass="form-control validate[custom[number]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_TOTALAMOUNTDIFFER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TOTALAMOUNTDIFFER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_TOTALAMOUNTDIFFER" data-type='number'  title="" onblur="checkExpression(this)" data-field="TOTALAMOUNTDIFFER"   Variable="TOTALAMOUNTDIFFER" ControlValue="" CssClass="form-control validate[custom[number]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_BATCHNUMBER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_BATCHNUMBER" data-type='string'  title="" onblur="checkExpression(this)" data-field="BATCHNUMBER"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_STATECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.STATECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_STATECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="STATECODE"   Variable="STATECODE" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
            
            <!--补充空单元格-->
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height:">
                                <div class="form-label">
                                </div>
                                <div class="form-field">
                                </div>
                            </div>
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
            <!--1.2多行-->
                    <!--Start Item table-->
            <div class="row" id="div_panel_PO_SUPPLIER_NETPRICE_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PO_SUPPLIER_NETPRICE_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PO_SUPPLIER_NETPRICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PO_SUPPLIER_NETPRICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class=" td_SUPPLIERCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SupplierCode") %></td>
                                    <td style=""  class=" td_PRARTICLECODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PRARTICLECODE") %></td>
                                    <td style=""  class=" td_BATCHNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %></td>
                                    <td style=""  class=" td_PRARTICLENAME"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PRArticleName") %></td>
                                    <td style=""  class=" td_TAXNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxNumber") %></td>
                                    <td style=""  class=" td_GRRECEIVINGQUANTITY"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.GRReceivingQuantity") %></td>
                                    <td style=""  class=" td_TAXRATEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateOrder") %></td>
                                    <td style=""  class=" td_TAXRATESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateSupplier") %></td>
                                    <td style=""  class=" td_TAXRATEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateDiffer") %></td>
                                    <td style=""  class=" td_NETPRICEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceOrder") %></td>
                                    <td style=""  class=" td_NETPRICESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceSupplier") %></td>
                                    <td style=""  class=" td_NETPRICEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceDiffer") %></td>
                                    <td style=""  class=" td_CONTRACTPRICEORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceOrder") %></td>
                                    <td style=""  class=" td_CONTRACTPRICESUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceSupplier") %></td>
                                    <td style=""  class=" td_CONTRACTPRICEDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceDiffer") %></td>
                                    <td style="width:60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_PO_SUPPLIER_NETPRICE_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="hidden">
                                                <ult:TextBox ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>' >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SUPPLIERCODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SupplierCode").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUPPLIERCODE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUPPLIERCODE" CssClass="item-control  " ControlValue='<%#Eval("SUPPLIERCODE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_PRARTICLECODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PRARTICLECODE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_PRARTICLECODE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="PRARTICLECODE" CssClass="item-control  " ControlValue='<%#Eval("PRARTICLECODE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_BATCHNUMBER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_BATCHNUMBER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="BATCHNUMBER" CssClass="item-control  " ControlValue='<%#Eval("BATCHNUMBER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_PRARTICLENAME" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.PRArticleName").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_PRARTICLENAME"  title="" data-type='string' onblur="checkExpression(this)"  data-field="PRARTICLENAME" CssClass="item-control  " ControlValue='<%#Eval("PRARTICLENAME")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_TAXNUMBER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxNumber").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_TAXNUMBER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="TAXNUMBER" CssClass="item-control  " ControlValue='<%#Eval("TAXNUMBER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_GRRECEIVINGQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.GRReceivingQuantity").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_GRRECEIVINGQUANTITY"  title="" data-type='number' onblur="checkExpression(this)"  data-field="GRRECEIVINGQUANTITY" CssClass="item-control validate[custom[number]] " ControlValue='<%#Eval("GRRECEIVINGQUANTITY")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_TAXRATEORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateOrder").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_TAXRATEORDER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="TAXRATEORDER" CssClass="item-control  " ControlValue='<%#Eval("TAXRATEORDER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_TAXRATESUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateSupplier").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_TAXRATESUPPLIER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="TAXRATESUPPLIER" CssClass="item-control  " ControlValue='<%#Eval("TAXRATESUPPLIER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_TAXRATEDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TaxRateDiffer").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_TAXRATEDIFFER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="TAXRATEDIFFER" CssClass="item-control  " ControlValue='<%#Eval("TAXRATEDIFFER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_NETPRICEORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceOrder").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_NETPRICEORDER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="NETPRICEORDER" CssClass="item-control  " ControlValue='<%#Eval("NETPRICEORDER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_NETPRICESUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceSupplier").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_NETPRICESUPPLIER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="NETPRICESUPPLIER" CssClass="item-control  " ControlValue='<%#Eval("NETPRICESUPPLIER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_NETPRICEDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NetPriceDiffer").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_NETPRICEDIFFER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="NETPRICEDIFFER" CssClass="item-control  " ControlValue='<%#Eval("NETPRICEDIFFER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_CONTRACTPRICEORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceOrder").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_CONTRACTPRICEORDER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="CONTRACTPRICEORDER" CssClass="item-control  " ControlValue='<%#Eval("CONTRACTPRICEORDER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_CONTRACTPRICESUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceSupplier").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_CONTRACTPRICESUPPLIER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="CONTRACTPRICESUPPLIER" CssClass="item-control  " ControlValue='<%#Eval("CONTRACTPRICESUPPLIER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_CONTRACTPRICEDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ContractPriceDiffer").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_CONTRACTPRICEDIFFER"  title="" data-type='string' onblur="checkExpression(this)"  data-field="CONTRACTPRICEDIFFER" CssClass="item-control  " ControlValue='<%#Eval("CONTRACTPRICEDIFFER")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_PO_SUPPLIER_NETPRICE_ITEMS',this);}return false;"
                                                    class="btn btn-icon btn-sm">
                                                    <i class="fa fa-trash"></i>
                                                </button>

                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>

                        <button onclick="addRow('tb_PO_SUPPLIER_NETPRICE_ITEMS');return false;"
                            class="btn btn-icon btn-default hidden-print">
                            <%=Lang.Get("Form_AddRow") %></button>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>
        <!--End Item table-->

        <attach:attachments id="Attachments1" runat="server"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='NewRequest.js?t=6365ea86-1fef-4398-b177-90ed69f82814'></script>
</body>
</html>
