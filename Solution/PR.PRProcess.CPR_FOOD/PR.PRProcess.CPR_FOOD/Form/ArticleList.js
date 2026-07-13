var searchRFQInput = "";
var searchSupper = "";
var searchFamilyNameInput = "";
var searchArticleName = "";
var language = "zh-CN";
//页面加载执行
//页面加载执行
$(function () {
    debugger

    language = $("#hdLanguage").val();
    $("input[type='checkbox']").val(0);
    debugger

    $("#RFQ_Number").on('change', function (e) {
        searchRFQInput = $(this).find("option:selected").val();
        searchSupper = $("#supplerName").find("option:selected").val();
        searchArticleName = $("#ArticleName").val();
        if (searchSupper == "") {
            BindSuppler(searchRFQInput, searchSupper, searchArticleName);
        }
    });
    $("#supplerName").on('change', function (e) {
        searchRFQInput = $("#RFQ_Number").find("option:selected").val();
        searchSupper = $(this).find("option:selected").val();
        searchArticleName = $("#ArticleName").val();
        if (searchRFQInput == "") {
            BindRFQ_Number(searchRFQInput, searchSupper, searchArticleName);
        }
    });
    $("#supplerName").selectpicker({
        noneSelectedText: '请选择',
    });
    if ($("#hdSupplierCode").val() != "") {
        var SupplerCode = $("#hdSupplierCode").val();
        $("#supplerName").empty();
        $("#supplerName").selectpicker('val', SupplerCode);
        $("#supplerName").append("<option value=''selected>" + SupplerCode + "</option>");
        $("#supplerName").selectpicker('refresh');
        $("#supplerName").find("option:selected").val(SupplerCode)
        $("#supplerName").prop('disabled', 'true');
    }
    if (searchRFQInput == "" && searchSupper == "" && searchFamilyNameInput == "" && $("#hdSupplierCode").val() == "") {
        BindSuppler(searchRFQInput, searchSupper, searchFamilyNameInput);
        BindRFQ_Number(searchRFQInput, searchSupper, searchFamilyNameInput);//加载询报价单号
    }
    if (searchRFQInput == "" && searchSupper == "" && searchFamilyNameInput == "" && $("#hdSupplierCode").val() != "") {
        BindRFQ_Number(searchRFQInput, searchSupper, searchFamilyNameInput);//加载询报价单号
    }

    $("#RFQ_Number").parent().find('div').eq(2).find("input").attr("id", "searchRFQInput");
    $("#supplerName").parent().find('div').eq(2).find("input").attr("id", "searchSupplerInput");
    $("#RFQ_Number").selectpicker({
        noneSelectedText: '请选择',
    });
    $("#supplerName").selectpicker({
        noneSelectedText: '请选择',
    });
    $("#searchRFQInput").off().on({
        input: function () {
            debugger
            searchRFQInput = $(this).val();
            searchSupper = $("#supplerName").find("option:selected").val();
            searchArticleName = $("#ArticleName").val();
            BindRFQ_Number(searchRFQInput, searchSupper, searchArticleName);
        }
    });
    $("#searchSupplerInput").off().on({
        input: function () {
            searchRFQInput = $("#RFQ_Number").find("option:selected").val();
            searchSupper = $(this).val();
            searchArticleName = $("#ArticleName").val();
            BindSuppler(searchRFQInput, searchSupper, searchArticleName);
        }
    });
    //BindSupplier();
})



window.onload = function () {
    $("#RFQ_Number").parent().find('div').eq(2).find("input").attr("id", "searchRFQInput");
    $("#supplerName").parent().find('div').eq(2).find("input").attr("id", "searchSupplerInput");
    $("#RFQ_Number").selectpicker({
        noneSelectedText: '请选择',
    });
    $("#supplerName").selectpicker({
        noneSelectedText: '请选择',
    });
    $("#searchRFQInput").off().on({
        input: function () {
            debugger
            searchRFQInput = $(this).val();
            searchSupper = $("#supplerName").find("option:selected").val();
            searchArticleName = $("#ArticleName").val();
            BindRFQ_Number(searchRFQInput, searchSupper, searchArticleName);
        }
    });
    $("#searchSupplerInput").off().on({
        input: function () {
            searchRFQInput = $("#RFQ_Number").find("option:selected").val();
            searchSupper = $(this).val();
            searchArticleName = $("#ArticleName").val();
            BindSuppler(searchRFQInput, searchSupper, searchArticleName);
        }
    });
}

