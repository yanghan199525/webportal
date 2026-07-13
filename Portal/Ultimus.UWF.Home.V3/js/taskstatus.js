//鼠标移上去显示流程审批详细步骤
function showTaskSteps(e, processName, incident, serverName) {
    //获取流程详细步骤
    var vDataToHtml = getTaskStepsHtmlData(e.id, processName, incident, serverName);
    if (vDataToHtml.indexOf("<td>") > 0) {
        //弹出框
        $('#' + e.id).popover({
            html: true,
            title: tasktitle,
            animation: false,
            content: vDataToHtml,//测试：'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
            container: false,
            trigger: 'manual',
            placement: 'right',
            container: 'body'
        });
        $('#' + e.id).popover('show');
    }
}

//鼠标离开隐藏流程审批详细步骤
function hideTaskSteps(e) {
    $('#' + e.id).popover('hide');
}

//获取任务表详细步骤，转换为html显示
function getTaskStepsHtmlData(id, processName, incident, serverName) {
    var shtml;
    $.ajax({
        url: "TaskStepsOverview.ashx?t=" + Math.random() + "&ProcessName=" + processName + "&Incident=" + incident + "&ServerName=" + serverName,
        cache: true,
        async: false,
        dataType: 'html',
        success: function (data) {
            shtml = data;
        }
    })
    return shtml;
}
