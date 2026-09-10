///Custom method write here
var suppliertype;
var suppliertypetxt;
// 提取重复选择器和配置，方便维护
var config = {
    // 需要显示/隐藏的div选择器
    divs: "#div_upload_Inv",
    // 需要添加/移除验证的输入框选择器
    inputs: "#fld_INVOICETYPE,#fld_INVOICENUMBER,#fld_BUYERNAME,#fld_BUYERTAXID",
    // 表格中需要显示/隐藏的列类名（含表头和表体）
    tableCols: ["td_INVOICETYPE", "td_INVOICENUMBER", "td_BUYERNAME", "td_BUYERTAXID", "th_ch", "td_INVOICEPATH"]
};

//多语言提示文本
const langText = {
    zh: {
        rowLimit: "提示：添加的物料行数请不要超过90行!",
        supplierTypeFirst: "请先选择采购类型",
        supplierEmpty: "供应商信息不能为空",
        duplicateMaterial: "当前存在相同物料或存在相同行号，无法提交，请先保存草稿，并联系管理员",
        remarkRequire: "请填写备注",
        subSubFamilyEmpty: "物品子子类别不能为空",
        materialEmpty: "物料信息不能为空",
        existMaterial: "已存在当前物料，自动为您修改数量！"
    },
    en: {
        rowLimit: "Item quantity should be less than 90 lines.",
        supplierTypeFirst: "Please select the type of purchase first",
        supplierEmpty: "Supplier information cannot be empty",
        duplicateMaterial: "Currently there is the same material or the same peer number. It cannot be submitted. Please save the draft first and contact the administrator",
        remarkRequire: "Please fill in the remarks",
        subSubFamilyEmpty: "Item Sub Subcategory cannot be empty",
        materialEmpty: "Material information cannot be empty",
        existMaterial: "Existing Article, automatically modify the quantity for you"
    }
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

    $("#div_field_FIXEDASSETS").change(changeFixedAssets);
    $("#div_field_IsPrePaid").change(changeIsPrePaid);

    const $deliveryDate = $("#fld_DELIVERYDATE");
    if ($deliveryDate.val() != '') {
        $deliveryDate.val($deliveryDate.val().replace(/\//g, '-'));
        const nextDay = new Date();
        nextDay.setDate(nextDay.getDate() + 1);
        const str = formatDate(nextDay) + " 18:00:00";
        $("#hdDatetime").val(str);
    }

    const Type = (getUrlParam('Type') || "").toUpperCase();
    if (Type == "NEWREQUEST") {
        changeFixedAssets();
        changeApplyPurpose();
    }
    if (Type == "MYREQUEST") {
        $("#fld_DELIVERYDATE").next().next().text($("#fld_DELIVERYDATE").val());
    }
    if (Type == "MYTASK") {
        ProcessingQuantity();
        changeApplyPurpose(true);
        changeSupplierType();
        $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
        $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());
        const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
        const existrow = tabCtl.rows[tabCtl.rows.length - 1];
        if (tabCtl.rows.length == 2 && $(existrow).find("input[id*='fld_APPLYREASON']").val() == "") {
            blockSupplierType();
        } else {
            hiddenSupplierType();
        }
    }
    if (Type == "DRAFT") {
        hiddenSupplierType();
    }

    judgeLanguage();
    isShow();
    showInvoiceInfo();

    //金额千分位格式化
    const $amount = $("#fld_AMOUNT");
    $amount.val(thousands(numberval($amount.val())));
    $amount.next("span").text($amount.val());

    initFileUploadEvent();
});

//初始化文件上传控件事件
function initFileUploadEvent() {
    const ALLOWED_FORMATS = ['.pdf', '.ofd', '.xml'];
    const MAX_SIZE = 4 * 1024 * 1024;

    const $fileUpload = $('[id$=fileUpload]');
    const $customSelectBtn = $('#customSelectBtn');
    const $fileNamesDisplay = $('#fileNamesDisplay');
    const $uploadButton = $('[id$=uploadButton]');
    const $errorLabel = $('#errorLabel');

    $customSelectBtn.on('click', function () {
        $fileUpload.click();
    });

    $fileUpload.on('change', function () {
        const files = this.files;
        if (files.length === 0) {
            resetFileDisplay();
            return;
        }
        const validateResult = validateFiles(files);
        if (!validateResult.valid) {
            showError(validateResult.msg);
            resetFileInput();
            return;
        }
        updateFileDisplay(files);
        hideError();
    });

    $uploadButton.on('click', function (e) {
        const files = $fileUpload[0].files;
        if (files.length === 0) {
            showError('请先选择文件');
            e.preventDefault();
            return;
        }
        const validateResult = validateFiles(files);
        if (!validateResult.valid) {
            showError(validateResult.msg);
            e.preventDefault();
        }
    });

    function validateFiles(files) {
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const fileExt = getFileExtension(file.name).toLowerCase();
            if (!ALLOWED_FORMATS.includes(fileExt)) {
                return { valid: false, msg: `文件 "${file.name}" 格式不支持！仅允许：${ALLOWED_FORMATS.join('、')}` };
            }
            if (file.size > MAX_SIZE) {
                return { valid: false, msg: `文件 "${file.name}" 超过大小限制（最大4MB）` };
            }
        }
        return { valid: true, msg: '' };
    }

    function getFileExtension(fileName) {
        const lastDotIndex = fileName.lastIndexOf('.');
        return lastDotIndex === -1 ? '' : fileName.slice(lastDotIndex);
    }

    function updateFileDisplay(files) {
        $fileNamesDisplay.text(files.length === 1 ? files[0].name : `已选择 ${files.length} 个文件`);
    }

    function resetFileInput() {
        $fileUpload.val('');
    }

    function resetFileDisplay() {
        $fileNamesDisplay.text('未选择任何文件');
        hideError();
    }

    function showError(msg) {
        $errorLabel.text(msg).show();
    }

    function hideError() {
        $errorLabel.text('').hide();
    }
}

