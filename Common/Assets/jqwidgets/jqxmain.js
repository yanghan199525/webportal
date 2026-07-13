//引用jqwidgets用到的JS文件
document.write("<script type='text/javascript' src='/jqwidgets/scripts/jquery-1.11.1.min.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jquery.validationEngine.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jquery.validationEngine-zh_CN.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jquery.validationEngine-en.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/bestseller.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxcore.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxdata.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxbuttons.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxscrollbar.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxmenu.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxcheckbox.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxlistbox.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxeditor.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.sort.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.pager.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.selection.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.edit.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxinput.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxwindow.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxdropdownbutton.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxdropdownlist.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.columnsresize.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxtabs.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxtree.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxscrollbar.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxpanel.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxtooltip.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxdatatable.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/scripts/demos.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxcombobox.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxdatetimeinput.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxcalendar.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxexpander.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxgrid.filter.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jquery.alerts.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxtree.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxsplitter.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxnumberinput.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxdocking.js'></script>");
document.write("<script type='text/javascript' src='/css/rightmenucss/js/common.js?v=725'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxtreegrid.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxradiobutton.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/jqxcheckbox.js'></script>");
document.write("<script type='text/javascript' src='/jqwidgets/globalization/globalize.js'></script>");

/////////////////////////////////////////////////////////////////////////////////////////
//拼接sql
function buildQueryString(data) {
    var str = '';
    for (var prop in data) {
        if (data.hasOwnProperty(prop)) {
            str += prop + '=' + data[prop] + '&';
        }
    }
    return str.substr(0, str.length - 1);
}

//获取AataAdapter
function getAataAdapter(jqxgrid, datafields, formatdata) {
    // alert(jqxgrid);
    $.ajaxSetup({
        async: false
    });
    document.onkeydown = function (e) {
        var isie = (document.all) ? true : false;
        var key;
        var ev;
        if (isie) {
            key = window.event.keyCode;
            ev = window.event;
        } else {
            key = e.which;
            ev = e;
        }
    }
    //    alert(jqxgrid);
    //    alert(datafields);
    //    alert(formatdata);
    var source =
    {
        type: "get",
        datatype: "json",
        datafields: datafields,
        addRow: function (rowID, rowData, position, commit) {
            // synchronize with the server - send insert command
            // call commit with parameter true if the synchronization with the server is successful 
            // and with parameter false if the synchronization failed.
            // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
            commit(true);
        },
        updateRow: function (rowID, rowData, commit) {
            // synchronize with the server - send update command
            // call commit with parameter true if the synchronization with the server is successful 
            // and with parameter false if the synchronization failed.
            commit(true);
        },
        deleteRow: function (rowID, commit) {
            // synchronize with the server - send delete command
            // call commit with parameter true if the synchronization with the server is successful 
            // and with parameter false if the synchronization failed.
            commit(true);
        },
        sort: function () {
            $("#" + jqxgrid).jqxGrid('updatebounddata', 'sort');
        },
        filter: function () {
            $("#" + jqxgrid).jqxGrid('updatebounddata', 'filter');
        },
        beforeprocessing: function (data) {
            var returnData = {};
            data = data.d;
            totalrecords = data.count;
            returnData.totalrecords = data.count;
            returnData.records = data.data;
            return returnData;
        },
        //参数对象
        formatdata: formatdata,
        url: '/Services/JqwidgetsWebService/PagingQuery.asmx/GetList'
    };

    var dataAdapter = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8' });
    return dataAdapter;
}



