<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectOrg.aspx.cs" Inherits="Ultimus.UWF.OrgChart.SelectOrg" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title id='Description'>Select org</title>
    <%=WebUtil.IncludeCssV3() %>
    <link rel="stylesheet" href="../../../Common/Assets/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxcheckbox.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxtree.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/globalization/globalize.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/globalization/globalize.culture.zh-CN.js"></script>

    <script type="text/javascript">
        var _currentDepartmentid;
        $(document).ready(function () {
            //department
            var tree = $('#jqxTree');

            var source = null;
            $.ajax({
                async: false,
                url: "../Handler/OrgHandler.ashx?method=GetDepartment&parentid=0",
                success: function (data, status, xhr) {
                    source = jQuery.parseJSON(data);
                }
            });
            //加载第一层树
            tree.jqxTree({ source: source, toggleMode: 'click', height: '390px' });
            tree.jqxTree("expandItem", tree.find('li:first')[0]);

            //点击部门
            tree.bind('select', function (event) {
                var ele = event.args.element;
                var item = $('#jqxTree').jqxTree('getItem', ele);
                changeGrid(item.value, "");
                _currentDepartmentid = item.value;
            });

            //展开树的子节点
            tree.on('expand', function (event) {
                var label = tree.jqxTree('getItem', event.args.element).label;
                var $element = $(event.args.element);
                var loader = false;
                var loaderItem = null;
                var children = $element.find('ul:first').children();
                $.each(children, function () {
                    var item = tree.jqxTree('getItem', this);
                    if (item && item.label == 'Loading...') {
                        loaderItem = item;
                        loader = true;
                        return false
                    };
                });
                if (loader) {
                    $.ajax({
                        url: loaderItem.value,
                        success: function (data, status, xhr) {
                            var items = jQuery.parseJSON(data);
                            tree.jqxTree('addTo', items, $element[0]);
                            tree.jqxTree('removeItem', loaderItem.element);
                        }
                    });
                }
            });

            //group
            var group = $('#jqxGroup');
            group.bind('select', function (event) {

                var htmlElement = event.args.element;
                var item = $('#jqxGroup').jqxTree('getItem', htmlElement);
                changeGrid(item.value, "");
                _currentDepartmentid = item.value;
            });
            //展开组
            group.on('expand', function (event) {
                var label = group.jqxTree('getItem', event.args.element).label;
                var $element = $(event.args.element);
                var loader = false;
                var loaderItem = null;
                var children = $element.find('ul:first').children();
                $.each(children, function () {
                    var item = group.jqxTree('getItem', this);
                    if (item && item.label == 'Loading...') {
                        loaderItem = item;
                        loader = true;
                        return false
                    };
                });
                if (loader) {
                    $.ajax({
                        url: loaderItem.value,
                        success: function (data, status, xhr) {
                            var items = jQuery.parseJSON(data);
                            group.jqxTree('addTo', items, $element[0]);
                            group.jqxTree('removeItem', loaderItem.element);
                        }
                    });
                }
            });

            //初始化用户
            $("#grid").jqxGrid(
                {
                    width: '100%',
                    source: null,
                    pageable: false,
                    height: 200,
                    sortable: false,
                    altrows: true,
                    enabletooltips: true,
                    editable: false,
                    selectionmode: 'checkbox',
                    columns: [
                        { text: '<%= Lang.Get("Login_UserName") %>', datafield: 'USERNAME', width: '40%' },
                        { text: '<%= Lang.Get("Form_JobFunction") %>', datafield: 'JOBFUNCTION', width: '40%' },
                        { text: '<%= Lang.Get("type") %>', datafield: 'EXT30' }
                    ]
                });
            //点击单元格，选择该行
            $("#grid").on("cellclick", function (event) {
                var args = event.args;
                var rowBoundIndex = args.rowindex;
                var rowVisibleIndex = args.visibleindex;
                var type = $("#txtType").val();
                if (type == "user" || type == "dept") {
                    $('#grid').jqxGrid('clearselection');
                }
                $("#grid").jqxGrid('selectrow', rowBoundIndex);
            });
            $("#gridsel").on("cellclick", function (event) {
                var args = event.args;
                var rowBoundIndex = args.rowindex;
                $("#gridsel").jqxGrid('selectrow', rowBoundIndex);
            });
            //选择后添加到已选
            $("#grid").on('rowselect', function (event) {
                var rowindex = event.args.rowindex;
                //var data = $('#grid').jqxGrid('getrowdata', rowindex);
                //如果是单选，先清除已选
                var type = $("#txtType").val();
                //if (type == "user" || type == "dept") {
                //    $('#gridsel').jqxGrid('clear');
                //}
                //var data1 = $('#gridsel').jqxGrid('getrowdatabyid', data.USERID);
                //if (data1 && data.TYPE == data1.TYPE) {

                //}
                //else {
                //    $("#gridsel").jqxGrid('addrow', 0, data);
                //}
                //判断是否可以全选
                if (type == "users" || type == "depts" || type == "2" || type == "4") {
                    //单选
                    if (typeof (rowindex) == "number") {
                        var data = $('#grid').jqxGrid('getrowdata', rowindex);
						var nubList = $('#gridsel').jqxGrid('getrows');
                        //人员不能重复选择
                            var row = nubList.filter(function (element, index, self) {
                                return element.USERID == data.USERID;
                            });
                            if (row.length == 0) {
                                $("#gridsel").jqxGrid('addrow', 0, data);
                            }
                        }
                    else {
                        for (var i = 0; i < rowindex.length; i++) {
                            var data = $('#grid').jqxGrid('getrowdata', rowindex[i]);
							var nubList = $('#gridsel').jqxGrid('getrows');
                            //人员不能重复选择
                            var row = nubList.filter(function (element, index, self) {
                                return element.USERID == data.USERID;
                            });
                            if (row.length == 0) {
                                $("#gridsel").jqxGrid('addrow', 0, data);
                            }
                        }
                    }
                } else {
                    $('#gridsel').jqxGrid('clear');
                    var data = $('#grid').jqxGrid('getrowdata', rowindex);
                    $("#gridsel").jqxGrid('addrow', 0, data);
                }
            });

            //add old data
            debugger;
            var olddatas = eval('<%=__olddatas%>'); //eval("{\"USERNAME\":\"zhang shuang\",\"JOBFUNCTION\":\"99-Operations Executive\",\"TYPE\":\"USER\",\"LOGINNAME\":\"CustomOC\\zhangs004\",\"EXT30\":\"User\",\"USERID\":1023,\"uid\":\"1023\"}"); 
            //olddata.USERNAME = "Joe Zhou";
            //olddata.TYPE = "USER";
            //olddata.USERID = "1001";
            //olddata.EXT30 = "User";
            //olddata.uid = "1001";
            //olddata.JOBFUNCTION = "";
            //olddata.USERID = "1001";
            //debugger;
            //olddatas.push(olddata);

            //初始化已选
            source =
                {
                    datatype: "json",
                    datafields: [
                        { name: 'USERNAME', type: 'string' },
                        { name: 'JOBFUNCTION', type: 'string' },
                        { name: 'LOGINNAME', type: 'string' },
                        { name: 'EXT30', type: 'string' },
                        { name: 'TYPE', type: 'string' },
                        { name: 'USERID', type: 'string' },
                        { name: 'EMAIL', type: 'string' },
 	       { name: 'MOBILENO', type: 'string' }
  

                    ],
                    id: 'USERID',
                    localdata: olddatas
                };

            dataAdapter = new $.jqx.dataAdapter(source, {
                downloadComplete: function (data, status, xhr) { },
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }
            });

            $("#gridsel").jqxGrid(
                {
                    width: '100%',
                    source: dataAdapter,
                    pageable: false,
                    height: 150,
                    sortable: false,
                    altrows: true,
                    enabletooltips: true,
                    editable: false,
                    selectionmode: 'checkbox',
                    columns: [
                        { text: '<%= Lang.Get("Login_UserName") %>', datafield: 'USERNAME', width: '40%' },
                        { text: '<%= Lang.Get("Form_JobFunction") %>', datafield: 'JOBFUNCTION', width: '40%' },
                          { text: '<%= Lang.Get("type") %>', datafield: 'EXT30' }
                    ]
                });

            //切换部门
            var _orgType = "Department";
            $("#ddlOrg").on('change', function (event) {
                if ($(this).val() == "Group") {
                    var source = null;
                    $.ajax({
                        async: false,
                        url: "../Handler/OrgHandler.ashx?method=GetGroup",
                        success: function (data, status, xhr) {
                            source = jQuery.parseJSON(data);
                        }
                    });

                    group.jqxTree({ source: source, toggleMode: 'click', height: '390px' });
                    group.jqxTree('expandAll');

                    $("#jqxTree").hide();
                    $("#jqxGroup").show();
                    _orgType = "Group";
                }
                else {
                    $("#jqxTree").show();
                    $("#jqxGroup").hide();
                    _orgType = "Department";
                }
            });

            $("#ddlType").on('change', function (event) {
                changeGrid(_currentDepartmentid, "");
            });

            //文本框回车
            $("#txtSearch").keydown(function (e) {
                var curKey = e.which;
                if (curKey == 13) {
                    $("#btnSearch").click();
                    return false;
                }
            });
            
            //$("#txtSearch").keyup(function (e) {
            //    $("#btnSearch").click();
            //    return false;
            //});

            //搜索
            $("#btnSearch").click(function () {
                var type = $("#ddlType").val();
                changeGrid("", $("#txtSearch").val());
            });
            //如果类型为组 模拟ddlOrg的change事件
            if ($("#txtType").val() == "group") {
                $("#ddlOrg").change();
            }
        });

        function changeGrid(departmentid, searchText) {

            try {
                var type = $("#ddlType").val();
                var org = $("#ddlOrg").val();
                //加载用户
                if (type == "User") {
                    var url = "../Handler/OrgHandler.ashx?method=GetUserList&departmentid=" + departmentid + "&text=" + encodeURI(searchText) + "&org=" + org,
                        source =
                            {
                                datatype: "json",
                                datafields: [
                                    { name: 'USERNAME', type: 'string' },
                                    { name: 'JOBFUNCTION', type: 'string' },
                                    { name: 'TYPE', type: 'string' },
                                    { name: 'LOGINNAME', type: 'string' },
                                    { name: 'EXT30', type: 'string' },
                                    { name: 'USERID', type: 'string' },
 		    { name: 'EMAIL', type: 'string' },
 	                    { name: 'MOBILENO', type: 'string' }
                                ],
                                id: 'USERID',
                                url: url
                            };

                    var dataAdapter = new $.jqx.dataAdapter(source, {
                        downloadComplete: function (data, status, xhr) { },
                        loadComplete: function (data) { },
                        loadError: function (xhr, status, error) { }
                    });

                    //user grid
                    $("#grid").jqxGrid(
                        {
                            width: '100%',
                            source: dataAdapter,
                            pageable: false,
                            height: 200,
                            sortable: false,
                            altrows: true,
                            enabletooltips: true,
                            editable: false,
                            selectionmode: 'checkbox',
                            //selectionmode: 'multiplerowsextended',
                            columns: [
                                { text: '<%= Lang.Get("Login_UserName") %>', datafield: 'USERNAME', width: '40%' },
                                { text: '<%= Lang.Get("Form_JobFunction") %>', datafield: 'JOBFUNCTION', width: '40%' },
                                  { text: '<%= Lang.Get("type") %>', datafield: 'EXT30' }
                            ]
                        });
                    $('#grid').jqxGrid('clearselection');
                }

                //加载部门
                if (type == "Department") {
                    var url = "../Handler/OrgHandler.ashx?method=GetDepartmentList&departmentid=" + departmentid + "&text=" + searchText + "&org=" + org,
                        source =
                            {
                                datatype: "json",
                                datafields: [
                                    { name: 'USERNAME', type: 'string' },
                                    { name: 'JOBFUNCTION', type: 'string' },
                                    { name: 'TYPE', type: 'string' },
                                    { name: 'LOGINNAME', type: 'string' },
                                    { name: 'EXT30', type: 'string' },
                                    { name: 'USERID', type: 'string' },
	                    { name: 'EMAIL', type: 'string' },
 	                    { name: 'MOBILENO', type: 'string' }
                                ],
                                id: 'USERID',
                                url: url
                            };

                    var dataAdapter = new $.jqx.dataAdapter(source, {
                        downloadComplete: function (data, status, xhr) { },
                        loadComplete: function (data) { },
                        loadError: function (xhr, status, error) { }
                    });

                    //user grid
                    $("#grid").jqxGrid(
                        {
                            width: '100%',
                            source: dataAdapter,
                            pageable: false,
                            height: 200,
                            sortable: false,
                            altrows: true,
                            enabletooltips: true,
                            editable: false,
                            selectionmode: 'checkbox',
                            //selectionmode: 'multiplerowsextended',
                            columns: [
                                { text: '<%= Lang.Get("Login_UserName") %>', datafield: 'USERNAME', width: '40%' },
                                { text: '<%= Lang.Get("Form_JobFunction") %>', datafield: 'JOBFUNCTION', width: '40%' },
                                 { text: '<%= Lang.Get("type") %>', datafield: 'EXT30' }
                            ]
                        });
                    $('#grid').jqxGrid('clearselection');
                }
                //加载组

                if (type == "Group") {
                    $('#grid').jqxGrid('clear');
                    var item = $('#jqxGroup').jqxTree('getSelectedItem');
                    var dataGroup = [{
                        "USERID": item.value, "USERNAME": item.label, "TYPE": "GROUP", "JOBFUNCTION": "", "EXT30": "Group",
                        "LOGINNAME": "",
                    }]
                    source =
                            {
                                localdata: dataGroup,
                                datatype: "json",
                                datafields: [
                                    { name: 'USERNAME', type: 'string' },
                                    { name: 'JOBFUNCTION', type: 'string' },
                                    { name: 'TYPE', type: 'string' },
                                    { name: 'LOGINNAME', type: 'string' },
                                    { name: 'EXT30', type: 'string' },
                                    { name: 'USERID', type: 'string' },
	                    { name: 'EMAIL', type: 'string' },
 	                    { name: 'MOBILENO', type: 'string' }
                                ],
                                id: 'USERID'
                            };

                    var dataAdapter = new $.jqx.dataAdapter(source, {
                        downloadComplete: function (data, status, xhr) { },
                        loadComplete: function (data) { },
                        loadError: function (xhr, status, error) { }
                    });

                    //user grid
                    $("#grid").jqxGrid(
                        {
                            width: '100%',
                            source: dataAdapter,
                            pageable: false,
                            height: 200,
                            sortable: false,
                            altrows: true,
                            enabletooltips: true,
                            editable: false,
                            selectionmode: 'checkbox',
                            //selectionmode: 'multiplerowsextended',
                            columns: [
                                { text: '<%= Lang.Get("Login_UserName") %>', datafield: 'USERNAME', width: '40%' },
                                { text: '<%= Lang.Get("Form_JobFunction") %>', datafield: 'JOBFUNCTION', width: '40%' },
                                 { text: '<%= Lang.Get("type") %>', datafield: 'EXT30' }
                            ]
                        });
                    $('#grid').jqxGrid('clearselection');
                }
            }
            catch (e) {

            }
        }
        //删除已选
        function delSel() {
            var selectedrowindex = $("#gridsel").jqxGrid('getselectedrowindex');
            if ($("#gridsel").jqxGrid('getselectedrowindex') > -1) {
                if (confirm('Do you confirm to delete?')) {
                    var id = $("#gridsel").jqxGrid('getrowid', selectedrowindex);
                    var rowindexes = $('#gridsel').jqxGrid('getselectedrowindexes');
                    var rowIDs = new Array();
                    for (i = 0; i < rowindexes.length; i++) {
                        var id = $('#gridsel').jqxGrid('getrowid', rowindexes[i]);
                        rowIDs.push(id);
                    }
                    $("#gridsel").jqxGrid('deleterow', rowIDs);
                    $('#gridsel').jqxGrid('clearselection');
                    return false;
                }
            } else {
                alert("Please select ！");
            }
            return false;
        }
        //返回数据
        function getData() {
            var rowDatas = $('#gridsel').jqxGrid('getrows');
            //if (rowDatas.length == 0) {
            //    return null;
            //}
            return rowDatas;
        }

        //如果组织类型为部门 则左边的不能有组 
        function ddlOrgchange(obj) {
            if ($(obj).val() == "Department")
                $("#ddlType option[value='Group']").css("display", "none");
            else if ($(obj).val() == "Group")
                $("#ddlType option[value='Group']").css("display", "");

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-xs-4">
                    <asp:DropDownList ID="ddlOrg" onchange="ddlOrgchange(this)" runat="server" Width="100%" ToolTip="Choose Org">
                        <asp:ListItem Value="Department">Department</asp:ListItem>
                        <asp:ListItem Value="Group">Group</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-xs-2">
                    <asp:DropDownList ID="ddlType" runat="server" Width="100%" ToolTip="Choose Type">
                        <asp:ListItem Value="User">User</asp:ListItem>
                        <asp:ListItem Value="Department">Department</asp:ListItem>
                        <asp:ListItem Value="Group" style="display: none;">Group</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-xs-6">

                    <div class="input-prepend input-group">
                        <input name="txtSearch" type="text" value="" id="txtSearch" class="form-control" placeholder="please input key word to search.." />
                        <span class="add-on input-group-addon" onclick="" id="btnSearch" title="Seach"><i class="fa fa-search"></i></span>
                    </div>

                </div>

            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div style="padding-top: 2px;"></div>
                </div>
                <div class="col-xs-4">

                    <div id='jqxTree' style='overflow: auto;'>
                    </div>

                    <div id='jqxGroup' style='overflow: auto;'>
                    </div>
                </div>
                <div class="col-xs-8">
                    <div class="row-fluid">
                        <div class="col-xs-12">
                            <div id="grid">
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="col-xs-12">
                            <div style="padding-top: 5px;"></div>
                        </div>
                        <div class="col-xs-4">
                            <span>Selected:</span>
                        </div>
                        <div class="col-xs-8" style="text-align: right">

                            <a onclick="return delSel();"
                                class="btn btn-icon btn-sm" title="delete">
                                <i class="fa fa-trash"></i>
                            </a>
                        </div>
                        <div class="col-xs-12">
                            <div style="padding-bottom: 5px;"></div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="col-xs-12">
                            <div id="gridsel">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <input id="Button1" type="button" value="Ok" onclick="getData(); " style="display: none" />
            <asp:TextBox ID="txtType" runat="server" Style="display: none"></asp:TextBox>
        </div>
    </form>
</body>
</html>
