<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="PR.PRProcess.OR_CPR_NONFOOD.NewRequest" %>
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
    <title>OR_CPR_NONFOOD</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_OR_CPR_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_OR_CPR_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_OR_CPR_NONFOOD_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_OR_CPR_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_OR_CPR_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_OR_CPR_NONFOOD_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_OR_CPR_NONFOOD_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="OR_CPR_NONFOOD" processprefix="OR_CPR" tablename="PROC_OR_CPR_NONFOOD"
   tablenamedetail="PROC_OR_CPR_NONFOOD_ITEMS" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_OR_CPR_NONFOOD">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.OR_CPR_NONFOOD") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table" >
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.DOCUMENTNO") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                       <asp:Label ID="txt_DOCUMENTNO" title="" runat="server">
                    </asp:Label>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.PurchasingPurpose") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PURCHASINGPURPOSE" data-type='string'  title="" onblur="checkExpression(this)" data-field="PURCHASINGPURPOSE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITECODE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITENAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITENAME"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.DELIVERYDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <div class="input-prepend input-group">
                         <ult:TextBox ID="fld_DELIVERYDATE"  title="" data-field="DELIVERYDATE" data-type="datetime" Format=""  Variable="" CssClass="form-control validate[custom[dateTimeFormat]]" runat="server">
                        </ult:textbox>
                         <span class="add-on input-group-addon hidden-xs"><i class="fa fa-calendar"></i></span>
                     </div>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SUPPLIERCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SUPPLIERCODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SUPPLIERNAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SUPPLIERNAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.USER_SIGNEDAPPROVER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_USER_SIGNEDAPPROVER" data-type='string'  title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER2" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.USER_SIGNEDAPPROVER2") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_USER_SIGNEDAPPROVER2" data-type='string'  title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER2"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SIGNEDAPPROVER3" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.USER_SIGNEDAPPROVER3") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_USER_SIGNEDAPPROVER3" data-type='string'  title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER3"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_POAmount" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.POAmount") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_POAMOUNT" data-type='number'  title="" onblur="checkExpression(this)" data-field="POAMOUNT"   Variable="" ControlValue="" CssClass="form-control validate[custom[number]]  ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-8 col-sm-6 col-xs-12 form-cell " id="div_field_IsCapex" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.IsCapex") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_ISCAPEX" data-type='string'  title="" onblur="checkExpression(this)" data-field="ISCAPEX"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-12 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.APPREMARK") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPREMARK" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPREMARK"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.DELIVERY") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DELIVERY" data-type='string'  title="" onblur="checkExpression(this)" data-field="DELIVERY"   Variable="DELIVERY" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>
             </div></div>
         </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--1.2多行-->
                    <!--Start Item table-->
            <div class="row" id="div_panel_OR_CPR_NONFOOD_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.OR_CPR_NONFOOD_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_OR_CPR_NONFOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_OR_CPR_NONFOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class=" td_SKUCODE"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SKUCode") %></td>
                                    <td style=""  class=" td_SKUNAME"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SKUName") %></td>
                                    <td style=""  class=" td_MATERIALTYPE"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.MaterialType") %></td>
                                    <td style=""  class=" td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.OrderUnit") %></td>
                                    <td style=""  class=" td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.OrderQuantity") %></td>
                                    <td style=""  class=" td_PRICE"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.Price") %></td>
                                    <td style=""  class=" td_TAXRATE"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.TaxRate") %></td>
                                    <td style=""  class=" td_GOODSAMOUNT"><%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.GoodsAmount") %></td>
                                    <td style="width:60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_OR_CPR_NONFOOD_ITEMS" runat="server">
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
                                            <td class=" td_SKUCODE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SKUCode").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SKUCODE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SKUCODE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SKUCODE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SKUNAME" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.SKUName").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SKUNAME"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SKUNAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SKUNAME")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_MATERIALTYPE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.MaterialType").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_MATERIALTYPE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="MATERIALTYPE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("MATERIALTYPE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.OrderUnit").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ORDERUNIT"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ORDERUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNIT")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.OrderQuantity").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ORDERQUANTITY"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ORDERQUANTITY" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERQUANTITY")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_PRICE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.Price").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_PRICE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="PRICE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("PRICE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_TAXRATE" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.TaxRate").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_TAXRATE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="TAXRATE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("TAXRATE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_GOODSAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.OR_CPR_NONFOOD.GoodsAmount").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_GOODSAMOUNT"  title="" data-type='string' onblur="checkExpression(this)"  data-field="GOODSAMOUNT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GOODSAMOUNT")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_OR_CPR_NONFOOD_ITEMS',this);}return false;"
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

                        <button onclick="addRow('tb_OR_CPR_NONFOOD_ITEMS');return false;"
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
    <script type='text/javascript' src='NewRequest.js?t=a5d86bd5-5e07-4b0c-a771-9e51eac10246'></script>
    <script src="math_common.js"></script>
     <script type="text/javascript">
         $(function () {
             //员工编号 进行显示
    $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
             var Amount = $("#fld_POAMOUNT").val();
             $("#fld_POAMOUNT").val(thousands(Amount));
             $("#fld_POAMOUNT").next("span").text($("#fld_POAMOUNT").val());
             $("#tb_OR_CPR_NONFOOD_ITEMS").find("thead").find("td:last").addClass("hidden");
             $("#tb_OR_CPR_NONFOOD_ITEMS").find("tbody").find("td:last").addClass("hidden");
             $("#Attachments1_actionRow").addClass("hidden");
             $("#fileinfo").find("td:last").addClass("hidden");
             $(".td_ORDERQUANTITY").find("span").each(function (index, element) {
                   num= parseInt($(this).text());
                 $(this).text(num);
             })
             // td_SITEPRICE
               $(".td_PRICE").find("span").each(function (index, element) {
                   $(this).text(thousands($(this).text()));
             })
             //td_SUBTOTALAMOUNT
               $(".td_GOODSAMOUNT").find("span").each(function (index, element) {
                   $(this).text(thousands($(this).text()));
             })
         })
      
    </script>
</body>
</html>
