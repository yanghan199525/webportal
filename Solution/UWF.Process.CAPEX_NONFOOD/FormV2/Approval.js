$(function () {
    if (isIE()) {
        alert("提醒：审批流模块在IE浏览器下可能会出现系统错误，请切换至Edge或Chrome浏览器访问。Remind：Process approval  module’s system operation may have errors in IE browser, please change to Edge or Chrome.");
        window.close();
    }
    ckneedaccept_click();
    ckremovable_click();
    ckbuybacktermt_click();
    chdisabled();
    querysearch();
    showpicture();
    //document.addEventListener('click', function (event) {
    //    if (event.target.id === 'ButtonList1_btnApprove') {
    //        window.close();
    //    }
    //});
    // 为所有.stassetclass元素绑定点击事件
    acceptClick();

})

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window)
        return true;

    else
        return false;
}

function ckneedaccept_click() {
    // 全选/反选功能
    $("#ch_needaccept").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".ckneedacceptItem input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".ckneedacceptItem input[type='checkbox']").on("click", function () {
        var allChecked = $(".ckneedacceptItem input[type='checkbox']:checked").length === $(".ckneedacceptItem input[type='checkbox']").length;
        $("#ch_needaccept").prop("checked", allChecked);

    });
    //validateAssetTypes();

}
function ckbuybacktermt_click() {
    // 全选/反选功能
    $("#ch_buybackterm").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".ckbuybacktermitem input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".ckbuybacktermitem input[type='checkbox']").on("click", function () {
        var allChecked = $(".ckbuybacktermitem input[type='checkbox']:checked").length === $(".ckbuybacktermitem input[type='checkbox']").length;
        $("#ch_buybackterm").prop("checked", allChecked);

    });

}
function ckremovable_click() {
    // 全选/反选功能
    $("#ch_removable").on("click", function () {
        var isChecked = $(this).prop("checked");
        $(".ckremovableitem input[type='checkbox']").prop("checked", isChecked);

    });
    // 单个复选框事件
    $(".ckremovableitem input[type='checkbox']").on("click", function () {
        var allChecked = $(".ckremovableitem input[type='checkbox']:checked").length === $(".ckremovableitem input[type='checkbox']").length;
        $("#ch_removable").prop("checked", allChecked);

    });

}
function chdisabled() {
    if ($("#approvalType").val() == "0") {
        $(".ckneedacceptItem input[type='checkbox']").addClass('disabled-checkbox');
        $(".ckbuybacktermitem input[type='checkbox']").addClass('disabled-checkbox');
        $(".ckremovableitem input[type='checkbox']").addClass('disabled-checkbox');
        $("#ch_needaccept").addClass('disabled-checkbox');
        $("#ch_buybackterm").addClass('disabled-checkbox');
        $("#ch_removable").addClass('disabled-checkbox');
        $('.tbusefullife').prop('readonly', true);
        $('.tbusefullife').addClass('form-control');
        $('.stassetclass').addClass('disabled-checkbox');
        $('[id*="fld_ASSETCLASS"]').each(function () {
            $(this).addClass('disabled-checkbox');
        });
        $('[id*="fld_USEFULLIFE"]').each(function () {
            $(this).addClass('disabled-checkbox');
        });
    } else {
        $(".ckneedacceptItem input[type='checkbox']").removeClass('disabled-checkbox');
        $(".ckbuybacktermitem input[type='checkbox']").removeClass('disabled-checkbox');
        $(".ckremovableitem input[type='checkbox']").removeClass('disabled-checkbox');
        $("#ch_needaccept").removeClass('disabled-checkbox');
        $("#ch_buybackterm").removeClass('disabled-checkbox');
        $("#ch_removable").removeClass('disabled-checkbox');
        $('.tbusefullife').prop('readonly', false);
        $('.tbusefullife').removeClass('form-control');
        $('.stassetclass').removeClass('disabled-checkbox');
        $('[id*="fld_ASSETCLASS"]').each(function () {
            $(this).removeClass('disabled-checkbox');
        });
        $('[id*="fld_USEFULLIFE"]').each(function () {
            $(this).removeClass('disabled-checkbox');
        });
    }
}
function showpicture() {
    // 原始逗号分隔的字符串（示例数据，可替换为实际值）
    const fileUrls = $('#fld_UPLOADS').val();

    // 拆分字符串为数组
    const urlArray = fileUrls.split(',');

    // 生成超链接 HTML
    const linkHtml = urlArray.map(url => {
        // 提取文件名（从 URL 中截取最后一部分，可根据实际情况调整）
        const fileName = url.split('/').pop();

        // 判断文件类型，添加对应图标（可选）
        let fileIcon = '';
        if (fileName.endsWith('.pdf')) fileIcon = '<i class="fa fa-file-pdf-o"></i> ';
        else if (fileName.endsWith('.png') || fileName.endsWith('.jpg')) fileIcon = '<i class="fa fa-file-image-o"></i> ';
        else fileIcon = '<i class="fa fa-file-o"></i> ';

        return `<a href="${url}" target="_blank" class="file-link">
                    ${fileIcon}${fileName}
                </a>`;
    }).join(', '); // 用逗号+空格分隔超链接

    // 将生成的 HTML 插入指定容器
    $('#div_uploads').html(linkHtml);
}
function querysearch() {
    if ($("#approvalType").val() == "1") {
        $('.stassetclass').selectpicker({
            liveSearch: true, // 启用搜索功能
            liveSearchPlaceholder: '搜索...', // 搜索框占位文本
            showTick: true, // 显示选中图标
        });
        search();
    }
}
function search() {
    $('[id*="fld_ASSETCLASS"]').each(function () {   
        $(this).selectpicker({
            liveSearch: true, // 启用搜索功能
            liveSearchPlaceholder: '搜索...', // 搜索框占位文本
            showTick: true, // 显示选中图标
            
        });
        //$(this).show();
        $(this).css({
            width: 0,
            height: 0,
            opacity: 0,
            display: 'block'  // 添加 display: block
        });
    });
    $('[id*="fld_USEFULLIFE"]').each(function () {
        $(this).selectpicker({
            liveSearch: true, // 启用搜索功能
            liveSearchPlaceholder: '搜索...', // 搜索框占位文本
            showTick: true, // 显示选中图标

        });
        //$(this).show();
        $(this).css({
            width: 0,
            height: 0,
            opacity: 0,
            display: 'block'  // 添加 display: block
        });
    });
}
function acceptClick() {
    // 1. 为所有“验收/质保标志”下拉框绑定change事件
    $('.stassetclass').on('change', function () {
        // 2. 获取当前下拉框的选中值
        var selectedValue = $(this).val();
        // 3. 找到当前下拉框所在的<tr>行
        var $row = $(this).closest('tr');
        // 4. 找到该行的“是否需要验收”复选框
        var $needAcceptCheckbox = $row.find('[id*="fld_NEEDACCEPT"]');

        // 5. 根据选中值设置复选框状态
        if (selectedValue == 'AcceptancePoint' || selectedValue == 'AssurancePoint' || selectedValue == '1') {
            $needAcceptCheckbox.prop('checked', true); // 勾选复选框
        } else {
            $needAcceptCheckbox.prop('checked', false); // 取消勾选
        }
    });

    // （可选）页面加载时初始化：触发一次change事件，确保初始状态正确
    //$('.stassetclass').trigger('change');
}
//function approve() {
//    $("#ButtonList1_btnApprove").click(function () {
//        // 点击后执行的代码

