<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.UserInfo" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%=WebUtil.IncludeJsV3() %>

<style type="text/css">
    body {
        font-size: 12px;
        font-family: '等线','Microsoft YaHei';
    }

    table td {
        padding: 3px;
    }

    .tdlbl {
        width: 10%;
        text-align: left;
    }

    .tdtxt {
        width: 20%;
        word-break: break-all;
    }

    .Detail_tdtxt {
        word-break: break-all;
    }

    .thlbl {
        text-align: center;
    }

    .panel {
        font-weight: bold;
        padding: 3px;
    }

    .hidden {
        display: none;
    }
</style>

<script type="text/javascript">
    function code128() {
        $("#barcode2").empty().barcode($("#UserInfo1_fld_DOCUMENTNO").text(), "code128", { barWidth: 1, barHeight: 30, showHRI: false });
    }

    $(document).ready(function () {
        debugger;
        code128();
        $("#UserInfo1_read_APPLICANT").text($("#UserInfo1_fld_APPLICANT").val());
        $("#UserInfo1_read_JOBFUNCTION").text($("#UserInfo1_fld_JOBFUNCTION").val());
        $("#UserInfo1_read_APPLICANTTEL").text($("#UserInfo1_fld_APPLICANTTEL").val());
        $("#UserInfo1_read_EMAIL").text($("#UserInfo1_fld_EMAIL").val());
        $("#UserInfo1_read_DEPARTMENT").text($("#UserInfo1_fld_DEPARTMENT").val());
        $("#UserInfo1_read_PROCESSSUMMARY").text($("#UserInfo1_fld_PROCESSSUMMARY").val());
        $("#UserInfo1_read_APPLICANTCODE").text($("#UserInfo1_fld_APPLICANTCODE").val());
        $("#UserInfo1_read_JOBLEVEL").text($("#UserInfo1_fld_JOBLEVEL").val());
        $("#UserInfo1_read_GRADE").text($("#UserInfo1_fld_GRADE").val());
        $("#UserInfo1_read_COSTCENTER").text($("#UserInfo1_fld_COSTCENTER").val());
        $("#UserInfo1_read_EMPNO").text($("#UserInfo1_fld_JUDGELOGIC3").val());
        $("#UserInfo1_read_COMPANY").text($("#UserInfo1_fld_COMPANY").val());
        
    });

</script>

<div class="hidden">
    <asp:TextBox ID="fld_Status" runat="server" Text="1"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSNAME" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_INCIDENT" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtStepName" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtSetpType" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_FORMID" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtProcessPrefix" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtReadOnly" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableName" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableNameDetail" runat="server"></asp:TextBox>
    <asp:TextBox ID="var_ApplicantAccount" runat="server" Text=""></asp:TextBox><%--申请人账号--%>
    <asp:TextBox ID="fld_DEPARTMENTID" runat="server" Text=""></asp:TextBox><%--本部门Id--%>
    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTaskId" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtApplicantAccount" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSSUMMARY" runat="server" Text="" Width="87%"></asp:TextBox>
    <asp:TextBox ID="txtIsVarSubmit" runat="server" Text="0"></asp:TextBox>
    <asp:TextBox ID="txtIsCreateForm" runat="server" Text="0"></asp:TextBox>
    <asp:Label ID="lblSummary" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="barcode" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="incident" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblCOMPANY" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblProcessName" runat="server" Visible="false"></asp:Label>
    <asp:TextBox ID="fld_CREATEBY" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_CREATEBYACCOUNT" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_CREATEBYCODE" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTACCOUNT" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTCODE" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_EMAIL" runat="server" Text="" CssClass=""></asp:TextBox>
    <asp:TextBox ID="fld_JOBFUNCTION" runat="server" Text="" CssClass=""></asp:TextBox>
    <asp:TextBox ID="fld_JOBLEVEL" runat="server" Text="" CssClass=""></asp:TextBox>
     <asp:TextBox ID="fld_EMPNO" runat="server" Text="" CssClass=""></asp:TextBox>
    <asp:TextBox ID="fld_GRADE" runat="server" Text="" CssClass=""></asp:TextBox>
    <asp:TextBox ID="fld_DEPARTMENT" runat="server" Text=""></asp:TextBox>
     <asp:TextBox ID="TextBox1" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_COSTCENTER" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTTEL" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSVERSION" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_JUDGELOGIC3" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_COMPANY" runat="server" Text=""></asp:TextBox>
    <asp:Label ID="lblDocumentNo" runat="server" Visible="false"></asp:Label>
    <asp:TextBox ID="fld_APPLICANT" CssClass="ReadOnly form-control" runat="server" data-prompt-position="bottomLeft"></asp:TextBox>
    <div class="btn-group hidden-print" id="editBtn" runat="server" visible="false"></div>
    <div id="attqueue" class="hidden"></div>
    <asp:Label ID="read_JOBFUNCTION" runat="server" Text=""></asp:Label>
    <asp:Label ID="read_EMAIL" runat="server" Text=""></asp:Label>
    <asp:Label ID="read_APPLICANTTEL" runat="server" Text=""></asp:Label>
                                    <asp:Label ID="read_APPLICANTACCOUNT" runat="server" Text="" CssClass=""></asp:Label>
</div>

<table align="center" style="width: 100%;">
    <tr>
        <td style="width: 20%">
            <div class="left">
                <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/form_logo.jpg" alt="logo" style="width: 180px;" />
            </div>
        </td>
        <td style="text-align: center; font-weight: bold; font-size: 18px; width: 60%; padding-left: 0px;">
            <%=Lang.Get(Request.QueryString["ProcessName"]) %>
            
        </td>
        <td style="width: 20%">
            <div style="float: right" class="">
                <div id="barcode2">
                </div>
            </div>
        </td>
    </tr>
</table>

<div class="panel">
    <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_BasicInfo")%>
    <span style="float: right; padding-right: 30px;">
        <asp:Label ID="fld_DOCUMENTNO" runat="server"></asp:Label></span>
</div>
<table border="1" style="width: 100%; border-collapse: collapse;">
    <tr>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_APPLICANT" runat="server"></asp:Label>
        </td>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Department")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_DEPARTMENT" runat="server" Text=""></asp:Label></td>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_RequestDate")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="fld_REQUESTDATE" runat="server" Text=""></asp:Label></td>
    </tr>
        <tr>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_AccountNo")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_APPLICANTCODE" runat="server"></asp:Label>
        </td>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_JobLevel")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_JOBLEVEL" runat="server" Text=""></asp:Label></td>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Officialrank")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_GRADE" runat="server" Text=""></asp:Label></td>
    </tr>
     <tr>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Costcenter")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_COSTCENTER" runat="server"></asp:Label>
        </td>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_EMPNO")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_EMPNO" runat="server" Text=""></asp:Label></td>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Corporation")%>：</td>
        <td class="tdtxt">
            <asp:Label ID="read_COMPANY" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td class="tdlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_ProcessTitle")%>：</td>
        <td class="tdtxt" colspan="5">
            <asp:Label ID="read_PROCESSSUMMARY" runat="server" Text=""></asp:Label></td>
    </tr>
</table>
