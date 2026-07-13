
//可以返回父页面方法
function selectUserInfo1(type, nameCtl, idCtl, accountCtl, IsMethod) {
    var val;
    //all:选择任意
    //user:单选人
    //users:多选人
    //depts:多选部门
    _accountCtl = accountCtl;
    _nameCtl = nameCtl;
    _idCtl = idCtl;
    val = window.open(path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectUser.aspx?Type=" + type + "&nameCtl=" + nameCtl + "&idCtl=" + idCtl + "&accountCtl=" + accountCtl + "&IsMethod=" + IsMethod, null, "Width=800,Height=500,top=20,left=200,scrollbars=yes,resizable=yes");
    val.focus();
}

//选择组织架构
//all:选择任意
//user:单选人
//users:多选人
//dept:单选部门
//depts:多选部门
//是否从ifram页面弹出的  20180228号新增
//parent.selectUserInfo(2, 'txtChoosedDepts', 'txtChoosedDeptids', '', 'PARENTFORM', true);此方法调用只用于菜单权限,与组维护页面
//parent.selectUserInfo(2, 'txtChoosedDepts', 'txtChoosedDeptids', '', null, true)  从ifram页面调用次方法
//selectUserInfo(2, 'txtChoosedDepts', 'txtChoosedDeptids', ''）从当前页调用此方法
function selectUserInfo(type, nameCtl, idCtl, accountCtl, callback, isiframopen, title) {
    var olddata = "";
    try {
        var id = $("#" + idCtl).val();
        if (!id) {
            id = 0;
        }
        olddata = "" + $("#" + nameCtl).val();
        olddata += ";" + id;
        olddata += "|" + $("#" + accountCtl).val();
        olddata = encodeURI(olddata);
    }
    catch (e) {
        console.error(e);
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() == "zh-cn") {
            title1 = "请选择";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Please Select";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Please Select";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }
    if (!title) {
        title = title1;
    }
    path = window.document.location.origin;
    if (typeof (path) == "undefined")
        path = window.document.location.protocol + "//" + window.document.location.host;

    var options = {
        title: title,
        oktext: Confirm,
        canceltext: Cancel,
        width: "800px",
        height: "430px",
        url: path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectOrg.aspx?Type=" + type + "&data=" + olddata,
        returnFunc: "getData" //返回数据的function
    };
    //弹出窗口
    showUserForm(options, nameCtl, idCtl, accountCtl, isiframopen);
}

function showUserForm(options, nameCtl, idCtl, accountCtl, isiframopen) {
    url = options.url;
    title = options.title;
    height = options.height;
    width = options.width;
    size = options.size;
    oktext = options.oktext;
    canceltext = options.canceltext;
    bialogCloseByBackdrop = options.bialogCloseByBackdrop;

    if (typeof (bialogCloseByBackdrop) == "undefined") {
        bialogCloseByBackdrop = true;
    }
    if (!size) {
        size = "lg";// 默认大小
    }
    if (!height) {
        height = "300";
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() == "zh-cn") {
            title1 = "数据源";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Data Source";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Data Source";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }

    if (!title) {
        title = title1;
    }
    if (!oktext) {
        oktext = Confirm;
    }
    if (!canceltext) {
        canceltext = Cancel;
    }
    buttons = options.buttons;
    returnFunc = options.returnFunc;
    // 初始化弹出层
    $('#formModal').on('show.bs.modal', function (event) {
        var modal = $(this);
        if (parent.document !== document)
            modal.css('top', (parent.document.documentElement.scrollTop - 10));
        var button = $(event.relatedTarget); // 触发事件的按钮  
        modal.find('.modal-title').text(title);
        modal.removeClass("bd-example-modal-lg").removeClass("bd-example-modal-xl").removeClass("bd-example-modal-sm");
        modal.addClass("bd-example-modal-" + size);
        modal.find(".modal-dialog").removeClass("modal-lg").removeClass("modal-xl").removeClass("modal-sm");
        modal.find(".modal-dialog").addClass("modal-" + size);
        modal.find('.modal-body').html('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' scrolling="no" frameborder="no" style="border-width:0px;"></iframe>');
        modal.find('.modal-footer .btn-light').text(canceltext);
        modal.find('.modal-footer .btn-primary').text(oktext).attr("onclick", "modalUserCallback('" + returnFunc + "','" + nameCtl + "','" + idCtl + "','" + accountCtl + "'," + isiframopen + ",'formModal')");
    });
    $('#formModal').on('hidden.bs.modal', function (e) {
        $(this).removeData("bs.modal");
        $('#formModal').modal('dispose');
        // do something...
    });

    $("#formModal").modal();
    //if (width) {
    //    var windowWidth = $(window).width();
    //    if (windowWidth < 640) {
    //        width = windowWidth;
    //    }

    //    $(".modal-dialog", parent.document).css({
    //        width: width
    //    });
    //}

}

function addSelectUserInfo(type, nameCtl, idCtl, accountCtl, callback, isiframopen, title) {
    var olddata = "";
    try {
        var id = $("#" + idCtl).val();
        if (!id) {
            id = 0;
        }
        olddata = "" + $("#" + nameCtl).val();
        olddata += ";" + id;
        olddata += "|" + $("#" + accountCtl).val();
        olddata = encodeURI(olddata);
    }
    catch (e) {
        console.error(e);
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() === "zh-cn") {
            title1 = "请选择";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Please Select";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Please Select";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }
    if (!title) {
        title = title1;
    }
    path = window.document.location.origin;
    if (typeof (path) === "undefined")
        path = window.document.location.protocol + "//" + window.document.location.host;

    var options = {
        title: title,
        oktext: Confirm,
        canceltext: Cancel,
        width: "800px",
        height: "430px",
        url: path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectOrg.aspx?Type=" + type + "&data=" + olddata,
        returnFunc: "getData" //返回数据的function
    };
    //弹出窗口
    addShowUserForm(options, nameCtl, idCtl, accountCtl, isiframopen);
}

function addShowUserForm(options, nameCtl, idCtl, accountCtl, isiframopen) {
    url = options.url;
    title = options.title;
    height = options.height;
    width = options.width;
    size = options.size;
    oktext = options.oktext;
    canceltext = options.canceltext;
    bialogCloseByBackdrop = options.bialogCloseByBackdrop;

    if (typeof (bialogCloseByBackdrop) === "undefined") {
        bialogCloseByBackdrop = true;
    }
    if (!size) {
        size = "lg";// 默认大小
    }
    if (!height) {
        height = "300";
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() == "zh-cn") {
            title1 = "数据源";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Data Source";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Data Source";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }

    if (!title) {
        title = title1;
    }
    if (!oktext) {
        oktext = Confirm;
    }
    if (!canceltext) {
        canceltext = Cancel;
    }
    buttons = options.buttons;
    returnFunc = options.returnFunc;
    // 初始化弹出层
    $('#AddSignModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 触发事件的按钮  
        var modal = $(this);
        if (parent.document !== document)
            modal.css('top', (parent.document.documentElement.scrollTop - 10));
        modal.find('.modal-title').text(title);
        modal.removeClass("bd-example-modal-lg").removeClass("bd-example-modal-xl").removeClass("bd-example-modal-sm");
        modal.addClass("bd-example-modal-" + size);
        modal.find(".modal-dialog").removeClass("modal-lg").removeClass("modal-xl").removeClass("modal-sm");
        modal.find(".modal-dialog").addClass("modal-" + size);
        modal.find('.modal-body').html('<iframe id="addSignWindow" src=' + url + ' width="100%" height=' + height + ' scrolling="no" frameborder="no" style="border-width:0px;"></iframe>');
        modal.find('.modal-footer .btn-light').text(canceltext);
        modal.find('.modal-footer .btn-primary').text(oktext).attr("onclick", "modalUserCallback('" + returnFunc + "','" + nameCtl + "','" + idCtl + "','" + accountCtl + "'," + isiframopen + ",'AddSignModal')");
    }); $('#AddSignModal').on('hidden.bs.modal', function (e) {
        $(this).removeData("bs.modal");
        $('#AddSignModal').modal('dispose');
        // do something...
    });

    $("#AddSignModal").modal();
    //if (width) {
    //    var windowWidth = $(window).width();
    //    if (windowWidth < 640) {
    //        width = windowWidth;
    //    }

    //    $(".modal-dialog", parent.document).css({
    //        width: width
    //    });
    //}

}

function modalUserCallback(returnFunc, nameCtl, idCtl, accountCtl, isiframopen, modelId) {
    var windowId = "frmWindow";
    if (returnFunc) {
        var func = "";
        if (modelId === "AddSignModal")
            func = "var val = document.getElementById(\"addSignWindow\").contentWindow." + returnFunc + "();";
        else
            func = "var val = document.getElementById(\"frmWindow\").contentWindow." + returnFunc + "();";
        //windowId = "addSignWindow";
        eval(func);
    }
    if (val) {
        var obj = val;
        var names = "";
        var ids = "";
        var accs = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i === 0) {
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
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + nameCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + nameCtl).val(names);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + nameCtl).val(names);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + nameCtl).val(names);
                }

            } else {
                $("#" + nameCtl).val(names);
            }
        }
        catch (e) {
            console.error(e);
        }
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + idCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + idCtl).val(ids);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + idCtl).val(ids);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + idCtl).val(ids);
                }

            } else {
                $("#" + idCtl).val(ids);
            }
            //isiframopen == true ? $(document.getElementById('frmWindow').contentDocument).find("#" + idCtl).val(ids) : $("#" + idCtl).val(ids);
            //$("#" + idCtl).val(ids); 
        }
        catch (e) {
            console.error(e);
        }
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + accountCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + accountCtl).val(accs);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + accountCtl).val(accs);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + accountCtl).val(accs);
                }

            } else {
                $("#" + accountCtl).val(accs);
            }
            //isiframopen == true ? $(document.getElementById('frmWindow').contentDocument).find("#" + accountCtl).val(accs) : $("#" + accountCtl).val(accs);
            //$("#" + accountCtl).val(accs); 
        }
        catch (e) {
            console.info(e);
        }
    }
    try {
        if (typeof (callback) === "function") {
            if (callback === "True") {
                ReturnPageIsMethod();
            }
            else if (callback === "DIY") {
                ReturnPageDIY();
            }
            //用于组维护 权限管理页面的回调函数  2018-07-17新增
            else if ("PARENTFORM") {
                if (document.getElementById('frmContent') === null) {
                    ReturnPageParentForm();
                }
                else {
                    document.getElementById('frmContent').contentWindow.ReturnPageParentForm();
                }
            }
            else {
                callback(val);
            }
        }
    }
    catch (e) {
        console.error(e);
    }
    $('#' + modelId).modal('toggle');
}

