<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.PO_Amendment.NewRequest" %>
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
    <title>PO_Amendment</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonList buttonList1 = Page.FindControl("ButtonList1") as ButtonList;
            buttonList1.BeforeSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_BeforeSubmit);
            buttonList1.AfterSubmit += new System.ComponentModel.CancelEventHandler(NewRequest_AfterSubmit);

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
            <ui:userinfo id="UserInfo1" processtitle="PO_Amendment" processprefix="" tablename="PROC_PO_AMENDMENT"
    tablenamedetail="" runat="server"></ui:userinfo>
            <!--End main table-->
            <!--Start 接UserInfo Div的结束标记,请不要删除-->
            </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
            <!--1.对Table做循环，判断单行,多行-->
            <!--1.1单行-->
            <div class="row" id="div_panel_PO_Amendment">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Lang.Get("UWF.Process.PO_Amendment.PO_Amendment") %>
                            </div>

                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table" >
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_FORMID" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.FORMID") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_FORMID" data-type='int'  title="" onblur="checkExpression(this)" data-field="FORMID"   Variable="" ControlValue="" CssClass="form-control validate[custom[integer]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PROCESSNAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.PROCESSNAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PROCESSNAME" data-type='int'  title="" onblur="checkExpression(this)" data-field="PROCESSNAME"   Variable="" ControlValue="" CssClass="form-control validate[custom[integer]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_INCIDENT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.INCIDENT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_INCIDENT" data-type='string'  title="" onblur="checkExpression(this)" data-field="INCIDENT"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DOCUMENTNO") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DOCUMENTNO" data-type='string'  title="" onblur="checkExpression(this)" data-field="DOCUMENTNO"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CREATEBY" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.CREATEBY") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_CREATEBY" data-type='string'  title="" onblur="checkExpression(this)" data-field="CREATEBY"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CREATEBYACCOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.CREATEBYACCOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_CREATEBYACCOUNT" data-type='string'  title="" onblur="checkExpression(this)" data-field="CREATEBYACCOUNT"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CREATEBYCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.CREATEBYCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_CREATEBYCODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="CREATEBYCODE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLICANT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPLICANT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPLICANT" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPLICANT"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLICANTACCOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPLICANTACCOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPLICANTACCOUNT" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPLICANTACCOUNT"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLICANTCODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPLICANTCODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPLICANTCODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPLICANTCODE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_REQUESTDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.REQUESTDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COMPLETEDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.COMPLETEDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DEPARTMENT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DEPARTMENT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DEPARTMENT" data-type='string'  title="" onblur="checkExpression(this)" data-field="DEPARTMENT"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DEPARTMENTID" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DEPARTMENTID") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DEPARTMENTID" data-type='int'  title="" onblur="checkExpression(this)" data-field="DEPARTMENTID"   Variable="" ControlValue="" CssClass="form-control validate[custom[integer]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PROCESSSUMMARY" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.PROCESSSUMMARY") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PROCESSSUMMARY" data-type='string'  title="" onblur="checkExpression(this)" data-field="PROCESSSUMMARY"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_STATUS" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.STATUS") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_STATUS" data-type='string'  title="" onblur="checkExpression(this)" data-field="STATUS"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.PurchasingPurpose") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PURCHASINGPURPOSE" data-type='string'  title="" onblur="checkExpression(this)" data-field="PURCHASINGPURPOSE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_AssetType" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.AssetType") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_ASSETTYPE" data-type='string'  title="" onblur="checkExpression(this)" data-field="ASSETTYPE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITECODE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITENAME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_SITENAME" data-type='string'  title="" onblur="checkExpression(this)" data-field="SITENAME"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DELIVERYDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DELIVERYDATE" data-type='string'  title="" onblur="checkExpression(this)" data-field="DELIVERYDATE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.AMOUNT") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_AMOUNT" data-type='number'  title="" onblur="checkExpression(this)" data-field="AMOUNT"   Variable="" ControlValue="" CssClass="form-control validate[custom[number]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPREMARK") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPREMARK" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPREMARK"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Requirement" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.Requirement") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_REQUIREMENT" data-type='string'  title="" onblur="checkExpression(this)" data-field="REQUIREMENT"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPROVEDATE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPROVEDATE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPROVEDATE" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPROVEDATE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_OVERTIME" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.OVERTIME") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_OVERTIME" data-type='string'  title="" onblur="checkExpression(this)" data-field="OVERTIME"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DELIVERY") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DELIVERY" data-type='string'  title="" onblur="checkExpression(this)" data-field="DELIVERY"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPROVE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_APPROVE" data-type='string'  title="" onblur="checkExpression(this)" data-field="APPROVE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_[PURCHASING TYPE]" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.[PURCHASING TYPE]") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_[PURCHASING TYPE]" data-type='string'  title="" onblur="checkExpression(this)" data-field="[PURCHASING TYPE]"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_MonthlyAmount" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.MonthlyAmount") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_MONTHLYAMOUNT" data-type='number'  title="" onblur="checkExpression(this)" data-field="MONTHLYAMOUNT"   Variable="" ControlValue="" CssClass="form-control validate[custom[number]] " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_BranchQuota" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.BranchQuota") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_BRANCHQUOTA" data-type='string'  title="" onblur="checkExpression(this)" data-field="BRANCHQUOTA"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PercentageOfExcess" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.PercentageOfExcess") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PERCENTAGEOFEXCESS" data-type='string'  title="" onblur="checkExpression(this)" data-field="PERCENTAGEOFEXCESS"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_COMPANY" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.COMPANY") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_COMPANY" data-type='string'  title="" onblur="checkExpression(this)" data-field="COMPANY"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COSTCENTER" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.COSTCENTER") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_COSTCENTER" data-type='string'  title="" onblur="checkExpression(this)" data-field="COSTCENTER"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PROCESSVERSION" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.PROCESSVERSION") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_PROCESSVERSION" data-type='string'  title="" onblur="checkExpression(this)" data-field="PROCESSVERSION"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_JOBFUNCTION" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.JOBFUNCTION") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_JOBFUNCTION" data-type='string'  title="" onblur="checkExpression(this)" data-field="JOBFUNCTION"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_EMAIL" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.EMAIL") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_EMAIL" data-type='string'  title="" onblur="checkExpression(this)" data-field="EMAIL"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_GRADE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.GRADE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_GRADE" data-type='string'  title="" onblur="checkExpression(this)" data-field="GRADE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_GRADECODE" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.GRADECODE") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_GRADECODE" data-type='string'  title="" onblur="checkExpression(this)" data-field="GRADECODE"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_JOBLEVEL" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.JOBLEVEL") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_JOBLEVEL" data-type='string'  title="" onblur="checkExpression(this)" data-field="JOBLEVEL"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_COMPANYID" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.COMPANYID") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_COMPANYID" data-type='string'  title="" onblur="checkExpression(this)" data-field="COMPANYID"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DEPARTMENTLEVEL" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.DEPARTMENTLEVEL") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_DEPARTMENTLEVEL" data-type='string'  title="" onblur="checkExpression(this)" data-field="DEPARTMENTLEVEL"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_JUDGELOGIC1" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.JUDGELOGIC1") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_JUDGELOGIC1" data-type='string'  title="" onblur="checkExpression(this)" data-field="JUDGELOGIC1"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_JUDGELOGIC2" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.JUDGELOGIC2") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_JUDGELOGIC2" data-type='string'  title="" onblur="checkExpression(this)" data-field="JUDGELOGIC2"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_JUDGELOGIC3" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.JUDGELOGIC3") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_JUDGELOGIC3" data-type='string'  title="" onblur="checkExpression(this)" data-field="JUDGELOGIC3"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COSTCENTERID" style="height:">
             <div class="form-label">
                 <%=Lang.Get("UWF.Process.PO_Amendment.COSTCENTERID") %>:
             </div>
             <div class="form-field"><div class="form-ctl">
                     <ult:TextBox ID="fld_COSTCENTERID" data-type='string'  title="" onblur="checkExpression(this)" data-field="COSTCENTERID"   Variable="" ControlValue="" CssClass="form-control  " runat="server">
                    </ult:textbox>

             </div></div>
         </div>
            
            <!--补充空单元格-->

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

        <attach:attachments id="Attachments1" runat="server"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='NewRequest.js?t=7e31678f-18ea-40bb-b7fb-b26cbe862df0'></script>
</body>
</html>
