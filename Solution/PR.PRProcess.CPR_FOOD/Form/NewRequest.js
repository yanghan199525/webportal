var arrData;
// 提取重复选择器和配置，方便维护
var config = {
    // 需要显示/隐藏的div选择器（合并为一个字符串）
    // divs: "#div_field_INVOICETYPE,#div_field_INVOICENUMBER,#div_field_BUYERNAME,#div_field_BUYERTAXID,#div_upload_Inv",
     divs: "#div_upload_Inv",
    // 需要添加/移除验证的输入框选择器
    inputs: "#fld_INVOICETYPE,#fld_INVOICENUMBER,#fld_BUYERNAME,#fld_BUYERTAXID",
    // 表格中需要显示/隐藏的列类名（含表头和表体）
    tableCols: ["td_INVOICETYPE", "td_INVOICENUMBER", "td_BUYERNAME", "td_BUYERTAXID", "th_ch","td_INVOICEPATH"]
};
$(function () {
    debugger
    $.ajax({
        type: "post",
        datatype: "json",
        contentType: "application/json",
        async: false,
        url: 'NewRequest.aspx/BindIsOneTime',
        success: function (data) {
            debugger
            if (data.d != "") {
                arrData = JSON.parse(data.d);
            } else {
            }
        }
    });
    //员工编号 进行显示
    $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
    //页面加载隐藏询报价功能
    //$("#ArticleRFQ").css("display", "none");
    //Add By Sylvia At 2020-04-27
    //页面加载是否预付隐藏
    //$("#div_field_IsPrePaid").css("display", "none");
    if (isIE()) {
        alert("提醒：审批流模块在IE浏览器下可能会出现系统错误，请切换至Edge或Chrome浏览器访问。Remind：Process approval  module’s system operation may have errors in IE browser, please change to Edge or Chrome.");
        //提示完毕，关闭页面
        window.close();
    }
    $("#div_field_FIXEDASSETS").change(function () {
        changeFixedAssets();
    })
    $("#div_field_IsPrePaid").change(function () {
        changeIsPrePaid();
    })
    //Add By Sylvia At 2020-08-03
    $("#div_field_ONLINEORSUPERMARKET").change(function () {
        changeOnlineProcurement();
    })

    //将总价金额转化成千分位显示
    debugger
    if ($("#fld_DELIVERYDATE").val() != '') {
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
    //var ShowType = getUrlParam('ShowType');
    if (Type == "NEWREQUEST") {
        changeFixedAssets();
        changeApplyPurpose();
    }
    if (Type == "MYREQUEST") {
        $("#fld_DELIVERYDATE").next().next().text($("#fld_DELIVERYDATE").val());
    }
    if (Type == "MYTASK") {
        debugger
        changeApplyPurpose(true);
        changeSupplierType();
        ProcessingQuantity();
        //changeFixedAssets(true);

        $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
        $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());
        var tabCtl = document.getElementById("tb_CPRFOOD_ITEMS");
        var existrow = tabCtl.rows[tabCtl.rows.length - 1];
        if (tabCtl.rows.length == 2 && $(existrow).find("input[id*='fld_APPLYREASON']").val() == "") {
            //$("#fld_SUPPLIERTYPE").removeAttr("disabled");
            blockSupplierType();
        } else {
            //$("#fld_SUPPLIERTYPE").attr("disabled", "disabled");
            hiddenSupplierType();
        }
    }
    if (Type == "DRAFT") {
        hiddenSupplierType();
    }
    judgeLanguage();
    showInvoiceInfo();
    var Amount = $("#fld_AMOUNT").val();
    $("#fld_AMOUNT").val(thousands(numberval(Amount)));
    $("#fld_AMOUNT").next("span").text($("#fld_AMOUNT").val());
    //将单价转化成千分位
    $("#fld_detail_PROC_CPRFOOD_ITEMS_ctl00_fld_SITEPRICE").next("span").text
        (thousands(numberval($("#fld_detail_PROC_CPRFOOD_ITEMS_ctl00_fld_SITEPRICE").val())));


    // 1. 配置：允许的文件格式（统一为发票常用格式）和大小限制（4MB）
    const ALLOWED_FORMATS = ['.pdf', '.ofd', '.xml']; // 统一格式
    const MAX_SIZE = 4 * 1024 * 1024; // 4MB（字节）

    // 2. 定位控件（兼容ASP.NET生成的带前缀ID，用"结尾匹配"选择器）
    const $fileUpload = $('[id$=fileUpload]'); // 匹配ID以fileUpload结尾的控件
    const $customSelectBtn = $('#customSelectBtn'); // 自定义选择按钮
    const $fileNamesDisplay = $('#fileNamesDisplay'); // 文件名显示
    const $uploadButton = $('[id$=uploadButton]'); // 上传按钮
    const $errorLabel = $('[id$=errorLabel]'); // 错误提示

    // 3. 点击自定义按钮 → 触发原生FileUpload选择文件
    $customSelectBtn.click(function () {
        $fileUpload.click();
    });

    // 4. 选择文件后 → 验证格式和大小，并更新显示
    $fileUpload.change(function () {
        const files = this.files;
        if (files.length === 0) {
            resetFileDisplay();
            return;
        }

        // 验证所有选中文件
        const validateResult = validateFiles(files);
        if (!validateResult.valid) {
            showError(validateResult.msg); // 显示错误
            resetFileInput(); // 清空选择（避免无效文件残留）
            return;
        }

        // 验证通过 → 更新文件名显示
        updateFileDisplay(files);
        hideError();
    });

    // 5. 点击上传按钮 → 二次验证（防止绕过客户端验证）
    $uploadButton.click(function (e) {
        const files = $fileUpload[0].files;
        if (files.length === 0) {
            showError('请先选择文件');
            e.preventDefault(); // 阻止提交
            return;
        }

        const validateResult = validateFiles(files);
        if (!validateResult.valid) {
            showError(validateResult.msg);
            e.preventDefault(); // 阻止提交
        }
    });

    // 辅助函数：验证文件（返回{valid: 布尔值, msg: 错误信息}）
    function validateFiles(files) {
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const fileName = file.name;
            const fileExt = getFileExtension(fileName).toLowerCase(); // 扩展名转小写

            // 验证格式
            if (!ALLOWED_FORMATS.includes(fileExt)) {
                return {
                    valid: false,
                    msg: `文件 "${fileName}" 格式不支持！仅允许：${ALLOWED_FORMATS.join('、')}`
                };
            }

            // 验证大小
            if (file.size > MAX_SIZE) {
                return {
                    valid: false,
                    msg: `文件 "${fileName}" 超过大小限制（最大4MB）`
                };
            }
        }
        return { valid: true, msg: '' };
    }

    // 辅助函数：获取文件扩展名（如".pdf"）
    function getFileExtension(fileName) {
        const lastDotIndex = fileName.lastIndexOf('.');
        return lastDotIndex === -1 ? '' : fileName.slice(lastDotIndex);
    }

    // 辅助函数：更新文件显示（多文件时显示"X个文件"）
    function updateFileDisplay(files) {
        if (files.length === 1) {
            $fileNamesDisplay.text(files[0].name); // 单个文件显示文件名
        } else {
            $fileNamesDisplay.text(`已选择 ${files.length} 个文件`); // 多文件显示数量
        }
    }

    // 辅助函数：重置文件输入（清空选择）
    function resetFileInput() {
        $fileUpload.val('');
    }

    // 辅助函数：重置显示状态
    function resetFileDisplay() {
        $fileNamesDisplay.text('未选择任何文件');
        hideError();
    }

    // 辅助函数：显示错误
    function showError(msg) {
        $errorLabel.text(msg).show();
    }

    // 辅助函数：隐藏错误
    function hideError() {
        $errorLabel.text('').hide();
    }

    //initInvoiceLinks();

    //onUploadCompleted();
})
//判断是否为代采购，是则隐藏网超选择框
function changeApplyPurpose(init) {
    var ApplyPurpose = $("#fld_APPLYPURPOSE").val();
    debugger
    if (ApplyPurpose == "2") {
        $("#SupplementaryBlank1").removeClass("hidden");
        $("#SupplementaryBlank2").removeClass("hidden");
        $("#div_field_ONLINEORSUPERMARKET").addClass("hidden");
        $("#div_field_FIXEDASSETS").addClass("hidden");
        $("#SupplementaryBlank1 .form-field").removeAttr("style");
        $("#SupplementaryBlank2 .form-field").removeAttr("style");

        alert("分店选择待采购需要提交独立的采购合同或客户订单。如果合同的内容符合以下条件的，则可以按代采购处理.\nDefinition of Purchasing activity on behalf of client \n \nIf the purchasing was requested by client and meet below criteria, Sodexo is acting as an agent during this activity.\n如果由客户提出的采购要求并同时满足以下条件，索迪斯在此业务中作为一个代理人。\n \n➢ Sodexo has no discretion in selecting the supplier(decided by client) used to fulfil an order; 索迪斯无权选择供应商(由客户决定)履行订单;\n➢ Sodexo have no discretion in establishing prices(decided by client);索迪斯没有定价权(由客户决定); \n➢ Sodexo doesn’t have the risks and rewards of ownership,such as general inventory risk before delivery or after returns, or inventory risks during shipping;索迪斯不拥有所有权的风险及回报，一般库存风险或在运输过程中的库存风险;\n➢ Sodexo can not modify the product(i.e.convert the raw materials supplies purchased) or performs part of the services(which was decided by client);索迪斯不可以修改采购产品或执行部分服务(由客户决定);\n➢ Sodexo was not involved in the determination of product or service specifications.索迪斯不能决定产品或服务的具体规格要求 \n \n   We treated them as purchasing activity on behalf of client,then the revenue will be only the commission or the margin(i.e.a net basis).我们认为这些是代客户采购业务，那么收入按佣金或加成（即净额）计算。");
        var divDD = document.getElementById("div_field_FIXEDASSETS");
        var inputs = divDD.getElementsByTagName("input");
        inputs[1].checked = true;
        AssignSignedApprover(init);
    }
    else {
        $("#SupplementaryBlank1").addClass("hidden");
        $("#SupplementaryBlank2").addClass("hidden");
        $("#div_field_ONLINEORSUPERMARKET").removeClass("hidden");
        //$("#div_field_FIXEDASSETS").removeClass("hidden");
        clearSignedFixedApprover(init);
        $(".USER_SignedApprover").attr("style", "pointer-events:auto;cursor: pointer;");
        $(".USER_SignedApprover").next().attr("style", "pointer-events:auto;cursor: pointer;");
    }
}
//判断是否为授权供应商，是则默认非网超且不可修改
function changeSupplierType() {
    debugger
    var SupplierType = $("#fld_SUPPLIERTYPE").val();
    if (SupplierType == "9") {
        var divDD = document.getElementById("div_field_ONLINEORSUPERMARKET");
        var inputs = divDD.getElementsByTagName("input");
        inputs[0].setAttribute("disabled", "disabled");
        inputs[1].checked = true;
        $("#fld_APPREMARK").removeClass("validate[required]");
        $("#fld_APPREMARK").siblings(".fld_APPREMARKformError").remove();
        //$("#ArticleRFQ").css("display", "block");
        //$("#supplerName").attr("disabled", true)

        //var vRbtidList = document.getElementsByName("RadioButtonList_Batch");
        //for (var i = 0; i < vRbtidList.length; i++) {
        //    debugger
        //    if (vRbtidList[i].checked) {
        //        if (vRbtidList[i].value == 1) {
        //            $("#btnAddCPRItems").attr("disabled", true)
        //            $("#RFQ_Number").attr("disabled", false);
        //            $("#supplerName").attr("disabled", false);
        //            $("#btn_Add").attr("disabled", false)
        //            $("#btn_Delete").attr("disabled", false)
        //        } else {
        //            $("#btnAddCPRItems").attr("disabled", false)
        //            $("#btn_Add").attr("disabled", true)
        //            $("#btn_Delete").attr("disabled", true)
        //            $("#RFQ_Number").attr("disabled", true);
        //            $("#supplerName").attr("disabled", true);
        //        }
        //    }
        //}
        //显示是否预付
        //$("#div_field_IsPrePaid").css("display", "block");
    }
    else {
        var divDD = document.getElementById("div_field_ONLINEORSUPERMARKET");
        var inputs = divDD.getElementsByTagName("input");
        inputs[0].removeAttribute("disabled");
        $("#fld_APPREMARK").addClass("validate[required]");    
        //$("#ArticleRFQ").css("display", "none");
        //$("#div_field_IsPrePaid").css("display", "none");
    }
    

    showInvoiceInfo();
    $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
    $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());
    suppliertype = $("#fld_SUPPLIERTYPE").val();
    suppliertypetxt = $("#fld_SUPPLIERTYPE").find("option:selected").text();
}
//Add By Sylvia At 2020-04-27
//判断是否为固定资产，是则一级加签审批人不可选
function changeFixedAssets(init) {
    debugger
    var FixedAsets;
    var vRbtid = document.getElementById("div_field_FIXEDASSETS");
    var vRbtidList = vRbtid.getElementsByTagName("input");
    for (var i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) {
            var value = vRbtidList[i].value;
            FixedAsets = value;
        }
    }
    debugger
    if (FixedAsets == "01") {
        debugger
        var fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
        var fld_USER_SIGNEDAPPROVER = $("#fld_USER_SIGNEDAPPROVER").val();
        var userinfo = $("#hdFixedAssetsSignedApprover").val();
        if (userinfo != ";") {
            var loginName = userinfo.split(';')[0];
            var cnname = userinfo.split(';')[1];

            if (fld_USER_SIGNEDAPPROVERNAME.search("" + cnname + "") != -1 && fld_USER_SIGNEDAPPROVER.search("" + loginName + "")) {
                $("#fld_USER_SIGNEDAPPROVER2NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER3NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER2").val("");
                $("#fld_USER_SIGNEDAPPROVER3").val("");
            }
            else {
                $("#fld_USER_SIGNEDAPPROVERNAME").val("");
                $("#fld_USER_SIGNEDAPPROVER2NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER3NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER").val("");
                $("#fld_USER_SIGNEDAPPROVER2").val("");
                $("#fld_USER_SIGNEDAPPROVER3").val("");
            }

            $("#fld_USER_SIGNEDAPPROVER").val("USER:org=CustomOC,user=CustomOC/" + loginName);
            var Language = judgeLanguage();
            if (Language == 'en-US') {
                $("#fld_USER_SIGNEDAPPROVERNAME").val(loginName);
            }
            else {
                $("#fld_USER_SIGNEDAPPROVERNAME").val(cnname);
            }

            $(".USER_SignedApprover").attr("style", "pointer-events:none;");
            $(".USER_SignedApprover").next().attr("style", "pointer-events:none;");
        }
        else {
            vRbtidList[0].setAttribute("disabled", "disabled");
            vRbtidList[1].checked = true;
        }
    }
    else {
        debugger
        clearSignedFixedApprover();
        $(".USER_SignedApprover").attr("style", "pointer-events:auto;cursor: pointer;");
        $(".USER_SignedApprover").next().attr("style", "pointer-events:auto;cursor: pointer;");
    }
}

