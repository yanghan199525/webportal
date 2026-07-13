//获取根路径
var userLang = localStorage.getItem("BPMUserLang");

var path = "../../..";
//var r = document.getElementsByTagName("script");
//for (var i = 0; i <= r.length; i++) {
//    var obj = r[i];
//    if (obj) {
//        if (obj.src.toLowerCase().indexOf("common.js") > 0) {
//            path = obj.src.toLowerCase().replace("/common/assets/js/common.js", "");
//        }
//    }
//}


//选择主数据
/*
            showSelectData({
                sql: "SELECT CODE,NAME,VALUE FROM COM_RESOURCE WHERE Type='AccountType'",
                order: "CODE",
                displayField: "CODE,NAME,VALUE",
                displayFieldCaption: "编号,名称,描述",
                displayFieldWidth: "100,100,200",
                title: "选择物料",
                callback: function (obj) {
                    var tr = $(ele).parent().parent();
                    tr.find(".name").val(obj);
                }
            });
*/
function showSelectData(options) {
    element = options.element;
    IsMethod = options.IsMethod;
    fields = options.fields;
    callback = options.callback;
    sql = options.sql;
    order = options.order;
    field = options.field;
    displayName = options.displayName;
    width = options.width;
    title = options.title;
    single = options.single;
    dbName = options.dbName;
    filter = options.filter;
    dataSource = options.dataSource;
    size = options.size;
    bialogCloseByBackdrop = options.bialogCloseByBackdrop;

    if (size == "Normal") {
        size = "lg";
    } else if (size == "Small") {
        size = "sm";// 最小
    } else if (size == "Wide") {
        size = "lg";
    } else if (size == "Large") {
        size = "xl";// 最大
    } else {
        size = "lg";
    }

    if (!title) {
        title = "";
    }
    if (!width) {
        width = "";
    }
    if (!order) {
        order = "";
    }
    if (!filter) {
        filter = "";
    }
    if (!dataSource) {
        dataSource = "";
    }
    if (!dbName) {
        dbName = "";
    }
    if (!field) {
        field = "";
    }
    if (!displayName) {
        displayName = "";
    }
    if (typeof (_rootPath) === "undefined") {
        _rootPath = window.document.location.origin;
    }
    if (typeof (_rootPath) === "undefined") {
        path = window.document.location.protocol + "//" + window.document.location.host;
    }
    url = _rootPath + "/Portal/Ultimus.UWF.Home.V3/SelectPageStrengthen.aspx?sql=" + sql + "&order=" + order
        + "&query=" + field + "&caption=" + displayName + "&width=" + width + "&title=" + title + "&single="
        + single + "&dbName=" + dbName + "&dataSource=" + dataSource + "&filter=" + filter;
    url = encodeURI(url);

    showForm({
        element: element,
        title: title,
        url: url,
        IsMethod: IsMethod,
        callback: callback,
        size: size,
        bialogCloseByBackdrop: bialogCloseByBackdrop,
        height: 445,
        fields: fields,
        returnFunc: "returnValue"
    });
}

//选择数据源
function selectDataSource(options) {
    element = options.element;
    fields = options.fields;
    dataSource = options.dataSource;
    single = options.single;
    filter = options.filter;
    title = options.title;
    IsMethod = options.IsMethod;
    size = options.size;
    bialogCloseByBackdrop = options.BialogCloseByBackdrop;
    if (!fields) {
        fields = "";
    }
    if (fields !== "") {
        var eid = element.id;
        if (element.id === undefined) {
            eid = element[0].id;//Jquery对象
        }
        fields = eid + "," + fields;
    }
    else {
        fields = element.id;
        if (fields === undefined) {
            fields = element[0].id;//Jquery对象
        }
    }
    IsMethod = (IsMethod === null || IsMethod === '' || IsMethod === 'undefined') ? false : true;
    showSelectData({
        element: element,
        dataSource: dataSource,
        single: single,
        filter: filter,
        title: title,
        size: size,
        IsMethod: IsMethod,
        bialogCloseByBackdrop: bialogCloseByBackdrop,
        fields: fields
    });
}

