//***********************标准表单的js存放文件***********************
var path = "/UWF";
var orgName = "Business Organization";

//隐藏Toolbar
//window.parent.theRows.rows = "0,*";

//设置路径
var r = document.getElementsByTagName("script");
for (var i = 0; i <= r.length; i++) {
    var obj = r[i];
    if (obj) {
        if (obj.src.toLowerCase().indexOf("standard.js") > 0) {
            path = obj.src.toLowerCase().replace("common/assets/js/standard.js", "");
        }
    }
}
//加载jquery
document.write("<script language='javascript' src='" + path + "/common/assets/js/jquery.js'></script>");


function showPage(sql, order, displayField, displayFieldCaption, displayFieldWidth, title, dbName) {
    if (!dbName) {
        dbName = "BizDB";
    }
    str = path + "/Common/SelectPage.aspx?dbName=" + dbName + "&sql=" + sql + "&order=" + order + "&query=" + displayField + "&caption=" + displayFieldCaption + "&width=" + displayFieldWidth + "&title=" + title;
    str = encodeURI(str);
    val = window.showModalDialog(str, null, "scroll:1;status:0;help:0;dialogWidth=800px;dialogHeight=480px");
    if (!val) {
        val = window.returnValue;
    }
    return val;
}

//选主数据
function selectPage1() {
    rtn = showPage(
        "SELECT NAME,REMARK,ISACTIVE FROM COM_APPSETTINGS",
        "NAME", "NAME,REMARK,ISACTIVE",
        "名称,备注,Active",
        "100,50,50",
        "选择窗口", "BizDB");
    if (!rtn) { return; }
    window.parent.frames[0].document.theFCO.setVarValue("TaskData.Global.Data1", rtn.NAME);
    window.parent.frames[0].document.theFCO.setVarValue("TaskData.Global.Data2", rtn.REMARK);
}

function selectPage(type,varName,varValue) {
    rtn = showPage(
        "SELECT NAME,VALUE,REMARK FROM COM_RESOURCE WHERE TYPE='"+type+"'", 'NAME', 'NAME,VALUE,REMARK', '名称,值,描述', '50,50,50',
        "选择窗口", "BizDB");
    if (!rtn) { return; }
    window.parent.frames[0].document.theFCO.setVarValue(varName, rtn.NAME);
    if (!varValue) {
        window.parent.frames(0).document.theFCO.setVarValue(varValue, rtn.VALUE);
    }
}

function selectSupplier() {
    rtn = showPage(
        "SELECT ID,NAME,CODE,VALUE,ISACTIVE FROM COM_RESOURCE WHERE TYPE='Supplier' AND ISACTIVE=1",
        "ID", "NAME,CODE,VALUE",
        "供应商名称,编号,描述",
        "100,50,50",
        "选择窗口", "BizDB");
    if (!rtn) { return; }
    window.parent.frames(0).document.theFCO.setVarValue("TaskData.Global.SupplierName", rtn.NAME);
    window.parent.frames(0).document.theFCO.setVarValue("TaskData.Global.SupplierNo", rtn.CODE);
}

function selectItems() {
    var ifco = window.parent.frames(0).document.theFCO;
    rtn = showPage(
        "SELECT ID,NAME,CODE,VALUE,ISACTIVE FROM COM_RESOURCE WHERE TYPE='MaterialItem' AND ISACTIVE=1",
        "ID", "NAME,CODE,VALUE",
        "物品名称,编号,描述",
        "100,50,50",
        "选择窗口", "BizDB");

    row = document.grdItem.GetCurrentSelection();
    if (!row) {
        row = "TaskData.Global.Item1[1]";
    }
    ifco.SetVarValue(row+".Name", rtn.NAME);
    ifco.SetVarValue(row + ".Desc", rtn.VALUE);
    document.grdItem.RefreshData();
}

