
$(function () {
    if (IsChrome()) {
        $("input[data-type=number]").each(function () {
            $(this).unbind("keyup");
            $(this).keypress(function (e) {
                if (!String.fromCharCode(e.keyCode).match(/[0-9\.]/)) {
                    return false;
                }
            });
            //if ($(this).attr("data-field") == "EXCHANGERATE") {
            //    $(this).attr("step", "0.0001");
            //} else {
            //    $(this).attr("step", "0.01");
            //}

            if (this.id.indexOf('fld_EXCHANGERATE') < 0) {
                $(this).attr("step", "0.01");
            } else {
                $(this).attr("step", "0.000001");
            }
        });
    }
    //自定义表单样式
    SetLabelPosition();
    //获取编辑器，初始化编辑器
    $("[input-type=wangEditor]").each(function (i) {
        Geteditor($(this)[i].id);
        $("#" + $(this).parent().attr("id") + "").css("display", "");
    });

    // 设置文本域高度
    $("textarea[input-type=textarea]").each(function () {
        var field = this.id.split("_")[1].toUpperCase();
        //$("#fld_" + field).css("resize", "none");
        //$("#div_field_" + field).children(".form-label").css("height", $("#div_fieldx_" + field).children(".form-field").innerHeight());
    });
    if (!IsPC()) {
        $("div[id*=div_field_NULL]").hide();
    }

})
function onlyNumber(obj) {
    //得到第一个字符是否为负号
    var t = obj.value.charAt(0);
    //先把非数字的都替换掉，除了数字和. 
    obj.value = obj.value.replace(/[^\d\.]/g, '');
    //必须保证第一个为数字而不是. 
    obj.value = obj.value.replace(/^\./g, '');
    //保证只有出现一个.而没有多个. 
    obj.value = obj.value.replace(/\.{2,}/g, '.');
    //保证.只出现一次，而不能出现两次以上 
    obj.value = obj.value.replace('.', '$#$').replace(/\./g, '').replace(
        '$#$', '.');
}

//js 中 filter函数在IE浏览器不兼容解决
Array.prototype.myfilter = function (fun /*, thisp*/) {
    var len = this.length;
    if (typeof fun != "function") {
        throw new TypeError();
    }
    var res = new Array();
    var thisp = arguments[1];
    for (var i = 0; i < len; i++) {
        if (i in this) {
            var val = this[i]; // in case fun mutates this  
            if (fun.call(thisp, val, i, this)) {
                res.push(val);
            }
        }
    }
    return res;
};
//ue.addListener('ready', function () {
//    if (request("Type").toLocaleLowerCase() == "myrequest") {
//        ue.setDisabled();
//    }
//});

//var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
//var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
//var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
//var isEdge = userAgent.indexOf("Edge") > -1; //判断是否IE的Edge浏览器
//var isFF = userAgent.indexOf("Firefox") > -1; //判断是否Firefox浏览器
//var isSafari = userAgent.indexOf("Safari") > -1 && userAgent.indexOf("Chrome") == -1; //判断是否Safari浏览器
//var isChrome = userAgent.indexOf("Chrome") > -1 && userAgent.indexOf("Safari") > -1; //判断Chrome浏览器
//Chrome浏览器判断
function IsChrome() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isChrome = userAgent.indexOf("Chrome") > -1 && userAgent.indexOf("Safari") > -1; //判断Chrome浏览器
    if (isChrome)
        return true;
    else
        return false;
}

//判断是否是PC端
function IsPC() {
    //判断是否是PC端
    var isPC = navigator.userAgent.indexOf("Windows") > -1;
    if (isPC)
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

//IE浏览器判断
function IsIE() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
    if (isIE)
        return true;
    else
        return false;
}

/// <summary>
/// 设置下拉框的Name值
/// </summary>
/// <param name="obj"> 隐藏控件的对象 </param>
function setddlName(obj) {
    $("#" + obj.id + "_NAME").val($(obj).find("option:selected").text());
}

/// <summary>
/// 设置下拉框联动
/// </summary>
/// <param name="obj"> 当前对象 </param>
/// <param name="id"> 联动对象 </param>
/// <param name="type"> 当前对象数据源Type </param>
function setddlLinkAge(obj, id, type) {
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "GetDropLinkAgeData";
    $.ajax({
        url: url,
        type: "POST",
        async: false,
        dataType: "json",
        data: { Method: method, type: type, value: $(obj).val() },
        success: function (data) {
            if (data != null && data != "") {
                $("#" + id).empty();
                $("#" + id).append("<option value=''></option>");
                var objs = eval(data);
                for (var i = 0; i < objs.length; i++) {
                    $("#" + id).append("<option value='" + objs[i].VALUE + "'>" + objs[i].NAME + "</option>");
                }
            }
        }
    });
}

/// <summary>
/// 获取下拉框的拓展数据
/// </summary>
/// <param name="obj"> 当前对象 </param>
/// <param name="type"> 当前对象数据源Type </param>
/// <param name="parm"> 需要返回的拓展字段数组对象 </param>  '[{\\'fld_DESCRIPTION\\':\\'REMARK\\'}]'
function GetDropEXTData(obj, type, parm) {
    $("#" + obj.id + "_NAME").val($(obj).find("option:selected").text());
    if (parm != "")
        parm = eval(parm);
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "GetDropEXTData";
    $.ajax({
        url: url,
        type: "POST",
        async: false,
        dataType: "json",
        data: { Method: method, type: type, value: $(obj).val() },
        success: function (data) {
            if (data != null && data != "") {
                var objs = eval(data);
                if (parm != "" && parm != null && typeof (parm) != undefined) {
                    $.each(parm, function (key, value) {
                        $("#" + value.ID).val(eval("objs[0]." + value.COLUMN));
                    })
                }
            }
        }
    });
}


