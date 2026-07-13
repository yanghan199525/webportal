<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectSignedApproverEn.aspx.cs" Inherits="Ultimus.UWF.OrgChart.SelectSignedApproverEn" %>

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
    <link rel="stylesheet" href="/Common/Assets/jqwidgets/styles/jqx.base.css" type="text/css" />
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
        $(document).ready(function () {
            var source = null;

            var url = "../Handler/UserHandler.ashx?method=GetUserList&text=" + encodeURI($("#txtSearch").val()) + "&lan=" + encodeURI($("#language").val()),
                source =
                {
                    datatype: "json",
                    datafields: [
                        { name: 'USERNAME', type: 'string' },
                        { name: 'JOBFUNCTION', type: 'string' },
                        { name: 'TYPE', type: 'string' },
                        { name: 'LOGINNAME', type: 'string' },
                        { name: 'EXT30', type: 'string' },
                        { name: 'USERID', type: 'string' }
                    ],
                    id: 'USERID',
                    url: url
                };

            var dataAdapter = new $.jqx.dataAdapter(source, {
                downloadComplete: function (data, status, xhr) { },
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }
            });

            //初始化用户
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
                    //selectionmode: 'checkbox',
                    columns: [
                        { text: 'Chinese Name', datafield: 'USERNAME', width: '24%' },
                        { text: 'English Name', datafield: 'LOGINNAME', width: '40%' },
                        { text: 'Job', datafield: 'JOBFUNCTION', width: '18%' },
                        { text: 'Type', datafield: 'EXT30', width: '18%' }
                    ]
                    //loadComplete: function () {
                    //    //var userid = $("#userId").val();
                    //    debugger
                    //    var userid = "1";
                    //    if (userid != "") {
                    //        $("#grid").jqxGrid('selectrow', userid);
                    //    }
                    //}
                });

            //点击单元格，选择该行
            $("#grid").on("cellclick", function (event) {
                debugger
                var args = event.args;
                var rowBoundIndex = args.rowindex;
                var rowVisibleIndex = args.visibleindex;
                $('#grid').jqxGrid('clearselection');
                $("#grid").jqxGrid('selectrow', rowBoundIndex);
            });

            $("#gridsel").on("cellclick", function (event) {
                var args = event.args;
                var rowBoundIndex = args.rowindex;
                $("#gridsel").jqxGrid('selectrow', rowBoundIndex);
            });

            //选择后添加到已选
            $("#grid").on('rowselect', function (event) {
                debugger
                var rowindex = event.args.rowindex;
                var data = $('#grid').jqxGrid('getrowdata', rowindex);
                //如果是单选，先清除已选
                $('#gridsel').jqxGrid('clear');

                var data1 = $('#gridsel').jqxGrid('getrowdatabyid', data.USERID);
                if (data1 && data.TYPE == data1.TYPE) {

                }
                else {
                    $("#gridsel").jqxGrid('addrow', 0, data);
                }
            });

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
                        { name: 'USERID', type: 'string' }
                    ],
                    id: 'USERID'
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
                    //selectionmode: 'checkbox',
                    columns: [
                        { text: 'Chinese Name', datafield: 'USERNAME', width: '24%' },
                        { text: 'English Name', datafield: 'LOGINNAME', width: '40%' },
                        { text: 'Job', datafield: 'JOBFUNCTION', width: '18%' },
                        { text: 'Type', datafield: 'EXT30', width: '18%' }
                    ]
                });

            //文本框回车
            $("#txtSearch").keydown(function (e) {
                var curKey = e.which;
                if (curKey == 13) {
                    $("#btnSearch").click();
                    return false;
                }
            });
            //搜索
            $("#btnSearch").click(function () {
                var type = $("#ddlType").val();
                $('#gridsel').jqxGrid('clear');
                changeGrid("", $("#txtSearch").val());
            });

        })

        function changeGrid(departmentid, searchText) {
            debugger
            try {
                //加载用户
                var url = "../Handler/UserHandler.ashx?method=GetUserList&text=" + encodeURI(searchText) + "&lan=" + encodeURI($("#language").val()),
                    source =
                    {
                        datatype: "json",
                        datafields: [
                            { name: 'USERNAME', type: 'string' },
                            { name: 'JOBFUNCTION', type: 'string' },
                            { name: 'TYPE', type: 'string' },
                            { name: 'LOGINNAME', type: 'string' },
                            { name: 'EXT30', type: 'string' },
                            { name: 'ACCOUNT', type: 'string' },
                            { name: 'USERID', type: 'string' }
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
                        //selectionmode: 'checkbox',
                        //selectionmode: 'multiplerowsextended',
                        columns: [
                            { text: 'Chinese Name', datafield: 'USERNAME', width: '24%' },
                            { text: 'English Name', datafield: 'LOGINNAME', width: '40%' },
                            { text: 'Job', datafield: 'JOBFUNCTION', width: '18%' },
                            { text: 'Type', datafield: 'EXT30', width: '18%' }
                        ]
                    });
                debugger
                $('#grid').jqxGrid('clearselection');
            }
            catch (e) {

            }
        }
        //删除已选
        function delSel() {
            $('#grid,#gridsel').jqxGrid('clearselection');
            $('#gridsel').jqxGrid('clear');
            return false;
        }
        //返回数据
        function getData() {
            var rowDatas = $('#gridsel').jqxGrid('getrows');
            return rowDatas;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-xs-4">
                    <asp:DropDownList ID="ddlType" runat="server" Width="100%" ToolTip="Select Type">
                        <asp:ListItem Value="User">User</asp:ListItem>
                        <%--<asp:ListItem Value="Department">部门</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
                <div class="col-xs-8">
                    <div class="input-prepend input-group">
                        <input name="txtSearch" type="text" value="" id="txtSearch" class="form-control" placeholder="Please enter a search phrase" />
                        <span class="add-on input-group-addon" onclick="" id="btnSearch" title="Search"><i class="fa fa-search"></i></span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div style="padding-top: 2px;"></div>
                </div>
                <div class="col-xs-12">
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

                            <a onclick="if(confirm('Do you want to delete?')){return delSel();}return false;"
                                class="btn btn-icon btn-sm" title="Delete">
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

            <input id="Button1" type="button" value="Ok" onclick="getData();" style="display: none" />
            <asp:TextBox ID="userId" runat="server" Style="display: none"></asp:TextBox>
            <asp:TextBox ID="language" runat="server" Style="display: none"></asp:TextBox>
            <asp:TextBox ID="txtType" runat="server" Style="display: none"></asp:TextBox>
        </div>
    </form>
</body>
</html>