//获取AataAdapter
function getTreeAataAdapter(jqxgrid, datafields, formatdata, keyDataField, parentDataField) {
    //keyDataField:唯一ID；parentDataField：层级
    // alert(jqxgrid);
    $.ajaxSetup({
        async: false
    });
    document.onkeydown = function (e) {
        var isie = (document.all) ? true : false;
        var key;
        var ev;
        if (isie) {
            key = window.event.keyCode;
            ev = window.event;
        } else {
            key = e.which;
            ev = e;
        }
    }

    var source =
    {
        type: "get",
        datatype: "json",
        datafields: datafields,
        hierarchy:
        {
            keyDataField: { name: keyDataField },
            parentDataField: { name: parentDataField }
        },
        id: keyDataField,
        addRow: function (rowID, rowData, position, commit) {
            // synchronize with the server - send insert command
            // call commit with parameter true if the synchronization with the server is successful 
            // and with parameter false if the synchronization failed.
            // you can pass additional argument to the commit callback which represents the new ID if it is generated from a DB.
            commit(true);
        },
        updateRow: function (rowID, rowData, commit) {
            // synchronize with the server - send update command
            // call commit with parameter true if the synchronization with the server is successful 
            // and with parameter false if the synchronization failed.
            commit(true);
        },
        deleteRow: function (rowID, commit) {
            // synchronize with the server - send delete command
            // call commit with parameter true if the synchronization with the server is successful 
            // and with parameter false if the synchronization failed.
            commit(true);
        },
        sort: function () {
            $("#" + jqxgrid).jqxGrid('updatebounddata', 'sort');
        },
        filter: function () {
            $("#" + jqxgrid).jqxGrid('updatebounddata', 'filter');
        },
        beforeprocessing: function (data) {
            var returnData = {};
            data = data.d;
            totalrecords = data.count;
            returnData.totalrecords = data.count;
            returnData.records = data.data;
            return returnData;
        },
        //参数对象
        formatdata: formatdata,
        url: '/Services/JqwidgetsWebService/PagingQuery.asmx/GetList'
    };

    var dataAdapter = new $.jqx.dataAdapter(source, { contentType: 'application/json; charset=utf-8' });
    return dataAdapter;
}



//加载列表
function jqxGrid(gridid, dataAdapter, columnsjson) {
    $("#" + gridid).jqxGrid(
    {
        width: '100%',
        pagesizeoptions: ['5', '10', '15'], //设置分页数
        source: dataAdapter,
        theme: theme,
        pageable: true,
        autoheight: true,
        sortable: true, //列头排序    
        altrows: true, //隔行变颜色
        enabletooltips: true,
        editable: false,
        columnsresize: true,
        virtualmode: true,
        filterable: false,
        rendergridrows: function (args) {
            return args.data;
        },
        //selectionmode: 'checkbox',////鼠标移动列表变颜色是一整行还是一个单元格
        selectionmode: 'multiplecellsadvanced',
        ready: function () {
            //eval(readycolumns);
            //$('#jqxgrid').jqxGrid('hidecolumn', 'OPENBANK');
        },
        columns: columnsjson
    });
}

//根据流程设置下拉框数据源
function getDropDownDictionary(processname, ccname, fieldid) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=DropDownDictionary",
        data: { "ProcessName": processname, "CNName": ccname },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });
    $("#" + fieldid + "").jqxDropDownList(
    {
        source: _data,
        selectedIndex: 0,
        filterable: true,
        width: '207',
        height: '25',
        searchMode: 'contains',
        valueMember: 'CNNAME',
        displayMember: 'CNNAME'
        //autoDropDownHeight: true
    });
}


//根据流程设置下拉框数据源
function getDropDownDictionaryEN(processname, ccname, fieldid) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=DropDownDictionary",
        data: { "ProcessName": processname, "CNName": ccname },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });
    $("#" + fieldid + "").jqxDropDownList(
    {
        source: _data,
        selectedIndex: 0,
        filterable: true,
        width: '207',
        height: '25',
        searchMode: 'contains',
        valueMember: 'ENNAME',
        displayMember: 'ENNAME'
        //autoDropDownHeight: true
    });
}


//根据流程设置下拉框数据源,主要用于明细行获取
function getDtDropDownDictionary(processname, ccname) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=DropDownDictionary",
        data: { "ProcessName": processname, "CNName": ccname },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });
    return _data;


}

