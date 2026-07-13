//Custom method write here
function beforeSubmit() {
    return true;
}

//初始化页面
$(function () {
    Page_Load();
    //员工编号 进行显示
    //员工编号 进行显示 设置高度为100
    $("#UserInfo1_read_APPLICANTACCOUNT").parent().parent("div").parent("div").removeAttr("hidden");
    $("#UserInfo1_read_APPLICANTACCOUNT").parent().parent("div").parent("div").css("height", "50px");
    $("#UserInfo1_read_APPLICANTACCOUNT").parent().parent("div").css("height", "50px");
    //隐藏之前的 申请部门
    $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
    if (StepName.toUpperCase() == "BEGIN") {
        $("#rowPrint").css("display", "none");
        $("#ButtonList1_btnAbortIncident").css("display", "none");
      
            $("#approvalrow").next().css("display", "none");
        
    }
})

//Begin
//=============================================================Begin 自定义事件方法=============================================================//
function Page_Load() {
    Page_Main();
    Page_Details();
}

/// <summary>
/// 默认加载主表
///</summary>
function Page_Main() {

}

/// <summary>
/// 默认加载明细行
///</summary>
function Page_Details() {

}
var StepName = getUrlParam('StepName');
//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}

//=============================================================End 自定义事件方法=============================================================//
//End

//Begin
//=============================================================Begin OnChange事件=============================================================//


//=============================================================End OnChange事件=============================================================//
//End