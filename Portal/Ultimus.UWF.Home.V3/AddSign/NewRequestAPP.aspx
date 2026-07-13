<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewRequestAPP.aspx.cs" Inherits="Ultimus.UWF.AddSign.NewRequestAPP" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Request.QueryString["Title"] %></title>
    <base target="_self" />
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <script src="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/js/loading.js" type="text/javascript"></script>
    <link href="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/css/loading.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        //self.moveTo(0, 0);
        //self.resizeTo(screen.availWidth, screen.availHeight);
        function submitForm() {
            if (window.confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>')) {
                showDiv();
                return true;
            }
            else {
                return false;
            }

        }
        function closeWin() {

            $('.modal-dialog button.close', parent.document).trigger('click');
            return false;
        }
        function submitSuccess() {
            parent.$("#ApprovalHistory1_txtComments").text($("#txtComments").text());
            if (request("obj") == "1") {
                parent.$("#ApprovalHistory1_rbAddApprover").prop("checked", "checked");
            } else {
                parent.$("#ApprovalHistory1_rbAddHuiApprover").prop("checked", "checked");
            }
            parent.$("#ButtonList1_btn_sign").click();
            //debugger;
            //alert('<%=Lang.Get("SubmitSuccess") %>');
            //if (window.opener != null) {
            //    try {
            //        closeDiv();

            //    } catch (e) {
            //        //window.opener.location.href = window.opener.location.href;
            //    }
            //}

            //parent.document.opener = null;
            //parent.document.opener.close();
            //window.opener = null;
            //window.open('', '_self');
            //window.close();
            //parent.parent.close();
            //closeWin();
        }

        function form_validation() {
            jQuery("#form1").validationEngine('attach', {
                onValidationComplete: function (form, status) {
                    if (status == false) {
                        submitTimes = 0;
                        closeDiv();
                    }
                }
            });
        }
        function selectUserInfoType() {
            var type = request("obj");
            parent.selectUserInfo(type, 'txtJiaqianName', 'txtJiaqianId', '', null, true);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%; margin-top: 3px;">

                <tr>
                    <td class="labelTD" style="width: 15%">
                        <%--<asp:Label ID="lbl_SignName" runat="server"  Text=""></asp:Label>:--%>
                        选择人员:
                    </td>
                    <td class="td-content" colspan="3">
                        <asp:TextBox ID="txtJiaqianName" runat="server" Width="66%" CssClass="validate[required]" onfocus="this.blur();" onmousedown="if(event.button==2) return  false ;"></asp:TextBox>
                        <asp:TextBox ID="txtJiaqianId" runat="server" Style="display: none;"></asp:TextBox>

                        <input type="button" runat="server" id="selectuser" class="btn btn-default" style="margin-bottom: 5px;" value="选择 Select" onclick="selectUserInfoType()" />
                    </td>
                </tr>
                <tr id="trIdear" runat="server">
                    <td class="labelTD">审批记录：
                    </td>
                    <td class="td-content" colspan="3">
                        <asp:TextBox ID="txtComments" runat="server" Width="90%" Height="100" TextMode="MultiLine"
                            MaxLength="1000"></asp:TextBox>
                    </td>
                </tr>
                <tr id="trAction" runat="server" class="hidden">
                    <td class="labelTD">
                        <%=Lang.Get("Countersigning_Way") %>：
                    </td>
                    <td class="textTD" colspan="3">
                        <ult:radiobuttonlist runat="server" id="rblHQ">
                    <asp:ListItem Value="1" Selected="True">会签 Counter Sign</asp:ListItem>
                    <asp:ListItem Value="0">串签 Sequence Sign</asp:ListItem>
                </ult:radiobuttonlist>
                    </td>
                </tr>
                <tr id="tr1" runat="server">
                    <td class="labelTD"></td>
                    <td class="textTD" style="display: none;" colspan="3">
                        <asp:CheckBox ID="cbxSubmitAfter" CssClass="checkbox" Text="加签不返回(加签后自动流转到下一步)" Checked="false" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="labelTD"></td>
                    <td class="textTD" colspan="3">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-default" Width="" Text=""
                            OnClientClick="return submitForm();" OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="btn btn-warning" Width="80" OnClientClick="return closeWin();" />
                    </td>
                </tr>
            </table>
            <div id="fade" class="black_overlay">
            </div>
            <div id="loadingdiv" class="white_content">
               <%-- <center>
        <img src="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/img/loading.gif" />
    </center>--%>
            </div>
        </div>
        <div style="display: none;">
            <asp:TextBox ID="txtJiaQianProcessName" runat="server" Text="子流程"></asp:TextBox>
            <asp:TextBox ID="txtProcessName" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtIncident" runat="server"></asp:TextBox>
            <asp:TextBox ID="txttaskId" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtStepName" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtTableName" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtFORMID" runat="server"></asp:TextBox>
        </div>

    </form>
</body>
</html>
