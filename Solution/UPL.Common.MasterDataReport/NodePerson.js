var ddlNodeName = $("#ddlNodeName");
var ddlNodePersonNumber = $("#ddlNodePersonNumber");

var searchNodeName = "";
var searchNodePersonNumber = "";

$(function () {
    var Type = getUrlParam('Type');
    if (Type=="Edit") {
        ddlNodeName.selectpicker('hide');
        $("#read_NodeName").css("display", "block");
        $("#read_NodePerson").css("display", "block");
    }
    else if (Type == "Add") {
        ddlNodeName.selectpicker('show');
        $("#read_NodeName").css("display", "none");
        $("#read_NodePerson").css("display", "none");
    }

    ddlNodeName.selectpicker({
        noneSelectedText: '请选择',
    });
    ddlNodePersonNumber.selectpicker({
        noneSelectedText: '请选择',
    });

    ddlNodeName.parent().find('div').eq(2).find("input").attr('id', 'searchNodeName');
    ddlNodePersonNumber.parent().find('div').eq(2).find("input").attr('id', 'searchNodePersonNumber');

    if (Type == "Add") {
        BindNodeName();
    }
    BindNodePersonNumber();

    $('#searchNodeName').off().on({
        input: function () {
            searchNodeName = $(this).val();
            BindNodeName();
        }
    });
    $('#searchNodePersonNumber').off().on({
        input: function () {
            searchNodePersonNumber = $(this).val();
            BindNodePersonNumber();
        }
    });

    ddlNodeName.on('change', function (e) {
        $('#hdNodeName').val(ddlNodeName.val());
    });
    ddlNodePersonNumber.on('change', function (e) {
        debugger
        $('#hdNodePersonNumber').val(ddlNodePersonNumber.val());
        $('#hdNodePersonName').val(ddlNodePersonNumber.find("option:selected").text());
    });
})

window.onload = function () {
    if ($("#hdNodeName").val() != '请选择' || $("#hdNodeName").val() != "") {
        debugger
        $("#read_NodeName").text($("#hdNodeName").val());
        $("#read_NodePerson").text($("#hdNodePersonName").val());

        //searchNodeName = $("#hdNodeName").val();
        //BindNodeName();
        //alert($("#hdNodeName").val());
        //ddlNodeName.selectpicker('val', $("#hdNodeName").val());
        //ddlNodeName.selectpicker('refresh');
    }
    if ($("#hdNodePersonNumber").val() != '请选择' || $("#hdNodePersonNumber").val() != "") {
        debugger
        //searchNodePersonNumber = $("#hdNodePersonNumber").val();
        //BindNodePersonNumber();
        //alert($("#hdNodePersonNumber").val());
        //ddlNodePersonNumber.selectpicker('val', $("#hdNodePersonNumber").val());
        //ddlNodePersonNumber.selectpicker('refresh');
    }
}

//加载节点名称
function BindNodeName() {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'NodalPersonDetails.aspx/BindNodeName',
        data: "{\"searchcondition\":\"" + searchNodeName + "\"}",
        success: function (data) {
            debugger
            if (data.d != "") {
                debugger
                var arrData = JSON.parse(data.d);
                ddlNodeName.empty();
                ddlNodeName.append("<option value=''>请选择</option>");
                for (var i = 0; i < arrData.length; i++) {
                    ddlNodeName.append("<option value='" + arrData[i].orgCode + "'>" + arrData[i].orgCode + "</option>");
                }
                ddlNodeName.selectpicker('val', '');
                ddlNodeName.selectpicker('refresh');
                debugger
                //if ($('#hdNodeName').val() != "") {
                //    ddlNodeName.selectpicker('val', $('#hdNodeName').val());
                //    ddlNodeName.selectpicker('refresh');
                //} else {
                //    ddlNodeName.selectpicker('val', '');
                //    ddlNodeName.selectpicker('refresh');
                //}
            } else {
                ddlNodeName.empty();
                ddlNodeName.selectpicker('val', '');
                ddlNodeName.selectpicker('refresh');
            }
        }
    });
}

//加载节点负责人
function BindNodePersonNumber() {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'NodalPersonDetails.aspx/BindNodePersonNumber',
        data: "{\"searchcondition\":\"" + searchNodePersonNumber + "\"}",
        success: function (data) {
            debugger
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlNodePersonNumber.empty();
                ddlNodePersonNumber.append("<option value=''>请选择</option>");
                for (var i = 0; i < arrData.length; i++) {
                    ddlNodePersonNumber.append("<option value='" + arrData[i].EMPNO + "'>" + arrData[i].USERNAME + "</option>");
                }
                debugger
                ddlNodePersonNumber.selectpicker('val', '');
                ddlNodePersonNumber.selectpicker('refresh');
                //if ($('#hdNodePersonNumber').val() != "") {
                //    ddlNodePersonNumber.selectpicker('val', $('#hdNodePersonNumber').val());
                //    ddlNodePersonNumber.selectpicker('refresh');
                //} else {
                //    ddlNodePersonNumber.selectpicker('val', '');
                //    ddlNodePersonNumber.selectpicker('refresh');
                //}
            } else {
                ddlNodePersonNumber.empty();
                ddlNodePersonNumber.selectpicker('val', '');
                ddlNodePersonNumber.selectpicker('refresh');
            }
        }
    });
}

//删除
function deleteNodalPerson(NodalPersonID) {
    $.ajax({
        type: "post", //要用post方式                 
        url: "NodalPersonManagement.aspx/DeleteNodalPerson",//方法所在页面和方法名
        data: "{\"NodalPersonID\":\"" + NodalPersonID + "\"}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //alert(data.d);//返回的数据用data.d获取内容
            if (data.d != "") {
                var obj = JSON.parse(data.d);
                if (obj.state == 1) {
                    alert("操作成功");
                    javascript: location.href = location.href;
                }
                else {
                    alert("操作失败，请联系管理员");
                }
            }
        },
        error: function (err) {
            alert("操作失败，请联系管理员");
        }
    });
}

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}