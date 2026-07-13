
$(function () {
    var type = getUrlParam("CprType");
    var article = getUrlParam("ArticleList");
    if (type == "0" && article!="") {
        BindArticle();
    }
   
})

function BindArticle() {
    debugger
    var tabCtl = document.getElementById("tb_CPR_NONFOOD_ITEMS");
    //var existrow = tabCtl.rows[tabCtl.rows.length - 1];
    $.ajax({
        type: "post",
        datatype: "json",
        contentType: "application/json",
        url: 'NewRequest.aspx/BindArticle',
        success: function (data) {
            debugger
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                if (arrData.length > 0) {
                    $("#fld_SUPPLIERTYPE").find("option[value='9']").attr("selected", true);
                    $("#fld_SUPPLIERTYPE").attr("disabled", true);
                    $("#btnAddCPRItems").css("display","none");
                    for (var i = 0; i < arrData.length; i++) {
                        if (i >= 1) {
                            var modelTr = tabCtl.rows[tabCtl.rows.length - 1];
                            var newRow = modelTr.cloneNode(true);
                            var rowIndex = tabCtl.rows.length - 1;
                            newRow = changeRowID(newRow, rowIndex);
                            clearRow(newRow);
                            if ($(tabCtl.rows[1]).attr("class") == "hidden") {
                                $(newRow).find(".index").html(rowIndex);
                                $(newRow).find(".index").val(rowIndex);
                            }
                            else {
                                $(newRow).find(".index").html(rowIndex + 1);
                                $(newRow).find(".index").val(rowIndex + 1);
                            }
                            $(newRow).find("input[id*='fld_APPLYREASON']").val("报价单外产品");

                            $(newRow).find("input[id*='fld_FAMILYCODE']").val(arrData[i].FamilyCode);
                            $('#fld_CPRFAMILYCODE').val("Food");

                            $(newRow).find("input[id*='fld_FAMILYNAME']").val(arrData[i].FamilyName);

                            $(newRow).find("input[id*='fld_SUBFAMILYCODE']").val(arrData[i].SubFamilyCode);
                            $(newRow).find("input[id*='fld_SUBFAMILYNAME']").val(arrData[i].SubFamilyNameCN);

                            $(newRow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(arrData[i].SubSubFamilyCode);
                            $(newRow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(arrData[i].SubSubFamilyNameCN);
                            $(newRow).find("input[id*='fld_SUBSUBFAMILYCE']").val(arrData[i].SubSubFamilyNameCN);
                                $(newRow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].ArticleName);
                                $(newRow).find("input[id*='fld_ARTICLECODE']").val(arrData[i].ArticleCode);

                                $(newRow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].ArticleName);

                            $(newRow).find("input[id*='fld_ORDERUNIT']").val(arrData[i].OrderUnitCN);
                            $(newRow).find("input[id*='fld_ORDERUNITVALUE']").val(arrData[i].OrderUnitAbbr);

                            $(newRow).find("input[id*='fld_UNIT']").val(arrData[i].BaseUnitAbbr);
                            $(newRow).find("input[id*='fld_UNITVALUE']").val(arrData[i].BaseUnitCN);

                            $(newRow).find("input[id*='fld_CONSUMPTIONUNIT']").val(arrData[i].BaseUnitAbbr);
                            $(newRow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(arrData[i].BaseUnitCN);

                            $(newRow).find("input[id*='fld_CONVERSION']").val(arrData[i].UOM_Pur2InvRate);
                            $(newRow).find("input[id*='fld_STOCK']").val(arrData[i].UOM_Inv2UseRate);

                            $(newRow).find("input[id*='fld_NETVOMULE']").val(arrData[i].NetVolume);
                            $(newRow).find("input[id*='fld_NETVOMULEUNIT']").val(arrData[i].NetVolumeUnit);

                            $(newRow).find("input[id*='fld_GROSSWEIGHT']").val(arrData[i].Gross_weight);
                            $(newRow).find("input[id*='fld_GROSSWEIGHTUNIT']").val("KG");

                            $(newRow).find("input[id*='fld_SITEPRICE']").val(arrData[i].SitePrice);
                            $(newRow).find("input[id*='fld_NETNETPRICE']").val(arrData[i].NetNetPrice);
                            $(newRow).find("input[id*='fld_ORDERQUANTITY']").val(arrData[i].OrderLimit);
                            var subtotalamount = arrData[i].NetNetPrice * arrData[i].OrderLimit
                            $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val(subtotalamount);

                            amount = calculatenumber(subtotalamount, amount, 1);
                            $('#fld_AMOUNT').val(thousands(amount));
                            $(tabCtl).find("tbody")[0].appendChild(newRow);

                            $("#tb_CPRFOOD_ITEMS_rowCount").val(rowIndex + 1);
                            if (isIE()) {
                                $('input[data-type="date"]').daterangepicker({ singleDatePicker: true, format: "YYYY/MM/DD" });
                                $('input[data-type="datetime"]').daterangepicker({
                                    "singleDatePicker": true, "timePicker": true,
                                    "timePicker24Hour": true, format: "YYYY/MM/DD  HH:mm"
                                });
                            }
                        }
                        else {
                            var existrow = tabCtl.rows[tabCtl.rows.length - 1];
                            $(existrow).find("input[id*='fld_APPLYREASON']").val("报价单外产品");

                            $(existrow).find("input[id*='fld_FAMILYCODE']").val(arrData[i].FamilyCode);
                            $('#fld_CPRFAMILYCODE').val("Food");

                            $(existrow).find("input[id*='fld_FAMILYNAME']").val(arrData[i].FamilyName);

                            $(existrow).find("input[id*='fld_SUBFAMILYCODE']").val(arrData[i].SubFamilyCode);
                            $(existrow).find("input[id*='fld_SUBFAMILYNAME']").val(arrData[i].SubFamilyNameCN);

                            $(existrow).find("input[id*='fld_SUBSUBFAMILYCODE']").val(arrData[i].SubSubFamilyCode);
                            $(existrow).find("input[id*='fld_SUBSUBFAMILYNAME']").val(arrData[i].SubSubFamilyNameCN);
                            $(existrow).find("input[id*='fld_SUBSUBFAMILYCE']").val(arrData[i].SubSubFamilyNameCN);
                            $(existrow).find("input[id*='fld_ARTICLENAME']").val(arrData[i].ArticleName);
                            $(existrow).find("input[id*='fld_ARTICLECODE']").val(arrData[i].ArticleCode);
                            $(existrow).find("input[id*='fld_ORDERUNIT']").val(arrData[i].OrderUnitCN);
                            $(existrow).find("input[id*='fld_ORDERUNITVALUE']").val(arrData[i].OrderUnitAbbr);

                            $(existrow).find("input[id*='fld_UNIT']").val(arrData[i].BaseUnitAbbr);
                            $(existrow).find("input[id*='fld_UNITVALUE']").val(arrData[i].BaseUnitCN);

                            $(existrow).find("input[id*='fld_CONSUMPTIONUNIT']").val(arrData[i].BaseUnitAbbr);
                            $(existrow).find("input[id*='fld_CONSUMPTIONUNITVALUE']").val(arrData[i].BaseUnitCN);

                            $(existrow).find("input[id*='fld_CONVERSION']").val(arrData[i].UOM_Pur2InvRate);
                            $(existrow).find("input[id*='fld_STOCK']").val(arrData[i].UOM_Inv2UseRate);

                            $(existrow).find("input[id*='fld_NETVOMULE']").val(arrData[i].NetVolume);
                            $(existrow).find("input[id*='fld_NETVOMULEUNIT']").val(arrData[i].NetVolumeUnit);

                            $(existrow).find("input[id*='fld_GROSSWEIGHT']").val(arrData[i].Gross_weight);
                            $(existrow).find("input[id*='fld_GROSSWEIGHTUNIT']").val("KG");
                            //arrData[i].SitePrice
                            $(existrow).find("input[id*='fld_SITEPRICE']").val(arrData[i].SitePrice);
                            $(existrow).find("input[id*='fld_NETNETPRICE']").val(arrData[i].NetNetPrice);
                            $(existrow).find("input[id*='fld_ORDERQUANTITY']").val(arrData[i].OrderLimit);
                            var subtotalamount = arrData[i].NetNetPrice * arrData[i].OrderLimit
                            $(existrow).find("input[id*='fld_SUBTOTALAMOUNT']").val(subtotalamount);
                            
                            amount = calculatenumber(subtotalamount, amount, 1);
                            $('#fld_AMOUNT').val(thousands(amount));
                        }
                    }
                }
            }
        }
    });
}



//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
