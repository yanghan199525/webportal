<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailSendForm.aspx.cs" Inherits="Ultimus.UWF.Workflow.EmailSendForm" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery.js" type="text/javascript"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <base target="_self" />

    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath() %>/Solution/Ultimus.UWF.Form.ProcessControl.V3/css/form.css" type="text/css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <div class="page-header ">
                <div class="left hidden-xs">
                    <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/form_logo.png" alt="logo" />
                </div>
                <h1 class="title center"><strong>
                    <asp:Label ID="txtProcessNameS" runat="server"></asp:Label>
                </strong></h1>
                <ol class="breadcrumb center">
                    <li class="active">
                        <asp:Label ID="txtsteplabel" runat="server"></asp:Label>
                    </li>
                </ol>
                <div class="right">
                    <div class="btn-group">
                        <div id="barcode2">
                        </div>
                        <div id="documentno" style="text-align: center" class="">
                            <asp:Label ID="lblDocumentNo" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-default">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default" runat="server" id="divApproveResult" visible="false">
                            <div class="title center" style="" runat="server" id="divApproveResultSuss" visible="false">
                                <div class="fa-title">
                                    <i class="fa fa-check-circle" style="color: green; font-size: 50px;"></i><span class="padding-r-5"></span>
                                    <asp:Label ID="lbResult" runat="server" Style="font-size: 14pt;"></asp:Label>
                                </div>
                            </div>
                            <div class="title center" style="font-size: 13pt;" runat="server" id="divApproveResultFail" visible="false">

                                <div class="fa-title">
                                    <i class="fa fa-exclamation-triangle" style="color: yellow; font-size: 50px;"></i>
                                    <span class="padding-r-5"></span>
                                    <asp:Label ID="lbResultFail" runat="server" Style="font-size: 14pt;"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default" runat="server" id="divApprove" visible="false">
                            <div class="panel-body form-table" style="border-top: 1px; border-color: #efefef;">
                                <div class="col-lg-12 col-sm-12 col-xs-12 form-cell  ">
                                </div>
                                <div class="col-lg-12 col-sm-12 col-xs-12 form-cell padding-b-20" style="height: 120px">
                                    <div class="form-label" style="height: 119px; margin-top: 0px;">
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>：                               
                                    </div>
                                    <div class="form-content">
                                        <asp:TextBox ID="txtComments" runat="server" CssClass="form-control validate[required max[1000]]" TextMode="MultiLine"
                                            MaxLength="1000" Height="100px" Style="margin-top: 1px;"></asp:TextBox>
                                    </div>
                                    <span class="hidden-xs hidden-sm hidden-md">( <%=Ultimus.UWF.Common.Logic.Lang.Get("MaxLength")%>：<asp:Label Text="0" runat="server"
                                        ID="reachChar" Font-Underline="true" ForeColor="Blue"> </asp:Label>
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Char")%>：)<br />
                                    </span>
                                </div>

                            </div>

                        </div>

                        <div class="panel panel-default" runat="server" id="divApproveLog" visible="false">
                            <div class="panel-title">
                                <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span>审批历史记录 Approval History</div>
                            </div>
                            <div class="panel-body">
                                <!--Start detail table-->
                                <table class="table table-bordered table-condensed form-detail-table" width="100%">
                                    <thead>
                                        <tr>
                                            <td class="hidden-xs show-print">No.</td>
                                            <td>審批人 Approver</td>
                                            <td class="hidden-xs  show-print">角色/部門 Role</td>
                                            <td>審批意見 Comments</td>
                                            <td>審批結果 Action</td>
                                            <td>審批時間 Approve Date</td>
                                            <td class="hidden">審批日期 Approval Day</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="ApprovalHistoryList" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="hidden-xs show-print">
                                                        <%# Container.ItemIndex+1 %>
                                                    </td>
                                                    <%-- <td><%# Eval("Level") %></td>--%>
                                                    <td>
                                                        <%# Eval("ApproverName")%>
                                                    </td>
                                                    <td class="hidden-xs show-print">
                                                        <%# Eval("StepName")%>
                                                    </td>
                                                    <td>
                                                        <%# Eval("Comments")%>                                  
                                                    </td>
                                                    <td>
                                                        <%# Eval("Action")%>
                                                    </td>
                                                    <td class="hidden-xs show-print">
                                                        <%--<%# MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).ToString("yyyy/MM/dd HH:mm:ss") %>--%>
                                                        <%#MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).Year==1900?"**********":MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).ToString("yyyy/MM/dd HH:mm:ss") %>
                                                    </td>
                                                    <td class="hidden">
                                                        <%#MyLib.ConvertUtil.ToDateTime( Eval("CreateDate")).ToString("MM/dd") %>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body" style="border-top: 0px;">

                                <div class="col-lg-12 col-sm-12 col-xs-12  padding-b-20 " style="height: 35px; text-align: center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="确认" OnClientClick="return submitForm();"
                                        OnClick="btnSubmit_Click" class="btn btn-default " Visible="false" />

                                    <asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="btn " OnClientClick="return closeWin();" />
                                    <%--<asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="btn " OnClientClick="" OnClick="btnClose_Click" />--%>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div style="display: none;">
                        <!--taskid-->
                        <asp:TextBox ID="txttaskid" runat="server"></asp:TextBox>
                        <!--username-->
                        <asp:TextBox ID="txtusername" runat="server"></asp:TextBox>
                        <!--type-->
                        <asp:TextBox ID="txttype" runat="server"></asp:TextBox>
                        <!--processname-->
                        <asp:TextBox ID="txtprocessname" runat="server"></asp:TextBox>
                        <!--incident-->
                        <asp:TextBox ID="txtincident" runat="server"></asp:TextBox>

                        <!--applicant-->
                        <asp:TextBox ID="txtLoginAccount" runat="server"></asp:TextBox>

                        <!--tableName-->
                        <asp:TextBox ID="txttableName" runat="server"></asp:TextBox>

                        <!--FORMID-->
                        <asp:TextBox ID="txtFORMID" runat="server"></asp:TextBox>

                        <%--CPR_APPROVE  &&  提交审批日期--%>
                        <asp:TextBox ID="var_APPROVE" runat="server"></asp:TextBox>

                         <%--USER_SEGMENTDIRECTOR_1  &&  事业部总监1--%>
                        <asp:TextBox ID="var_USER_SEGMENTDIRECTOR_1" runat="server"></asp:TextBox>

                         <%--SEGMENTDIRECTOR--%>
                        <asp:TextBox ID="var_SEGMENTDIRECTOR" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    String.prototype.trim = function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    function code128() {
        $("#barcode2").empty().barcode($("#lblDocumentNo").text(), "code128", { barWidth: 1, barHeight: 30, showHRI: false });
    }

    $(document).ready(function () {
        code128();
        $("#txtComments").keyup(function () {

            $("#reachChar").text(getLength($("#txtComments").val()));
            if (getLength($("#txtComments").val()) > 4000) {
                $("#reachChar").css("color", "red");
            }
            else {
                $("#reachChar").css("color", "blue");
            }
        });
    });

    function submitForm() {
        if ($("#txtComments").val() == undefined || $("#txtComments").val().trim() == "") {
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("RequireComments")%>');
            $("#txtComments").focus();
            return false;
        }
        else {
            if ($("#txtComments").val() != undefined && getLength($("#txtComments").val()) > 2000) {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("CommentsOverLength")%>');
                return false;
            }
            else {
                if (!confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>')) {
                    return false;
                } else { return true; }
            }
        }

    }


    //function getByteLen(str) {
    function getLength(val) {
        var cArr = val.match(/[^\x00-\xff]/ig);
        var num = val.length + (cArr == null ? 0 : cArr.length);
        return num;
    } //为UTF-8时，非ASCII字符占用三个字节宽

    //}
    //function closePage()
    //{
    //    debugger
    //    alert(111);
    //    window.location.href = "about:blank";
    //    window.close();
    //}
</script>

</html>
