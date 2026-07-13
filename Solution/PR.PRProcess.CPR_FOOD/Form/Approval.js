// 提取重复选择器和配置，方便维护
var config = {
    // 需要显示/隐藏的div选择器（合并为一个字符串）
    // divs: "#div_field_INVOICETYPE,#div_field_INVOICENUMBER,#div_field_BUYERNAME,#div_field_BUYERTAXID,#div_upload_Inv",
    divs: "#div_upload_Inv",
    // 需要添加/移除验证的输入框选择器
    inputs: "#fld_INVOICETYPE,#fld_INVOICENUMBER,#fld_BUYERNAME,#fld_BUYERTAXID",
    // 表格中需要显示/隐藏的列类名（含表头和表体）
    tableCols: ["td_INVOICETYPE", "td_INVOICENUMBER", "td_BUYERNAME", "td_BUYERTAXID", "th_ch", "td_INVOICEPATH"]
};
//Custom method write here
function beforSubmit() {
    debugger
    var StepName = getUrlParam('StepName');
    var Type = getUrlParam('Type').toUpperCase();
    if (StepName == 'Applicant Confirmation') {
        if (Type == 'MYTASK') {
           
            var fld_DELIVERYDATE = $("#fld_DELIVERYDATE").val();
            var delivery = fld_DELIVERYDATE.replace(/-/g, "").replace(/:/g, "").replace(/\s*/g, "");
            $("#var_DELIVERY").val(delivery.substr(0, delivery.length - 2));
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
    var showRemark = $("#read_SHOWREMARK").text();
    if (showRemark == "0") {
        $("#read_SHOWREMARK").text("否");
    }
    else {
        $("#read_SHOWREMARK").text("是");
    }

    //将总价金额转化成千分位显示

    var language = $("#hdLanguage").val().toLowerCase();
    var read_ONLINEORSUPERMARKET = $("#read_ONLINEORSUPERMARKET").html();
    if (read_ONLINEORSUPERMARKET == 1) {
        if (language == "en-us") {
            $("#read_ONLINEORSUPERMARKET").html('Online Or Supermarket');
        }
        else {
            $("#read_ONLINEORSUPERMARKET").html('网上或超市采购');
        }
    }
    else if (read_ONLINEORSUPERMARKET == 0) {
        if (language == "en-us") {
            $("#read_ONLINEORSUPERMARKET").html('Not Online Or Supermarket');
            
        }
        else {
            $("#read_ONLINEORSUPERMARKET").html('非网上或超市采购');
        }
    }
    debugger
    var read_FIXEDASSETS = $("#read_FIXEDASSETS").html();
    if (read_FIXEDASSETS == "01") {
        if (language == "en-us") {
            $("#read_FIXEDASSETS").html('Fixed Assets');
        }
        else {
            $("#read_FIXEDASSETS").html('固定资产');
        }
    }
    else if (read_FIXEDASSETS == "02") {
        if (language == "en-us") {
            $("#read_FIXEDASSETS").html('Not Fixed Assets');

        }
        else {
            $("#read_FIXEDASSETS").html('非固定资产');
        }
    }

    var read_USER_SIGNEDAPPROVERNAME = $("#read_USER_SIGNEDAPPROVERNAME").html();
    var read_USER_SIGNEDAPPROVER2NAME = $("#read_USER_SIGNEDAPPROVER2NAME").html();
    var read_USER_SIGNEDAPPROVER3NAME = $("#read_USER_SIGNEDAPPROVER3NAME").html();
    if (read_USER_SIGNEDAPPROVERNAME == "") {
        if (language == "en-us") {
            $("#read_USER_SIGNEDAPPROVERNAME").html('Nothing');
        }
        else {
            $("#read_USER_SIGNEDAPPROVERNAME").html('无');
        }
        
    }
    if (read_USER_SIGNEDAPPROVER2NAME == "") {
        if (language == "en-us") {
            $("#read_USER_SIGNEDAPPROVER2NAME").html('Nothing');
        }
        else {
            $("#read_USER_SIGNEDAPPROVER2NAME").html('无');
        }
        
    }
    if (read_USER_SIGNEDAPPROVER3NAME == "") {
        if (language == "en-us") {
            $("#read_USER_SIGNEDAPPROVER3NAME").html('Nothing');
        }
        else {
            $("#read_USER_SIGNEDAPPROVER3NAME").html('无');
        }
        
    }

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
        $("#read_DELIVERYDATE").text($("#fld_DELIVERYDATE").val());
        $("#fld_DELIVERYDATE").next().next().text($("#fld_DELIVERYDATE").val());
    }

    showInvoiceInfo();
    var div_field_SITENAME_height = $("#div_field_SITENAME .form-label").height();
    $("#div_field_DELIVERYDATE .form-label").height(div_field_SITENAME_height);
    isShow();
    initInvoiceLinks();
})

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}