function clearSignedFixedApprover(init) {
    if (init) return;
    debugger
    var fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
    var fld_USER_SIGNEDAPPROVER = $("#fld_USER_SIGNEDAPPROVER").val();
    var fld_USER_SIGNEDAPPROVER2NAME = $("#fld_USER_SIGNEDAPPROVER2NAME").val();
    var fld_USER_SIGNEDAPPROVER2 = $("#fld_USER_SIGNEDAPPROVER2").val();
    var fld_USER_SIGNEDAPPROVER3NAME = $("#fld_USER_SIGNEDAPPROVER3NAME").val();
    var fld_USER_SIGNEDAPPROVER3 = $("#fld_USER_SIGNEDAPPROVER3").val();
    if (fld_USER_SIGNEDAPPROVERNAME != '' || fld_USER_SIGNEDAPPROVER != '') {
        $("#fld_USER_SIGNEDAPPROVERNAME,#fld_USER_SIGNEDAPPROVER").val('');
        $("#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2").val('');
        $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
        //if (fld_USER_SIGNEDAPPROVER2NAME != '' || fld_USER_SIGNEDAPPROVER2 != '') {
        //    $("#fld_USER_SIGNEDAPPROVERNAME").val(fld_USER_SIGNEDAPPROVER2NAME);
        //    $("#fld_USER_SIGNEDAPPROVER").val(fld_USER_SIGNEDAPPROVER2);
        //    if (fld_USER_SIGNEDAPPROVER3NAME != '' || fld_USER_SIGNEDAPPROVER3 != '') {
        //        $("#fld_USER_SIGNEDAPPROVER2NAME").val(fld_USER_SIGNEDAPPROVER3NAME);
        //        $("#fld_USER_SIGNEDAPPROVER2").val(fld_USER_SIGNEDAPPROVER3);
        //    }
        //}
    }
}

//原始
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