function showForm(options) {
    element = options.element;
    IsMethod = options.IsMethod;
    fields = options.fields;
    url = options.url;
    title = options.title;
    height = options.height;
    width = options.width;
    size = options.size;
    oktext = options.oktext;
    canceltext = options.canceltext;
    bialogCloseByBackdrop = options.bialogCloseByBackdrop;

    if (typeof (bialogCloseByBackdrop) === "undefined") {
        bialogCloseByBackdrop = true;
    }
    if (!size) {
        size = "lg";// 默认大小
    }
    if (!height) {
        height = "300";
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        var titles = title.split(',');
        var titlecn = '';
        var titleen = '';
        for (var i = 0; i < titles.length; i++) {
            if (titles[i].split(':')[0].toLocaleLowerCase() === "zh-cn") {
                titlecn = titles[i].split(':')[1];
            } else {
                titleen = titles[i].split(':')[1];
            }
        }
        if (userLang.toLocaleLowerCase() == "zh-cn") {
            title = titlecn;
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title = titleen;
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title = "Data Source";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }

    if (!title) {
        title = "Data Source";
    }

    if (!oktext) {
        oktext = Confirm;
    }

    if (!canceltext) {
        canceltext = Cancel;
    }

    // 初始化弹出层
    $('#formModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 触发事件的按钮  
        var modal = $(this);
        if (parent.document !== document)
            modal.css('top', (parent.document.documentElement.scrollTop - 10));
        modal.removeClass("bd-example-modal-lg").removeClass("bd-example-modal-xl").removeClass("bd-example-modal-sm");
        modal.addClass("bd-example-modal-" + size);
        modal.find(".modal-dialog").removeClass("modal-lg").removeClass("modal-xl").removeClass("modal-sm");
        modal.find(".modal-dialog").addClass("modal-" + size);
        modal.find(".modal-content").removeAttr("style");
        modal.find('.modal-title').text(title);
        modal.find(".modal-footer .btn-primary").text(oktext).attr("data-dismiss", "modal");
        modal.find('.modal-body').html('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' scrolling="no" frameborder="no" style="border-width:0px;"></iframe>');
        modal.find('.modal-footer .btn-light').text(canceltext);

        try {
            if (!isNullOrEmpty(element))
                modal.find('.modal-footer .btn-primary').attr("onclick", "modalCallback(" + IsMethod + ",'" + fields + "','" + element.id + "')");
        } catch (e) {
            console.info("element is empty");
        }
        if (typeof (OpenModalFn) === "function") {
            // 调用表单内部方法，自定义设置model
            OpenModalFn(modal, element.id);
        }
    });
    $('#formModal').on('hidden.bs.modal', function (e) {
        $(this).removeData("bs.modal");
        $('#formModal').modal('dispose');
        // do something...
    });

    $("#formModal").modal();
    //if (width) {
    //    var windowWidth = $(window).width();
    //    if (windowWidth < 640) {
    //        width = windowWidth;
    //    }

    //    $(".modal-dialog", parent.document).css({
    //        width: width
    //    });
    //}
}

// 弹出层返回参数
function modalCallback(IsMethod, fields, id) {
    var element = document.getElementById(id);
    var sz = fields.split(',');
    var objs = "";
    for (i = 0; i < sz.length; i++) {
        var str = "";
        objs = document.getElementById("frmWindow").contentWindow.returnValue();
        $.each(objs, function (k, obj) {
            var names = "";
            var j = 0;
            for (var name in obj) {
                if (i == j) {
                    names = name;
                }
                j++;
            }
            if (obj[names] == null)
                str += ",";
            else
                str += obj[names] + ",";
        });
        if (sz[i].indexOf("fld_") < 0) {
            if (element.id != undefined) {
                //repeater
                if (element.id.indexOf("_ctl") > 0) {
                    var ids = element.id.split('_');
                    var idpref = "";
                    for (l = 0; l < ids.length - 1; l++) {
                        idpref += ids[l] + "_";
                    }
                    if (str.length != 1) {
                        $("#" + idpref + sz[i]).val(str.trimEnd(','));
                    } else {
                        $("#" + idpref + sz[i]).val(str.replace(',', ''));
                    }

                }
                else {
                    if (str.length != 1) {
                        $("#fld_" + sz[i]).val(str.trimEnd(','));
                    } else {
                        $("#fld_" + sz[i]).val(str.replace(',', ''));
                    }
                }
            } else {
                //自定义控件返回
                $("#" + sz[i]).val(str.trimEnd(','));
            }

        }
        else {
            if (str.length != 1) {
                $("#" + sz[i]).val(str.trimEnd(','));
            } else {
                $("#" + sz[i]).val(str.replace(',', ''));
            }
        }
    }

    //判断是否返回父页面方法
    if (IsMethod) {
        try {
            OpenerPageIsMethod(element.id, objs);
        } catch (e) {
            console.info("IsMethod  OpenerPageIsMethod回调方法不存在");
        }
    }

    if (typeof (CloseModalCallback) === "function") {
        // 调用表单内部方法，自定义设置model
        CloseModalCallback(element.id, objs);
    }
    //try {
    //    OpenModalCallback(element.id);
    //} catch (e) {
    //    console.info("OpenModalCallback回调方法不存在");
    //}

    // 关闭模态窗关闭
    $('#formModal').modal('toggle');
}

//关闭弹出表单
function closeForm() {
    $('.modal-dialog button.close', parent.document).trigger('click');
    return false;
}

function showAlert(text, callback) {
    BootstrapDialog.show({
        message: text,
        animate: false,
        callback: callback
    });
}

function showConfirm(text, callback) {
    BootstrapDialog.show({
        message: text,
        animate: false,
        buttons: [{
            label: 'Ok',
            cssClass: 'btn btn-default btn-md',
            action: function (dialog) {
                if (callback) {
                    callback(ctl.val());
                }

                dialog.close();
            }
        }, {
            label: 'Cancel',
            cssClass: 'btn btn-md',
            action: function (dialog) {
                dialog.close();
            }
        }]
    });

}
//附加验证
function attachValidation() {
    $("#form1").validationEngine('attach', {
        onValidationComplete: function (form, status) {

        }
    });
}

//验证，废弃
function validate() {
    var flag = $("#form1").validationEngine();
    $(".formError").show();
    return flag;
}

//去掉验证
function removeValidate() {
    $("#form1").validationEngine('detach');
}

//去掉验证
function detachValidation() {
    $("#form1").validationEngine('detach');
}

//转大写
function setMoneyCAP(num) {
    //num = num.replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    //num = num.replace("￥", "").replace("￥", "").replace("￥", "").replace("￥", "").replace("￥", "").replace("￥", "");

    if (num == "" || num == null) {
        return;
    }



    //if (isNaN(num))
    //update by bai 2017/12/22
    num = num.replace(/\,/g, "");
    if (isNaN(num)) {
        alert("只能输入数字和小数点！");
        return;
    }

    currencyDigits = num;
    //最大值
    var MAXIMUM_NUMBER = 99999999999.99;
    //定义数字大写汉字符号
    var CN_ZERO = "零";
    var CN_ONE = "壹";
    var CN_TWO = "贰";
    var CN_THREE = "叁";
    var CN_FOUR = "肆";
    var CN_FIVE = "伍";
    var CN_SIX = "陆";
    var CN_SEVEN = "柒";
    var CN_EIGHT = "捌";
    var CN_NINE = "玖";
    var CN_TEN = "拾";
    var CN_HUNDRED = "佰";
    var CN_THOUSAND = "仟";
    var CN_TEN_THOUSAND = "万";
    var CN_HUNDRED_MILLION = "亿";
    var CN_SYMBOL = "";
    var CN_DOLLAR = "圆";
    var CN_TEN_CENT = "角";
    var CN_CENT = "分";
    var CN_INTEGER = "整";

    //临时变量
    var integral;           // Represent integral part of digit number.
    var decimal;            // Represent decimal part of digit number.
    var outputCharacters;   // The output result.
    var parts;
    var digits, radices, bigRadices, decimals;
    var zeroCount;
    var i, p, d;
    var quotient, modulus;

    // Validate input string:
    currencyDigits = currencyDigits.toString();
    if (currencyDigits == "") {
        alert("输入为空，不能进行转换！");
        return "";
    }
    if (currencyDigits.match(/[^,.\d]/) != null) {
        alert("数值中存在非法字符！");
        return "";
    }
    if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
        alert("非法的数值格式！");
        return "";
    }

    // Normalize the format of input digits:
    currencyDigits = currencyDigits.replace(/,/g, "");      // Remove comma delimiters.
    currencyDigits = currencyDigits.replace(/^0+/, "");     // Trim zeros at the beginning.

    //如果数值超过最大值的范围
    if (Number(currencyDigits) > MAXIMUM_NUMBER) {
        alert("数值过大，无法完成转换！");
        return "";
    }

    // Process the coversion from currency digits to characters:
    // Separate integral and decimal parts before processing coversion:
    parts = currencyDigits.split(".");
    if (parts.length > 1) {
        integral = parts[0];
        decimal = parts[1];
        decimal = decimal.substr(0, 2);     // Cut down redundant decimal digits that are after the second.
    }
    else {
        integral = parts[0];
        decimal = "";
    }

    // Prepare the characters corresponding to the digits:
    digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
    radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
    bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
    decimals = new Array(CN_TEN_CENT, CN_CENT);

    // Start processing:
    outputCharacters = "";

    // Process integral part if it is larger than 0:
    if (Number(integral) > 0) {
        zeroCount = 0;
        for (i = 0; i < integral.length; i++) {
            p = integral.length - i - 1;
            d = integral.substr(i, 1);
            quotient = p / 4;
            modulus = p % 4;
            if (d === "0") {
                zeroCount++;
            }
            else {
                if (zeroCount > 0) {
                    outputCharacters += digits[0];
                }
                zeroCount = 0;
                outputCharacters += digits[Number(d)] + radices[modulus];
            }

            if (modulus === 0 && zeroCount < 4) {
                outputCharacters += bigRadices[quotient];
            }
        }

        outputCharacters += CN_DOLLAR;
    }

    // Process decimal part if there is:
    if (decimal !== "") {
        for (i = 0; i < decimal.length; i++) {
            d = decimal.substr(i, 1);
            if (d !== "0") {
                outputCharacters += digits[Number(d)] + decimals[i];
            }
        }
    }

    // Confirm and return the final output string:
    if (outputCharacters === "") {
        outputCharacters = CN_ZERO + CN_DOLLAR;
    }

    if (decimal === "" || decimal === "00" || decimal === "0") {
        outputCharacters += CN_INTEGER;
    }

    outputCharacters = CN_SYMBOL + outputCharacters;
    return outputCharacters;
}

