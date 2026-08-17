<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.MPR_SERVICE.NewRequest" %>
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
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MPR_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_MPR_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_MPR_SERVICE_ITEMS.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MPR_SERVICE_ITEMS = Page.FindControl("fld_detail_PROC_MPR_SERVICE_ITEMS") as Ultimus.UWF.Form.WebControls.Repeater;
            if(fld_detail_PROC_MPR_SERVICE_ITEMS.Items.Count==0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_MPR_SERVICE_ITEMS,1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="MPR_SERVICE" processprefix="" tablename="PROC_MPR_SERVICE"
   tablenamedetail="PROC_MPR_SERVICE_ITEMS" runat="server"></ui:userinfo>
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
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.MPR_SERVICE.MPR_SERVICE") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
                                    <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
                                        <div class="form-label">
                                            <%=Lang.Get("UWF.Process.MPR_SERVICE.SITECODE") %>:
                                        </div>
                                        <div class="form-field">
                                            <div class="form-ctl">
                                                    <ult:TextBox ID="fld_SITECODE" data-type='string' title="" onblur="" data-field="SITECODE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                                    </ult:TextBox>
                                            </div>
                                        </div>
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
            <div class="row" id="div_panel_MPR_SERVICE_ITEMS">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-title">
                            <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("UWF.Process.MPR_SERVICE.MPR_SERVICE_ITEMS") %></div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>
                        <div class="panel-body">
                            <!--Start detail table-->
                            <table id="tb_MPR_SERVICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                                <thead>
                                    <tr>
                                        <td class="hidden">
                                            <input id="tb_MPR_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                        </td>
                                        <td class="th_no" style="width: 50px">
                                            <%=Lang.Get("No") %>
                                        </td>
                                            <td style=""  class=" td_ARTICLECODE"><%=Lang.Get("UWF.Process.MPR_SERVICE.ARTICLECODE") %></td>
                                        <td style="width: 60px"><%=Lang.Get("Action") %></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <ult:Repeater ID="fld_detail_PROC_MPR_SERVICE_ITEMS" runat="server">
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
                                        <td class=" td_ARTICLECODE" data-label='<%=Lang.Get("UWF.Process.MPR_SERVICE.ARTICLECODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ARTICLECODE" title="" data-type='string' onblur=""  data-field="ARTICLECODE" CssClass="item-control  " ControlValue='<%#Eval("ARTICLECODE")%>' runat="server">
                                                </ult:TextBox>

                                        </td>
                                            <td>
                                                <a onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteRow('tb_MPR_SERVICE_ITEMS',this);}return false;"
                                                    class="btn btn-icon btn-sm">
                                                    <i class="fa fa-trash"></i>
                                                </a>

                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </ult:repeater>
                                </tbody>
                            </table>
                            <div class="padding-t-5"></div>

                            <a onclick="addRow('tb_MPR_SERVICE_ITEMS');return false;" runat="server" id="btn_MPR_SERVICE_ITEMS"
                            class="btn btn-icon btn-default hidden-print">
                                <%=Lang.Get("Form_AddRow") %></a>
                        </div>
                        <!--End detail table-->
                    </div>
                </div>
            </div>
            <!--End Item table-->

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
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=f25f0bfe-0706-4b02-bf50-783e4ad02b14'></script>
    <script type='text/javascript' src='NewRequest.js?t=8b62c1a2-75d3-4426-933a-d6ea38451b0e'></script>
</body>
</html>
