var lan = ""

$(function () {

    lan = $("#hdLanguage").val().toLowerCase();

    $(".USER_SignedApprover2").click(function () {
        var fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
        if (fld_USER_SIGNEDAPPROVERNAME !== "") {
            debugger
            selectSignedApprover(1, 'fld_USER_SIGNEDAPPROVER2NAME', '', 'fld_USER_SIGNEDAPPROVER2');
        }
        else {
            if (lan == "en-us") {
                alert('Please select the level 1 addendum approver first');
            }
            else {
                alert('请先选择一级加签审批人');
            }
        }
    })

    $(".USER_SignedApprover3").click(function () {
        var fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
        var fld_USER_SIGNEDAPPROVER2NAME = $("#fld_USER_SIGNEDAPPROVER2NAME").val();
        if (fld_USER_SIGNEDAPPROVERNAME != "") {
            if (fld_USER_SIGNEDAPPROVER2NAME !== "") {
                selectSignedApprover(1, 'fld_USER_SIGNEDAPPROVER3NAME', '', 'fld_USER_SIGNEDAPPROVER3');
            }
            else {
                if (lan == "en-us") {
                    alert('Please select the secondary addendum approver first');
                }
                else {
                    alert('请先选择二级加签审批人');
                }
            }
        }
        else {
            if (lan == "en-us") {
                alert('Please select the level 1 addendum approver first');
            }
            else {
                alert('请先选择一级加签审批人');
            }
        }
    })
})

function selectSignedApprover(type, nameCtl, idCtl, accountCtl) {
    debugger
    selectSignedApproverInfo(type, nameCtl, idCtl, accountCtl, null);
}