//单选人员
function selectUser2(idVar, nameVar) {
    var val;
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.OrgChart/SelectUserFromAD.aspx?Type=1", null, "dialogWidth=900px;dialogHeight=500px");
    if (!val) {
        val = window.returnValue;
    }
    if (val) {
        val = val.replace("\\", '/');
        var obj = eval(val);//转换为json对象 eval("(" + val + ")") eval(val);
        var names = "";
        var ids = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i == 0) {
                    names += obj[i].Name;
                    ids += obj[i].LoginName;
                }
                else {
                    names += "," + obj[i].Name;
                    ids += "," + obj[i].LoginName;
                }
            }
        }

        var ifco = window.parent.frames(0).document.theFCO;
        ifco.SetVarValue(idVar, ids);
        ifco.SetVarValue(nameVar, names);
    }
}
//多选人员
function selectUser(idVar, nameVar) {
    var ifco = window.parent.frames[0].document.theFCO;
    var val;
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.OrgChart/SelectUser.aspx?Type=2", null, "dialogWidth=900px;dialogHeight=500px");
    var id = new Array();
    if (!val) {
        val = window.returnValue;
    }
    if (val) {
        val = val.replace("\\",'/');
        var obj = eval(val);
        var names = "";
        var ids = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i == 0) {
                    names += obj[i].Name.replace("[USER]", "");
                    ids += obj[i].LoginName;
                }
                else {
                    names += "," + obj[i].Name.replace("[USER]", "");
                    ids += "," + obj[i].LoginName;
                }
                id[i] = "USER:org=" + orgName + ",user=" + obj[i].LoginName.replace("\\", "/");

            }
        }

        ifco.SetVarValuesArray(idVar, id);
        ifco.SetVarValue(nameVar, names);
    }
}

//多选部门
function selectDept(idVar, nameVar) {
    var val;
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.OrgChart/SelectUserFromAD.aspx?Type=4", null, "dialogWidth=900px;dialogHeight=500px");
    if (!val) {
        val = window.returnValue;
    }
    if (val) {
        var obj = eval(val);
        var names = "";
        var ids = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i == 0) {
                    names += obj[i].Name;
                    ids += obj[i].ID;
                }
                else {
                    names += "," + obj[i].Name;
                    ids += "," + obj[i].ID;
                }
            }
        }

        var ifco = window.parent.frames[0].document.theFCO;
        ifco.SetVarValue(idVar, ids);
        ifco.SetVarValue(nameVar, names);
    }
}

//多选部门
function selectDeptArray(idVar, nameVar) {
    var val;
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.OrgChart/SelectUserFromAD.aspx?Type=4", null, "dialogWidth=900px;dialogHeight=500px");
    if (!val) {
        val = window.returnValue;
    }
    var id = new Array();
    if (val) {
        var obj = eval(val);
        var names = "";
        var ids = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i == 0) {
                    names += obj[i].Name;
                    ids += obj[i].ID;
                }
                else {
                    names += "," + obj[i].Name;
                    ids += "," + obj[i].ID;
                }
                id[i] = obj[i].ID;
            }
        }

        var ifco = window.parent.frames[0].document.theFCO;
        ifco.SetVarValuesArray(idVar, id);
        ifco.SetVarValue(nameVar, names);
    }
}

//多选岗位
function selectJob(idVar, nameVar) {
    var val;
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.OrgChart/SelectUserFromAD.aspx?Type=5", null, "dialogWidth=900px;dialogHeight=500px");
    if (!val) {
        val = window.returnValue;
    }
    if (val) {
        var obj = eval(val);
        var names = "";
        var ids = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i == 0) {
                    names += obj[i].Job;
                    ids += obj[i].Job;
                }
                else {
                    names += "," + obj[i].Job;
                    ids += "," + obj[i].Job;
                }
            }
        }

        var ifco = window.parent.frames[0].document.theFCO;
        ifco.SetVarValue(idVar, ids);
        ifco.SetVarValue(nameVar, names);
    }
}