//selectUser(1,'','','','标题','DIY'）
function selectUser(type, nameCtl, idCtl, accountCtl, title, callback) {
    if (callback) {
        selectUserInfo(type, nameCtl, idCtl, accountCtl, callback, false, title);
    } else {
        selectUserInfo(type, nameCtl, idCtl, accountCtl, null, false, title);
    }
}

function selectUser1(type, nameCtl, idCtl, accountCtl) {
    var val;
    //all:选择任意
    //user:单选人
    //users:多选人
    //depts:多选部门
    _accountCtl = accountCtl;
    _nameCtl = nameCtl;
    _idCtl = idCtl;
    val = window.open(path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectUser.aspx?Type=" + type + "&nameCtl=" + nameCtl + "&idCtl=" + idCtl + "&accountCtl=" + accountCtl, null, "Width=800,Height=500,top=20,left=200,scrollbars=yes,resizable=yes");
    //val = showForm({ url: path + "/Portal/Ultimus.UWF.OrgChart/SelectUser.aspx?Type=" + type + "&nameCtl=" + nameCtl + "&idCtl=" + idCtl + "&accountCtl=" + accountCtl, size: BootstrapDialog.SIZE_WIDE });
    val.focus();
}

function selectApprover(type, nameCtl, approverCtl) {
    var val;
    //all:选择任意
    //user:单选人
    //users:多选人
    //depts:多选部门
    val = window.showModalDialog(path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectUser.aspx?Type=" + type, null, "dialogWidth=800px;dialogHeight=500px");
    if (!val) {
        if (_val) {
            val = _val;
        }
        else {
            val = window.returnValue;
        }
    }
    if (val) {
        val = val.replace(/\\/g, "/");
        var obj = eval(val);
        var names = "";
        var ids = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i == 0) {
                    names += obj[i].Name;
                    ids += "USER:org=CustomOC,user=" + obj[i].LoginName;
                }
                else {
                    names += "," + obj[i].Name;
                    ids += "|USER:org=CustomOC,user=" + obj[i].LoginName;
                }
            }
        }

        $("#" + nameCtl).val(names);
        if (approverCtl) {
            $("#" + approverCtl).val(ids);
        }
    }
}


