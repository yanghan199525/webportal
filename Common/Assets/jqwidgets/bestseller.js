//定义页面中常用的正则表达式
$(document).ready(function () {
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
    $("input[money=kp]").each(function () {
        $(this).keyup(function () {
            this.value = this.value.replace(/[^\-?\d.]/g, "");
            this.value = this.value.replace(/\.{2,}/g, ".");
            this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
            this.value = this.value.replace(/\-{2,}/g, "-");
            this.value = this.value.replace("-", "$#$").replace(/\-/g, "").replace("$#$", "-");
            this.value = this.value.replace(/([0-9]+\.[0-9]{2})[0-9]*/, "$1");
        });
    });

    //Date.prototype.toJSON = function () { return this.toLocaleString(); }
});
//关闭页面
function closeWin() {
    window.opener = null;
    window.open('', '_self');
    window.close();
    return false;
}
//保存成功并关闭当前页面
function successClose() {
    jAlert('保存成功', '操作提醒', function () {
        closeWin();
    });
}
//保存成功不关闭当前页面
function success() {
    jAlert('保存成功', '操作提醒');
}
//删除成功
function del() {
    jAlert('删除成功', '操作提醒');
}
//获取url参数
function request(paras) {
    var url = location.href;
    var paraString = url.substring(url.indexOf('?') + 1, url.length).split('&');
    var paraObj = {}
    for (i = 0; j = paraString[i]; i++) {
        paraObj[j.substring(0, j.indexOf('=')).toLowerCase()] = j.substring(j.indexOf('=') + 1, j.length);
    }
    var returnValue = paraObj[paras.toLowerCase()];
    if (typeof (returnValue) == 'undefined') {
        return '';
    } else {
        return returnValue;
    }
}

//获取CheckBoxList的选中值
function getCheckBoxListValue(obj) {
    var valuelist = "";
    $("input[name^='" + obj + "']").each(function () {
        if (this.checked) {
            //$(this):当前checkbox对象;
            //$(this).parent("span"):checkbox父级span对象
            valuelist += $(this).parent("span").attr("alt") + "@";
        }
    });
    if (valuelist.length > 0) {
        valuelist = valuelist.substring(0, valuelist.length - 1);
    }
    return valuelist;
}

//js设置CheckBoxList的选中
function setCheckBoxListCheck(id, val) {
    $("input[name^='" + id + "']").each(function () {
        var str = $(this).parent("span").attr("alt");
        if (val.indexOf(str) != -1) {
            $(this).attr("checked", true);
        }
    });
}
//验证DIV必填
function validateDiv(divid) {
    var num = 0;
    $("#" + divid + " input").each(function () {
        var element = $(this);
        if (element.hasClass('validate') && element.val() == "" && element.css("display") != "none") {
            var promptTopPosition = 0;
            var promptleftPosition = 0;
            var fieldWidth = element.width();
            var fieldLeft = element.position().left;
            var fieldTop = element.position().top;
            if (element.attr("type") == "text") {
                promptleftPosition += fieldLeft + fieldWidth - 10;
            } else {
                promptleftPosition += fieldLeft + fieldWidth - 30;
            }
            promptTopPosition += fieldTop + 25;
            var finid = element.attr("id").replace("txt_", "").replace("fld_", "");
            var errerdiv = "<div id='" + finid + "div' class='" + finid + "formError parentFormform1 formError' style='opacity: 0.87; position: absolute; top:" + promptTopPosition + "px; left:" + promptleftPosition + "px; margin-top:-40px'><div class='formErrorContent'>* This field is required<br></div><div class='formErrorArrow'><div class='line10'></div><div class='line9'></div><div class='line8'></div><div class='line7'></div><div class='line6'></div><div class='line5'></div><div class='line4'></div><div class='line3'></div><div class='line2'></div><div class='line1'></div></div></div>";
            element.parent().append(errerdiv);
            $("#" + finid + "div").unbind().click(function () {
                this.remove();
            })
            num++;
        }
    });
    $("#" + divid + " div").each(function () {
        var element = $(this);
        if (element.hasClass('validate') && element.val() == "" && element.css("display") != "none") {
            var promptTopPosition = 0;
            var promptleftPosition = 0;
            var fieldWidth = element.width();
            var fieldLeft = element.position().left;
            var fieldTop = element.position().top;
            if (element.attr("type") == "text") {
                promptleftPosition += fieldLeft + fieldWidth - 10;
            } else {
                promptleftPosition += fieldLeft + fieldWidth - 30;
            }
            promptTopPosition += fieldTop + 25;
            var finid = element.attr("id").replace("txt_", "").replace("fld_", "");
            var errerdiv = "<div id='" + finid + "div' class='" + finid + "formError parentFormform1 formError' style='opacity: 0.87; position: absolute; top:" + promptTopPosition + "px; left:" + promptleftPosition + "px; margin-top:-40px'><div class='formErrorContent'>* This field is required<br></div><div class='formErrorArrow'><div class='line10'></div><div class='line9'></div><div class='line8'></div><div class='line7'></div><div class='line6'></div><div class='line5'></div><div class='line4'></div><div class='line3'></div><div class='line2'></div><div class='line1'></div></div></div>";
            element.parent().append(errerdiv);
            $("#" + finid + "div").unbind().click(function () {
                this.remove();
            })
            num++;
        }
    });
    if (num > 0) {
        return false;
    } else {
        return true;
    }
}

