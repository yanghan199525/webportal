<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PO_SUPPLIER_SUMMARY.Approval" %>

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
    <title><%=Lang.Get(Request.QueryString["ProcessName"]) %></title>
    <script runat="server">
            protected void Page_Load(object sender, EventArgs e)
            {
                ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
                buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(Process);

                Ultimus.UWF.Form.WebControls.Repeater read_detail_PROC_PO_SUPPLIER_SUMMARY_ITEMS = Page.FindControl("read_detail_PROC_PO_SUPPLIER_SUMMARY_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
                AfterLoad();
            }
     
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="PO_SUPPLIER_SUMMARY" processpefix="PSS" tablename="PROC_PO_SUPPLIER_SUMMARY"
            tablenamedetail="PROC_PO_SUPPLIER_SUMMARY_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="hidden row" id="div_panel_PO_SUPPLIER_SUMMARY">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.PO_SUPPLIER_SUMMARY") %>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        
                        <div class="col-lg-12 col-sm-6 col-xs-12 form-cell hidden" id="div_field_BATCHNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.BATCHNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_BATCHNUMBER" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <!--补充空单元格-->
                       <%-- <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs addCell2" style="height: ">
                            <div class="form-label">
                            </div>
                            <div class="form-field">
                            </div>
                        </div>--%>

                    </div>
                </div>
            </div>
        </div>
        <!--1.2多行-->
        <!--Start Item table-->
        <div class="row" id="div_panel_PO_SUPPLIER_SUMMARY_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.PO_SUPPLIER_SUMMARY_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <div class="inputContainer padding-t-5" style="width: 100%">
                            <!--Start detail table-->
                            <table id="tb_PO_SUPPLIER_SUMMARY_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                                <thead>
                                    <tr>
                                        <td style="text-align: left; vertical-align: middle;">
                                            <input style="cursor: pointer; margin-right: 5px; vertical-align: middle;" type="checkbox" id="ch_btn" onclick="ch_click()" name="checkBox" checked /><span style="vertical-align: middle;"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.ISALLOW") %></span>
                                        </td>
                                        <td style="" class="hidden"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.FORMID") %></td>
                                        <td style="" class="  td_REASONS"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.REASONS") %></td>
                                        <td style="" class="  td_SUPPLIERCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SUPPLIERCODE") %></td>
                                        <td style="" class="  td_SUPPLIERNAME"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SUPPLIERNAME") %></td>
                                        <td style="" class="  td_COMPANYCODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.COMPANYCODE") %></td>
                                        <td style="" class="  td_TOTALAMOUNTORDER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TOTALAMOUNTORDER") %></td>
                                          <td style="" class="  td_TOTALAMOUNTSUPPLIER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TOTALAMOUNTSUPPLIER") %></td>
                                        <td style="" class="  td_TOTALAMOUNTDIFFER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TOTALAMOUNTDIFFER") %></td>
                                      
                                        <td style="" class="hidden  td_STATECODE"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.STATECODE") %></td>
                                        <td style="" class="hidden  td_BATCHNUMBER"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.BATCHNUMBER") %></td>
                                        <td style="" class="hidden  td_ROWGUID"><%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.ROWGUID") %></td>
                                        <td style="width: 60px"><%=Lang.Get("Action") %></td>
                                    </tr>
                                </thead>
                                <tbody class="Articles">
                                    <ult:Repeater ID="read_detail_PROC_PO_SUPPLIER_SUMMARY_ITEMS" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class=" td_ISALLOW" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.ISALLOW").Split('<')[0] %>'>
                                                    <ult:CheckBox ID="fld_ISALLOW" title="" data-type='string' data-field="ISALLOW" CssClass="item-checkbox" runat="server"  Format="" Width="90%" Checked="true"></ult:CheckBox>
                                                </td>
                                                <td class="hidden">
                                                    <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                </td>
                                                <td class=" td_REASONS" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.REASONS").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_REASONS" title="" data-type='radio' data-field="REASONS" runat="server" CssClass="validate[required]" Text='<%#Eval("REASONS")%>' Format="" Width="90%"></ult:TextBox>
                                                </td>
                                                <td class=" td_SUPPLIERCODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SUPPLIERCODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUPPLIERCODE" title="" data-type='string' data-field="SUPPLIERCODE" runat="server" Text='<%#Eval("SUPPLIERCODE")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_SUPPLIERNAME" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.SUPPLIERNAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUPPLIERNAME" title="" data-type='string' data-field="SUPPLIERNAME" runat="server" Text='<%#Eval("SUPPLIERNAME")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_COMPANYCODE" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.COMPANYCODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_COMPANYCODE" title="" data-type='string' data-field="COMPANYCODE" runat="server" Text='<%#Eval("COMPANYCODE")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_TOTALAMOUNTORDER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TOTALAMOUNTORDER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TOTALAMOUNTORDER" title=""  data-field="TOTALAMOUNTORDER" runat="server" Text='<%#Eval("TOTALAMOUNTORDER")%>' Format="" CssClass="autonumber"   Width="90%"></ult:Label>
                                                </td>
                                                 <td class=" td_TOTALAMOUNTSUPPLIER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TOTALAMOUNTSUPPLIER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TOTALAMOUNTSUPPLIER" title=""  data-field="TOTALAMOUNTSUPPLIER" runat="server" Text='<%#Eval("TOTALAMOUNTSUPPLIER")%>' CssClass="autonumber"  Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_TOTALAMOUNTDIFFER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.TOTALAMOUNTDIFFER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_TOTALAMOUNTDIFFER" title=""  data-field="TOTALAMOUNTDIFFER" runat="server" Text='<%#Eval("TOTALAMOUNTDIFFER")%>' CssClass="autonumber"  Format="" Width="90%"></ult:Label>
                                                </td>
                                               
                                                <td class="hidden td_STATECODE"  data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.STATECODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_STATECODE" title="" data-type='string' data-field="STATECODE" runat="server" Text='<%#Eval("STATECODE")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_BATCHNUMBER" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.BATCHNUMBER").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_BATCHNUMBER" title="" data-type='string' data-field="BATCHNUMBER" runat="server" Text='<%#Eval("BATCHNUMBER")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class="hidden td_ROWGUID" data-label='<%=Lang.Get("UWF.Process.PO_SUPPLIER_SUMMARY.ROWGUID").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ROWGUID" title="" data-type='string' data-field="ROWGUID" runat="server" Text='<%#Eval("ROWGUID")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td>
                                                    <button onclick="showview('<%#Eval("SUPPLIERCODE")%>','<%#Eval("BATCHNUMBER")%>');return false;" name="showbnt" class="btn btn-icon btn-default">
                                                        <%=Lang.Get("SecurityDetail_Detail") %></button>

                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </ult:Repeater>
                                </tbody>
                            </table>
                        </div>
                        <div class="padding-t-5"></div>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>
        <!--End Item table-->
        <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
        <asp:HiddenField ID="approvalType" Value="0" runat="server" />
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=c7ce841e-377b-4f20-82cd-5dbce75fc400'></script>
    <script type='text/javascript' src='Approval.js?t=119054c2-263c-4c56-ba64-d5589aa0531c'></script>
</body>
</html>