function fun() {
    $("#HdRFQ_Number").val($("#RFQ_Number").find("option:selected").val());
    $("#HdsupplerName").val($("#supplerName").find("option:selected").val());
    $("#HdArticleName").val($("#ArticleName").val());
};
function returnValue1() {
    var tabLen = $(".Articles").find("tr").length;
  //  CheckSupplier(tabLen);
    var num = 0;
    debugger
    // CheckSupplier(tabLen);
    //if (!checkOrderLimit(tabLen)) {
    //    return false;
    //}
    //else if ( $("#supplierNameCN").val()=="") {
    //    alert("无法查询到当前选中物料所对应的的供应商，请联系管理员！");
    //    return false;
    //} 
    //else {
        // var suppler = $("#supplierNameCN").val();
        var rowdata = "[";
        for (var i = 0; i <= tabLen; i++) {
            for (var J = 0; J <= tabLen; J++) {
                if ($("tr:eq(" + J + ")>td:eq(0)").find("input[type = 'checkbox']").val() == "1") {
                    num = J
                    break;
                }
            }
            if (i == num) {
                if ($("tr:eq(" + i + ")>td:eq(0)").find("input[type = 'checkbox']").val() == "1") {
                    rowdata += "{";
                    rowdata += "\"familyname\":\"" + $("tr:eq(" + i + ")>td:eq(10)").text() + "\",";
                    rowdata += "\"familycode\":\"" + $("tr:eq(" + i + ")>td:eq(9)").text() + "\",";

                    rowdata += "\"subfamilyname\":\"" + $("tr:eq(" + i + ")>td:eq(3)").text() + "\",";
                    rowdata += "\"subfamilycode\":\"" + $("tr:eq(" + i + ")>td:eq(12)").text() + "\",";

                    rowdata += "\"subsubfamilyname\":\"" + $("tr:eq(" + i + ")>td:eq(4)").text() + "\",";
                    rowdata += "\"subsubfamilycode\":\"" + $("tr:eq(" + i + ")>td:eq(13)").text() + "\",";
                    rowdata += "\"subsubfamilyce\":\"" + $("tr:eq(" + i + ")>td:eq(4)").text() + "\",";
                    if ($("tr:eq(" + i + ")>td:eq(15)").text() == "") {
                        alert("无法查询到当前选中物料所对应的的供应商，请联系管理员！");
                        return false;
                    } else {
                        rowdata += "\"supplier\":\"" + $("tr:eq(" + i + ")>td:eq(15)").text() + "\",";
                    }

                    rowdata += "\"suppliercode\":\"" + $("tr:eq(" + i + ")>td:eq(14)").text() + "\",";

                    rowdata += "\"article\":\"" + $("tr:eq(" + i + ")>td:eq(2)").text() + "\",";
                    rowdata += "\"articlecode\":\"" + $("tr:eq(" + i + ")>td:eq(11)").text() + "\",";
                    rowdata += "\"otherarticlename\":\"" + $("tr:eq(" + i + ")>td:eq(2)").text() + "\",";
                    // 
                    rowdata += "\"orderunit\":\"" + $("tr:eq(" + i + ")>td:eq(5)").text() + "\",";
                    rowdata += "\"orderunittext\":\"" + $("tr:eq(" + i + ")>td:eq(16)").text() + "\",";

                    rowdata += "\"unit\":\"" + $("tr:eq(" + i + ")>td:eq(16)").text() + "\",";
                    rowdata += "\"unittext\":\"" + $("tr:eq(" + i + ")>td:eq(18)").text() + "\",";

                    rowdata += "\"consumptionunit\":\"" + $("tr:eq(" + i + ")>td:eq(16)").text() + "\",";
                    rowdata += "\"consumptionunittext\":\"" + $("tr:eq(" + i + ")>td:eq(18)").text() + "\",";

                    rowdata += "\"conversion\":\"" + $("tr:eq(" + i + ")>td:eq(19)").text() + "\",";
                    rowdata += "\"stock\":\"" + $("tr:eq(" + i + ")>td:eq(20)").text() + "\",";
                    rowdata += "\"netvomule\":\"" + $("tr:eq(" + i + ")>td:eq(21)").text() + "\",";
                    rowdata += "\"netvomuleunit\":\"" + $("tr:eq(" + i + ")>td:eq(22)").text() + "\",";
                    rowdata += "\"grossweight\":\"" + $("tr:eq(" + i + ")>td:eq(23)").text() + "\",";

                    rowdata += "\"siteprice\":\"" + $("tr:eq(" + i + ")>td:eq(6)").text() + "\",";
                    rowdata += "\"netnetprice\":\"" + $("tr:eq(" + i + ")>td:eq(24)").text() + "\",";

                    rowdata += "\"InitOrderlimt\":\"" + $("tr:eq(" + i + ")>td:eq(25)").text() + "\",";
                    rowdata += "\"InvoiceType\":\"" + $("tr:eq(" + i + ")>td:eq(7)").text() + "\",";
                    rowdata += "\"taxRate\":\"" + $("tr:eq(" + i + ")>td:eq(27)").text() + "\",";
                    rowdata += "\"taxCode\":\"" + $("tr:eq(" + i + ")>td:eq(26)").text() + "\",";
                    rowdata += "\"IsOneTimeUsing\":\"" + $("tr:eq(" + i + ")>td:eq(28)").text() + "\",";
                    rowdata += "\"articleid\":\"" + $("tr:eq(" + i + ")>td:eq(29)").text() + "\",";

                    rowdata += "\"orderquantity\":\"" + $("tr:eq(" + i + ")>td:eq(8)").find("input[type='text']").val() + "\"";
                    rowdata += "}";
                }
            } else {
                if ($("tr:eq(" + i + ")>td:eq(0)").find("input[type = 'checkbox']").val() == "1") {
                    rowdata += ",{";
                    rowdata += "\"familyname\":\"" + $("tr:eq(" + i + ")>td:eq(10)").text() + "\",";
                    rowdata += "\"familycode\":\"" + $("tr:eq(" + i + ")>td:eq(9)").text() + "\",";

                    rowdata += "\"subfamilyname\":\"" + $("tr:eq(" + i + ")>td:eq(3)").text() + "\",";
                    rowdata += "\"subfamilycode\":\"" + $("tr:eq(" + i + ")>td:eq(12)").text() + "\",";

                    rowdata += "\"subsubfamilyname\":\"" + $("tr:eq(" + i + ")>td:eq(4)").text() + "\",";
                    rowdata += "\"subsubfamilycode\":\"" + $("tr:eq(" + i + ")>td:eq(13)").text() + "\",";
                    rowdata += "\"subsubfamilyce\":\"" + $("tr:eq(" + i + ")>td:eq(4)").text() + "\",";
                    if ($("tr:eq(" + i + ")>td:eq(15)").text() == "") {
                        alert("无法查询到当前选中物料所对应的的供应商，请联系管理员！");
                        return false;
                    } else {
                        rowdata += "\"supplier\":\"" + $("tr:eq(" + i + ")>td:eq(15)").text() + "\",";
                    }

                    rowdata += "\"suppliercode\":\"" + $("tr:eq(" + i + ")>td:eq(14)").text() + "\",";

                    rowdata += "\"article\":\"" + $("tr:eq(" + i + ")>td:eq(2)").text() + "\",";
                    rowdata += "\"articlecode\":\"" + $("tr:eq(" + i + ")>td:eq(11)").text() + "\",";
                    rowdata += "\"otherarticlename\":\"" + $("tr:eq(" + i + ")>td:eq(2)").text() + "\",";
                    // 
                    rowdata += "\"orderunit\":\"" + $("tr:eq(" + i + ")>td:eq(5)").text() + "\",";
                    rowdata += "\"orderunittext\":\"" + $("tr:eq(" + i + ")>td:eq(16)").text() + "\",";

                    rowdata += "\"unit\":\"" + $("tr:eq(" + i + ")>td:eq(16)").text() + "\",";
                    rowdata += "\"unittext\":\"" + $("tr:eq(" + i + ")>td:eq(18)").text() + "\",";

                    rowdata += "\"consumptionunit\":\"" + $("tr:eq(" + i + ")>td:eq(16)").text() + "\",";
                    rowdata += "\"consumptionunittext\":\"" + $("tr:eq(" + i + ")>td:eq(18)").text() + "\",";

                    rowdata += "\"conversion\":\"" + $("tr:eq(" + i + ")>td:eq(19)").text() + "\",";
                    rowdata += "\"stock\":\"" + $("tr:eq(" + i + ")>td:eq(20)").text() + "\",";
                    rowdata += "\"netvomule\":\"" + $("tr:eq(" + i + ")>td:eq(21)").text() + "\",";
                    rowdata += "\"netvomuleunit\":\"" + $("tr:eq(" + i + ")>td:eq(22)").text() + "\",";
                    rowdata += "\"grossweight\":\"" + $("tr:eq(" + i + ")>td:eq(23)").text() + "\",";

                    rowdata += "\"siteprice\":\"" + $("tr:eq(" + i + ")>td:eq(6)").text() + "\",";
                    rowdata += "\"netnetprice\":\"" + $("tr:eq(" + i + ")>td:eq(24)").text() + "\",";

                    rowdata += "\"InitOrderlimt\":\"" + $("tr:eq(" + i + ")>td:eq(25)").text() + "\",";
                    rowdata += "\"InvoiceType\":\"" + $("tr:eq(" + i + ")>td:eq(7)").text() + "\",";
                    rowdata += "\"taxRate\":\"" + $("tr:eq(" + i + ")>td:eq(27)").text() + "\",";
                    rowdata += "\"taxCode\":\"" + $("tr:eq(" + i + ")>td:eq(26)").text() + "\",";
                    rowdata += "\"IsOneTimeUsing\":\"" + $("tr:eq(" + i + ")>td:eq(28)").text() + "\",";
                    rowdata += "\"articleid\":\"" + $("tr:eq(" + i + ")>td:eq(29)").text() + "\",";
                    rowdata += "\"orderquantity\":\"" + $("tr:eq(" + i + ")>td:eq(8)").find("input[type='text']").val() + "\"";
                    rowdata += "}";
                }
            }
        }
        rowdata += "]";
        console.log(rowdata);
        //return rowdata;
        return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
    }
