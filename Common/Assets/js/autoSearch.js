var search = null;
var isBegin = true;
var callbackfunction;
var selectRowIndex = 0;
jQuery.extend({
    begin: function (obj, configjson, callback) {
        // 防止累加事件，先将事件删除后再绑定       
        $(obj).unbind();
        $(obj).bind("focus", function () {
            $(obj).select();
            $.search(obj, configjson, callback);
        }).bind("keyup", function () {
            $.search(obj, configjson, callback);
        }).bind("blur", function () {
            var isblur = true;
            $("#searchdiv").find("table tr").each(function () {
                if ($(this).css("backgroundColor") == "#cccccc") {
                    isblur = false;
                }
                if ($(this).css("backgroundColor") == "rgb(204, 204, 204)") {
                    isblur = false;
                }
            });
            if (isblur) {
                var callbacks = $.Callbacks();
                callbacks.add(callbackfunction);
                callbacks.fire(null);
                callbacks.fired();
                $("#searchdiv").remove();
                search = null;
                callbackfunction = null;
            }
        });
    },
    search: function (obj, configjson, callback) {
        if (obj != search) {
            $("#searchdiv").remove();
            search = obj;
            $(document.body).append("<div id=\"searchdiv\" style=\"z-index:99999;position:absolute;background-color:White;border:1px #cccccc solid;display:none;\"><div>");
            var os = $(obj).offset();
            var width = $(document.body).outerWidth(true);
            var height = $(document.body).outerHeight(true);
            //当前的控件在屏幕的右边
            if (eval(os.left * 1) > eval(width * 1 / 2)) {
                $("#searchdiv").css({ "right": eval(width * 1) - eval(os.left * 1) - eval($(obj).width() * 1) - 15, "top": eval(os.top * 1) + $(obj).height() + 10 });
            } else {//当前的控件在屏幕的左边
                $("#searchdiv").css({ "left": os.left, "top": eval(os.top * 1) + $(obj).height() + 10 });
            }

        }

        try {
            $.post("http://" + location.host + "/Portal/Ultimus.UWF.Form/AutoSearchHandler.ashx", { "key": $(obj).val(), "xml": configjson }, function (data) {
                var table = "";
                if (data != null && data != "") {
                    var json = eval("(" + data + ")");
                    if (json.data.length > 0) {
                        table += "<table class=\"table table-condensed table-bordered\" style=\"margin-bottom: 0px\">";
                        table += "<tr>";
                        if (json.SearchType == "2") {
                            table += "<th><input type=\"checkbox\" onclick=\"$.selectAllCheckbox(this)\"/></th>";
                        }
                        for (var i = 0; i < json.data[0].data.length; i++) {
                            table += "<th style=\"" + json.data[0].data[i].Display + "\">" + json.data[0].data[i].title.replace("$br$", "<br/>") + "</th>";
                        }
                        for (var j = 0; j < json.data.length; j++) {
                            if (json.SearchType == "2") {
                                table += "<tr style=\"cursor:pointer;\" onmousemove=\"this.style.backgroundColor = '#cccccc'\" onmouseout=\"this.style.backgroundColor = 'White'\">";
                                table += "<td><input type=\"checkbox\" name=\"checkbox\"/></td>";
                            } else {
                                table += "<tr style=\"cursor:pointer;\" onclick=\"this.style.backgroundColor = '#cccccc';$.getSearchValueByRow()\" onmousemove=\"this.style.backgroundColor = '#cccccc'\" onmouseout=\"this.style.backgroundColor = 'White'\">";
                            }
                            for (var h = 0; h < json.data[j].data.length; h++) {
                                table += "<td  style=\"" + json.data[j].data[h].Display + "\" id=\"" + json.data[j].data[h].Column + "\">" + json.data[j].data[h].value + "</td>";
                            }
                            table += "</tr>";
                        }
                        if (json.SearchType == "2") {
                            table += "<tr><td colspan=\"" + json.data[0].data.length + 1 + "\"><input type=\"button\" value=\"Confirm 确定\" class=\"btn\" onclick=\"$.getSearchValueByButton()\"/></td></tr>";
                        }
                        table += "<tr class='hidden'><font color='#0000FF'>提示：可键入数据，模糊查询 you can input data to query!</font></tr>";
                        table += "</table>";
                        
                    } else {
                        table = "没有找到相关记录. <br/> Record not found.";
                    }

                    $("#searchdiv").html(table);

                    $("#searchdiv").show(100);

                } else {
                    $("#searchdiv").html("没有找到相关记录. <br/> Record not found.");
                }
                callbackfunction = callback;
            });
        } catch (e) {
            alert(e.Message);
        }
    },
    getSearchValueByRow: function (obj) {
        var data = "";
        $("#searchdiv table tr:gt(0)").each(function () {
            var color = $(this).css("backgroundColor").toString();
            var flag = false;
            if (color == "#cccccc") {
                flag = true;
            }
            if (color == "rgb(204, 204, 204)") {
                flag = true;
            }
            if (flag) {

                data = "{";
                $(this).find("td").each(function () {
                    data += "'" + $(this).attr("id") + "':'" + $(this).text() + "',";
                });
                data = data.substring(0, data.length - 1) + "}";
            }
        }
    );
        if (data != "") {
            this.beginCallback(data);
        }
        else {
            $("#searchdiv").remove();
            search = null;
            callbackfunction = null;
        }
    },
    selectAllCheckbox: function (obj) {
        if ($(obj).attr("checked"))
            $("#searchdiv [name='checkbox']:checkbox").attr("checked", "checked");
        else
            $("#searchdiv [name='checkbox']:checkbox").removeAttr("checked");
    },
    getSearchValueByButton: function () {
        var data = "";
        if ($("#searchdiv [name='checkbox'][checked]:checkbox").length > 0) {
            data += "[";
            $("#searchdiv table tr:gt(0)").each(function (i, item) {
                if (i != $("#searchdiv table tr").length) {
                    if ($(this).find("td:eq(0)").find("[name='checkbox']:checkbox").attr("checked")) {
                        data += "{";
                        $(this).find("td:gt(0)").each(function () {
                            data += "'" + $(this).attr("id") + "':'" + $(this).text() + "',";
                        });
                        data = data.substring(0, data.length - 1);
                        data += "},";
                    }
                }
            });
            data = data.substring(0, data.length - 1);
            data += "]";

            this.beginCallback(data);
        } else {
            $("#searchdiv").remove();
            search = null;
            callbackfunction = null;
        }
    },
    beginCallback: function (data) {
        var callbacks = $.Callbacks();
        callbacks.add(callbackfunction);
        callbacks.fire(eval("(" + data + ")"));
        callbacks.fired();
        $("#searchdiv").remove();
        search = null;
        callbackfunction = null;
    }
});