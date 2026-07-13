/* 
 * 编辑页面
 * 
 */

//验证表单
function validateForm() {
    var flag = $("#form1").validationEngine('validate');
    $(".formError").show();
    return flag;
}

//获取表单
function getFormData() {
    var data = $("form").serializeJSON({ useIntKeysAsArrayIndex: true });
    return data;
}

//刷新表单
function refreshFrom() {
    location.href = location.href;
}

//保存
function submitForm(successLang,failureLang)
{
    //validation
    var flag = validateForm();
    if (!flag) {
        return;
    }
    //submit
    var data = $("form").serializeJSON({ useIntKeysAsArrayIndex: true });
    var jsonStr = "data=" + JSON.stringify(data) + "&method=submit";
    $.post(location.href, jsonStr, function (data) {
        var obj = eval("(" + data + ")");
        if (obj.success == "1") {
            alert(successLang);
            self.close();
        }
        else {
            alert(failureLang+":" + obj.message);

        }
    });
}

//删除
function deleteForm(confirmLang, successLang, failureLang)
{
    if (!confirm(confirmLang)) {
        return;
    }

    var data = $("form").serializeJSON({ useIntKeysAsArrayIndex: true });
    var jsonStr = "data=" + JSON.stringify(data) + "&method=delete";
    $.post(location.href, jsonStr, function (data) {
        var obj = eval("(" + data + ")");
        if (obj.success == "1") {
            alert(successLang);
            self.close();
        }
        else {
            alert(failureLang+":" + obj.message);

        }
    });
}


/* 
 * ajax method
 * 
 */
//ajax Get
function getData(method, callback) {
    var data = $("form").serializeJSON({ useIntKeysAsArrayIndex: true });
    var jsonStr = "data=" + JSON.stringify(data) + "&method=" + method;
    $.get(location.href, jsonStr, callback);
}

//ajax Post
function postData(method, callback) {
    var data = $("form").serializeJSON({ useIntKeysAsArrayIndex: true });
    var jsonStr = "data=" + JSON.stringify(data) + "&method=" + method;
    $.post(location.href, jsonStr, callback);
}

/* 
 * 列表及报表页面
 * 
 */
//首次加载
var _tbodyId;
var _templateId;
var _pagerId;
var _pagesize;
function initList(tbodyId, templateId,pagerId)
{
    _tbodyId = tbodyId;
    _templateId = templateId;
    _pagerId = pagerId;
    _pagesize = $("#" + pagerId).attr("pagelistcount");
     searchForm();
}

////跳转分页
//function changePage(pageIndex) {
//    postData("changepage&pageindex=" + pageIndex + "&pagesize=" + _pagesize, function (data) {
//        var objs = JSON.parse(data);
//        var html = template(_templateId, objs);
//        $("#" + _tbodyId).html(html);

//        var totalcount = objs["count"][0].totalcount;
//        $(".totalcount").text(totalcount);
//    });
//}

////搜索
//function searchForm() {
//    postData("changepage&pageindex=1&pagesize=" + _pagesize, function (data) {
//        var objs = JSON.parse(data);
//        var html = template(_templateId, objs);
//        $("#" + _tbodyId).html(html);

//        var totalcount = objs["count"][0].totalcount;
//        $(".totalcount").text(totalcount);
//        $("#" + _pagerId).initPage(totalcount, 1, changePage);
//    });
//}


/**
 * 对日期进行格式化，
 * @param date 要格式化的日期
 * @param format 进行格式化的模式字符串
 *     支持的模式字母有：
 *     y:年,
 *     M:年中的月份(1-12),
 *     d:月份中的天(1-31),
 *     h:小时(0-23),
 *     m:分(0-59),
 *     s:秒(0-59),
 *     S:毫秒(0-999),
 *     q:季度(1-4)
 * @return String
 */
//template.defaults.imports.dateFormat = function (date, format) {

//    if (typeof date === "string") {
//        var mts = date.match(/(\/Date\((\d+)\)\/)/);
//        if (mts && mts.length >= 3) {
//            date = parseInt(mts[2]);
//        }
//    }
//    if (!date)
//    {
//        return "";
//    }

//    date = new Date(date);
//    if (!date || date.toUTCString() == "Invalid Date" ) {
//        return "";
//    }