//}


//function BindsupplierName(pccode, subsubfamily, suppliercode, J) {
//    datadata = "{\"searchcondition\":\"" + suppliercode + "\",\"pccode\":\"" + pccode + "\",\"subfamilycode\":\"" + subsubfamily + "\"}";
//    $.ajax({
//        type: "POST",
//        datatype: "json",
//        contentType: "application/json",
//        url: 'ArticleList.aspx/BindSupplier',
//        data: datadata,
//        success: function (data) {
//            if (data != "") {
//                var arrData = JSON.parse(data.d);
//                $("#SupplierName").val(arrData[0].SupplierNameCN);
//                $("tr:eq(" + J + ")>td:eq(15)").text(arrData[0].SupplierNameCN);
//            }
//        },
//        error: function (XMLHttpRequest, textStatus, errorThrown) {
//        }
//    });
//}
//function CheckSupplier(tabLen) {
//    debugger
//    for (var J = 0; J <= tabLen; J++) {
//        if ($("tr:eq(" + J + ")>td:eq(0)").find("input[type = 'checkbox']").val() == "1") {
//            var pccode = $("#hdSiteCode").val();
//            var subsubfamily = $("tr:eq(" + J + ")>td:eq(13)").text();
//            var suppliercode = $("tr:eq(" + J + ")>td:eq(14)").text();
//            BindsupplierName(pccode, subsubfamily, suppliercode, J);
//        }
//    }
//    return true;
//}
//function BindSupplier() {
//    var tabLen = $(".Articles").find("tr").length;
//    debugger
//    for (var J = 0; J <= tabLen; J++) {

