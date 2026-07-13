<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.CAPEX_SERVICE.NewRequest" %>
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
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_CAPEX_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_CAPEX_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_CAPEX_SERVICE_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_CAPEX_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_CAPEX_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_CAPEX_SERVICE_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_CAPEX_SERVICE_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="CAPEX_SERVICE" processprefix="" tablename="PROC_CAPEX_SERVICE"
   tablenamedetail="PROC_CAPEX_SERVICE_ITEMS" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
           <!--1.1单行-->
        <div class="row" id="div_panel_CAPEX_SERVICE">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CAPEX_SERVICE") %>
                        </div>

                        <ul class="panel-tools">
                            <li>
                                <a class="icon minimise-tool">
                                    <i class="fa fa-minus"></i>
                                </a>
                            </li>
                            <li>
                                <a class="icon expand-tool">
                                    <i class="fa fa-expand"></i>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">

                        <!-- SITECODE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITECODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SITECODE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- SITENAME -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SITENAME" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- AMOUNT -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.AMOUNT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_AMOUNT" data-type='number' title="" onblur="checkExpression(this)" data-field="AMOUNT" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- SUPPLIERCODE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERCODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- SUPPLIERNAME -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERNAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- CAPEXNUMBER -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CAPEXNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CAPEXNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_CAPEXNUMBER" data-type='string' title="" onblur="checkExpression(this)" data-field="CAPEXNUMBER" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- CONTRACTDATE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CONTRACTDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CONTRACTDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_CONTRACTDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="CONTRACTDATE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- DEPRECIATIONDATE -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DEPRECIATIONDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.DEPRECIATIONDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_DEPRECIATIONDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="DEPRECIATIONDATE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- UPLOADS -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_UPLOADS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.UPLOADS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_UPLOADS" data-type='string' title="" onblur="checkExpression(this)" data-field="UPLOADS" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- ISCOR -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISCOR" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ISCOR") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISCOR" data-type='string' title="" onblur="checkExpression(this)" data-field="ISCOR" Variable="ISCOR" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <!-- ISCORName -->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISCORName" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ISCORName") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISCORName" data-type='string' title="" onblur="checkExpression(this)" data-field="ISCORName" Variable="ISCORName" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--1.2多行-->
        <!--Start Item table-->
        <div class="row" id="div_panel_CAPEX_SERVICE_Items">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-bars"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.CAPEX_SERVICE_Items") %>
                        </div>

                        <ul class="panel-tools">
                            <li>
                                <a class="icon minimise-tool">
                                    <i class="fa fa-minus"></i>
                                </a>
                            </li>
                            <li>
                                <a class="icon expand-tool">
                                    <i class="fa fa-expand"></i>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <table id="tb_CAPEX_SERVICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_CAPEX_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width: 50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLECODE") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLENAME") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.FAMILYNAME") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.PCPRICE") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERQTY") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERUNIT") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.AMOUNT") %>
                                    </td>
                                     <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.DELIVERYDATE") %>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle;">
                                        <input style="cursor: pointer; margin-right: 5px; vertical-align: middle;" type="checkbox" id="ch_needaccept" onclick="ckneedaccept_click()" name="checkBox" /><span style="vertical-align: middle;"><%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.NEEDACCEPT") %></span>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ASSETCLASS") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ACCEPTMARK") %>
                                    </td>
                                    <td>
                                        <%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.USEFULLIFE") %>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle;">
                                        <input style="cursor: pointer; margin-right: 5px; vertical-align: middle;" type="checkbox" id="ch_buybackterm" onclick="ckbuybackterm_click()" name="checkBox" /><span style="vertical-align: middle;"><%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.BUYBACKTERM") %></span>
                                    </td>
                                    <td style="text-align: left; vertical-align: middle;">
                                        <input style="cursor: pointer; margin-right: 5px; vertical-align: middle;" type="checkbox" id="ch_removable" onclick="ckremovable_click()" name="checkBox" /><span style="vertical-align: middle;"><%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.REMOVABLE") %></span>
                                    </td>

                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_CAPEX_SERVICE_ITEMS" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="hidden">
                                                <ult:TextBox ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                </ult:TextBox>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLECODE") %>'>
                                                <ult:Label ID="fld_ARTICLECODE" data-field="ARTICLECODE" runat="server" ControlValue='<%#Eval("ARTICLECODE")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ARTICLENAME") %>'>
                                                <ult:Label ID="fld_ARTICLENAME" data-field="ARTICLENAME" runat="server" ControlValue='<%#Eval("ARTICLENAME")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.FAMILYNAME") %>'>
                                                <ult:Label ID="fld_FAMILYNAME" data-field="FAMILYNAME" runat="server" ControlValue='<%#Eval("FAMILYNAME")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.PCPRICE") %>'>
                                                <ult:Label ID="fld_PCPRICE" data-field="PCPRICE" runat="server" ControlValue='<%#Eval("PCPRICE")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERQTY") %>'>
                                                <ult:Label ID="fld_ORDERQTY" data-field="ORDERQTY" runat="server" ControlValue='<%#Eval("ORDERQTY")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ORDERUNIT") %>'>
                                                <ult:Label ID="fld_ORDERUNIT" data-field="ORDERUNIT" runat="server" ControlValue='<%#Eval("ORDERUNIT")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.AMOUNT") %>'>
                                                <ult:Label ID="fld_AMOUNT" data-field="AMOUNT" runat="server" ControlValue='<%#Eval("AMOUNT")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.DELIVERYDATE") %>'>
                                                <ult:Label ID="fld_DELIVERYDATE" data-field="DELIVERYDATE" runat="server" ControlValue='<%#Eval("DELIVERYDATE")%>'>
                                                </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.NEEDACCEPT") %>'>
                                                <ult:CheckBox ID="fld_NEEDACCEPT" data-field="NEEDACCEPT"  CssClass="ckneedacceptItem" runat="server" ControlValue='<%#Eval("NEEDACCEPT")%>'></ult:CheckBox>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ASSETCLASS") %>'>
                                                <ult:Label ID="fld_ASSETCLASS" data-field="ASSETCLASS"  runat="server" ControlValue='<%#Eval("ASSETCLASS")%>'> </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.ACCEPTMARK") %>'>
                                                <ult:Label ID="fld_ACCEPTMARK" data-field="ACCEPTMARK" runat="server" ControlValue='<%#Eval("ACCEPTMARK")%>'> </ult:Label>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.USEFULLIFE") %>'>
                                                <ult:TextBox ID="fld_USEFULLIFE" data-field="USEFULLIFE" CssClass="form-control" runat="server" ControlValue='<%#Eval("USEFULLIFE")%>' />
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.BUYBACKTERM") %>'>
                                                <ult:CheckBox ID="fld_BUYBACKTERM" data-field="BUYBACKTERM" CssClass="ckbuybacktermitem" runat="server" ControlValue='<%#Eval("BUYBACKTERM")%>'></ult:CheckBox>
                                            </td>
                                            <td data-label='<%=Lang.Get("PR.PRProcess.CAPEX_SERVICE.REMOVABLE") %>'>
                                                <ult:CheckBox ID="fld_REMOVABLE" data-field="REMOVABLE" CssClass="ckremovableitem" runat="server" ControlValue='<%#Eval("REMOVABLE")%>'></ult:CheckBox>
                                            </td>

                                        </tr>
                                    </ItemTemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>

                        <button id="btnAddCPRItems" onclick="addPRItemsRow('tb_CAPEX_SERVICE_ITEMS');return false;"
                            class="btn btn-icon btn-default hidden-print">
                            <%=Lang.Get("Form_AddRow") %>
                        </button>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>

        <attach:attachments id="Attachments1" runat="server"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

        <div class="hidden">
            <asp:TextBox ID="txt_Judge1" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt_Judge2" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt_Judge3" runat="server"></asp:TextBox>
        </div>
    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=fcf57a07-45c8-4032-a9d8-85a62b44025e'></script>
    <script type='text/javascript' src='NewRequest.js?t=f9190013-d463-43a4-bdf3-35b02e7330dc'></script>
</body>
</html>
