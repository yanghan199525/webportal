//Custom method write here
function beforeSubmit() {
    return true;
}

//初始化页面
$(function () {
    Page_Load();
    reject();   
    crequired();
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
function reject() {
    $("#ButtonList1_btnReject").click(function () {
        // 点击后执行的代码
        var txtComments = $("#ApprovalHistory1_txtComments").val();
        $("#fld_REASONS").val(txtComments);         
    });
}
function crequired() {
    $("#ApprovalHistory1_txtComments").addClass('validate[required]');
}


//=============================================================End 自定义事件方法=============================================================//
//End

//Begin
//=============================================================Begin OnChange事件=============================================================//


//=============================================================End OnChange事件=============================================================//
//End