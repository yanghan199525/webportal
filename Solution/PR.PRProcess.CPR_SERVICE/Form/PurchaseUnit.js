
//采购单位
var ddlOrderUnit = $("#ddlOrderUnit");
//库存单位
var ddlUnit = $("#ddlUnit");
//消耗单位
var ddlConsumptionUnit = $("#ddlConsumptionUnit");
//多语言
var language = "zh-CN";

$(function () {
    debugger
    language = $("#hdLanguage").val();

    if (language.toLowerCase() == 'en-us') {
        ddlOrderUnit.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlUnit.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlConsumptionUnit.selectpicker({
            noneSelectedText: 'Please Select',
        });
    }
    else {
        ddlOrderUnit.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlUnit.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlConsumptionUnit.selectpicker({
            noneSelectedText: '请选择',
        });
    }

    //加载采购单位
    BindOrderUnit();
    //加载库存单位
    BindBaseUnit();

    ddlOrderUnit.on('change', function (e) {
        ddlUnit.selectpicker('val', ddlOrderUnit.val());
        ddlUnit.selectpicker('refresh');
        ddlConsumptionUnit.selectpicker('val', ddlOrderUnit.val());
        ddlConsumptionUnit.selectpicker('refresh');
        $('#fld_CONVERSION').val('1');
        $('#fld_STOCK').val('1');
        $('#fld_NETVOMULE').val('0');
        $('#fld_GROSSWEIGHT').val('0');
    });
})

function BindOrderUnit() {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindOrderUnit',
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlOrderUnit.empty();
                if (language.toLowerCase() == 'en-us') {
                    ddlOrderUnit.append("<option value=''>Please Select</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlOrderUnit.append("<option value='" + arrData[i].OrderUnitAbbr + "'>" + arrData[i].OrderUnitEN + "</option>");
                    }
                }
                else {
                    ddlOrderUnit.append("<option value=''>请选择</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlOrderUnit.append("<option value='" + arrData[i].OrderUnitAbbr + "'>" + arrData[i].OrderUnitCN + "</option>");
                    }
                }

                ddlOrderUnit.selectpicker('val', '');
                ddlOrderUnit.selectpicker('refresh');
            } else {
                ddlOrderUnit.empty();
            }
        }
    });
}

function BindBaseUnit() {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindBaseUnit',
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlUnit.empty();
                ddlConsumptionUnit.empty();
                if (language.toLowerCase() == 'en-us') {
                    ddlUnit.append("<option value=''>Please Select</option>");
                    ddlConsumptionUnit.append("<option value=''>Please Select</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlUnit.append("<option value='" + arrData[i].BaseUnitAbbr + "'>" + arrData[i].BaseUnitEN + "</option>");
                        ddlConsumptionUnit.append("<option value='" + arrData[i].BaseUnitAbbr + "'>" + arrData[i].BaseUnitEN + "</option>");
                    }
                }
                else {
                    ddlUnit.append("<option value=''>请选择</option>");
                    ddlConsumptionUnit.append("<option value=''>请选择</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlUnit.append("<option value='" + arrData[i].BaseUnitAbbr + "'>" + arrData[i].BaseUnitCN + "</option>");
                        ddlConsumptionUnit.append("<option value='" + arrData[i].BaseUnitAbbr + "'>" + arrData[i].BaseUnitCN + "</option>");
                    }
                }
                ddlUnit.selectpicker('val', '');
                ddlConsumptionUnit.selectpicker('val', '');
                ddlUnit.selectpicker('refresh');
                ddlConsumptionUnit.selectpicker('refresh');
            } else {
                ddlUnit.empty();
                ddlConsumptionUnit.empty();
            }
        }
    });
}