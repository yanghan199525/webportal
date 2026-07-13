
var ddlFamily = $('#ddlFamily');
var ddlSubFamily = $('#ddlSubFamily');
var ddlSubSubFamily = $('#ddlSubSubFamily');
var ddlInvoiceType = $('#ddlInvoiceType');
var ddlArticle = $('#ddlArticle');
var ddlArticles = $('#ddlArticles');
var ddlSupplier = $('#ddlSupplier');
var sltArticle = $('#sltArticle');
var category = "";
var suppliertype = "";
var sitecode = "";
var language = "zh-CN";

var searchSupplier = "";
var searchArticles = "";

$(function () {
    // alert($("#hdFamilyCode").val());
    debugger
    category = $('#hdCategory').val();
    suppliertype = $('#hdSupplierType').val();
    sitecode = $('#hdSiteCode').val();
    language = $("#hdLanguage").val();
    if (language.toLowerCase() == 'en-us') {
        ddlFamily.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlSubFamily.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlSubSubFamily.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlInvoiceType.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlSupplier.selectpicker({
            noneSelectedText: $('#hdSupplierName').val(),
        });
        ddlArticle.selectpicker({
            noneSelectedText: 'Please Select',
        });
        ddlArticles.selectpicker({
            noneSelectedText: 'Please Select',
        });
        sltArticle.selectpicker({
            noneSelectedText: 'Please Select',
        });
        
    }
    else {
        ddlFamily.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlSubFamily.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlSubSubFamily.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlInvoiceType.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlSupplier.selectpicker({
            noneSelectedText: $('#hdSupplierName').val(),
        });
        ddlArticle.selectpicker({
            noneSelectedText: '请选择',
        });
        ddlArticles.selectpicker({
            noneSelectedText: '请选择',
        });
        sltArticle.selectpicker({
            noneSelectedText: '请选择',
        });
    }

    ddlSupplier.parent().find('div').eq(2).find("input").attr('id', 'searchSupplierInput');
    ddlArticles.parent().find('div').eq(2).find("input").attr('id', 'searchArticlesInput');
    sltArticle.parent().find('div').eq(2).find("input").attr('id', 'searchSltArticleInput');

    if ($("#hdSupplierCode").val() != "") {
        debugger
        ddlSupplier.selectpicker('val', $("#hdSupplierCode").val());
        ddlSupplier.prop('disabled', 'true');
        ddlSupplier.selectpicker('refresh');
        $('#fld_SupplierCode').val($("#hdSupplierCode").val());
    }
    
    

    if (suppliertype == '9') {
        ddlArticles.selectpicker('show');
        $("#fld_OTHERARTICLENAME,#div_field_HISTORYARTICLELIST").addClass("hidden");
        $("#ddlFamily,#ddlSubFamily,#ddlSubSubFamily,#ddlSupplier,#ddlOrderUnit,#ddlUnit,#ddlConsumptionUnit,#ddlNetVomule,#ddlGrossWeight").prop('disabled', 'true'); $("#ddlFamily,#ddlSubFamily,#ddlSubSubFamily,#ddlSupplier,#ddlOrderUnit,#ddlUnit,#ddlConsumptionUnit,#ddlNetVomule,#ddlGrossWeight").selectpicker('refresh');
        $("#fld_CONVERSION,#fld_STOCK,#fld_GROSSWEIGHT,#fld_NETVOMULE,#fld_SITEPRICE").attr("disabled", true);
        debugger
        BindArticle();
    }
    else {
        ddlArticles.selectpicker('hide');
        $("#fld_OTHERARTICLENAME,#div_field_HISTORYARTICLELIST").removeClass("hidden");
    }
    GetArticle();

    ///加载一级
    BindFamily(category);
   // BindInvoiceType();
    ddlFamily.on('change', function (e) {
        // 
        if (suppliertype != '9') {
            BindSubFamily(category, ddlFamily.val());
        }
        $("#hiddenTAXNOMYLASTCODE").val(ddlFamily.val());   
        //document.getElementById('ddlSubSubFamily').options.selectedIndex = 0;
        //ddlSubSubFamily.selectpicker('refresh');
    });
  
    ddlSubFamily.on('change', function (e) {
        // 
        debugger
        if (suppliertype != '9') {
            BindSubSubFamily(category, ddlFamily.val(), ddlSubFamily.val());
        }
        $("#hiddenTAXNOMYLASTCODE").val(ddlSubFamily.val());

    });

    ddlSubSubFamily.on('change', function (e) {
        debugger
        if ($('#ddlSubSubFamily').val() != "") {
            BindSubSubFamilyCE();

            if ($('#hdSupplierCode').val() == "") {
                BindSupplier();
            }
            else {
                if (suppliertype != "9") {
                    BindArticle();
                }
            }
        }
        else {
            if ($('#hdSupplierCode').val() == "") {
                $('#fld_OTHERARTICLENAME').attr("disabled", false);
                $('#fld_SupplierCode,#fld_OTHERARTICLENAME,#hdArticleCode').val('');
                $('#ddlSupplier,#ddlArticle,#ddlArticles').empty();
                $('#ddlSupplier,#ddlArticle,#ddlArticles').selectpicker('val', '');
                $('#ddlSupplier,#ddlArticle,#ddlArticles').selectpicker('refresh');
            }
            else {
                $('#fld_OTHERARTICLENAME').attr("disabled", false);
                $("#hdArticleCode").val('');
                $('#ddlArticle,#ddlArticles').empty();
                $('#ddlArticle,#ddlArticles').selectpicker('val', '');
                $('#ddlArticle,#ddlArticles').selectpicker('refresh');
            }
        }
        //BindInvoiceType();
        $("#hiddenTAXNOMYLASTCODE").val(ddlSubSubFamily.val());
    });
    BindInvoiceType();
    ddlArticle.on('change', function (e) {
        debugger
        var ArticleValue = ddlArticle.val();
        if (ArticleValue == '') {
            $('#fld_OTHERARTICLENAME').attr("disabled", false);
            $("#ddlOrderUnit").selectpicker('val', '');
            $("#ddlOrderUnit").selectpicker('refresh');
            $("#fld_CONVERSION").val('');
            $("#ddlUnit").selectpicker('val', '');
            $("#ddlUnit").selectpicker('refresh');
            $("#fld_STOCK").val('');
            $("#ddlConsumptionUnit").selectpicker('val', '');
            $("#ddlConsumptionUnit").selectpicker('refresh');
            $("#fld_GROSSWEIGHT").val('');
            $("#fld_NETVOMULE").val('');
            $("#ddlNetVomule").val('KG');
            $("#hdArticleCode").val('');
        }
        else {
            var ArticleArr = ArticleValue.split('|');
            var UOM_PurUnit = ArticleArr[0];//采购单位
            var UOM_Pur2InvRate = ArticleArr[1];//采购单位转换率
            var UOM_InvUnit = ArticleArr[2];//库存单位
            var UOM_Inv2UseRate = ArticleArr[3];//库存单位转换率
            var UOM_UseUnit = ArticleArr[4];//消耗单位
            var Gross_weight = parseFloat(ArticleArr[5]);//毛重
            var NetVolume = parseFloat(ArticleArr[6]);//库存单位净含量
            var NetVolumeUnit = ArticleArr[7];//库存单位净含量单位
            var ArticleCode = ArticleArr[8];//物品编号

            $("#ddlOrderUnit").selectpicker('val', UOM_PurUnit);
            $("#ddlOrderUnit").selectpicker('refresh');
            $("#fld_CONVERSION").val(Math.round(UOM_Pur2InvRate));
            $("#ddlUnit").selectpicker('val', UOM_InvUnit);
            $("#ddlUnit").selectpicker('refresh');
            $("#fld_STOCK").val(Math.round(UOM_Inv2UseRate));
            $("#ddlConsumptionUnit").selectpicker('val', UOM_UseUnit);
            $("#ddlConsumptionUnit").selectpicker('refresh');
            $("#fld_GROSSWEIGHT").val(Gross_weight.toFixed(2));
            $("#fld_NETVOMULE").val(NetVolume.toFixed(2));
            $("#ddlNetVomule").val(NetVolumeUnit);
            $("#hdArticleCode").val(ArticleCode);

            $('#fld_OTHERARTICLENAME').attr("disabled", true);
        }

    });
    ddlArticles.on('change', function (e) {
        debugger
        var ArticlesValue = ddlArticles.val();
        if (ArticlesValue == '') {
            $('#fld_OTHERARTICLENAME').attr("disabled", false);
            $("#ddlOrderUnit").selectpicker('val', '');
            $("#ddlOrderUnit").selectpicker('refresh');
            $("#fld_CONVERSION").val('');
            $("#ddlUnit").selectpicker('val', '');
            $("#ddlUnit").selectpicker('refresh');
            $("#fld_STOCK").val('');
            $("#ddlConsumptionUnit").selectpicker('val', '');
            $("#ddlConsumptionUnit").selectpicker('refresh');
            $("#fld_GROSSWEIGHT").val('');
            $("#fld_NETVOMULE").val('');
            $("#ddlNetVomule").val('KG');
            $("#fld_SITEPRICE").val('');
            $("#fld_NETNETPRICE").val('');
            $("#hdArticleCode").val('');

            ddlFamily.selectpicker('val', '');
            ddlFamily.selectpicker('refresh');
            $("#ddlSubFamily,#ddlSubSubFamily").empty();
            $("#ddlSubFamily,#ddlSubSubFamily").selectpicker('val', '');
            $("#ddlSubFamily,#ddlSubSubFamily").selectpicker('refresh');
            $("#hdAuthorizedSupplierCode").val('');
            if (hdSupplierCode == '') {
                $("#ddlSupplier").empty();
                $("#ddlSupplier").selectpicker('val', '');
                $("#ddlSupplier").selectpicker('refresh');
                $("#fld_SupplierCode").val('');
            }
        }
        else {
            var ArticlesArr = ArticlesValue.split('|');
            var UOM_PurUnit = ArticlesArr[0];//采购单位
            var UOM_Pur2InvRate = ArticlesArr[1];//采购单位转换率
            var UOM_InvUnit = ArticlesArr[2];//库存单位
            var UOM_Inv2UseRate = ArticlesArr[3];//库存单位转换率
            var UOM_UseUnit = ArticlesArr[4];//消耗单位
            var Gross_weight = parseFloat(ArticlesArr[5]);//毛重
            var NetVolume = parseFloat(ArticlesArr[6]);//库存单位净含量
            var NetVolumeUnit = ArticlesArr[7];//库存单位净含量单位
            var ArticleFamily = ArticlesArr[8];//物品子子类别编号
            var SupplierCode = ArticlesArr[9];//授权供应商编号
            var SitePrice = parseFloat(ArticlesArr[10]);//物料价格
            var NetNetPrice = parseFloat(ArticlesArr[11]);//净价
            var ArticleCode = ArticlesArr[12];//物品编号

            $("#ddlOrderUnit").selectpicker('val', UOM_PurUnit);
            $("#ddlOrderUnit").selectpicker('refresh');
            $("#fld_CONVERSION").val(Math.round(UOM_Pur2InvRate));
            $("#ddlUnit").selectpicker('val', UOM_InvUnit);
            $("#ddlUnit").selectpicker('refresh');
            $("#fld_STOCK").val(Math.round(UOM_Inv2UseRate));
            $("#ddlConsumptionUnit").selectpicker('val', UOM_UseUnit);
            $("#ddlConsumptionUnit").selectpicker('refresh');
            $("#fld_GROSSWEIGHT").val(Gross_weight.toFixed(2));
            $("#fld_NETVOMULE").val(NetVolume.toFixed(2));
            $("#ddlNetVomule").val(NetVolumeUnit);
            $("#fld_SITEPRICE").val(SitePrice.toFixed(2));
            $("#fld_NETNETPRICE").val(NetNetPrice.toFixed(2));
            $("#hdArticleCode").val(ArticleCode);

            checkPositiveInteger3();

            ddlFamily.selectpicker('val', ArticleFamily.substring(3, 0));
            ddlFamily.selectpicker('refresh');
            $("#hdSubFamilyCode").val(ArticleFamily.substring(5, 0));
            $("#hdSubSubFamilyCode").val(ArticleFamily);
            $("#hdAuthorizedSupplierCode").val(SupplierCode);
            BindSubFamily(category, ArticleFamily.substring(3, 0));

            $('#fld_OTHERARTICLENAME').attr("disabled", true);
        }
    });
    ddlSupplier.on('change', function (e) {
        // 
        $('#fld_SupplierCode').val(ddlSupplier.val());
        if (suppliertype != "9") {
            BindArticle();
        }
    });
    sltArticle.on('change', function (e) {
        debugger
        var ArticleValue = sltArticle.val();
        if (ArticleValue) {
            var ArticleArr = ArticleValue.split('|');
            var varFamily = ArticleArr[0];//采购单位
            var varSubFamily = ArticleArr[1];//采购单位转换率
            var varSubSubFamily = ArticleArr[2];//采购单位转换率
            var varARTICLENAME = ArticleArr[3];//采购单位转换率

            BindSubFamily(category, varFamily, varSubFamily);
            BindSubSubFamily(category, varFamily, varSubFamily, varSubSubFamily);
        
            $("#ddlFamily").selectpicker('val', varFamily);
            $("#ddlFamily").selectpicker('refresh');
        
            $("#fld_OTHERARTICLENAME").val(varARTICLENAME);

            

           
        }

    });

    $('#searchSupplierInput').off().on({
        input: function () {
            searchSupplier = $(this).val();
            BindSupplier();
        }
    });
    $('#searchArticlesInput').off().on({
        input: function () {
            searchArticles = $(this).val();
            BindArticle();
        }
    });
    $('#searchSltArticleInput').off().on({
        input: function () {
            searchArticles = $(this).val();
            GetArticle();
        }
    });

    ddlFamily.parent().children('div').find('button').attr("id", "selectbtnfamily");

    
});