function selectPage(sql, order, displayField, displayFieldCaption, displayFieldWidth, title) {
    str = path + "/Portal/Ultimus.UWF.Common/SelectPage.aspx?sql=" + sql + "&order=" + order + "&query=" + displayField + "&caption=" + displayFieldCaption + "&width=" + displayFieldWidth + "&title=" + title;
    str = encodeURI(str);
    val = window.showModalDialog(str, null, "scroll:1;status:0;help:0;dialogWidth=800px;dialogHeight=480px");
    if (!val) {
        val = window.returnValue;
    }
    return val;
}


function selectPage(sql, order, displayField, displayFieldCaption, displayFieldWidth, title, dbName) {
    str = path + "/Portal/Ultimus.UWF.Common/SelectPage.aspx?dbName=" + dbName + "&sql=" + sql + "&order=" + order + "&query=" + displayField + "&caption=" + displayFieldCaption + "&width=" + displayFieldWidth + "&title=" + title;
    str = encodeURI(str);
    val = window.showModalDialog(str, null, "scroll:1;status:0;help:0;dialogWidth=800px;dialogHeight=480px");
    if (!val) {
        val = window.returnValue;
    }
    return val;
}
//关闭模态窗
function closeDialog() {
    $('.modal').map(function () {
        if (!$(this).is(":hidden")) {
            $(this).modal('hide');
        }
    });
}



