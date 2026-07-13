$(function () {
    //员工编号 进行显示
    $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
    if (isIE()) {
        alert("提醒：审批流模块在IE浏览器下可能会出现系统错误，请切换至Edge或Chrome浏览器访问。Remind：Process approval  module’s system operation may have errors in IE browser, please change to Edge or Chrome.");
        window.close();
    }
 
    debugger
    if ($("#fld_DELIVERYDATE").val() != '' && $("#fld_DELIVERYDATE").val() != undefined) {
        var DeliveryDate = $("#fld_DELIVERYDATE").val();
        $("#fld_DELIVERYDATE").val(DeliveryDate.replace(/\//g, '-'));
        //$("#fld_DELIVERYDATESHOW").val($("#fld_DELIVERYDATE").val().split('T')[0]);
        //var str = getFormatDate();
        //$("#hdDate").val(str);

        var date = new Date();
        date = date.setDate(date.getDate() + 1);
        date = new Date(date);
        var str = date.getFullYear() + "/" + ((date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1)) + "/" + (date.getDate() > 9 ? date.getDate() : "0" + date.getDate())
        $("#hdDatetime").val(str + " 18:00:00");
    }

    debugger
    var Type = getUrlParam('Type').toUpperCase();
    if (Type == "MYREQUEST") {
        $("#fld_DELIVERYDATE").next().next().text($("#fld_DELIVERYDATE").val());
    }
    if (Type == "MYTASK") {
        debugger
        $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
        $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());
        var tabCtl = document.getElementById("tb_CAPEX_NONFOOD_ITEMS");
        var existrow = tabCtl.rows[tabCtl.rows.length - 1];
        
    }
    if (Type == "DRAFT") {
        hiddenSupplierType();
    }

    judgeLanguage();
    ckneedaccept_click();
    ckremovable_click();
    ckbuybacktermt_click();
})

function getFormatDate() {
    var nowDate = new Date();
    var year = nowDate.getFullYear();
    var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
    var oldMonth = month;
    //var date = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
    var date = nowDate.getDate();
    if (month == "12") {
        year = year + 1;
        month = "01";
    }
    var lastday = getLastMonthDay(year, month);
    if (date == lastday) {
        if (oldMonth != "12") {
            month = nowDate.getMonth() + 2 < 10 ? "0" + (nowDate.getMonth() + 2) : nowDate.getMonth() + 2;
        }
        date = "01";
    }
    else {
        date = date + 1;
    }
    date = date < 10 ? "0" + date : date;
    return year + "-" + month + "-" + date;
}

function getLastMonthDay(year, month) {
    var day = new Date(year, month, 0);
    var lastdate = day.getDate();//获取当月最后一天日期  
    return lastdate;
}

//function CheckOrderLimt() {
//    debugger
//    isOrderQuantity();
//}

function futureDateTime(field, rules, i, options) {
    debugger
    var InputTime = new Date($("#fld_DELIVERYDATE").val());
    var datetime = new Date($("#hdDatetime").val());
    if (InputTime < datetime) {
        options.allrules.validate2fields.alertText = "要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am";
        return options.allrules.validate2fields.alertText;
    }
}
//Custom method write here
function beforeSubmit () {
    debugger
    var Language = judgeLanguage();

    var fld_suppliercode = $("#fld_SUPPLIERCODE").val();
    var fld_suppliername = $("#fld_SUPPLIERNAME").val();

    var tabCtl = document.getElementById("tb_CAPEX_NONFOOD_ITEMS");
    var existrow = tabCtl.rows[tabCtl.rows.length - 1];
    var Language = judgeLanguage();

    if (!isOrderQuantity()) {
        return false;
    }
    //物料行数<=90
    if ((tabCtl.rows.length - 1) > 90) {
        if (Language == 'en-US') {
            alert("Item quantity should be less than 90 lines.");
        } else {
	    alert("提示：添加的物料行数请不要超过90行!");
        }
        return false;
    }

    if (tabCtl.rows.length == 2 && $(existrow).find("input[id*='fld_APPLYREASON']").val() == "") {
        if (Language == 'en-US') {
            $('#btnAddCPRItems').validationEngine('showPrompt', 'Material information cannot be empty', 'error');
        }
        else {
            $('#btnAddCPRItems').validationEngine('showPrompt', '物料信息不能为空', 'error');
        }
        return false;
    }
    else if (fld_suppliercode == "" || fld_suppliername == "") {
        if (Language == 'en-US') {
            alert("Supplier information cannot be empty");
        }
        else {
            alert("供应商信息不能为空");
        }
        return false;
    }
    else if (!checkArticleCode()) {
        if (Language == 'en-US') {
            alert("The same material is currently available and cannot be submitted. Please save the draft first and contact the administrator");
        }
        else {
            alert("当前存在相同物料，无法提交，请先保存草稿，并联系管理员");
        }
        return false;
    }
    else {
        var m = 0;
        var n = 0;
        var actual_amount = 0;

        for (var i = 1; i < tabCtl.rows.length; i++) {
            var existrow_ = tabCtl.rows[i];
            var subsubfamilycode = $(existrow_).find("input[id*='fld_SUBSUBFAMILYCODE']").val();
            var subsubfamilyname = $(existrow_).find("input[id*='fld_SUBSUBFAMILYNAME']").val();
            debugger
            var siteprice = $(existrow_).find("input[id*='fld_SITEPRICE']").val();
            var orderquantity = $(existrow_).find("input[id*='fld_ORDERQUANTITY']").val();
            var subtotalamount = numberval($(existrow_).find("input[id*='fld_SUBTOTALAMOUNT']").val());
            var actualamount = numberval(siteprice) * numberval(orderquantity);
            if (subtotalamount != actualamount) {
                n++;
                subtotalamount = actualamount;
            }
            actual_amount += subtotalamount;

            if (subsubfamilycode == "" || subsubfamilycode == null || subsubfamilycode == undefined) {
                m++;
                if (Language == 'en-US') {
                    $('#btnAddCPRItems').validationEngine('showPrompt', 'Item Sub Subcategory cannot be empty', 'error');
                }
                else {
                    $('#btnAddCPRItems').validationEngine('showPrompt', '物品子子类别不能为空', 'error');
                }
            }
            else if (subsubfamilyname == "" || subsubfamilyname == "请选择") {
                m++;
                if (Language == 'en-US') {
                    $('#btnAddCPRItems').validationEngine('showPrompt', 'Item Sub Subcategory cannot be empty', 'error');
                }
                else {
                    $('#btnAddCPRItems').validationEngine('showPrompt', '物品子子类别不能为空', 'error');
                }
            }
        }

        if (n > 0) {
            amount = 0;
            amount = calculatenumber(numberval(actual_amount), numberval(amount), 1);
            $('#fld_AMOUNT').val(thousands(amount));
        }
        if (m > 0) {
            return false;
        }
        else {
            return true;
        }
    }
}



//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}

//判断当前用户使用的语言
function judgeLanguage() {
    debugger
    var btnAdd_Text = $("#btnAddCPRItems").text().trim().replace(/[ ]/g, "");
    if (/^[a-zA-Z]+$/.test(btnAdd_Text)) {
        $("#hdLanguage").val('en-US');
        return 'en-US';
    }
    else {
        $("#hdLanguage").val('zh-CN');
        return 'zh-CN';
    }
}

function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window)
        return true;
    else
        return false;
}
function ckneedaccept_click() {
    // 全选/反选功能
    $("#ch_needaccept").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".ckneedacceptItem input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".ckneedacceptItem input[type='checkbox']").on("click", function () {
        var allChecked = $(".ckneedacceptItem input[type='checkbox']:checked").length === $(".ckneedacceptItem input[type='checkbox']").length;
        $("#ch_needaccept").prop("checked", allChecked);

    });

}
function ckbuybacktermt_click() {
    // 全选/反选功能
    $("#ch_buybackterm").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".ckbuybacktermitem input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".ckbuybacktermitem input[type='checkbox']").on("click", function () {
        var allChecked = $(".ckbuybacktermitem input[type='checkbox']:checked").length === $(".ckbuybacktermitem input[type='checkbox']").length;
        $("#ch_buybackterm").prop("checked", allChecked);

    });

}
function ckremovable_click() {
    // 全选/反选功能
    $("#ch_removable").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".ckremovableitem input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".ckremovableitem input[type='checkbox']").on("click", function () {
        var allChecked = $(".ckremovableitem input[type='checkbox']:checked").length === $(".ckremovableitem input[type='checkbox']").length;
        $("#ch_removable").prop("checked", allChecked);

    });

}