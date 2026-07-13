<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.PO_Amendment.NewRequest" %>
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
    <title>PO_Amendment</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PO_Amendment_ITEMS = Page.FindControl("fld_detail_PROC_PO_Amendment_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_PO_Amendment_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PO_Amendment_ITEMS = Page.FindControl("fld_detail_PROC_PO_Amendment_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_PO_Amendment_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_PO_Amendment_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="PO_Amendment" processprefix="PROC" tablename="PROC_PO_AMENDMENT"
   tablenamedetail="PROC_PO_AMENDMENT_ITEMS" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PO_Amendment">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table" >
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DOCUMENTNO") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DOCUMENTNO" data-type='string'  title="" onblur="checkExpression(this)" data-field="DOCUMENTNO"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITECODE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.PurchasingPurpose") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PURCHASINGPURPOSE" data-type='string'  title="" onblur="checkExpression(this)" data-field="PURCHASINGPURPOSE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_INITDELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.INITDELIVERYDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_INITDELIVERYDATE" data-type='string'  title="" onblur="checkExpression(this)" data-field="INITDELIVERYDATE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DELIVERYDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DELIVERYDATE" data-type='string'  title="" onblur="checkExpression(this)" data-field="DELIVERYDATE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITENAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITENAME"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_INITAMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.INITAMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_INITAMOUNT" data-type='number'  title="" onblur="checkExpression(this)" data-field="INITAMOUNT"   Variable="" ControlValue="" CssClass="form-control validate[custom[number]]  ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_AMOUNT" data-type='number'  title="" onblur="checkExpression(this)" data-field="AMOUNT"   Variable="" ControlValue="" CssClass="form-control validate[custom[number]]  ReadOnly" runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPREMARK") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPREMARK" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPREMARK"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
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
                        </div>
                    </div>
                </div>
            </div>
            <!--1.2多行-->
                    <!--Start Item table-->
            <div class="row" id="div_panel_PO_Amendment_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PO_AMENDMENT_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PO_AMENDMENT_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class=" td_ARTICLENAME"><%=Lang.Get("UWF.Process.PO_Amendment.ARTICLENAME") %></td>
                                    <td style=""  class=" td_SUBSUBFAMILYCE"><%=Lang.Get("UWF.Process.PO_Amendment.SUBSUBFAMILYCE") %></td>
                                    <td style=""  class=" td_ORDERUNIT"><%=Lang.Get("UWF.Process.PO_Amendment.ORDERUNIT") %></td>
                                    <td style=""  class=" td_SITEPRICE"><%=Lang.Get("UWF.Process.PO_Amendment.SITEPRICE") %></td>
                                    <td style=""  class=" td_INITORDERQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.INITORDERQUANTITY") %></td>
                                    <td style=""  class=" td_ORDERQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.ORDERQUANTITY") %></td>
                                    <td style=""  class=" td_SUBTOTALAMOUNT"><%=Lang.Get("UWF.Process.PO_Amendment.SUBTOTALAMOUNT") %></td>
                                    <td style=""  class=" td_ARTICLECODE"><%=Lang.Get("UWF.Process.PO_Amendment.ARTICLECODE") %></td>
                                    <td style=""  class=" td_ADJUSTMENTQUANTITY"><%=Lang.Get("UWF.Process.PO_Amendment.AdjustmentQuantity") %></td>
                                    <td style="width:60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_PO_AMENDMENT_ITEMS" runat="server">
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
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ARTICLENAME"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ARTICLENAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ARTICLENAME")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYCE" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.SUBSUBFAMILYCE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUBSUBFAMILYCE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUBSUBFAMILYCE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SUBSUBFAMILYCE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ORDERUNIT").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ORDERUNIT"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ORDERUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNIT")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.SITEPRICE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SITEPRICE"  title="" data-type='number' onblur="checkExpression(this)"  data-field="SITEPRICE" CssClass="item-control validate[custom[number]]  ReadOnly" ControlValue='<%#Eval("SITEPRICE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_INITORDERQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.INITORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_INITORDERQUANTITY"  title="" data-type='number' onblur="checkExpression(this)"  data-field="INITORDERQUANTITY" CssClass="item-control validate[custom[number]]  ReadOnly" ControlValue='<%#Eval("INITORDERQUANTITY")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ORDERQUANTITY"  title="" data-type='number' onblur="checkExpression(this)"  data-field="ORDERQUANTITY" CssClass="item-control validate[custom[number]]  ReadOnly" ControlValue='<%#Eval("ORDERQUANTITY")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUBTOTALAMOUNT"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUBTOTALAMOUNT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SUBTOTALAMOUNT")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ARTICLECODE" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.ARTICLECODE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ARTICLECODE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ARTICLECODE" CssClass="item-control  " ControlValue='<%#Eval("ARTICLECODE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ADJUSTMENTQUANTITY" data-label='<%=Lang.Get("UWF.Process.PO_Amendment.AdjustmentQuantity").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ADJUSTMENTQUANTITY"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ADJUSTMENTQUANTITY" CssClass="item-control  " ControlValue='<%#Eval("ADJUSTMENTQUANTITY")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_PO_AMENDMENT_ITEMS',this);}return false;"
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

                        <button onclick="addRow('tb_PO_AMENDMENT_ITEMS');return false;"
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
    <script type='text/javascript' src='NewRequest.js?t=f5ba6b49-1de7-4eff-9970-6ed0e37695f7'></script>
</body>
</html>
