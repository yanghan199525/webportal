<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval24.aspx.cs" Inherits="PR.PRProcess.CPR_FOOD.Approval24" %>
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
    <title>CPR_FOOD</title>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
     <ui:userinfo id="UserInfo1" processtitle="CPR_FOOD" processpefix="CPRF" tablename="PROC_CPR_FOOD"
            tablenamedetail="PROC_CPRFOOD_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_CPR_FOOD">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.CPR_FOOD") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.APPLYPURPOSE") %><span style='color:red'>*</span>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPLYPURPOSE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SUPPLIERTYPE") %><span style='color:red'>*</span>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SUPPLIERTYPE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITENAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.DELIVERYDATE") %><span style='color:red'>*</span>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERYDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SUPPLIERCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SUPPLIERCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SUPPLIERNAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SUPPLIERNAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.ASSETTYPE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_ASSETTYPE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                    <ult:Label ID="read_AMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-12 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.APPREMARK") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPREMARK" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.APPROVEDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PCCOMPCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.PCCOMPCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PCCOMPCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLYPURPOSETXT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.APPLYPURPOSETXT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPLYPURPOSETXT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SUPPLIERTYPETXT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SUPPLIERTYPETXT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SUPPLIERTYPETXT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPETXT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.ASSETTYPETXT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_ASSETTYPETXT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CPRFAMILYCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.CPRFAMILYCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_CPRFAMILYCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PURCHASINGAGENT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.PURCHASINGAGENT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PURCHASINGAGENT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ONLINEORSUPERMARKET" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.ONLINEORSUPERMARKET") %><span style='color:red'>*</span>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_ONLINEORSUPERMARKET" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SignedApprover" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.USER_SignedApprover") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SignedApprover2" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.USER_SignedApprover2") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER2" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SignedApprover3" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.USER_SignedApprover3") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER3" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApproverName" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.USER_SignedApproverName") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVERNAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover2Name" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.USER_SignedApprover2Name") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER2NAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover3Name" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.USER_SignedApprover3Name") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_USER_SIGNEDAPPROVER3NAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SIGNEDAPPROVERNUMBER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.SIGNEDAPPROVERNUMBER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SIGNEDAPPROVERNUMBER" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.DELIVERY") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERY" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("PR.PRProcess.CPR_FOOD.APPROVE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPROVE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
            
            <!--补充空单元格-->

                        </div>
                    </div>
                </div>
            </div>
            <!--1.2多行-->
                    <!--Start Item table-->
            <div class="row" id="div_panel_CPRFOOD_Items">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.CPR_FOOD.CPRFOOD_Items") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_CPRFOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_CPRFOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width:50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style=""  class="  td_APPLYREASON"><%=Lang.Get("PR.PRProcess.CPR_FOOD.APPLYREASON") %><span style='color:red'>*</span></td>
                                    <td style=""  class="hidden  td_FAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.FAMILYCODE") %></td>
                                    <td style=""  class="hidden  td_FAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_FOOD.FAMILYNAME") %></td>
                                    <td style=""  class="hidden  td_SUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBFAMILYCODE") %></td>
                                    <td style=""  class="hidden  td_SUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBFAMILYNAME") %></td>
                                    <td style=""  class="hidden  td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBSUBFAMILYCODE") %></td>
                                    <td style=""  class="  td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBSUBFAMILYNAME") %></td>
                                    <td style=""  class="  td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.CPR_FOOD.ARTICLENAME") %></td>
                                    <td style=""  class="hidden  td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.ARTICLECODE") %></td>
                                    <td style=""  class="  td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERUNIT") %></td>
                                    <td style=""  class="hidden  td_UNIT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.UNIT") %></td>
                                    <td style=""  class="hidden  td_CONSUMPTIONUNIT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.CONSUMPTIONUNIT") %></td>
                                    <td style=""  class="hidden  td_CONVERSION"><%=Lang.Get("PR.PRProcess.CPR_FOOD.CONVERSION") %></td>
                                    <td style=""  class="hidden  td_STOCK"><%=Lang.Get("PR.PRProcess.CPR_FOOD.STOCK") %></td>
                                    <td style=""  class="hidden  td_NETVOMULE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.NETVOMULE") %></td>
                                    <td style=""  class="hidden  td_GROSSWEIGHT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.GROSSWEIGHT") %></td>
                                    <td style=""  class="hidden  td_NETVOMULEUNIT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.NETVOMULEUNIT") %></td>
                                    <td style=""  class="hidden  td_GROSSWEIGHTUNIT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.GROSSWEIGHTUNIT") %></td>
                                    <td style=""  class="  td_SITEPRICE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.SITEPRICE") %><span style='color:red'>*</span></td>
                                    <td style=""  class="  td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERQUANTITY") %></td>
                                    <td style=""  class="hidden  td_ORDERUNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERUNITVALUE") %></td>
                                    <td style=""  class="hidden  td_UNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.UNITVALUE") %></td>
                                    <td style=""  class="hidden  td_CONSUMPTIONUNITVALUE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.CONSUMPTIONUNITVALUE") %></td>
                                    <td style=""  class="hidden  td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBTOTALAMOUNT") %></td>
                                    <td style=""  class="hidden  td_NETNETPRICE"><%=Lang.Get("PR.PRProcess.CPR_FOOD.NETNETPRICE") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="read_detail_PROC_CPRFOOD_ITEMS" runat="server">
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
                                            <td class=" td_APPLYREASON" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.APPLYREASON").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_APPLYREASON" title="" data-field="APPLYREASON" runat="server" Text='<%#Eval("APPLYREASON")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_FAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.FAMILYCODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_FAMILYCODE" title="" data-field="FAMILYCODE" runat="server" Text='<%#Eval("FAMILYCODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_FAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.FAMILYNAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_FAMILYNAME" title="" data-field="FAMILYNAME" runat="server" Text='<%#Eval("FAMILYNAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_SUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBFAMILYCODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBFAMILYCODE" title="" data-field="SUBFAMILYCODE" runat="server" Text='<%#Eval("SUBFAMILYCODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_SUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBFAMILYNAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBFAMILYNAME" title="" data-field="SUBFAMILYNAME" runat="server" Text='<%#Eval("SUBFAMILYNAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBSUBFAMILYCODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBSUBFAMILYCODE" title="" data-field="SUBSUBFAMILYCODE" runat="server" Text='<%#Eval("SUBSUBFAMILYCODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBSUBFAMILYNAME" title="" data-field="SUBSUBFAMILYNAME" runat="server" Text='<%#Eval("SUBSUBFAMILYNAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLENAME" title="" data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_ARTICLECODE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.ARTICLECODE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLECODE" title="" data-field="ARTICLECODE" runat="server" Text='<%#Eval("ARTICLECODE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERUNIT" title="" data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_UNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.UNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_UNIT" title="" data-field="UNIT" runat="server" Text='<%#Eval("UNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.CONSUMPTIONUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_CONSUMPTIONUNIT" title="" data-field="CONSUMPTIONUNIT" runat="server" Text='<%#Eval("CONSUMPTIONUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_CONVERSION" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.CONVERSION").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_CONVERSION" title="" data-field="CONVERSION" runat="server" Text='<%#Eval("CONVERSION")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_STOCK" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.STOCK").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_STOCK" title="" data-field="STOCK" runat="server" Text='<%#Eval("STOCK")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_NETVOMULE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.NETVOMULE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_NETVOMULE" title="" data-field="NETVOMULE" runat="server" Text='<%#Eval("NETVOMULE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.GROSSWEIGHT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_GROSSWEIGHT" title="" data-field="GROSSWEIGHT" runat="server" Text='<%#Eval("GROSSWEIGHT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_NETVOMULEUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.NETVOMULEUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_NETVOMULEUNIT" title="" data-field="NETVOMULEUNIT" runat="server" Text='<%#Eval("NETVOMULEUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHTUNIT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.GROSSWEIGHTUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_GROSSWEIGHTUNIT" title="" data-field="GROSSWEIGHTUNIT" runat="server" Text='<%#Eval("GROSSWEIGHTUNIT")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.SITEPRICE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SITEPRICE" title="" data-field="SITEPRICE" runat="server" Text='<%#Eval("SITEPRICE")%>' CssClass="autonumber" Width="90%"></ult:Label>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERQUANTITY" title="" data-field="ORDERQUANTITY" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_ORDERUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.ORDERUNITVALUE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERUNITVALUE" title="" data-field="ORDERUNITVALUE" runat="server" Text='<%#Eval("ORDERUNITVALUE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_UNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.UNITVALUE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_UNITVALUE" title="" data-field="UNITVALUE" runat="server" Text='<%#Eval("UNITVALUE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.CONSUMPTIONUNITVALUE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_CONSUMPTIONUNITVALUE" title="" data-field="CONSUMPTIONUNITVALUE" runat="server" Text='<%#Eval("CONSUMPTIONUNITVALUE")%>' Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_SUBTOTALAMOUNT" title="" data-field="SUBTOTALAMOUNT" runat="server" Text='<%#Eval("SUBTOTALAMOUNT")%>' CssClass="autonumber" Width="90%"></ult:Label>
                                            </td>
                                            <td class="hidden td_NETNETPRICE" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.NETNETPRICE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_NETNETPRICE" title="" data-field="NETNETPRICE" runat="server" Text='<%#Eval("NETNETPRICE")%>' CssClass="autonumber" Width="90%"></ult:Label>
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
    <script type='text/javascript' src='Approval24.js?t=c8f01019-3814-414e-850f-581685bce9cc'></script>
</body>
</html>
