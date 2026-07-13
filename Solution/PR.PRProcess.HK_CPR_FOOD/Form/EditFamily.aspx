<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditFamily.aspx.cs" Inherits="PR.PRProcess.HK_CPR_FOOD.EditFamily" %>

<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%--<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachmentsCPR.ascx" TagName="Attachments" TagPrefix="attach" %>--%>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="Ultimus.UWF.Form.ProcessControl.V3" %>
<%@ Import Namespace="Ultimus.UWF.Workflow.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Add CPR Items</title>
    <!-- ========== Css Files ========== -->

    <link href="../../../common/assets/css/root.css" rel="stylesheet" />
    <style>
        body {
            background-color: #fff;
        }

        .tdrow {
            padding-top: 2px !important;
            padding-bottom: 2px !important;
        }

        @media screen and (max-width: 500px) {
            .task {
                width: 350px !important;
                display: block !important;
            }
        }

        @media screen and (min-width: 500px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }

</style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row " id="div_panel_CPR">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_APPLYPURPOSE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.FAMILYNAME") %><span style='color: red' id="ddlFamily_span">*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <select id="ddlFamily" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUPPLIERTYPE" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SUBFAMILYNAME") %><span style='color: red' id="ddlSubFamily_span">*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">

                                        <select id="ddlSubFamily" class="selectpicker form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_SUBSUBFAMILYNAME" style="height: ">
                                <div class="form-label">
                                    <%=Lang.Get("PR.PRProcess.OutOfCataloguePurchaseRequisitionRequest.SUBSUBFAMILYNAME") %><span style='color: red' id="ddlSubSubFamily_span">*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">

                                        <select id="ddlSubSubFamily" class="selectpicker ignoreMe form-control validate[required]" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hidden">
                <asp:HiddenField ID="hdCategory" runat="server" />
                <asp:HiddenField ID="hdSiteCode" runat="server" />
                <asp:HiddenField ID="hdFamilyCode" runat="server" />                
                <asp:HiddenField ID="hdUserName" runat="server" />
                <asp:HiddenField ID="hdLanguage" runat="server" /> 
                <asp:HiddenField ID="hdSubSubFamilyCe" runat="server" />
            </div>
        </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>
    <%--<script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/select2-master/dist/js/select2.full.min.js" type="text/javascript"></script>
    <link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/select2-master/dist/css/select2.min.css" rel="stylesheet" />--%>
    <script type="text/javascript" src='EditFamily.aspx.js?t=dc64a1ef-95e5-4fb4-a793-a14f2004d88599999'></script>
</body>
</html>