//校验数量
function isOrderQuantity() {
    const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
    const reg = /^([1-9]\d*(\.\d{1,2})?|([0](\.([0][1-9]|[1-9]\d{0,1}))))$/;
    let arrData;

    $.ajax({
        type: "post",
        datatype: "json",
        contentType: "application/json",
        async: false,
        url: 'NewRequest.aspx/BindIsOneTime',
        success: function (data) {
            if (data.d != "") {
                arrData = JSON.parse(data.d);
            }
        }
    });

    for (let i = 1; i < tabCtl.rows.length; i++) {
        const existrow = tabCtl.rows[i];
        const orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();
        const InitOrderLimt = $(existrow).find("input[id*='InitOrderLimt']").val();
        const articleName = $(existrow).find("input[id*='fld_ARTICLENAME']").val();
        const fld_ORDERUNIT = $(existrow).find("input[id*='fld_ORDERUNIT']").val();

        const result = checkPositiveIntegerQuantity(orderquantity, existrow, fld_ORDERUNIT);
        if (!result) return false;

        if (arrData && arrData.length > 0) {
            const articleCode = $(existrow).find("input[id*='fld_ARTICLECODE']").val();
            const matchItem = arrData.find(x => x.ArticleCode == articleCode);
            if (matchItem && InitOrderLimt != null && InitOrderLimt != undefined && InitOrderLimt != "") {
                if (!reg.test(orderquantity)) {
                    alert("请输入大于0的整数或者保留一到两位小数！");
                    return false;
                }
                const limitVal = numberval(InitOrderLimt);
                const qtyVal = numberval(orderquantity);
                if ((limitVal - limitVal * 0.05) > qtyVal || (limitVal * 1.05) < qtyVal) {
                    alert(`物品名称为${articleName}的数量不能超过初始值${InitOrderLimt}的正负百分之五`);
                    return false;
                }
            }
        }
    }
    return true;
}

function beforeSubmit() {
    const Language = judgeLanguage();
    const txt = langText[Language === 'en-US' ? 'en' : 'zh'];

    $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
    $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());

    const fld_suppliercode = $("#fld_SUPPLIERCODE").val();
    const fld_suppliername = $("#fld_SUPPLIERNAME").val();
    const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
    const existrow = tabCtl.rows[tabCtl.rows.length - 1];

    if (!isOrderQuantity()) return false;
    if (!checkPositiveInteger()) return false;

    //物料行数最大90
    if ((tabCtl.rows.length - 1) > 90) {
        alert(txt.rowLimit);
        return false;
    }

    if (tabCtl.rows.length == 2 && $(existrow).find("input[id*='fld_APPLYREASON']").val() == "") {
        $('#btnAddCPRItems').validationEngine('showPrompt', txt.materialEmpty, 'error');
        return false;
    }
    if (fld_suppliercode == "" || fld_suppliername == "") {
        alert(txt.supplierEmpty);
        return false;
    }
    if (!checkArticleCode()) {
        alert(txt.duplicateMaterial);
        return false;
    }
    if (checkShowRemark()) {
        alert(txt.remarkRequire);
        return false;
    }

    let m = 0;
    let n = 0;
    let actual_amount = 0;
    for (let i = 1; i < tabCtl.rows.length; i++) {
        const existrow_ = tabCtl.rows[i];
        const subsubfamilycode = $(existrow_).find("input[id*='fld_SUBSUBFAMILYCODE']").val();
        const subsubfamilyname = $(existrow_).find("input[id*='fld_SUBSUBFAMILYNAME']").val();
        const siteprice = numberval($(existrow_).find("input[id*='fld_SITEPRICE']").val());
        const orderquantity = numberval($(existrow_).find("input[id*='fld_ORDERQUANTITY']").val());
        const subtotalamount = numberval($(existrow_).find("input[id*='fld_SUBTOTALAMOUNT']").val());
        const actualamount = siteprice * orderquantity;

        if (subtotalamount != actualamount) {
            n++;
        }
        actual_amount += actualamount;

        if (subsubfamilycode == "" || subsubfamilycode == null || subsubfamilycode == undefined || subsubfamilyname == "" || subsubfamilyname == "请选择") {
            m++;
            $('#btnAddCPRItems').validationEngine('showPrompt', txt.subSubFamilyEmpty, 'error');
        }
    }

    if (n > 0) {
        const amount = calculatenumber(actual_amount, 0, 1);
        $('#fld_AMOUNT').val(thousands(amount));
    }
    return m <= 0;
}