//    var map = {
//        "M": date.getMonth() + 1, //月份
//        "d": date.getDate(), //日
//        "h": date.getHours(), //小时
//        "m": date.getMinutes(), //分
//        "s": date.getSeconds(), //秒
//        "q": Math.floor((date.getMonth() + 3) / 3), //季度
//        "S": date.getMilliseconds() //毫秒
//    };


//    format = format.replace(/([yMdhmsqS])+/g, function (all, t) {
//        var v = map[t];
//        if (v !== undefined) {
//            if (all.length > 1) {
//                v = '0' + v;
//                v = v.substr(v.length - 2);
//            }
//            return v;
//        }
//        else if (t === 'y') {
//            return (date.getFullYear() + '').substr(4 - all.length);
//        }
//        return all;
//    });
//    return format;
//};


/* 
 * 流程页面
 * 
 */
//提交、退回、拒绝
function submitProcess(actionType)
{
    var data = $("form").serializeJSON({ useIntKeysAsArrayIndex: true });
    var jsonStr = "data=" + JSON.stringify(data) + "&method=submit&ActionType=" + actionType;
    $.post(location.href, jsonStr, submitCallback);
}

function submitCallback(data) {
    var obj = JSON.parse(data);
    if (obj.success == 1)
    {
        alert('Success');
        window.close();
    }
    else
    {
        alert('Failure:' + obj.message);

    }
}

// 添加空白行
function addItem(tabId) {
    try {
        var tabCtl = document.getElementById(tabId);
        var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
        var newRow = modelTr.cloneNode(true);
        var rowIndex = tabCtl.rows.length - 1;
        newRow = changeItemID(newRow, rowIndex);
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

        //明细行中的日期
        if (isIE()) {
            $('input[data-type="date"]').daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });
            $('input[data-type="datetime"]').daterangepicker({
                "singleDatePicker": true, "timePicker": true,
                "timePicker24Hour": true, format: "YYYY/MM/DD  HH:mm"
            });
        }

        //明细行中的上传附件
        var ubtn = $(newRow).find(".uploadifive-button")[0];
        if (ubtn) {
            $(ubtn).attr("id", $(ubtn).attr("id").replace("uploadifive-", ""));
            $(ubtn).attr("class", $(ubtn).attr("class").replace("uploadifive-button", "attachment"));
            $(ubtn).empty();
        }

        attachUpload($(newRow).find(".attachment")[0]);
        $(newRow).removeClass("hidden"); 
        
    }
    catch (e) {
    }
}

//清除数据
function clearRow(row) {
    for (var i = 0; i < row.cells.length; i++) {
        try {
            //if ($(row.cells[i].childNodes[1]).attr("type") == "text"
            //    || $(row.cells[i].childNodes[1]).attr("type") == "number"
            //    || $(row.cells[i].childNodes[1]).attr("type") == "date"
            //    || $(row.cells[i].childNodes[1]).attr("type") == "datetime-local"
            //) {
            //    row.cells[i].childNodes[1].value = "";
            //}
            if ($(row.cells[i].childNodes[1]).hasClass("input-group")) {
                $(row.cells[i].childNodes[1]).find("input").val("");
            } else {
                row.cells[i].childNodes[1].value = "";
            }
        }
        catch (e) {
        }
    }

    $(row).find(".selectuser").val("");
    $(row).find(".attachment_show").empty();

}

//更改控件的ID
function changeItemID(row, rowIndex) {
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

            var objs = $(row.cells[j]).find("label");
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

        name = $(row.cells[j]).children().attr("name");
        if (name && name != "undefined") {
            var a = name.indexOf("[");
            var b = rowIndex;
            
            var c = name.substr(a).substr(name.substr(a).indexOf("]"));
            name = name.substr(0, a) + "[" + b + c;
            $(row.cells[j]).children().attr("name", name);
        }
        else {
            var objs = $(row.cells[j]).find("input");
            $.each(objs, function (i, obj) {
                name = obj.name;
                var a = name.indexOf("[");
                var b = rowIndex;
                
                var c = name.substr(a).substr(name.substr(a).indexOf("]"));
                name = name.substr(0, a) + "[" + b + c;
                $(obj).attr("name", name);
            });
        }
    }
    return row;
}