function BindSubSubFamilyCE() {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindSubSubFamilyCE',
        data: "{\"SubSubFamilyCode\":\"" + $('#ddlSubSubFamily').val() + "\"}",
        success: function (data) {
            if (data.d != "") {
                debugger
                var arrData = JSON.parse(data.d);
                $("#hdSubSubFamilyCe").val(arrData[0].SubSubFamilyNameCN + "/" + arrData[0].SubSubFamilyNameEN);
            }
        }
    });
}

function BindLanguage() {

    var username = $("#hdUserName").val().split('\\')[1];

    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindLanguage',
        data: "{\"username\":\"" + username + "\"}",
        success: function (data) {

            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                language = arrData[0].LANGUAGE;
            } else {
                language = "zh-CN";
            }
        }
    });
}

function BindFamily(category) {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindFamily',
        data: "{\"categorycode\":\"" + category + "\"}",
        //data: function () { return { 'selectedCategory': selectedCategory } },
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlFamily.empty();
                if (language.toLowerCase() == "en-us") {
                    ddlFamily.append("<option value=''>Please Select</option>");
                    for (var i = 0; i < arrData.length; i++) {
                  
                            ddlFamily.append("<option value='" + arrData[i].FamilyCode + "' >" + arrData[i].FamilyNameEN + "</option>");
                    }
                }
                else {
                    ddlFamily.append("<option value=''>请选择</option>");
                    for (var i = 0; i < arrData.length; i++) { 
                            ddlFamily.append("<option value='" + arrData[i].FamilyCode + "'>" + arrData[i].FamilyNameCN + "</option>");
                        
                    }
                }
                ddlFamily.selectpicker('val', '');
                ddlFamily.selectpicker('refresh');
                //ddlFamily.parent().children('div').find('button').attr("id", "selectbtnfamily");               
            } else {
                ddlFamily.empty();
                ddlFamily.selectpicker('val', '');
                ddlFamily.selectpicker('refresh');               
                //ddlFamily.parent().children('div').find('button').attr("id", "selectbtnfamily");
            }
            CheckTaxnomy(ddlFamily.selector);            
        }
    });
}


function BindSubFamily(category, family,falg='') {

    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindSubFamily',
        data: "{\"categorycode\":\"" + category + "\",\"familycode\":\"" + family + "\"}",
        success: function (data) {
            // 

            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlSubFamily.empty();

                if (language.toLowerCase() == "en-us") {
                    ddlSubFamily.append("<option value=''>Please Select</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlSubFamily.append("<option value='" + arrData[i].SubFamilyCode + "'>" + arrData[i].SubFamilyNameEN + "</option>");
                    }
                }
                else {
                    ddlSubFamily.append("<option value=''>请选择</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlSubFamily.append("<option value='" + arrData[i].SubFamilyCode + "'>" + arrData[i].SubFamilyNameCN + "</option>");
                    }
                }
                debugger
                if (suppliertype == "9") {
                    ddlSubFamily.selectpicker('val', $("#hdSubFamilyCode").val());
                    BindSubSubFamily(category, ddlFamily.val(), $("#hdSubFamilyCode").val());
                }
                else {
                    ddlSubFamily.selectpicker('val', '');
                }
                ddlSubFamily.selectpicker('refresh');

                ddlSubSubFamily.empty();
                ddlSubSubFamily.selectpicker('val', '');
                ddlSubSubFamily.selectpicker('refresh');

                if ($('#hdSupplierCode').val() == '') {
                    $('#fld_SupplierCode').val('');
                    ddlSupplier.empty();
                    ddlSupplier.selectpicker('val', '');
                    ddlSupplier.selectpicker('refresh');
                }
                //BindSubSubFamily(category, ddlFamily.val(), ddlSubFamily.val());
               

            } else {
                //ddlSubFamily.empty();
                //ddlSubFamily.parent().children('div').find('button').attr("id", "selectbtnsubfamily");
                $('#ddlSubFamily,#ddlSubSubFamily').empty();
                $('#ddlSubFamily,#ddlSubSubFamily').selectpicker('val', '');
                $('#ddlSubFamily,#ddlSubSubFamily').selectpicker('refresh');
                if ($('#hdSupplierCode').val() == '') {
                    $('#fld_SupplierCode').val('');
                    ddlSupplier.empty();
                    ddlSupplier.selectpicker('val', '');
                    ddlSupplier.selectpicker('refresh');
                }
               // CheckTaxnomy(ddlSubFamily.selector);
                BindSupplier();
                if (suppliertype != "9") {
                    BindArticle();
                }
            }
            if (falg) {
                $("#ddlSubFamily").selectpicker('val', falg);
                $("#ddlSubFamily").selectpicker('refresh');
            }
            CheckTaxnomy(ddlSubFamily.selector);
        }
    });
}

function BindSubSubFamily(category, family, subfamily, falg = '') {

    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindSubSubFamily',
        data: "{\"categorycode\":\"" + category + "\",\"familycode\":\"" + family + "\",\"subfamilycode\":\"" + subfamily + "\"}",
        success: function (data) {
            // 
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlSubSubFamily.empty();

                if (language.toLowerCase() == "en-us") {
                    ddlSubSubFamily.append("<option value=''>Please Select</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlSubSubFamily.append("<option value='" + arrData[i].SubSubFamilyCode + "'>" + arrData[i].SubSubFamilyNameEN + "</option>");
                    }
                }
                else {
                    ddlSubSubFamily.append("<option value=''>请选择</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlSubSubFamily.append("<option value='" + arrData[i].SubSubFamilyCode + "'>" + arrData[i].SubSubFamilyNameCN + "</option>");
                    }
                }
                debugger
                if (suppliertype == "9") {
                    ddlSubSubFamily.selectpicker('val', $("#hdSubSubFamilyCode").val());
                    //$("#hdSupplierCode").val($("#hdAuthorizedSupplierCode").val());
                    if ($('#ddlSubSubFamily').val() != "") {
                        BindSubSubFamilyCE();
                    }
                    BindSupplier();
                }
                else {
                    ddlSubSubFamily.selectpicker('val', '');
                }
                ddlSubSubFamily.selectpicker('refresh');
                ddlSubSubFamily.parent().children('div').find('button').attr("id", "selectbtnsubsubfamily");
                //BindSupplier();
                //CheckTaxnomy(ddlSubSubFamily.selector);
                if ($('#hdSupplierCode').val() == '') {
                    $('#fld_SupplierCode').val('');
                    ddlSupplier.empty();
                    ddlSupplier.selectpicker('val', '');
                    ddlSupplier.selectpicker('refresh');
                }
            } else {
                ddlSubSubFamily.empty();
                ddlSubSubFamily.parent().children('div').find('button').attr("id", "selectbtnsubsubfamily");
                ddlSubSubFamily.selectpicker('val', '');
                ddlSubSubFamily.selectpicker('refresh');
                if ($('#hdSupplierCode').val() == '') {
                    $('#fld_SupplierCode').val('');
                    ddlSupplier.empty();
                    ddlSupplier.selectpicker('val', '');
                    ddlSupplier.selectpicker('refresh');
                }              
                BindSupplier();
                if (suppliertype != "9") {
                    BindArticle();
                }
            }
            if (falg) {
                $("#ddlSubSubFamily").selectpicker('val', falg);
                $("#ddlSubSubFamily").selectpicker('refresh');
            }
            CheckTaxnomy(ddlSubSubFamily.selector);
        }
    });
}

