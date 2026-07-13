<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="PR.PRProcess.PRHK_FOOD_NONFOOD.NewRequest" %>
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
    <title>PRHK_FOOD_NONFOOD</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="PRHK_FOOD_NONFOOD" processprefix="HKCPR" tablename="PROC_PRHK_FOOD_NONFOOD"
   tablenamedetail="PROC_PRHK_FOOD_NONFOOD_ITEMS" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PRHK_FOOD_NONFOOD">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.PRHK_FOOD_NONFOOD") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table" >
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.DOCUMENTNO") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DOCUMENTNO" data-type='string'  title="" onblur="checkExpression(this)" data-field="DOCUMENTNO"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.PurchasingPurpose") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PURCHASINGPURPOSE" data-type='string'  title="" onblur="checkExpression(this)" data-field="PURCHASINGPURPOSE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITECODE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITENAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITENAME"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.DELIVERYDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DELIVERYDATE" data-type='string'  title="" onblur="checkExpression(this)" data-field="DELIVERYDATE"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
        <%-- <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_AMOUNT" data-type='string'  title="" onblur="checkExpression(this)" data-field="AMOUNT"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>--%>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Requirement" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.Requirement") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_REQUIREMENT" data-type='string'  title="" onblur="checkExpression(this)" data-field="REQUIREMENT"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.APPREMARK") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPREMARK" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPREMARK"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_AMOUNT" data-type='string'  title="" onblur="checkExpression(this)" data-field="AMOUNT"   Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.APPROVEDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPROVEDATE" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPROVEDATE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>
             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.APPROVE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPROVE" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPROVE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
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
            <div class="row" id="div_panel_PRHK_FOOD_NONFOOD_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.PRHK_FOOD_NONFOOD_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PRHK_FOOD_NONFOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PRHK_FOOD_NONFOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="hidden td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ARTICLECODE") %></td>
                                    <td style=""  class=" td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ARTICLENAME") %></td>
                                    <td style=""  class=" td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SUBSUBFAMILYNAME") %></td>
                                    <td style=""  class="hidden td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SUBSUBFAMILYCODE") %></td>
                                    <td style=""  class=" td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ORDERUNIT") %></td>
                                    <td style=""  class=" td_SITEPRICE"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SITEPRICE") %></td>
                                    <td style=""  class=" td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ORDERQUANTITY") %></td>
                                    <td style=""  class=" td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SUBTOTALAMOUNT") %></td>
                                    <td style="width:60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_PRHK_FOOD_NONFOOD_ITEMS" runat="server">
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
                                            <td class="hidden td_ARTICLECODE" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ARTICLECODE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ARTICLECODE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ARTICLECODE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ARTICLECODE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ARTICLENAME"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ARTICLENAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ARTICLENAME")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUBSUBFAMILYNAME"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUBSUBFAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYNAME")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SUBSUBFAMILYCODE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUBSUBFAMILYCODE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUBSUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCODE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ORDERUNIT").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ORDERUNIT"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ORDERUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNIT")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SITEPRICE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SITEPRICE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SITEPRICE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SITEPRICE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.ORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_ORDERQUANTITY"  title="" data-type='string' onblur="checkExpression(this)"  data-field="ORDERQUANTITY" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERQUANTITY")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.PRHK_FOOD_NONFOOD.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUBTOTALAMOUNT"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUBTOTALAMOUNT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SUBTOTALAMOUNT")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_PRHK_FOOD_NONFOOD_ITEMS',this);}return false;"
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

                        <button onclick="addRow('tb_PRHK_FOOD_NONFOOD_ITEMS');return false;"
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
    <script type='text/javascript' src='NewRequest.js?t=d45f823f-f769-4b6d-ad9b-3aebab9e87bb'></script>
    <script type='text/javascript' src='math_common.js?t=dc64a1ef-95e5-4fb4-a793-a14f354d8a33'></script>
    <script src="math_common.js"></script>
     <script type="text/javascript">
         $(function () {
             //员工编号 进行显示
    $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
             var Amount = $("#fld_AMOUNT").val();
             $("#fld_AMOUNT").val(thousands(Amount));
             $("#fld_AMOUNT").next("span").text($("#fld_AMOUNT").val());
             $("#tb_PRHK_FOOD_NONFOOD_ITEMS").find("thead").find("td:last").addClass("hidden");
             $("#tb_PRHK_FOOD_NONFOOD_ITEMS").find("tbody").find("td:last").addClass("hidden");
             $(".td_ORDERQUANTITY").find("span").each(function (index, element) {
                 $(this).text(thousands($(this).text()));
             })
             // td_SITEPRICE
               $(".td_SITEPRICE").find("span").each(function (index, element) {
                   $(this).text(thousands($(this).text()));
             })
             //td_SUBTOTALAMOUNT
               $(".td_SUBTOTALAMOUNT").find("span").each(function (index, element) {
                   $(this).text(thousands($(this).text()));
             })
         })
      
    </script>
</body>
</html>
