<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="PR.PRProcess.HK_CPR_NONFOOD.NewRequest" %>

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
    <title>HK_CPR_NONFOOD</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_NONFOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_NONFOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            fld_detail_PROC_HK_CPR_NONFOOD_Items.AfterBind += new System.EventHandler(AfterBind);

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
            Ultimus.UWF.Form.WebControls.Repeater fld_detail_PROC_HK_CPR_NONFOOD_Items = Page.FindControl("fld_detail_PROC_HK_CPR_NONFOOD_Items") as Ultimus.UWF.Form.WebControls.Repeater;
            if (fld_detail_PROC_HK_CPR_NONFOOD_Items.Items.Count == 0)
            {
                UserInfo userInfo1 = Page.FindControl("UserInfo1") as UserInfo;
                _form.AddBlankRow(userInfo1, fld_detail_PROC_HK_CPR_NONFOOD_Items, 1);
            }
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="HK_CPR_NONFOOD" processprefix="HK_CPR" tablename="PROC_HK_CPR_NONFOOD"
            tablenamedetail="PROC_HK_CPR_NONFOOD_ITEMS" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_HK_CPR_NONFOOD">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.HK_CPR_NONFOOD") %>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPLYPURPOSE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:DropDownList ID="fld_APPLYPURPOSE" title="" onblur="checkExpression(this)" data-field="APPLYPURPOSE" Variable="" CssClass="form-control  selector validate[required]" Source="DataSource.SODEXO_香港申请目的" Filter="" ControlValue="" runat="server">
                                    </ult:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUPPLIERTYPE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:DropDownList ID="fld_SUPPLIERTYPE" title="" onblur="checkExpression(this)" data-field="SUPPLIERTYPE" Variable="SUPPLIERTYPE" CssClass="form-control  selector validate[required]" Source="DataSource.SODEXO_香港采购类型" Filter="" ControlValue="" runat="server" onchange="changeSupplierType()">
                                    </ult:DropDownList>
                                   
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLYPURPOSETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPLYPURPOSETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPLYPURPOSETXT" data-type='string' title="" onblur="checkExpression(this)" data-field="APPLYPURPOSETXT" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SUPPLIERTYPETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUPPLIERTYPETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERTYPETXT" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERTYPETXT" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPETXT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ASSETTYPETXT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ASSETTYPETXT" data-type='string' title="" onblur="checkExpression(this)" data-field="ASSETTYPETXT" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SITECODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITECODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SITECODE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITENAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SITENAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SITENAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SITENAME" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.DELIVERYDATE") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_DELIVERYDATE" title="" data-field="DELIVERYDATE" data-type="text" Format="" Variable="DELIVERYDATE" CssClass="form-control Wdate validate[required,funcCall[futureDateTime]]" runat="server" data-errormessage-type-mismatch="要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am" onClick="WdatePicker({readOnly:false,startDate:'%y-%M-%d 06:30:00',dateFmt:'yyyy-MM-dd HH:mm:00',alwaysUseStartDate:false})">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon hidden-xs"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUPPLIERCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERCODE" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERCODE" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERNAME" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUPPLIERNAME") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SUPPLIERNAME" data-type='string' title="" onblur="checkExpression(this)" data-field="SUPPLIERNAME" Variable="" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ASSETTYPE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ASSETTYPE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ASSETTYPE" data-type='string' title="" onblur="checkExpression(this)" data-field="ASSETTYPE" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.AMOUNT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_AMOUNT" data-type='string' title="" onblur="checkExpression(this)" data-field="AMOUNT" Variable="AMOUNT" ControlValue="" CssClass="form-control   ReadOnly" runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPREMARK") %><span style='color: red'>*</span>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPREMARK" data-type='string' title="" onblur="checkExpression(this)" data-field="APPREMARK" Variable="" ControlValue="" CssClass="form-control  " runat="server" data-errormessage-type-mismatch="申请备注必填<br/>The Remarks required is not empty">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPROVEDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CPRFAMILYCODE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CPRFAMILYCODE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_CPRFAMILYCODE" data-type='string' title="" onblur="checkExpression(this)" data-field="CPRFAMILYCODE" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PURCHASINGAGENT" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.PURCHASINGAGENT") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_PURCHASINGAGENT" data-type='string' title="" onblur="checkExpression(this)" data-field="PURCHASINGAGENT" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SIGNEDAPPROVERNUMBER" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SIGNEDAPPROVERNUMBER") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_SIGNEDAPPROVERNUMBER" data-type='string' title="" onblur="checkExpression(this)" data-field="SIGNEDAPPROVERNUMBER" Variable="SIGNEDAPPROVERNUMBER" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.DELIVERY") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_DELIVERY" data-type='string' title="" onblur="checkExpression(this)" data-field="DELIVERY" Variable="DELIVERY" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPROVE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPROVE" data-type='string' title="" onblur="checkExpression(this)" data-field="APPROVE" Variable="APPROVE" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApproverName" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.USER_SignedApproverName") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVERNAME" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVERNAME" Variable="" ControlValue="" CssClass="form-control ReadOnly " runat="server">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER" Variable="USER_SignedApprover" ControlValue="" CssClass="form-control hidden " runat="server">
                                        </ult:TextBox>
                                        <%--selectUser--%>
                                        <span class="add-on input-group-addon USER_SignedApprover" style="cursor: pointer;" onclick="selectSignedApprover(1,'fld_USER_SIGNEDAPPROVERNAME','','fld_USER_SIGNEDAPPROVER');"><i class="fa fa-search"></i></span>
                                        <span class="add-on input-group-addon" style="cursor: pointer;" onclick="clearSignedApprover()"><i class="fa fa-trash"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover2Name" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.USER_SignedApprover2Name") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER2NAME" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER2NAME" Variable="" ControlValue="" CssClass="form-control ReadOnly " runat="server">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER2" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER2" Variable="USER_SignedApprover2" ControlValue="" CssClass="form-control hidden " runat="server">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon USER_SignedApprover2" style="cursor: pointer;"><i class="fa fa-search"></i></span>
                                        <span class="add-on input-group-addon" style="cursor: pointer;" onclick="clearSignedApprover2()"><i class="fa fa-trash"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_USER_SignedApprover3Name" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.USER_SignedApprover3Name") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <div class="input-prepend input-group">
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER3NAME" data-type='string' title="" onblur="checkExpression(this)" data-field="USER_SIGNEDAPPROVER3NAME" Variable="USER_SignedApprover3Name" ControlValue="" CssClass="form-control ReadOnly " runat="server">
                                        </ult:TextBox>
                                        <ult:TextBox ID="fld_USER_SIGNEDAPPROVER3" title="" data-field="USER_SIGNEDAPPROVER3" Variable="USER_SignedApprover3" ControlValue="" CssClass="form-control hidden " runat="server">
                                        </ult:TextBox>
                                        <span class="add-on input-group-addon USER_SignedApprover3" style="cursor: pointer;"><i class="fa fa-search"></i></span>
                                        <span class="add-on input-group-addon" style="cursor: pointer;" onclick="clearSignedApprover3()"><i class="fa fa-trash"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_FIXEDASSETS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.FIXEDASSETS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:RadioButtonList ID="fld_FIXEDASSETS" title="" data-field="FIXEDASSETS" Variable="" CssClass="" Source="DataSource." Filter="" ControlValue="" RepeatDirection="Horizontal" runat="server">
                         
                                        <asp:ListItem Text="否" Value="02" Selected="True"></asp:ListItem>
                                    </ult:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVEDATE" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPROVEDATE") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_APPROVEDATE" data-type='datetime' title="" onblur="checkExpression(this)" data-field="APPROVEDATE" Variable="APPROVEDATE" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISEDU" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ISEDU") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISEDU" data-type='string' title="" onblur="checkExpression(this)" data-field="ISEDU" Variable="ISEDU" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_ISFIXEDASSETS" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("PR.PRProcess.HK_CPR_FOOD.ISFIXEDASSETS") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_ISFIXEDASSETS" data-type='string' title="" onblur="checkExpression(this)" data-field="ISFIXEDASSETS" Variable="ISFIXEDASSETS" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
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
        <div class="row" id="div_panel_HK_CPR_NONFOOD_Items">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.HK_CPR_NONFOOD_Items") %></div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <!--Start detail table-->
                        <table id="tb_HK_CPR_NONFOOD_ITEMS" class="table table-bordered table-condensed form-detail-table form-resp-table tablerequired" width="100%">
                            <thead>
                                <tr>
                                    <td class="hidden">
                                        <input id="tb_HK_CPR_NONFOOD_ITEMS_rowCount" type="text" runat="server" />
                                    </td>
                                    <td class="th_no" style="width: 50px">
                                        <%=Lang.Get("No") %>
                                    </td>
                                    <td style="" class=" td_APPLYREASON"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPLYREASON") %><span style='color: red'>*</span></td>
                                    <td style="" class="hidden td_FAMILYCODE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.FAMILYCODE") %></td>
                                    <td style="" class="hidden td_FAMILYNAME"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.FAMILYNAME") %></td>
                                    <td style="" class="hidden td_SUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBFAMILYCODE") %></td>
                                    <td style="" class="hidden td_SUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBFAMILYNAME") %></td>
                                    <td style="" class="hidden td_SUBSUBFAMILYCODE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBSUBFAMILYCODE") %></td>
                                    <td style="" class=" td_SUBSUBFAMILYNAME"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBSUBFAMILYNAME") %></td>
                                    <td style="" class=" td_ARTICLENAME"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ARTICLENAME") %></td>
                                    <td style="" class="hidden td_ARTICLECODE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ARTICLECODE") %></td>
                                    <td style="" class=" td_ORDERUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ORDERUNIT") %></td>
                                    <td style="" class="hidden td_UNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.UNIT") %></td>
                                    <td style="" class="hidden td_CONSUMPTIONUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CONSUMPTIONUNIT") %></td>
                                    <td style="" class="hidden td_CONVERSION"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CONVERSION") %></td>
                                    <td style="" class="hidden td_STOCK"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.STOCK") %></td>
                                    <td style="" class="hidden td_NETVOMULE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.NETVOMULE") %></td>
                                    <td style="" class="hidden td_GROSSWEIGHT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.GROSSWEIGHT") %></td>
                                    <td style="" class="hidden td_NETVOMULEUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.NETVOMULEUNIT") %></td>
                                    <td style="" class="hidden td_GROSSWEIGHTUNIT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.GROSSWEIGHTUNIT") %></td>
                                    <td style="" class=" td_SITEPRICE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SITEPRICE") %><span style='color: red'>*</span></td>
                                    <td style="" class=" td_ORDERQUANTITY"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ORDERQUANTITY") %></td>
                                    <td style="" class="hidden td_ORDERUNITVALUE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ORDERUNITVALUE") %></td>
                                    <td style="" class="hidden td_UNITVALUE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.UNITVALUE") %></td>
                                    <td style="" class="hidden td_CONSUMPTIONUNITVALUE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CONSUMPTIONUNITVALUE") %></td>
                                    <td style="" class="hidden td_SUBTOTALAMOUNT"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBTOTALAMOUNT") %></td>
                                     <td style="" class="hidden td_SUBSUBFAMILYCE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBSUBFAMILYCE") %></td>
                                    <td style="" class="hidden td_NETNETPRICE"><%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.NETNETPRICE") %></td>
                                    <td style="width: 60px"><%=Lang.Get("Action") %></td>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="fld_detail_PROC_HK_CPR_NONFOOD_ITEMS" runat="server">
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
                                            <td class=" td_APPLYREASON" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.APPLYREASON").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_APPLYREASON" title="" data-type='string' onblur="checkExpression(this)" data-field="APPLYREASON" CssClass="item-control validate[required]  ReadOnly" ControlValue='<%#Eval("APPLYREASON")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_FAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.FAMILYCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_FAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="FAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("FAMILYCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_FAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.FAMILYNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_FAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="FAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("FAMILYNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBFAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBFAMILYCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBFAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBFAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("SUBFAMILYNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCODE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBSUBFAMILYCODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBSUBFAMILYCODE" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYCODE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_SUBSUBFAMILYNAME" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBSUBFAMILYNAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBSUBFAMILYNAME" title="" data-type='string' onblur="checkExpression(this)" data-field="SUBSUBFAMILYNAME" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYNAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_ARTICLENAME" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ARTICLENAME").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ARTICLENAME" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLENAME" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ARTICLENAME")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_ARTICLECODE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ARTICLECODE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ARTICLECODE" title="" data-type='string' onblur="checkExpression(this)" data-field="ARTICLECODE" CssClass="item-control  " ControlValue='<%#Eval("ARTICLECODE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERUNIT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ORDERUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ORDERUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_UNIT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.UNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_UNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="UNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("UNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNIT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CONSUMPTIONUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_CONSUMPTIONUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="CONSUMPTIONUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONSUMPTIONUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_CONVERSION" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CONVERSION").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_CONVERSION" title="" data-type='string' onblur="checkExpression(this)" data-field="CONVERSION" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("CONVERSION")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_STOCK" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.STOCK").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_STOCK" title="" data-type='string' onblur="checkExpression(this)" data-field="STOCK" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("STOCK")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_NETVOMULE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.NETVOMULE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_NETVOMULE" title="" data-type='string' onblur="checkExpression(this)" data-field="NETVOMULE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("NETVOMULE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.GROSSWEIGHT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_GROSSWEIGHT" title="" data-type='string' onblur="checkExpression(this)" data-field="GROSSWEIGHT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GROSSWEIGHT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_NETVOMULEUNIT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.NETVOMULEUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_NETVOMULEUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="NETVOMULEUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("NETVOMULEUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_GROSSWEIGHTUNIT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.GROSSWEIGHTUNIT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_GROSSWEIGHTUNIT" title="" data-type='string' onblur="checkExpression(this)" data-field="GROSSWEIGHTUNIT" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("GROSSWEIGHTUNIT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_SITEPRICE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SITEPRICE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SITEPRICE" title="" data-type='string' onblur="checkExpression(this)" data-field="SITEPRICE" CssClass="item-control validate[required,custom[number]]  ReadOnly" ControlValue='<%#Eval("SITEPRICE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class=" td_ORDERQUANTITY" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ORDERQUANTITY").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ORDERQUANTITY" title="" data-type='number' onblur="checkExpression(this)" data-field="ORDERQUANTITY" CssClass="item-control validate[custom[number]]  ReadOnly" ControlValue='<%#Eval("ORDERQUANTITY")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_ORDERUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.ORDERUNITVALUE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_ORDERUNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="ORDERUNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("ORDERUNITVALUE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_UNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.UNITVALUE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_UNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="UNITVALUE" CssClass="item-control   ReadOnly" ControlValue='<%#Eval("UNITVALUE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_CONSUMPTIONUNITVALUE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.CONSUMPTIONUNITVALUE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_CONSUMPTIONUNITVALUE" title="" data-type='string' onblur="checkExpression(this)" data-field="CONSUMPTIONUNITVALUE" CssClass="item-control  " ControlValue='<%#Eval("CONSUMPTIONUNITVALUE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBTOTALAMOUNT" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBTOTALAMOUNT").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_SUBTOTALAMOUNT" title="" data-type='number' onblur="checkExpression(this)" data-field="SUBTOTALAMOUNT" CssClass="item-control validate[custom[number]]  ReadOnly" ControlValue='<%#Eval("SUBTOTALAMOUNT")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td class="hidden td_SUBSUBFAMILYCE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.SUBSUBFAMILYCE").Split('<')[0] %>'>
                                                    <ult:TextBox ID="fld_SUBSUBFAMILYCE"  title="" data-type='string' onblur="checkExpression(this)"  data-field="SUBSUBFAMILYCE" CssClass="item-control  " ControlValue='<%#Eval("SUBSUBFAMILYCE")%>' runat="server" >
                                                    </ult:TextBox>
                                            </td>
                                            <td class="hidden td_NETNETPRICE" data-label='<%=Lang.Get("PR.PRProcess.HK_CPR_NONFOOD.NETNETPRICE").Split('<')[0] %>'>
                                                <ult:TextBox ID="fld_NETNETPRICE" title="" data-type='number' onblur="checkExpression(this)" data-field="NETNETPRICE" CssClass="item-control validate[custom[number]] " ControlValue='<%#Eval("NETNETPRICE")%>' runat="server">
                                                </ult:TextBox>
                                            </td>
                                            <td>
                                                <button onclick="if(confirm('<%=Lang.Get("SecurityList_ConfirmDelete") %>？'))deleteCPRRow('tb_HK_CPR_NONFOOD_ITEMS',this);return false;"
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

                        <button id="btnAddCPRItems" onclick="addPRItemsRow('tb_HK_CPR_NONFOOD_ITEMS');return false;"
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
        <asp:HiddenField ID="hdDatetime" runat="server" />
        <%--<asp:HiddenField ID="hdDate" runat="server" />--%>
        <asp:HiddenField ID="hdLanguage" runat="server" />
        <asp:HiddenField ID="hdFixedAssetsSignedApprover" runat="server" />
        <asp:HiddenField ID="SUPPLIERTYPE" runat="server" />
        <asp:HiddenField ID="SUPPLIERTYPETXT" runat="server" />
        <asp:HiddenField ID="hdCustomerProcurementSignedApprover" runat="server" />
        <script type='text/javascript' src="SelectSignedApprover.js"></script>
        <script type='text/javascript' src="My97DatePicker/WdatePicker.js"></script>
        <script src="math.js"></script>
    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='NewRequest.js?t=7a9a1d87-03c3-4f71-887c-881c714141fg'></script>
    <script src="math_common.js"></script>
    <script>
        $(function () {
            //$("#fld_AMOUNT").val(thousands(numberval($("#fld_AMOUNT").val()));
            $("#fld_AMOUNT").next("span").text(thousands($("#fld_AMOUNT").val()));
            //$(".td_SITEPRICE").find("input").each(function (index, element) {
            //       $(this).val(thousands($(this).val()));
            // })
            // //td_SUBTOTALAMOUNT
            //$(".td_SUBTOTALAMOUNT").find("input").each(function (index, element) {
            //       $(this).val(thousands($(this).val()));
             //})
        })
     
    </script>


</body>
</html>