//        var pccode = $("#hdSiteCode").val();
//        var subsubfamily = $("tr:eq(" + J + ")>td:eq(13)").text();
//        var suppliercode = $("tr:eq(" + J + ")>td:eq(14)").text();
//        BindsupplierName(pccode, subsubfamily, suppliercode, J);
//    }
//}

//function checkOrderLimit(tabLen) {
//    for (var J = 0; J <= tabLen; J++) {
//        if ($("tr:eq(" + J + ")>td:eq(0)").find("input[type = 'checkbox']").val() == "1") {
//            if ($("tr:eq(" + J + ")>td:eq(1)").text() != "") {
//                var OrderLimt = $("tr:eq(" + J + ")>td:eq(8)").find(".OrderLimt").val();
//                var initOrderLimt = $("tr:eq(" + J + ")>td:eq(25)").text();
//                var r = /(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{1}$)|(^[0-9]*\.[0-9]{2}$)/;
//                if (initOrderLimt != "") {
//                    if (!r.test(Number(OrderLimt))) {
//                        alert("请输入大于0的整数或者保留一到两位小数！");
//                        return false;
//                    } else if ((initOrderLimt - (initOrderLimt * 0.05)) > OrderLimt || (initOrderLimt * 1.05) < OrderLimt) {
//                        alert("物品名称为" + $("tr:eq(" + J + ")>td:eq(2)").text() + "的数量不能超过初始值" + initOrderLimt + "的正负百分之五");
//                        $("tr:eq(" + J + ")>td:eq(2)").focus();
//                        return false;
//                    }
//                }
//            } else {
//                var OrderLimt = $("tr:eq(" + J + ")>td:eq(8)").find(".OrderLimt").val();
//                var r = /(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{1}$)|(^[0-9]*\.[0-9]{2}$)/;
//                if (!r.test(Number(OrderLimt))) {
//                    alert("请输入大于0的整数或者保留一到两位小数！");
//                    return false;
//                }
//            }
//        }
//    }
//    return true;
//}
$("input[type='checkbox']").on("change", function () {
    debugger
    if ($(this).is(":checked")) {
        $(this).val(1);
        $(this).attr("checked", "checked");
        var tdList = $(this).parent();
        var SupplerCode = tdList.nextAll().eq(13).text();
        $("#supplerName").empty();
        $("#supplerName").selectpicker('val', SupplerCode);
        $("#supplerName").append("<option value=''selected>" + SupplerCode + "</option>");
        $("#supplerName").selectpicker('refresh');
        $("#supplerName").find("option:selected").val(SupplerCode)
        var tabLen = $(".Articles").find("tr").length;
        for (var i = 1; i <= tabLen; i++) {
            if ($("tr:eq(" + i + ")>td:eq(14)").text() != SupplerCode) {
                $("tr:eq(" + i + ")>td:eq(0)").find("input[type = 'checkbox']").attr("disabled", true);
                $("tr:eq(" + i + ")>td:eq(8)").find("input[type = 'text']").attr("disabled", true);
                $("tr:eq(" + i + ")").css({
                    "color": "darkgray"
                });
            }
        }
       // CheckSupplier(tabLen);
    } else {
        $(this).val(0);
        if ($("input[type='checkbox']:checked").length == 0) {
            BindSuppler(searchRFQInput, "", searchFamilyNameInput);
            var tabLen = $(".Articles").find("tr").length;
            for (var i = 1; i <= tabLen; i++) {
                $("tr:eq(" + i + ")>td:eq(0)").find("input[type = 'checkbox']").attr("disabled", false);
                $("tr:eq(" + i + ")>td:eq(8)").find("input[type = 'text']").attr("disabled", false);
                $("tr:eq(" + i + ")").css({
                    "color": "black"
                });
            }
        }
    }
});