function selectPage2() {
    var ifco = window.parent.frames[0].document.theFCO;
    rtn = showPage(
        "SELECT NAME,REMARK,ISACTIVE FROM COM_APPSETTINGS",
        "NAME", "NAME,REMARK,ISACTIVE",
        "名称,备注,Active",
        "100,50,50",
        "选择窗口");

    row = document.grdItem.GetCurrentSelection();
    if (!row) {
        row = "TaskData.Global.Item1[1]";
    }
    ifco.SetVarValue("TaskData.Global.Item1[1].Name", rtn[0].NAME);
    ifco.SetVarValue("TaskData.Global.Item1[1].Qty", rtn[0].ISACTIVE);

    ifco.SetVarValue("TaskData.Global.Item1[2].Name", rtn[1].NAME);
    ifco.SetVarValue("TaskData.Global.Item1[2].Qty", rtn[1].ISACTIVE);

    document.grdItem.RefreshData();
}

function getValue() {
    var ifco = window.parent.frames[0].document.theFCO;
    var v = ifco.getVarValue("TaskData.Global.Item1[1].Name");
    alert(v);

    //str=document.grdItem.GetCurrentSelection();
    ///alert(str);

}

function addRow() {
    var ifco = window.parent.frames[0].document.theFCO;
    ifco.XSAddNew("TaskData.Global.Item1");
}



function loadButton(frmId, type) {

    //表单居中
    $("body *").each(function () {
        if ($(this).css("left") != "auto") {
            if ($(document.body).width() > 850) {
                try {
                    $(this).css({ "left": eval(eval($(this).css("left").replace("px", "") * 1) + eval($(document.body).width() - eval($("div[id*='FrameBody']:eq(0)").css("width").replace("px", ""))) / 2) + "px" });
                }
                catch (e) {
                }
            }
        }
    });

    //type:1 开始节点 2 同意 3 同意+不同意
    //任务状态为待办才显示
    var ifco = window.parent.frames[0].document.theFCO;
    var taskStatus = ifco.GetTaskStatus();

    var flag = 0;
    if ((type == 1 || type == 10 || type == 2 || type == 20) && taskStatus == 1) {
        //添加提交
        $("#" + frmId).append("<div id='div_area' style='height:43 px;padding-top:10px;'><center><input style='height:28;color:#ffffff;background-color:#008663;font-family:Calibri;font-style:normal;font-weight:bold;font-size:10pt;width:80px;' id='btn_form_submit'  type='button' value='Submit'></center></div>");
        flag = 1;
    }

    if ((type == 3 || type == 30) && taskStatus == 1) {
        //添加同意
        $("#" + frmId).append("<div id='div_area' style='height:43 px;padding-top:10px;'><center><input style='height:28;color:#ffffff;background-color:#008663;font-family:Calibri;font-style:normal;font-weight:bold;font-size:10pt;width:80px;' id='btn_form_approve'   type='button' value='Approve'></center></div>");
        flag = 1;

        //添加不同意
        $("#div_area").find("center").append("&nbsp;&nbsp;<input style='height:28;color:#ffffff;background-color:#008663;font-family:Calibri;font-style:normal;font-weight:bold;font-size:10pt;width:80px;' id='btn_form_return'  type='button' value='Reject'>");
    }
    
    $("#btn_form_submit").click(function () {
        SubmitForm()
    });

    $("#btn_form_approve").click(function () {
        Approve()
    });

    $("#btn_form_return").click(function () {
        ReturnForm()
    });
}

//定时器,如不能提交则再次启用提交
var timerSubmit;
function ToggleSubmitButton() {
    $("#btn_form_submit").val("Submit");
    $("#btn_form_submit").attr("disabled", false);
}

var timerSubmit;
function ToggleApproveButton() {
    $("#btn_form_approve").val("Approve");
    $("#btn_form_approve").attr("disabled", false);
}

var timerSubmit;
function ToggleReturnButton() {
    $("#btn_form_return").val("Reject");
    $("#btn_form_return").attr("disabled", false);
}

//验证表单
function validationForm() {
//    var ifco = window.parent.frames[0].document.theFCO;
//    var processName = ifco.getProcessName();
//    if (processName == "Chop Application") {
//        var reason3 = ifco.getVarValue("TaskData.Global.Reason3");
//        var reason3Text = ifco.getVarValue("TaskData.Global.Reason3Text");
//        if (reason3) {
//            if (!reason3Text) {
//                alert('Please input one year approved document no!');
//                return false;
//            }
//        }
//    }
    return true;
}

