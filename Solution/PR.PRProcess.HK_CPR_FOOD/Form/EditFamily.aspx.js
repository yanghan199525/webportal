
var ddlFamily = $('#ddlFamily');
var ddlSubFamily = $('#ddlSubFamily');
var ddlSubSubFamily = $('#ddlSubSubFamily');
var category = "";
var sitecode = "";
var language = "zh-CN";

var searchSupplier = "";
var searchArticles = "";

$(function () {
    // alert($("#hdFamilyCode").val());
    debugger
    category = $('#hdCategory').val();
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
        
    }

   
    ///加载一级
    BindFamily(category);

    ddlFamily.on('change', function (e) {
            BindSubFamily(category, ddlFamily.val());

    });
  
    ddlSubFamily.on('change', function (e) {
            BindSubSubFamily(category, ddlFamily.val(), ddlSubFamily.val());
   
    });

    ddlSubSubFamily.on('change', function (e) {
        if ($('#ddlSubSubFamily').val() != "") {
            BindSubSubFamilyCE();
        }
    });

    ddlFamily.parent().children('div').find('button').attr("id", "selectbtnfamily");

    
});

function BindLanguage() {

    var username = $("#hdUserName").val().split('\\')[1];

    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'EditFamily.aspx/BindLanguage',
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
        url: 'EditFamily.aspx/BindFamily',
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
             if ($("#hdFamilyCode").val() != "") {
                debugger
                ddlFamily.selectpicker('val', $("#hdFamilyCode").val());
                ddlFamily.selectpicker('refresh');
                BindSubFamily(category, $("#hdFamilyCode").val());
                ddlFamily.prop('disabled', 'true');

            }
           
        }
    });
}


function BindSubFamily(category, family) {

    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'EditFamily.aspx/BindSubFamily',
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
                
                    ddlSubFamily.selectpicker('val', '');
                ddlSubFamily.selectpicker('refresh');

                ddlSubSubFamily.empty();
                ddlSubSubFamily.selectpicker('val', '');
                ddlSubSubFamily.selectpicker('refresh');


            } else {
                $('#ddlSubFamily,#ddlSubSubFamily').empty();
                $('#ddlSubFamily,#ddlSubSubFamily').selectpicker('val', '');
                $('#ddlSubFamily,#ddlSubSubFamily').selectpicker('refresh');
                
            }
        }
    });
}

function BindSubSubFamily(category, family, subfamily) {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'EditFamily.aspx/BindSubSubFamily',
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
               
                 ddlSubSubFamily.selectpicker('val', '');                
                ddlSubSubFamily.selectpicker('refresh');
                ddlSubSubFamily.parent().children('div').find('button').attr("id", "selectbtnsubsubfamily");
               
            } else {
                ddlSubSubFamily.empty();
                ddlSubSubFamily.parent().children('div').find('button').attr("id", "selectbtnsubsubfamily");
                ddlSubSubFamily.selectpicker('val', '');
                ddlSubSubFamily.selectpicker('refresh');                          
               
            }
 
        }
    });
}

function BindSubSubFamilyCE() {
    $.ajax({
        type: "POST",
        datatype: "json",
        contentType: "application/json",
        url: 'EditFamily.aspx/BindSubSubFamilyCE',
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


///回调函数
function returnValue1() {
    var flag = $("#form1").validationEngine('validate');
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
        debugger        
        var familycode = ddlFamily.val();
        var subfamilycode = ddlSubFamily.val();
        var subsubfamilycode = ddlSubSubFamily.val();
        if (familycode == "" || subfamilycode == "" || subsubfamilycode == "") {
            if (language.toLowerCase() == "en-us") {
                alert('Tip : Material classification cannot be empty');
            }
            else {
                alert('提示：物料分类不能为空');
            }
            scrollTo(0, 0);
        }
        else {                          
                    var rowdata;
                    rowdata = "{";
                    rowdata += "\"familyname\":\"" + $('#ddlFamily').find("option:selected").text() + "\",";
                    rowdata += "\"familycode\":\"" + $('#ddlFamily').val() + "\",";

                    rowdata += "\"subfamilyname\":\"" + $('#ddlSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subfamilycode\":\"" + $('#ddlSubFamily').val() + "\",";

                    rowdata += "\"subsubfamilyname\":\"" + $('#ddlSubSubFamily').find("option:selected").text() + "\",";
                    rowdata += "\"subsubfamilycode\":\"" + $('#ddlSubSubFamily').val() + "\","; 
                    rowdata += "\"subsubfamilyce\":\"" + $("#hdSubSubFamilyCe").val() + "\"";
                    rowdata += "}";
                    rowdata = "[" + rowdata + "]";
                    return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));

        }
    }
}






