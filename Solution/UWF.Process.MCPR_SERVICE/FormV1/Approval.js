//Custom method write here
var config = {
    // 需要显示/隐藏的div选择器
    divs: "#div_upload_Inv",
    // 需要添加/移除验证的输入框选择器
    inputs: "#fld_INVOICETYPE,#fld_INVOICENUMBER,#fld_BUYERNAME,#fld_BUYERTAXID",
    // 表格中需要显示/隐藏的列类名（含表头和表体）
    tableCols: ["td_INVOICETYPE", "td_INVOICENUMBER", "td_BUYERNAME", "td_BUYERTAXID", "th_ch", "td_INVOICEPATH"]
};

// 多语言映射
const langMap = {
    zh: { empty: "无", fixedAssets01: "固定资产", fixedAssets02: "非固定资产" },
    en: { empty: "Nothing", fixedAssets01: "Fixed Assets", fixedAssets02: "Not Fixed Assets" }
};

$(function () {
    if (isIE()) {
        alert("提醒：审批流模块在IE浏览器下可能会出现系统错误，请切换至Edge或Chrome浏览器访问。Remind：Process approval  module’s system operation may have errors in IE browser, please change to Edge or Chrome.");
        window.close();
        return;
    }

    //员工编号显示，申请部门隐藏
    $("#UserInfo1_read_APPLICANTACCOUNT").parents("div").eq(2).removeAttr("hidden");
    $("#UserInfo1_read_DEPARTMENT").parents("div").eq(2).hide();

    // SHOWREMARK 0/1转文字
    const $showRemark = $("#read_SHOWREMARK");
    $showRemark.text($showRemark.text() === "0" ? "否" : "是");

    const language = ($("#hdLanguage").val() || "").toLowerCase();
    const langKey = language === "en-us" ? "en" : "zh";

    // 审批人空值替换
    const approverIds = ["#read_USER_SIGNEDAPPROVERNAME", "#read_USER_SIGNEDAPPROVER2NAME", "#read_USER_SIGNEDAPPROVER3NAME"];
    approverIds.forEach(id => {
        const $el = $(id);
        if (!$el.html()) {
            $el.html(langMap[langKey].empty);
        }
    });

    // 固定资产翻译
    const $fixedAssets = $("#read_FIXEDASSETS");
    const faVal = $fixedAssets.html();
    if (faVal === "01") {
        $fixedAssets.html(langMap[langKey].fixedAssets01);
    } else if (faVal === "02") {
        $fixedAssets.html(langMap[langKey].fixedAssets02);
    }

    const stepName = getUrlParam('StepName');
    const type = (getUrlParam('Type') || "").toUpperCase();

    // 送货日期编辑/只读切换
    if (stepName === 'Applicant Confirmation' && type === 'MYTASK') {
        $("#read_DELIVERYDATE").addClass("hidden");
        $("#edit_DELIVERYDATE").removeClass("hidden");
        const $deliveryDate = $("#fld_DELIVERYDATE");
        const val = $deliveryDate.val();
        if (val) {
            $deliveryDate.val(val.replace(/\//g, '-'));
        }
    } else {
        $("#read_DELIVERYDATE").removeClass("hidden");
        $("#edit_DELIVERYDATE").addClass("hidden");
    }

    // label高度对齐
    const labelHeight = $("#div_field_SITENAME .form-label").height();
    $("#div_field_DELIVERYDATE .form-label").height(labelHeight);

    showInvoiceInfo();
    initInvoiceLinks();
});

function beforSubmit() {
    const stepName = getUrlParam('StepName');
    const type = (getUrlParam('Type') || "").toUpperCase();
    if (stepName === 'Applicant Confirmation' && type === 'MYTASK') {
        const val = $("#fld_DELIVERYDATE").val() || "";
        const delivery = val.replace(/-/g, "").replace(/:/g, "").replace(/\s*/g, "");
        $("#var_DELIVERY").val(delivery.substr(0, delivery.length - 2));
    }
    return true;
}

function approveForm() {
    const inputTime = new Date($("#fld_DELIVERYDATE").val());
    const datetime = new Date($("#hdDatetime").val());
    if (inputTime < datetime) {
        alert("要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am");
        return false;
    }
    return true;
}

function futureDateTime(field, rules, i, options) {
    const inputTime = new Date($("#fld_DELIVERYDATE").val());
    const datetime = new Date($("#hdDatetime").val());
    if (inputTime < datetime) {
        const msg = "要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am";
        options.allrules.validate2fields.alertText = msg;
        return msg;
    }
}

//获取url中的参数
function getUrlParam(name) {
    const reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    const r = window.location.search.substr(1).match(reg);
    return r ? decodeURIComponent(r[2]) : null;
}

function isIE() {
    return !!window.ActiveXObject || "ActiveXObject" in window;
}

function initInvoiceLinks() {
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
        const displayText = pathValue.split('_').length > 1 ? pathValue.split('_').pop() : pathValue;
        $link.text(displayText).show();
    } else {
        $link.hide();
    }
}

function showInvoiceInfo() {
    const isShow = $("#read_SUPPLIERTYPE").text() === "5";
    config.tableCols.forEach(colClass => {
        const selector = `#tb_MCPR_SERVICE_ITEMS thead tr td.${colClass}, #tb_MCPR_SERVICE_ITEMS tbody tr td.${colClass}`;
        isShow ? $(selector).show() : $(selector).hide();
    });
}