//验证jqxgrid必填项
function checkjqxgrid(jqxgrid, jqxcolumns) {
    if (jqxcolumns == "") {
        //alert(jqxgrid);
        var headcolumns = $("#" + jqxgrid + "").jqxGrid('getcolumn', 0).owner._columns;
        if (headcolumns) {
            for (var count = 0; count < headcolumns.length; count++) {
                //                if (headcolumns[count].text.substring(headcolumns[count].text.length - 1, headcolumns[count].text.length) == "*") {
                //                    jqxcolumns += headcolumns[count].datafield + ",";
                //                }
                if (headcolumns[count].text.indexOf("*") >= 0) {
                    jqxcolumns += headcolumns[count].datafield + ",";
                }
            }
            jqxcolumns = jqxcolumns.substring(0, jqxcolumns.length - 1);
        }
    }
    var row = $("#" + jqxgrid + "").jqxGrid('getrows').length;
    if (jqxcolumns == "") {
        return true;
    }
    for (var i = 0; i < row; i++) {
        var col = jqxcolumns.split(',');
        for (var j = 0; j < col.length; j++) {
            var v = $("#" + jqxgrid + "").jqxGrid('getcellvalue', i, col[j]);
            if (v === "" || v == null) {
                $("#" + jqxgrid + "").jqxGrid('begincelledit', i, col[j]);
                return false;
            }
        }
    }
    return true;
}

//验证jqxgrid必填项必须传入验证列
function checkjqxgridcolumns(jqxgrid, jqxcolumns) {

    var row = $("#" + jqxgrid + "").jqxGrid('getrows').length;
    if (jqxcolumns == "") {
        return true;
    }
    for (var i = 0; i < row; i++) {
        var col = jqxcolumns.split(',');
        for (var j = 0; j < col.length; j++) {
            var v = $("#" + jqxgrid + "").jqxGrid('getcellvalue', i, col[j]);
            if (v === "" || v == null) {
                $("#" + jqxgrid + "").jqxGrid('begincelledit', i, col[j]);
                return false;
            }
        }
    }
    return true;
}


// //保留两位小数
function changeTwoDecimal(x) {
    var f_x = parseFloat(x);
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
}

// //保留四位小数（albert 2015-10-21 by add）
function changeFourDecimal(x) {
    var f_x = parseFloat(x);
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 4) {
        s_x += '0';
    }
    return s_x;
}

//时间格式化
Date.prototype.format = function (format) {
    /* 
    * eg:format="yyyy-MM-dd hh:mm:ss"; 
    */
    var o = {
        "M+": this.getMonth() + 1, // month  
        "d+": this.getDate(), // day  
        "h+": this.getHours(), // hour  
        "m+": this.getMinutes(), // minute  
        "s+": this.getSeconds(), // second  
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter  
        "S": this.getMilliseconds()
        // millisecond  
    }

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4
                        - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                            ? o[k]
                            : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}

