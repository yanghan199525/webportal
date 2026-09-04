<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.MCPR_SERVICE.NewRequest" %>

<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="atth" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachmentsOC.ascx" TagName="AttachmentAdd" TagPrefix="ath" %>
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
    <title>MCPR_SERVICE</title>
    <style>
        /* 文件选择容器样式 */
        .custom-file-container {
            display: inline-flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            vertical-align: middle;
        }
        /* 自定义选择按钮 */
        .custom-file-btn {
            background-color: #409EFF;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s;
        }

            .custom-file-btn:hover {
                background-color: #66b1ff;
            }
        /* 文件信息显示区域 */
        .file-info {
            padding: 6px 12px;
            min-width: 200px;
            max-width: 400px;
            overflow: hidden;
        }

        .file-name {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            display: inline-block;
        }
        /* 上传按钮样式 */
        .upload-btn {
            background-color: #67c23a;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
            font-size: 14px;
            transition: background-color 0.2s;
        }

            .upload-btn:hover {
                background-color: #85ce61;
            }
        /* 错误提示样式（统一红色） */
        .error {
            font-size: 13px;
        }

        .item-control-invoice-path {
            display: block;
            width: 0;
            height: 0;
            opacity: 0;
        }

        .invoice-path-link {
            display: none;
            margin-left: 8px;
            color: #409EFF;
        }
    </style>
    <script type="text/javascript">
        function onUploadCompleted() {
            var tabId = 'tb_MCPR_SERVICE_ITEMS';
            try {
                var SupplierType = $("#fld_SUPPLIERTYPE").val();
                var tabCtl = document.getElementById(tabId);
                for (var i = 0; i < tabCtl.rows.length; i++) {
                    var existrow = tabCtl.rows[i];
                    var fld_CHECKED = $(existrow).find("input[id*='fld_CHECKED']").is(':checked');
                    if (fld_CHECKED) {
                        $(existrow).find("input[id*='fld_INVOICENUMBER']").val($("#fld_INVOICENUMBER").val());
                        $(existrow).find("input[id*='fld_BUYERNAME']").val($("#fld_BUYERNAME").val());
                        $(existrow).find("input[id*='fld_BUYERTAXID']").val($("#fld_BUYERTAXID").val());
                        $(existrow).find("input[id*='fld_INVOICEPATH']").val($("#fld_INVOICEPATH").val());
                        initInvoiceLinks();
                    }
                }
                hiddenSupplierType();
            }
            catch (e) {
            }
        }
        function initInvoiceLinks() {
            // 遍历所有表体行的INVOICEPATH文本框
            $("#tb_MCPR_SERVICE_ITEMS tbody tr td.td_INVOICEPATH [data-field='INVOICEPATH']").each(function () {
                syncInvoiceLink(this);
            });
        }
        function syncInvoiceLink(textbox) {
            const $textbox = $(textbox);
            const pathValue = $textbox.val().trim();
            const $link = $textbox.next(".invoice-path-link");
            if (pathValue) {
                $link.attr("href", pathValue);
                $link.text(pathValue.split('_').length > 1 ? pathValue.split('_').pop() : pathValue);
                $link.show();
            } else {
                $link.hide();
            }
        }
    </script>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
                buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
                buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);

                Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_Items = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_Items") as Ultimus.UWF.Form.WebControls.Repeater;
                fld_detail_PROC_MCPR_SERVICE_Items.AfterBind += new System.EventHandler(AfterBind);
            }
            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_MCPR_SERVICE_Items = Page.FindControl("fld_detail_PROC_MCPR_SERVICE_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            if (fld_detail_PROC_MCPR_SERVICE_Items.Items.Count == 0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_MCPR_SERVICE_Items, 1);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1"
            processtitle="MCPR_SERVICE"
            processprefix="CPRS"
            tablename="PROC_MCPR_SERVICE"
            tablenamedetail="PROC_MMCPR_SERVICE_ITEMS"
            runat="server">
        </ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
        <!--End 接UserInfo Div的结束标记,请不要删除-->

        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_MCPR_SERVICE">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.MCPR_SERVICE") %>
                        </div>
                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPLYPURPOSE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:DropDownList ID="fld_APPLYPURPOSE"
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="APPLYPURPOSE"
                                        Variable=""
                                        CssClass="form-control selector "
                                        Source="DataSource.SODEXO_申请目的"
                                        Filter=""
                                        ControlValue=""
                                        runat="server"
                                        onchange="changeApplyPurpose()">
                                    </ult:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUPPLIERTYPE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:DropDownList ID="fld_SUPPLIERTYPE"
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SUPPLIERTYPE"
                                        Variable="SUPPLIERTYPE"
                                        CssClass="form-control selector validate[required]"
                                        Source="DataSource.SODEXO_采购类型"
                                        Filter=""
                                        ControlValue=""
                                        runat="server"
                                        onchange="changeSupplierType()">
                                    </ult:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITECODE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SITECODE"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control ReadOnly"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITENAME"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SITENAME"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control ReadOnly"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_ServiceEstimatedFinishTime" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ServiceEstimatedFinishTime") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_ServiceEstimatedFinishTime"
                                            title=""
                                            data-field="ServiceEstimatedFinishTime"
                                            data-type="text"
                                            Format=""
                                            Variable="ServiceEstimatedFinishTime"
                                            CssClass="form-control Wdate validate[required,funcCall[futureFinishTime]]"
                                            runat="server"
                                            data-errormessage-type-mismatch="服务预计完成时间必须大于当天<br/>The estimated service completion time must be greater than the current day"
                                            onClick="WdatePicker({readOnly:false,dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon hidden-xs"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--补充空单元格-->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" style="border-left: 0px; height: " id="SupplementaryBlank">
                            <div class="form-label" style="background-color: transparent;">
                                &nbsp;<br />
                                &nbsp;
                            </div>
                            <div class="form-field">
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERCODE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SUPPLIERCODE"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control validate[required] ReadOnly"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERNAME"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SUPPLIERNAME"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control validate[required] ReadOnly"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ASSETTYPE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ASSETTYPE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="ASSETTYPE"
                                        Variable="ASSETTYPE"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label" id="amount">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.AMOUNT")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_AMOUNT"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="AMOUNT"
                                        Variable="AMOUNT"
                                        ControlValue=""
                                        CssClass="form-control ReadOnly autonumber"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PURCHASINGAGENT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.PURCHASINGAGENT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_PURCHASINGAGENT"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="PURCHASINGAGENT"
                                        Variable="PURCHASINGAGENT"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApproverName" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.USER_SignedApproverName") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVERNAME"
                                            data-type='string'
                                            title=""
                                            onblur="checkExpression(this)"
                                            data-field="USER_SIGNEDAPPROVERNAME"
                                            Variable=""
                                            ControlValue=""
                                            CssClass="form-control ReadOnly"
                                            runat="server">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER"
                                            data-type='string'
                                            title=""
                                            onblur="checkExpression(this)"
                                            data-field="USER_SIGNEDAPPROVER"
                                            Variable="USER_SignedApprover"
                                            ControlValue=""
                                            CssClass="form-control hidden"
                                            runat="server">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon USER_SignedApprover" style="cursor: pointer;" onclick="selectSignedApprover(1,'fld_USER_SIGNEDAPPROVERNAME','','fld_USER_SIGNEDAPPROVER');"><i class="fa fa-search"></i></span>
                                        <span class="add-on input-group-addon" style="cursor: pointer;" onclick="clearSignedApprover()"><i class="fa fa-trash"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover2Name" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.USER_SignedApprover2Name") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER2NAME"
                                            data-type='string'
                                            title=""
                                            onblur="checkExpression(this)"
                                            data-field="USER_SIGNEDAPPROVER2NAME"
                                            Variable=""
                                            ControlValue=""
                                            CssClass="form-control ReadOnly"
                                            runat="server">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER2"
                                            data-type='string'
                                            title=""
                                            onblur="checkExpression(this)"
                                            data-field="USER_SIGNEDAPPROVER2"
                                            Variable="USER_SignedApprover2"
                                            ControlValue=""
                                            CssClass="form-control hidden"
                                            runat="server">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon USER_SignedApprover2" style="cursor: pointer;"><i class="fa fa-search"></i></span>
                                        <span class="add-on input-group-addon" style="cursor: pointer;" onclick="clearSignedApprover2()"><i class="fa fa-trash"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover3Name" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.USER_SignedApprover3Name") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER3NAME"
                                            data-type='string'
                                            title=""
                                            onblur="checkExpression(this)"
                                            data-field="USER_SIGNEDAPPROVER3NAME"
                                            Variable=""
                                            ControlValue=""
                                            CssClass="form-control ReadOnly"
                                            runat="server">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER3"
                                            data-type='string'
                                            title=""
                                            onblur="checkExpression(this)"
                                            data-field="USER_SIGNEDAPPROVER3"
                                            Variable="USER_SignedApprover3"
                                            ControlValue=""
                                            CssClass="form-control hidden"
                                            runat="server">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon USER_SignedApprover3" style="cursor: pointer;"><i class="fa fa-search"></i></span>
                                        <span class="add-on input-group-addon" style="cursor: pointer;" onclick="clearSignedApprover3()"><i class="fa fa-trash"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_INVOICETYPE">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICETYPE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_INVOICETYPE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="INVOICETYPE"
                                        Variable="INVOICETYPE"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_INVOICENUMBER">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICENUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="TextBox1"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="INVOICENUMBER"
                                        Variable="INVOICENUMBER"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_BUYERNAME">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="TextBox2"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="BUYERNAME"
                                        Variable="BUYERNAME"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_BUYERTAXID">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERTAXID") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="TextBox3"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="BUYERTAXID"
                                        Variable="BUYERTAXID"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="hidden col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_FIXEDASSETS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.FIXEDASSETS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:RadioButtonList ID="fld_FIXEDASSETS"
                                        title=""
                                        data-field="FIXEDASSETS"
                                        Variable=""
                                        CssClass=""
                                        Source="DataSource."
                                        Filter=""
                                        ControlValue=""
                                        RepeatDirection="Horizontal"
                                        runat="server">
                                        <asp:ListItem Text="否" Value="02" Selected="True"></asp:ListItem>
                                    </ult:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="hidden col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SHOWREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.CPR_NONFOOD.SHOWREMARK") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:RadioButtonList ID="fld_SHOWREMARK"
                                        title=""
                                        data-field="SHOWREMARK"
                                        Variable=""
                                        CssClass="validate[required]"
                                        Source="DataSource."
                                        Filter=""
                                        ControlValue=""
                                        RepeatDirection="Horizontal"
                                        runat="server">
                                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="否" Value="0" Selected="True"></asp:ListItem>
                                    </ult:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="hidden col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_IsPrePaid" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.IsPrePaid") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:RadioButtonList ID="fld_IsPrePaid"
                                        title=""
                                        data-field="IsPrePaid"
                                        Variable="IsPrePaid"
                                        CssClass="validate[required]"
                                        Source="DataSource."
                                        Filter=""
                                        ControlValue=""
                                        RepeatDirection="Horizontal"
                                        runat="server">
                                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="否" Value="0" Selected="True"></asp:ListItem>
                                    </ult:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_INVOICEPATH" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.INVOICEPATH") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="TextBox4"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="INVOICEPATH"
                                        Variable="INVOICEPATH"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height: 50px">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPREMARK")  %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPREMARK"
                                        title=""
                                        data-field="APPREMARK"
                                        data-type='string'
                                        Format=""
                                        Variable=""
                                        ControlValue=""
                                        TextMode="Multiline"
                                        CssClass="form-control validate[required]"
                                        onblur="checkExpression(this)"
                                        runat="server"
                                        data-errormessage-type-mismatch="申请备注必填<br/>The Remarks required is not empty">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPROVEDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPROVEDATE"
                                        data-type='datetime'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="APPROVEDATE"
                                        Variable="APPROVEDATE"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PCCOMPCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.PCCOMPCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_PCCOMPCODE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="PCCOMPCODE"
                                        Variable="PCCOMPCODE"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLYPURPOSETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPLYPURPOSETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPLYPURPOSETXT"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="APPLYPURPOSETXT"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SUPPLIERTYPETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUPPLIERTYPETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERTYPETXT"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SUPPLIERTYPETXT"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ASSETTYPETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ASSETTYPETXT"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="ASSETTYPETXT"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CPRFAMILYCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CPRFAMILYCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_CPRFAMILYCODE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="CPRFAMILYCODE"
                                        Variable=""
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SIGNEDAPPROVERNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SIGNEDAPPROVERNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SIGNEDAPPROVERNUMBER"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SIGNEDAPPROVERNUMBER"
                                        Variable="SIGNEDAPPROVERNUMBER"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.DELIVERY") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_DELIVERY"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="DELIVERY"
                                        Variable="DELIVERY"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPROVE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPROVE"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="APPROVE"
                                        Variable="APPROVE"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <!--补充空单元格-->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SEGMENTDIRECTOR" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SEGMENTDIRECTOR") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SEGMENTDIRECTOR"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="SEGMENTDIRECTOR"
                                        Variable="SEGMENTDIRECTOR"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_USER_SEGMENTDIRECTOR_1" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.USER_SEGMENTDIRECTOR_1") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_USER_SEGMENTDIRECTOR_1"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="USER_SEGMENTDIRECTOR_1"
                                        Variable="USER_SEGMENTDIRECTOR_1"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISCOR" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ISCOR") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISCOR"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="ISCOR"
                                        Variable="ISCOR"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISCORName" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ISCORName") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISCORName"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="ISCORName"
                                        Variable="ISCORName"
                                        ControlValue=""
                                        CssClass="form-control"
                                        runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISSALARY" style="height: ">
                            <div class="form-label" id="ISSALARY">
                                <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ISSALARY")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISSALARY"
                                        data-type='string'
                                        title=""
                                        onblur="checkExpression(this)"
                                        data-field="ISSALARY"
                                        Variable="ISSALARY"
                                        ControlValue=""
                                        CssClass="form-control ReadOnly"
                                        runat="server">
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
        <div class="row" id="div_panel_MCPR_SERVICE_Items">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-bars"></i>
                            <span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.MCPR_SERVICE.MCPR_SERVICE_Items") %>
                        </div>
                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_MCPR_SERVICE_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_MCPR_SERVICE_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_ch" style="width: 50px">勾选</td>
                                    <td class="th_no" style="width: 50px"><%=Lang.Get("No") %></td>
                                    <td class="td_APPLYREASON"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPLYREASON") %><span style='color: red'>*</span></td>
                                    <td class="td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBSUBFAMILYNAME") %></td>
                                    <td class="td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ARTICLENAME") %></td>
                                    <td class="td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ORDERUNIT") %></td>
                                    <td class="td_SITEPRICE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SITEPRICE") %><span style='color: red'>*</span></td>
                                    <td class="td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ORDERQUANTITY") %> <span style='color: red'>*</span></td>
                                    <td class="td_INVOICENUMBER"><%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICENUMBER") %><span style='color: red'>*</span></td>
                                    <td class="td_BUYERNAME"><%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERNAME") %><span style='color: red'>*</span></td>
                                    <td class="td_BUYERTAXID"><%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERTAXID") %><span style='color: red'>*</span></td>
                                    <td class="td_INVOICEPATH"><%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICEPATH") %></td>
                                    <td class="hidden td_FAMILYCODE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.FAMILYCODE") %></td>
                                    <td class="hidden td_FAMILYNAME"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.FAMILYNAME") %></td>
                                    <td class="hidden td_SUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBFAMILYCODE") %></td>
                                    <td class="hidden td_SUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBFAMILYNAME") %></td>
                                    <td class="hidden td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBSUBFAMILYCODE") %></td>
                                    <td class="hidden td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ARTICLECODE") %></td>
                                    <td class="hidden td_UNIT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.UNIT") %></td>
                                    <td class="hidden td_CONSUMPTIONUNIT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CONSUMPTIONUNIT") %></td>
                                    <td class="hidden td_CONVERSION"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CONVERSION") %></td>
                                    <td class="hidden td_STOCK"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.STOCK") %></td>
                                    <td class="hidden td_NETVOMULE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.NETVOMULE") %></td>
                                    <td class="hidden td_GROSSWEIGHT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.GROSSWEIGHT") %></td>
                                    <td class="hidden td_NETVOMULEUNIT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.NETVOMULEUNIT") %></td>
                                    <td class="hidden td_GROSSWEIGHTUNIT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.GROSSWEIGHTUNIT") %></td>
                                    <td class="hidden InvoiceType"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.InvoiceType") %></td>
                                    <td class="hidden td_TAXCODE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.TAXCODE") %></td>
                                    <td class="hidden td_TAXRATE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.TAXRATE") %></td>
                                    <td class="hidden InitOrderLimt"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.InitOrderLimt") %></td>
                                    <td class="hidden td_ORDERUNITVALUE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ORDERUNITVALUE") %></td>
                                    <td class="hidden td_UNITVALUE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.UNITVALUE") %></td>
                                    <td class="hidden td_CONSUMPTIONUNITVALUE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CONSUMPTIONUNITVALUE") %></td>
                                    <td class="hidden td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBTOTALAMOUNT") %></td>
                                    <td class="hidden td_SUBSUBFAMILYCE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBSUBFAMILYCE") %></td>
                                    <td class="hidden td_NETNETPRICE"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.NETNETPRICE") %></td>
                                    <td class="hidden td_ARTICLEID"><%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ARTICLEID") %></td>
                                    <td class="td_DELIVERYDATE"><%=Lang.Get("PR.PRProcess.MPR_SERVICE.DELIVERYDATE") %></td>
                                    <td style="width: 60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- 服务端分组变量，必须放在Repeater外面 --%>
                                <% string lastDeliveryDate = null; int groupFlag = 0; %>
                                <ult:Repeater ID="fld_detail_PROC_MCPR_SERVICE_ITEMS" runat="server">
                                    <itemtemplate>
                                        <%
                                            string currDeliveryDate = Eval("DELIVERYDATE")?.ToString();
                                            if (currDeliveryDate != lastDeliveryDate)
                                            {
                                                groupFlag = groupFlag == 0 ? 1 : 0;
                                                lastDeliveryDate = currDeliveryDate;
                                            }
                                            string trBgColor = groupFlag == 1 ? "#f2f7ff" : "#ffffff";
                                        %>
                                        <tr style="background-color:<%=trBgColor%>">
                                            <td class="hidden">
                                                <ult:TextBox ID="fld_FORMID" Text='<%#Eval("FORMID") %>' runat="server" />
                                            </td>
                                            <td class="th_ch">
                                                <ult:CheckBox ID="fld_CHECKED" data-field="CHECKED" runat="server" ControlValue='<%#Eval("CHECKED")%>'></ult:CheckBox>
                                            </td>
                                            <td class="td_no" data-label='<%=Lang.Get("No").Split('<')[0] %>'>
                                                <div class="index"><%#Eval("ROWNO")%> </div>
                                                <ult:TextBox ID="fld_ROWNO" data-field="ROWNO" CssClass="index hidden" runat="server" ControlValue='<%#Eval("ROWNO")%>'></ult:TextBox>
                                            </td>
                                            <td class="td_APPLYREASON" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.APPLYREASON").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_APPLYREASON" title

                                            <td class=" td_SUBSUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBSUBFAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYNAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("SUBSUBFAMILYNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ARTICLENAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ARTICLENAME" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLENAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ARTICLENAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ORDERUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ORDERUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SITEPRICE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SITEPRICE" title="" data-type='string' onblur="checkExpression(this)" data-field="SITEPRICE" CssClass="item-control validate[custom[number]] ReadOnly " ControlValue='<%#Eval("SITEPRICE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ORDERQUANTITY").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ORDERQUANTITY" title="" data-type='number' onblur="checkExpression(this)" data-field="ORDERQUANTITY" CssClass="item-control  validate[required,custom[number]]  ControlValue='<%#Eval("ORDERQUANTITY")%>' runat="server" onchange="SumAmount(this)" data-errormessage-type-mismatch="采购数量必须大于0<br />Purchase quantity must be greater than 0">
                                                </ult:TextBox>
                                            </td>
                                            <td class="td_INVOICENUMBER" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICENUMBER").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_INVOICENUMBER" title="" data-type='string' onblur="checkExpression(this)" data-field="INVOICENUMBER" CssClass="item-control validate[required]" ControlValue='<%#Eval("INVOICENUMBER")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="td_BUYERNAME" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_BUYERNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="BUYERNAME" CssClass="item-control validate[required]" ControlValue='<%#Eval("BUYERNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="td_BUYERTAXID" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.BUYERTAXID").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_BUYERTAXID" title="" data-type='string' onblur="checkExpression(this)" data-field="BUYERTAXID" CssClass="item-control validate[required]" ControlValue='<%#Eval("BUYERTAXID")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="td_INVOICEPATH" data-label='<%=Lang.Get("PR.PRProcess.CPR_FOOD.INVOICEPATH").Split('<')[0] %>'>
                                                  <ult:TextBox ID="fld_INVOICEPATH" title="" data-type='string' onblur="checkExpression(this)" data-field="INVOICEPATH" CssClass="item-control-invoice-path" ControlValue='<%#Eval("INVOICEPATH")%>' runat="server">
                                                     
                                                </ult:TextBox>
                                                <a href="" class="invoice-path-link" target="_blank" style="display: none"></a>
                                            </td>
                                            <td class="hidden td_FAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.FAMILYCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_FAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="FAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("FAMILYCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_FAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.FAMILYNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_FAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="FAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("FAMILYNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBFAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBFAMILYCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBFAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBFAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("SUBFAMILYNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBSUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBSUBFAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>

                                            <td class="hidden td_ARTICLECODE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ARTICLECODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ARTICLECODE" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLECODE" CssClass="item-control  " ControlValue='<%#Eval("ARTICLECODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>

                                            <td class="hidden td_UNIT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.UNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_UNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="UNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("UNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNIT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CONSUMPTIONUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_CONSUMPTIONUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="CONSUMPTIONUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONSUMPTIONUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_CONVERSION" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CONVERSION").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_CONVERSION" title="" data-type='string' onblur="checkExpression(this)" data-field="CONVERSION" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONVERSION")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_STOCK" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.STOCK").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_STOCK" title="" data-type='string' onblur="checkExpression(this)" data-field="STOCK" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("STOCK")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_NETVOMULE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.NETVOMULE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_NETVOMULE" title="" data-type='string' onblur="checkExpression(this)" data-field="NETVOMULE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("NETVOMULE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.GROSSWEIGHT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_GROSSWEIGHT" title="" data-type='string' onblur="checkExpression(this)" data-field="GROSSWEIGHT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GROSSWEIGHT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_NETVOMULEUNIT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.NETVOMULEUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_NETVOMULEUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="NETVOMULEUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("NETVOMULEUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHTUNIT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.GROSSWEIGHTUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_GROSSWEIGHTUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="GROSSWEIGHTUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GROSSWEIGHTUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>

                                            <td class="hidden InvoiceType" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.InvoiceType").Split('<')[0] %>'>
                                                <ult:TextBox ID="InvoiceType" title="" data-type='text' onblur="checkExpression(this)" data-field="InvoiceType" CssClass="item-control ReadOnly " ControlValue='<%#Eval("INVOICETYPE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_TAXCODE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.TAXCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_TAXCODE" title="" data-type='text' onblur="checkExpression(this)" data-field="TAXCODE" CssClass="item-control ReadOnly " ControlValue='<%#Eval("TAXCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_TAXRATE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.TAXRATE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_TAXRATE" title="" data-type='text' onblur="checkExpression(this)" data-field="TAXRATE" CssClass="item-control ReadOnly " ControlValue='<%#Eval("TAXRATE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden InitOrderLimt" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.InitOrderLimt").Split('<')[0] %>'>
                                                <ult:TextBox ID="InitOrderLimt" title="" data-type='text' onblur="checkExpression(this)" data-field="InitOrderLimt" CssClass="item-control ReadOnly " runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_ORDERUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ORDERUNITVALUE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ORDERUNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERUNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNITVALUE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_UNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.UNITVALUE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_UNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="UNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("UNITVALUE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.CONSUMPTIONUNITVALUE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_CONSUMPTIONUNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="CONSUMPTIONUNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONSUMPTIONUNITVALUE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBTOTALAMOUNT" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBTOTALAMOUNT" CssClass="item-control  " ControlValue='<%#Eval("SUBTOTALAMOUNT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.SUBSUBFAMILYCE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBSUBFAMILYCE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYCE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_NETNETPRICE" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.NETNETPRICE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_NETNETPRICE" title="" data-type='number' onblur="checkExpression(this)" data-field="NETNETPRICE" CssClass="item-control validate[custom[number]] " ControlValue='<%#Eval("NETNETPRICE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>

                                            <td class="hidden td_ARTICLEID" data-label='<%=Lang.Get("PR.PRProcess.MCPR_SERVICE.ARTICLEID").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ARTICLEID" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLEID" CssClass="item-control" ControlValue='<%#Eval("ARTICLEID")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="td_DELIVERYDATE" data-label='<%=Lang.Get("PR.PRProcess.MPR_SERVICE.DELIVERYDATE").Split('<')[0] %>'>
                                              <ult:TextBox ID="fld_DELIVERYDATE" title="" data-field="DELIVERYDATE" runat="server"Text='<%#Eval("DELIVERYDATE")%>' Width="90%">
                                                </ult:TextBox>
                                            </td>
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？')){deleteCPRRow('tb_MCPR_SERVICE_ITEMS',this);}return false;"
                                                    class="btn btn-icon btn-sm" name="delBtn">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </itemtemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                        <div class="padding-t-5"></div>

                        <button id="btnAddCPRItems" onclick="addPRItemsRow('tb_MCPR_SERVICE_ITEMS');return false;"
                            class="btn btn-icon btn-default hidden-print" runat="server">
                            <%=Lang.Get("Form_AddRow") %></button>
                        <%--<button onclick="addRow('tb_MCPR_SERVICE_ITEMS');return false;"
                            class="btn btn-icon btn-default hidden-print">
                            <%=Lang.Get("Form_AddRow") %></button>--%>
                    </div>
                    <!--End detail table-->
                </div>
            </div>
        </div>

        <!--End Item table-->
        <div class="upload-row hidden" id="div_upload_Inv">
            <!-- 自定义文件选择容器（用于美化） -->
            <div class="custom-file-container">
                <!-- 原生FileUpload控件（隐藏，实际处理文件） -->
                <asp:FileUpload ID="fileUpload" runat="server" Multiple="true" Text="选择发票文件"
                    Style="display: none;" />

                <!-- 自定义选择按钮 -->
                <button type="button" class="custom-file-btn" id="customSelectBtn">选择文件</button>

                <!-- 选中文件显示区域 -->
                <div class="file-info">
                    <span class="file-name" id="fileNamesDisplay">未选择任何文件</span>
                </div>
            </div>

            <!-- 上传按钮 -->
            <asp:Button ID="uploadButton" runat="server" Text="上传发票"
                OnClick="UploadButton_Click" CssClass="btn upload-btn" />

            <!-- 错误提示 -->
            <asp:Label ID="errorLabel" runat="server" CssClass="error"
                Style="color: #f56c6c; margin-left: 10px; display: none;"></asp:Label>
        </div>
        <div class="file-list" id="fileList">
            <!-- 文件列表将通过JavaScript动态生成 -->
        </div>


        <atth:attachments id="Attachments1" runat="server"></atth:attachments>
        <%-- <ath:AttachmentAdd id="AttachmentsAdd" runat="server"></ath:AttachmentAdd>--%>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
        <asp:HiddenField ID="hdDatetime" runat="server" />
        <asp:HiddenField ID="hdFinshDate" runat="server" />
        <%--<asp:HiddenField ID="hdDate" runat="server" />--%>
        <asp:HiddenField ID="hdLanguage" runat="server" />
        <asp:HiddenField ID="hdFixedAssetsSignedApprover" runat="server" />
        <asp:HiddenField ID="SUPPLIERTYPE" runat="server" />
        <asp:HiddenField ID="SUPPLIERTYPETXT" runat="server" />
        <asp:HiddenField ID="hdCustomerProcurementSignedApprover" runat="server" />
        <asp:HiddenField ID="HiddenIncident" runat="server" />
        <%--   <asp:HiddenField ID="fld_ORIGINALAMOUNT" runat="server" />--%>
    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='math_common.js?t=dc64a1ef-95e5-4fb4-a793-a14f354d8a32'></script>
    <script type='text/javascript' src='NewRequest.js?t=5b8a82215-ed02-4bjj-adfe-2372FE999999'></script>
    <script type='text/javascript' src="SelectSignedApprover.js"></script>
    <script type='text/javascript' src="My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="RFQNewRequest.js"></script>

</body>
</html>