//注册提交
function SubmitForm() {
    try {
        if (($("input[type$='button']").size() > 0 && $("input[type$='button']").eq("0").attr("disabled") == true)) {
            return false;
        }

        if (!validationForm()) {
            return false;
        }

        timerSubmit = setInterval(ToggleSubmitButton, 10000);    //启动定时器
        $(this).val("Waiting...");
        $(this).attr("disabled", true);
        if (confirm("Do you want to submit?")) {
            $("#btn_form_submit").val("Submit");
            $("#btn_form_submit").attr("disabled", false);
            window.parent.frames[0].document.theFCO.DoFormSubmit(1);    //send form
        }

    } catch (e) {

    }
}

//注册同意
function Approve() {
    try {
        if (($("input[type$='button']").size() > 0 && $("input[type$='button']").eq("0").attr("disabled") == true)) {
            return false;
        }

        var iFCO = window.parent.frames[0].document.theFCO;
        timerSubmit = setInterval(ToggleApproveButton, 10000);    //启动定时器
        $(this).val("Waiting...");
        $(this).attr("disabled", true);
        if (confirm("Do you want to approve?")) {

            $.post(
                    "/uwf/Portal/ultimus.uwf.workflow/controller/TaskClient.ashx",
                    { method: 'SubmitTask', taskId: iFCO.GetTaskID(), stepLabel: iFCO.GetStepLabel(), processName: iFCO.GetProcessName(), incident: iFCO.GetIncidentNo(), t: new Date().getTime() },
                    function (data, status) {
                       
                        $("#btn_form_approve").val("Approve");
                        $("#btn_form_approve").attr("disabled", false);
                        window.parent.frames[0].document.theFCO.DoFormSubmit(1);    //send form
                    }
                );


        }

    } catch (e) {

    }
}

//注册不同意
function ReturnForm() {
    try {
        if (($("input[type$='button']").size() > 0 && $("input[type$='button']").eq("0").attr("disabled") == true)) {
            return false;
        }
        var iFCO = window.parent.frames[0].document.theFCO;
        var comments = iFCO.GetVarValue("TaskData.Global.Comments");
        if (!comments) {
            alert('Please input comments!');
            return;
        }


        timerSubmit = setInterval(ToggleReturnButton, 10000);    //启动定时器
        $(this).val("Waiting...");
        $(this).attr("disabled", true);

        var iFCO = window.parent.frames[0].document.theFCO;

        if (confirm("Do you want to reject?")) {
            $.post(
                    "/uwf/Portal/ultimus.uwf.workflow/controller/TaskClient.ashx",
                    { method: 'ReturnTask', taskId: iFCO.GetTaskID(), stepLabel: iFCO.GetStepLabel(), processName: iFCO.GetProcessName(), incident: iFCO.GetIncidentNo(), t: new Date().getTime() },
                    function (data, status) {
                       
                        $("#btn_form_return").val("Reject");
                        $("#btn_form_return").attr("disabled", false);
                        window.parent.frames[0].document.theFCO.DoFormSubmit(0);    //send form
                    }
                );
        }

    } catch (e) {

    }
}

//加载审批意见
function loadHistory(history) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var processname = iFCO.GetProcessName();

    var inc = iFCO.GetIncidentNo();
    var url = path + "/Portal/Ultimus.UWF.Workflow/History.aspx?ProcessName=" + escape(processname) + "&Incident=" + inc + "&t=" + new Date().getTime();
    var strHtml = "<IFRAME id='fr_History' width='100%' height='100%' SRC='" + url + "' frameborder='no'  marginwidth='5' marginheight='5' scrolling='yes'  allowtransparency='true'></IFRAME>";
    document.getElementById(history).innerHTML = strHtml;
    //调整高度
    $('#fr_History').load(function () {
        var d = $('#fr_History').contents().find("table tr").size();
        var hh = 0;
        if (d <= 4) {
            hh = eval(d * 28);
            $("#fr_History").css("height", hh + "px");
        } else {
            hh = eval(d * 28);
            $("#fr_History").css("height", hh + "px");
        }
        var t = $("#" + history).css("top").replace("px", "");   //History的TOP
        $("body").append("<div style='position:absolute;top:" + eval(eval(t) + hh + 100) + "px;height:100px;'>&nbsp;</div>");

    });
}