//trim
String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

//trimEnd
String.prototype.trimEnd = function (char) {
    if (this.lastIndexOf(",") > 0) {
        return this.substring(0, this.lastIndexOf(","));
    }
    return this;
};

// 添加空白行
function addRow(tabId) {
    try {
        var tabCtl = document.getElementById(tabId);
        var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
        var newRow = modelTr.cloneNode(true);
        //var rowIndex = newRow.rowIndex - 1;
        var rowIndex = tabCtl.rows.length - 1;
        newRow = changeRowID(newRow, rowIndex);
        clearRow(newRow);
        if ($(tabCtl.rows[1]).attr("class") === "hidden") {
            $(newRow).find(".index").html(rowIndex);
            $(newRow).find(".index").val(rowIndex);
        }
        else {
            $(newRow).find(".index").html(rowIndex + 1);
            $(newRow).find(".index").val(rowIndex + 1);
            var newGuid = guid();
            $(newRow).find("input[data-field='ROWGUID']").html(newGuid);
            $(newRow).find("input[data-field='ROWGUID']").val(newGuid);
        }

        $(tabCtl).find("tbody")[0].appendChild(newRow);

        $("#" + tabId + "_rowCount").val(rowIndex + 1);

        //设置H5控件
        InitDateControls();

        var ubtn = $(newRow).find(".uploadifive-button")[0];
        if (ubtn) {
            $(ubtn).attr("id", $(ubtn).attr("id").replace("uploadifive-", ""));
            $(ubtn).attr("class", $(ubtn).attr("class").replace("uploadifive-button", "attachment"));
            $(ubtn).empty();
        }

        attachUpload($(newRow).find(".attachment")[0]);
        $(newRow).removeClass("hidden");
        reActiveCss();
        $(".formError").each(function () {
            $(this).remove();
        });
    }
    catch (e) {
        $(".formError").each(function () {
            $(this).remove();
        });
    }
}

