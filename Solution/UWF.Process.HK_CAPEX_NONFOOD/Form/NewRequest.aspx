<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.CAPEX_NONFOOD.NewRequest" %>
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
    <title>CAPEX_NONFOOD</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS = Page.FindControl("fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="CAPEX_NONFOOD" processprefix="" tablename="PROC_CAPEX_NONFOOD"
   tablenamedetail="PROC_PROC_CAPEX_NONFOOD_ITEMS" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_CAPEX_NONFOOD">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.CAPEX_NONFOOD") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table" >
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITECODE"   Variable="SITECODE" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITENAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITENAME"   Variable="SITENAME" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_AMOUNT" data-type='string'  title="" onblur="checkExpression(this)" data-field="AMOUNT"   Variable="AMOUNT" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CapexNumber" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.CapexNumber") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_CAPEXNUMBER" data-type='string'  title="" onblur="checkExpression(this)" data-field="CAPEXNUMBER"   Variable="CapexNumber" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SupplierCode" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SupplierCode") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SUPPLIERCODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE"   Variable="SupplierCode" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SupplierName" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.SupplierName") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SUPPLIERNAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME"   Variable="SupplierName" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ContractDate" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.ContractDate") %>:
             </div>
             <div class="form-field"><div class="form-ctl">

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DepreciationDate" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.DepreciationDate") %>:
             </div>
             <div class="form-field"><div class="form-ctl">

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Uploads" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.CAPEX_NONFOOD.Uploads") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_UPLOADS" data-type='string'  title="" onblur="checkExpression(this)" data-field="UPLOADS"   Variable="Uploads" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
            
            <!--补充空单元格-->

                        </div>
                    </div>
                </div>
            </div>
            <!--1.2多行-->
                    <!--Start Item table-->
            <div class="row" id="div_panel_PROC_CAPEX_NONFOOD_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.CAPEX_NONFOOD.PROC_CAPEX_NONFOOD_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PROC_CAPEX_NONFOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PROC_CAPEX_NONFOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style="width:60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_PROC_CAPEX_NONFOOD_ITEMS" runat="server">
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
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_PROC_CAPEX_NONFOOD_ITEMS',this);}return false;"
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

                        <button onclick="addRow('tb_PROC_CAPEX_NONFOOD_ITEMS');return false;"
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
    <script type='text/javascript' src='NewRequest.js?t=9fa623fa-7f2e-46cd-8eba-8e0d7c2621ec'></script>
</body>
</html>