//加载附件
function loadAttachment(controlId, readOnly) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var processname = iFCO.GetProcessName();
    var formId = iFCO.getVarValue("TaskData.Global.FormID");

    var inc = iFCO.GetIncidentNo();
    var taskStatus = iFCO.GetTaskStatus();
    var url = path + "/Portal/Ultimus.UWF.Workflow/AttachmentControl.aspx?taskStatus=" + taskStatus + "&ReadOnly=" + readOnly + "&TYPE=" + controlId + "&FormID=" + formId + "&ProcessName=" + escape(processname) + "&Incident=" + inc + "&t=" + new Date().getTime();
    var strHtml = "<IFRAME id='frm" + controlId + "' width='98%'  SRC='" + url + "' frameborder='no'  marginwidth='5' marginheight='5' scrolling='yes'  allowtransparency='true'></IFRAME>";
    document.getElementById(controlId).innerHTML = strHtml;
    //调整高度
    var a = window.parent.frames[1].document.getElementById(controlId).style.height;
    try
    {
        $('#frm' + controlId).css("height", a);
    }
    catch (e) {
    }
}

//加载正文
function loadWord(controlId, readOnly) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var processname = iFCO.GetProcessName();
    var formId = iFCO.getVarValue("TaskData.Global.FormID");

    var inc = iFCO.GetIncidentNo();
    var taskStatus = iFCO.GetTaskStatus();
    var url = path + "/Portal/Ultimus.UWF.Workflow/AttachmentControl.aspx?ISWORD=1&taskStatus=" + taskStatus + "&ReadOnly=" + readOnly + "&TYPE=" + controlId + "&FormID=" + formId + "&ProcessName=" + escape(processname) + "&Incident=" + inc + "&t=" + new Date().getTime();
    var strHtml = "<IFRAME id='frm" + controlId + "' width='98%' height='100%' SRC='" + url + "' frameborder='no'  marginwidth='5' marginheight='5' scrolling='yes'  allowtransparency='true'></IFRAME>";
    document.getElementById(controlId).innerHTML = strHtml;
    //调整高度
    var a = window.parent.frames[1].document.getElementById(controlId).style.height;
    $('#frm' + controlId).css("height", a);
}

//预览正文
function previewWord(controlId) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var formId = iFCO.getVarValue("TaskData.Global.FormID");
    var url = path + "/Portal/Ultimus.UWF.Workflow/AttachmentPreview.aspx?TYPE=" + controlId + "&FormID=" + formId + "&t=" + new Date().getTime();
    window.open(url);
}

//获取Url
function getPreviewWord(controlId) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var formId = iFCO.getVarValue("TaskData.Global.FormID");
    var url = path + "/Portal/Ultimus.UWF.Workflow/AttachmentPreview.aspx?TYPE=" + controlId + "&FormID=" + formId + "&t=" + new Date().getTime();
    return url;
}

//预览正文Show
function showWord(controlId) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var processname = iFCO.GetProcessName();
    var formId = iFCO.getVarValue("TaskData.Global.FormID");

    var inc = iFCO.GetIncidentNo();
    var taskStatus = iFCO.GetTaskStatus();
    var url = path + "/Portal/Ultimus.UWF.Workflow/AttachmentPreview.aspx?TYPE=" + controlId + "&FormID=" + formId + "&ProcessName=" + escape(processname) + "&Incident=" + inc + "&t=" + new Date().getTime();
    var strHtml = "<IFRAME id='frm" + controlId + "' width='98%' height='100%' SRC='" + url + "' frameborder='no'  marginwidth='5' marginheight='5' scrolling='yes'  allowtransparency='true'></IFRAME>";
    document.getElementById(controlId).innerHTML = strHtml;
    //window.open(url);
    //调整高度
    var a = window.parent.frames[1].document.getElementById(controlId).style.height;
    $('#frm' + controlId).css("height", a);
}