/// <summary>
/// 隐藏控件，追加span标签
/// </summary>
/// <param name="obj"> 隐藏控件的对象 </param>
function HidInputAddSpan(obj) {
    $(obj).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(obj).css("width") + ";text-align:center;\">" + $(obj).val() + "</span>");
    $(obj).hide();
}

/// <summary>
/// 绑定下拉框span值
/// </summary>
/// <param name="obj"> 隐藏控件的对象 </param>
function SetDropSpan(tableName, formId, rowId, obj) {
    var field = "";
    if (rowId == "") {
        field = obj[0].id.split("_")[1];
    } else {
        field = obj[0].id.split("_fld_")[1];
    }
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "GetDropValue";

    $.ajax({
        url: url,
        type: "POST",
        async: true,
        dataType: "html",
        data: { Method: method, tableName: tableName, formId: formId, rowId: rowId, field: field },
        success: function (msg) {
            if (msg != null && msg != "") {
                $(obj).next("span").text(msg);
            }
        }
    });
}

/// <summary>
/// 传入单号打开相应发起页面
/// </summary>
/// <param name="obj"> 当前对象 </param>
/// <param name="tablename"> 表名 </param>
function OpenFormid(obj, tablename) {
    var Document = $(obj).html();

    if (obj.nodeName == "INPUT")
        Document = $(obj).val();

    if (Document != "" && tablename != "") {
        var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
        //var head = Document.match(/^[a-z|A-Z]+/gi);
        var method = "OpenForm";
        $.ajaxSetup({ async: false });
        $.post(url, { Method: method, Doc: Document, Table: tablename }, function (data) {
            if (data != null && data != "") {
                var objs = eval(data);
                objReport.openForm(objs[0].FORMID, objs[0].PROCESSNAME, objs[0].INCIDENT);
                return false;
            }
        });
    }
}

/// <summary>
/// 传入单号打开相应发起页面
/// </summary>
function OpenContractNo(ContractNo) {
    if (ContractNo != "") {
        var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
        var method = "OpenContract";
        $.ajaxSetup({ async: false });
        $.post(url, { Method: method, ContractNo: ContractNo }, function (data) {
            if (data != null && data != "") {
                var objs = eval(data);
                objReport.openForm(objs[0].FORMID, objs[0].PROCESSNAME, objs[0].INCIDENT);
                return false;
            }
        });
    }
}

/// <summary>
/// 防止文本框点击出负数
/// </summary>
/// <param name="obj"> 当前对象 </param>
function Fun_OnclickAmount(obj) {
    var EstimatedAmount = $(obj).val();
    if ($(obj).val() < 0) {
        $(obj).val("");
    }
}


/// <summary>
/// 输入时，数值保留两位小数（若有特殊控制，按照json配置）
/// </summary>
/// <param name="obj"> 
//var obj = [{ id: 'fld_EXCHANGERATE', ToFixed: '', format: 'false' }, { id: 'fld_T003TB003', ToFixed: '1', format: 'true' }];
///id：字段ID；ToFixed：保留小数位；format：是否格式化，true需要false不需要 </param>
function Fun_OnblurToFixed(obj) {
    debugger
    $("input[data-type=number]").each(function () {
        if (obj != '' && obj != undefined) {
            var objs = eval(obj);
            for (var i = 0; i < objs.length; i++) {
                if ($(this).val().trim() != "" && $(this).val().trim() >= 0) {
                    if (objs[i].format == "true" && this.id.indexOf(objs[i].id) >= 0 && objs[i].ToFixed != "") {
                        $(this).val(FormatNum($(this).val().trim(), parseInt(objs[i].ToFixed)));
                    } else {
                        $(this).val(FormatNum($(this).val().trim(), 2));
                    }
                } else if ($(this).val().trim() < 0) {
                    if (objs[i].format == "true" && this.id.indexOf(objs[i].id) >= 0 && objs[i].ToFixed != "") {
                        $(this).val(FormatNum(Math.abs($(this).val().trim()), parseInt(objs[i].ToFixed)));
                    } else {
                        $(this).val(FormatNum(Math.abs($(this).val().trim()), 2));
                    }
                } else {
                    $(this).val("");
                }
            }
        } else {
            if ($(this).val().trim() != "" && $(this).val().trim() >= 0) {
                $(this).val(FormatNum($(this).val().trim(), 2));
            } else if ($(this).val().trim() < 0) {
                $(this).val($(this).val().trim(), 2);
            } else {
                $(this).val("");
            }
        }
    });
}