function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window)
        return true;
    else
        return false;
}


function editCPRRow(tbItems, familycode) {
    var username = getUrlParam('UserName');
    var sitecode = $("#read_SITECODE").text();   
    url = "EditFamily.aspx?materialcategory=Food&sitecode=" + sitecode + "&familycode=" + familycode+"&username=" + username+"";
     height = "350px";
        buttons = [{
            label: '修改',
            cssClass: 'btn btn-default btn-md',
            action: function (dialog) {

                var val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue1();
                if (val == "") {

                } else {
                    var res = val[0];
                    addCPRITEMRow(tbItems, res);
                    dialog.close();
                }
            }
        },
        {
            label: '取消',
            cssClass: 'btn btn-md',
            action: function (dialog) {
                dialog.close();
            }
        }];
        BootstrapDialog.show({
            title: '添加物料',
            animate: false,
            closable: false,
            size: BootstrapDialog.SIZE_NORMAL,
            message: $('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'),
            buttons: buttons
        });
 
}

function addCPRITEMRow(tabId, res) {
    try {
        var tabCtl = document.getElementById(tabId);
        var existrow = tabCtl.rows[tabCtl.rows.length - 1];
        debugger 
            $(existrow).find("input[id*='fld_SUBFAMILYCODE']").val(res.subfamilycode);
            $(existrow).find("input[id*='fld_SUBFAMILYNAME']").val(res.subfamilyname);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(res.subsubfamilycode);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(res.subsubfamilyname);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYCE']").val(res.subsubfamilyce);
        hiddenSupplierType();
    }
    catch (e) {
    }
}

function isShow() {
    var suppliertype = $("#read_SUPPLIERTYPE").text();   
    if (suppliertype != "2") {
        $(".btn-icon-sm-edit").css("display", "none");;
    } else {
        $(".btn-icon-sm-edit").css("display", "block");;
    }
    
}
function initInvoiceLinks() {
    // 遍历所有表体行的INVOICEPATH文本框
    $("#tb_CPRFOOD_ITEMS tbody tr td.td_INVOICEPATH [data-field='INVOICEPATH']").each(function () {
        syncInvoiceLink(this); // 同步当前文本框对应的链接
    });
}

function syncInvoiceLink(textbox) {

    const $textbox = $(textbox);
    const pathValue = $textbox.val().trim(); // 获取文本框中的路径值
    console.log(11, pathValue);
    const $link = $textbox.next(".invoice-path-link"); // 找到同级的链接标签

    if (pathValue) {
        // 路径有值：更新链接的href和显示文本
        $link.attr("href", pathValue);
        $link.text(pathValue.split('_').length > 1 ? pathValue.split('_').pop() : pathValue); // 超长路径省略显示
        $link.show(); // 显示链接
        console.log(1101, pathValue);
    } else {
        // 路径为空：隐藏链接
        console.log(1102, pathValue);
        $link.hide();
    }

}
function showInvoiceInfo() {

    if ($("#read_SUPPLIERTYPE").text() == "5") {
        //$(config.divs).removeClass("hidden");
        // 添加必填验证
        //$(config.inputs).addClass("validate[required]");
        // 显示表格列（遍历所有列类名，同时处理表头和表体）
        config.tableCols.forEach(function (colClass) {
            $(`#tb_CPRFOOD_ITEMS thead tr td.${colClass}, #tb_CPRFOOD_ITEMS tbody tr td.${colClass}`).show();
        });
    }
    else {
        // 隐藏div
        //$(config.divs).addClass("hidden");
        // 移除必填验证
        //$(config.inputs).removeClass("validate[required]");

        // 隐藏表格列（遍历所有列类名，同时处理表头和表体）
        config.tableCols.forEach(function (colClass) {
            $(`#tb_CPRFOOD_ITEMS thead tr td.${colClass}, #tb_CPRFOOD_ITEMS tbody tr td.${colClass}`).hide();
        });
    }

}



