//Custom method write here
function beforeSubmit() {
    debugger
    var StepName = getUrlParam('StepName');
    var Type = getUrlParam('Type').toUpperCase();
    if (StepName == 'Applicant Confirmation') {
        if (Type == 'MYTASK') {
            var fld_DELIVERYDATE = $("#fld_DELIVERYDATE").val();
            var delivery = fld_DELIVERYDATE.replace(/-/g, "").replace(/:/g, "").replace(/\s*/g, "");
            $("#read_DELIVERY").val(delivery.substr(0, delivery.length - 2));
        }
    }
    if ($("#fileinfo").find("tr").length <= 0 && StepName.trim() == 'SignedApprover') {
        alert("请至少上传一个附件");
        return false;
    }
    return true;
}
$(function () {
    debugger
    var StepName = getUrlParam('StepName');
    var Type = getUrlParam('Type').toUpperCase();
    if (StepName == 'Applicant Confirmation') {
        if (Type == 'MYTASK') {
            $("#read_DELIVERYDATE").addClass("hidden");
            $("#edit_DELIVERYDATE").removeClass("hidden");
            if ($("#fld_DELIVERYDATE").val() != '') {
                var DeliveryDate = $("#fld_DELIVERYDATE").val();
                $("#fld_DELIVERYDATE").val(DeliveryDate.replace(/\//g, '-'));
            }
        }
        else if (Type == 'REPORT') {
            $("#read_DELIVERYDATE").removeClass("hidden");
            $("#edit_DELIVERYDATE").addClass("hidden");
        }
    }
    else {
        $("#read_DELIVERYDATE").removeClass("hidden");
        $("#edit_DELIVERYDATE").addClass("hidden");
        $("#fld_DELIVERYDATE").next().next().text($("#fld_DELIVERYDATE").val());
    }
    if (StepName == "SignedApprover" && Type == 'MYTASK') {

    } else {
        $("#Attachments1_actionRow").addClass("hidden");
        $("#fileinfo").find("td:last").addClass("hidden");
        $("#uploadifive-file_upload").parent().css("display", "none");
    }
})
function futureDateTime(field, rules, i, options) {
    debugger
    var InputTime = new Date($("#fld_DELIVERYDATE").val());
    var datetime = new Date($("#hdDatetime").val());
    if (InputTime < datetime) {
        options.allrules.validate2fields.alertText = "要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am";
        return options.allrules.validate2fields.alertText;
    }
}

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