// 添加空白行（明细行选择user）
function addRowS(tabId) {
    try {
        var tabCtl = document.getElementById(tabId);
        var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
        var newRow = modelTr.cloneNode(true);
        //var rowIndex = newRow.rowIndex - 1;
        var rowIndex = tabCtl.rows.length - 1;
        newRow = changeRowIDS(newRow, rowIndex);
        clearRow(newRow);
        if ($(tabCtl.rows[1]).attr("class") == "hidden") {
            $(newRow).find(".index").html(rowIndex);
            $(newRow).find(".index").val(rowIndex);
        }
        else {
            $(newRow).find(".index").html(rowIndex + 1);
            $(newRow).find(".index").val(rowIndex + 1);
        }

        $(tabCtl).find("tbody")[0].appendChild(newRow);

        $("#" + tabId + "_rowCount").val(rowIndex + 1);

        try {
            InitDate();
            InitDateTime();
            InitTime();
        } catch (e) {
            InitDate();
            InitDateTime();
            InitTime();
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
    catch (e) {
        console.info(e);
    }
}

// 复制行
function copyRow(tabId) {
    var tabCtl = document.getElementById(tabId);
    var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
    var newRow = modelTr.cloneNode(true);
    var rowIndex = tabCtl.rows.length - 1;
    newRow = changeRowID(newRow, rowIndex);
    $(tabCtl).find("tbody")[0].appendChild(newRow);
    $("#" + tabId + "_rowCount").val(rowIndex + 1);
}

//更改控件的ID
function changeRowID(row, rowIndex) {
    for (var j = 0; j < row.cells.length; j++) {
        if ($(row.cells[j]).children().hasClass("inputContainer")) {
            id = $(row.cells[j]).find(".inputContainer").children().attr("id");
        } else {
            id = $(row.cells[j]).children().attr("id");
        }
        if (id) {
            var a = id.indexOf("ctl");
            var b = rowIndex;//parseInt(id.substr(a + 3, 2)) + 1;//rowIndex
            if (b < 10) {
                b = "0" + b;
            }
            var c = id.substr(a).substr(id.substr(a).indexOf("_"));
            id = id.substr(0, a) + "ctl" + b + c;
            if ($(row.cells[j]).children().hasClass("inputContainer")) {
                $(row.cells[j]).find(".inputContainer").children().attr("id", id);
            } else {
                $(row.cells[j]).children().attr("id", id);
            }
        }
        else {
            var objs = $(row.cells[j]).find("input");
            $.each(objs, function (i, obj) {
                id = obj.id;
                var a = id.indexOf("ctl");
                var b = rowIndex;
                if (b < 10) {
                    b = "0" + b;
                }
                var c = id.substr(a).substr(id.substr(a).indexOf("_"));
                id = id.substr(0, a) + "ctl" + b + c;
                $(obj).attr("id", id);
            });

            objs = $(row.cells[j]).find("label");
            $.each(objs, function (i, obj) {
                id = $(obj).attr("for");
                var a = id.indexOf("ctl");
                var b = rowIndex;
                if (b < 10) {
                    b = "0" + b;
                }
                var c = id.substr(a).substr(id.substr(a).indexOf("_"));
                id = id.substr(0, a) + "ctl" + b + c;
                $(obj).attr("for", id);
            });
        }

        if ($(row.cells[j]).children().hasClass("inputContainer")) {
            name = $(row.cells[j]).find(".inputContainer").children().attr("name");
        } else {
            name = $(row.cells[j]).children().attr("name");
        }

        if (name && name != "undefined") {
            var a = name.indexOf("ctl");
            var b = rowIndex;//parseInt(name.substr(a + 3, 2)) + 1;//rowIndex
            if (b < 10) {
                b = "0" + b;
            }
            var c = name.substr(a).substr(name.substr(a).indexOf("$"));
            name = name.substr(0, a) + "ctl" + b + c;

            if ($(row.cells[j]).children().hasClass("inputContainer")) {
                $(row.cells[j]).find(".inputContainer").children().attr("name", name);
            } else {
                $(row.cells[j]).children().attr("name", name);
            }
        }
        else {
            var objs = $(row.cells[j]).find("input");
            $.each(objs, function (i, obj) {
                name = obj.name;
                var a = name.indexOf("ctl");
                var b = rowIndex;
                if (b < 10) {
                    b = "0" + b;
                }
                var c = name.substr(a).substr(name.substr(a).indexOf("$"));
                name = name.substr(0, a) + "ctl" + b + c;
                $(obj).attr("name", name);
            });
        }
    }
    return row;
}
//更改控件id （明细行选择user）
function changeRowIDS(row, rowIndex) {
    for (var j = 0; j < row.cells.length; j++) {
        id = $(row.cells[j]).children().attr("id");
        if (id) {
            var a = id.indexOf("ctl");
            var b = rowIndex;//parseInt(id.substr(a + 3, 2)) + 1;//rowIndex
            if (b < 10) {
                b = "0" + b;
            }
            var c = id.substr(a).substr(id.substr(a).indexOf("_"));
            id = id.substr(0, a) + "ctl" + b + c;
            $(row.cells[j]).children().attr("id", id);
        }
        else {
            var objs = $(row.cells[j]).find("input");
            $.each(objs, function (i, obj) {
                id = obj.id;
                var a = id.indexOf("ctl");
                var b = rowIndex;
                if (b < 10) {
                    b = "0" + b;
                }
                var c = id.substr(a).substr(id.substr(a).indexOf("_"));
                id = id.substr(0, a) + "ctl" + b + c;
                $(obj).attr("id", id);
            });

            objs = $(row.cells[j]).find("label");
            $.each(objs, function (i, obj) {
                id = $(obj).attr("for");
                var a = id.indexOf("ctl");
                var b = rowIndex;
                if (b < 10) {
                    b = "0" + b;
                }
                var c = id.substr(a).substr(id.substr(a).indexOf("_"));
                id = id.substr(0, a) + "ctl" + b + c;
                $(obj).attr("for", id);
            });
            objs = $(row.cells[j]).find("input");
            var objs2 = $(row.cells[j]).find("span");
            if (objs2.length > 0) {
                var objs3 = $(row.cells[j]).prop('outerHTML');
                var id3 = objs3.split("','");
                var e = id3[1];
                var f = id3[2];
                var g = e.split("ctl");
                $.each(objs2, function (i, obj2) {
                    $.each(objs, function (i, obj) {
                        id = obj.id;
                        var a = id.indexOf("ctl");
                        var b = rowIndex;
                        if (b < 10) {
                            b = "0" + b;
                        }
                        var c = id.substr(a).substr(id.substr(a).indexOf("_"));
                        if (g[0] !== "") {
                            var h = g[0] + "ctl" + b + g[1].substr(2, g[1].length);
                        } else {
                            h = "";
                        }
                        id = "SelectUserList(1,'" + id.substr(0, a) + "ctl" + b + c + "','" + h + "','" + b + "','selectUser');";
                        $(obj2).attr("onclick", id);
                    });
                });
            }
        }

        name = $(row.cells[j]).children().attr("name");
        if (name && name !== "undefined") {
            var a = name.indexOf("ctl");
            var b = rowIndex;//parseInt(name.substr(a + 3, 2)) + 1;//rowIndex
            if (b < 10) {
                b = "0" + b;
            }
            var c = name.substr(a).substr(name.substr(a).indexOf("$"));
            name = name.substr(0, a) + "ctl" + b + c;
            $(row.cells[j]).children().attr("name", name);
        }
        else {
            var objs = $(row.cells[j]).find("input");
            $.each(objs, function (i, obj) {
                name = obj.name;
                var a = name.indexOf("ctl");
                var b = rowIndex;
                if (b < 10) {
                    b = "0" + b;
                }
                var c = name.substr(a).substr(name.substr(a).indexOf("$"));
                name = name.substr(0, a) + "ctl" + b + c;
                $(obj).attr("name", name);
            });
        }
    }
    return row;
}
//清除数据
function clearRow(row) {
    for (var i = 0; i < row.cells.length; i++) {
        try {
            //if ($(row.cells[i].childNodes[1]).hasClass("input-group")) {
            //    $(row.cells[i].childNodes[1]).find("input").val("");
            //} else {
            //    row.cells[i].childNodes[1].value = "";
            //}
            var obj;
            if ($(row.cells[i].childNodes[1]).hasClass("input-group")) {
                obj = $(row.cells[i].childNodes[1]).find("input");
                if (!obj.hasClass("defaultValue"))
                    obj.val("");
            } else {
                obj = row.cells[i].childNodes[1];
                if (!$(obj).hasClass("defaultValue"))
                    row.cells[i].childNodes[1].value = "";
            }
        }
        catch (e) {
        }
    }
    $(row).find(".selectuser").val("");
    $(row).find(".attachment_show").empty();
}

//删除行
function deleteRow(tabId, ele) {
    var tabCtl = document.getElementById(tabId);
    var tabRows = tabCtl.rows;
    var rowIndex = $(ele).parent().parent()[0].rowIndex;
    if (rowIndex === 1) {
        clearRow($(ele).parent().parent()[0]);
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


//isDeleteFirstLine 是否删除第一行 bool类型
function deleteRow(tabId, ele, isDeleteFirstLine) {
    var tabCtl = document.getElementById(tabId);
    var tabRows = tabCtl.rows;
    var rowIndex = $(ele).parent().parent()[0].rowIndex;
    var length = $("#" + tabId + " .fa-trash").length;
    if (length === 1 && isDeleteFirstLine !== true) {
        clearRow($(ele).parent().parent()[0]);
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

function deleteRowForHidden(tabId, ele) {
    var tabCtl = document.getElementById(tabId);
    var tabRows = tabCtl.rows;
    var rowIndex = $(ele).parent().parent()[0].rowIndex;
    if (rowIndex == 1) {
        clearRow($(ele).parent().parent()[0]);
    }
    else {
        tabCtl.deleteRow(rowIndex);
    }
    $("#" + tabId + "_rowCount").val(tabRows.length - 1);

    tabCtl = document.getElementById(tabId);
    tabRows = tabCtl.rows;
    for (var i = 2; i < tabRows.length; i++) {
        changeRowID(tabRows[i], i - 1);

        $(tabRows[i]).find(".index").html(i - 1);
        $(tabRows[i]).find(".index").val(i - 1);

    }
}////复制行
//function copyRow(tabId) {
//    var tabCtl = document.getElementById(tabId);
//    var tabRows = tabCtl.rows;
//    var rowCheckBox;
//    var copyRows;
//    var index = 0;

//    for (var i = 1; i < tabRows.length - index - 1; i++) {
//        rowCheckBox = tabRows[i].childNodes[1].childNodes[1];
//        if (rowCheckBox.checked == true) {
//            tabCtl.appendChild(tabRows[i].cloneNode(true));
//            index++;
//        }
//    }
//}

//提取表格的值,JSON格式
function GetDataTable(tabId) {
    var tableData = new Array();
    var table = $("#" + tabId).find("tbody")[0];
    for (var i = 1; i < table.rows.length; i++) {
        tableData.push(GetRowData(table.rows[i]));
    }
    return JSON.stringify(tableData);
}

//提取指定行的数据，JSON格式
function GetRowData(row) {
    var rowData = {};
    for (var j = 0; j < row.cells.length; j++) {
        name = $(row.cells[j]).children().attr("data-field");
        if (name) {
            var value = $(row.cells[j]).children().val();
            if (!value) {
                value = row.cells[j].innerText;
            }
            rowData[name] = value;
        }
    }
    //alert("ProductName:" + rowData.ProductName);
    //或者这样：alert("ProductName:" + rowData["ProductName"]);
    return rowData;
}

//选择所有行
function selectAll(tabId, allCheck) {
    var tabCtl = document.getElementById(tabId);
    var checkBox = tabCtl.getElementsByTagName('input');
    for (var i = 1; i < checkBox.length; i++) {
        if (allCheck.checked == true) {
            checkBox[i].checked = true;
        } else {
            checkBox[i].checked = false;
        }
    }
}


//********废弃**********
///打开tab页  
//Title:打开的Tab页的描述
//Url:打开的地址
//TabName:打开的Tab页ID,
//closable:true可关闭 false不可关闭
function openTab(title, url, tabName, closable) {
    var t = typeof window.tabs == "undefined" ? window.parent.tabs : window.tabs;
    t.add(title, url, tabName, closable);
}

//********废弃**********
function openForm(title, url) {
    return window.open(url);
}

//********废弃**********
function info(text) {
    alert(text);
}

//********废弃**********
function error(text) {
    alert(text);
}

//********废弃**********
function ask(text) {
    return confirm(text);
}


/***************************************************************************
Copyright (c) 2016 安码商务软件系统（上海）有限公司
创建人: jack   
日  期: 2016-10-18
修改人:	
日  期: 
描  述: 报表页面通用JS方法
版  本: 1.0
***************************************************************************/

var objReport = new Object();

//objReport.openForm = function (taskId, type, ele) {
//    var sheight = screen.height - 150;
//    var swidth = screen.width - 10;
//    var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
//    s = window.open('/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?TaskId=' + taskId + '&Type=' + type + '', '', winoption);

//    s.focus();
//}

objReport.openForm = function (formID, ProcessName, Incident) {
    var sheight = screen.height - 150;
    var swidth = screen.width - 10;
    var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
    s = window.open('/Portal/Ultimus.UWF.Workflow/OpenForm.aspx?FormID=' + formID + '&ProcessName=' + ProcessName + '&Incident=' + Incident + '&Type=report', '', winoption);

    s.focus();
};

objReport.openPage = function (url) {
    var sheight = screen.height - 150;
    var swidth = screen.width - 10;
    var winoption = "left=0,top=0,height=" + sheight + ",width=" + swidth + ",toolbar=yes,menubar=yes,location=yes,status=yes,scrollbars=yes,resizable=yes";
    s = window.open(url, '', winoption);
    s.focus();
};



//检查当前数据行中需要运行的字段
function checkExpression(element) {
    //表格中的计算
    if (element) {
        row = element.parentNode.parentNode;
        try {
            for (var j = 0; j < row.cells.length; j++) {
                expn = $(row)[0].parentNode.parentNode.rows[0].cells[j].getAttribute("data-expression");
                //如指定了公式则要求计算
                if (expn) {
                    var result = Expression(row, expn);
                    var format = $(row)[0].parentNode.parentNode.rows[0].cells[j].getAttribute("data-format");
                    if (format) {
                        //如指定了格式，进行字值格式化
                        //row.cells[j].innerHTML = formatNumber(Expression(row, expn), format);
                        $(row.cells[j]).children().val(GetMoney(FormatNum(result, 2)));
                    } else {
                        $(row.cells[j]).children().val(result);
                        //row.cells[j].innerHTML = Expression(row, expn);
                    }
                }
            }
        }
        catch (e) {
        }
    }

    //主表中的公式
    var totalPrice = 0.00;
    $("input[data-expression]").each(function (i, ele) {
        totalPrice = 0.00;
        var express = $(ele).attr("data-expression");
        if (express.indexOf("SUM(") >= 0) {
            express = express.replace("SUM(", "");
            express = express.replace(")", "");
            var sz = express.split('.');
            var ww = 0;
            var last;
            var item = 0;
            $("#tb_" + sz[0] + " tr").each(function () {
                var field = "";
                if (item === 0) {
                    ww = sz[1].split('{');
                    last = $.trim(ww[0]);
                }
                var price;
                if (ww.length > 1)
                    price = parseFloat($(this).find("[data-field='" + last.substring(0, last.length - 1) + "']").val());
                else
                    price = parseFloat($(this).find("[data-field='" + last + "']").val());
                if (price)
                    totalPrice += price;
                item++;
            });
            var num = "";
            if (ww.length > 1)
                num = ExpressionField(totalPrice + last.substring(last.length - 1, last.length) + "{" + ww[1]);
            else
                num = totalPrice;

            if (num !== "")
                $(ele).val(GetMoney(FormatNum(num, 2)));
            else
                $(ele).val("");
        }
        else {
            $(ele).val(GetMoney(FormatNum(ExpressionField(express), 2)));
        }
    });
}

//计算需要运算的字段
function Expression(row, expn) {
    var rowData = GetRowData(row);
    //循环代值计算
    for (var j = 0; j < row.cells.length; j++) {
        name = $(row.cells[j]).children().attr("data-field");
        if (name && name !== "null" && name != "undefined") {
            var reg = new RegExp("{" + name + "}", "g");
            if (expn.indexOf("{" + name + "}") >= 0) {
                var val = rowData[name];
                if (val !== "")
                    expn = expn.replace(reg, rowData[name].replace(/\,/g, ""));
                else
                    return "";
            }
        }
    }
    try {
        return eval(expn);
    }
    catch (e) {
    }
}

//计算需要运算的字段
function ExpressionField(expn) {
    var sz = splitFields(expn);
    for (var i = 0; i < sz.length; i++) {
        name = sz[i];
        if (name.indexOf("{") >= 0) {
            continue;
        }
        if (name) {
            var reg = new RegExp("{" + name + "}", "i");
            var val;
            if ($("#fld_" + name)) {
                val = $("#fld_" + name).val();
            }
            else {
                val = $("#read_" + name).val();
            }
            if (val == "")
                return "";
            else
                expn = expn.replace(reg, val.replace(/\,/g, ""));
        }
    }

    try {
        var num = eval(expn);
        if (!isNaN(num))
            return num;
        else
            return "";
    }
    catch (e) {
        //return expn;
        return "";
    }
}

///////////////////////////////////////////////////////////////////////////////////
/** 
* 格式化数字显示方式   
* 用法 
* formatNumber(12345.999,'#,##0.00'); 
* formatNumber(12345.999,'#,##0.##'); 
* formatNumber(123,'000000'); 
* @param num 
* @param pattern 
*/
/* 以下是范例
formatNumber('','')=0
formatNumber(123456789012.129,null)=123456789012
formatNumber(null,null)=0
formatNumber(123456789012.129,'#,##0.00')=123,456,789,012.12
formatNumber(123456789012.129,'#,##0.##')=123,456,789,012.12
formatNumber(123456789012.129,'#0.00')=123,456,789,012.12
formatNumber(123456789012.129,'#0.##')=123,456,789,012.12
formatNumber(12.129,'0.00')=12.12
formatNumber(12.129,'0.##')=12.12
formatNumber(12,'00000')=00012
formatNumber(12,'#.##')=12
formatNumber(12,'#.00')=12.00
formatNumber(0,'#.##')=0
*/

function formatNumber(num, pattern) {
    re = new RegExp(",", "g");
    var fixnum = "";

    if (num.length > 0) {
        num = num.replace(re, "");
    }

    try {
        num = num.replace(/[^0-9.+-]/g, '');
    } catch (e) {
    }

    //负数判断
    if (parseFloat(num) < 0) {
        num = num * -1;
        fixnum = "-";
    }
    var strarr = num ? num.toString().split('.') : ['0'];
    var fmtarr = pattern ? pattern.split('.') : [''];
    var retstr = '';

    // 整数部分   
    var str = strarr[0];
    var fmt = fmtarr[0];
    var i = str.length - 1;
    var comma = false;
    for (var f = fmt.length - 1; f >= 0; f--) {
        switch (fmt.substr(f, 1)) {
            case '#':
                if (i >= 0) retstr = str.substr(i--, 1) + retstr;
                break;
            case '0':
                if (i >= 0) retstr = str.substr(i--, 1) + retstr;
                else retstr = '0' + retstr;
                break;
            case ',':
                comma = true;
                retstr = ',' + retstr;
                break;
        }
    }
    if (i >= 0) {
        if (comma) {
            var l = str.length;
            for (; i >= 0; i--) {
                retstr = str.substr(i, 1) + retstr;
                if (i > 0 && ((l - i) % 3) == 0) retstr = ',' + retstr;
            }
        }
        else retstr = str.substr(0, i + 1) + retstr;
    }

    retstr = retstr + '.';
    //ckx 20180530 add 修正6位数字格式错误
    var resultstr = retstr;
    if (parseFloat(resultstr.replace(re, "")) > 0) {
        for (var k = 0; k < resultstr.length; k++) {
            var str_1 = resultstr.substr(k, 1);
            if (str_1 == "0" || str_1 == "," || str_1 == " ") {
                retstr = resultstr.substr(k + 1, resultstr.length - k);
            }
            else {
                break;
            }
        }
    }
    // 处理小数部分   
    str = strarr.length > 1 ? strarr[1] : '';
    fmt = fmtarr.length > 1 ? fmtarr[1] : '';
    i = 0;
    for (var f = 0; f < fmt.length; f++) {
        switch (fmt.substr(f, 1)) {
            case '#':
                if (i < str.length) retstr += str.substr(i++, 1);
                break;
            case '0':
                if (i < str.length) retstr += str.substr(i++, 1);
                else retstr += '0';
                break;
        }
    }
    retstr = fixnum + retstr;
    return retstr.replace(/^,+/, '').replace(/\.$/, '');
}

//function formatNumber(num, pattern) {
//    var strarr = num ? num.toString().split('.') : ['0'];
//    var fmtarr = pattern ? pattern.split('.') : [''];
//    var retstr = '';
//
//    // 整数部分   
//    var str = strarr[0];
//    var fmt = fmtarr[0];
//    var i = str.length - 1;
//    var comma = false;
//    for (var f = fmt.length - 1; f >= 0; f--) {
//        switch (fmt.substr(f, 1)) {
//            case '#':
//                if (i >= 0) retstr = str.substr(i--, 1) + retstr;
//                break;
//            case '0':
//                if (i >= 0) retstr = str.substr(i--, 1) + retstr;
//                else retstr = '0' + retstr;
//                break;
//            case ',':
//                comma = true;
//                retstr = ',' + retstr;
//                break;
//        }
//    }
//    if (i >= 0) {
//        if (comma) {
//            var l = str.length;
//            for (; i >= 0; i--) {
//                retstr = str.substr(i, 1) + retstr;
//                if (i > 0 && ((l - i) % 3) == 0) retstr = ',' + retstr;
//            }
//        }
//        else retstr = str.substr(0, i + 1) + retstr;
//    }
//
//    retstr = retstr + '.';
//    // 处理小数部分   
//    str = strarr.length > 1 ? strarr[1] : '';
//    fmt = fmtarr.length > 1 ? fmtarr[1] : '';
//    i = 0;
//    for (var f = 0; f < fmt.length; f++) {
//        switch (fmt.substr(f, 1)) {
//            case '#':
//                if (i < str.length) retstr += str.substr(i++, 1);
//                break;
//            case '0':
//                if (i < str.length) retstr += str.substr(i++, 1);
//                else retstr += '0';
//                break;
//        }
//    }
//    return retstr.replace(/^,+/, '').replace(/\.$/, '');
//}

//取{}中间的数据，如{quantity}*{price}，返回quantity,price数组
function splitFields(str) {
    var r = "^";
    var reg = ".*?\\{(.*?)\\}";
    for (var i = 0; i < str.match(/\{/g).length; i++) {
        r += reg;
    }
    r += ".*$";
    reg = new RegExp(r);
    var m = reg.exec(str);
    return m;
}

// 保留几位小数
function ToFixed(value, digits) {
    var str = value.toString();
    var index = str.indexOf(".");
    var strInt = str;
    var strDec = "";

    if (index > 0) {
        strInt = str.substr(0, index);
        strDec = str.substr(index + 1, digits);
    }
    while (strDec.length < digits) {
        strDec += "0";
    }
    var integer = strInt + strDec;
    if (index > 0) {
        var nums = new Array();
        var dec = str.substr(index + 1 + digits);//取舍小数部分
        for (var i = 0; i < dec.length; i++) {
            nums.push(dec.charAt(i));//拆分每个数字
        }
        var n1;
        var n2;
        while (nums.length > 1) {
            n1 = nums.pop();
            if (n1 > 4) {
                n2 = nums[nums.length - 1] + 1;
                nums[nums.length - 1] = n2;
            }

        }
        if (nums.length && nums[nums.length - 1] > 4)
            integer++;

    }
    str = integer.toString();
    if (digits == 0)
        return str;
    while (str.length < strInt.length + strDec.length) {
        str = "0" + str;
    }
    return str.substr(0, str.length - digits) + "." + str.substr(str.length - digits);
}

function request(paras) {
    var url = location.href;
    var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
    var paraObj = {}
    for (i = 0; j = paraString[i]; i++) {
        paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
    }
    var returnValue = "";
    try {
        returnValue = decodeURI(paraObj[paras.toLowerCase()]);
    } catch (e) {
        returnValue = unescape(paraObj[paras.toLowerCase()]);
    } if (typeof (returnValue) === "undefined") {
        return "";
    } else {
        return returnValue;
    }
}

function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window)
        return true;
    else
        return false;
}


//Edge浏览器判断
function IsEdge() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isEdge = userAgent.indexOf("Edge") > -1; //判断是否IE的Edge浏览器
    if (isEdge)
        return true;
    else
        return false;
}

//Firefox浏览器判断
function IsFirefox() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isFirefox = userAgent.indexOf("Firefox") > -1; //判断是否是Firefox浏览器
    if (isFirefox)
        return true;
    else
        return false;
}

function isAndroid() {
    if (navigator.userAgent.indexOf("Android") > 0)
        return true;
    else
        return false;
}

function isIphone() {
    if (navigator.userAgent.indexOf("iPhone") > 0)
        return true;
    else
        return false;
}

function isMQQ() {
    if (navigator.userAgent.indexOf("MQQBrowser") > 0)
        return true;
    else
        return false;
}

function isWeixin() {
    if (navigator.userAgent.indexOf("MicroMessenger") > 0)
        return true;
    else
        return false;
}

function closeWinAfterSubmit() {
    try {
        if (isMQQ() || isWeixin()) {
            if (request("type").toLowerCase() === "newrequest") {
                location.href = "../../../Portal/Ultimus.UWF.Home.V3/NewTaskList.aspx";
            }
            if (request("type").toLowerCase() === "mytask") {
                location.href = "../../../Portal/Ultimus.UWF.Home.V3/MyTaskList.aspx";
            }
        }
        else {
            window.opener = null;
            window.open('', '_self');
            window.close();
        }
    }
    catch (e) {
        alert(e);
    }
}

function closeWin() {
    try {
        if (isMQQ() || isWeixin()) {
            history.go(-1);
        }
        else {
            window.opener = null;
            window.open('', '_self');
            window.close();
        }
    }
    catch (e) {
        alert(e);
    }
    //return false;
}

String.prototype.replaceAll = function (s1, s2) {
    return this.replace(new RegExp(s1, "gm"), s2);
};

//页面加载
$(document).ready(function () {
    //设置分页按钮大小
    $(".asppager a").addClass("btn btn-small");
    $(".asppager i").parent().removeClass("btn-small");
    //设置只读控件
    $(".ReadOnly").attr("readonly", "readonly");//设为不可用
    //$(".ReadOnly").css("background-color", "#f5f5f5");
    //设置H5控件
    InitDateControls();

    //设置验证提示框位置
    var wo = 'bottomLeft';
    $('input').attr('data-prompt-position', wo);
    $('input').data('promptPosition', wo);
    $('textarea').attr('data-prompt-position', wo);
    $('textarea').data('promptPosition', wo);
    $('select').attr('data-prompt-position', wo);
    $('select').data('promptPosition', wo);
});

function changetType(selector, targetType) {
    $(selector)[0].type = "password";
}

function validateCheckbox(field, rules, i, options) {
    var groupname = field.attr("data-field");
    var groupSize = $(field).find("input[data-field='" + groupname + "']:checked").length;
    if (groupSize < 1) {
        rules.push('required');
    }
}

//判断是否为数字 
function is_numeric(num) {
    var reg = /^\-?([1-9]\d*|0)(\.\d+)?$/;
    if (reg.test(num)) {
        return true;
    } else {
        return false;
    }
}

//转换金额为以两位小数点的货币形式
function GetMoney(n) {
    if (is_numeric(n)) {
        n = Math.round(n * 100) / 100;
        if (n < 0) {
            n = (n - 0.001) + '';
        }
        else {
            n = (n + 0.001) + '';
        }
        return n.substring(0, n.indexOf('.') + 3);
    }
    else {
        return 0.00;
    }
}

// 初始化日期控件
function InitDateControls() {
    if (request("type").toLocaleLowerCase() !== "myrequest") {
        try {
            InitDate();
            InitDateTime();
            InitTime();
        } catch (e) {
            InitDate();
            InitDateTime();
            InitTime();
        }
    }
}

var layLang = "en";
function InitDate() {
    if (userLang === "zh-CN")
        layLang = "cn";
    $('input[data-type="date"]').each(function () {
        $(this).removeAttr("lay-key");
        laydate.render({
            elem: this
            , theme: '#4b87f5'
            , type: 'date'
            , min: '2000-12-30'// 格式不能变
            , max: '2100-12-30'
            , format: 'yyyy/MM/dd' //可任意组合
            , lang: layLang
        });
    });
}

function InitDateTime() {
    if (userLang === "zh-CN")
        layLang = "cn";
    $('input[data-type="datetime"]').each(function () {
        $(this).removeAttr("lay-key");
        laydate.render({
            elem: this
            , theme: '#4b87f5'
            , type: 'datetime'
            , min: '2000-12-30'
            , max: '2100-12-30'
            , format: 'yyyy/MM/dd HH:mm' //可任意组合
            , lang: layLang
        });
    });
}

function InitTime() {
    if (userLang === "zh-CN")
        layLang = "cn";
    $('input[data-type="time"]').each(function () {
        $(this).removeAttr("lay-key");
        laydate.render({
            elem: this
            , theme: '#4b87f5'
            , type: 'time'
            , min: '2000-12-30'
            , max: '2100-12-30'
            , format: 'HH:mm' //可任意组合
            , lang: layLang
        });
    });
}

// 转换html代码
function FilterHtmls(str) {
    str = str.replace(new RegExp("<", 'g'), "&lt;");
    str = str.replace(new RegExp(">", 'g'), "&gt;");
    return str;
}
// 转换html代码
function FilterTxt(str) {
    str = str.replace(new RegExp("&lt;", 'g'), "<");
    str = str.replace(new RegExp("&gt;", 'g'), ">");
    return str;
}

// 格式化小数
function FormatNum(n, len) {
    if (is_numeric(n)) {
        var step1 = "1";
        var step2 = "0.";
        for (var i = 0; i < len; i++) {// 2
            step1 += "0";// 102
            step2 += "0";// 0.001
        }
        var num = parseInt(step1);
        n = Math.round(n * num) / num;

        step2 = step2 + "1";
        num = parseFloat(step2);
        if (n < 0) {
            n = (n - num) + '';
        }
        else {
            n = (n + num) + '';
        }
        if (len > 0) {
            return n.substring(0, n.indexOf('.') + len + 1);
        }
        return n.substring(0, n.indexOf('.') + len);
    }
    else {
        return 0.00;
    }
};

$(document).ready(function () {
    $(".utcdatetime").each(function (event) {
        //算出时差,并转换为毫秒：
        let offset = new Date().getTimezoneOffset();
        offset = offset + 480;//服务器时间为+8区
        if (offset === 0) {
            return;
        }

        //获取控件的值
        let flag = false;
        let val = $(this).val();
        if (!val) {
            val = $(this).text();
            flag = true;
        }
        let d = new Date(val);

        //计算时间的时间
        offset = offset * 60 * 1000;
        //算出对应的格林位置时间
        var GMTDate = new Date(d - offset);//Wed Apr 20 2016 22:27:02 GMT+0800 (CST)
        //转换成本地时间格式
        var GMTDateInLocalString = GMTDate.format("yyyy/MM/dd hh:mm:ss").toLocaleString();//2016/4/20 下午10:27:02

        if (!flag) {
            if (isNaN(GMTDateInLocalString) && !isNaN(Date.parse(GMTDateInLocalString))) {
                $(this).val(GMTDateInLocalString);
            }
        }
        else {
            if (isNaN(GMTDateInLocalString) && !isNaN(Date.parse(GMTDateInLocalString))) {
                $(this).text(GMTDateInLocalString);
            }

        }

    });

});

Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(),    //day
        "h+": this.getHours(),   //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
        "S": this.getMilliseconds() //millisecond
    };
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
        (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
            RegExp.$1.length == 1 ? o[k] :
                ("00" + o[k]).substr(("" + o[k]).length));
    return format;
};

//}



/*** method **
 *  add / subtract / multiply /divide
 * floatObj.add(0.1, 0.2) >> 0.3
 * floatObj.multiply(19.9, 100) >> 1990
 *
 */
var floatObj = function () {
    /*
     * 判断obj是否为一个整数
     */
    function isInteger(obj) {
        return Math.floor(obj) === obj
    }
    /*
     * 将一个浮点数转成整数，返回整数和倍数。如 3.14 >> 314，倍数是 100
     * @param floatNum {number} 小数
     * @return {object}
     *   {times:100, num: 314}
     */
    function toInteger(floatNum) {
        var ret = { times: 1, num: 0 };
        if (isInteger(floatNum)) {
            ret.num = floatNum;
            return ret;
        }
        var strfi = floatNum + '';
        var dotPos = strfi.indexOf('.');
        var len = strfi.substr(dotPos + 1).length;
        var times = Math.pow(10, len);
        var intNum = Number(floatNum.toString().replace('.', ''));
        ret.times = times;
        ret.num = intNum;
        return ret;
    }
    /*
     * 核心方法，实现加减乘除运算，确保不丢失精度
     * 思路：把小数放大为整数（乘），进行算术运算，再缩小为小数（除）
     *
     * @param a {number} 运算数1
     * @param b {number} 运算数2
     * @param digits {number} 精度，保留的小数点数，比如 2, 即保留为两位小数
     * @param op {string} 运算类型，有加减乘除（add/subtract/multiply/divide）
     *
     */
    function operation(a, b, digits, op) {
        var o1 = toInteger(a);
        var o2 = toInteger(b);
        var n1 = o1.num;
        var n2 = o2.num;
        var t1 = o1.times;
        var t2 = o2.times;
        var max = t1 > t2 ? t1 : t2;
        var result = null;
        switch (op) {
            case 'add':
                if (t1 === t2) { // 两个小数位数相同
                    result = n1 + n2;
                } else if (t1 > t2) { // o1 小数位 大于 o2
                    result = n1 + n2 * (t1 / t2);
                } else { // o1 小数位 小于 o2
                    result = n1 * (t2 / t1) + n2;
                }
                return result / max;
            case 'subtract':
                if (t1 === t2) {
                    result = n1 - n2;
                } else if (t1 > t2) {
                    result = n1 - n2 * (t1 / t2);
                } else {
                    result = n1 * (t2 / t1) - n2;
                }
                return result / max;
            case 'multiply':
                result = (n1 * n2) / (t1 * t2);
                return result;
            case 'divide':
                result = (n1 / n2) * (t2 / t1);
                return result;
        }
    }
    // 加减乘除的四个接口
    function add(a, b, digits) {
        return operation(a, b, digits, 'add');
    }
    function subtract(a, b, digits) {
        return operation(a, b, digits, 'subtract');
    }
    function multiply(a, b, digits) {
        return operation(a, b, digits, 'multiply');
    }
    function divide(a, b, digits) {
        return operation(a, b, digits, 'divide');
    }
    // exports
    return {
        add: add,
        subtract: subtract,
        multiply: multiply,
        divide: divide
    };

}();

// 表单头部收缩切换
function tabFormTitle(obj) {
    var $btn = $(obj).find(".btn-actions-pane-right").find(".fa-angle")
    // 折叠
    $($(obj).attr("data-target")).on('hidden.bs.collapse', function () {
        $btn.removeClass("fa-chevron-down").removeClass("fa-chevron-left");
        $btn.addClass("fa-chevron-left");
    });
    // 展开
    $($(obj).attr("data-target")).on('shown.bs.collapse', function () {
        $btn.removeClass("fa-chevron-down").removeClass("fa-chevron-left");
        $btn.addClass("fa-chevron-down");
    });
}


// 全选事件
function formBatchSelDe(id) {
    var iscli = $("#selectall_" + id).is(":checked");
    if (iscli) {
        $("#" + id + " tbody tr").find("input[id$=sel]").prop("checked", true);
        $("#btnRemove_" + id).show();
    } else {
        $("#" + id + " tbody tr").find("input[id$=sel]").prop("checked", false);
        $("#btnRemove_" + id).hide();
    }
}

// 明细行单选控制
function formBatchOneSelDe(obj) {
    var $table = $(obj).parents("table");
    var id = $table[0].id;
    if ($table.find("tbody .ch_Batch_" + id + ":checked").length === $table.find("tbody .ch_Batch_" + id + "").length) {
        $("#selectall_" + id).prop("checked", true);
    } else {
        $("#selectall_" + id).prop("checked", false);
    }

    if ($table.find("tbody .ch_Batch_" + id + ":checked").length > 0) {
        $("#btnRemove_" + id).show();
    } else {
        $("#btnRemove_" + id).hide();
    }
}

// 批量删除事件
function formBatchDelete(id) {
    var res = true;
    $("#" + id + " span[groupname=\"sel\"]").each(function () {
        var $tr = $(this).parents("tr");
        if ($(this).children().prop("checked")) {
            if (res && !confirm('您是否要删除?？'))
                return false;
            res = false;
            deleteRow(id, $tr.find(".th_Action").find("a"));
        }
    });
}