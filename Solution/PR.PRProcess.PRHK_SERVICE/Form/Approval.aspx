<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="PR.PRProcess.PRHK_SERVICE.Approval" %>
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
    <title>PRHK_SERVICE</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="PRHK_SERVICE" processpefix="HKCPR" tablename="PROC_PRHK_SERVICE"
            tablenamedetail="PROC_PRHK_SERVICE_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PRHK_SERVICE">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.PRHK_SERVICE") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.DOCUMENTNO") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DOCUMENTNO" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.PurchasingPurpose") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PURCHASINGPURPOSE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITENAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.DELIVERYDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERYDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Requirement" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.Requirement") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_REQUIREMENT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.APPREMARK") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPREMARK" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="Label1" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.APPROVEDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPROVEDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.PRHK_SERVICE.APPROVE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPROVE" title="" Format=""  runat="server">
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
            <div class="row" id="div_panel_PRHK_SERVICE_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.PRHK_SERVICE_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_PRHK_SERVICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_PRHK_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="  td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.ARTICLENAME") %></td>
                                    <td style=""  class="  td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SUBSUBFAMILYNAME") %></td>
                                    <td style=""  class="  td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.ORDERUNIT") %></td>
                                    <td style=""  class="  td_SITEPRICE"><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SITEPRICE") %></td>
                                    <td style=""  class="  td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.ORDERQUANTITY") %></td>
                                    <td style=""  class="  td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SUBTOTALAMOUNT") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="read_detail_PROC_PRHK_SERVICE_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="hidden">
                                                <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>' >
                                                    </ult:TextBox>
                                                <ult:TextBox ID="fld_ROWGUID" data-field="ROWGUID" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWGUID")%>' >
                                                    </ult:TextBox>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("PR.PRProcess.PRHK_SERVICE.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLENAME" title="" data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBSUBFAMILYNAME" title="" data-field="SUBSUBFAMILYNAME" runat="server" Text='<%#Eval("SUBSUBFAMILYNAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.PRHK_SERVICE.ORDERUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERUNIT" title="" data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SITEPRICE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SITEPRICE" title="" data-field="SITEPRICE" runat="server" Text='<%#Eval("SITEPRICE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.PRHK_SERVICE.ORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERQUANTITY" title="" data-field="ORDERQUANTITY" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.PRHK_SERVICE.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBTOTALAMOUNT" title="" data-field="SUBTOTALAMOUNT" runat="server" Text='<%#Eval("SUBTOTALAMOUNT")%>' Width="90%"></ult:Label>
                                            </td>
                                            
                                        </tr>
                                    </ItemTemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>
        <!--End Item table-->
        <attach:attachments id="Attachments1" runat="server" ReadOnly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=c17e0b9b-e23e-4f39-b264-f22235c62767'></script>
    <script type='text/javascript' src='math_common.js?t=dc64a1ef-95e5-4fb4-a793-a14f354d8a33'></script>
    <script src="math_common.js"></script>
     <script type="text/javascript">
         $(function () {
             //员工编号 进行显示
    $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
             var Amount = $("#read_AMOUNT").html();
             $("#read_AMOUNT").html(thousands(Amount));
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
