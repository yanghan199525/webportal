<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PO_Amendment.Approval" %>
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
    <title>PO_Amendment</title>
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

                        <div class="panel-body form-table">
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_FORMID" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.FORMID") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_FORMID" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PROCESSNAME" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.PROCESSNAME") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PROCESSNAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_INCIDENT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.INCIDENT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_INCIDENT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DOCUMENTNO" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DOCUMENTNO") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DOCUMENTNO" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CREATEBY" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.CREATEBY") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_CREATEBY" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CREATEBYACCOUNT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.CREATEBYACCOUNT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_CREATEBYACCOUNT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_CREATEBYCODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.CREATEBYCODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_CREATEBYCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLICANT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPLICANT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPLICANT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLICANTACCOUNT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPLICANTACCOUNT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPLICANTACCOUNT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPLICANTCODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPLICANTCODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPLICANTCODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_REQUESTDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.REQUESTDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_REQUESTDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COMPLETEDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.COMPLETEDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_COMPLETEDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DEPARTMENT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DEPARTMENT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DEPARTMENT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DEPARTMENTID" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DEPARTMENTID") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DEPARTMENTID" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PROCESSSUMMARY" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.PROCESSSUMMARY") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PROCESSSUMMARY" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_STATUS" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.STATUS") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_STATUS" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PurchasingPurpose" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.PurchasingPurpose") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PURCHASINGPURPOSE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_AssetType" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.AssetType") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_ASSETTYPE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SITECODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITECODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_SITENAME" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.SITENAME") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_SITENAME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_DELIVERYDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DELIVERYDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERYDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_AMOUNT" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.AMOUNT") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                    <ult:Label ID="read_AMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPREMARK" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPREMARK") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPREMARK" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_Requirement" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.Requirement") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_REQUIREMENT" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPROVEDATE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPROVEDATE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPROVEDATE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_OVERTIME" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.OVERTIME") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_OVERTIME" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DELIVERY" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DELIVERY") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DELIVERY" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_APPROVE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.APPROVE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_APPROVE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_[PURCHASING TYPE]" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.[PURCHASING TYPE]") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_[PURCHASING TYPE]" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_MonthlyAmount" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.MonthlyAmount") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                    <ult:Label ID="read_MONTHLYAMOUNT" title="" Format="" CssClass="autonumber" runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_BranchQuota" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.BranchQuota") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_BRANCHQUOTA" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_PercentageOfExcess" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.PercentageOfExcess") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PERCENTAGEOFEXCESS" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_COMPANY" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.COMPANY") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_COMPANY" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COSTCENTER" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.COSTCENTER") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_COSTCENTER" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_PROCESSVERSION" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.PROCESSVERSION") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_PROCESSVERSION" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_JOBFUNCTION" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.JOBFUNCTION") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_JOBFUNCTION" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_EMAIL" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.EMAIL") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_EMAIL" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_GRADE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.GRADE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_GRADE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_GRADECODE" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.GRADECODE") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_GRADECODE" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_JOBLEVEL" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.JOBLEVEL") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_JOBLEVEL" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_COMPANYID" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.COMPANYID") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_COMPANYID" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden" id="div_field_DEPARTMENTLEVEL" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.DEPARTMENTLEVEL") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_DEPARTMENTLEVEL" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_JUDGELOGIC1" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.JUDGELOGIC1") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_JUDGELOGIC1" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_JUDGELOGIC2" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.JUDGELOGIC2") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_JUDGELOGIC2" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_JUDGELOGIC3" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.JUDGELOGIC3") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_JUDGELOGIC3" title="" Format=""  runat="server">
                </ult:Label>
            </div></div>
         </div>
         <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_COSTCENTERID" style="height:">
             <div class="form-label">
                 
                 <%=Lang.Get("UWF.Process.PO_Amendment.COSTCENTERID") %>:
             </div>

             <div class="form-field"><div class="form-ctl">
                <ult:Label ID="read_COSTCENTERID" title="" Format=""  runat="server">
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
                        </div>
                    </div>
                </div>
            </div>
        <attach:attachments id="Attachments1" runat="server" ReadOnly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='Approval.js?t=2231c05e-539e-42cf-b061-4e4e17121951'></script>
</body>
</html>