//选择组织架构
//all:选择任意
//user:单选人
//users:多选人
//dept:单选部门
//depts:多选部门
//是否从ifram页面弹出的
function selectSignedApproverInfo(type, nameCtl, idCtl, accountCtl, callback, isiframopen) {
    debugger
    var olddata = "";
    try {
    }
    catch (e) {
    }
    if (lan == "en-us") {
        var options = {
            title: "Choose to Sign the Approver",
            oktext: "Confirm",
            canceltext: "Cancel",
            width: "700px",
            height: "430px",
            url: path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectSignedApproverEn.aspx?userId=1&language=" + lan,
            // url:  "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectSignedApproverEn.aspx?userId=1&language=" + lan,
            //url: path + "/Portal/Ultimus.UWF.OrgChart/SelectSignedApprover.aspx",
            callback: function (val) {
                if (val) {
                    debugger
                    var obj = val;
                    var names = "";
                    var ids = "";
                    var accs = "";
                    if (obj) {
                        for (i = 0; i < obj.length; i++) {
                            if (i == 0) {
                                names += obj[i].LOGINNAME;
                                ids += obj[i].USERID + "|" + obj[i].TYPE;
                                accs += obj[i].LOGINNAME;
                            }
                            else {
                                names += "," + obj[i].LOGINNAME;
                                ids += "," + obj[i].USERID + "|" + obj[i].TYPE;
                                accs += "," + obj[i].LOGINNAME;
                            }
                        }
                    }
                    try {
                        isiframopen == true ? $(window.frames["frmWindow"][0].contentWindow.document).find("#" + nameCtl).val(names) : $("#" + nameCtl).val(names);
                        //$("#" + nameCtl).val(names)
                    }
                    catch (e) {
                    }
                    try {
                        isiframopen == true ? $(window.frames["frmWindow"][0].contentWindow.document).find("#" + idCtl).val(ids) : $("#" + idCtl).val(ids);

                        //$("#" + idCtl).val(ids); 
                    }
                    catch (e) {
                    }
                    try {
                        isiframopen == true ? $(window.frames["frmWindow"][0].contentWindow.document).find("#" + accountCtl).val(accs) : $("#" + accountCtl).val(accs);
                        //$("#" + accountCtl).val(accs); 
                    }
                    catch (e) {
                    }
                }

                try {
                    if (callback) {

                        if (callback == "True") {
                            ReturnPageIsMethod();
                        }
                        else if (callback == "DIY") {
                            ReturnPageDIY();
                        }
                        else {
                            callback(val);
                        }
                    }
                }
                catch (e) {
                }
            },
            returnFunc: "getData" //返回数据的function
        };
    }
    else {
        var options = {
            title: "选择加签审批人",
            oktext: "确定",
            canceltext: "取消",
            width: "700px",
            height: "430px",
            url: path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectSignedApprover.aspx?userId=1",
            // url:  "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectSignedApproverEn.aspx?userId=1&language=" + lan,
            //url: path + "/Portal/Ultimus.UWF.OrgChart/SelectSignedApprover.aspx",
            callback: function (val) {
                if (val) {
                    debugger
                    var obj = val;
                    var names = "";
                    var ids = "";
                    var accs = "";
                    if (obj) {
                        for (i = 0; i < obj.length; i++) {
                            if (i == 0) {
                                names += obj[i].USERNAME;
                                ids += obj[i].USERID + "|" + obj[i].TYPE;
                                accs += obj[i].LOGINNAME;
                            }
                            else {
                                names += "," + obj[i].USERNAME;
                                ids += "," + obj[i].USERID + "|" + obj[i].TYPE;
                                accs += "," + obj[i].LOGINNAME;
                            }
                        }
                    }
                    try {
                        isiframopen == true ? $(window.frames["frmWindow"][0].contentWindow.document).find("#" + nameCtl).val(names) : $("#" + nameCtl).val(names);
                        //$("#" + nameCtl).val(names)
                    }
                    catch (e) {
                    }
                    try {
                        isiframopen == true ? $(window.frames["frmWindow"][0].contentWindow.document).find("#" + idCtl).val(ids) : $("#" + idCtl).val(ids);

                        //$("#" + idCtl).val(ids); 
                    }
                    catch (e) {
                    }
                    try {
                        isiframopen == true ? $(window.frames["frmWindow"][0].contentWindow.document).find("#" + accountCtl).val(accs) : $("#" + accountCtl).val(accs);
                        //$("#" + accountCtl).val(accs); 
                    }
                    catch (e) {
                    }
                }

                try {
                    if (callback) {

                        if (callback == "True") {
                            ReturnPageIsMethod();
                        }
                        else if (callback == "DIY") {
                            ReturnPageDIY();
                        }
                        else {
                            callback(val);
                        }
                    }
                }
                catch (e) {
                }
            },
            returnFunc: "getData" //返回数据的function
        };
    }

    //弹出窗口
    showForm(options);
}

function clearSignedApprover() {
    var fld_USER_SIGNEDAPPROVERNAME = $("#fld_USER_SIGNEDAPPROVERNAME").val();
    var fld_USER_SIGNEDAPPROVER = $("#fld_USER_SIGNEDAPPROVER").val();
    var fld_USER_SIGNEDAPPROVER2NAME = $("#fld_USER_SIGNEDAPPROVER2NAME").val();
    var fld_USER_SIGNEDAPPROVER2 = $("#fld_USER_SIGNEDAPPROVER2").val();
    var fld_USER_SIGNEDAPPROVER3NAME = $("#fld_USER_SIGNEDAPPROVER3NAME").val();
    var fld_USER_SIGNEDAPPROVER3 = $("#fld_USER_SIGNEDAPPROVER3").val();
    if (fld_USER_SIGNEDAPPROVERNAME != '' || fld_USER_SIGNEDAPPROVER != '') {
        if (lan == "en-us") {
            if (confirm("Confirm to delete the current signature approver?")) {
                $("#fld_USER_SIGNEDAPPROVERNAME,#fld_USER_SIGNEDAPPROVER").val('');
                $("#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2").val('');
                $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
                if (fld_USER_SIGNEDAPPROVER2NAME != '' || fld_USER_SIGNEDAPPROVER2 != '') {
                    $("#fld_USER_SIGNEDAPPROVERNAME").val(fld_USER_SIGNEDAPPROVER2NAME);
                    $("#fld_USER_SIGNEDAPPROVER").val(fld_USER_SIGNEDAPPROVER2);
                    if (fld_USER_SIGNEDAPPROVER3NAME != '' || fld_USER_SIGNEDAPPROVER3 != '') {
                        $("#fld_USER_SIGNEDAPPROVER2NAME").val(fld_USER_SIGNEDAPPROVER3NAME);
                        $("#fld_USER_SIGNEDAPPROVER2").val(fld_USER_SIGNEDAPPROVER3);
                    }
                }
            }
        }
        else {
            if (confirm("确认删除当前加签审批人？")) {
                $("#fld_USER_SIGNEDAPPROVERNAME,#fld_USER_SIGNEDAPPROVER").val('');
                $("#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2").val('');
                $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
                if (fld_USER_SIGNEDAPPROVER2NAME != '' || fld_USER_SIGNEDAPPROVER2 != '') {
                    $("#fld_USER_SIGNEDAPPROVERNAME").val(fld_USER_SIGNEDAPPROVER2NAME);
                    $("#fld_USER_SIGNEDAPPROVER").val(fld_USER_SIGNEDAPPROVER2);
                    if (fld_USER_SIGNEDAPPROVER3NAME != '' || fld_USER_SIGNEDAPPROVER3 != '') {
                        $("#fld_USER_SIGNEDAPPROVER2NAME").val(fld_USER_SIGNEDAPPROVER3NAME);
                        $("#fld_USER_SIGNEDAPPROVER2").val(fld_USER_SIGNEDAPPROVER3);
                    }
                }
            }
        }
    }
}