//根据流程设置下拉框数据源,主要用于明细行获取
function getDtDropDownDictionarybyType(Type) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=DropDownDictionarybyType",
        data: { "RType": Type },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });
    return _data;


}

//根据流程设置下拉框数据源,主要用于供应商明细行获取
function getDtDropDownDictionarybyTypeSupplier(Type) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=DropDownDictionarybyTypeSupplier",
        data: { "RType": Type },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });
    return _data;


}

//根据表名和条件查询列表
function getDataTableList(cells, tablename, where) {
    var _data;
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=getDropDownList",
        data: { "Cells": cells, "TableName": tablename, "Where": where },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });
    return _data;

}

function getResourseDictionary(typename, fieldid, whereAdd, disabled, autoDropHeight, controlsWidth, selectedIndex, controlsHeight) {
    var lang = "CNNAME";
    if (_Lang != undefined && _Lang != "") {
        lang = _Lang;
    }
    var _data;
    var cells = "cnname,enname,code";
    var tablename = "com_resource";
    var where = "where type='" + typename + "'";
    if (whereAdd == "" || whereAdd == undefined) {

    }
    else {
        where += "  " + whereAdd + " order by orderno ";
    }
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=getDropDownList",
        data: { "Cells": cells, "TableName": tablename, "Where": where },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });

    if (controlsWidth == "" || controlsWidth == undefined) {
        controlsWidth = '207';
    }
    if (controlsHeight == "" || controlsHeight == undefined) {
        controlsHeight = '25';
    }
    if (autoDropHeight == undefined) {
        autoDropHeight = true;
    }
    if (disabled == "" || disabled == undefined) {
        disabled = false;
    }
    if (selectedIndex == "" || selectedIndex == undefined) {
        if (selectedIndex != 0) {
            selectedIndex = -1;
        }
    }

    $("#" + fieldid + "").jqxDropDownList(
    {
        source: _data,
        selectedIndex: selectedIndex,
        filterable: true,
        width: controlsWidth,
        height: controlsHeight,
        searchMode: 'contains',
        valueMember: 'CODE',
        displayMember: lang,
        disabled: disabled,
        autoDropDownHeight: false
    });

}



function getResourseDictionarySupplier(typename, fieldid, whereAdd, disabled, autoDropHeight, controlsWidth, selectedIndex, controlsHeight) {
    var lang = "CNNAME";
    if (_Lang != undefined && _Lang != "") {
        lang = _Lang;
    }
    var _data;
    var cells = "SUPPLIERNAME,SUPPLIERID";
    var tablename = "i_supplier";
    var where = "where 1=1";
    $.ajax({
        url: "/Services/JqwidgetsWebService/Dictionary.ashx?type=getDropDownList",
        data: { "Cells": cells, "TableName": tablename, "Where": where },
        method: "post",
        async: false,
        success: function (result) {
            if (result.Success) {
                _data = result.Data;
            } else {
                _data = "";
            }
        }
    });

    if (controlsWidth == "" || controlsWidth == undefined) {
        controlsWidth = '207';
    }
    if (controlsHeight == "" || controlsHeight == undefined) {
        controlsHeight = '25';
    }
    if (autoDropHeight == undefined) {
        autoDropHeight = true;
    }
    if (disabled == "" || disabled == undefined) {
        disabled = false;
    }
    if (selectedIndex == "" || selectedIndex == undefined) {
        if (selectedIndex != 0) {
            selectedIndex = -1;
        }
    }

    $("#" + fieldid + "").jqxDropDownList(
    {
        source: _data,
        selectedIndex: selectedIndex,
        filterable: true,
        width: controlsWidth,
        height: controlsHeight,
        searchMode: 'contains',
        valueMember: 'SUPPLIERID',
        displayMember: "SUPPLIERNAME",
        disabled: disabled,
        autoDropDownHeight: false
    });

}