//        if (HasCheckedNeedAccept()) {
//            if (!acceptCheck()) {
//                return false;
//            }
//        } 
//        // 示例：阻止默认行为（如果是链接或提交按钮）
//        // event.preventDefault();
//    });
//}
//function HasCheckedNeedAccept() {
//    // 匹配所有 class=ckneedacceptItem 的复选框
//    var $checkBoxList = $(".ckneedacceptItem");
//    // 筛选出已勾选的
//    var $checked = $checkBoxList.filter(":checked");
//    // 返回布尔值：true=存在选中，false=全部未选
//    return $checked.length > 0;
//}
////加载询价单号
//function acceptCheck() {
//    debugger
//    $.ajax({
//        type: "post",
//        datatype: "json",
//        contentType: "application/json",
//        async: false,
//        url: 'Approval.aspx/acceptCheck',
//        data: "{\"siteCode\":\"" + $("#fld_SITECODE") + "\",\"supplierCode\":\"" + $("#fld_SUPPLIERCODE") + "\",\"capexNumber\":\"" + $("#fld_CAPEXNUMBER") + "\",\"formId\":\"" + $("#fld_FORMID") + "\"}",
//        success: function (data) {
//            debugger
//            if (data.d != "1") {
//                alert("已经存在验收点的数据！");
//                return false;
//            } 
//        }
//    });
//}





