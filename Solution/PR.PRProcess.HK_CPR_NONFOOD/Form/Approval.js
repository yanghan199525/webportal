//Custom method write here
function beforSubmit() {
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
    return true;
}
function approveForm() {
    var InputTime = new Date($("#fld_DELIVERYDATE").val());
    var datetime = new Date($("#hdDatetime").val());
    if (InputTime < datetime) {
        alert("要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am");
        return false;
    }
}
function futureDateTime(field, rules, i, options) {
    debugger
    var InputTime = new Date($("#fld_DELIVERYDATE").val());
    var datetime = new Date($("#hdDatetime").val());
    if (InputTime < datetime) {
        options.allrules.validate2fields.alertText = "要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am";
        return options.allrules.validate2fields.alertText;
    }
}
$(function () {
    //员工编号 进行显示
    $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
    if (isIE()) {
        alert("提醒：审批流模块在IE浏览器下可能会出现系统错误，请切换至Edge或Chrome浏览器访问。Remind：Process approval  module’s system operation may have errors in IE browser, please change to Edge or Chrome.");
        //提示完毕，关闭页面
        window.close();
    }


    //将总价金额转化成千分位显示
    debugger
    var StepName = getUrlParam('StepName');
    var Type = getUrlParam('Type').toUpperCase();
    if (StepName == 'Applicant Confirmation') {
        if (Type == 'MYTASK') {
            $("#read_DELIVERYDATE").addClass("hidden");
            $("#edit_DELIVERYDATE").removeClass("hidden");
            if ($("#fld_DELIVERYDATE").val() != '') {
                var DeliveryDate = $("#fld_DELIVERYDATE").val();
                //var read_DELIVERYDATESHOW = $("#read_DELIVERYDATESHOW").text();
                //$("#fld_DELIVERYDATESHOW").val(read_DELIVERYDATESHOW);
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

    var div_field_SITENAME_height = $("#div_field_SITENAME .form-label").height();
    $("#div_field_DELIVERYDATE .form-label").height(div_field_SITENAME_height);
})

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}