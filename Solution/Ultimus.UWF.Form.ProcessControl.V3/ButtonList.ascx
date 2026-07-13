<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ButtonList.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.ButtonList" %>

<script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath() %>/Solution/Ultimus.UWF.Form.ProcessControl.V3/js/loading.js" type="text/javascript"></script>
<link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath() %>/Solution/Ultimus.UWF.Form.ProcessControl.V3/css/loading.css" type="text/css" rel="stylesheet" />


<!--弹出层时背景层DIV-->
<div id="fade" class="black_overlay">
</div>
<div id="loadingdiv" class="white_content">
    <center>
        <img src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath() %>/Solution/Ultimus.UWF.Form.ProcessControl.V3/img/loading.gif" /></center>
</div>

<div class="row hidden-print" id="rowPrint">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-title">
            </div>

            <div class="panel-body padding-b-20" style="text-align: center">
                <asp:TextBox ID="showSign" runat="server" Style="display: none"></asp:TextBox>
                <asp:LinkButton ID="btnSend" runat="server" OnClick="btnSubmit_Click" OnClientClick="return approveForm();" CssClass="btn btn-default">提交</asp:LinkButton>
                <input type="button" id="btn_showMarterPrint" class="btn btn-toggle " value="调整流程" onclick="showMarterPrint(); return false;" style="display: none" />
                <asp:LinkButton ID="btnApprove" runat="server" OnClientClick="return approveForm();"
                    OnClick="btnSubmit_Click" Visible="false" CssClass="btn btn-default"><i class="fa fa-check"></i>同意</asp:LinkButton>

                <%--       <asp:LinkButton ID="btnSubmitCataLog" runat="server" CssClass="btn btn-default" Text="报价单明细提交"
                    OnClick="btnSubmitCataLog_Click"></asp:LinkButton>--%>

                <asp:LinkButton ID="btnSaveDraft" runat="server" CssClass="btn btn-toggle" Text="保存草稿" OnClientClick="reDisabled();showDiv();return true;"
                    OnClick="btnSaveDraft_Click" Visible="false"></asp:LinkButton>
                <asp:HyperLink ID="btnPrint" CssClass="btn btn-toggle" Visible="false" runat="server" Target="_blank">打印</asp:HyperLink>
                <asp:LinkButton ID="btnProcessCopy" runat="server" CssClass="btn btn-default" Text="复制" OnClick="btnProcessCopy_Click" Visible="false"></asp:LinkButton>
                <asp:LinkButton ID="btnReminders" runat="server" CssClass="btn btn-default" Text="催办" OnClick="btnReminders_Click" Visible="false"></asp:LinkButton>
                <div id="divGoto" runat="server" visible="false">
                    <input type="button" id="btnGoto" runat="server" class="btn btn-toggle" value="跳转" onclick="showGoto(''); return false;" style="" />
                </div>
                <div style="display: none">
                    <asp:Button Text="签呈同意" runat="server" ID="btn_sign" OnClick="btnSubmit_Click" />
                </div>
                <input type="button" id="btn_AddApprover" runat="server" class="btn btn-toggle hidden" value="增加审批人" onclick="showAddApprover('1'); return false;" style="display: block" />
                <input type="button" id="btn_AddhuiApprover" runat="server" class="btn btn-toggle hidden" value="增加会签人" onclick="showAddApprover('2'); return false;" style="display: block" />
                <input type="button" id="btnAddSign" runat="server" class="btn btn-toggle hidden" value="加签" onclick="showAddSign()" style="" />
                <asp:LinkButton ID="btnReturn" runat="server" CssClass="btn btn-toggle" Text="退回" OnClientClick="reDisabled();return returnForm();"
                    OnClick="btnSubmit_Click" Visible="false"></asp:LinkButton>
                <div style="display: none">
                    <asp:LinkButton ID="lbnSelectReturn" runat="server" OnClick="lbnSelectReturn_Click"></asp:LinkButton>
                </div>
                <asp:LinkButton ID="btnSelectReturn" runat="server" CssClass="btn btn-toggle" Text="选择退回" OnClientClick="return showSelectStep();"
                    Visible="false"></asp:LinkButton>
                <asp:LinkButton ID="btnCallback" runat="server" CssClass="btn btn-toggle" Text="撤回" OnClientClick="reDisabled();return callbackConfirm();"
                    OnClick="btnCallback_Click" Visible="false"></asp:LinkButton>
                <asp:LinkButton ID="btnReject" runat="server" CssClass="btn btn-toggle" Text="拒绝" OnClientClick="reDisabled();return rejectForm();"
                    OnClick="btnSubmit_Click" Visible="false"></asp:LinkButton>
                <asp:LinkButton ID="btnAbortIncident" runat="server" CssClass="btn btn-toggle" Text="终止流程" OnClientClick="reDisabled();return rejectForm();"
                    OnClick="btnAbort_Click" Visible="false"></asp:LinkButton>
                <input type="button" id="btnSendRead" visible="false" runat="server" class="btn btn-info hidden" value="呈阅" onclick="showSendRead(''); return false;" style="" />
                <input id="txtJiaqianName" runat="server" style="display: none; height: 20px; width: auto" cssclass="validate[required]" onfocus="this.blur();" onmousedown="if(event.button==2) return  false ;">
                <input id="txtJiaqianId" runat="server" style="display: none;" />
                <input id="btnChuanYue" runat="server" visible="false" class="btn btn-info" style="" type="button" value="传阅" onclick="assignSingle(this);" />
                <input type="button" id="btnXieban" runat="server" visible="false" class="btn btn-info" value="协办" onclick="showAsst('协办流程'); return false;" style="" />
                <input type="button" id="btnCopy" runat="server" visible="false" class="btn btn-info" value="抄送" onclick="showAsst('抄送流程'); return false;" style="" />
                <asp:LinkButton ID="btnApprover" runat="server" Visible="false" CssClass="btn btn-info hidden" Text="后续审批人"></asp:LinkButton>
                <asp:HyperLink ID="hyFlow" CssClass="btn btn-info hidden" runat="server" Target="_blank">流程图</asp:HyperLink>
                <asp:LinkButton ID="btnClose" runat="server" Text="关闭" CssClass="btn btn-toggle" OnClientClick="return  Prompt();"></asp:LinkButton>
                <asp:Button ID="butSIGN" runat="server" Text="加签" OnClientClick="return signSubmit();"
                    OnClick="btnSIGN_Click" class="btn btn-default " Visible="false" />

                <asp:Button ID="btTransfer" runat="server" Text="转办" OnClientClick="return signSubmit();"
                    OnClick="btnTransfer_Click" class="btn btn-default " Visible="false" />
                <!-- 弹框 -->
                <div class="modal fade bs-example-modal-sm" id="AssignSingleModal" tabindex="-1" role="dialog" aria-labelledby="AssignSingleModal" aria-hidden="true">
                    <div class="modal-dialog modal-xs diyModal">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="H1">请选择
                                </h4>
                            </div>
                            <div class="modal-body" style="height: 120px;">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-3  col-xs-12 col-Name">
                                            请选择： 
                                        </div>
                                        <div class="col-md-8  col-xs-12">
                                            <div class="form-field">
                                                <div class="form-ctl">
                                                    <div class="input-prepend input-group" id="Union1">
                                                        <asp:TextBox ID="AssignUserName" onclick="$('#ButtonList1_AssignUserName').val('');$('#ButtonList1_AssignUserAccount').val('');selectUser('1', 'ButtonList1_AssignUserName', 'ButtonList1_AssignUserID','ButtonList1_AssignUserLoginName');" title="" data-field="" Style="background-color: rgb(245, 245, 245);" variable="" controlvalue="" CssClass="form-control validate[required] ReadOnly" MaxLength="500" runat="server" placeholder="点击此处选择用户"></asp:TextBox>
                                                        <span id="btn_assignSpan" class="add-on input-group-addon" onclick="$(this).prev().click()"><i class="fa fa-search"></i></span>
                                                        <asp:TextBox runat="server" ID="AssignUserLoginName" Style="display: none"></asp:TextBox>
                                                        <asp:TextBox runat="server" ID="AssignUserAccount" Style="display: none"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-3  col-xs-12 col-Name">
                                            意见：
                                        </div>
                                        <div class="col-md-8  col-xs-12">
                                            <div class="form-field">
                                                <div class="form-ctl">
                                                    <asp:TextBox runat="server" ID="txtReadOpinion" CssClass="form-control " TextMode="MultiLine"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" id="btn_Assign" class="btn btn-warning" onclick="btnCirculationUserInfo()" value="确认" />

                                <button id="btn_cancel" type="button" class="btn " data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 弹框 -->

            </div>
        </div>
    </div>