//此方法为只选日期的情况下
//function getFormatDate() {
//    debugger
//    var nowDate = new Date();
//    var year = nowDate.getFullYear();
//    var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
//    //var month = "12";
//    var oldMonth = month;
//    var date = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
//    //var date = "30";
//    if (month == "12") {
//        year = year + 1;
//        month = "01";
//    }
//    var lastday = getLastMonthDay(year, month);
//    if (date == lastday) {
//        if (oldMonth != "12") {
//            month = nowDate.getMonth() + 2 < 10 ? "0" + (nowDate.getMonth() + 2) : nowDate.getMonth() + 2;
//        }
//        date = "02";
//    }
//    else if (date == (lastday - 1)) {
//        if (oldMonth != "12") {
//            month = nowDate.getMonth() + 2 < 10 ? "0" + (nowDate.getMonth() + 2) : nowDate.getMonth() + 2;
//        }
//        date = "01";
//    }
//    else {
//        date = date + 2;
//    }
//    return year + "-" + month + "-" + date;
//}

function getLastMonthDay(year, month) {
    var day = new Date(year, month, 0);
    var lastdate = day.getDate();//获取当月最后一天日期  
    return lastdate;
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

//function CheckOrderLimt() {
//    debugger
//    isOrderQuantity();
//}

function isOrderQuantity() {
    var tabCtl = document.getElementById("tb_CPRFOOD_ITEMS");
    var r = /^([1-9]\d*(\.\d{1,2})?|([0](\.([0][1-9]|[1-9]\d{0,1}))))$/;


    for (var i = 1; i < tabCtl.rows.length; i++) {
        var existrow = tabCtl.rows[i];
        var orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();
        var InitOrderLimt = $(existrow).find("input[id*='InitOrderLimt']").val();
        var articleName = $(existrow).find("input[id*='fld_ARTICLENAME']").val();
        var articleCode = $(existrow).find("input[id*='fld_ARTICLECODE']").val();
        var fld_ORDERUNIT = $(existrow).find("input[id*='fld_ORDERUNIT']").val();
        var result = checkPositiveIntegerQuantity(orderquantity, existrow, fld_ORDERUNIT);
        if (!result) {
            return false;
        }
        if (arrData != undefined && arrData.length > 0) {

            for (var j = 0; j < arrData.length; j++) {
                if (arrData[j].ArticleCode == articleCode) {
                    if (InitOrderLimt != null && InitOrderLimt != undefined && InitOrderLimt != "") {
                        if (!r.test(orderquantity)) {
                            alert("请输入大于0的整数或者保留一到两位小数！");
                            return false;
                        } else if ((InitOrderLimt - (InitOrderLimt * 0.05)) > orderquantity || (InitOrderLimt * 1.05) < orderquantity) {
                            alert("物品名称为" + articleName + "的数量不能超过初始值" + InitOrderLimt + "的正负百分之五");
                            return false;
                        }
                    }
                }
            }
            //if (arrData.find(articleCode) != -1) {

            //}
        }
    }
    return true;
}


function checkPositiveIntegerQuantity(orderquantity, existrow, netvomuleunit) {
    if (netvomuleunit == "KG" || netvomuleunit == "Hour" || netvomuleunit == "Meter" || netvomuleunit == "Square meter" || netvomuleunit == "小时" || netvomuleunit == "米" || netvomuleunit == "平方" || netvomuleunit == "千克" || netvomuleunit == "克" || netvomuleunit == "G" || netvomuleunit == "立方" || netvomuleunit == "M" || netvomuleunit == "M2" || netvomuleunit == "M3"|| netvomuleunit == "平方米" ) {
        if (orderquantity != '') {
            var reg = /^([1-9]\d*(\.\d{0,2})?|([0](\.([0][1-9]|[1-9]\d{0,2}))))$/;
            if (orderquantity.split('.')[1] == "00" || orderquantity.split('.')[1] == "0") {
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(orderquantity));
                orderquantity = parseInt(orderquantity);
            }
            else {
                if (orderquantity.indexOf(".") != -1) {
                    var lastnum = orderquantity.substr(orderquantity.length - 1, 1);
                    if (lastnum == "0") {
                        var new_orderquantity = orderquantity.substr(0, orderquantity.length - 1);
                        orderquantity = orderquantity.substr(0, orderquantity.length - 1);
                        $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(new_orderquantity);
                    }
                }
            }
            //var reg = /([1-9]\d*(\.\d*[1-9])?)|(0\.\d*[1-9])/;
            if (reg.test(orderquantity)) {
                return true;
            } else {
                alert("请输入大于0的整数或者保留一到两位小数！\nPlease enter an integer greater than 0 or keep one or two places");
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val('');
                return false;
            }
        }
    }
    else {
        if (orderquantity.split('.')[1] == "00" || orderquantity.split('.')[1] == "0") {
            $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(orderquantity));
            orderquantity = parseInt(orderquantity);
        }
        if (orderquantity != '') {
            var reg = /^[1-9]+\d*$/;
            if (reg.test(orderquantity)) {
                return true;
            } else {
                alert("请输入大于0的整数\nPlease enter an integer greater than 0");
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val('');
                return false;
            }
        }
    }
}