/// <summary>
/// 表单追加千分位，我的申请直接调用
/// var obj = [{ id: 'fld_EXCHANGERATE',format: 'false' }, { id: 'fld_T003TB003',format: 'true' }];
/// id：字段ID；format：是否格式化，true需要false不需要
/// </summary>
function Fun_FormatAutonumber(obj) {
    $("input[data-type=number]").each(function () {
        if ($(this).val() != "" && $(this).val() >= 0) {
            if (obj != '' && obj != undefined) {
                var objs = eval(obj);
                for (var i = 0; i < objs.length; i++) {
                    if (objs[i].format == "true" && this.id.indexOf(objs[i].id) >= 0) {
                        $(this).addClass("autonumber");
                        $(this).next('span').addClass("autonumber");
                        $(this).next('span').next('span').addClass("autonumber");
                        formatAutonumber();
                    }
                }
            } else {
                $(this).addClass("autonumber");
                $(this).next('span').addClass("autonumber");
                $(this).next('span').next('span').addClass("autonumber");
                formatAutonumber();
            }
        }
    });
}

function SetMainInfo(data) {
    if (data != null && data != "") {
        var json = JSON.parse(data);
        for (var i = 0; i < json.length; i++) {
            for (var key in json[i]) {
                if ($("span[data-field='fld_" + key + "']").hasClass("spRadio"))
                    $("input[name='fld_" + key + "'][value='" + json[i][key] + "']").attr("checked", 'checked');
                else if ($("#fld_" + key)[0].nodeName == "INPUT") {
                    // 给文本框赋值
                    $("#fld_" + key).attr("value", json[i][key]);
                    $("#fld_" + key).text(json[i][key]);
                } else if ($("#fld_" + key)[0].nodeName == "SELECT") {
                    $("#fld_" + key).find("option[value='" + json[i][key] + "']").attr("selected", true);
                }
            }
        }
    }
}

/// <summary>
/// 提取主表的值,JSON格式
/// </summary>
function GetDataMainReal(tabId) {
    var tableData = new Array();
    var table = $("#" + tabId + " tbody")[0];
    for (var i = 0; i < table.rows.length; i++) {
        tableData.push(GetMainDataReal(table.rows[i]));
    }
    return JSON.stringify(tableData);
}

/// <summary>
/// 提取主表指定行的数据，JSON格式
/// </summary>
function GetMainDataReal(row) {
    var rowData = {};
    var column = "";
    var namearr = new Array();
    for (var j = 0; j < row.cells.length; j++) {
        for (var k = 0; k < $(row.cells[j]).children().length; k++) {
            if ($(row.cells[j]).children().eq(k).hasClass("input-group"))
                name = $(row.cells[j]).children().children().eq(k).attr("ID");
            else if ($(row.cells[j]).children().eq(k).hasClass("spRadio"))
                name = $(row.cells[j]).children().eq(k).find("input").attr("name");
            else
                name = $(row.cells[j]).children().eq(k).attr("ID");

            if (name != "undefined") {
                if (name.indexOf("fld_") >= 0) {
                    namearr = name.split("fld_");
                }
                if (name.indexOf("read_") >= 0) {
                    if (name.indexOf("_fld_") >= 0) {
                        namearr = name.split("_fld_");
                    } else {
                        namearr = name.split("read_");
                    }
                }

                if (namearr.length == 3)
                    column = namearr[2];
                else if (namearr.length == 2)
                    column = namearr[1];

                if (column) {
                    var value;
                    if ($(row.cells[j]).children().eq(k).hasClass("input-group"))
                        value = $(row.cells[j]).children().children().eq(k).val().trim();
                    else if ($(row.cells[j]).children().eq(k).hasClass("spRadio"))
                        value = $("input[name='" + name + "']:checked").val();
                    else if ($(row.cells[j]).children().eq(k)[0].nodeName == "SPAN")
                        value = $(row.cells[j]).children().eq(k).text().trim();
                    else
                        value = $(row.cells[j]).children().eq(k).val().trim();
                    var tyoe = $(row.cells[j]).children().eq(k).attr("setType");
                    if (value == "undefined") {
                        value = $(row.cells[j]).children().children().val();
                    }
                    if (tyoe != "no") {
                        rowData[column] = value;
                    }
                }
            }

        }

    }
    return rowData;
}

/// <summary>
/// 提取表格的值,JSON格式
/// </summary>
/// <param name="tabId"> 表ID </param>
function GetDataTableReal(tabId) {
    var tableData = new Array();
    var table = $("#" + tabId).find("tbody")[0];
    for (var i = 0; i < table.rows.length; i++) {
        tableData.push(GetRowDataReal(table.rows[i]));
    }
    return JSON.stringify(tableData);
}

/// <summary>
/// 提取指定行的数据，JSON格式
/// </summary>
/// <param name="row"> 行对象 </param>
function GetRowDataReal(row) {
    debugger;
    var rowData = {};
    var namearr = new Array();
    for (var j = 0; j < row.cells.length; j++) {
        for (var k = 0; k < $(row.cells[j]).children().length; k++) {
            name = $(row.cells[j]).children().eq(k).attr("ID");
            if (name != "undefined") {
                if (name.indexOf("_fld_") >= 0) {
                    namearr = name.split("_fld_");
                }
                if (name.indexOf("_read_") >= 0) {
                    namearr = name.split("_read_");
                }
                if (namearr[1]) {
                    var value = $(row.cells[j]).children().eq(k).val().trim();
                    var tyoe = $(row.cells[j]).children().eq(k).attr("setType");
                    if (value == "undefined") {
                        value = $(row.cells[j]).children().children().val();
                    }
                    if (tyoe != "no") {
                        rowData[namearr[1]] = value;
                    }
                }
            }

        }

    }
    //alert("ProductName:" + rowData.ProductName);
    //或者这样：alert("ProductName:" + rowData["ProductName"]);
    return rowData;
}

