<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="PR.PRProcess.MPR_SERVICE.Approval" %>
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
    <title>MPR_SERVICE</title>
</head>
<body>
    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1"
            processtitle="MPR_SERVICE"
            processpefix="PR"
            tablename="PROC_MPR_SERVICE"
            tablenamedetail="PROC_MPR_SERVICE_ITEMS"
            runat="server">
        </ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_MPR_SERVICE">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.MPR_SERVICE.MPR_SERVICE") %>
                        </div>
                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DOCUMENTNO" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.DOCUMENTNO") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_DOCUMENTNO" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.PurchasingPurpose") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_PURCHASINGPURPOSE" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SITECODE" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SITENAME" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.AMOUNT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_AMOUNT" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Requirement" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.Requirement") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_REQUIREMENT" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-8 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.APPREMARK") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_APPREMARK" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.APPROVEDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_APPROVEDATE" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MPR_SERVICE.APPROVE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_APPROVE" title="" Format="" runat="server"></ult:Label>
                                </div>
                            </div>
                        </div>
                        <!--补充空单元格-->
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
        <!--1.2多行-->
        <!--Start Item table-->
        <div class="row" id="div_panel_MPR_SERVICE_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-bars"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.MPR_SERVICE.MMPR_SERVICE_ITEMS") %>
                        </div>
                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_MPR_SERVICE_ITEMS"
                            class="table table-bordered table-condensed form-detail-table form-resp-table"
                            width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_MPR_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td style="width: 50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td class="hidden td_ARTICLECODE">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.ARTICLECODE") %>
                                    </td>
                                    <td class="td_ARTICLENAME">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.ARTICLENAME") %>
                                    </td>
                                    <td class="hidden td_SUBSUBFAMILYCODE">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.SUBSUBFAMILYCODE") %>
                                    </td>
                                    <td class="td_SUBSUBFAMILYNAME">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.SUBSUBFAMILYNAME") %>
                                    </td>
                                    <td class="td_ORDERUNIT">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.ORDERUNIT") %>
                                    </td>
                                    <td class="td_SITEPRICE">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.SITEPRICE") %>
                                    </td>
                                    <td class="td_ORDERQUANTITY">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.ORDERQUANTITY") %>
                                    </td>
                                    <td class="td_SUBTOTALAMOUNT">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.SUBTOTALAMOUNT") %>
                                    </td>
                                    <td class="td_DELIVERYDATE">
                                        <%=Lang.Get("PR.PRProcess.MPR_SERVICE.DELIVERYDATE") %>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <%--移除 OnItemDataBound，不再后台行绑定 --%>
                                <ult:Repeater ID="read_detail_PROC_MPR_SERVICE_ITEMS" runat="server">
                                   <itemtemplate>
                                        <%-- tr不加runat="server"，绑定送货日期自定义属性 --%>
                                        <tr data-deliverydate='<%#Eval("DELIVERYDATE") %>'>
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
                                            <td class="hidden td_ARTICLECODE"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.ARTICLECODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ARTICLECODE"
                                                           title=""
                                                           data-field="ARTICLECODE"
                                                           runat="server"
                                                           Text='<%#Eval("ARTICLECODE")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_ARTICLENAME"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.ARTICLENAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ARTICLENAME"
                                                           title=""
                                                           data-field="ARTICLENAME"
                                                           runat="server"
                                                           Text='<%#Eval("ARTICLENAME")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCODE"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.SUBSUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBSUBFAMILYCODE"
                                                           title=""
                                                           data-field="SUBSUBFAMILYCODE"
                                                           runat="server"
                                                           Text='<%#Eval("SUBSUBFAMILYCODE")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_SUBSUBFAMILYNAME"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBSUBFAMILYNAME"
                                                           title=""
                                                           data-field="SUBSUBFAMILYNAME"
                                                           runat="server"
                                                           Text='<%#Eval("SUBSUBFAMILYNAME")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_ORDERUNIT"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.ORDERUNIT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ORDERUNIT"
                                                           title=""
                                                           data-field="ORDERUNIT"
                                                           runat="server"
                                                           Text='<%#Eval("ORDERUNIT")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_SITEPRICE"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.SITEPRICE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SITEPRICE"
                                                           title=""
                                                           data-field="SITEPRICE"
                                                           runat="server"
                                                           Text='<%#Eval("SITEPRICE")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_ORDERQUANTITY"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.ORDERQUANTITY").Split('<')[0] %>'>
                                                <ult:Label ID="fld_ORDERQUANTITY"
                                                           title=""
                                                           data-field="ORDERQUANTITY"
                                                           runat="server"
                                                           Text='<%#Eval("ORDERQUANTITY")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_SUBTOTALAMOUNT"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                <ult:Label ID="fld_SUBTOTALAMOUNT"
                                                           title=""
                                                           data-field="SUBTOTALAMOUNT"
                                                           runat="server"
                                                           Text='<%#Eval("SUBTOTALAMOUNT")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                            <td class="td_DELIVERYDATE"
                                                data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.DELIVERYDATE").Split('<')[0] %>'>
                                                <ult:Label ID="fld_DELIVERYDATE"
                                                           title=""
                                                           data-field="DELIVERYDATE"
                                                           runat="server"
                                                           Text='<%#Eval("DELIVERYDATE")%>'
                                                           Width="90%">
                                                </ult:Label>
                                            </td>
                                        </tr>
                                   </itemtemplate>
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
        <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=dd99baa9-36d3-4e49-a360-521692f85936'></script>
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
                let num = parseInt($(this).text());
                $(this).text(num);
            });
            // td_SITEPRICE
            $(".td_SITEPRICE").find("span").each(function (index, element) {
                $(this).text(thousands($(this).text()));
            });
            //td_SUBTOTALAMOUNT
            $(".td_SUBTOTALAMOUNT").find("span").each(function (index, element) {
                $(this).text(thousands($(this).text()));
            });

            // ========= JS实现按DELIVERYDATE分组隔行变色 =========
            let lastDelivery = null;
            let colorFlag = 0;
            $("#tb_MPR_SERVICE_ITEMS > tbody > tr").each(function () {
                let currVal = $(this).attr("data-deliverydate");
                //日期发生变化，切换颜色标记
                if (currVal !== lastDelivery) {
                    colorFlag = colorFlag === 0 ? 1 : 0;
                    lastDelivery = currVal;
                }
                //设置背景色，可自行修改色值
                if (colorFlag === 1) {
                    $(this).css("background-color", "#f2f7ff");
                } else {
                    $(this).css("background-color", "#ffffff");
                }
            });
        })
    </script>
</body>
</html>
