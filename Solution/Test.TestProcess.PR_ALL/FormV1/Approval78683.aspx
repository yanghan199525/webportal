<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval78683.aspx.cs" Inherits="UWF.Process.CPR_ALL.Approval78683" %>
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
            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
        }

    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
            <ui:userinfo id="UserInfo1" processtitle="CPR_ALL" processpefix="" tablename="PROC_CPR_ALL"
   tablenamedetail="" runat="server"></ui:userinfo>
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

                            <!--补充空单元格-->

                        </div>
                    </div>
                </div>
            </div>
            <!--1.1单行-->
            <div class="row" id="div_panel_CPR_Takumi">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.CPR_ALL.CPR_Takumi") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.APPLYPURPOSE") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_APPLYPURPOSE" title="" data-type='string' Format="" Variable="APPLYPURPOSE" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.SUPPLIERTYPE") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_SUPPLIERTYPE" title="" data-type='string' Format="" Variable="" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.SITECODE") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_SITECODE" title="" data-type='string' Format="" Variable="" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.SITENAME") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_SITENAME" title="" data-type='string' Format="" Variable="" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.DELIVERYDATE") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_DELIVERYDATE" title="" data-type='date' Format="" Variable="" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height:">
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
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.SUPPLIERNAME") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_SUPPLIERNAME" title="" data-type='string' Format="" Variable="" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ASSETTYPE" style="height:">
                                         <div class="form-label">
                                        <%=Lang.Get("UWF.Process.CPR_ALL.ASSETTYPE") %>:
                                    </div>
                                    <div class="form-field">
                                        <div class="form-ctl">
                                                <ult:Label ID="read_ASSETTYPE" title="" data-type='string' Format="" Variable="" runat="server">
                                                </ult:Label>
                                        </div>
                                    </div>
                                    
                                </div>

                            <!--补充空单元格-->

                                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs addCell3" style="height:">
                                    <div class="form-label">
                                    </div>
                                    <div class="form-field">
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
	<script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=725d0141-0c69-4597-acff-2fcf231265f1'></script>
    <script type='text/javascript' src='Approval78683.js?t=873379b3-bbeb-475f-8b8f-8ae57bc02030'></script>
</body>
</html>