function selectApplicant(type, nameCtl, idCtl, accountCtl,emalCtl,telCtl, callback, isiframopen, title) {
    var olddata = "";
    try {
        var id = $("#" + idCtl).val();
        if (!id) {
            id = 0;
        }
        olddata = "" + $("#" + nameCtl).val();
        olddata += ";" + id;
        olddata += "|" + $("#" + accountCtl).val();
        olddata = encodeURI(olddata);
    }
    catch (e) {
        console.error(e);
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() == "zh-cn") {
            title1 = "请选择";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Please Select";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Please Select";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }
    if (!title) {
        title = title1;
    }
    path = window.document.location.origin;
    if (typeof (path) == "undefined")
        path = window.document.location.protocol + "//" + window.document.location.host;

    var options = {
        title: title,
        oktext: Confirm,
        canceltext: Cancel,
        width: "800px",
        height: "430px",
        url: path + "/Portal/Ultimus.UWF.Home.V3/OrgChart/SelectOrg.aspx?Type=" + type + "&data=" + olddata,
        returnFunc: "getData" //返回数据的function
    };
    //弹出窗口
    showApplicantForm(options, nameCtl, idCtl, accountCtl, emalCtl, telCtl,isiframopen);
}

function showApplicantForm(options, nameCtl, idCtl, accountCtl, emalCtl, telCtl, isiframopen) {
    url = options.url;
    title = options.title;
    height = options.height;
    width = options.width;
    size = options.size;
    oktext = options.oktext;
    canceltext = options.canceltext;
    bialogCloseByBackdrop = options.bialogCloseByBackdrop;

    if (typeof (bialogCloseByBackdrop) == "undefined") {
        bialogCloseByBackdrop = true;
    }
    if (!size) {
        size = "lg";// 默认大小
    }
    if (!height) {
        height = "300";
    }
    var title1;
    var Confirm;
    var Cancel;
    try {
        if ($("#div_lang").attr("data-lang").toLocaleLowerCase() == "zh-cn") {
            title1 = "数据源";
            Confirm = "确定";
            Cancel = "取消";
        } else {
            title1 = "Data Source";
            Confirm = "Confirm";
            Cancel = "Cancel";
        }
    } catch (e) {
        title1 = "Data Source";
        Confirm = "Confirm";
        Cancel = "Cancel";
    }

    if (!title) {
        title = title1;
    }
    if (!oktext) {
        oktext = Confirm;
    }
    if (!canceltext) {
        canceltext = Cancel;
    }
    buttons = options.buttons;
    returnFunc = options.returnFunc;
    // 初始化弹出层
    $('#formModal').on('show.bs.modal', function (event) {
        var modal = $(this);
        if (parent.document !== document)
            modal.css('top', (parent.document.documentElement.scrollTop - 10));
        var button = $(event.relatedTarget); // 触发事件的按钮  
        modal.find('.modal-title').text(title);
        modal.removeClass("bd-example-modal-lg").removeClass("bd-example-modal-xl").removeClass("bd-example-modal-sm");
        modal.addClass("bd-example-modal-" + size);
        modal.find(".modal-dialog").removeClass("modal-lg").removeClass("modal-xl").removeClass("modal-sm");
        modal.find(".modal-dialog").addClass("modal-" + size);
        modal.find('.modal-body').html('<iframe id="frmWindow" src=' + url + ' width="100%" height=' + height + ' scrolling="no" frameborder="no" style="border-width:0px;"></iframe>');
        modal.find('.modal-footer .btn-light').text(canceltext);
        modal.find('.modal-footer .btn-primary').text(oktext).attr("onclick", "modalApplicantCallback('" + returnFunc + "','" + nameCtl + "','" + idCtl + "','" + accountCtl + "','" + emalCtl + "','" + telCtl + "'," + isiframopen + ",'formModal')");
    });
    $('#formModal').on('hidden.bs.modal', function (e) {
        $(this).removeData("bs.modal");
        $('#formModal').modal('dispose');
        // do something...
    });

    $("#formModal").modal();
    //if (width) {
    //    var windowWidth = $(window).width();
    //    if (windowWidth < 640) {
    //        width = windowWidth;
    //    }

    //    $(".modal-dialog", parent.document).css({
    //        width: width
    //    });
    //}

}