</div>

</div>
<!-- END CONTAINER -->
<!-- //////////////////////////////////////////////////////////////////////////// -->

</div>
<!-- End Content -->
<!-- //////////////////////////////////////////////////////////////////////////// -->


<script type="text/javascript">
    $.validationEngine.defaults.validateNonVisibleFields = false;
    //移动端务删 开始
    $(function () {
        appForm();
    })
    function appForm() {
        if (GetQueryString("fromterminal") == 'app') {
            $("#rowPrint").css("display", "none");
            $("#pheader").css("display", "none");
            $("#approvalrow").css("display", "none");
            $("#filelist").css("display", "none");
            pseth();
        }
    }
    function pseth() {
        var iObj = parent.parent.document.getElementById('frame_content');
        iObjH = parent.parent.frames["frame_content"].frames["iframeC"].location.hash;
        iObj.style.height = iObjH.split("#")[1] + "px";
    }
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]); return null;
    }

    //移动端务删  结束
    function approveForm() {


        //如果有公式，那么计算公式
        //try {
        //    checkExpression();
        //}
        //catch (e) {
        //}
        //验证数据
        var flag = $("#form1").validationEngine('validate');

        if (!flag) {
            $(".formError").show();
            return false;
        }
        $("#ApprovalHistory1_rbApprove").prop("checked", true);
        return submitForm();
    }

    function returnForm() {
        try {
            $("#ApprovalHistory1_rbReturn").prop("checked", true);
            return submitForm();
        }
        catch (e) {
            alert(e);
            return false;
        }
    }

    function rejectForm() {
        try {
            $("#ApprovalHistory1_rbReject").prop("checked", true);
            return submitForm();
        }
        catch (e) {
            alert(e);
            return false;
        }
    }
    function showSelectStep() {
        // var $textAndPic = $('<div></div>');
        var trIder = $('#ApprovalHistory1_trIdear').html().replace("119px", "");
        var $textAndPic = $('<div id="selectReturnWin"><div class="row"><div class="col-md-12">');
        $textAndPic.append($('#ApprovalHistory1_selectReturn').html());
        $textAndPic.append(trIder);
        $textAndPic.append('</div></div></div>');

        var IsOK = false;
        var dialog = BootstrapDialog.show({
            title: '选择性退回',
            message: $textAndPic,
            buttons: [{
                label: '确定',
                action: function (dialogRef) {
                    if ($("#selectReturnWin #ApprovalHistory1_txtComments").val() == "") {
                        alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("RequireComments")%>');
                        return false;
                    }
                    dialogRef.close();
                    var comments = dialogRef.getModalBody().find("#ApprovalHistory1_txtComments");
                    var returnStep = dialogRef.getModalBody().find("#ApprovalHistory1_rblStepList").val();
                    //$("#ApprovalHistory1_rblStepList").find("option[text='" + returnStep + "']").attr("selected", true);
                    $('#ApprovalHistory1_rblStepList').prop('value', returnStep);
                    $("#ApprovalHistory1_rbSelectReturn").prop("checked", true);
                    $("#ApprovalHistory1_txtComments").val(comments.val());
                    javascript: __doPostBack("ButtonList1$lbnSelectReturn", "");
                    showDiv();
                    if (submitTimes > 0) {
                        alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("Submiting") %>');
                        return false;
                    }
                    submitTimes++;
                    return true;

                }
            }, {
                    label: '取消',
                    action: function (dialogRef) {
                        $("#ApprovalHistory1_rbSelectReturn").prop("checked", false);
                        dialogRef.close(); $
                    }
                }]
        });
        return false;
    }
    function signSubmit() {
        //判断审批意见
        if ($("#ButtonList1_showSign").val() == "1") {
            var SIGNNAME = $("#ApprovalHistory1_fldSIGNNAME").val();
            if (SIGNNAME == "" || SIGNNAME == undefined) {
                alert('请选择经办人员');
                return false;
            }
        }
        approveForm();
    }
    var submitTimes = 0;
    function submitForm() {

        if (!validateDates()) {
            return false;
        }
        if (!validateAssetTypes()) {
            return false;
        }
        if (!validateACCEPTMARK()) {
            return false;
        }
        //if (!validateDELIVERYDATE()) {
        //    return false;
        //}
        //判断审批意见
        if (typeof (validateIdear) == "function") {
            if (!validateIdear()) {
                return false;
            }
        }
        if ($("#ApprovalHistory1_rbReject").prop("checked") || $("#ApprovalHistory1_rbReturn").prop("checked")) {
            if (!confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>'))
                return false;
            else
                return true
        } else {
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
                ////固资内容单独处理
                //var tabLen = $("#tb_CAPEX_NONFOOD_ITEMS").find("tr").length;
                //for (var i = 0; i <= tabLen; i++) {
                //    for (var J = 0; J <= tabLen; J++) {
                //        if ($("tr:eq(" + J + ")>td:eq(0)").find("input[type = 'checkbox']").val() == "1") {
                //            num = J
                //            break;
                //        }
                //    }
                //}
            }
            if (count > 0) {
                return false;
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
                reDisabled();
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
    }

    function callbackConfirm() {
        return confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>');
    }

    function submitSuccess() {
        try {
            showDiv();
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitSuccess") %>');

            refreshCount();

            closeDiv();

            window.opener = null;
            window.open('', '_self');
            window.close();
            closeWinAfterSubmit();

        }
        catch (e) {
        }

    }

    function saveSuccess() {
        //window.location.href = window.location.href.replace("Type=NEWREQUEST", "Type=Draft");
        showDiv();
        alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("SaveSuccess") %>');
        closeDiv();
        window.close();
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

    function showAddSign() {
        var val;
        var FORMID = $('#UserInfo1_fld_FORMID').val();
        var tb = $('#UserInfo1_txtTableName').val();
        val = showForm({ title: '加签', url: path + '/Portal/Ultimus.UWF.Home.V3/AddSign/NewRequest.aspx?taskId=<%=Request["TaskID"] %>&FORMID=' + FORMID + '&tablename=' + tb + '&StepName=<%=Server.UrlEncode(Convert.ToString( Request["StepName"])) %>&Incident=<%=Request["Incident"] %>&ProcessName=<%=Server.UrlEncode(Convert.ToString( Request["ProcessName"])) %>', buttons: [] });
        return false;
    }

    function showAddApprover(obj) {
        var title = "";
        if (obj == 1) {
            title = "增加审批人";
        }
        else {
            title = "增加会签人"
        }
        var val;
        var FORMID = $('#UserInfo1_fld_FORMID').val();
        var tb = $('#UserInfo1_txtTableName').val();
        val = showForm({ title: title, url: path + '/Portal/Ultimus.UWF.Home.V3/AddSign/NewRequestAPP.aspx?taskId=<%=Request["TaskID"] %>&FORMID=' + FORMID + '&tablename=' + tb + '&StepName=<%=Server.UrlEncode(Convert.ToString( Request["StepName"])) %>&Incident=<%=Request["Incident"] %>&ProcessName=<%=Server.UrlEncode(Convert.ToString( Request["ProcessName"])) %>&obj=' + obj, buttons: [] });
        return false;
    }
    function showNextApprover() {
        var val;
        var FORMID = $('#UserInfo1_fld_FORMID').val();
        var tb = $('#UserInfo1_txtTableName').val();
        val = showForm({ title: '后续审批人', url: path + '/Portal/Ultimus.UWF.Home.V3/Workflow/showNextApprover.aspx?taskId=<%=Request["TaskID"] %>&FORMID=' + FORMID + '&tablename=' + tb + '&StepName=<%=Server.UrlEncode(Convert.ToString( Request["StepName"])) %>&Incident=<%=Request["Incident"] %>&ProcessName=<%=Server.UrlEncode(Convert.ToString( Request["ProcessName"])) %>', buttons: [] });
        return false;
    }

    function showSendRead(processName) {
        var val;
        var FORMID = $('#UserInfo1_fld_FORMID').val();
        var tb = $('#UserInfo1_txtTableName').val();
        val = showForm({ title: 'Task Forward', url: path + '/Portal/Ultimus.UWF.Workflow/SendRead/NewRequest.aspx?taskId=<%=Request["TaskID"] %>&FORMID=' + FORMID + '&tablename=' + tb + '&StepName=<%=Server.UrlEncode(Convert.ToString( Request["StepName"])) %>&Incident=<%=Request["Incident"] %>&ProcessName=<%=Server.UrlEncode(Convert.ToString( Request["ProcessName"])) %>', buttons: [] });
        return false;
    }

    function refreshCount() {
        try {
            var obj = window.opener;
            obj.parent.refreshCount();
        }
        catch (e) { }
    }
    function assignSingle(obj) {
        $("#AssignSingleModal").modal();
        $("#ButtonList1_txtReadOpinion").val("");
        $("#ButtonList1_AssignUserName").val("");
        $("#ButtonList1_AssignUserAccount").val("");
    }
    var stepname = "<%=Request.Params["StepName"]%>";
    var processname = "<%=Request.Params["ProcessName"]%>";
    // 传阅
    function btnCirculationUserInfo() {
        if ($("#ButtonList1_AssignUserLoginName").val() == "" || $("#ButtonList1_AssignUserName").val() == "") {
            alert("Please Select User!");
            return;
        }
        //传阅人username
        var readusername = $("#ButtonList1_AssignUserName").val();
        //传阅人loginname
        var readloginname = $("#ButtonList1_AssignUserLoginName").val();
        //传阅人意见
        var opinion = $("#ButtonList1_txtReadOpinion").val();
        var incident = request("INCIDENT");
        var taskid = request("TASKID");
        var type = request("Type");
        var datat = {
            READUSERNAME: readusername, READLOGINNAME: readloginname, OPINION: opinion, STEPNAME: stepname,
            PROCESSNAME: processname, INCIDENT: incident, TASKID: taskid, TYPE: type
        };
        $.ajax({
            url: "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/Handler/ProcessControl.ashx?method=InsertCirculation",
            type: "POST",
            data: datat,
            cache: false,
            async: false,
            dataType: 'html',
            success: function (data) {
                $("#AssignSingleModal").modal("hide");
                alert("Success！");
                $(".chuanyuedetail").append(data);
                //ID重新排序
                tabCtl = document.getElementById("CirculationItem");
                tabRows = tabCtl.rows;
                for (var i = 1; i < tabRows.length; i++) {
                    $(tabRows[i]).find(".index").html(i);
                    $(tabRows[i]).find(".index").val(i);
                }
            },
            error: function () {
                $("#AssignSingleModal").modal("hide");
                alert("Failure！");
            }
        })
    }
    //关闭提示
    function Prompt() {
        if (confirm("<%=Ultimus.UWF.Common.Logic.Lang.Get("ConfirmClose") %>?")) {
            return closeWin();
        };
        return false;
    }

    function reDisabled() {
        // 清除disabled禁用
        $("[disabled='disabled']:not(button)").each(function () {
            $(this).removeAttr("disabled");
        })
    }
    function validateDates() {
        if ($("#approvalType").val() == "0") return true;
        // 合同结束日期
        var contractdate = $("#fld_CONTRACTDATE").val();
        //折旧开始日期
        var depreciationdate = $("#fld_DEPRECIATIONDATE").val();
        //合同结束日期  必须 大于（不能等于，不能是同一天）   折旧开始日期 

        if (!contractdate || !depreciationdate) {
            return true;
        }
        var contractDateObj = new Date(contractdate);
        var depreciationDateObj = new Date(depreciationdate);

        if (isNaN(contractDateObj.getTime()) || isNaN(depreciationDateObj.getTime())) {
            alert("日期格式不正确，请使用 YYYY-MM-DD 格式");
            return false;
        }
        if (contractDateObj <= depreciationDateObj) {
            alert("合同结束日期必须晚于折旧开始日期");
            return false;
        }
        if ($("#isGL").val() == "0") {
            // 获取当前时间和年份
            const now = new Date();
            const currentYear = now.getFullYear();
            // 计算阈值（当年9月1日 00:00:00）
            const currentSept1 = new Date(currentYear, 8, 1, 0, 0, 0, 0);
            // 确定比较阈值
            const threshold = now > currentSept1
                ? currentSept1
                : new Date(currentYear - 1, 8, 1, 0, 0, 0, 0);
            if (depreciationDateObj < threshold) {
                alert("折旧开始日期不能是上一财年的日期");
                return false;
            }
        }
        return true;
    }

    function validateDELIVERYDATE() {
        var deliverydate = $("#fld_DELIVERYDATE").val();
        if (!deliverydate || deliverydate == undefined) {
            return true;
        }
        var contractDateObj = new Date(deliverydate);
        var target = new Date("2025-10-01 00:00:00");

        if (contractDateObj >= target) {
            alert("10月及之后的订单暂时无法提交，如存在相关问题请联系订购中心");
            return false;
        }

        return true;
    }
    /**
* 校验“是否需要验收”的资产类别是否一致
* @returns {boolean} 校验结果（true=一致，false=不一致）
*/
    function validateAssetTypes() {
        // 1. 收集所有被选中的“是否需要验收”行的资产类别值
        if ($("#approvalType").val() == "0") return true;
        const selectedTypes = [];
        const checkedCheckboxes = document.querySelectorAll('input[type="checkbox"][id*="fld_NEEDACCEPT"]:checked');
        if (!checkedCheckboxes) return true;
        // 转换为for循环遍历（通过索引访问）
        for (let i = 0; i < checkedCheckboxes.length; i++) {
            // 获取当前循环的checkbox元素
            const checkbox = checkedCheckboxes[i];

            // 1. 定位到checkbox所在的<tr>行元素
            const row = checkbox.closest('tr');
            if (!row) {
                console.warn('未找到checkbox所在的行元素');
                continue; // 跳过当前循环，处理下一个checkbox
            }

            // 2. 在当前行中查找id包含"fld_ASSETCLASS"的元素
            const assetClassElement = row.querySelector('[id*="fld_ASSETCLASS"]');
            if (!assetClassElement) {
                console.warn('当前行中未找到id包含"fld_ASSETCLASS"的元素');
                continue; // 跳过当前循环，处理下一个checkbox
            }

            // 3. 获取元素值并添加到数组（修复原代码中return导致后续逻辑无效的问题）
            selectedTypes.push(assetClassElement.value);
        }

        // 2. 若选中行数 < 2，无需校验（或根据需求调整，如“至少选1行时校验”）
        if (selectedTypes.length < 2) {
            return true; // 可根据业务需求修改，比如“至少选2行才校验”则返回 selectedTypes.length >= 2
        }

        // 3. 检查所有选中的类别是否一致
        const firstType = selectedTypes[0];
        const isAllSame = selectedTypes.every(type => type === firstType);

        // 4. 不一致则提示错误
        if (!isAllSame) {
            alert('选中“是否需要验收”的资产类别必须保持一致！');
            return false;
        }
        return true;
    }
    function validateACCEPTMARK() {
        if ($("#approvalType").val() == "0") return true;
        const selectedTypes = [];
        const acceptmarks = document.querySelectorAll('[id*="fld_ACCEPTMARK"]');
        if (!acceptmarks) return true;
        for (let i = 0; i < acceptmarks.length; i++) {
            // 获取当前索引对应的元素
            const element = acceptmarks[i];
            // 容错：确保元素有value属性再添加
            if (element.value !== undefined && element.value !== "") {
                selectedTypes.push(element.value);
            }
        }
        // 检查是否存在重复值（相同内容出现超过1次）
        // Set会自动去重，若去重后的长度小于原数组长度，说明有重复
        const hasDuplicate = new Set(selectedTypes).size !== selectedTypes.length;

        if (hasDuplicate) {
            alert('验收/质保标志不能有重复值！');
            return false;
        }
        //if (selectedTypes.length < 2) {
        //    return true; // 可根据业务需求修改，比如“至少选2行才校验”则返回 selectedTypes.length >= 2
        //}
        //// 3. 检查所有选中的类别是否一致
        //const firstType = selectedTypes[0];
        //const isAllSame = selectedTypes.every(type => type === firstType);

        //// 4. 不一致则提示错误
        //if (!isAllSame) {
        //    alert('验收/质保标志必须唯一！');
        //    return false;
        //}
        return true;
    }
</script>