//Custom method write here
function beforeSubmit() {
    var Language = judgeLanguage();
    debugger
    //var deliverydate = $("#fld_DELIVERYDATESHOW").val();
    //$("#fld_DELIVERYDATE").val(deliverydate + "T06:00");
    $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
    $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());
    var fld_suppliercode = $("#fld_SUPPLIERCODE").val();
    var fld_suppliername = $("#fld_SUPPLIERNAME").val();

    var tabCtl = document.getElementById("tb_CPRFOOD_ITEMS");
    var existrow = tabCtl.rows[tabCtl.rows.length - 1];
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
        //var Language = judgeLanguage();
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
            alert("Currently there is the same material or the same peer number. It cannot be submitted. Please save the draft first and contact the administrator");
        }
        else {
            alert("当前存在相同物料或存在相同行号，无法提交，请先保存草稿，并联系管理员");
        }
        return false;
    }
    else if (checkShowRemark()) {
        if (Language == 'en-US') {
            alert("Please fill in the remarks");
        }
        else {
            alert("请填写备注");
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
        //add yang.han
        //时间判断
        //debugger;
        //var time = new Date();
        //if (time.getHours() < 11 && time.getHours() >= 0) {
        //    if (Language == 'en-US'){
        //        alert("Due to system adjustment, please submit CPR after 11 am! Please contact ordering center for any problems.");
        //    } else {
        //        alert("因系统调整，6月25日起单外订单申请请在每天11点后系统提交！如有疑问请联系订购中心。");
        //    }
        //    return false;
        //}
        if (m > 0) {
            return false;
        }
        else {
            document.getElementById('ButtonList1_btnSend').style.display = 'none'; // 隐藏创建流程的提交按钮
            return true;
        }
    }
    debugger;
    document.getElementById('ButtonList1_btnSend').style.display = 'none'; // 隐藏创建流程的提交按钮

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

//添加行
//Add by Sean 2017-12-26
function addPRItemsRow(tbItems) {
    debugger
    var Language = judgeLanguage();

    //debugger
    var returnFunc;
    //var selectedcategory = $('input[name="fld_ASSETTYPE"]').filter(':checked').val();
    var selectedcategory = $('#fld_ASSETTYPE').val();
    var suppliertype = $('#fld_SUPPLIERTYPE').val();
    var sitecode = $('#fld_SITECODE').val();
    var pccode = document.getElementById("fld_SITECODE").value;
    if (sitecode != pccode) {
        alert("提示：浏览器版本问题，导致获取分店编号异常!");
    }
    var suppliercode = $('#fld_SUPPLIERCODE').val();
    var suppliername = $('#fld_SUPPLIERNAME').val();
    //alert(suppliertype);

    var familycode = $('#fld_CPRFAMILYCODE').val();
    //var supplierCode = $('#fld_SUPPLIERCODE').val();

    if ($("#" + tbItems + " tr:not(:first)").length >= 90) {
        if (Language == 'en-US') {
            alert("Item quantity should be less than 90 lines.");
        } else {
            alert("提示：添加的物料行数请不要超过90行!");
        }
        return false;
    }

    if (selectedcategory == undefined) {
        if (Language == 'en-US') {
            alert("Please select the item type first( Food / NonFood /Service )");
        }
        else {
            alert("请先选择物品类型（食品/非食品/服务）");
        }
    } else if (suppliertype == "" || suppliertype == undefined) {
        if (Language == 'en-US') {
            alert("Please select the type of purchase first");
        }
        else {
            alert("请先选择采购类型");
        }
    } else if (suppliertype == 9) {
        //window.open("ArticleList.aspx", "Add Article", "frameborder = no style = 'border-width:0px;overflow-y:auto;overflow-x:hidden;'");
        var username = getUrlParam('UserName');
        url = "ArticleList.aspx?suppliercode=" + suppliercode + "&sitecode=" + sitecode + "&username=" + username;
        url = encodeURI(url);
        height = "500px";
        if (Language == 'en-US') {
            buttons = [{
                label: 'Save',
                cssClass: 'btn btn-default btn-md',
                action: function (dialog) {
                    var val = $(dialog.getModalBody().find('#frmWindowArticle'))[0].contentWindow.returnValue1();
                    if (val == "") {

                    } else {
                        console.log(val);
                        AddCprArticle(tbItems, val);
                        dialog.close();
                    }
                }
            }, {
                label: 'Cancel',
                cssClass: 'btn btn-md',
                action: function (dialog) {
                    dialog.close();
                }
            }];
            BootstrapDialog.show({
                title: 'Add Article',
                animate: false,
                closable: false,
                size: BootstrapDialog.SIZE_WIDE,
                message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'),
                buttons: buttons
            });
        }
        else {
            buttons = [{
                label: '保存',
                cssClass: 'btn btn-default btn-md',
                action: function (dialog) {
                    var val = $(dialog.getModalBody().find('#frmWindowArticle'))[0].contentWindow.returnValue1();
                    if (val == "") {

                    } else {
                        console.log(val);
                        AddCprArticle(tbItems, val);
                        dialog.close();
                    }
                }
            }, {
                label: '取消',
                cssClass: 'btn btn-md',
                action: function (dialog) {
                    dialog.close();
                }
            }];
            BootstrapDialog.show({
                title: '添加物料清单',
                animate: false,
                closable: false,
                size: BootstrapDialog.SIZE_WIDE,
                message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'),
                buttons: buttons
            });
        }
    } else {
        var username = getUrlParam('UserName');
        url = "AddPRItemPage.aspx?materialcategory=" + selectedcategory + "&suppliertype=" + suppliertype + "&sitecode=" + sitecode + "&suppliercode=" + suppliercode + "&familycode=" + familycode + "&suppliername=" + suppliername + "&username=" + username;
        url = encodeURI(url);
        height = "600px";

        if (Language == 'en-US') {
            buttons = [{
                label: 'Save',
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
            }, {
                label: 'Save and continue Adding',
                cssClass: 'btn btn-default btn-md',
                action: function (dialog) {
                    var val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue2();
                    if (val == "") {

                    } else {
                        var res = val[0];
                        addCPRITEMRow(tbItems, res);
                    }
                }
            }, {
                label: 'Cancel',
                cssClass: 'btn btn-md',
                action: function (dialog) {
                    dialog.close();
                }
            }];
            BootstrapDialog.show({
                title: 'Add Article',
                animate: false,
                closable: false,
                size: BootstrapDialog.SIZE_NORMAL,
                message: $('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'),
                buttons: buttons
            });
        }
        else {
            buttons = [{
                label: '保存',
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
            }, {
                label: '保存并继续添加',
                cssClass: 'btn btn-default btn-md',
                action: function (dialog) {
                    var val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue2();
                    if (val == "") {

                    } else {
                        var res = val[0];
                        addCPRITEMRow(tbItems, res);
                    }
                }
            }, {
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
    }

    //addRow(tbItems);
}
var amount;

function addCPRITEMRow(tabId, res) {

    if ($.trim($('#fld_AMOUNT').val()) == "") {
        amount = 0;
    } else {
        amount = numberval($.trim($('#fld_AMOUNT').val()));
    }
    try {
        var tabCtl = document.getElementById(tabId);
        var existrow = tabCtl.rows[tabCtl.rows.length - 1];
        debugger
        if (tabCtl.rows.length == 2 && $(existrow).find("input[id*='fld_APPLYREASON']").val() == "") {
            //var existrow = tabCtl.rows[tabCtl.rows.length - 1];
            $('#fld_SUPPLIERCODE').val(res.suppliercode);

            $('#fld_SUPPLIERNAME').val(res.supplier);

            $(existrow).find("input[id*='fld_APPLYREASON']").val(res.applyreason);

            $(existrow).find("input[id*='fld_FAMILYCODE']").val(res.familycode);
            $('#fld_CPRFAMILYCODE').val(res.familycode);
            //alert($('#fld_CPRFAMILYCODE').val());

            $(existrow).find("input[id*='fld_FAMILYNAME']").val(res.familyname);

            $(existrow).find("input[id*='fld_SUBFAMILYCODE']").val(res.subfamilycode);
            $(existrow).find("input[id*='fld_SUBFAMILYNAME']").val(res.subfamilyname);

            $(existrow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(res.subsubfamilycode);
            $(existrow).find("input[id*='fld_OLDSUBSUBFAMILYCODE']").val(res.subsubfamilycode);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(res.subsubfamilyname);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYCE']").val(res.subsubfamilyce);


            $(existrow).find("input[id*='fld_INVOICETYPE']").val(res.InvoiceType);
            $(existrow).find("input[id*='fld_TAXCODE']").val(res.taxCode);
            $(existrow).find("input[id*='fld_TAXRATE']").val(res.taxRate);
            $(existrow).find("input[id*='fld_ARTICLEID']").val(res.articleid);

            if (res.article != "" && res.article != "请选择") {
                $(existrow).find("input[id*='fld_ARTICLENAME']").val(res.article);
                $(existrow).find("input[id*='fld_ARTICLECODE']").val(res.articlecode);
            } else {
                $(existrow).find("input[id*='fld_ARTICLENAME']").val(res.otherarticlename);
            }
            debugger

            $(existrow).find("input[id*='fld_ORDERUNIT']").val(res.orderunittext);
            $(existrow).find("input[id*='fld_ORDERUNITVALUE']").val(res.orderunit);

            $(existrow).find("input[id*='fld_UNIT']").val(res.unittext);
            $(existrow).find("input[id*='fld_UNITVALUE']").val(res.unit);

            $(existrow).find("input[id*='fld_CONSUMPTIONUNIT']").val(res.consumptionunittext);
            $(existrow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(res.consumptionunit);

            $(existrow).find("input[id*='fld_CONVERSION']").val(res.conversion);
            $(existrow).find("input[id*='fld_STOCK']").val(res.stock);

            $(existrow).find("input[id*='fld_NETVOMULE']").val(res.netvomule);
            $(existrow).find("input[id*='fld_NETVOMULEUNIT']").val(res.netvomuleunit);

            $(existrow).find("input[id*='fld_GROSSWEIGHT']").val(res.grossweight);
            $(existrow).find("input[id*='fld_GROSSWEIGHTUNIT']").val(res.grossweightunit);

            $(existrow).find("input[id*='fld_SITEPRICE']").val(res.siteprice);
            $(existrow).find("input[id*='fld_NETNETPRICE']").val(res.netnetprice);
            if (res.orderquantity.split('.')[1] == "00" || res.orderquantity.split('.')[1] == "0") {
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(res.orderquantity));
            } else {
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(res.orderquantity);
            }

            $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val(res.subtotalamount);
            //var rowtotal = Number(res.siteprice) * Number(res.orderquantity);
            //amount = Number(amount) + rowtotal;

            amount = calculatenumber(res.subtotalamount, amount, 1);
            $('#fld_AMOUNT').val(thousands(amount));
            //$('#fld_AMOUNT').val(amount);
        }
        else {
            if (!checkCPRItems(tabId, res)) {
                var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
                var newRow = modelTr.cloneNode(true);
                //var rowIndex = newRow.rowIndex - 1;
                var rowIndex = tabCtl.rows.length - 1;
                newRow = changeRowID(newRow, rowIndex);
                clearRow(newRow);
                if ($(tabCtl.rows[1]).attr("class") == "hidden") {
                    $(newRow).find(".index").html(rowIndex);
                    $(newRow).find(".index").val(rowIndex);
                }
                else {
                    $(newRow).find(".index").html(rowIndex + 1);
                    $(newRow).find(".index").val(rowIndex + 1);
                }
                debugger
                //$('#fld_SUPPLIERCODE').val(res.suppliercode);
                //$('#fld_SUPPLIERNAME').val(res.supplier);

                $(newRow).find("input[id*='fld_APPLYREASON']").val(res.applyreason);

                $(newRow).find("input[id*='fld_FAMILYCODE']").val(res.familycode);
                debugger
                //$('#fld_CPRFAMILYCODE').val(res.familycode);
                //alert($('#fld_CPRFAMILYCODE').val());
                $(newRow).find("input[id*='fld_FAMILYNAME']").val(res.familyname);

                $(newRow).find("input[id*='fld_SUBFAMILYCODE']").val(res.subfamilycode);
                $(newRow).find("input[id*='fld_SUBFAMILYNAME']").val(res.subfamilyname);

                $(newRow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(res.subsubfamilycode);
                $(newRow).find("input[id*='fld_OLDSUBSUBFAMILYCODE']").val(res.subsubfamilycode);
                $(newRow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(res.subsubfamilyname);
                $(newRow).find("input[id*='fld_SUBSUBFAMILYCE']").val(res.subsubfamilyce);

                $(newRow).find("input[id*='fld_INVOICETYPE']").val(res.InvoiceType);
                $(newRow).find("input[id*='fld_TAXCODE']").val(res.taxCode);
                $(newRow).find("input[id*='fld_TAXRATE']").val(res.taxRate);

                $(newRow).find("input[id*='fld_ARTICLEID']").val(res.articleid);

                debugger
                if (res.article != "" && res.article != "请选择") {
                    $(newRow).find("input[id*='fld_ARTICLENAME']").val(res.article);
                    $(newRow).find("input[id*='fld_ARTICLECODE']").val(res.articlecode);
                } else {
                    $(newRow).find("input[id*='fld_ARTICLENAME']").val(res.otherarticlename);
                }
                debugger

                $(newRow).find("input[id*='fld_ORDERUNIT']").val(res.orderunittext);
                $(newRow).find("input[id*='fld_ORDERUNITVALUE']").val(res.orderunit);


                $(newRow).find("input[id*='fld_UNIT']").val(res.unittext);
                $(newRow).find("input[id*='fld_UNITVALUE']").val(res.unit);


                $(newRow).find("input[id*='fld_CONSUMPTIONUNIT']").val(res.consumptionunittext);
                $(newRow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(res.consumptionunit);

                $(newRow).find("input[id*='fld_CONVERSION']").val(res.conversion);
                $(newRow).find("input[id*='fld_STOCK']").val(res.stock);

                $(newRow).find("input[id*='fld_NETVOMULE']").val(res.netvomule);
                $(newRow).find("input[id*='fld_NETVOMULEUNIT']").val(res.netvomuleunit);

                $(newRow).find("input[id*='fld_GROSSWEIGHT']").val(res.grossweight);
                $(newRow).find("input[id*='fld_GROSSWEIGHTUNIT']").val(res.grossweightunit);

                $(newRow).find("input[id*='fld_SITEPRICE']").val(res.siteprice);
                $(newRow).find("input[id*='fld_NETNETPRICE']").val(res.netnetprice);
                $(newRow).find("input[id*='fld_ORDERQUANTITY']").val(res.orderquantity);
                if (res.orderquantity.split('.')[1] == "00" || res.orderquantity.split('.')[1] == "0") {
                    $(newRow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(res.orderquantity));
                } else {
                    $(newRow).find("input[id*='fld_ORDERQUANTITY']").val(res.orderquantity);
                }

                $(newRow).find("input[id*='fld_SUBTOTALAMOUNT']").val(res.subtotalamount);
                $(newRow).find("a[class*='invoice-path-link']").attr("href", "").text("");
                //var rowtotal = Number(res.siteprice) * Number(res.orderquantity);
                //amount = Number(amount) + rowtotal;

                amount = calculatenumber(res.subtotalamount, amount, 1);
                $('#fld_AMOUNT').val(thousands(amount));

                $(tabCtl).find("tbody")[0].appendChild(newRow);

                $("#" + tabId + "_rowCount").val(rowIndex + 1);


                if (isIE()) {
                    $('input[data-type="date"]').daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });
                    $('input[data-type="datetime"]').daterangepicker({
                        "singleDatePicker": true, "timePicker": true,
                        "timePicker24Hour": true, format: "YYYY/MM/DD  HH:mm"
                    });
                }

                var ubtn = $(newRow).find(".uploadifive-button")[0];
                if (ubtn) {
                    $(ubtn).attr("id", $(ubtn).attr("id").replace("uploadifive-", ""));
                    $(ubtn).attr("class", $(ubtn).attr("class").replace("uploadifive-button", "attachment"));
                    $(ubtn).empty();
                }

                attachUpload($(newRow).find(".attachment")[0]);
                $(newRow).removeClass("hidden");

                reActiveCss();
            }
            else {
                var suppliertype = $("#fld_SUPPLIERTYPE").val();
                if (suppliertype == "9") {
                    amount = calculatenumber(res.subtotalamount, amount, 1);
                    $('#fld_AMOUNT').val(thousands(amount));
                }
                else {
                    SumAmount();
                }

                alert('已存在当前物料，自动为您修改数量！\nExisting Article, automatically modify the quantity for you');
            }
        }

        //$("#fld_SUPPLIERTYPE").attr("disabled", "disabled");
        hiddenSupplierType();
        //initInvoiceLinks();
    }
    catch (e) {
    }
}

function BindsupplierName(pccode, subsubfamily, suppliercode) {
    debugger
    datadata = "{\"searchcondition\":\"" + suppliercode + "\",\"pccode\":\"" + pccode + "\",\"subfamilycode\":\"" + subsubfamily + "\"}";
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'NewRequest.aspx/BindSupplier',
        data: datadata,
        success: function (data) {
            if (data != "") {
                var arrData = JSON.parse(data.d);
                $("#fld_SUPPLIERNAME").val(arrData[0].SupplierNameCN);
                alert(arrData[0].SupplierNameCN);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {


        }
    });
}

// Add yang.han time:2021-10-27
function AddCprArticle(tabId, arrData) {


    $("#fld_SUPPLIERCODE").val(arrData[0].suppliercode);

    $("#fld_SUPPLIERNAME").val(arrData[0].supplier);

    if ($.trim($('#fld_AMOUNT').val()) == "") {
        amount = 0;
    } else {
        amount = numberval($.trim($('#fld_AMOUNT').val()));
    }
    var tabCtl = document.getElementById(tabId);
    //var arrData = JSON.parse(res);
    var FirstRow = tabCtl.rows[tabCtl.rows.length - 1];
    for (var i = 0; i < arrData.length; i++) {
        if (tabCtl.rows.length >= 2 && $(FirstRow).find("input[id*='fld_APPLYREASON']").val() != "") {
            var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
            var newRow = modelTr.cloneNode(true);
            var rowIndex = tabCtl.rows.length - 1;
            newRow = changeRowID(newRow, rowIndex);
            clearRow(newRow);
            if ($(tabCtl.rows[1]).attr("class") == "hidden") {
                $(newRow).find(".index").html(rowIndex);
                $(newRow).find(".index").val(rowIndex);
            }
            else {
                $(newRow).find(".index").html(rowIndex + 1);
                $(newRow).find(".index").val(rowIndex + 1);
            }
            $(newRow).find("input[id*='fld_APPLYREASON']").val("单外报价单产品");

            $(newRow).find("input[id*='fld_FAMILYCODE']").val(arrData[i].familycode);
            $('#fld_CPRFAMILYCODE').val(arrData[i].familycode);
            //alert($('#fld_CPRFAMILYCODE').val());

            $(newRow).find("input[id*='fld_FAMILYNAME']").val(arrData[i].familyname);

            $(newRow).find("input[id*='fld_SUBFAMILYCODE']").val(arrData[i].subfamilycode);
            $(newRow).find("input[id*='fld_SUBFAMILYNAME']").val(arrData[i].subfamilyname);

            $(newRow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(arrData[i].subsubfamilycode);
            $(newRow).find("input[id*='fld_OLDSUBSUBFAMILYCODE']").val(arrData[i].subsubfamilycode);
            $(newRow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(arrData[i].subsubfamilyname);
            $(newRow).find("input[id*='fld_SUBSUBFAMILYCE']").val(arrData[i].subsubfamilyce);

            $(newRow).find("input[id*='fld_INVOICETYPE']").val(arrData[i].InvoiceType);
            $(newRow).find("input[id*='fld_TAXCODE']").val(arrData[i].taxCode);
            $(newRow).find("input[id*='fld_TAXRATE']").val(arrData[i].taxRate);
            $(newRow).find("input[id*='InitOrderLimt']").val(arrData[i].InitOrderlimt);

            $(newRow).find("input[id*='fld_ARTICLEID']").val(arrData[i].articleid);
            if (arrData[i].article != "" && arrData[i].article != "请选择") {
                $(newRow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].article);
                $(newRow).find("input[id*='fld_ARTICLECODE']").val(arrData[i].articlecode);
            } else {
                $(newRow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].otherarticlename);
            }
            debugger

            $(newRow).find("input[id*='fld_ORDERUNIT']").val(arrData[i].orderunit);
            $(newRow).find("input[id*='fld_ORDERUNITVALUE']").val(arrData[i].orderunittext);

            $(newRow).find("input[id*='fld_UNIT']").val(arrData[i].unittext);
            $(newRow).find("input[id*='fld_UNITVALUE']").val(arrData[i].unit);

            $(newRow).find("input[id*='fld_CONSUMPTIONUNIT']").val(arrData[i].consumptionunittext);
            $(newRow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(arrData[i].consumptionunit);

            $(newRow).find("input[id*='fld_CONVERSION']").val(arrData[i].conversion);
            $(newRow).find("input[id*='fld_STOCK']").val(arrData[i].stock);

            $(newRow).find("input[id*='fld_NETVOMULE']").val(arrData[i].netvomule);
            $(newRow).find("input[id*='fld_NETVOMULEUNIT']").val(arrData[i].netvomuleunit);

            $(newRow).find("input[id*='fld_GROSSWEIGHT']").val(arrData[i].grossweight);
            $(newRow).find("input[id*='fld_GROSSWEIGHTUNIT']").val(arrData[i].grossweightunit);

            $(newRow).find("input[id*='fld_SITEPRICE']").val(arrData[i].siteprice);
            $(newRow).find("input[id*='fld_NETNETPRICE']").val(arrData[i].netnetprice);
            if (arrData[i].orderquantity.split('.')[1] == "00" || arrData[i].orderquantity.split('.')[1] == "0") {
                $(newRow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(arrData[i].orderquantity));
            } else {
                $(newRow).find("input[id*='fld_ORDERQUANTITY']").val(arrData[i].orderquantity);
            }

            var subtotalamount = arrData[i].siteprice * arrData[i].orderquantity;
            $(newRow).find("input[id*='fld_SUBTOTALAMOUNT']").val(subtotalamount);

            amount = calculatenumber(subtotalamount, amount, 1);
            $('#fld_AMOUNT').val(thousands(amount));
            $(tabCtl).find("tbody")[0].appendChild(newRow);

            $("#tb_CPRFOOD_ITEMS_rowCount").val(rowIndex + 1);
            if (isIE()) {
                $('input[data-type="date"]').daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });
                $('input[data-type="datetime"]').daterangepicker({
                    "singleDatePicker": true, "timePicker": true,
                    "timePicker24Hour": true, format: "YYYY/MM/DD  HH:mm"
                });
            }
        }
        else {
            var existrow = tabCtl.rows[tabCtl.rows.length - 1];
            //$("#fld_SUPPLIERNAME").val(arrData[i].supplier);
            $(existrow).find("input[id*='fld_APPLYREASON']").val("单外报价单产品");

            $(existrow).find("input[id*='fld_FAMILYCODE']").val(arrData[i].familycode);
            $('#fld_CPRFAMILYCODE').val(arrData[i].familycode);
            //alert($('#fld_CPRFAMILYCODE').val());

            $(existrow).find("input[id*='fld_FAMILYNAME']").val(arrData[i].familyname);

            $(existrow).find("input[id*='fld_SUBFAMILYCODE']").val(arrData[i].subfamilycode);
            $(existrow).find("input[id*='fld_SUBFAMILYNAME']").val(arrData[i].subfamilyname);

            $(existrow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(arrData[i].subsubfamilycode);
            $(existrow).find("input[id*='fld_OLDSUBSUBFAMILYCODE']").val(arrData[i].subsubfamilycode);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(arrData[i].subsubfamilyname);
            $(existrow).find("input[id*='fld_SUBSUBFAMILYCE']").val(arrData[i].subsubfamilyce);

            $(existrow).find("input[id*='fld_INVOICETYPE']").val(arrData[i].InvoiceType);
            $(existrow).find("input[id*='fld_TAXCODE']").val(arrData[i].taxCode);
            $(existrow).find("input[id*='fld_TAXRATE']").val(arrData[i].taxRate);
            $(existrow).find("input[id*='InitOrderLimt']").val(arrData[i].InitOrderlimt);

            $(existrow).find("input[id*='fld_ARTICLEID']").val(arrData[i].articleid);

            if (arrData[i].article != "" && arrData[i].article != "请选择") {
                $(existrow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].article);
                $(existrow).find("input[id*='fld_ARTICLECODE']").val(arrData[i].articlecode);
            } else {
                $(existrow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].otherarticlename);
            }
            debugger

            $(existrow).find("input[id*='fld_ORDERUNIT']").val(arrData[i].orderunit);
            $(existrow).find("input[id*='fld_ORDERUNITVALUE']").val(arrData[i].orderunittext);

            $(existrow).find("input[id*='fld_UNIT']").val(arrData[i].unittext);
            $(existrow).find("input[id*='fld_UNITVALUE']").val(arrData[i].unit);

            $(existrow).find("input[id*='fld_CONSUMPTIONUNIT']").val(arrData[i].consumptionunittext);
            $(existrow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(arrData[i].consumptionunit);

            $(existrow).find("input[id*='fld_CONVERSION']").val(arrData[i].conversion);
            $(existrow).find("input[id*='fld_STOCK']").val(arrData[i].stock);

            $(existrow).find("input[id*='fld_NETVOMULE']").val(arrData[i].netvomule);
            $(existrow).find("input[id*='fld_NETVOMULEUNIT']").val(arrData[i].netvomuleunit);

            $(existrow).find("input[id*='fld_GROSSWEIGHT']").val(arrData[i].grossweight);
            $(existrow).find("input[id*='fld_GROSSWEIGHTUNIT']").val(arrData[i].grossweightunit);

            $(existrow).find("input[id*='fld_SITEPRICE']").val(arrData[i].siteprice);
            $(existrow).find("input[id*='fld_NETNETPRICE']").val(arrData[i].netnetprice);
            if (arrData[i].orderquantity.split('.')[1] == "00" || arrData[i].orderquantity.split('.')[1] == "0") {
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(arrData[i].orderquantity));
            } else {
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(arrData[i].orderquantity);
            }
            var subtotalamount = arrData[i].siteprice * arrData[i].orderquantity;
            $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val(subtotalamount);

            amount = calculatenumber(subtotalamount, amount, 1);
            $('#fld_AMOUNT').val(thousands(amount));
        }
    }
}

function calculatenumber(subtotalamount, amount, type) {
    if (type == 1) {
        amount = Math.round((numberval(subtotalamount) + numberval(amount)) * 100) / 100;
    } else {
        amount = Math.round((numberval(amount) - numberval(subtotalamount)) * 100) / 100;
    }
    return amount;
}

//删除行
function deleteCPRRow(tabId, ele) {
    debugger
    var tabCtl = document.getElementById(tabId);
    var tabRows = tabCtl.rows;
    var rowIndex = $(ele).parent().parent()[0].rowIndex;
    //Edit by Sean 2017-10-25 
    //if (rowIndex == 1) {
    var currentrow = tabCtl.rows[rowIndex];
    //var siteprice = $(currentrow).find("input[id*='fld_SITEPRICE']").val();
    //var orderquantity = $(currentrow).find("input[id*='fld_ORDERQUANTITY']").val();
    var subtotalamount = $(currentrow).find("input[id*='fld_SUBTOTALAMOUNT']").val();

    if ($.trim($('#fld_AMOUNT').val()) == "") {
        amount = 0;
    } else {
        amount = numberval($.trim($('#fld_AMOUNT').val()));
    }

    //var rowtotal = Number(siteprice) * Number(orderquantity);

    amount = calculatenumber(subtotalamount, amount, 2);
    $('#fld_AMOUNT').val(thousands(amount));

    if (rowIndex == 1 && tabRows.length == 2) {
        clearRow($(ele).parent().parent()[0]);
        //tabCtl.deleteRow(rowIndex);
        $('#fld_SUPPLIERCODE').val("");
        $('#fld_SUPPLIERNAME').val("");
        $('#fld_CPRFAMILYCODE').val("");
		$('#fld_AMOUNT').val(0);
        //$("#fld_SUPPLIERTYPE").removeAttr("disabled");
        blockSupplierType();
    }
    else {
        tabCtl.deleteRow(rowIndex);
    }
    $("#" + tabId + "_rowCount").val(tabRows.length - 1);

    tabCtl = document.getElementById(tabId);
    tabRows = tabCtl.rows;
    for (var i = 1; i < tabRows.length; i++) {
        changeRowID(tabRows[i], i - 1);

        $(tabRows[i]).find(".index").html(i);
        $(tabRows[i]).find(".index").val(i);
    }
}

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}

//物料明细数量部分，鼠标移出事件，计算金额
function SumAmount() {
    amount = 0;
    var tabCtl = document.getElementById("tb_CPRFOOD_ITEMS");
    for (var i = 1; i < tabCtl.rows.length; i++) {
        var existrow = tabCtl.rows[i];
        var siteprice = $(existrow).find("input[id*='fld_SITEPRICE']").val();
        var orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();
        var netvomuleunit = $(existrow).find("input[id*='fld_NETVOMULEUNIT']").val();
        var consumptionUnitValue = $(existrow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val();
        //var result = checkPositiveInteger(orderquantity, existrow, consumptionUnitValue);
        //if (!result) {
        //    break;
        //}
        orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();

        $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val(numberval(siteprice) * orderquantity);
        var subtotalamount = $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val();
        amount = calculatenumber(subtotalamount, amount, 1);
    }
    $("#fld_AMOUNT").val(thousands(amount));
}

//未审批通过，重新提交页面，对物料明细数量赋值进行小数点处理
function ProcessingQuantity() {
    var tabCtl = document.getElementById("tb_CPRFOOD_ITEMS");
    for (var i = 0; i < tabCtl.rows.length; i++) {
        if (i == 0) { continue; }
        var existrow = tabCtl.rows[i];
        var orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();
        if (orderquantity.split('.')[1] == "00") {
            $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(orderquantity));
        }
        else {
            if (orderquantity.indexOf(".") != -1) {
                var lastnum = orderquantity.substr(orderquantity.length - 1, 1);
                if (lastnum == "0") {
                    var new_orderquantity = orderquantity.substr(0, orderquantity.length - 1);
                    $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(new_orderquantity);
                }
            }
        }
    }
}

//Add by sylvia at 20200417
//修改为可输入整数、大于0且带有一位小数、大于0且带有两位小数
function checkPositiveInteger(orderquantity, existrow, netvomuleunit) {
    if (netvomuleunit == "KG" || netvomuleunit == "Hour" || netvomuleunit == "Meter" || netvomuleunit == "Square meter" || netvomuleunit == "M" || netvomuleunit == "M2" || netvomuleunit == "M3") {
        if (orderquantity != '') {
            var reg = /(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{1}$)|(^[0-9]*\.[0-9]{2}$)/;
            //var reg = /([1-9]\d*(\.\d*[1-9])?)|(0\.\d*[1-9])/;
            if (reg.test(orderquantity)) {
                if (orderquantity.split('.')[1] == "00" || orderquantity.split('.')[1] == "0") {
                    $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(parseInt(orderquantity));
                }
                else {
                    if (orderquantity.indexOf(".") != -1) {
                        var lastnum = orderquantity.substr(orderquantity.length - 1, 1);
                        if (lastnum == "0") {
                            var new_orderquantity = orderquantity.substr(0, orderquantity.length - 1);
                            $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(new_orderquantity);
                        }
                    }
                }
                return true;
            } else {
                alert("请输入大于0的整数或者保留一到两位小数\nPlease enter an integer greater than 0 or keep one or two decimal places");
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val('');
                return false;
            }
        }
    }
    else {
        if (orderquantity != '') {
            var reg = /^[1-9]+\d*$/;
            if (reg.test(orderquantity)) {
                return true;
            } else {
                alert("请输入大于0的正整数\nPlease enter a positive integer greater than 0");
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val('');
                return false;
            }
        }
    }
}

//Add By Sylvia At 2020-04-22
//Edit By Sylvia At 2020-05-19
//添加行之前判断是否有重复项，如果有，则不添加行，只修改数量
//名称，三层单位，两层转换率，子子类（非授权供应商、员工垫资）
function checkCPRItems(tabId, res) {
    var suppliertype = $("#fld_SUPPLIERTYPE").val();
    var tabCtl = document.getElementById(tabId);
    var orderquantity = res.orderquantity;

    if (suppliertype == "9") {
        debugger
        var articlecode = res.articlecode;
        var siteprice = res.siteprice;
        var m = 0;
        var n = tabCtl.rows.length - 1;

        for (var i = 1; i < tabCtl.rows.length; i++) {
            var existing_row = tabCtl.rows[i];
            var existing_articlecode = $(existing_row).find("input[id*='fld_ARTICLECODE']").val();
            var existing_orderquantity = $(existing_row).find("input[id*='fld_ORDERQUANTITY']").val();
            var existing_siteprice = $(existing_row).find("input[id*='fld_SITEPRICE']").val();
            if (articlecode == existing_articlecode && siteprice == existing_siteprice) {
                var new_orderquantity = numberval(orderquantity) + numberval(existing_orderquantity);
                $(existing_row).find("input[id*='fld_ORDERQUANTITY']").val(new_orderquantity);
                //return true;
            }
            else {
                m++;
                //return false;
            }
        }

        if (m == n) {
            return false;
        }
        else {
            return true;
        }
    }
    else {
        debugger
        var articlename = res.otherarticlename;//物品名称
        if (articlename == "") {
            articlename = res.article;
        }
        var orderunit = res.orderunit;//采购单位
        var unit = res.unit;//库存单位
        var consumptionunit = res.consumptionunit;//消耗单位
        var conversion = res.conversion;//转换率（采购-->库存）
        var stock = res.stock;//库存（库存-->消耗）
        var subsubfamilycode = res.subsubfamilycode;//子子类别

        var m = 0;
        var n = tabCtl.rows.length - 1;

        for (var j = 1; j < tabCtl.rows.length; j++) {
            var exist_rows = tabCtl.rows[j];
            var exist_articlename = $(exist_rows).find("input[id*='fld_ARTICLENAME']").val();
            var exist_orderunit = $(exist_rows).find("input[id*='fld_ORDERUNITVALUE']").val();
            var exist_unit = $(exist_rows).find("input[id*='fld_UNITVALUE']").val();
            var exist_consumptionunit = $(exist_rows).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val();
            var exist_conversion = $(exist_rows).find("input[id*='fld_CONVERSION']").val();
            var exist_stock = $(exist_rows).find("input[id*='fld_STOCK']").val();
            var exist_subsubfamilycode = $(exist_rows).find("input[id*='fld_SUBSUBFAMILYCODE']").val();

            var exist_orderquantity = $(exist_rows).find("input[id*='fld_ORDERQUANTITY']").val();
            if (articlename == exist_articlename && orderunit == exist_orderunit && unit == exist_unit && consumptionunit == exist_consumptionunit && conversion == exist_conversion && stock == exist_stock && subsubfamilycode == exist_subsubfamilycode) {
                debugger
                var news_orderquantity = numberval(orderquantity) + numberval(exist_orderquantity);
                $(exist_rows).find("input[id*='fld_ORDERQUANTITY']").val(news_orderquantity);
                //return true;
            }
            else {
                m++;
                //return false;
            }
        }

        if (m == n) {
            return false;
        }
        else {
            return true;
        }
    }
}

//Add by sylvia at 20200601
//添加行之前判断物料所属供应商是否相同
//function checkCPRItemsSupplierCode(res) {
//    var suppliercode = $("#fld_SUPPLIERCODE").val();
//    if (res.suppliercode != suppliercode) {
//        alert('物料所属供应商不同，无法添加\nThe material belongs to a different supplier, so it cannot be added');
//        return false;
//    }
//    else {
//        return true;
//    }
//}

//Add By Sylvia At 2020-04-28
//添加物料之后，隐藏采购类型DROPDOWNLIST，把文本显示在TEXTBOX框
function hiddenSupplierType() {
    debugger
    var code = $("#fld_SUPPLIERTYPE").val();
    var value = $("#fld_SUPPLIERTYPE").find("option:selected").text();
    /*删除项*/
    document.getElementById('fld_SUPPLIERTYPE').options.length = 0;
    /*添加项*/
    document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("" + value + "", "" + code + ""));
}
//删除物料之后，显示采购类型DROPDOWNLIST，隐藏文本TEXTBOX框
function blockSupplierType() {
    //$("#fld_SUPPLIERTYPE").removeClass("hidden");
    //$("#hidden_SUPPLIERTYPE").addClass("hidden");
    debugger
    var code = $("#fld_SUPPLIERTYPE").val();
    //alert(code);
    /*删除项*/
    document.getElementById('fld_SUPPLIERTYPE').options.length = 0;
    /*添加项*/
    var Language = judgeLanguage();
    if (Language == 'en-US') {
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("", ""));
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("Unauthorized Supplier", "2"));
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("Authorized Supplier", "9"));
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("Buying Outright", "5"));
    }
    else {
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("", ""));
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("非授权供应商", "2"));
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("授权供应商", "9"));
        document.getElementById("fld_SUPPLIERTYPE").options.add(new Option("员工垫资", "5"));
    }
    $("#fld_SUPPLIERTYPE").val(code);
}

