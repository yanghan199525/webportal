$(function () {
    if (IsChrome()) {
        $("input[data-type=number]").each(function () {
            $(this).unbind("keyup");
            $(this).keypress(function (e) {
                if (!String.fromCharCode(e.keyCode).match(/[0-9\.]/)) {
                    return false;
                }
            });
            if (this.id.indexOf('fld_EXCHANGERATE') < 0) {
                $(this).attr("step", "0.01");
            } else {
                $(this).attr("step", "0.000001");
            }
        });
    }

    //获取编辑器，初始化编辑器
    $("div[data-type=wangEditor]").each(function (i) {
        var nodeName = document.getElementById($(this).next()[i].id).nodeName == "SPAN" ? "read_" : "fld_";
        Geteditor($(this)[i].id, nodeName);
        if (request("StepName") != "申请人" || request("type").toLocaleLowerCase() == "myrequest") {
            $("div[contenteditable='true']").attr('contenteditable', false);
        }
    });
})

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
    $("#" + id).empty();
    $("#" + id).append("<option value=''></option>");
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
/// 设置地址下拉框联动
/// </summary>
/// <param name="obj"> 当前对象 </param>
/// <param name="id"> 联动对象 </param>
function SitesetddlLinkAge(obj, id) {
    $("#" + id).empty();
    $("#" + id).append("<option value=''></option>");
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "SitesetddlLinkAge";
    $.ajax({
        url: url,
        type: "POST",
        async: false,
        dataType: "json",
        data: { Method: method, value: $(obj).val() },
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
/// 设置地址下拉框联动(多条件)
/// </summary>
/// <param name="obj"> 当前对象 </param>
/// <param name="id"> 联动对象 </param>
/// <param name="type"> 当前对象数据源 </param>
function GetDropLinkAgeDataMultiCondition(obj, id, type, ext10) {
    $("#" + id).empty();
    $("#" + id).append("<option value=''></option>");
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "GetDropLinkAgeDataMultiCondition";
    $.ajax({
        url: url,
        type: "POST",
        async: false,
        dataType: "json",
        data: { Method: method, type: type, value: $(obj).val(), ext10: ext10 },
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
/// 获取下拉框的拓展数据(税率，明细行)
/// </summary>
/// <param name="obj"> 当前对象 </param>
/// <param name="type"> 当前对象数据源Type </param>
/// <param name="parm"> 需要返回的拓展字段数组对象 </param>  '[{\\'id\\':\\'fld_VATRATE_CODE\\',\\'COLUMN\\':\\'CODE\\'}]'
function GetDropEXTDataTax(obj, type, parm) {
    $("#" + obj.id + "_NAME").val($(obj).find("option:selected").text());
    var objary = obj.name.split('$');
    if (parm != "")
        parm = eval(parm);
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "GetDropEXTDataTax";
    $.ajax({
        url: url,
        type: "POST",
        async: false,
        dataType: "json",
        data: { Method: method, type: type, value: $(obj).val(), name: $(obj).find("option:selected").text() },
        success: function (data) {
            if (data != null && data != "") {
                var objs = eval(data);
                if (parm != "" && parm != null && typeof (parm) != undefined) {
                    $.each(parm, function (key, value) {
                        $("#" + objary[0] + "_" + objary[1] + "_" + value.id).val(eval("objs[0]." + value.COLUMN));
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
function Fun_OnclickAmount(obj) {
    var EstimatedAmount = $(obj).val();
    if ($(obj).val() < 0) {
        $(obj).val("");
    }
}

/// <summary>
/// 输入时，数值保留两位小数
/// var obj = [{ id: 'fld_EXCHANGERATE', ToFixed: '', format: 'false' }, { id: 'fld_T003TB003', ToFixed: '1', format: 'true' }];
/// id：字段ID；ToFixed：保留小数位；format：是否格式化，true需要false不需要
/// </summary>
function Fun_OnblurToFixed(obj) {
    $("input[data-type=number]").each(function () {
        if (obj != '' && obj != undefined) {
            var objs = eval(obj);
            for (var i = 0; i < objs.length; i++) {
                if ($(this).val() != "" && $(this).val() >= 0) {
                    if (objs[i].format == "true" && this.id.indexOf(objs[i].id) >= 0 && objs[i].ToFixed != "") {
                        $(this).val(FormatNum($(this).val(), parseInt(objs[i].ToFixed)));
                    } else {
                        $(this).val(FormatNum($(this).val(), 2));
                    }
                } else if ($(this).val() < 0) {
                    if (objs[i].format == "true" && this.id.indexOf(objs[i].id) >= 0 && objs[i].ToFixed != "") {
                        //$(this).val(FormatNum(Math.abs($(this).val()), parseInt(objs[i].ToFixed)));
                        $(this).val(FormatNum($(this).val(), parseInt(objs[i].ToFixed)));
                    } else {
                        //$(this).val(FormatNum(Math.abs($(this).val()), 2));
                        $(this).val(FormatNum($(this).val(), 2));
                    }
                } else {
                    $(this).val("");
                }
            }
        } else {
            if ($(this).val() != "" && $(this).val() >= 0) {
                $(this).val(FormatNum($(this).val(), 2));
            } else if ($(this).val() < 0) {
                //$(this).val(FormatNum(Math.abs($(this).val()), 2));
                $(this).val(FormatNum($(this).val(), 2));

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
                        formatAutonumber();
                    }
                }
            } else {
                //$(this).addClass("autonumber");
                $(this).next('span').addClass("autonumber");
                formatAutonumber();
            }
        }
    });
}

function SetMainInfo(data) {
    if (data != null && data != "") {
        var json = JSON.parse(data);
        for (var key in json[0]) {
            if ($("#fld_" + key)[0].nodeName == "INPUT") {
                // 给文本框赋值
                $("#fld_" + key).attr("value", json[0][key]);
                $("#fld_" + key).text(json[0][key]);
            } else if ($("#fld_" + key)[0].nodeName == "SELECT") {
                $("#fld_" + key).find("option[value='" + json[0][key] + "']").attr("selected", true);
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
    var namearr = new Array();
    for (var j = 0; j < row.cells.length; j++) {
        for (var k = 0; k < $(row.cells[j]).children().length; k++) {
            name = $(row.cells[j]).children().eq(k).attr("ID");
            if (name != "undefined") {
                if (name.indexOf("fld_") >= 0) {
                    namearr = name.split("fld_");
                }
                if (name.indexOf("read_") >= 0) {
                    namearr = name.split("read_");
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
    return rowData;
}

/// <summary>
/// 提取表格的值,JSON格式
/// </summary>
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
function GetRowDataReal(row) {
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
/// 通过币种返回出当前汇率
/// </summary>
/// <param name="obj"> 对象 </param>
/// <param name="Currency"> 币种 </param>
function GetExchangeRate(obj, Currency) {
    if (Currency != null && Currency != "") {
        var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
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
/// 通过币种和公司返回出当前汇率
/// </summary>
/// <param name="obj"> 对象 </param>
/// <param name="Currency"> 币种 </param>
/// <param name="ApplicantName"> 申请人登录账号 </param>
function GetCompanyExchangeRate(obj, Currency, BU) {
    if (Currency != null && Currency != "") {
        var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
        var method = "GetCompanyCurrency";
        $.ajaxSetup({ async: false });
        $.post(url, { Method: method, CURRENCY: Currency, BU: BU }, function (data) {
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
/// 给基础表单赋值
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
        InitDateControls();
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
    title = obj.dialog.title === undefined ? title1 : obj.dialog.title;
    openid = obj.dialog.openid === undefined ? "" : obj.dialog.openid;// 弹出窗打开函数的标识
    iframeSrc = obj.iframe.src;
    iframeHeight = obj.iframe.height === undefined ? "440px" : obj.iframe.height;
    iframeWidth = obj.iframe.width === undefined ? "100%" : obj.iframe.width;
    iframeScroll = obj.iframe.scrolling === undefined ? "no" : obj.iframe.scrolling;
    btnClose = obj.buttons.btnClose === undefined ? Cancel : obj.buttons.btnClose;
    btnOK = obj.buttons.btnOK === undefined ? Confirm : obj.buttons.btnOK;
    btnMethod = obj.buttons.method === undefined ? "" : obj.buttons.method;
    btnNum = obj.buttons.num === undefined ? 2 : obj.buttons.num;
    if (obj.dialog.size === "Normal") {
        size = "xl";
    } else if (obj.dialog.size === "Small") {
        size = "sm";// 最小
    } else if (obj.dialog.size === "Wide") {
        size = "lg";
    } else if (obj.dialog.size === "Large") {
        size = "xl";
    } else {
        size = "xl";// 最大
    }

    // 初始化弹出层
    $('#formModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // 触发事件的按钮  
        var modal = $(this);
        modal.css('top', (parent.document.documentElement.scrollTop - 10));
        modal.removeClass("bd-example-modal-lg").removeClass("bd-example-modal-xl").removeClass("bd-example-modal-sm");
        modal.addClass("bd-example-modal-" + size);
        modal.find(".modal-dialog").removeClass("modal-lg").removeClass("modal-xl").removeClass("modal-sm");
        modal.find(".modal-dialog").addClass("modal-" + size);
        modal.find(".modal-content").removeAttr("style");
        modal.find('.modal-title').text(title);
        modal.find('.modal-body').html('<iframe id="frmWindow" src=' + iframeSrc + ' width="100%" height=' + iframeHeight + ' scrolling="no" frameborder="no" style="border-width:0px;"></iframe>');
        modal.find(".modal-footer .btn-primary").attr("data-dismiss", "modal");
        if (btnNum === 2) {
            modal.find('.modal-footer .btn-light').text(btnClose);
            modal.find('.modal-footer .btn-primary').removeClass("hidden");
            modal.find('.modal-footer .btn-primary').text(btnOK).attr("onclick", "dialogCallback('" + btnMethod + "')");
        } else {
            modal.find('.modal-footer .btn-primary').addClass("hidden");
        }
        if (typeof (OpenBModalFn) === "function") {
            // 调用表单内部方法，自定义设置model
            OpenBModalFn(modal, openid);
        }
    });
    $('#formModal').on('hidden.bs.modal', function (e) {
        $(this).removeData("bs.modal");
        $('#formModal').modal('dispose');
        // do something...
    });
    $("#formModal").modal();
}

function dialogCallback(btnMethod) {
    try {
        var bool;
        if (btnMethod !== "") {
            bool = eval("document.getElementById('frmWindow').contentWindow." + btnMethod);
        }
        if (bool) {
            $('#formModal').modal('toggle');
        }

    } catch (e) {
        console.error(e);
    }
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
/// 生成编辑器
/// </summary>
/// <param name="id"> 编辑器ID </param>
/// <param name="nodeName"> id 前缀 </param>
function Geteditor(id, nodeName) {
    //初始化
    var E = window.wangEditor
    var editor = new E('#' + id);
    //菜单配置
    editor.customConfig.menus = [
        'head',  // 标题
        'bold',  // 粗体
        'fontSize',  // 字号
        'fontName',  // 字体
        'italic',  // 斜体
        'underline',  // 下划线
        'strikeThrough',  // 删除线
        'foreColor',  // 文字颜色
        'backColor',  // 背景颜色
        'link',  // 插入链接
        'list',  // 列表
        'justify',  // 对齐方式
        'quote',  // 引用
        'emoticon',  // 表情
        //'image',  // 插入图片
        'table',  // 表格
        //'video',  // 插入视频
        'code',  // 插入代码
        'undo',  // 撤销
        'redo'  // 重复
    ]
    // 配置服务器端地址
    //editor.customConfig.uploadImgServer = '/File';
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/UploadHandler.ashx";
    editor.customConfig.uploadImgServer = url;
    // 隐藏“网络图片”tab
    editor.customConfig.showLinkImg = false
    // 使用 base64 保存图片
    //editor.customConfig.uploadImgShowBase64 = true   
    editor.customConfig.uploadImgHeaders = {
        'Accept': 'text/x-json'
    }

    // 自定义处理粘贴的文本内容
    editor.customConfig.pasteTextHandle = function (content) {
        // content 即粘贴过来的内容（html 或 纯文本），可进行自定义处理然后返回
        content = subFnContent(content, "<style>", "</style>");
        content = subFnContent(content, "<!--", "-->");
        return content;
    }

    //配置编辑区域的 z-index
    editor.customConfig.zIndex = 1
    //可使用监听函数在上传图片的不同阶段做相应处理
    editor.customConfig.uploadImgHooks = {
        before: function (xhr, editor, files) {
            debugger;
            // 图片上传之前触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，files 是选择的图片文件

            // 如果返回的结果是 {prevent: true, msg: 'xxxx'} 则表示用户放弃上传
            // return {
            //     prevent: true,
            //     msg: '放弃上传'
            // }
        },
        success: function (xhr, editor, result) {
            debugger;
            // 图片上传并返回结果，图片插入成功之后触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
        },
        fail: function (xhr, editor, result) {
            debugger;
            // 图片上传并返回结果，但图片插入错误时触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
        },
        error: function (xhr, editor) {
            debugger;
            // 图片上传出错时触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象
        },
        timeout: function (xhr, editor) {
            debugger;
            // 图片上传超时时触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象
        },
        // 如果服务器端返回的不是 {errno:0, data: [...]} 这种格式，可使用该配置
        // （但是，服务器端返回的必须是一个 JSON 格式字符串！！！否则会报错）
        customInsert: function (insertImg, result, editor) {
            // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果

            // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
            var url = result.url
            insertImg(url)

            // result 必须是一个 JSON 格式字符串！！！否则报错
        }
    }
    editor.customConfig.onblur = function (html) {
        // html 即编辑器中的内容
        console.log('onblur', html)
    }
    var $text1 = $('#' + nodeName + id);
    editor.customConfig.onchange = function (html) {
        // 监控变化，同步更新到 textarea
        if (nodeName == "fld_") {
            $text1.val(html);
        } else {
            $text1.html(html);
        }
    }
    editor.create();
    if (nodeName == "fld_" && request("Type").toUpperCase() != "MYREQUEST" && request("Type").toUpperCase() != "MYREAD") {
        editor.txt.text($text1.val());
    } else if (nodeName == "fld_" && (request("Type").toUpperCase() == "MYREQUEST" || request("Type").toUpperCase() == "MYREAD")) {
        editor.txt.text($text1.val());
        $("#" + id).html(editor.$textContainerElem.html());
        // 手机端样式设置
        if (isMQQ() || isWeixin() || isIphone() || isAndroid()) {
            $("#" + id).parents(".form-field").css("overflow-x", "scroll");
            $("#" + id).parent(".form-ctl").css("width", "-webkit-fill-available");
        }

        $("#" + id).parents(".form-field").prev().css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").parent().css("height", $("#" + id).height() + 10);
        $("#" + id).parents("#div_field_" + id.toUpperCase()).css("height", $("#" + id).parents(".form-field").innerHeight() + 1);
        $("#" + id).children().css("overflow-y", "hidden");
    } else {
        editor.txt.text($text1.html());
        $("#" + id).html(editor.$textContainerElem.html());
        // 手机端样式设置
        if (isMQQ() || isWeixin() || isIphone() || isAndroid()) {
            $("#" + id).parents(".form-field").css("overflow-x", "scroll");
            $("#" + id).parent(".form-ctl").css("width", "-webkit-fill-available");
        }

        $("#" + id).parents(".form-field").prev().css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").parent().css("height", $("#" + id).height() + 10);
        $("#" + id).parents("#div_field_" + id.toUpperCase()).css("height", $("#" + id).parents(".form-field").innerHeight() + 1);
        $("#" + id).children().css("overflow-y", "hidden");
    }
    LoadImgs();
}
var Images
if (document.getElementById("MDESCRIPTION") != null) {
    Images = document.getElementById("MDESCRIPTION").getElementsByTagName("img");
}
var ImgLoaded = 0;

//设置加载队列
function LoadImgs() {
    for (var i = 0; i < Images.length; i++) {
        Images[i] = new Image();
        downloadImage(i);
    }
}

//加载单个图片文件
function downloadImage(i) {
    var imageIndex = i + 1; //图片以1开始
    Images[i].onLoad = validateImages(i);
}

//验证是否成功加载完成，如不成功则重新加载
function validateImages(i) {
    if (!Images[i].complete) {
        window.setTimeout('downloadImage(' + i + ')', 200);
    }
    else if (typeof Images[i].naturalWidth != "undefined" && Images[i].naturalWidth == 0) {
        window.setTimeout('downloadImage(' + i + ')', 200);
    }
    if (Images[i].complete) {
        console.info(i);
        ImgLoaded++
        if (ImgLoaded == document.getElementById("MDESCRIPTION").getElementsByTagName("img").length) {
            $("div[data-type=wangEditor]").each(function (i) {
                var nodeName = document.getElementById($(this).next()[i].id).nodeName == "SPAN" ? "read_" : "fld_";
                setWangEditorCss($(this)[i].id, nodeName);
                if (request("StepName") != "申请人" || request("type").toLocaleLowerCase() == "myrequest") {
                    $("div[contenteditable='true']").attr('contenteditable', false);
                }
            });
        }
    }
}

function setWangEditorCss(id, nodeName) {
    var $text1 = $('#' + nodeName + id);

    if (nodeName == "fld_" && request("Type").toUpperCase() != "MYREQUEST" && request("Type").toUpperCase() != "MYREAD") {
        // 手机端样式设置
        if (isMQQ() || isWeixin() || isIphone() || isAndroid()) {
            $("#" + id).parents(".form-field").css("overflow-x", "scroll");
            $("#" + id).parent(".form-ctl").css("width", "-webkit-fill-available");
        }

        $("#" + id).parents(".form-field").css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").prev().css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").parent().css("height", $("#" + id).height() + 10);
        $("#" + id).parents("#div_field_" + id.toUpperCase()).css("height", $("#" + id).parents(".form-field").innerHeight() + 1);
    } else if (nodeName == "fld_" && (request("Type").toUpperCase() == "MYREQUEST" || request("Type").toUpperCase() == "MYREAD")) {
        // 手机端样式设置
        if (isMQQ() || isWeixin() || isIphone() || isAndroid()) {
            $("#" + id).parents(".form-field").css("overflow-x", "scroll");
            $("#" + id).parent(".form-ctl").css("width", "-webkit-fill-available");
        }

        $("#" + id).parents(".form-field").css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").prev().css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").parent().css("height", $("#" + id).height() + 10);
        $("#" + id).parents("#div_field_" + id.toUpperCase()).css("height", $("#" + id).parents(".form-field").innerHeight() + 1);
        $("#" + id).children().css("overflow-y", "hidden");
    } else {
        // 手机端样式设置
        if (isMQQ() || isWeixin() || isIphone() || isAndroid()) {
            $("#" + id).parents(".form-field").css("overflow-x", "scroll");
            $("#" + id).parent(".form-ctl").css("width", "-webkit-fill-available");
        }
        $("#" + id).parents(".form-field").css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").prev().css("height", $("#" + id).height() + 9);
        $("#" + id).parents(".form-field").parent().css("height", $("#" + id).height() + 10);
        $("#" + id).parents("#div_field_" + id.toUpperCase()).css("height", $("#" + id).parents(".form-field").innerHeight() + 1);
        $("#" + id).children().css("overflow-y", "hidden");
    }
}

function subFnContent(content, start, end) {
    if (content.indexOf(start) > -1 && content.indexOf(end) > -1) {
        var strStart = content.substring(0, content.indexOf(start));
        var strEnd = content.substring(content.indexOf(end) + end.length, content.length);
        content = strStart + strEnd;
        if (content.indexOf(start) > -1 && content.indexOf(end) > -1)
            content = subFnContent(content, start, end);
    }
    return content;
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
        //if ($(this).next().children().find("div").attr("data-type") == "wangEditor") {
        //    //$(this).parent().removeAttr("auto");
        //}
        if ($(this).parent("div").hasClass("hidden")) { }
        else {
            if ($(this).next().find("input[type='checkbox']").length > 0) {
                $(this).next().height($(this).height());
                $(this).next().find("input[type='checkbox']").css("height", "auto");
            } else {
                if ($(this).height() < $(this).next().children().height()) {
                    $(this).height($(this).next().height());
                    //$(this).height($(this).next().children().height() + 10);
                } else {
                    $(this).next().height($(this).height());
                    $(this).parent().height($(this).parent().height());
                }
            }
        }
    })
}

// 添加有数据的行
function addDataRow(tabId) {
    try {
        var tabCtl = document.getElementById(tabId);
        var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
        var newRow = modelTr.cloneNode(true);
        //var rowIndex = newRow.rowIndex - 1;
        var rowIndex = tabCtl.rows.length - 1;
        newRow = changeRowID(newRow, rowIndex);
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
    }
    catch (e) {
    }
}

function formatAutonumber() {
    $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
    $('.autonumber').focus(function () {
        $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
    });
}

/// <summary>
/// 下拉框添加遮罩层,设置只读
/// </summary>
function SetDropReadonly(id) {
    $('#' + id).css({ 'background-color': "#eeeeee", 'cursor': "not-allowed" });
    $('#' + id).attr("onfocus", "this.blur()");
    $('#' + id).attr("title", "");
    $('#' + id).attr("readonly", "readonly");
}
//两个下拉框在一起样式
//第二个联动下拉框DIV ID
//LinkageStyle("div_field_SERVICENATUREWITHSG2");
function LinkageStyle(ID) {
    $("#" + ID).attr("style", "border-left:0px;");
    $("#" + ID + " .form-label").addClass("hidden");
    $("#" + ID + " .form-field").attr("style", "height: 45px;float:none;margin-left:0px");
    $("#" + ID + " .form-ctl").attr("style", "margin-left:0px;");
}




function getDatabySql(fields, tablename, strwhere) {
    var _data;
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "getDatabySql";
    $.ajaxSetup({ async: false });
    $.post(url, { Method: method, fields: fields, tablename: tablename, strwhere: strwhere }, function (data) {

        _data = data;

    });
    return _data;
}

/* 验证是否为空字符串,null,undefined */
function isNullOrEmpty(str) {
    // 同时判断 undefined 和 null 时可使用typeof (str) === "undefined"
    return str === "" ? true : (typeof (str) === "undefined" ? true : (str === null ? true : false));
}

function hide(id) {
    var t = typeof (id);
    if (t === "string") {
        $("#" + id).hide();
        $("#" + id).addClass("hidden");
    }
    if (t === "object") {
        $(id).addClass("hidden");
    }
}
function show(id) {
    var t = typeof (id);
    if (t === "string") {
        $("#" + id).show();
        $("#" + id).removeClass("hidden");
    }
    if (t === "object") {
        $(id).removeClass("hidden");
    }
}
function hideClass(cl) {
    $("." + cl).hide();
}
function showClass(cl) {
    $("." + cl).show();
}

// 模块div的id
function disabledProp(id) {
    $("#" + id).find("span").each(function () {
        if (!isNullOrEmpty($(this).attr("onclick")))
            $(this).attr("oclick", $(this).attr("onclick"));
        $(this).attr("onclick", "");
    })
    $("#" + id).find("input").each(function () {
        if (!isNullOrEmpty($(this).attr("onclick")))
            $(this).attr("oclick", $(this).attr("onclick"));
        $(this).attr("onclick", "");
        $(this).attr("readonly", "readonly");
    })
}

// 模块div的id
function EnabledProp(id) {
    $("#" + id).find("span").each(function () {
        if (!isNullOrEmpty($(this).attr("oclick")))
            $(this).attr("onclick", $(this).attr("oclick"));
        $(this).attr("oclick", "");
    })
    $("#" + id).find("input").each(function () {
        if (!isNullOrEmpty($(this).attr("oclick")))
            $(this).attr("onclick", $(this).attr("oclick"));
        $(this).attr("oclick", "");
        $(this).removeAttr("readonly");
    })
}
/// <summary>
/// Word转PDF
/// <param name="wordUrl">需要转换的word的地址</param>
/// <param name="pdfUrl">生成PDF的地址</param>
/// <param name="rCodeUrl">二维码链接</param>
/// <param name="waterWord">水印文字</param>
/// <param name="width">水印长度(默认500)</param>
/// <param name="height">水印宽度(默认100)</param>
/// <param name="saveType">保存格式</param>
/// </summary>
function WordToPDF(wordUrl, pdfUrl, waterWord, width, height, rCodeUrl) {
    var _data;
    var url = "/Solution/UPL.Common.BussinessControl/Ajax/HandlerCommon.ashx";
    var method = "WordToPDF";
    $.ajaxSetup({ async: false });
    $.post(url, { Method: method, wordUrl: wordUrl, pdfUrl: pdfUrl, rCodeUrl: rCodeUrl, waterWord: waterWord, width: width, height: height }, function (data) {

        _data = data;

    });
    return _data;
}



