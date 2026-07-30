<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ButtonList_AddSign.ascx.cs"
    Inherits="Ultimus.UWF.AddSign.ButtonList_AddSign" %>

<script src="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/js/loading.js" type="text/javascript"></script>
<link href="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/css/loading.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">
    var submitTimes = 0;
    function submitForm() {
        //判断审批意见
        if (typeof (validateIdear) == "function") {
            if (!validateIdear()) {
                return false;
            }
        }
        //加个客户端方法beforeSubmit
        if (typeof (beforeSubmit) == "function") {
            var flag = beforeSubmit();
            if (!flag) {
                submitTimes = 0;
                return false;
            }
        }

        //判断明细行
        var count = 0

        if (!$(".tablerequired").is(":hidden")) {
            $(".tablerequired").each(function (index, ele) {

                if ($(ele).find("tr").length <= 1) {
                    count++;
                    alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("MustInputDetail") %>');
                    return false;
                }
            });
        }
        if (count > 0) {
            return false;
        }
        //alert();
        if ($("#Attachments1_txtReadonly").val() != "1" && $("#Attachments1_FilePath").val() != "") {
            //if (!confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("HaveFile") %>')) {
            //return false;
            //}
        }
        //判断是否是必须上传附件
        if ($("#Attachments1_txtMust").val() == "1") {
            if ($("#fileinfo tr").size() <= 0) {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("AttachmentRequire") %>');
                return false;
            }
        };


        if (count == 0) {
            if (!confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>')) {
                return false;
            }
            showDiv();
            if (submitTimes > 0) {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("Submiting") %>');
                return false;
            }
            submitTimes++;
            return true;
        }
        else {
            return false;
        }
    }

    function submitSuccess() {
        if (window.opener != null) {
            try {
                //                var f = $("#ApprovalHistory1_rbReturn").attr("checked");
                //                if (f == "checked") {
                //                    setTimeout(
                //                        function () { 
                //                            closeDiv();
                //                            window.opener.location.href = window.opener.location.href;
                //                            window.opener = null;
                //                            window.open('', '_self');
                //                            window.close();
                //                        }, 1500);
                //                    return;
                //                }
                //                else {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitSuccess") %>');
                    closeDiv();
                //window.opener.location.href = window.opener.location.href;
                //                }
                }
                catch (e) {
                    //window.opener.location.href = window.opener.location.href;
                }


            }

            window.opener = null;
            window.open('', '_self');
            window.close();
        }

        function saveSuccess() {
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("SaveSuccess") %>');
        if (window.opener != null) {
            window.opener.location.href = window.opener.location.href;
        }
        //        window.opener = null;
        //        window.open('', '_self');
        //window.close();
    }


    function closeWin() {
        //        window.opener = null;
        //        window.open('', '_self');
        window.close();
        return false;
    }


    function showAsst(processName) {

        var val;
        val = window.showModalDialog(path + '/Modules/Ultimus.UWF.Workflow/AsstTask.aspx?taskId=<%=Request["TaskID"] %>&ProcessName=' + escape(processName), null, "dialogWidth=600px;dialogHeight=300px");
    }

    function showGoto(processName) {

        var val;
        val = window.showModalDialog(path + '/Modules/Presale.Process.Exp/GotoStep.aspx?taskId=<%=Request["TaskID"] %>&Incident=<%=Request["Incident"] %>&ProcessName=<%=Server.UrlEncode(Convert.ToString( Request["ProcessName"])) %>', null, "dialogWidth=600px;dialogHeight=300px");
        window.close();
        return false;
    }

    function Print_click(obj) {
        $(obj).attr("disabled", "disabled");
        javascript: __doPostBack('ButtonList1$print', '')
    }

</script>
<!--弹出层时背景层DIV-->
<div id="fade" class="black_overlay">
</div>
<div id="loadingdiv" class="white_content">
    <center>
        <img src="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/img/loading.gif" /></center>
</div>
<div class="subBtn">
    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary hidden"  Text="提交" OnClientClick=""
        OnClick="btnSubmit_Click" />
    <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary"  Text="提交" OnClientClick="return submitForm();"
        OnClick="btnSubmit_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <%--<asp:Button ID="btnSaveDraft" runat="server" CssClass="btn "  Text="保存草稿" OnClientClick="showDiv();"
        OnClick="btnSaveDraft_Click" />--%>

     <asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="btn"   OnClientClick="return closeWin();" />
</div>