//Add By Sylvia At 2020-06-23
//检查是否存在相同物料
function checkArticleCode() {
    debugger
    var suppliertype = $("#fld_SUPPLIERTYPE").val();
    var tabCtl = document.getElementById("tb_CPRFOOD_ITEMS");

    if (suppliertype == "9") {
        var m = 0, num = 0, no = 0;
        for (var i = 1; i < tabCtl.rows.length; i++) {
            var existing_row = tabCtl.rows[i];
            var existing_articlecode = $(existing_row).find("input[id*='fld_ARTICLECODE']").val();
            var existing_siteprice = $(existing_row).find("input[id*='fld_SITEPRICE']").val();
            var existing_rowno = $(existing_row).find("input[id*='fld_ROWNO']").val();
            for (var j = 1; j < tabCtl.rows.length; j++) {
                if (i != j) {
                    var existing_j_row = tabCtl.rows[j];
                    var existing_j_articlecode = $(existing_j_row).find("input[id*='fld_ARTICLECODE']").val();
                    var existing_j_siteprice = $(existing_j_row).find("input[id*='fld_SITEPRICE']").val();
                    var existing_j_rowno = $(existing_j_row).find("input[id*='fld_ROWNO']").val();
                    if (existing_articlecode == existing_j_articlecode && existing_siteprice == existing_j_siteprice) {
                        m++;
                    }
                    if (existing_rowno == existing_j_rowno) {
                        no++;
                    }
                }
                else {
                    num++;
                }
            }
        }

        if (m > 0 || num != (tabCtl.rows.length - 1) || no > 0) {
            return false;
        }
        else {
            return true;
        }
    }
    else {
        var m = 0, num = 0, no = 0;

        for (var a = 1; a < tabCtl.rows.length; a++) {
            var existings_row = tabCtl.rows[a];
            var existings_articlename = $(existings_row).find("input[id*='fld_ARTICLENAME']").val();
            var existings_orderunit = $(existings_row).find("input[id*='fld_ORDERUNITVALUE']").val();
            var existings_unit = $(existings_row).find("input[id*='fld_UNITVALUE']").val();
            var existings_consumptionunit = $(existings_row).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val();
            var existings_conversion = $(exisings_row).find("input[id*='fld_CONVERSION']").val();
            var existings_stock = $(existings_row).find("input[id*='fld_STOCK']").val();
            var existings_subsubfamilycode = $(existings_row).find("input[id*='fld_SUBSUBFAMILYCODE']").val();
            var existings_orderquantity = $(existings_row).find("input[id*='fld_ORDERQUANTITY']").val();
            var existings_rowno = $(existings_row).find("input[id*='fld_ROWNO']").val();
            for (var b = 1; b < tabCtl.rows.length; b++) {
                if (a != b) {
                    var exist_rows = tabCtl.rows[b];
                    var exist_articlename = $(exist_rows).find("input[id*='fld_ARTICLENAME']").val();
                    var exist_orderunit = $(exist_rows).find("input[id*='fld_ORDERUNITVALUE']").val();
                    var exist_unit = $(exist_rows).find("input[id*='fld_UNITVALUE']").val();
                    var exist_consumptionunit = $(exist_rows).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val();
                    var exist_conversion = $(exist_rows).find("input[id*='fld_CONVERSION']").val();
                    var exist_stock = $(exist_rows).find("input[id*='fld_STOCK']").val();
                    var exist_subsubfamilycode = $(exist_rows).find("input[id*='fld_SUBSUBFAMILYCODE']").val();
                    var exist_orderquantity = $(exist_rows).find("input[id*='fld_ORDERQUANTITY']").val();
                    var exist_rowno = $(exist_rows).find("input[id*='fld_ROWNO']").val();
                    if (existings_articlename == exist_articlename && existings_orderunit == exist_orderunit && existings_unit == exist_unit && existings_consumptionunit == exist_consumptionunit && existings_conversion == exist_conversion && existings_stock == exist_stock && existings_subsubfamilycode == exist_subsubfamilycode) {
                        m++;
                    }
                    if (existings_rowno == exist_rowno) {
                        no++;
                    }
                }
                else {
                    num++;
                }
            }
        }

        if (m > 0 || num != (tabCtl.rows.length - 1) || no > 0) {
            return false;
        }
        else {
            return true;
        }
    }

}

