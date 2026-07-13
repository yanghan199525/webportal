$(".checkBtn").click(function () {
    var name = $(this).val();
    if (name.trim() == "同意") {
        $(this).val("拒绝");
    } else {
        $(this).val("同意");
    }
})

$(function () {
    debugger
    var approved = $("#hdCheckApproved").val().trim();
    var num = $(".CataLogArticle").find("tr").length;
    for (var i = 1; i < num; i++) {
        if (approved == "approval") {
            $("#radioBtn").css("display", "none");
            $("#btnSend").css("display", "none");
            $("tr:eq(" + i + ")>td:eq(2)").css("display", "none");
            $("tr:eq(" + i + ")>td:eq(3)").css("display", "none");
        } else {
            $("tr:eq(" + i + ")>td:eq(4)").css("display", "none");
            $("tr:eq(" + i + ")>td:eq(5)").css("display", "none");
        }
    }
    $("#cataLogTable").colResizable({
        liveDrag: true,
        gripInnerHtml: "<div class='grip'></div>",
        draggingClass: "dragging",
        resizeMode: 'fit'
    });
})

var theForm = document.forms['form1'];
if (!theForm) {
    theForm = document.form1;
}
function __doPostBack(eventTarget, eventArgument) {
    var num = $(".CataLogArticle").find("tr").length;
    var jsonT = "[";
    for (var i = 1; i <num; i++) {
        var item = $("tr:eq(" + i + ")>td:eq(2)").find("input[type = 'button']").val();
        var remark = $("tr:eq(" + i + ")>td:eq(3)").find("input[type = 'text']").val();
        var ApprovalId = $("tr:eq(" + i + ")>td:eq(0)").find(".ApprovalId").text();
        var PreviewId = $("tr:eq(" + i + ")>td:eq(1)").find(".PreviewId").text();
        if (item.trim() == "拒绝") {

            //目前不进行拒绝理由必填的判断
            //if (remark == "") {
            //    alert('拒绝理由不能为空');
            //    $("tr:eq(" + i + ")>td:eq(25)").find("input[type = 'text']").focus();
            //    return false;
            //} else {
            //    debugger
            //    jsonT += "{\"ApprovalId\":\"" + ApprovalId + "\",\"PreviewId\":\"" + PreviewId + "\",\"item\":\"" + item + "\",\"remark\":\"" + remark + "\"},"
            //}

            jsonT += "{\"ApprovalNo\":\"" + ApprovalId.trim() + "\",\"PreviewId\":\"" + PreviewId.trim() + "\",\"item\":\"" + item.trim() + "\",\"remark\":\"" + remark.trim() + "\"},"
        }
    }
    jsonT = jsonT.substr(0, jsonT.length - 1);
    jsonT += "]";
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
    CataLogArticle(jsonT);
}

function CataLogArticle(jsonT) {
    console.log(jsonT);
    
    debugger
    $.ajax({
        type: "post",
        url: 'cataLogInfo.aspx/UpdateCataLogArticle',
        datatype: "json",
        contentType: "application/json",
        async: false,
        //"{jsonStr:'"+jsonT + "'}"
        data: "{jsonStr:'" + jsonT + "'}",
            success: function (data) {
                debugger
                if (data.d == true) {
                    console.log(1);

                } else {

                }
            }
        });

}

function CheckAgree() {
        var num = $(".CataLogArticle").find("tr").length;
        for (var i = 0; i <= num; i++) {
            $("tr:eq(" + i + ")>td:eq(2)").find("input[type = 'button']").val("同意");
        }
}

function CheckReject () {
        var num = $(".CataLogArticle").find("tr").length;
        for (var i = 0; i <= num; i++) {
            $("tr:eq(" + i + ")>td:eq(2)").find("input[type = 'button']").val("拒绝");
        } 
}
function returnValue1() {
    debugger
    var num = $(".CataLogArticle").find("tr").length;
    var jsonT = "[";
    for (var i = 1; i < num; i++) {
        var item = $("tr:eq(" + i + ")>td:eq(2)").find("input[type = 'button']").val().trim();
        var remark = $("tr:eq(" + i + ")>td:eq(3)").find("input[type = 'text']").val().trim();
        var ApprovalId = $("tr:eq(" + i + ")>td:eq(0)").text().trim();
        var PreviewId = $("tr:eq(" + i + ")>td:eq(1)").text().trim();
        if (item == "拒绝") {
             //目前不进行拒绝理由必填的判断

            //if (remark == "") {
            //    alert('拒绝理由不能为空');
            //    $("tr:eq(" + i + ")>td:eq(25)").find("input[type = 'text']").focus();
            //    return false;
            //} else {
            //    debugger
            //    jsonT += "{\"ApprovalId\":\"" + ApprovalId + "\",\"PreviewId\":\"" + PreviewId + "\",\"item\":\"" + item + "\",\"remark\":\"" + remark + "\"},"
            //}
            jsonT += "{\"ApprovalNo\":\"" + ApprovalId + "\",\"PreviewId\":\"" + PreviewId + "\",\"item\":\"" + item + "\",\"remark\":\"" + remark + "\"},"
        }
    }
    jsonT = jsonT.substr(0, jsonT.length - 1);
    jsonT += "]";
    CataLogArticle(jsonT);
    //ReturnApprovalResult();
    $("#hdCheckApproved").val("approval");
    alert("保存成功!");
    return true;
}



function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}



//目前不在内部调用回传接口

//function ReturnApprovalResult() {
//    debugger
//    var incident = $("#hdIncident").val();
//    $.ajax({
//        type: "post",
//        url: 'cataLogInfo.aspx/SaveApprovalResult',
//        datatype: "json",
//        contentType: "application/json",
//        data: "{\"incident\":\"" + incident + "\"}",
//        async: true,
//        success: function (data) {
//            debugger
//            if (data.d == true) {
//                console.log(1);

//            } else {

//            }
//        }
//    });
//}
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}