/// <summary>
/// 仿C# string.format
/// </summary>
String.format = function () {
    if (arguments.length == 0)
        return null;
    var str = arguments[0];
    for (var i = 1; i < arguments.length; i++) {
        var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
        str = str.replace(re, arguments[i]);
    }
    return str;
};

/// <summary>
/// 清除表格中的onblur事件
/// </summary>
function ClearOnblur() {
    //$("input").not("[data-type=number]").each(function () {
    //    $(this).removeAttr("onblur", "checkExpression(this);");
    //});
    $("textarea").each(function () {
        $(this).removeAttr("onblur", "checkExpression(this);");
    });
    $("input").each(function () {
        $(this).removeAttr("onblur", "checkExpression(this);");
    });
    $("select").each(function () {
        $(this).removeAttr("onblur", "checkExpression(this);");
    });
}

/// <summary>
/// 添加明细行滚动条
/// </summary>
/// <param name="tableId"> 表Id </param>
/// <param name="width"> 明细行宽度 </param>
/// <param name="maxWidth"> 明细行最大宽度 </param>
function AddTableScroll(tableId, width, maxWidth) {
    $("#" + tableId).css({ "width": width, "max-width": maxWidth });
    //var he = $("#" + tableId).parent().height();
    //$("#" + tableId).parent().css({ "overflow-x": "scroll", "height": he * 1 + 20 });
    $("#" + tableId).parent().css({ "overflow-x": "scroll" });
}

/// <summary>
/// 设置表单样式
/// </summary>
function SetLabelPosition() {
    //文本描述靠右显示
    //$(".form-label").addClass("text-right");
    //内容换行显示
    $(".form-detail-table > tbody > tr > td").css("word-break", "break-all");
    $(".form-ctl").css("word-break", "break-all");
}

/// <summary>
/// 通过币种返回出当前汇率
/// </summary>
/// <param name="obj"> 对象 </param>
/// <param name="Currency"> 币种 </param>
function GetExchangeRate(obj, Currency) {
    if (Currency != null && Currency != "") {
        var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerRepayment.ashx";
        var method = "GetCurrency";
        $.ajaxSetup({ async: false });
        $.post(url, { Method: method, CURRENCY: Currency }, function (data) {
            if (data != null && data != "") {
                var objs = eval(data);
                $(obj).val(FormatNum(objs[0].ExchangeRate, 6));
            } else {
                alert("此币种没有汇率，请联系管理员！");
                $(obj).val("");
            }
        });
    } else {
        $(obj).val("");
    }
}

/// <summary>
/// 给主表单赋值
/// </summary>
/// <param name="obj"> 对象 </param>
/// <param name="arr"> { REQUESTTYPE: false, INCIDENT: false }</param>
function SetTableMain(obj, arr) {
    for (var name in obj) {
        if (arr != "" || arr != undefined || arr != null) {
            if (arr[name] == false)
                continue
        }

        $("[name^='fld']").each(function () {
            var id = $(this).attr("id").split('fld_')[1].toUpperCase();
            if (id.indexOf("_") > 0) {
                var fle_name = $(this).attr("name").split('fld_')[1].toUpperCase();
                if (fle_name == name) {
                    $("input[name='fld_" + fle_name + "'][value='" + obj[name] + "']").attr("checked", true);
                }
            } else {
                if (id == name) {
                    $("#fld_" + id).val(obj[name]);
                }
            }
        });
    }
}

/// <summary>
/// 给明细行赋值
/// </summary>
/// <obj>JSON对象</obj>
/// <param name="rpId"> Repeater的Id </param>
/// <param name="tbId"> Table的Id </param>
function SetTableDetail(obj, rpId, tbId) {
    if (obj != undefined) {
        var tr1 = $("#" + tbId + " tr:eq(1)").html();// 取第一行为模板
        $("#" + tbId + " tr").not(":first").remove();

        var tr = "";
        for (var i = 0; i < obj.length; i++) {
            var num = "";
            var $html = $("<tr>" + tr1 + "</tr>");

            // 排序
            $html.find("div[class='index']").html(i + 1);

            $html.find("[id^='" + rpId + "']").each(function () {
                var fldName = $(this).attr("name");
                var columns = fldName.split("fld_")[2];
                var id = "";

                if (i.toString().length == 1) {
                    num = "ctl0" + i;
                    id = rpId + "_" + num + "_fld_" + columns;
                    $(this).attr("id", id);
                    $(this).attr("name", rpId + "$" + num + "$fld_" + columns);
                } else if (i.toString().length >= 2) {
                    num = "ctl" + i;
                    id = rpId + "_" + num + "_fld_" + columns;
                    $(this).attr("id", id);
                    $(this).attr("name", rpId + "$" + num + "$fld_" + columns);
                }

                // 给每列赋值
                for (var name in obj[i]) {
                    if (columns == name) {
                        if ($html.find("#" + id)[0].nodeName == "INPUT") {
                            // 给文本框赋值
                            $html.find("#" + id).attr("value", obj[i][name]);
                        } else if ($html.find("#" + id)[0].nodeName == "SELECT") {
                            // 给下拉框赋值
                            $html.find("#" + id).find("option[value='" + obj[i][name] + "']").attr("selected", true);
                        }

                    };
                }
            })

            tr += "<tr>" + $html.html() + "</tr>";
        }
        $("#" + tbId + " tbody").html(tr);
    }
}