//Add By Sylvia At 2020-08-02
//是否显示备注
//是：备注必填
function checkShowRemark() {
    debugger
    var ShowRemark;
    var vRbtid = document.getElementById("div_field_SHOWREMARK");
    var vRbtidList = vRbtid.getElementsByTagName("input");
    for (var i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) {
            var value = vRbtidList[i].value;
            ShowRemark = value;
        }
    }
    if (ShowRemark == "1") {
        var appremark = $("#fld_APPREMARK").val();
        if (appremark.trim() == "") {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}

//Add By Sylvia At 2020-08-03
//网上采购
function changeOnlineProcurement() {
    debugger
    var OnlineProcurement;
    var vRbtid = document.getElementById("div_field_ONLINEORSUPERMARKET");
    var vRbtidList = vRbtid.getElementsByTagName("input");
    for (var i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) {
            var value = vRbtidList[i].value;
            OnlineProcurement = value;
        }
    }
    //if (OnlineProcurement == "1") {
    //    alert('网上采购提示信息窗口，附件变更为必填项，无附件无法进行提交');
    //}
}
function changeIsPrePaid() {
    var IsPrePaid;
    var vRbtid = document.getElementById("div_field_IsPrePaid");
    var vRbtidList = vRbtid.getElementsByTagName("input");
    for (var i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) {
            var value = vRbtidList[i].value;
            IsPrePaid = value;
        }
    }
}