//日期加
function addByTransDate(dateParameter, num) {
    var translateDate = "", dateString = "", monthString = "", dayString = "";
    translateDate = dateParameter.replace("-", "/").replace("-", "/");
    var newDate = new Date(translateDate);
    newDate = newDate.valueOf();
    newDate = newDate + num * 24 * 60 * 60 * 1000;
    newDate = new Date(newDate);
    //如果月份长度少于2，则前加 0 补位     
    if ((newDate.getMonth() + 1).toString().length == 1) {
        monthString = 0 + "" + (newDate.getMonth() + 1).toString();
    } else {
        monthString = (newDate.getMonth() + 1).toString();
    }
    //如果天数长度少于2，则前加 0 补位     
    if (newDate.getDate().toString().length == 1) {
        dayString = 0 + "" + newDate.getDate().toString();
    } else {
        dayString = newDate.getDate().toString();
    }
    dateString = newDate.getFullYear() + "-" + monthString + "-" + dayString;
    return dateString;
}
//日期减
function reduceByTransDate(dateParameter, num) {
    var translateDate = "", dateString = "", monthString = "", dayString = "";
    translateDate = dateParameter.replace("-", "/").replace("-", "/");
    var newDate = new Date(translateDate);
    newDate = newDate.valueOf();
    newDate = newDate - num * 24 * 60 * 60 * 1000;
    newDate = new Date(newDate);
    //如果月份长度少于2，则前加 0 补位     
    if ((newDate.getMonth() + 1).toString().length == 1) {
        monthString = 0 + "" + (newDate.getMonth() + 1).toString();
    } else {
        monthString = (newDate.getMonth() + 1).toString();
    }
    //如果天数长度少于2，则前加 0 补位     
    if (newDate.getDate().toString().length == 1) {
        dayString = 0 + "" + newDate.getDate().toString();
    } else {
        dayString = newDate.getDate().toString();
    }
    dateString = newDate.getFullYear() + "-" + monthString + "-" + dayString;
    return dateString;
}
//获取当前月份的天数
function getTheMonthDays() {
    //构造当前日期对象
    var date = new Date();
    //获取年份
    var year = date.getFullYear();
    //获取当前月份
    var mouth = date.getMonth() + 1;
    //定义当月的天数；
    var days;
    //当月份为二月时，根据闰年还是非闰年判断天数
    if (mouth == 2) {
        days = year % 4 == 0 ? 29 : 28;
    }
    else if (mouth == 1 || mouth == 3 || mouth == 5 || mouth == 7 || mouth == 8 || mouth == 10 || mouth == 12) {
        //月份为：1,3,5,7,8,10,12 时，为大月.则天数为31；
        days = 31;
    }
    else {
        //其他月份，天数为：30.
        days = 30;
    }
    return days;
}


/************* jqx控件绑定方法 ****************/

//绑定日期控件 control 控件id
function datetime(control) {
    var item = control.split(",");
    for (var i = 0; i < item.length; i++) {
        $("#" + item[i] + "").jqxDateTimeInput({ width: '207', height: '25px', formatString: 'yyyy-MM-dd', culture: 'zh-CN' });

        $("#" + item[i] + "").val(null);
    }
}

//albert 2015-8-31 by add
function BindDatetimeControl(control, controlsWidth, controlsHeight) {
    var item = control.split(",");
    if (controlsWidth == "" || controlsWidth == undefined) {
        controlsWidth = '207';
    }
    if (controlsHeight == "" || controlsHeight == undefined) {
        controlsHeight = '25';
    }
    for (var i = 0; i < item.length; i++) {
        $("#" + item[i] + "").jqxDateTimeInput({ width: controlsWidth, height: controlsHeight + 'px', formatString: 'yyyy-MM-dd' });
        $("#" + item[i] + "").val(null);
    }
}

//绑定是和否方法 control 控件id
function trueorfalse(control) {
    var item = control.split(",");
    var sourceitem = [
                    "否",
                    "是"
                    ];
    for (var i = 0; i < item.length; i++) {
        $("#" + item[i] + "").jqxDropDownList({ source: sourceitem,
            placeHolder: "", // selectedIndex: 0, 
            width: '207', height: '25', autoDropDownHeight: true
        });
    }
}

//绑定手动赋值下拉框
function binddropdown(control, source, controlsWidth, controlsHeight) {
    if (controlsWidth == "" || controlsWidth == undefined) {
        controlsWidth = '207';
    }
    if (controlsHeight == "" || controlsHeight == undefined) {
        controlsHeight = '25';
    }
    $("#" + control + "").jqxDropDownList({ source: source,
        placeHolder: "", // selectedIndex: 0, 
        width: controlsWidth, height: controlsHeight, autoDropDownHeight: true
    });
}

//jqxgrid取消选择方法
function unselection(control) {
    $("#" + control + "").jqxGrid('clearselection');
}

//jqxgrid重新绑定方法
function searchgrid(contral) {
    // $("#" + contral + "").jqxGrid('gotopage', 0);
    $("#" + contral + "").jqxGrid('updatebounddata', 'cells');

}