/// <summary>
/// 验证日期大小
/// </summary>
/// <param name="start"> 开始时间 </param>
/// <param name="end"> 结束时间 </param>
function CheckDataSize(startTime, endTime) {
    var start = new Date(startTime.replace("-", "/").replace("-", "/"));
    var end = new Date(endTime.replace("-", "/").replace("-", "/"));
    if (end < start) {
        return false;
    }
    return true;
}

/// <summary>
/// 验证最小日期
/// </summary>
function CheckMinData(time) {
    var time = time.replace("-", "/").replace("-", "/");
    var data = time.split("/")[0];
    if (parseInt(data) < 100) {
        return false;
    }

    var start = new Date("1753/01/01");
    var end = new Date(time);
    if (start > end) {
        return false;
    }
    return true;
}

/// <summary>
/// 判断输入框中输入的日期格式为yyyy/mm/dd和正确的日期
/// 并且天数不能超过当月最大天数
/// </summary>
function IsDate(strDate) {
    var reg = /^(\d{4})\/(\d{2})\/(\d{2})$/;
    var str = strDate;
    if (str == "") return true;
    if (!reg.test(str)) return false;

    // 获取当月总天数
    var num = getDaysByMonth(strDate.split("/")[0], strDate.split("/")[1]);
    if (parseInt(strDate.split("/")[2]) > parseInt(num)) return false;

    return true;
}

/// <summary>
/// 判断输入框中输入的日期格式为yyyy-MM-dd hh:mm
/// </summary>
function IsDateTime(strDate) {
    var reg = /^\d{4}(\-|\/|.)\d{1,2}\1\d{1,2}\s+([0-1][0-9]|[2][0-3])(:)([0-5][0-9])$/g;
    var str = strDate;
    if (str == "") return true;
    if (!reg.test(str)) {
        return false;
    }
    return true;
}

/// <summary>
/// 获取当月总天数
/// </summary>
function getDaysByMonth(year, month) {
    month = parseInt(month, 10) + 1;
    var d = new Date(year + "/" + month + "/0");
    return d.getDate();
}

/// <summary>
/// 消息提示框
/// </summary>
/// <param name="title"> 弹出框标题 </param>
/// <param name="text"> 提示信息 </param>
function showDialogAlert(title, text) {
    BootstrapDialog.show({
        title: title,
        message: text,
        animate: false
    });
}

/// <summary>
/// Confirm确认消息提示框
/// </summary>
/// <param name="title"> 弹出框标题 </param>
/// <param name="msg"> 提示信息 </param>
/// <param name="callback"> 传递方法，方法名 </param>
function showDialogConfirm(title, msg, callback) {
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() == "zh-cn") {
            title1 = "提示信息！";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Prompt Message!";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Prompt Message!";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }
    BootstrapDialog.show({
        title: title1,
        message: msg,
        animate: false,
        buttons: [{
            label: Confirm,
            cssClass: 'btn-default',
            action: function (dialog) {
                callback();
                dialog.close();
            }
        }, {
            label: Cancel,
            cssClass: 'btn-icon',
            action: function (dialog) {
                dialog.close();
            }
        }]
    });
}

/// <summary>
/// 自定义弹出框
/// </summary>
/// <param name="obj"> JSON对象，事例如下 </param>
//  var dialog = { title: '比价页面' };
//  var iframe = { id: 'frameWindow', src: '"' + url + '"', height: '200px' };
//  var buttons = { num: btnNum, method: 'returnPage("' + url + '")',pageFn:"pageFn()" };
//  var dia = { dialog: dialog, iframe: iframe, buttons: buttons };
//  showDialog(dia);
function showDialog(obj) {
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() === "zh-cn") {
            title1 = "数据源";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Data Source";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Data Source";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }
    title = obj.dialog.title == undefined ? title1 : obj.dialog.title;
    iframeId = obj.iframe.id == undefined ? "frmWindow" : obj.iframe.id;
    iframeSrc = obj.iframe.src;
    iframeHeight = obj.iframe.height == undefined ? "440px" : obj.iframe.height;
    iframeWidth = obj.iframe.width == undefined ? "100%" : obj.iframe.width;
    iframeScroll = obj.iframe.scrolling == undefined ? "no" : obj.iframe.scrolling;
    btnOK = obj.buttons.btnOK == undefined ? Confirm : obj.buttons.btnOK;
    btnClose = obj.buttons.btnClose == undefined ? Cancel : obj.buttons.btnClose;
    btnMethod = obj.buttons.method == undefined ? "" : obj.buttons.method;
    btnNum = obj.buttons.num == undefined ? 2 : obj.buttons.num;
    if (obj.dialog.size == "Normal") {
        size = BootstrapDialog.SIZE_NORMAL;
    } else if (obj.dialog.size == "Small") {
        size = BootstrapDialog.SIZE_SMALL;
    } else if (obj.dialog.size == "Wide") {
        size = BootstrapDialog.SIZE_WIDE;
    } else if (obj.dialog.size == "Large") {
        size = BootstrapDialog.SIZE_LARGE;
    } else {
        size = BootstrapDialog.SIZE_WIDE;
    }

    var btns;
    if (btnNum == 2) {
        btns = [{
            label: btnOK,
            action: function (dialog) {//给当前按钮添加点击事件
                var res = true;
                var fn = "document.getElementById('" + iframeId + "').contentWindow." + btnMethod;
                if (btnMethod != "") {
                    if (eval(fn)) {
                        dialog.close();
                    }
                }
                //if (btnMethod != "") {
                //    res = eval(pageFn);
                //}
                //if (res) {
                //dialog.close();
                //}
            }
        }, {
            label: btnClose,
            cssClass: "btn-primary", //给按钮添加类名  可以通过此方式给按钮添加样式
            action: function (dialog) {   //给当前按钮添加点击事件
                dialog.close();
            }
        }];
    } else {
        btns = [{
            label: btnClose,
            cssClass: "btn-primary", //给按钮添加类名  可以通过此方式给按钮添加样式
            action: function (dialog) {   //给当前按钮添加点击事件
                dialog.close();
            }
        }];
    }
    var message = $('<iframe id="' + iframeId + '" src=' + iframeSrc + ' width="100%" height=' + iframeHeight
        + ' scrolling="' + iframeScroll + '" frameborder="no" style="border-width:0px;"></iframe>');

    BootstrapDialog.show({
        title: title,
        size: size,
        animate: false,
        message: message,
        buttons: btns
    });
}