//Add By Sylvia At 2020-08-03
//客户代采购给一级加签审批人赋值
function AssignSignedApprover(init) {
    debugger
    var fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
    var fld_USER_SIGNEDAPPROVER = $("#fld_USER_SIGNEDAPPROVER").val();
    var userinfo = $("#hdCustomerProcurementSignedApprover").val();
    if (userinfo != ";") {
        var loginName = userinfo.split(';')[0];
        var cnname = userinfo.split(';')[1];

        if (!init) {
            if (fld_USER_SIGNEDAPPROVERNAME.search("" + cnname + "") != -1 && fld_USER_SIGNEDAPPROVER.search("" + loginName + "")) {
                $("#fld_USER_SIGNEDAPPROVER2NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER3NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER2").val("");
                $("#fld_USER_SIGNEDAPPROVER3").val("");
            }
            else {
                $("#fld_USER_SIGNEDAPPROVERNAME").val("");
                $("#fld_USER_SIGNEDAPPROVER2NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER3NAME").val("");
                $("#fld_USER_SIGNEDAPPROVER").val("");
                $("#fld_USER_SIGNEDAPPROVER2").val("");
                $("#fld_USER_SIGNEDAPPROVER3").val("");
            }
        }

        $("#fld_USER_SIGNEDAPPROVER").val("USER:org=CustomOC,user=CustomOC/" + loginName);
        var Language = judgeLanguage();
        if (Language == 'en-US') {
            $("#fld_USER_SIGNEDAPPROVERNAME").val(loginName);
        }
        else {
            $("#fld_USER_SIGNEDAPPROVERNAME").val(cnname);
        }

        $(".USER_SignedApprover").attr("style", "pointer-events:none;");
        $(".USER_SignedApprover").next().attr("style", "pointer-events:none;");
    }
    else {
        alert("当前申请目的为客户代采购，但未配置一级加签审批人，请联系管理员\\nThe current application purpose is to purchase on behalf of the customer, but there is no first-level signatory approver. Please contact the administrator");
    }
}


function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window)
        return true;
    else
        return false;
}
function updateProgress(fileName, progress) {
    const progressBar = document.querySelector(`[data-filename="${fileName}"] .progress`);
    if (progressBar) {
        progressBar.style.width = progress + '%';
    }
}

function showInvoiceInfo() {

    if ($("#fld_SUPPLIERTYPE").val() == "5") {
        $(config.divs).removeClass("hidden");
        // 添加必填验证
        //$(config.inputs).addClass("validate[required]");
        // 显示表格列（遍历所有列类名，同时处理表头和表体）
        config.tableCols.forEach(function (colClass) {
            $(`#tb_CPRFOOD_ITEMS thead tr td.${colClass}, #tb_CPRFOOD_ITEMS tbody tr td.${colClass}`).show();
        });
    }
    else {
        // 隐藏div
        $(config.divs).addClass("hidden");
        // 移除必填验证
        //$(config.inputs).removeClass("validate[required]");

        // 隐藏表格列（遍历所有列类名，同时处理表头和表体）
        config.tableCols.forEach(function (colClass) {
            $(`#tb_CPRFOOD_ITEMS thead tr td.${colClass}, #tb_CPRFOOD_ITEMS tbody tr td.${colClass}`).hide();
        });
    }

}