function BindInvoiceType() {
    debugger
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindInvoiceType',
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlInvoiceType.empty();
                ddlInvoiceType.append("<option value=''>请选择</option>");
                for (var i = 0; i < arrData.length; i++) {
                    ddlvalue = arrData[i].TaxCode + "|" + arrData[i].TaxRate;
                    ddlInvoiceType.append("<option value='" + ddlvalue + "'>" + arrData[i].InvoiceTypeDesc + "</option>");
                    ddlInvoiceType.selectpicker('refresh');
                }
            } else {
                ddlInvoiceType.empty();
                ddlInvoiceType.selectpicker('val', '');
                ddlInvoiceType.selectpicker('refresh');
            }
        }
    });
}
///回调函数
function returnValue1() {
    //var reg_oblique_line = new RegExp("\"", "g");
    var flag = $("#form1").validationEngine('validate');
    // 
    if (!flag) {
        $(".formError").show();

        if ($('#ddlFamily').val() == "" || $('#ddlFamily').val() == null)
            if (language.toLowerCase() == "en-us") {
                $('#selectbtnfamily').validationEngine('showPrompt', 'Please improve the material classification', 'error');
            }
            else {
                $('#selectbtnfamily').validationEngine('showPrompt', '请完善物料分类', 'error');
            }
        //if ($('#ddlSubFamily').val() == "" || $('#ddlSubFamily').val() == null)
        //    $('#selectbtnsubfamily').validationEngine('showPrompt', '提示内容', 'error');
        //if ($('#ddlSubSubFamily').val() == "" || $('#ddlSubSubFamily').val() == null)
        //    $('#selectbtnsubsubfamily').validationEngine('showPrompt', '提示内容', 'error');
        //if ($('#fld_SupplierCode').val() == "" || $('#fld_SupplierCode').val() == null)
        //    $('#selectbtnsupplier').validationEngine('showPrompt', '提示内容', 'error');
        return false;
    } else {
        //Add By Sylvia At 2020/05/12
        debugger
        var ArticleText = $('#ddlArticle').find("option:selected").text();
        var ArticlesText = $('#ddlArticles').find("option:selected").text();
        var familycode = ddlFamily.val();
        var subfamilycode = ddlSubFamily.val();
        var subsubfamilycode = ddlSubSubFamily.val();
        var orderunitvalue = $("#ddlOrderUnit").val();
        var unitvalue = $("#ddlUnit").val();
        var consumptionunit = $("#ddlConsumptionUnit").val();
        var suppliervalue = ddlSupplier.val();
        var suppliername = $('button[data-id="ddlSupplier"]').attr('title');
        var InvoiceType = ddlInvoiceType.val();
        var InvoiceTypeText = ddlInvoiceType.find("option:selected").text();
        var InvoiceTypeArr = InvoiceType.split('|');
        var taxRate = InvoiceTypeArr[1];
        var taxCode = InvoiceTypeArr[0];
        if (familycode == "" || subfamilycode == "" || subsubfamilycode == "") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : Material classification cannot be empty');
            }
            else {
                alert('提示：物料分类不能为空');
            }
            scrollTo(0, 0);
        }
        else if (InvoiceTypeText == "" || InvoiceTypeText == "请选择" || InvoiceTypeText == "Please Select") {
            alert('提示：票种不能为空');
            scrollTo(0, 0);
        }
        else if (orderunitvalue == "" || orderunitvalue == "请选择" || orderunitvalue == "Please Select") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : The purchasing unit, inventory unit and consumption unit cannot be empty');
            }
            else {
                alert('提示：采购单位不能为空');
            }
            scrollTo(0, 400);
        } else if (unitvalue == "" || unitvalue == "请选择" || unitvalue == "Please Select") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : The purchasing unit, inventory unit and consumption unit cannot be empty');
            }
            else {
                alert('提示：库存单位不能为空');
            }
            scrollTo(0, 400);
        }
        else if (consumptionunit == "" || consumptionunit == "请选择" || consumptionunit == "Please Select") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : The purchasing unit, inventory unit and consumption unit cannot be empty');
            }
            else {
                alert('提示：消耗单位不能为空');
            }
            scrollTo(0, 400);
        }
        else if (suppliervalue == "") {
            if (suppliername == "" || suppliername == "请选择" || suppliername == "Please Select") {
                if (language.toLowerCase() == "en-us") {
                    alert('Tip : The supplier cannot be empty');
                }
                else {
                    alert('提示：供应商不能为空');
                }
                scrollTo(0, 0);
            }
        }
        //Update By Sylvia At 2019/12/09-16:27
        //9为授权供应商
        else if (suppliertype == '9') {
            if (ArticlesText == '' || ArticlesText == '请选择' || ArticlesText == 'Please Select') {
                if (language.toLowerCase() == "en-us") {
                    alert('Tip : please select item name！')
                }
                else {
                    alert('提示：请选择物品名称！')
                }
                scrollTo(0, 0);
            }
            else {
                // 
                //if (reg.test($('#fld_OTHERARTICLENAME').val())) {
                //    alert("提示：您输入的信息含有非法字符！请返回顶部重新填写！");
                //    $('#fld_OTHERARTICLENAME').val('');
                //}
                //else {

                var rowdata;
                rowdata = "{";
                rowdata += "\"applyreason\":\"" + $('#ddlApplyReason').val() + "\",";

                rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\",";
                rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\",";

                rowdata += "\"supplier\":\"" + $('#ddlSupplier').find("option:selected").text() + "\",";
                rowdata += "\"suppliercode\":\"" + $('#fld_SupplierCode').val() + "\",";

                //rowdata += "\"article\":\"" + $('#ddlArticles').find("option:selected").text() + "\",";
                if (ArticlesText.indexOf("\"") != -1) {
                    ArticlesText = ArticlesText.replace(reg_oblique_line, "\\\"");
                }
                rowdata += "\"article\":\"" + ArticlesText + "\",";

                rowdata += "\"articlecode\":\"" + $("#hdArticleCode").val() + "\",";
                rowdata += "\"otherarticlename\":\"" + $('#fld_OTHERARTICLENAME').val() + "\",";

                // 
                rowdata += "\"orderunit\":\"" + $('#ddlOrderUnit').val() + "\",";
                rowdata += "\"orderunittext\":\"" + $('#ddlOrderUnit').find("option:selected").text() + "\",";

                rowdata += "\"unit\":\"" + $('#ddlUnit').val() + "\",";
                rowdata += "\"unittext\":\"" + $('#ddlUnit').find("option:selected").text() + "\",";

                rowdata += "\"consumptionunit\":\"" + $('#ddlConsumptionUnit').val() + "\",";
                rowdata += "\"consumptionunittext\":\"" + $('#ddlConsumptionUnit').find("option:selected").text() + "\",";

                rowdata += "\"conversion\":\"" + $('#fld_CONVERSION').val() + "\",";
                rowdata += "\"stock\":\"" + $('#fld_STOCK').val() + "\",";
                rowdata += "\"netvomule\":\"" + $('#fld_NETVOMULE').val() + "\",";
                rowdata += "\"netvomuleunit\":\"" + $('#ddlNetVomule').val() + "\",";
                rowdata += "\"grossweight\":\"" + $('#fld_GROSSWEIGHT').val() + "\",";
                rowdata += "\"grossweightunit\":\"" + $('#ddlGrossWeight').val() + "\",";

                rowdata += "\"siteprice\":\"" + $('#fld_SITEPRICE').val() + "\",";
                rowdata += "\"netnetprice\":\"" + $('#fld_NETNETPRICE').val() + "\",";
                rowdata += "\"orderquantity\":\"" + $('#fld_ORDERQUANTITY').val() + "\",";
                var unitprice = Number($('#fld_SITEPRICE').val());
                var orderquantity = Number($('#fld_ORDERQUANTITY').val());
                var subtotalamount = unitprice * orderquantity;
                rowdata += "\"subtotalamount\":\"" + subtotalamount.toFixed(4).toString() + "\"";
                rowdata += "}";

                rowdata = "[" + rowdata + "]";

                return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
            }
        }
        else {
            //if (ArticlesText == '' || ArticlesText == '请选择' || ArticlesText == 'Please Select') {
            //    if (language.toLowerCase() == "en-us") {
            //        alert('Tip : please select item name！')
            //    }
            //    else {
            //        alert('提示：请选择物品名称！')
            //    }
            //    return false;
            //    scrollTo(0, 0);
            //}
            var OTHERARTICLENAME = $('#fld_OTHERARTICLENAME').val();
            if (OTHERARTICLENAME == '') {
                if (ArticleText == '' || ArticleText == '请选择' || ArticleText == 'Please Select') {
                    if (language.toLowerCase() == "en-us") {
                        alert('Tip : please select item name！')
                    }
                    else {
                        alert('提示：请选择物品名称！')
                    }
                    scrollTo(0, 0);
                }
                else {
                    //var reg = /[`~!@#$%^&*()_+<>?:"{},.\/;'[\]]/im;
                    //if (reg.test($('#fld_OTHERARTICLENAME').val())) {
                    //    alert("提示：您输入的信息含有非法字符！请返回顶部重新填写！");
                    //    $('#fld_OTHERARTICLENAME').val('');
                    //}
                    //else {
                    var rowdata;
                    rowdata = "{";
                    rowdata += "\"applyreason\":\"" + $('#ddlApplyReason').val() + "\",";

                    rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                    rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                    rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                    rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\",";

                    rowdata += "\"InvoiceType\":\"" + $('#ddlInvoiceType').find("option:selected").text() + "\",";
                    rowdata += "\"taxRate\":\"" + taxRate + "\",";
                    rowdata += "\"taxCode\":\"" + taxCode + "\",";
                    rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\",";

                    rowdata += "\"supplier\":\"" + $('#ddlSupplier').find("option:selected").text() + "\",";
                    rowdata += "\"suppliercode\":\"" + $('#fld_SupplierCode').val() + "\",";

                    rowdata += "\"article\":\"" + $('#ddlArticle').find("option:selected").text() + "\",";
                    rowdata += "\"articlecode\":\"" + $("#hdArticleCode").val() + "\",";
                    rowdata += "\"otherarticlename\":\"" + $('#fld_OTHERARTICLENAME').val() + "\",";
                    // 
                    rowdata += "\"orderunit\":\"" + $('#ddlOrderUnit').val() + "\",";
                    rowdata += "\"orderunittext\":\"" + $('#ddlOrderUnit').find("option:selected").text() + "\",";

                    rowdata += "\"unit\":\"" + $('#ddlUnit').val() + "\",";
                    rowdata += "\"unittext\":\"" + $('#ddlUnit').find("option:selected").text() + "\",";

                    rowdata += "\"consumptionunit\":\"" + $('#ddlConsumptionUnit').val() + "\",";
                    rowdata += "\"consumptionunittext\":\"" + $('#ddlConsumptionUnit').find("option:selected").text() + "\",";

                    rowdata += "\"conversion\":\"" + $('#fld_CONVERSION').val() + "\",";
                    rowdata += "\"stock\":\"" + $('#fld_STOCK').val() + "\",";
                    rowdata += "\"netvomule\":\"" + $('#fld_NETVOMULE').val() + "\",";
                    rowdata += "\"netvomuleunit\":\"" + $('#ddlNetVomule').val() + "\",";
                    rowdata += "\"grossweight\":\"" + $('#fld_GROSSWEIGHT').val() + "\",";
                    rowdata += "\"grossweightunit\":\"" + $('#ddlGrossWeight').val() + "\",";

                    rowdata += "\"siteprice\":\"" + $('#fld_SITEPRICE').val() + "\",";
                    rowdata += "\"netnetprice\":\"" + $('#fld_NETNETPRICE').val() + "\",";
                    rowdata += "\"orderquantity\":\"" + $('#fld_ORDERQUANTITY').val() + "\",";
                    var unitprice = Number($('#fld_SITEPRICE').val());
                    var orderquantity = Number($('#fld_ORDERQUANTITY').val());
                    var subtotalamount = unitprice * orderquantity;
                    rowdata += "\"subtotalamount\":\"" + subtotalamount.toFixed(4).toString() + "\"";
                    rowdata += "}";

                    rowdata = "[" + rowdata + "]";
                    return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
                    //}
                }
            }
            else {
                if (OTHERARTICLENAME == '请选择' || OTHERARTICLENAME.toLowerCase() == 'please select') {
                        if (language.toLowerCase() == "en-us") {
                            alert('Tip : Article name cannot be "please select"！')
                        }
                        else {
                            alert('提示：物料名称不能为 “请选择”!')
                        }
                        scrollTo(0, 0);
                        return false;
                    }
                    //过滤特殊字符
                    //Add by Sylvia 2018-5-22
                    //Edit By Sylvia At 2020-08-04
                    //var reg = /[`~!@#$%^&*()_+<>?:"{},.\/;'[\]]/im;
                    //if (reg.test($('#fld_OTHERARTICLENAME').val())) {
                    //    if (language.toLowerCase() == "en-us") {
                    //        alert('Tip : the message you entered contains illegal characters! Please return to the top and fill in again!')
                    //    }
                    //    else {
                    //        alert("提示：您输入的信息含有非法字符！请返回顶部重新填写！");
                    //    }

                    var reg = /[`~@$^_￥……=<>?{}\'·！——|'《》？‘’【】]/;
                    if (reg.test($('#fld_OTHERARTICLENAME').val())) {
                        if (language.toLowerCase() == "en-us") {
                            alert('Tip : Only Chinese and English and special characters such as / \ - % & ，,、()（）。* :：.+ # “”; \"\" are allowed for item name!')
                        }
                        else {
                            alert("提示：物品名称只允许输入中文和英文以及/ \ - % & ，,、()（）。* :：.+ # “”; \"\"等特殊字符！");
                        }
                        $('#fld_OTHERARTICLENAME').val('');
                        scrollTo(0, 0);
                    }
                    else {
                        var rowdata;
                        rowdata = "{";
                        rowdata += "\"applyreason\":\"" + $('#ddlApplyReason').val() + "\",";

                        rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                        rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                        rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                        rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                        rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                        rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\",";
                        rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\",";

                        rowdata += "\"supplier\":\"" + $('#ddlSupplier').find("option:selected").text() + "\",";
                        rowdata += "\"suppliercode\":\"" + $('#fld_SupplierCode').val() + "\",";

                        rowdata += "\"InvoiceType\":\"" + $('#ddlInvoiceType').find("option:selected").text() + "\",";
                        rowdata += "\"taxRate\":\"" + taxRate + "\",";
                        rowdata += "\"taxCode\":\"" + taxCode + "\",";

                        rowdata += "\"article\":\"" + $('#ddlArticle').find("option:selected").text() + "\",";
                        rowdata += "\"articlecode\":\"" + $("#hdArticleCode").val() + "\",";
                        rowdata += "\"otherarticlename\":\"" + $('#fld_OTHERARTICLENAME').val() + "\",";
                        // 
                        rowdata += "\"orderunit\":\"" + $('#ddlOrderUnit').val() + "\",";
                        rowdata += "\"orderunittext\":\"" + $('#ddlOrderUnit').find("option:selected").text() + "\",";

                        rowdata += "\"unit\":\"" + $('#ddlUnit').val() + "\",";
                        rowdata += "\"unittext\":\"" + $('#ddlUnit').find("option:selected").text() + "\",";

                        rowdata += "\"consumptionunit\":\"" + $('#ddlConsumptionUnit').val() + "\",";
                        rowdata += "\"consumptionunittext\":\"" + $('#ddlConsumptionUnit').find("option:selected").text() + "\",";

                        rowdata += "\"conversion\":\"" + $('#fld_CONVERSION').val() + "\",";
                        rowdata += "\"stock\":\"" + $('#fld_STOCK').val() + "\",";
                        rowdata += "\"netvomule\":\"" + $('#fld_NETVOMULE').val() + "\",";
                        rowdata += "\"netvomuleunit\":\"" + $('#ddlNetVomule').val() + "\",";
                        rowdata += "\"grossweight\":\"" + $('#fld_GROSSWEIGHT').val() + "\",";
                        rowdata += "\"grossweightunit\":\"" + $('#ddlGrossWeight').val() + "\",";

                        rowdata += "\"siteprice\":\"" + $('#fld_SITEPRICE').val() + "\",";
                        rowdata += "\"netnetprice\":\"" + $('#fld_NETNETPRICE').val() + "\",";
                        rowdata += "\"orderquantity\":\"" + $('#fld_ORDERQUANTITY').val() + "\",";
                        var unitprice = Number($('#fld_SITEPRICE').val());
                        var orderquantity = Number($('#fld_ORDERQUANTITY').val());
                        var subtotalamount = unitprice * orderquantity;
                        rowdata += "\"subtotalamount\":\"" + subtotalamount.toFixed(4).toString() + "\"";
                        rowdata += "}";

                        rowdata = "[" + rowdata + "]";
                        return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
                    }
                }
            }
        }
        //
}

var reg_oblique_line = new RegExp("\"", "g");
function returnValue2() {

    var flag = $("#form1").validationEngine('validate');
    // 
    if (!flag) {
        $(".formError").show();

        if ($('#ddlFamily').val() == "" || $('#ddlFamily').val() == null)
            if (language.toLowerCase() == "en-us") {
                $('#selectbtnfamily').validationEngine('showPrompt', 'Please improve the material classification', 'error');
            }
            else {
                $('#selectbtnfamily').validationEngine('showPrompt', '请完善物料分类', 'error');
            }
        return false;
    } else {
        //Add By Sylvia At 2020/05/12
        debugger
        var ArticleText = $('#ddlArticle').find("option:selected").text();
        var ArticlesText = $('#ddlArticles').find("option:selected").text();
        var familycode = ddlFamily.val();
        var subfamilycode = ddlSubFamily.val();
        var subsubfamilycode = ddlSubSubFamily.val();
        var orderunitvalue = $("#ddlOrderUnit").val();
        var unitvalue = $("#ddlUnit").val();
        var consumptionunit = $("#ddlConsumptionUnit").val();
        var suppliervalue = ddlSupplier.val();
        var suppliername = $('button[data-id="ddlSupplier"]').attr('title');
        var InvoiceTypeText = ddlInvoiceType.find("option:selected").text();
        var InvoiceType = ddlInvoiceType.val();
        var InvoiceTypeArr = InvoiceType.split('|');
        var taxRate = InvoiceTypeArr[1];
        var taxCode = InvoiceTypeArr[0];
        if (familycode == "" || subfamilycode == "" || subsubfamilycode == "") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : Material classification cannot be empty');
            }
            else {
                alert('提示：物料分类不能为空');
            }
            scrollTo(0, 0);
        }
        else if (InvoiceTypeText == "" || InvoiceTypeText == "请选择" || InvoiceTypeText == "Please Select") {
            alert('提示：票种不能为空');
            scrollTo(0, 0);
        }
        else if (orderunitvalue == null || unitvalue == null || consumptionunit == null || orderunitvalue == "请选择" || unitvalue == "请选择" || consumptionunit == "请选择" || orderunitvalue == "Please Select" || orderunitvalue == "Please Select" || orderunitvalue =="Please Select") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : The purchasing unit, inventory unit and consumption unit cannot be empty');
            }
            else {
                alert('提示：采购单位、库存单位以及消耗单位不能为空');
            }
            scrollTo(0, 400);
        }
        else if (suppliervalue == "") {
            if (suppliername == "" || suppliername == "请选择" || suppliername == "Please Select") {
                if (language.toLowerCase() == "en-us") {
                    alert('Tip : The supplier cannot be empty');
                }
                else {
                    alert('提示：供应商不能为空');
                }
                scrollTo(0, 0);
            }
        }
            //Update By Sylvia At 2019/12/09-16:27
            //9为授权供应商
        else if (suppliertype == '9') {
            if (ArticlesText == '' || ArticlesText == '请选择' || ArticlesText == 'Please Select') {
                if (language.toLowerCase() == "en-us") {
                    alert('Tip : please select item name！')
                }
                else {
                    alert('提示：请选择物品名称！')
                }
                scrollTo(0, 0);
            }
            else {
                var rowdata;
                rowdata = "{";
                rowdata += "\"applyreason\":\"" + $('#ddlApplyReason').val() + "\",";

                rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\",";
                rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\",";

                rowdata += "\"supplier\":\"" + $('#ddlSupplier').find("option:selected").text() + "\",";
                rowdata += "\"suppliercode\":\"" + $('#fld_SupplierCode').val() + "\",";

                rowdata += "\"InvoiceType\":\"" + $('#ddlInvoiceType').val() + "\",";
                rowdata += "\"taxRate\":\"" + taxRate + "\",";
                rowdata += "\"taxCode\":\"" + taxCode + "\",";

                //rowdata += "\"article\":\"" + $('#ddlArticles').find("option:selected").text() + "\",";
                if (ArticlesText.indexOf("\"") != -1) {
                    ArticlesText = ArticlesText.replace(reg_oblique_line, "\\\"");
                }
                rowdata += "\"article\":\"" + ArticlesText + "\",";

                rowdata += "\"articlecode\":\"" + $("#hdArticleCode").val() + "\",";
                rowdata += "\"otherarticlename\":\"" + $('#fld_OTHERARTICLENAME').val() + "\",";
                // 
                rowdata += "\"orderunit\":\"" + $('#ddlOrderUnit').val() + "\",";
                rowdata += "\"orderunittext\":\"" + $('#ddlOrderUnit').find("option:selected").text() + "\",";

                rowdata += "\"unit\":\"" + $('#ddlUnit').val() + "\",";
                rowdata += "\"unittext\":\"" + $('#ddlUnit').find("option:selected").text() + "\",";

                rowdata += "\"consumptionunit\":\"" + $('#ddlConsumptionUnit').val() + "\",";
                rowdata += "\"consumptionunittext\":\"" + $('#ddlConsumptionUnit').find("option:selected").text() + "\",";

                rowdata += "\"conversion\":\"" + $('#fld_CONVERSION').val() + "\",";
                rowdata += "\"stock\":\"" + $('#fld_STOCK').val() + "\",";
                rowdata += "\"netvomule\":\"" + $('#fld_NETVOMULE').val() + "\",";
                rowdata += "\"netvomuleunit\":\"" + $('#ddlNetVomule').val() + "\",";
                rowdata += "\"grossweight\":\"" + $('#fld_GROSSWEIGHT').val() + "\",";
                rowdata += "\"grossweightunit\":\"" + $('#ddlGrossWeight').val() + "\",";

                rowdata += "\"siteprice\":\"" + $('#fld_SITEPRICE').val() + "\",";
                rowdata += "\"netnetprice\":\"" + $('#fld_NETNETPRICE').val() + "\",";
                rowdata += "\"orderquantity\":\"" + $('#fld_ORDERQUANTITY').val() + "\",";
                var unitprice = Number($('#fld_SITEPRICE').val());
                var orderquantity = Number($('#fld_ORDERQUANTITY').val());
                var subtotalamount = unitprice * orderquantity;
                rowdata += "\"subtotalamount\":\"" + subtotalamount.toFixed(4).toString() + "\"";
                rowdata += "}";

                rowdata = "[" + rowdata + "]";
                //执行清空及保留部分操作

                ClearDialog();

                return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
            }
        }
        else {
            var OTHERARTICLENAME = $('#fld_OTHERARTICLENAME').val();
            if (OTHERARTICLENAME == '') {
                if (ArticleText == '' || ArticleText == '请选择' || ArticleText == 'Please Select') {
                    if (language.toLowerCase() == "en-us") {
                        alert('Tip : Please fill in the item name!')
                    }
                    else {
                        alert('提示：请填写物品名称！')
                    }
                }
                else {
                    var rowdata;
                    rowdata = "{";
                    rowdata += "\"applyreason\":\"" + $('#ddlApplyReason').val() + "\",";

                    rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                    rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                    rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                    rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\",";
                    rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\",";

                    rowdata += "\"supplier\":\"" + $('#ddlSupplier').find("option:selected").text() + "\",";
                    rowdata += "\"suppliercode\":\"" + $('#fld_SupplierCode').val() + "\",";

                    rowdata += "\"InvoiceType\":\"" + $('#ddlInvoiceType').find("option:selected").text() + "\",";
                    rowdata += "\"taxRate\":\"" + taxRate + "\",";
                    rowdata += "\"taxCode\":\"" + taxCode + "\",";

                    rowdata += "\"article\":\"" + $('#ddlArticle').find("option:selected").text() + "\",";
                    rowdata += "\"articlecode\":\"" + $("#hdArticleCode").val() + "\",";
                    rowdata += "\"otherarticlename\":\"" + $('#fld_OTHERARTICLENAME').val() + "\",";
                    // 
                    rowdata += "\"orderunit\":\"" + $('#ddlOrderUnit').val() + "\",";
                    rowdata += "\"orderunittext\":\"" + $('#ddlOrderUnit').find("option:selected").text() + "\",";

                    rowdata += "\"unit\":\"" + $('#ddlUnit').val() + "\",";
                    rowdata += "\"unittext\":\"" + $('#ddlUnit').find("option:selected").text() + "\",";

                    rowdata += "\"consumptionunit\":\"" + $('#ddlConsumptionUnit').val() + "\",";
                    rowdata += "\"consumptionunittext\":\"" + $('#ddlConsumptionUnit').find("option:selected").text() + "\",";

                    rowdata += "\"conversion\":\"" + $('#fld_CONVERSION').val() + "\",";
                    rowdata += "\"stock\":\"" + $('#fld_STOCK').val() + "\",";
                    rowdata += "\"netvomule\":\"" + $('#fld_NETVOMULE').val() + "\",";
                    rowdata += "\"netvomuleunit\":\"" + $('#ddlNetVomule').val() + "\",";
                    rowdata += "\"grossweight\":\"" + $('#fld_GROSSWEIGHT').val() + "\",";
                    rowdata += "\"grossweightunit\":\"" + $('#ddlGrossWeight').val() + "\",";

                    rowdata += "\"siteprice\":\"" + $('#fld_SITEPRICE').val() + "\",";
                    rowdata += "\"netnetprice\":\"" + $('#fld_NETNETPRICE').val() + "\",";
                    rowdata += "\"orderquantity\":\"" + $('#fld_ORDERQUANTITY').val() + "\",";
                    var unitprice = Number($('#fld_SITEPRICE').val());
                    var orderquantity = Number($('#fld_ORDERQUANTITY').val());
                    var subtotalamount = unitprice * orderquantity;
                    rowdata += "\"subtotalamount\":\"" + subtotalamount.toFixed(4).toString() + "\"";
                    rowdata += "}";

                    rowdata = "[" + rowdata + "]";
                    //执行清空及保留部分操作
                    ClearDialog();

                    return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
                }
            }
            else {
                //过滤特殊字符
                //Add by Sylvia 2018-5-22
                //Edit By Sylvia At 2020-08-04
                //var reg = /[`~!@#$%^&*()_+<>?:"{},.\/;'[\]]/im;
                //if (reg.test($('#fld_OTHERARTICLENAME').val())) {
                //    if (language.toLowerCase() == "en-us") {
                //        alert('Tip : the message you entered contains illegal characters! Please return to the top and fill in again!')
                //    }
                //    else {
                //        alert("提示：您输入的信息含有非法字符！请返回顶部重新填写！");
                //    }
                if ( OTHERARTICLENAME == '请选择' || OTHERARTICLENAME == 'Please Select') {
                    if (language.toLowerCase() == "en-us") {
                        alert('Tip : please select item name！')
                    }
                    else {
                        alert('提示：请选择物品名称！')
                    }
                    
                    scrollTo(0, 0);
                    return false;
                }
                var reg = /[`~@$^_￥……=<>?{}\'·！——|'《》？‘’【】]/;
                if (reg.test($('#fld_OTHERARTICLENAME').val())) {
                    if (language.toLowerCase() == "en-us") {
                        alert('Tip : Only Chinese and English and special characters such as / \ - % & ，,、()（）。* :：.+ # “”; \"\" are allowed for item name!')
                    }
                    else {
                        alert("提示：物品名称只允许输入中文和英文以及/ \ - % & ，,、()（）。* :：.+ # “”; \"\"等特殊字符！");
                    }
                    $('#fld_OTHERARTICLENAME').val('');
                    scrollTo(0, 0);
                }
                else {
                    var rowdata;
                    rowdata = "{";
                    rowdata += "\"applyreason\":\"" + $('#ddlApplyReason').val() + "\",";

                    rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                    rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                    rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                    rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\",";
                    rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\",";

                    rowdata += "\"InvoiceType\":\"" + $('#ddlInvoiceType').find("option:selected").text() + "\",";
                    rowdata += "\"taxRate\":\"" + taxRate + "\",";
                    rowdata += "\"taxCode\":\"" + taxCode + "\",";

                    rowdata += "\"supplier\":\"" + $('#ddlSupplier').find("option:selected").text() + "\",";
                    rowdata += "\"suppliercode\":\"" + $('#fld_SupplierCode').val() + "\",";

                    rowdata += "\"article\":\"" + $('#ddlArticle').find("option:selected").text() + "\",";
                    rowdata += "\"articlecode\":\"" + $("#hdArticleCode").val() + "\",";
                    rowdata += "\"otherarticlename\":\"" + $('#fld_OTHERARTICLENAME').val() + "\",";
                    // 
                    rowdata += "\"orderunit\":\"" + $('#ddlOrderUnit').val() + "\",";
                    rowdata += "\"orderunittext\":\"" + $('#ddlOrderUnit').find("option:selected").text() + "\",";

                    rowdata += "\"unit\":\"" + $('#ddlUnit').val() + "\",";
                    rowdata += "\"unittext\":\"" + $('#ddlUnit').find("option:selected").text() + "\",";

                    rowdata += "\"consumptionunit\":\"" + $('#ddlConsumptionUnit').val() + "\",";
                    rowdata += "\"consumptionunittext\":\"" + $('#ddlConsumptionUnit').find("option:selected").text() + "\",";

                    rowdata += "\"conversion\":\"" + $('#fld_CONVERSION').val() + "\",";
                    rowdata += "\"stock\":\"" + $('#fld_STOCK').val() + "\",";
                    rowdata += "\"netvomule\":\"" + $('#fld_NETVOMULE').val() + "\",";
                    rowdata += "\"netvomuleunit\":\"" + $('#ddlNetVomule').val() + "\",";
                    rowdata += "\"grossweight\":\"" + $('#fld_GROSSWEIGHT').val() + "\",";
                    rowdata += "\"grossweightunit\":\"" + $('#ddlGrossWeight').val() + "\",";

                    rowdata += "\"siteprice\":\"" + $('#fld_SITEPRICE').val() + "\",";
                    rowdata += "\"netnetprice\":\"" + $('#fld_NETNETPRICE').val() + "\",";
                    rowdata += "\"orderquantity\":\"" + $('#fld_ORDERQUANTITY').val() + "\",";
                    var unitprice = Number($('#fld_SITEPRICE').val());
                    var orderquantity = Number($('#fld_ORDERQUANTITY').val());
                    var subtotalamount = unitprice * orderquantity;
                    rowdata += "\"subtotalamount\":\"" + subtotalamount.toFixed(4).toString() + "\"";
                    rowdata += "}";

                    rowdata = "[" + rowdata + "]";
                    //执行清空及保留部分操作

                    ClearDialog();

                    return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
                }
            }
        }
    }
    // 

}

function ClearDialog() {

    var supplierValue = $('#ddlSupplier').val();

    var suppliercode = $('#fld_SupplierCode').val();

    var suppliername = $('#ddlSupplier').find("option:selected").text();

    $(':input', '#form1')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');

    $('#fld_SupplierCode').val(suppliercode);
    $('#hdSupplierCode').val(suppliercode);
    $('#hdSupplierName').val(suppliername);
    $('#ddlOrderUnit,#ddlUnit,#ddlConsumptionUnit,#ddlSubFamily,#ddlSubSubFamily,#ddlFamily,#ddlArticle,#ddlArticles').selectpicker('val', '');
    $('#ddlOrderUnit,#ddlUnit,#ddlConsumptionUnit,#ddlSubFamily,#ddlSubSubFamily,#ddlFamily,#ddlArticle,#ddlArticles').selectpicker('refresh');
    $('#fld_SupplierCode').attr("disabled", true);
    $('#fld_OTHERARTICLENAME').attr("disabled", false);
    ddlSupplier.selectpicker('val', supplierValue);
    ddlSupplier.prop('disabled', 'true');
    ddlSupplier.selectpicker('refresh');
    $('#ddlNetVomule,#ddlGrossWeight').val('KG');
    if (suppliertype != "9") {
        ddlArticles.empty();
    }
    else {
        BindArticle();
    }
    $("#hdArticleCode").val('');
    ddlArticles.selectpicker('val', '');
    ddlArticles.selectpicker('refresh');
    ddlArticle.empty();
    ddlArticle.selectpicker('val', '');
    ddlArticle.selectpicker('refresh');
    scrollTo(0, 0);
}

function showTempSelectData(options) {
    // 
    callback = options.callback;
    sql = options.sql;
    order = options.order;
    field = options.field;
    displayName = options.displayName;
    width = options.width;
    title = options.title;
    single = options.single;
    dbName = options.dbName;
    filter = options.filter;
    dataSource = options.dataSource;
    if (!title) {
        title = "";
    }
    if (!width) {
        width = "";
    }
    if (!order) {
        order = "";
    }
    if (!filter) {
        filter = "";
    }
    if (!dataSource) {
        dataSource = "";
    }

    if (typeof (_rootPath) == "undefined") {
        _rootPath = path;
    }
    url = _rootPath + "/Portal/Ultimus.UWF.Home.V3/SelectPage.aspx?sql=" + sql + "&order=" + order
        + "&query=" + field + "&caption=" + displayName + "&width=" + width + "&title=" + title + "&single=" + single + "&dbName=" + dbName + "&dataSource=" + dataSource + "&filter=" + filter;
    url = encodeURI(url);
    showTempForm({
        title: title,
        url: url,
        callback: callback,
        size: BootstrapDialog.SIZE_LARGE,
        height: 400, /* 460 ByJinJian 20170918*/
        returnFunc: "returnValue"
    });
}

//选择数据源
function selectTempDataSource(options) {
    element = options.element;
    fields = options.fields;
    dataSource = options.dataSource;
    single = options.single;
    filter = options.filter;
    title = options.title;
    IsMethod = options.IsMethod;
    if (!fields) {
        fields = "";
    }
    if (fields != "") {
        fields = element.id + "," + fields;
    }
    else {
        fields = element.id;
    }
    IsMethod = (IsMethod == null || IsMethod == '' || IsMethod == 'undefined') ? false : true;
    showTempSelectData({
        dataSource: dataSource,
        single: single,
        filter: filter,
        title: title,
        callback: function (objs) {
            // 
            var sz = fields.split(',');
            for (i = 0; i < sz.length; i++) {
                var str = "";
                $.each(objs, function (k, obj) {
                    var names = "";
                    var j = 0;
                    for (var name in obj) {
                        if (i == j) {
                            names = name;
                        }
                        j++;
                    }
                    str += obj[names] + ",";
                });
                if (sz[i].indexOf("fld_") < 0) {
                    //repeater
                    if (element.id.indexOf("_ctl") > 0) {
                        var ids = element.id.split('_');
                        var idpref = "";
                        for (l = 0; l < ids.length - 1; l++) {
                            idpref += ids[l] + "_";
                        }
                        $("#" + idpref + sz[i]).val(str.trimEnd(','));
                    }
                    else {
                        $("#fld_" + sz[i]).val(str.trimEnd(','));
                    }
                }
                else {
                    $("#" + sz[i]).val(str.trimEnd(','));
                }
            }

            ////判断是否返回父页面方法
            //if (IsMethod) {
            //    OpenerPageIsMethod(element.id);
            //}
        }
    });
}

function showTempForm(options) {
    url = options.url;
    callback = options.callback;
    title = options.title;
    height = options.height;
    size = options.size;
    if (!size) {
        size = BootstrapDialog.SIZE_LARGE;
    }
    if (!height) {
        height = "300";
    }
    if (!title) {
        title = "Information";
    }
    buttons = options.buttons;
    returnFunc = options.returnFunc;
    if (!buttons) {
        buttons = [{
            label: 'Ok',
            cssClass: 'btn btn-default btn-md',
            action: function (dialog) {
                //var ctl = $($(dialog.getModalBody().find('#frmWindow'))[0].contentWindow.document.getElementById("txtReturnValue"));
                if (returnFunc) {
                    // 
                    var func = "var val=$(dialog.getModalBody().find('#frmWindow'))[0].contentWindow." + returnFunc + "();";
                    eval(func);

                    if (val) {
                        dialog.close();

                        var sz = fields.split(',');
                        for (i = 0; i < sz.length; i++) {
                            var str = "";
                            $.each(objs, function (k, obj) {
                                var names = "";
                                var j = 0;
                                for (var name in obj) {
                                    if (i == j) {
                                        names = name;
                                    }
                                    j++;
                                }
                                str += obj[names] + ",";
                            });
                            if (sz[i].indexOf("fld_") < 0) {
                                //repeater
                                if (element.id.indexOf("_ctl") > 0) {
                                    var ids = element.id.split('_');
                                    var idpref = "";
                                    for (l = 0; l < ids.length - 1; l++) {
                                        idpref += ids[l] + "_";
                                    }
                                    $("#" + idpref + sz[i]).val(str.trimEnd(','));
                                }
                                else {
                                    $("#fld_" + sz[i]).val(str.trimEnd(','));
                                }
                            }
                            else {
                                $("#" + sz[i]).val(str.trimEnd(','));
                            }
                        }
                        //if (callback) {
                        //    debuuger
                        //    callback(val);
                        //}
                    }
                }
                else {
                    dialog.close();
                }
            }
        }, {
            label: 'Cancel',
            cssClass: 'btn btn-md',
            action: function (dialog) {
                dialog.close();
            }
        }];
    }

    BootstrapDialog.show({
        title: title,
        animate: false,
        size: size,
        message: $('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' scrolling="no" frameborder="no" style="border-width:0px;"></iframe>'),
        buttons: buttons
    });
}

//Add by sylvia at 20190321
function checkPositiveInteger(field, rules, i, options) {
    if (field.val != '') {
        var reg = /^[1-9]+\d*$/;
        if (reg.test(field.val())) {
            return;
        } else {
            options.allrules.validate2fields.alertText = "请输入大于0的正整数";
            $("#fld_ORDERQUANTITY").val('');
            return options.allrules.validate2fields.alertText;
        }
    }
}
function checkPositiveInteger5(field, rules, i, options) {
    if (field.val() != '') {
        var reg = /([1-9]\d*(\.\d*[1-9])?)/;
        if (reg.test(field.val())) {
            return;
        } else {
            options.allrules.validate2fields.alertText = "请输入大于0的数";
            // $("#fld_STOCK").val('');
            return options.allrules.validate2fields.alertText;
        }
    }
}


function checkPositiveInteger4(field, rules, i, options) {

    if (field.val() != '') {
        var reg = /([1-9]\d*(\.\d*[1-9])?)/;
        if (reg.test(field.val())) {
            return;
        } else {
            options.allrules.validate2fields.alertText = "请输入大于0的数";
            // $("#fld_STOCK").val('');
            return options.allrules.validate2fields.alertText;
        }
    }
}
//Add by sylvia at 20200417
//修改为可输入整数、大于0且带有一位小数、大于0且带有两位小数
function checkPositiveInteger1(field, rules, i, options) {
    debugger
    var NetVomule = $("#ddlNetVomule").val();
    if (NetVomule == "KG") {
        if (field.val != '') {
            var reg = /(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{1}$)|(^[0-9]*\.[0-9]{2}$)/;
            //var reg = /([1-9]\d*(\.\d*[1-9])?)|(0\.\d*[1-9])/;
            if (reg.test(field.val())) {
                var orderquantity = $("#fld_ORDERQUANTITY").val();
                if (orderquantity.split('.')[1] == "00" || orderquantity.split('.')[1] == "0") {
                    $("#fld_ORDERQUANTITY").val(parseInt(orderquantity));
                }
                else {
                    if (orderquantity.indexOf(".") != -1) {
                        var lastnum = orderquantity.substr(orderquantity.length - 1, 1);
                        if (lastnum == "0") {
                            var new_orderquantity = orderquantity.substr(0, orderquantity.length - 1);
                            $("#fld_ORDERQUANTITY").val(new_orderquantity);
                        }
                    }
                }
                return;
            } else {
                if (language.toLowerCase() == "en-us") {
                    options.allrules.validate2fields.alertText = "Please enter an integer greater than 0 or keep one or two decimal places";
                }
                else {
                    options.allrules.validate2fields.alertText = "请输入大于0的整数或者保留一到两位小数";
                }
                $("#fld_ORDERQUANTITY").val('');
                return options.allrules.validate2fields.alertText;
            }
        }
    }
    else {
        if (field.val != '') {
            var reg = /^[1-9]+\d*$/;
            if (reg.test(field.val())) {
                return;
            } else {
                options.allrules.validate2fields.alertText = "请输入大于0的正整数";
                $("#fld_ORDERQUANTITY").val('');
                return options.allrules.validate2fields.alertText;
            }
        }
    }
}

//Add by sylvia at 20200608
//修改为可输入整数、大于0且带有一位小数、大于0且带有两位小数
function checkPositiveInteger2(field, rules, i, options) {
    if (field.val != '') {
        var reg = /(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{1}$)|(^[0-9]*\.[0-9]{2}$)/;
        //var reg = /([1-9]\d*(\.\d*[1-9])?)|(0\.\d*[1-9])/;
        if (reg.test(field.val())) {
            var siteprice = $("#fld_SITEPRICE").val();
            if (siteprice.split('.')[1] == "00" || siteprice.split('.')[1] == "0") {
                $("#fld_SITEPRICE").val(parseInt(siteprice));
            }
            else {
                if (siteprice.indexOf(".") != -1) {
                    var lastnum = siteprice.substr(siteprice.length - 1, 1);
                    if (lastnum == "0") {
                        var new_siteprice = siteprice.substr(0, siteprice.length - 1);
                        $("#fld_SITEPRICE").val(new_siteprice);
                    }
                }
            }
            return;
        } else {
            if (language.toLowerCase() == "en-us") {
                options.allrules.validate2fields.alertText = "Please enter an integer greater than 0 or keep one or two decimal places";
            }
            else {
                options.allrules.validate2fields.alertText = "请输入大于0的整数或者保留一到两位小数";
            }
            $("#fld_SITEPRICE").val('');
            return options.allrules.validate2fields.alertText;
        }
    }
}


//Add by sylvia at 20200622
//修改带有两位小数(去掉0)
function checkPositiveInteger3() {
    var siteprice = $("#fld_SITEPRICE").val();
    if (siteprice.split('.')[1] == "00" || siteprice.split('.')[1] == "0") {
        $("#fld_SITEPRICE").val(parseInt(siteprice));
    }
    else {
        if (siteprice.indexOf(".") != -1) {
            var lastnum = siteprice.substr(siteprice.length - 1, 1);
            if (lastnum == "0") {
                var new_siteprice = siteprice.substr(0, siteprice.length - 1);
                $("#fld_SITEPRICE").val(new_siteprice);
            }
        }
    }
}

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}

function CheckTaxnomy(tam) {
    var tamCount = $(tam + ' option').length;
    switch (tam) {
        case "#ddlSubFamily":
            if (tamCount <= 1) {
                $(tam + '_span').hide();
                $(tam).removeClass('validate[required]');
                $('#ddlSubSubFamily_span').hide();
                $('#ddlSubSubFamily').removeClass('validate[required]');
                //$('#ddlTaxnomyFive_span').hide();
                //$('#ddlTaxnomyFive').removeClass('validate[required]');
                //$('#ddlTaxnomySix_span').hide();
                //$('#ddlTaxnomySix').removeClass('validate[required]');
            } else {
                $(tam + '_span').show();
                $(tam).addClass('validate[required]');
            }
            break;
        case "#ddlSubSubFamily":
            if (tamCount <= 1) {
                $(tam + '_span').hide();
                $(tam).removeClass('validate[required]');
                //$('#ddlTaxnomyFive_span').hide();
                //$('#ddlTaxnomyFive').removeClass('validate[required]');
                //$('#ddlTaxnomySix_span').hide();
                //$('#ddlTaxnomySix').removeClass('validate[required]');
            } else {
                $(tam + '_span').show();
                $(tam).addClass('validate[required]');
            }
         //break;
        //case "#ddlTaxnomyFive":
        //    if (tamCount <= 1) {
        //        $(tam + '_span').hide();
        //        $(tam).removeClass('validate[required]');
        //        $('#ddlTaxnomySix_span').hide();
        //        $('#ddlTaxnomySix').removeClass('validate[required]');
        //    } else {
        //        $(tam + '_span').show();
        //        $(tam).addClass('validate[required]');
        //    }
        //    break;
        //case "#ddlTaxnomySix":
        //    if (tamCount <= 1) {
        //        $(tam + '_span').hide();
        //        $(tam).removeClass('validate[required]');
        //    } else {
        //        $(tam + '_span').show();
        //        $(tam).addClass('validate[required]');
        //    }
            break;
        default: ""
    }

}

function BindSupplier() {
    var datadata = "";
    if (suppliertype == "9") {
        datadata = "{\"suppliertype\":\"" + suppliertype + "\",\"searchcondition\":\"" + $("#hdAuthorizedSupplierCode").val() + "\",\"pccode\":\"" + $('#hdSiteCode').val() + "\",\"subfamilycode\":\"" + $('#hiddenTAXNOMYLASTCODE').val() + "\"}";
    }
    else {
        datadata = "{\"suppliertype\":\"" + suppliertype + "\",\"searchcondition\":\"" + searchSupplier + "\",\"pccode\":\"" + $('#hdSiteCode').val() + "\",\"subfamilycode\":\"" + $('#hiddenTAXNOMYLASTCODE').val() + "\"}";
    }

    //if (suppliertype == "2") {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindSupplier',
        data: datadata,
        //data: function () { return { 'selectedCategory': selectedCategory } },
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlSupplier.empty();
                debugger
                if (language.toLowerCase() == "en-us") {
                    ddlSupplier.append("<option value=''>Please Select</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlSupplier.append("<option value='" + arrData[i].SupplierCode + "'>" + arrData[i].SupplierNameEN + "</option>");
                    }
                }
                else {
                    ddlSupplier.append("<option value=''>请选择</option>");
                    for (var i = 0; i < arrData.length; i++) {
                        ddlSupplier.append("<option value='" + arrData[i].SupplierCode + "'>" + arrData[i].SupplierNameCN + "</option>");
                    }
                }
                debugger
                if ($("#hdSupplierCode").val() != "") {
                    ddlSupplier.selectpicker('val', $("#hdSupplierCode").val());
                    ddlSupplier.prop('disabled', 'true');
                    ddlSupplier.selectpicker('refresh');
                    $('#fld_SupplierCode').val($("#hdSupplierCode").val());
                    //ddlSupplier.parent().children('div').find('button').attr("id", "selectbtnsupplier");
                } else {
                    if (suppliertype == "9") {
                        if ($("#ddlSupplier option").length > 1) {
                            ddlSupplier.selectpicker('val', $("#hdAuthorizedSupplierCode").val());
                            ddlSupplier.prop('disabled', 'true');
                            ddlSupplier.selectpicker('refresh');
                            $('#fld_SupplierCode').val($("#hdAuthorizedSupplierCode").val());
                        }
                        else {
                            alert('无法查询到当前物料所对应的的供应商，请联系管理员！\r\nUnable to find the supplier corresponding to the current material, please contact the administrator')
                        }
                    }
                    else {
                        ddlSupplier.selectpicker('val', '');
                        ddlSupplier.selectpicker('refresh');
                        //Add By Sylvia At 2019/12/24
                        $('#fld_SupplierCode,#fld_OTHERARTICLENAME').val('');
                        $('#dlArticle,#ddlArticles').empty();
                        $('#dlArticle,#ddlArticles').selectpicker('val', '');
                        $('#dlArticle,#ddlArticles').selectpicker('refresh');
                    }
                }
            } else {
                //ddlSupplier.empty();
                //ddlSupplier.parent().children('div').find('button').attr("id", "selectbtnsupplier");

                //Add By Sylvia At 2019/12/24
                $('#fld_SupplierCode,#fld_OTHERARTICLENAME').val('');
                $('#ddlSupplier,#dlArticle,#ddlArticles').empty();
                $('#ddlSupplier,#dlArticle,#ddlArticles').selectpicker('val', '');
                $('#ddlSupplier,#dlArticle,#ddlArticles').selectpicker('refresh');
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {


        }
    });
}

function BindArticle() {
    debugger

    var siteCode = $('#hdSiteCode').val();
    var articlefamily = $('#hiddenTAXNOMYLASTCODE').val();
    var suppliercode = $("#fld_SupplierCode").val();

    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/BindArticle',
        //data: "{\"sitecode\":\"" + siteCode + "\",\"articlefamily\":\"" + articlefamily + "\"}",
        data: "{\"sitecode\":\"" + siteCode + "\",\"articlefamily\":\"" + articlefamily + "\",\"suppliertype\":\"" + suppliertype + "\",\"suppliercode\":\"" + suppliercode + "\",\"category\":\"" + category + "\",\"searchcondition\":\"" + searchArticles + "\"}",
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                ddlArticle.empty();
                ddlArticles.empty();

                if (language.toLowerCase() == "en-us") {
                    ddlArticle.append("<option value=''>Please Select</option>");
                    ddlArticles.append("<option value=''>Please Select</option>");
                }
                else {
                    ddlArticle.append("<option value=''>请选择</option>");
                    ddlArticles.append("<option value=''>请选择</option>");
                }

                for (var i = 0; i < arrData.length; i++) {
                    var IsOneTimeUsing = arrData[i].IsOneTimeUsing;
                    var UseTimes = arrData[i].UseTimes;
                    var ddlvalue = "";
                    //alert(IsOneTimeUsing);
                    if (IsOneTimeUsing == "") {
                        //非授权供应商及员工垫资
                        //alert("非授权供应商及员工垫资");
                        ddlvalue = arrData[i].UOM_PurUnit + "|" + arrData[i].UOM_Pur2InvRate + "|" + arrData[i].UOM_InvUnit + "|" + arrData[i].UOM_Inv2UseRate + "|" + arrData[i].UOM_UseUnit + "|" + arrData[i].Gross_weight + "|" + arrData[i].NetVolume + "|" + arrData[i].NetVolumeUnit + "|" + arrData[i].ArticleCode;
                        ddlArticle.append("<option value='" + ddlvalue + "'>" + arrData[i].SubSubFamilyTextCN +"  "+ arrData[i].ArticleName + "</option>");
                    }
                    else if (IsOneTimeUsing == "1" || IsOneTimeUsing == "0") {
                        debugger
                        //授权供应商
                        //if (IsOneTimeUsing == "1") {
                        //    if (UseTimes < 1) {
                        //        ddlvalue = arrData[i].UOM_PurUnit + "|" + arrData[i].UOM_Pur2InvRate + "|" + arrData[i].UOM_InvUnit + "|" + arrData[i].UOM_Inv2UseRate + "|" + arrData[i].UOM_UseUnit + "|" + arrData[i].Gross_weight + "|" + arrData[i].NetVolume + "|" + arrData[i].NetVolumeUnit + "|" + arrData[i].ArticleFamily + "|" + arrData[i].SupplierCode + "|" + arrData[i].SitePrice + "|" + arrData[i].NetNetPrice + "|" + arrData[i].ArticleCode;
                        //        ddlArticles.append("<option value='" + ddlvalue + "'>" + arrData[i].ArticleName + "</option>");
                        //    }//SitePrice
                        //}
                        //else {
                        //    ddlvalue = arrData[i].UOM_PurUnit + "|" + arrData[i].UOM_Pur2InvRate + "|" + arrData[i].UOM_InvUnit + "|" + arrData[i].UOM_Inv2UseRate + "|" + arrData[i].UOM_UseUnit + "|" + arrData[i].Gross_weight + "|" + arrData[i].NetVolume + "|" + arrData[i].NetVolumeUnit + "|" + arrData[i].ArticleFamily + "|" + arrData[i].SupplierCode + "|" + arrData[i].SitePrice + "|" + arrData[i].NetNetPrice + "|" + arrData[i].ArticleCode;
                        //    ddlArticles.append("<option value='" + ddlvalue + "'>" + arrData[i].ArticleName + "</option>");
                        //}
                        ddlvalue = arrData[i].UOM_PurUnit + "|" + arrData[i].UOM_Pur2InvRate + "|" + arrData[i].UOM_InvUnit + "|" + arrData[i].UOM_Inv2UseRate + "|" + arrData[i].UOM_UseUnit + "|" + arrData[i].Gross_weight + "|" + arrData[i].NetVolume + "|" + arrData[i].NetVolumeUnit + "|" + arrData[i].ArticleFamily + "|" + arrData[i].SupplierCode + "|" + arrData[i].SitePrice + "|" + arrData[i].NetNetPrice + "|" + arrData[i].ArticleCode;
                        ddlArticles.append("<option value='" + ddlvalue + "'>" + arrData[i].SubSubFamilyTextCN + "  " + arrData[i].ArticleName+ "</option>");
                    }

                    //var ddlvalue = arrData[i].UOM_PurUnit + "|" + arrData[i].UOM_Pur2InvRate + "|" + arrData[i].UOM_InvUnit + "|" + arrData[i].UOM_Inv2UseRate + "|" + arrData[i].UOM_UseUnit + "|" + arrData[i].Gross_weight + "|" + arrData[i].NetVolume + "|" + arrData[i].NetVolumeUnit;
                    //ddlArticle.append("<option value='" + ddlvalue + "'>" + arrData[i].ArticleName + "</option>");
                }
                ddlArticle.selectpicker('val', '');
                ddlArticle.selectpicker('refresh');
                ddlArticles.selectpicker('val', '');
                ddlArticles.selectpicker('refresh');
            } else {
                ddlArticle.empty();
                ddlArticles.empty();
                ddlArticle.selectpicker('val', '');
                ddlArticle.selectpicker('refresh');
                ddlArticles.selectpicker('val', '');
                ddlArticles.selectpicker('refresh');
            }
        }
    });
}
function CheckTaxnomy(tam) {
    var tamCount = $(tam + ' option').length;
    switch (tam) {
        case "#ddlSubFamily":
            if (tamCount <= 1) {
                $(tam + '_span').hide();
                $(tam).removeClass('validate[required]');
                $('#ddlSubSubFamily_span').hide();
                $('#ddlSubSubFamily').removeClass('validate[required]');
                //$('#ddlTaxnomyFive_span').hide();
                //$('#ddlTaxnomyFive').removeClass('validate[required]');
                //$('#ddlTaxnomySix_span').hide();
                //$('#ddlTaxnomySix').removeClass('validate[required]');
            } else {
                $(tam + '_span').show();
                $(tam).addClass('validate[required]');
            }
            break;
        case "#ddlSubSubFamily":
            if (tamCount <= 1) {
                $(tam + '_span').hide();
                $(tam).removeClass('validate[required]');
                //$('#ddlTaxnomyFive_span').hide();
                //$('#ddlTaxnomyFive').removeClass('validate[required]');
                //$('#ddlTaxnomySix_span').hide();
                //$('#ddlTaxnomySix').removeClass('validate[required]');
            } else {
                $(tam + '_span').show();
                $(tam).addClass('validate[required]');
            }
            //break;
            //case "#ddlTaxnomyFive":
            //    if (tamCount <= 1) {
            //        $(tam + '_span').hide();
            //        $(tam).removeClass('validate[required]');
            //        $('#ddlTaxnomySix_span').hide();
            //        $('#ddlTaxnomySix').removeClass('validate[required]');
            //    } else {
            //        $(tam + '_span').show();
            //        $(tam).addClass('validate[required]');
            //    }
            //    break;
            //case "#ddlTaxnomySix":
            //    if (tamCount <= 1) {
            //        $(tam + '_span').hide();
            //        $(tam).removeClass('validate[required]');
            //    } else {
            //        $(tam + '_span').show();
            //        $(tam).addClass('validate[required]');
            //    }
            break;
        default: ""
    }

}

function GetArticle() {
    debugger

    var siteCode = $('#hdSiteCode').val();
    var articlefamily = $('#hiddenTAXNOMYLASTCODE').val();
    var suppliercode = $("#fld_SupplierCode").val();
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'AddPRItemPage.aspx/GetArticle',
        //data: "{\"sitecode\":\"" + siteCode + "\",\"articlefamily\":\"" + articlefamily + "\"}",
        data: "{\"sitecode\":\"" + siteCode + "\",\"articlefamily\":\"" + articlefamily + "\",\"suppliertype\":\"" + suppliertype + "\",\"suppliercode\":\"" + suppliercode + "\",\"category\":\"" + category + "\",\"searchcondition\":\"" + searchArticles + "\"}",
        success: function (data) {
            if (data.d != "") {
                var arrData = JSON.parse(data.d);
                sltArticle.empty();
                if (language.toLowerCase() == "en-us") {
                    sltArticle.append("<option value=''>Please Select</option>");
                }
                else {
                    sltArticle.append("<option value=''>请选择</option>");
                }

                for (var i = 0; i < arrData.length; i++) {
                 {
                        //非授权供应商及员工垫资
                        //alert("非授权供应商及员工垫资");
                        ddlvalue = arrData[i].FamilyCode + "|" + arrData[i].SubFamilyCode + "|" + arrData[i].SubSubFamilyCode + "|" + arrData[i].ArticleName;
                        sltArticle.append("<option value='" + ddlvalue + "'>" + arrData[i].ArticleName + " " + arrData[i].FamilyNameCN + "/" + arrData[i].SubFamilyNameCN + "/" + arrData[i].SubSubFamilyNameCN + "</option>");
                 }

                }
                sltArticle.selectpicker('val', '');
                sltArticle.selectpicker('refresh');

            } else {
                sltArticle.empty();
                sltArticle.selectpicker('val', '');
                sltArticle.selectpicker('refresh');

            }
        }
    });
}




