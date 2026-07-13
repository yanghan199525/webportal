//Custom method write here
function beforeSubmit() {
    return true;
}

//初始化页面
$(function () {
   // Page_Load();
    ch_click();
    showbnt();
    approve();
    //reject();
   
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
function ch_click() {
    // 全选/反选功能
    $("#ch_btn").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".item-checkbox input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".item-checkbox input[type='checkbox']").on("click", function () {
        var allChecked = $(".item-checkbox input[type='checkbox']:checked").length === $(".item-checkbox input[type='checkbox']").length;
        $("#ch_btn").prop("checked", allChecked);

    });

}
function showview(suppliercode, batchnumber) {
    url = "Items.aspx?suppliercode=" + suppliercode + "&batchnumber=" + batchnumber;
    url = encodeURI(url);
    //window.open(url, "Add Article", "frameborder = no style = 'border-width:0px;overflow-y:auto;overflow-x:hidden;'");
    //url = "Items.aspx?suppliercode=" + suppliercode + "&batchnumber=" + batchnumber;
    //url = encodeURI(url);
    //var height = '500px';
    //buttons = [{
    //    label: 'Cancel',
    //    cssClass: 'btn btn-md',
    //    action: function (dialog) {
    //        dialog.close();
    //    }
    //}];
    //BootstrapDialog.show({
    //    title: '添加物料清单',
    //    animate: false,
    //    closable: false,
    //    size: BootstrapDialog.SIZE_WIDE,
    //    message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'),
    //    buttons: buttons
    //});
    //// 使用window.open打开新窗口，替代模态框
    const newWindow = window.open(url, '_blank');

    // 监听新窗口加载完成事件
    if (newWindow) {
        newWindow.addEventListener('load', function () {
            try {
                // 尝试修改标题（仅同源有效）
                newWindow.document.title = '物料清单 - 新窗口';
                console.log('标题修改成功');
            } catch (e) {
                // 跨域时会抛出异常
                console.log('无法修改标题（可能跨域）：', e);
            }
        });
    }

    

}

function showbnt() {
    $("button[name='showbnt']").show(); // 显示
}
function approve() {
    $("#ButtonList1_btnApprove").click(function () {
        // 点击后执行的代码
        $("#approvalType").val("1");
        if ($(".item-checkbox :checked").length == 0) {
            // 有选中项
            alert("请选择需要通过审批的列！");
        }
        // 示例：阻止默认行为（如果是链接或提交按钮）
        // event.preventDefault();
    });
}
//function reject() {
//    $("#ButtonList1_btnReject").click(function () {
//        // 点击后执行的代码
//        var txtComments = $("#ApprovalHistory1_txtComments").val();
//        $("#fld_REASONS").val(txtComments);
//    });
//}
//=============================================================End 自定义事件方法=============================================================//
//End

//Begin
//=============================================================Begin OnChange事件=============================================================//


//=============================================================End OnChange事件=============================================================//
//End