/// <summary>
/// 创建合计表格
/// </summary>
///1、表格名称 2、行数 3、列数
function CreateTable(tableid, row, column) {
    var create = "<table id=\"" + tableid + "Amount\">";
    for (var i = 0; i < row; i++) {
        create += "      <tr>";
        for (var j = 0; j < column; j++) {
            create += "      <td>";
            create += "      </td>";
        }
        create += "      </tr>";
    }
    create += "  </table>";

    $("#" + tableid).next("div").html(create);
}

/// <summary>
/// 创建合计表格
/// </summary>
///1、表格名称 2、行数 3、列数
function AddTableCount(tableid) {
    var $lastTr = $("<tr>" + $("#" + tableid + " tr:last").html() + "</tr>");
    $lastTr.find("td").each(function () {
        $(this).html("");
    });
    var tr = "<tr id=\"" + tableid + "_Tr_Count\">" + $lastTr.html() + "</tr>";
    $("#" + tableid + " tbody").append(tr.trim());
}

/// <summary>
/// 删除表单中报错形成的红色DIV
/// </summary>
function ClearErrorDiv() {
    $(".formError").each(function () {
        $(this).remove();
    })
}

/// <summary>
/// 防止误差计算  1\含税金额 2\税额 3\不含税额
/// </summary>
function compute(obj) {
    var NoTaxAmount = $(obj).parent().parent().find("input[id*=fld_NOTAXAMOUNT]");
    var TaxAmount = $(obj).parent().parent().find("input[id*=fld_TAXAMOUNT]");
    var TaxRate = $(obj).parent().parent().find("select[id*=fld_TAXRATE]");
    var AllAmount = $(obj).parent().parent().find("input[id*=fld_AMOUNT]");

    if ($(TaxRate).val() != "") {
        $(NoTaxAmount).val(GetMoney(GetMoney($(AllAmount).val()) / GetMoney(parseInt(1) + parseFloat(GetMoney($(TaxRate).val())))));
        $(TaxAmount).val(GetMoney(GetMoney($(AllAmount).val()) - GetMoney($(NoTaxAmount).val())));
    } else {
        $(NoTaxAmount).val(0);
        $(TaxAmount).val(0);
    }
}
/// <summary>
/// 计算税金
/// </summary>
function TaxAmount(obj) {
    var AllAmount = $(obj).parent().parent().find("input[id*=fld_AMOUNT]");
    var TaxAmount = $(obj).parent().parent().find("input[id*=fld_TAXAMOUNT]");
    var NoTaxAmount = $(obj).parent().parent().find("input[id*=fld_NOTAXAMOUNT]");

    NoTaxAmount.val($(AllAmount).val() - $(TaxAmount).val());
}

/// <summary>
/// 计算不包含税金
/// </summary>
function NoTaxAmount(obj) {
    var AllAmount = $(obj).parent().parent().find("input[id*=fld_AMOUNT]");
    var TaxAmount = $(obj).parent().parent().find("input[id*=fld_TAXAMOUNT]");
    var NoTaxAmount = $(obj).parent().parent().find("input[id*=fld_NOTAXAMOUNT]");

    TaxAmount.val($(AllAmount).val() - $(NoTaxAmount).val());
}

/// <summary>
/// 获取子流程状态
/// </summary>
function CheckChildrenProcessStatus(tableName, formId) {
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "CheckChildrenProcessStatus";
    var obj;
    $.ajax({
        url: url,
        type: "POST",
        async: false,
        dataType: "json",
        data: { Method: method, tableName: tableName, formId: formId },
        success: function (data) {
            obj = { status: data.status, msg: data.msg };
        }
    });
    return obj;
}