function checkPositiveInteger() {
    const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
    for (let i = 1; i < tabCtl.rows.length; i++) {
        const existrow = tabCtl.rows[i];
        const orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();
        const fld_ORDERUNIT = $(existrow).find("input[id*='fld_ORDERUNIT']").val();
        checkPositiveIntegerQuantity(orderquantity, existrow, fld_ORDERUNIT);
    }
    return true;
}

function futureDateTime(field, rules, i, options) {
    const InputTime = new Date($("#fld_DELIVERYDATE").val());
    const datetime = new Date($("#hdDatetime").val());
    if (InputTime < datetime) {
        const msg = "要求送货日期必须为明天下午6点以后，默认时间为早上6点30分<br/>Required delivery date must be after 6pm tomorrow, default time is 6:30am";
        options.allrules.validate2fields.alertText = msg;
        return msg;
    }
}

function futureFinishTime(field, rules, i, options) {
    const InputTime = new Date($("#fld_ServiceEstimatedFinishTime").val());
    const datetime = new Date($("#hdFinshDate").val());
    if (InputTime < datetime) {
        const msg = "服务预计完成时间必须大于等于当天<br/>The estimated service completion time must be greater than the current day";
        options.allrules.validate2fields.alertText = msg;
        return msg;
    }
}

//日期格式化 yyyy/mm/dd
function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}/${month}/${day}`;
}

function getFormatDate() {
    const nowDate = new Date();
    let year = nowDate.getFullYear();
    let month = String(nowDate.getMonth() + 1).padStart(2, '0');
    const oldMonth = month;
    let date = nowDate.getDate();

    if (month == "12") {
        year = year + 1;
        month = "01";
    }
    const lastday = getLastMonthDay(year, month);
    if (date == lastday) {
        if (oldMonth != "12") {
            month = String(nowDate.getMonth() + 2).padStart(2, '0');
        }
        date = 1;
    } else {
        date = date + 1;
    }
    date = String(date).padStart(2, '0');
    return `${year}-${month}-${date}`;
}

function getLastMonthDay(year, month) {
    return new Date(year, month, 0).getDate();
}

//添加行
function addPRItemsRow(tbItems) {
    const Language = judgeLanguage();
    const txt = langText[Language === 'en-US' ? 'en' : 'zh'];
    const selectedcategory = $('#fld_ASSETTYPE').val();
    const suppliertypeVal = $('#fld_SUPPLIERTYPE').val();
    const sitecode = $('#fld_SITECODE').val();
    const suppliercode = $('#fld_SUPPLIERCODE').val();
    const suppliername = $('#fld_SUPPLIERNAME').val();
    const familycode = $('#fld_CPRFAMILYCODE').val();

    if ($("#" + tbItems + " tr:not(:first)").length >= 90) {
        alert(txt.rowLimit);
        return false;
    }
    if (suppliertypeVal == "" || suppliertypeVal == undefined) {
        alert(txt.supplierTypeFirst);
        return false;
    }

    const username = getUrlParam('UserName');
    let url, height, buttons;

    if (suppliertypeVal == 9) {
        url = `ArticleList.aspx?suppliercode=${suppliercode}&sitecode=${sitecode}&username=${username}&familyCode=${familycode}`;
        url = encodeURI(url);
        height = "500px";
        if (Language == 'en-US') {
            buttons = [{
                label: 'Save',
                cssClass: 'btn btn-default btn-md',
                action: function (dialog) {
                    const val = $(dialog.getModalBody().find('#frmWindowArticle'))[0].contentWindow.returnValue1();
                    if (val) {
                        AddCprArticle(tbItems, val);
                        dialog.close();
                    }
                }
            }, { label: 'Cancel', cssClass: 'btn btn-md', action: d => d.close() }];
            BootstrapDialog.show({ title: 'Add Article', animate: false, closable: false, size: BootstrapDialog.SIZE_WIDE, message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'), buttons: buttons });
        } else {
            buttons = [{
                label: '保存',
                cssClass: 'btn btn-default btn-md',
                action: function (dialog) {
                    const val = $(dialog.getModalBody().find('#frmWindowArticle'))[0].contentWindow.returnValue1();
                    if (val) {
                        AddCprArticle(tbItems, val);
                        dialog.close();
                    }
                }
            }, { label: '取消', cssClass: 'btn btn-md', action: d => d.close() }];
            BootstrapDialog.show({ title: '添加物料清单', animate: false, closable: false, size: BootstrapDialog.SIZE_WIDE, message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'), buttons: buttons });
        }
    } else {
        url = `AddPRItemPage.aspx?materialcategory=${selectedcategory}&suppliertype=${suppliertypeVal}&sitecode=${sitecode}&suppliercode=${suppliercode}&familycode=${familycode}&suppliername=${suppliername}&username=${username}`;
        url = encodeURI(url);
        height = "600px";
        if (Language == 'en-US') {
            buttons = [
                {
                    label: 'Save',
                    cssClass: 'btn btn-default btn-md',
                    action: function (dialog) {
                        const val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue1();
                        if (val) { addCPRITEMRow(tbItems, val[0]); dialog.close(); }
                    }
                },
                {
                    label: 'Save and continue Adding',
                    cssClass: 'btn btn-default btn-md',
                    action: function (dialog) {
                        const val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue2();
                        if (val) addCPRITEMRow(tbItems, val[0]);
                    }
                },
                { label: 'Cancel', cssClass: 'btn btn-md', action: d => d.close() }
            ];
            BootstrapDialog.show({ title: 'Add Article', animate: false, closable: false, size: BootstrapDialog.SIZE_NORMAL, message: $('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'), buttons: buttons });
        } else {
            buttons = [
                {
                    label: '保存',
                    cssClass: 'btn btn-default btn-md',
                    action: function (dialog) {
                        const val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue1();
                        if (val) { addCPRITEMRow(tbItems, val[0]); dialog.close(); }
                    }
                },
                {
                    label: '保存并继续添加',
                    cssClass: 'btn btn-default btn-md',
                    action: function (dialog) {
                        const val = $(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.returnValue2();
                        if (val) addCPRITEMRow(tbItems, val[0]);
                    }
                },
                { label: '取消', cssClass: 'btn btn-md', action: d => d.close() }
            ];
            BootstrapDialog.show({ title: '添加物料', animate: false, closable: false, size: BootstrapDialog.SIZE_NORMAL, message: $('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'), buttons: buttons });
        }
    }
}

function AddCprArticle(tabId, arrData) {
    let amount = numberval($.trim($('#fld_AMOUNT').val()) || "0");
    const tabCtl = document.getElementById(tabId);
    const FirstRow = tabCtl.rows[tabCtl.rows.length - 1];

    for (let i = 0; i < arrData.length; i++) {
        const dataItem = arrData[i];
        if (tabCtl.rows.length >= 2 && $(FirstRow).find("input[id*='fld_APPLYREASON']").val() != "") {
            $("#fld_SUPPLIERCODE").val(dataItem.suppliercode);
            $("#fld_SUPPLIERNAME").val(dataItem.supplier);
            const modelTr = tabCtl.rows[tabCtl.rows.length - 1];
            const newRow = modelTr.cloneNode(true);
            const rowIndex = tabCtl.rows.length - 1;
            changeRowID(newRow, rowIndex);
            clearRow(newRow);
            fillRowData($(newRow), dataItem);

            const subtotalamount = numberval(dataItem.siteprice) * numberval(dataItem.orderquantity);
            amount = calculatenumber(subtotalamount, amount, 1);
            $('#fld_AMOUNT').val(thousands(amount));
            $(tabCtl).find("tbody")[0].appendChild(newRow);
            $("#tb_MCPR_SERVICE_ITEMS_rowCount").val(rowIndex + 1);
            bindIeDatePicker(newRow);
        } else {
            const existrow = tabCtl.rows[tabCtl.rows.length - 1];
            $("#fld_SUPPLIERCODE").val(dataItem.suppliercode);
            $("#fld_SUPPLIERNAME").val(dataItem.supplier);
            fillRowData($(existrow), dataItem);
            const subtotalamount = numberval(dataItem.siteprice) * numberval(dataItem.orderquantity);
            amount = calculatenumber(subtotalamount, amount, 1);
            $('#fld_AMOUNT').val(thousands(amount));
        }
    }
}

//填充行公共逻辑
function fillRowData($row, data) {
    $row.find("input[id*='fld_APPLYREASON']").val("单外报价单产品");
    $row.find("input[id*='fld_FAMILYCODE']").val(data.familycode);
    $('#fld_CPRFAMILYCODE').val(data.familycode);
    $row.find("input[id*='fld_FAMILYNAME']").val(data.familyname);
    $row.find("input[id*='fld_SUBFAMILYCODE']").val(data.subfamilycode);
    $row.find("input[id*='fld_SUBFAMILYNAME']").val(data.subfamilyname);
    $row.find("input[id*='fld_SUBSUBFAMILYCODE']").val(data.subsubfamilycode);
    $row.find("input[id*='fld_SUBSUBFAMILYNAME']").val(data.subsubfamilyname);
    $row.find("input[id*='fld_SUBSUBFAMILYCE']").val(data.subsubfamilyce);
    $row.find("input[id*='InvoiceType']").val(data.InvoiceType);
    $row.find("input[id*='fld_TAXCODE']").val(data.taxCode);
    $row.find("input[id*='fld_TAXRATE']").val(data.taxRate);
    $row.find("input[id*='fld_ARTICLEID']").val(data.articleid);
    $row.find("input[id*='InitOrderLimt']").val(data.InitOrderlimt);

    if (data.article != "" && data.article != "请选择") {
        $row.find("input[id*='fld_ARTICLENAME']").val(data.article);
        $row.find("input[id*='fld_ARTICLECODE']").val(data.articlecode);
    } else {
        $row.find("input[id*='fld_ARTICLENAME']").val(data.otherarticlename);
    }

    $row.find("input[id*='fld_ORDERUNIT']").val(data.orderunit);
    $row.find("input[id*='fld_ORDERUNITVALUE']").val(data.orderunittext);
    $row.find("input[id*='fld_UNIT']").val(data.unittext);
    $row.find("input[id*='fld_UNITVALUE']").val(data.unit);
    $row.find("input[id*='fld_CONSUMPTIONUNIT']").val(data.consumptionunittext);
    $row.find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(data.consumptionunit);
    $row.find("input[id*='fld_CONVERSION']").val(data.conversion);
    $row.find("input[id*='fld_STOCK']").val(data.stock);
    $row.find("input[id*='fld_NETVOMULE']").val(data.netvomule);
    $row.find("input[id*='fld_NETVOMULEUNIT']").val(data.netvomuleunit);
    $row.find("input[id*='fld_GROSSWEIGHT']").val(data.grossweight);
    $row.find("input[id*='fld_GROSSWEIGHTUNIT']").val(data.grossweightunit);
    $row.find("input[id*='fld_SITEPRICE']").val(data.siteprice);
    $row.find("input[id*='fld_NETNETPRICE']").val(data.netnetprice);

    const qty = formatQuantity(data.orderquantity);
    $row.find("input[id*='fld_ORDERQUANTITY']").val(qty);
    const subtotalamount = numberval(data.siteprice) * numberval(data.orderquantity);
    $row.find("input[id*='fld_SUBTOTALAMOUNT']").val(subtotalamount);
}

//数量格式化，去除末尾.0/.00
function formatQuantity(val) {
    if (!val) return val;
    const str = String(val);
    if (str.split('.')[1] === "00" || str.split('.')[1] === "0") {
        return parseInt(val);
    }
    return val;
}

//IE下绑定日期控件
function bindIeDatePicker(rowDom) {
    if (isIE()) {
        $('input[data-type="date"]', rowDom).daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });
        $('input[data-type="datetime"]', rowDom).daterangepicker({ "singleDatePicker": true, "timePicker": true, "timePicker24Hour": true, format: "YYYY/MM/DD  HH:mm" });
    }
}

var amount;
function addCPRITEMRow(tabId, res) {
    amount = numberval($.trim($('#fld_AMOUNT').val()) || "0");
    try {
        const tabCtl = document.getElementById(tabId);
        const existrow = tabCtl.rows[tabCtl.rows.length - 1];
        const Language = judgeLanguage();
        const txt = langText[Language === 'en-US' ? 'en' : 'zh'];

        if (tabCtl.rows.length == 2 && $(existrow).find("input[id*='fld_APPLYREASON']").val() == "") {
            $('#fld_SUPPLIERCODE').val(res.suppliercode);
            $('#fld_SUPPLIERNAME').val(res.supplier);
            fillRowData($(existrow), res);
        } else {
            if (!checkCPRItems(tabId, res)) {
                const modelTr = tabCtl.rows[tabCtl.rows.length - 1];
                const newRow = modelTr.cloneNode(true);
                const rowIndex = tabCtl.rows.length - 1;
                changeRowID(newRow, rowIndex);
                clearRow(newRow);
                fillRowData($(newRow), res);
                $(newRow).find("a[class*='invoice-path-link']").attr("href", "").text("");
                amount = calculatenumber(res.subtotalamount, amount, 1);
                $('#fld_AMOUNT').val(thousands(amount));
                $(tabCtl).find("tbody")[0].appendChild(newRow);
                $("#" + tabId + "_rowCount").val(rowIndex + 1);
                bindIeDatePicker(newRow);

                const ubtn = $(newRow).find(".uploadifive-button")[0];
                if (ubtn) {
                    $(ubtn).attr("id", $(ubtn).attr("id").replace("uploadifive-", ""));
                    $(ubtn).attr("class", $(ubtn).attr("class").replace("uploadifive-button", "attachment"));
                    $(ubtn).empty();
                }
                attachUpload($(newRow).find(".attachment")[0]);
                $(newRow).removeClass("hidden");
                reActiveCss();
            } else {
                const suppliertypeVal = $("#fld_SUPPLIERTYPE").val();
                if (suppliertypeVal == "9") {
                    amount = calculatenumber(res.subtotalamount, amount, 1);
                    $('#fld_AMOUNT').val(thousands(amount));
                } else {
                    SumAmount();
                }
                alert(txt.existMaterial);
            }
        }
        hiddenSupplierType();
    } catch (e) {
    }
}

function calculatenumber(subtotalamount, amount, type) {
    const subVal = numberval(subtotalamount);
    const amtVal = numberval(amount);
    return type == 1
        ? Math.round((subVal + amtVal) * 100) / 100
        : Math.round((amtVal - subVal) * 100) / 100;
}

//删除行
function deleteCPRRow(tabId, ele) {
    const tabCtl = document.getElementById(tabId);
    const tabRows = tabCtl.rows;
    const rowIndex = $(ele).parent().parent()[0].rowIndex;
    const currentrow = tabCtl.rows[rowIndex];
    const subtotalamount = $(currentrow).find("input[id*='fld_SUBTOTALAMOUNT']").val();

    amount = numberval($.trim($('#fld_AMOUNT').val()) || "0");
    amount = calculatenumber(subtotalamount, amount, 2);
    $('#fld_AMOUNT').val(thousands(amount));

    if (rowIndex == 1 && tabRows.length == 2) {
        clearRow($(ele).parent().parent()[0]);
        $('#fld_SUPPLIERCODE').val("");
        $('#fld_SUPPLIERNAME').val("");
        $('#fld_CPRFAMILYCODE').val("");
        $('#fld_AMOUNT').val(0);
        blockSupplierType();
    } else {
        tabCtl.deleteRow(rowIndex);
    }
    $("#" + tabId + "_rowCount").val(tabRows.length - 1);
    //重排序号
    for (let i = 1; i < tabRows.length; i++) {
        changeRowID(tabRows[i], i - 1);
        $(tabRows[i]).find(".index").html(i).val(i);
    }
}

//判断语言
function judgeLanguage() {
    const btnAddText = $("#btnAddCPRItems").text().trim().replace(/[ ]/g, "");
    const isEn = /^[a-zA-Z]+$/.test(btnAddText);
    const lang = isEn ? 'en-US' : 'zh-CN';
    $("#hdLanguage").val(lang);
    return lang;
}

//获取url参数，修复unescape
function getUrlParam(name) {
    const reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    const r = window.location.search.substr(1).match(reg);
    return r ? decodeURIComponent(r[2]) : null;
}

//金额重算
function SumAmount() {
    amount = 0;
    const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
    for (let i = 1; i < tabCtl.rows.length; i++) {
        const existrow = tabCtl.rows[i];
        const siteprice = numberval($(existrow).find("input[id*='fld_SITEPRICE']").val());
        const orderquantity = numberval($(existrow).find("input[id*='fld_ORDERQUANTITY']").val());
        const subTotal = siteprice * orderquantity;
        $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val(subTotal);
        amount = calculatenumber(subTotal, amount, 1);
    }
    $("#fld_AMOUNT").val(thousands(amount));
}

function ProcessingQuantity() {
    const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
    for (let i = 1; i < tabCtl.rows.length; i++) {
        const existrow = tabCtl.rows[i];
        const orderquantity = $(existrow).find("input[id*='fld_ORDERQUANTITY']").val();
        const qty = formatQuantity(orderquantity);
        $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(qty);
    }
}

//数量校验
function checkPositiveIntegerQuantity(orderquantity, existrow, netvomuleunit) {
    const unitList = ["KG", "Hour", "Meter", "Square meter", "小时", "米", "平方", "千克", "克", "G", "立方", "M", "M2", "M3", "平方米"];
    if (unitList.includes(netvomuleunit)) {
        if (orderquantity != '') {
            const qty = formatQuantity(orderquantity);
            const reg = /^([1-9]\d*(\.\d{0,2})?|([0](\.([0][1-9]|[1-9]\d{0,2}))))$/;
            if (reg.test(qty)) {
                return true;
            } else {
                alert("请输入大于0的整数或者保留一到两位小数\nPlease enter an integer greater than 0 or keep one or two decimal places");
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val('');
                return false;
            }
        }
    } else {
        if (orderquantity != '') {
            const qty = formatQuantity(orderquantity);
            const reg = /^[1-9]+\d*$/;
            if (reg.test(qty)) {
                return true;
            } else {
                alert("请输入大于0的整数\nPlease enter an integer greater than 0");
                $(existrow).find("input[id*='fld_ORDERQUANTITY']").val('');
                return false;
            }
        }
    }
    return true;
}

//重复物料判断
function checkCPRItems(tabId, res) {
    const suppliertypeVal = $("#fld_SUPPLIERTYPE").val();
    const tabCtl = document.getElementById(tabId);
    let matchExist = false;

    if (suppliertypeVal == "9") {
        const articlecode = res.articlecode;
        const siteprice = res.siteprice;
        for (let i = 1; i < tabCtl.rows.length; i++) {
            const existing_row = tabCtl.rows[i];
            const existing_articlecode = $(existing_row).find("input[id*='fld_ARTICLECODE']").val();
            const existing_siteprice = $(existing_row).find("input[id*='fld_SITEPRICE']").val();
            const existing_orderquantity = numberval($(existing_row).find("input[id*='fld_ORDERQUANTITY']").val());
            if (articlecode == existing_articlecode && siteprice == existing_siteprice) {
                $(existing_row).find("input[id*='fld_ORDERQUANTITY']").val(numberval(res.orderquantity) + existing_orderquantity);
                matchExist = true;
            }
        }
    } else {
        const articlename = res.otherarticlename || res.article;
        const checkObj = {
            articlename,
            orderunit: res.orderunit,
            unit: res.unit,
            consumptionunit: res.consumptionunit,
            conversion: res.conversion,
            stock: res.stock,
            subsubfamilycode: res.subsubfamilycode
        };
        for (let j = 1; j < tabCtl.rows.length; j++) {
            const exist_rows = tabCtl.rows[j];
            const rowObj = {
                articlename: $(exist_rows).find("input[id*='fld_ARTICLENAME']").val(),
                orderunit: $(exist_rows).find("input[id*='fld_ORDERUNITVALUE']").val(),
                unit: $(exist_rows).find("input[id*='fld_UNITVALUE']").val(),
                consumptionunit: $(exist_rows).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(),
                conversion: $(exist_rows).find("input[id*='fld_CONVERSION']").val(),
                stock: $(exist_rows).find("input[id*='fld_STOCK']").val(),
                subsubfamilycode: $(exist_rows).find("input[id*='fld_SUBSUBFAMILYCODE']").val()
            };
            if (JSON.stringify(checkObj) === JSON.stringify(rowObj)) {
                const existQty = numberval($(exist_rows).find("input[id*='fld_ORDERQUANTITY']").val());
                $(exist_rows).find("input[id*='fld_ORDERQUANTITY']").val(numberval(res.orderquantity) + existQty);
                matchExist = true;
            }
        }
    }
    return matchExist;
}

function changeFixedAssets() {
    let FixedAsets;
    const vRbtid = document.getElementById("div_field_FIXEDASSETS");
    const vRbtidList = vRbtid.getElementsByTagName("input");
    for (let i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) FixedAsets = vRbtidList[i].value;
    }
    if (FixedAsets == "01") {
        const userinfo = $("#hdFixedAssetsSignedApprover").val();
        if (userinfo != ";") {
            const loginName = userinfo.split(';')[0];
            const cnname = userinfo.split(';')[1];
            const fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
            const fld_USER_SIGNEDAPPROVER = $("#fld_USER_SIGNEDAPPROVER").val();
            if (fld_USER_SIGNEDAPPROVERNAME.search(cnname) == -1 || fld_USER_SIGNEDAPPROVER.search(loginName) == -1) {
                $("#fld_USER_SIGNEDAPPROVERNAME,#fld_USER_SIGNEDAPPROVER,#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2,#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val("");
            } else {
                $("#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2,#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val("");
            }
            $("#fld_USER_SIGNEDAPPROVER").val("USER:org=CustomOC,user=CustomOC/" + loginName);
            const Language = judgeLanguage();
            $("#fld_USER_SIGNEDAPPROVERNAME").val(Language == 'en-US' ? loginName : cnname);
            $(".USER_SignedApprover").css("pointer-events", "none");
            $(".USER_SignedApprover").next().css("pointer-events", "none");
        } else {
            vRbtidList[0].setAttribute("disabled", "disabled");
            vRbtidList[1].checked = true;
        }
    } else {
        clearSignedFixedApprover();
        $(".USER_SignedApprover").css({ "pointer-events": "auto", "cursor": "pointer" });
        $(".USER_SignedApprover").next().css({ "pointer-events": "auto", "cursor": "pointer" });
    }
}

function changeIsPrePaid() {
    let IsPrePaid;
    const vRbtid = document.getElementById("div_field_IsPrePaid");
    const vRbtidList = vRbtid.getElementsByTagName("input");
    for (let i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) IsPrePaid = vRbtidList[i].value;
    }
}

function clearSignedFixedApprover(init) {
    if (init) return;
    $("#fld_USER_SIGNEDAPPROVERNAME,#fld_USER_SIGNEDAPPROVER,#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2,#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
}

function hiddenSupplierType() {
    const code = $("#fld_SUPPLIERTYPE").val();
    const value = $("#fld_SUPPLIERTYPE").find("option:selected").text();
    document.getElementById('fld_SUPPLIERTYPE').options.length = 0;
    document.getElementById("fld_SUPPLIERTYPE").options.add(new Option(value, code));
}

function blockSupplierType() {
    const code = $("#fld_SUPPLIERTYPE").val();
    const Language = judgeLanguage();
    const optList = Language == 'en-US'
        ? [{ t: "", v: "" }, { t: "Unauthorized Supplier", v: "2" }, { t: "Authorized Supplier", v: "9" }, { t: "Buying Outright", v: "5" }]
        : [{ t: "", v: "" }, { t: "非授权供应商", v: "2" }, { t: "授权供应商", v: "9" }, { t: "员工垫资", v: "5" }];
    const sel = document.getElementById('fld_SUPPLIERTYPE');
    sel.options.length = 0;
    optList.forEach(opt => sel.options.add(new Option(opt.t, opt.v)));
    $("#fld_SUPPLIERTYPE").val(code);
}

function checkArticleCode() {
    const suppliertypeVal = $("#fld_SUPPLIERTYPE").val();
    const tabCtl = document.getElementById("tb_MCPR_SERVICE_ITEMS");
    const rows = Array.from(tabCtl.rows).slice(1);

    for (let i = 0; i < rows.length; i++) {
        for (let j = i + 1; j < rows.length; j++) {
            const row1 = rows[i];
            const row2 = rows[j];
            const rowNo1 = $(row1).find("input[id*='fld_ROWNO']").val();
            const rowNo2 = $(row2).find("input[id*='fld_ROWNO']").val();
            if (rowNo1 == rowNo2) return false;

            if (suppliertypeVal == "9") {
                const art1 = $(row1).find("input[id*='fld_ARTICLECODE']").val();
                const price1 = $(row1).find("input[id*='fld_SITEPRICE']").val();
                const art2 = $(row2).find("input[id*='fld_ARTICLECODE']").val();
                const price2 = $(row2).find("input[id*='fld_SITEPRICE']").val();
                if (art1 == art2 && price1 == price2) return false;
            } else {
                const obj1 = getRowMaterialKey(row1);
                const obj2 = getRowMaterialKey(row2);
                if (JSON.stringify(obj1) === JSON.stringify(obj2)) return false;
            }
        }
    }
    return true;
}

function getRowMaterialKey(row) {
    return {
        articlename: $(row).find("input[id*='fld_ARTICLENAME']").val(),
        orderunit: $(row).find("input[id*='fld_ORDERUNITVALUE']").val(),
        unit: $(row).find("input[id*='fld_UNITVALUE']").val(),
        consumptionunit: $(row).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(),
        conversion: $(row).find("input[id*='fld_CONVERSION']").val(),
        stock: $(row).find("input[id*='fld_STOCK']").val(),
        subsubfamilycode: $(row).find("input[id*='fld_SUBSUBFAMILYCODE']").val()
    };
}

function checkShowRemark() {
    let ShowRemark;
    const vRbtid = document.getElementById("div_field_SHOWREMARK");
    const vRbtidList = vRbtid.getElementsByTagName("input");
    for (let i = 0; i < vRbtidList.length; i++) {
        if (vRbtidList[i].checked) ShowRemark = vRbtidList[i].value;
    }
    if (ShowRemark == "1") {
        return ($("#fld_APPREMARK").val() || "").trim() == "";
    }
    return false;
}

function changeApplyPurpose(init) {
    const ApplyPurpose = $("#fld_APPLYPURPOSE").val();
    if (ApplyPurpose == "2") {
        $("#SupplementaryBlank").removeClass("hidden");
        $("#div_field_FIXEDASSETS").addClass("hidden");
        $("#SupplementaryBlank .form-field").removeAttr("style");
        alert("分店选择待采购需要提交独立的采购合同或客户订单。如果合同的内容符合以下条件的，则可以按代采购处理.\nDefinition of Purchasing activity on behalf of client \n \nIf the purchasing was requested by client and meet below criteria, Sodexo is acting as an agent during this activity.\n如果由客户提出的采购要求并同时满足以下条件，索迪斯在此业务中作为一个代理人。\n \n➢ Sodexo has no discretion in selecting the supplier(decided by client) used to fulfil an order; 索迪斯无权选择供应商(由客户决定)履行订单;\n➢ Sodexo have no discretion in establishing prices(decided by client);索迪斯没有定价权(由客户决定); \n➢ Sodexo doesn’t have the risks and rewards of ownership,such as general inventory risk before delivery or after returns, or inventory risks during shipping;索迪斯不拥有所有权的风险及回报，一般库存风险或在运输过程中的库存风险;\n➢ Sodexo can not modify the product(i.e.convert the raw materials supplies purchased) or performs part of the services(which was decided by client);索迪斯不可以修改采购产品或执行部分服务(由客户决定);\n➢ Sodexo was not involved in the determination of product or service specifications.索迪斯不能决定产品或服务的具体规格要求 \n \n   We treated them as purchasing activity on behalf of client,then the revenue will be only the commission or the margin(i.e.a net basis).我们认为这些是代客户采购业务，那么收入按佣金或加成（即净额）计算。");
        AssignSignedApprover(init);
    } else {
        $("#SupplementaryBlank").addClass("hidden");
        clearSignedFixedApprover(init);
        $(".USER_SignedApprover").css({ "pointer-events": "auto", "cursor": "pointer" });
        $(".USER_SignedApprover").next().css({ "pointer-events": "auto", "cursor": "pointer" });
    }
}

function changeSupplierType() {
    const SupplierType = $("#fld_SUPPLIERTYPE").val();
    if (SupplierType == "9") {
        $("#fld_APPREMARK").removeClass("validate[required]");
        $("#fld_APPREMARK").siblings(".fld_APPREMARKformError").remove();
    } else {
        $("#fld_APPREMARK").addClass("validate[required]");
    }
    showInvoiceInfo();
    $("#SUPPLIERTYPE").val($("#fld_SUPPLIERTYPE").val());
    $("#SUPPLIERTYPETXT").val($("#fld_SUPPLIERTYPE").find("option:selected").text());
    suppliertype = $("#fld_SUPPLIERTYPE").val();
    suppliertypetxt = $("#fld_SUPPLIERTYPE").find("option:selected").text();
}
/**
 * Add By Sylvia At 2020-08-03
 * 客户代采购给一级加签审批人赋值
 * @param {any} init 是否是初始化
 */
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
function isShow() {
    
    if ($("#HiddenIncident").val() == "-2") {

        //$("#ButtonList1_btnSend").hide();
        $("#ButtonList1_btnSaveDraft").hide();

    } else {       
        $("#ButtonList1_btnSend").show();
        $("#ButtonList1_btnSaveDraft").show();

    }
    
}

function updateProgress(fileName, progress) {
    const progressBar = document.querySelector(`[data-filename="${fileName}"] .progress`);
    if (progressBar) {
        progressBar.style.width = progress + '%';
    }
}
function initInvoiceLinks() {
    // 遍历所有表体行的INVOICEPATH文本框
    $("#tb_MCPR_SERVICE_ITEMS tbody tr td.td_INVOICEPATH [data-field='INVOICEPATH']").each(function () {
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
    } else {
        // 路径为空：隐藏链接
        $link.hide();
    }

}

function showInvoiceInfo() {

    if ($("#fld_SUPPLIERTYPE").val() == "5") {
        $(config.divs).removeClass("hidden");
        // 添加必填验证
        //$(config.inputs).addClass("validate[required]");
        // 显示表格列（遍历所有列类名，同时处理表头和表体）
        config.tableCols.forEach(function (colClass) {
            $(`#tb_MCPR_SERVICE_ITEMS thead tr td.${colClass}, #tb_MCPR_SERVICE_ITEMS tbody tr td.${colClass}`).show();
        });
    }
    else {
        // 隐藏div
        $(config.divs).addClass("hidden");
        // 移除必填验证
        //$(config.inputs).removeClass("validate[required]");

        // 隐藏表格列（遍历所有列类名，同时处理表头和表体）
        config.tableCols.forEach(function (colClass) {
            $(`#tb_MCPR_SERVICE_ITEMS thead tr td.${colClass}, #tb_MCPR_SERVICE_ITEMS tbody tr td.${colClass}`).hide();
        });
    }

}