//协办或抄送
function showAsst(processName) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var taskId = iFCO.GetTaskID();

    var val;
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.Workflow/AsstTask.aspx?taskId=" + taskId + "&ProcessName=" + escape(processName), null, "dialogWidth=600px;dialogHeight=300px");
}

//Grid导出
var strExportString = "";
function Export(varName, colNames) {
    var iFCO = window.parent.frames[0].document.theFCO;
    var pre;
    var current = iFCO.XSMoveFirst(varName);
    var sz = colNames.split(',');
    var str = "";
    for (j = 0; j < sz.length; j++) {
        str += sz[j] + "|";
    }
    str += "~";
    for (i = 1; i < 100; i++) {
        for (j = 0; j < sz.length; j++) {
            var colName = sz[j];
            colName = colName.split('[')[0];
            str += iFCO.GetVarValue(current + "." + colName) + "|";
        }
        str += "~";
        current = iFCO.XSMoveNext(varName);
        if (pre == current) {
            break;
        }
        pre = current;
    }
    strExportString = str; //格式为c1|c2|~c3|c4~c5|c6
    window.open(path + "/Portal/Ultimus.UWF.Office/GridExport.aspx");
}

function GetExportString() {
    return strExportString;
}

//Grid导入
var w;
function Import(varName, colNames) {
    w = window.open(path + "/Portal/Ultimus.UWF.Office/GridImport.aspx?varName=" + varName + "&colNames=" + escape(colNames));
}

function AddNewRow(varName) {
    var iFCO = window.parent.frames[0].document.theFCO;
    iFCO.XSAddNew(varName);
    //iFCO.XSLastFirst(varName);
}

function SetImport(varName, value) {
    var iFCO = window.parent.frames[0].document.theFCO;
    iFCO.SetVarValue(varName, value);
}


function refreshData(ele) {
    try {
        document.grdItem.RefreshData();
    }
    catch (e) {
    }
}

//设置文本输入框为只读
function setDisabled(str) {
    $("#" + str).keydown(function () {
        return false;
    });
    $("#" + str).attr("readonly", true);
}

//打印
//加载审批意见
function printProcess() {
    var iFCO = window.parent.frames[0].document.theFCO;
    var processname = iFCO.GetProcessName();
    var stepName = iFCO.GetStepLabel();
    var incidentNo = iFCO.GetIncidentNo();
    var version = "";
    var taskId = iFCO.GetTaskID();

    window.open("/Web_Print/PrintDoc.aspx?ProcessName=" + processname + "&StepName=" + stepName + "&IncidentNo=" + incidentNo + "&ProcessVersion=" + version + "&TaskID=" + taskId);
}

/**
* 弹出主数据选择窗口
* @width    弹出窗口的宽度
* @height   弹出窗口的高度
* @strSQL   执行的语句编号
* @strName  列名
* @strWidth 列宽
* @strConn  连接数据库的key,oleDB
* @strOrder 排序列名
* @strTitle 弹出页面的标题
* @isMulti  是否多选（值：1或null)
*/
function OpenModal(width, height, strSQL, strName, strWidth, strConn, strOrder, strTitle, isMulti) {
    var strUrl = path + "/Portal/Ultimus.UWF.Common/olePage4.aspx?SQL=" + strSQL + "&Name=" + escape(strName) + "&Width=" + strWidth + "&Conn=" + strConn + "&Order=" + strOrder + "&t=" + new Date().getTime() + "&Title=" + escape(strTitle) + (isMulti != undefined ? "&isMulti=1" : "");
    return window.showModalDialog(strUrl, "", "dialogWidth:" + width + "px; dialogHeight:" + height + "px; dialogLeft: status:no; directories:yes;scrollbars:auto;Resizable=no; ");
}