/// <summary>
/// 检查是否上传附件
/// </summary>
function CheckFile() {
    //上传附件表格的行数
    if ($("#fileinfo tr").size() > 0) {
        return true;
    } else {
        alert("请上传附件!\nPlease upload attachment!");
        return false;
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


//生成GUID
function guid() {
    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
}
function S4() {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

/// <summary>
/// 截取字符串长度,并设置Title
/// </summary>
/// <param name="id"> 主Id </param>
/// <param name="divId"> 当前控件最外层Div的id </param>
/// <param name="setHightId"> 获取高度的id </param>
function CutSetTitle(id, divId, setHightId) {
    var val = $("#" + id).parent().find("span").text();
    $("#" + id).parent().find("span").attr("title", val);
    $("#" + id).parent().find("span").text(val.substring(0, 25) + "...");
    $("#" + divId).find(".form-label").height($("#" + setHightId).find(".form-label").height());
}

/// <summary>
/// 删除明细行行数据
/// </summary>
/// <param name="$tr"> 行Jquery对象 </param>
function DeleteDetailsRow($tr) {
    $tr.find("input[type='text']").each(function () {
        $(this).val("");
    })
}

/// <summary>
/// 删除所有明细行行数据
/// </summary>
/// <param name="tabId"> table ID </param>
function deleteAllRow(tabId) {
    $("#" + tabId).find("tr").not(":first").each(function () {
        deleteRow(tabId, $(this).find("td:last a").get(0), false);
    })
}

/// <summary>
/// 生成编辑器
/// </summary>
/// <param name="id"> 编辑器ID </param>
/// <param name="nodeName"> id 前缀 </param>
function Geteditor(id) {
    ue = UE.getEditor(id, {
        "imagePathFormat": "/image/{yyyy}{mm}{dd}/{time}{rand:6}_{filename}",
        "imageUrlPrefix": "D:\DingXin\SrcDicos3.0",
        wordCount: false,
        elementPathEnabled: false,
        autoHeightEnabled: true,
        contextMenu: [],
        toolbars: [
            [
                'source', //源代码
                'anchor', //锚点
                'undo', //撤销
                'redo', //重做
                'bold', //加粗
                'indent', //首行缩进
                'italic', //斜体
                'underline', //下划线
                'strikethrough', //删除线
                'subscript', //下标
                'fontborder', //字符边框
                'superscript', //上标
                'formatmatch', //格式刷
                'blockquote', //引用
                'pasteplain', //纯文本粘贴模式
                'selectall', //全选
                'horizontal', //分隔线
                'removeformat', //清除格式
                'insertrow', //前插入行
                'insertcol', //前插入列
                'mergeright', //右合并单元格
                'mergedown', //下合并单元格
                'deleterow', //删除行
                'deletecol', //删除列
                'splittorows', //拆分成行
                'splittocols', //拆分成列
                'splittocells', //完全拆分单元格
                'deletecaption', //删除表格标题
                'inserttitle', //插入标题
                'mergecells', //合并多个单元格
                'deletetable', //删除表格
                'cleardoc', //清空文档
                'insertparagraphbeforetable', //"表格前插入行"
                'fontfamily', //字体
                'fontsize', //字号
                'paragraph', //段落格式
                'simpleupload', //单图上传
                'searchreplace', //查询替换
                'justifyleft', //居左对齐
                'justifyright', //居右对齐
                'justifycenter', //居中对齐
                'justifyjustify', //两端对齐
                'forecolor', //字体颜色
                'backcolor', //背景色
                'insertorderedlist', //有序列表
                'insertunorderedlist', //无序列表
                'rowspacingtop', //段前距
                'rowspacingbottom', //段后距
                'imagenone', //默认
                'imagecenter', //居中
                'lineheight', //行间距
                'customstyle', //自定义标题
                'autotypeset', //自动排版
                'touppercase', //字母大写
                'tolowercase', //字母小写
                'inserttable', //插入表格
            ]
        ]
    });
    ue.addListener('ready', function () {
        if (request("Type").toUpperCase() == "PRINT") {
            $("#" + id).addClass("hidden");
            $("#" + id).parent().append("<div id='remark'>" + $("#" + id).next().val() + "</div>");
            var companywidth = window.screen.width;
            $("#remark table").each(function () {
                width = $(this).css('width');
                width = width.substring(0, width.length - 2);
                if (width > companywidth) {
                    $("#remark table").attr("width", "100%");
                }
            })
            $("#remark img").each(function () {
                width = $(this).width();
                var divwidth = $("#remark").width();
                var imgwidth = parseInt(divwidth) - 500;
                $("#remark img").attr("style", "max-width: 100% !important;  width:expression(this.width > " + divwidth + " ? " + imgwidth + "px : this.width)!important;");

            })
        }
        if (id.substring(0, 1).toUpperCase() == "R" || request("Type").toLocaleLowerCase() == "myrequest") {
            ue.setDisabled();
        }
    });

}

/// <summary>
/// 设置lable高度
/// </summary>
/// <param name="num"> 列数量</param>
/// <param name="idItem"> 最高级DIV 的ID"'div_field_T402TA004_NAME','div_field_T402TA005_NAME','div_field_T402TA006_NAME'"</param>
function SetFormLabelHeight(idItem) {
    var obj = idItem.split(",");
    var high = 0;
    $(obj).each(function (key, value) {
        high = GetMaxNum(high, $("#" + value).height())
    });
    $(obj).each(function (key, value) {
        $("#" + value).children(".form-label").css("height", high);
    });
}

// 获取最大值
function GetMaxNum(oldNum, newNum) {
    if (oldNum > newNum)
        return oldNum;
    else
        return newNum;
}

$(function () {
    setLable();
})

function setLable() {
    $(".form-label").each(function () {
        if ($(this).parent("div").hasClass("hidden")) { }
        else {
            if ($(this).next().find("input[type='checkbox']").length > 0) {
                debugger;
                var height = $(this).next().height();
                $(this).next().height(height);
                $(this).next().parent().height(height + 10);
                $(this).next().find("input[type='checkbox']").css("height", "auto");
                $(this).height(height);
            } else if ($(this).next().find("input[type='radio']").length > 0) {
                var height = $(this).next().find("span").height();
                $(this).next().height(height);
                if (height * 1 <= 36) {
                    height = 36;
                }
                $(this).next().parent().height(height + 9);
                if (!IsPC()) {
                    $(this).next().parent().height(height + 11);
                }
                $(this).next().find("input[type='radio']").css("height", "auto");
                //$(this).height(height);
            }
            else {
                if ($(this).height() < $(this).next().children().height()) {
                    $(this).height($(this).next().height());
                } else {
                    $(this).next().height($(this).height());
                    $(this).parent().height($(this).parent().height());
                }
            }
        }
    })
}

// 初始化控件
function Initialize() {
    $("input[money=money]").each(function () {
        $(this).keyup(function () {
            this.value = this.value.replace(/[^0-9.]/g, '');
        });
    });
    $("input[money=int]").each(function () {
        $(this).keyup(function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });
    $("input[data-type=money]").each(function () {
        $(this).keyup(function () {
            this.value = this.value.replace(/[^0-9.]/g, '');
        });
    });
    $("input[data-type=int]").each(function () {
        $(this).keyup(function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });
    $("input[data-type=number]").each(function () {
        $(this).keyup(function () {
            this.value = this.value.replace(/[^0-9.]/g, '');
        });
    });
}

// 格式化千分位
function formatAutonumber() {
    $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
    $('.autonumber').focus(function () {
        $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
    });
}

// 格式化千分位
function formatSpanAutonumber(id, num) {
    if (id != undefined) {
        if (num == undefined)
            num = 2;

        if ($("#" + id)[0].nodeName == "SPAN")
            $("#" + id).autoNumeric('init', { vMin: '-9999999999999.' + NumericNum(num, "9"), vMax: '9999999999999.' + NumericNum(num, "9") });
        else
            $("#" + id).next().autoNumeric('init', { vMin: '-9999999999999.' + NumericNum(num, "9"), vMax: '9999999999999.' + NumericNum(num, "9") });
    }
}

function NumericNum(len, num) {
    var res = "";
    for (var i = 0; i < len; i++) {
        res += num;
    }
    return res;
}
//格式化日期
//调用方法 Format(date,"yyyy-MM-dd HH:mm");输出格式为 "2015-10-14 16:50"；第一个参数为时间，第二个参数为输出格式
function Format(now, mask) {
    var d = new Date(now);
    var zeroize = function (value, length) {
        if (!length) length = 2;
        value = String(value);
        for (var i = 0, zeros = ''; i < (length - value.length); i++) {
            zeros += '0';
        }
        return zeros + value;
    };

    return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0) {
        switch ($0) {
            case 'd': return d.getDate();
            case 'dd': return zeroize(d.getDate());
            case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
            case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
            case 'M': return d.getMonth() + 1;
            case 'MM': return zeroize(d.getMonth() + 1);
            case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
            case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
            case 'yy': return String(d.getFullYear()).substr(2);
            case 'yyyy': return d.getFullYear();
            case 'h': return d.getHours() % 12 || 12;
            case 'hh': return zeroize(d.getHours() % 12 || 12);
            case 'H': return d.getHours();
            case 'HH': return zeroize(d.getHours());
            case 'm': return d.getMinutes();
            case 'mm': return zeroize(d.getMinutes());
            case 's': return d.getSeconds();
            case 'ss': return zeroize(d.getSeconds());
            case 'l': return zeroize(d.getMilliseconds(), 3);
            case 'L': var m = d.getMilliseconds();
                if (m > 99) m = Math.round(m / 10);
                return zeroize(m);
            case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
            case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
            case 'Z': return d.toUTCString().match(/[A-Z]+$/);
            // Return quoted strings with the surrounding quotes removed
            default: return $0.substr(1, $0.length - 2);
        }
    });
};

function BindLongText() {
    $(".longtext").each(function () {
        $(this).removeAttr("title");
        $(this).attr("title", $(this).text());
        $(this).parent().parent().prev().css("height", "0px");
    });
}


//去除千分位
function Nums(val) {
    var text = val.replace(/[^\d.]/g, "").replace(/^\./g, "").replace(/\.{2,}/g, ".");
    text = text.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".").replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3');
    var strInt = text;
    var strDec = "";
    var index = text.indexOf(".");
    if (text != "" && text != undefined) {
        if (index > 0) {
            strInt = text.substr(0, index);
            strDec = text.substr(index + 1, 1);

            text = strInt + '.' + strDec;
        }
        else {
            text = strInt;
        }
    }
    else {
        text = "0.0";
    }
    return text;
}


//转换千分位  s，值  n，留小数
function fmoney(s, n) {
    n = n > 0 && n <= 20 ? n : 2;
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
    var l = s.split(".")[0].split("").reverse(),
    r = s.split(".")[1];
    t = "";
    for (i = 0; i < l.length; i++) {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    return t.split("").reverse().join("") + "." + r;
}

//是否包含IsExcel
function IsExcel() {
    var flag = false;
    var tr_length = $('#fileinfo tr').length;
    if (tr_length > 0) {
        $('#fileinfo tr').each(function (i, obj) {
            let arom = $(obj).find("td").eq(1).find("a").text().trim();
            if (arom.indexOf(".xls") >= 0 || arom.indexOf(".xlsx") >= 0) {
                flag = true;
            }
        });
    } else {
        flag = false;
    }
    return flag;
}