//加载询价单号
function BindRFQ_Number(searchRFQInput, searchSupper, searchArticleName) {
    debugger
    $.ajax({
        type: "post",
        datatype: "json",
        contentType: "application/json",
        async: false,
        url: 'ArticleList.aspx/BindRRQ_Number',
        data: "{\"RFQ_Number\":\"" + searchRFQInput + "\",\"suppliercode\":\"" + searchSupper + "\",\"ArticleName\":\"" + searchArticleName + "\"}",
        success: function (data) {
            debugger
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                $("#RFQ_Number").empty();
                $("#RFQ_Number").append("<option value=''>请选择</option>");
                for (var i = 0; i < arrData.length; i++) {
                    $("#RFQ_Number").append("<option>" + arrData[i].RFQ_Number + "</option>");
                }
                // $("#RFQ_Number").selectpicker('val', '');
                $("#RFQ_Number").selectpicker('refresh');
            } else {
                if (language.toLowerCase() == "en-us") {
                    $("#RFQ_Number").empty();
                    $("#RFQ_Number").append("<option value=''>Please Select</option>");
                    $("#RFQ_Number").selectpicker('refresh');
                }
                else {
                    $("#RFQ_Number").empty();
                    $("#RFQ_Number").append("<option value=''>请选择</option>");
                    $("#RFQ_Number").selectpicker('refresh');
                }
            }
        }
    });
}
//加载该询报价单下的授权供应商
function BindSuppler(searchRFQInput, searchSupper, searchFamilyNameInput) {
    $.ajax({
        type: "post",
        datatype: "json",
        contentType: "application/json",
        async: false,
        url: 'ArticleList.aspx/BindSupper',
        data: "{\"searchRFQInput\":\"" + searchRFQInput + "\",\"searchSupper\":\"" + searchSupper + "\",\"searchArticleName\":\"" + searchArticleName + "\"}",
        success: function (data) {
            debugger
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                $("#supplerName").empty();
                $("#supplerName").append("<option value=''>请选择</option>");
                for (var i = 0; i < arrData.length; i++) {
                    $("#supplerName").append("<option>" + arrData[i].SupplierCode + "</option>");
                }
                $("#supplerName").selectpicker('val', '');
                $("#supplerName").selectpicker('refresh');
            } else {
                if (language.toLowerCase() == "en-us") {
                    $("#supplerName").empty();
                    $("#supplerName").append("<option value=''>Please Select</option>");
                    $("#supplerName").selectpicker('val', '');
                    $("#supplerName").selectpicker('refresh');
                }
                else {
                    $("#supplerName").empty();
                    $("#supplerName").append("<option value=''>请选择</option>");
                    $("#supplerName").selectpicker('val', '');
                    $("#supplerName").selectpicker('refresh');
                }
            }
        }
    });
}

//$(".OrderLimt").mouseout(function () {
//    debugger
//    var initOrderLimit = $(this).parent().nextAll().eq(17).text();

//    var r = /^\+?[1-9][0-9]*$/;
//    if (initOrderLimit != "") {
//        if (!r.test($(this).val())) {
//            alert("请输入大于零的正整数！");
//            return false;
//        } else if ((initOrderLimit - (initOrderLimit * 0.05)) > $(this).val() || (initOrderLimit * 1.05) < $(this).val()) {
//            alert("数量不能超过初始值" + initOrderLimit + "的正负百分之五");
//            $(this).focus();
//            return false;
//        } else {
//            return true;
//        }
//    }
//})