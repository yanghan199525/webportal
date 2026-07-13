<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.CPR_ALL.NewRequest" %>

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
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_CPR_all_Items = Page.FindControl("fld_detail_PROC_CPR_all_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_CPR_all_Items.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_CPR_all_Items = Page.FindControl("fld_detail_PROC_CPR_all_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            if (fld_detail_PROC_CPR_all_Items.Items.Count == 0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_CPR_all_Items, 1);
            }
        }
    </script>
</head>
<body>

        <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="CPR_ALL" processpefix="" tablename="PROC_CPR_ALL"
            tablenamedetail="PROC_CPR_ALL_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_CPR_ALL">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("UWF.Process.CPR_ALL.CPR_ALL") %>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.CPR_ALL.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_SUPPLIERCODE" title="" data-type='string' Format="" Variable="" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.CPR_ALL.AMOUNT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:Label ID="read_AMOUNT" title="" data-type='string' Format="" Variable="AMOUNT" runat="server">
                                    </ult:Label>
                                </div>
                            </div>

                        </div>

                        <!--补充空单元格-->

                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs addCell3" style="height: ">
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
        <div class="row" id="div_panel_CPR_ALL_ITEMS">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.CPR_ALL.CPR_ALL_ITEMS") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <div class="inputContainer padding-t-5" style="width: 100%">
                            <!--Start detail table-->
                            <table id="tb_CPR_ALL_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                                <thead>
                                    <tr>
                                        <td class="hidden">
                                            <input id="tb_CPR_ALL_ITEMS_rowCount" type="text" runat="server" />
                                        </td>
                                        <td style="width: 50px">
                                            <%=Lang.Get("No") %>
                                        </td>
                                        <td style="" class="  td_ARTICLECODE"><%=Lang.Get("UWF.Process.CPR_ALL.ARTICLECODE") %></td>
                                        <td style="width: 60px"><%=Lang.Get("Action") %></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <ult:Repeater ID="read_detail_PROC_CPR_ALL_ITEMS" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="hidden">
                                                    <ult:Label ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                                </td>
                                                <td data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                    <div class="index"><%#Eval("ROWNO")%> </div>
                                                    <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'>
                                                    </ult:TextBox>
                                                    <ult:TextBox ID="fld_ROWGUID" data-field="ROWGUID" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWGUID")%>'>
                                                    </ult:TextBox>
                                                </td>
                                                <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("UWF.Process.CPR_ALL.ARTICLENAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ARTICLENAME" title="" data-type='string' data-field="ARTICLENAME" runat="server" Text='<%#Eval("ARTICLENAME")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_FAMILYNAME" data-label='<%=Lang.Get("UWF.Process.CPR_ALL.FAMILYNAME").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_FAMILYNAME" title="" data-type='string' data-field="FAMILYNAME" runat="server" Text='<%#Eval("FAMILYNAME")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_PRICE" data-label='<%=Lang.Get("UWF.Process.CPR_ALL.PRICE").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_PRICE" title="" data-type='string' data-field="PRICE" runat="server" Text='<%#Eval("PRICE")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("UWF.Process.CPR_ALL.ORDERUNIT").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERUNIT" title="" data-type='string' data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERUNIT")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("UWF.Process.CPR_ALL.ORDERQUANTITY").Split('<')[0] %>'>
                                                    <ult:Label ID="fld_ORDERQUANTITY" title="" data-type='string' data-field="ORDERUNIT" runat="server" Text='<%#Eval("ORDERQUANTITY")%>' Format="" Width="90%"></ult:Label>
                                                </td>
                                                <td></td>
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

    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=5dadf7ea-3554-484d-9adb-43dbad6b6a97'></script>
    <script type='text/javascript' src='NewRequest.js?t=25886b4a-6259-4529-92b9-fe22f3777ae3'></script>
</body>
</html>