//弹出框关闭
function cloststore(contral) {
    $("#" + contral + "").jqxWindow('close');
}

//根据流程设置下拉框数据源   //albert 2015-8-31 by add
function getDropDownLis(processname, ccname, fieldid, controlsWidth, controlsHeight) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=DropDownDictionary",
        data: { "ProcessName": processname, "CNName": ccname },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });

    if (controlsWidth == "" || controlsWidth == undefined) {
        controlsWidth = '207';
    }
    if (controlsHeight == "" || controlsHeight == undefined) {
        controlsHeight = '25';
    }

    $("#" + fieldid + "").jqxDropDownList(
    {
        source: _data,
        //selectedIndex: 0,
        placeHolder: "",
        width: controlsWidth,
        height: controlsHeight,
        searchMode: 'startswithignorecase',
        valueMember: 'CNNAME',
        displayMember: 'CNNAME',
        autoDropDownHeight: true
    });
}

/*****************************/


/****************---日期格式转换 albert 2015-8-24 by add----*********/
/*示例如下：
var time1 = new Date(Date.parse(paramTime.replace(/-/g,"/"))); //将参数转换成时间类型
alert(time1.pattern("yyyy"));   
alert(time1.pattern("yyyy-MM"));   
alert(time1.pattern("yyyy-MM-dd"));   
alert(time1.pattern("yyyy-MM-dd hh:mm:ss")); //12时制   
alert(time1.pattern("yyyy-MM-dd HH:mm:ss")); //24时制  
alert(time1.pattern("yyyy/MM"));  
alert(time1.pattern("yyyy/MM/dd")); 
alert(time1.pattern("yyyy/MM/dd hh:mm:ss")); //12时制   
alert(time1.pattern("yyyy/MM/dd HH:mm:ss")); //24时制  
*/
Date.prototype.pattern = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份      
        "d+": this.getDate(), //日      
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时      
        "H+": this.getHours(), //小时      
        "m+": this.getMinutes(), //分      
        "s+": this.getSeconds(), //秒      
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度      
        "S": this.getMilliseconds() //毫秒      
    };
    var week = {
        "0": "\u65e5",
        "1": "\u4e00",
        "2": "\u4e8c",
        "3": "\u4e09",
        "4": "\u56db",
        "5": "\u4e94",
        "6": "\u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[this.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}
/****************---End----*********/
$.fn.jqxGridFormat = function (paras) {
    var formatType = "yyyy-MM-dd hh:mm";
    if (paras != undefined && paras != "") {
        formatType = paras;
    }
    var gridData = $(this).jqxGrid('getrows');
    $(gridData).each(function (i, e) {
        var keys = []; //定义一个数组用来接受key  
        for (var key in e) {
            if (eval("e." + key) != null && eval("e." + key).constructor == Date) {
                var dateKey = eval("e." + key).format(formatType)
                eval("e." + key + " = dateKey;");  //alues.push(e[key])
            } //循环内逐一打印value值  
        }
    });
    return gridData;
};

$.fn.jqxGrid4Int2String = function (paras) {
    var formatType = "yyyy-MM-dd";
    if (paras != undefined && paras != "") {
        formatType = paras;
    }
    var gridData = $(this).jqxGrid('getrows');
    $(gridData).each(function (i, e) {
        var keys = []; //定义一个数组用来接受key  
        for (var key in e) {
            if (eval("e." + key) != null && eval("e." + key).constructor == Number) {
                var dateKey = eval("e." + key) + "";
                eval("e." + key + " = dateKey;");  //alues.push(e[key])
            } //循环内逐一打印value值  
            if (eval("e." + key) != null && eval("e." + key).constructor == Date) {
                var dateKey = eval("e." + key).format(formatType)
                eval("e." + key + " = dateKey;");  //alues.push(e[key])
            } //循环内逐一打印value值  
        }
    });
    return gridData;
};

//逐行删除Grid数据（针对有合计行的Grid）
function delGridData(gridId) {
    var grid = $("#" + gridId);
    var rows = grid.jqxGrid('getrows').length;
    if (rows > 0) {
        for (var i = 0; i < rows; i++) {
            grid.jqxGrid('deleterow', i);
            grid.jqxGrid('refreshdata');
        }
    }
}

Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
(this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
RegExp.$1.length == 1 ? o[k] :
("00" + o[k]).substr(("" + o[k]).length));
    return format;
}