function clearSignedApprover2() {
    var fld_USER_SIGNEDAPPROVER2NAME = $("#fld_USER_SIGNEDAPPROVER2NAME").val();
    var fld_USER_SIGNEDAPPROVER2 = $("#fld_USER_SIGNEDAPPROVER2").val();
    var fld_USER_SIGNEDAPPROVER3NAME = $("#fld_USER_SIGNEDAPPROVER3NAME").val();
    var fld_USER_SIGNEDAPPROVER3 = $("#fld_USER_SIGNEDAPPROVER3").val();
    if (fld_USER_SIGNEDAPPROVER2NAME != '' || fld_USER_SIGNEDAPPROVER2 != '') {
        if (lan == "en-us") {
            if (confirm("Confirm to delete the current signature approver？")) {
                $("#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2").val('');
                $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
                if (fld_USER_SIGNEDAPPROVER3NAME != '' || fld_USER_SIGNEDAPPROVER3 != '') {
                    $("#fld_USER_SIGNEDAPPROVER2NAME").val(fld_USER_SIGNEDAPPROVER3NAME);
                    $("#fld_USER_SIGNEDAPPROVER2").val(fld_USER_SIGNEDAPPROVER3);
                }
            }
        }
        else {
            if (confirm("确认删除当前加签审批人？")) {
                $("#fld_USER_SIGNEDAPPROVER2NAME,#fld_USER_SIGNEDAPPROVER2").val('');
                $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
                if (fld_USER_SIGNEDAPPROVER3NAME != '' || fld_USER_SIGNEDAPPROVER3 != '') {
                    $("#fld_USER_SIGNEDAPPROVER2NAME").val(fld_USER_SIGNEDAPPROVER3NAME);
                    $("#fld_USER_SIGNEDAPPROVER2").val(fld_USER_SIGNEDAPPROVER3);
                }
            }
        }
    }
}

function clearSignedApprover3() {
    var fld_USER_SIGNEDAPPROVER3NAME = $("#fld_USER_SIGNEDAPPROVER3NAME").val();
    var fld_USER_SIGNEDAPPROVER3 = $("#fld_USER_SIGNEDAPPROVER3").val();
    if (fld_USER_SIGNEDAPPROVER3NAME != '' || fld_USER_SIGNEDAPPROVER3 != '') {
        if (lan == "en-us") {
            if (confirm("Confirm to delete the current signature approver？")) {
                $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
            }
        }
        else {
            if (confirm("确认删除当前加签审批人？")) {
                $("#fld_USER_SIGNEDAPPROVER3NAME,#fld_USER_SIGNEDAPPROVER3").val('');
            }
        }
    }
}