function modalApplicantCallback(returnFunc, nameCtl, idCtl, accountCtl, emalCtl, telCtl,  isiframopen, modelId) {
    var windowId = "frmWindow";
    if (returnFunc) {
        var func = "";
        if (modelId === "AddSignModal")
            func = "var val = document.getElementById(\"addSignWindow\").contentWindow." + returnFunc + "();";
        else
            func = "var val = document.getElementById(\"frmWindow\").contentWindow." + returnFunc + "();";
        //windowId = "addSignWindow";
        eval(func);
    }
    if (val) {
        var obj = val;
        var names = "";
        var ids = "";
        var accs = "";
        var email = "";
        var tel = "";
        if (obj) {
            for (i = 0; i < obj.length; i++) {
                if (i === 0) {
                    names += obj[i].USERNAME;
                    ids += obj[i].USERID + "|" + obj[i].TYPE;
                    accs += obj[i].LOGINNAME;
                    email += obj[i].EMAIL;
                    tel += obj[i].MOBILENO;
                }
                else {
                    names += "," + obj[i].USERNAME;
                    ids += "," + obj[i].USERID + "|" + obj[i].TYPE;
                    accs += "," + obj[i].LOGINNAME;
                    email += "," + obj[i].EMAIL;
                    tel += "," + obj[i].MOBILENO;
                }
            }
        }
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + nameCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + nameCtl).val(names);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + nameCtl).val(names);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + nameCtl).val(names);
                }

            } else {
                $("#" + nameCtl).val(names);
            }
        }
        catch (e) {
            console.error(e);
        }
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + idCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + idCtl).val(ids);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + idCtl).val(ids);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + idCtl).val(ids);
                }

            } else {
                $("#" + idCtl).val(ids);
            }
            //isiframopen == true ? $(document.getElementById('frmWindow').contentDocument).find("#" + idCtl).val(ids) : $("#" + idCtl).val(ids);
            //$("#" + idCtl).val(ids); 
        }
        catch (e) {
            console.error(e);
        }
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + accountCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + accountCtl).val(accs);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + accountCtl).val(accs);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + accountCtl).val(accs);
                }

            } else {
                $("#" + accountCtl).val(accs);
            }
            //isiframopen == true ? $(document.getElementById('frmWindow').contentDocument).find("#" + accountCtl).val(accs) : $("#" + accountCtl).val(accs);
            //$("#" + accountCtl).val(accs); 
        }
        catch (e) {
            console.info(e);
        }
       
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + emalCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + emalCtl).val(email);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + emalCtl).val(email);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + emalCtl).val(email);
                }

            } else {
                $("#" + emalCtl).val(email);
            }
            //isiframopen == true ? $(document.getElementById('frmWindow').contentDocument).find("#" + accountCtl).val(accs) : $("#" + accountCtl).val(accs);
            //$("#" + accountCtl).val(accs); 
        }
        catch (e) {
            console.info(e);
        }
        try {
            if (isiframopen === true) {
                if ($(document.getElementById(windowId).contentDocument).find("#" + telCtl).val() === undefined) {
                    if (document.getElementById('frmContent') === null) {
                        $(document).find("#" + telCtl).val(tel);
                    }
                    else {
                        $(document.getElementById('frmContent').contentDocument).find("#" + telCtl).val(tel);
                    }
                }
                else {
                    $(document.getElementById(windowId).contentDocument).find("#" + telCtl).val(tel);
                }

            } else {
                $("#" + telCtl).val(tel);
            }
            //isiframopen == true ? $(document.getElementById('frmWindow').contentDocument).find("#" + accountCtl).val(accs) : $("#" + accountCtl).val(accs);
            //$("#" + accountCtl).val(accs); 
        }
        catch (e) {
            console.info(e);
        }
    }
    try {
        if (typeof (callback) === "function") {
            if (callback === "True") {
                ReturnPageIsMethod();
            }
            else if (callback === "DIY") {
                ReturnPageDIY();
            }
            //用于组维护 权限管理页面的回调函数  2018-07-17新增
            else if ("PARENTFORM") {
                if (document.getElementById('frmContent') === null) {
                    ReturnPageParentForm();
                }
                else {
                    document.getElementById('frmContent').contentWindow.ReturnPageParentForm();
                }
            }
            else {
                callback(val);
            }
        }
    }
    catch (e) {
        console.error(e);
    }
    $('#' + modelId).modal('toggle');
}