<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPageStrengthen.aspx.cs" Inherits="Ultimus.UWF.Home.V3.SelectPageStrengthen" EnableViewState="false" ViewStateMode="Disabled" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Task List</title>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3()%>

    <style>
        body {
            background-color: #fff;
        }

        table.dataTable tbody th, table.dataTable tbody td {
            padding-top: 7px !important;
            padding-bottom: 7px !important;
            vertical-align: middle !important;
        }

        .table th, .table tbody td, .table td {
            padding-top: 7px !important;
            padding-bottom: 7px !important;
            vertical-align: middle !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <table id="tasklist" class="table table-hover table-nofooter" width="100%">
                        <thead>
                            <tr>

                                <td><%=Lang.Get("UWF.Select")%></td>
                                <%=GetTitle() %>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>

        <div class="hidden">
            <asp:HiddenField ID="hidSingle" runat="server" Value="true" />
            <asp:HiddenField ID="hidFilter" runat="server" />
            <asp:HiddenField ID="hidDataSource" runat="server" /> <%--//数据源名称--%>
            <asp:HiddenField ID="hidCaption_EN" runat="server" /> <%--//字段英文名称--%>
            <asp:HiddenField ID="hidCaption" runat="server" /> <%--//字段中文名称--%>
            <asp:HiddenField ID="hidHidden" runat="server" /> <%--//隐藏字段--%>
            <asp:HiddenField ID="hidValue" runat="server" /> <%--//值字段--%>

        </div>
    </form>

    <script type="text/javascript">
        // 设置双击选择事件
        function closeDialogWin(obj) {
            //单选
            if ($("#hidSingle").val() == "true")
                $(obj).find(".radio").get(0).checked = true
            else
                $(obj).find(".checkbox").get(0).checked = true
            $(window.parent.document).find(".bootstrap-dialog-footer-buttons .btn-default").click();
            $(window.parent.document).find(".bootstrap-dialog-footer-buttons .btn-close").click();
        }
        function returnValue() {
            var single = $("#hidSingle").val();
            var rowdata;
            //单选
            if (single == "true") {
                $("#tasklist").find("input[type=radio]").each(function (ele) {
                    if ($(this).prop("checked")) {
                        rowdata = JSON.stringify(table.row(ele).data());
                        //rowdata = $(this).parent().parent().find(".rowdata").text();
                    }
                });
                if (!rowdata) {
                    return false;
                }
                rowdata = "[" + rowdata + "]";
            }
            else {
                //多选
                $("#tasklist").find("input[type=checkbox]").each(function (ele) {
                    if ($(this).prop("checked")) {
                        if (!rowdata) {
                            rowdata = JSON.stringify(table.row(ele).data());
                            //rowdata = $(this).parent().parent().find(".rowdata").text();
                        }
                        else {
                            rowdata = rowdata + ',' + JSON.stringify(table.row(ele).data());
                        }
                    }
                });
                if (!rowdata) {
                    return false;
                }
                rowdata = "[" + rowdata + "]";
            }
            return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
        }

        $(document).ready(function () {
            var tabel;
            ////加载数据源
            //GetDataSource();
            setTimeout("GetDataSource()", 100);// 等待样式加载完成
        });

        function GetDataSource() {
            //提示信息国际化配置
            var lang = {
                "sProcessing": "<%=Lang.Get("GetData")%>",
                "sLengthMenu": "<%=Lang.Get("ItemsPerPage")%>",
                "sZeroRecords": "<%=Lang.Get("Nomatch")%>",
                "sInfo": "<%=Lang.Get("ItemFromTO")%> ",
                "sInfoEmpty": "<%=Lang.Get("ItemFromTO")%> ",
                "sInfoFiltered": "(<%=Lang.Get("MAXResult")%>)",
                "sInfoPostFix": "",
                "sSearch": "<%=Lang.Get("btn_Search")%>:",
                "sUrl": "",
                "sEmptyTable": "<%=Lang.Get("DataIsNull")%>",
                "sLoadingRecords": "<%=Lang.Get("loading")%>",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "<%=Lang.Get("First")%>",
                    "sPrevious": "<%=Lang.Get("Previous")%>",
                    "sNext": "<%=Lang.Get("Next")%>",
                    "sLast": "<%=Lang.Get("Last")%>",
                    "sJump": "<%=Lang.Get("Jump")%>"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            };

            table = $("#tasklist").dataTable({
                language: lang,  //提示信息
                bInfo: false, //页脚信息
                serverSide: true,  //启用服务器端分页
                paging: true,//开启表格分页
                blengthChange: false, //开启一页显示多少条数据的下拉菜单
                aLengthMenu: [[5, 10, 20, 50, 100, -1], [5, 10, 20, 50, 100, 'All']],  //用户可自选每页展示数量 5条或10条
                iDisplayLength: 10, //默认显示的记录数
                autoWidth: false,  //禁用自动调整列宽 
                processing: false,  //隐藏加载提示,自行处理
                bFilter: true, //过滤功能,原生搜索
                searching: true,  //禁用原生搜索
                bSort: false, //排序功能
                renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
                sdom: 't<"dataTables_info"il>p',//lfrtip
                pagingType: "full",  //分页样式：simple,simple_numbers,full,full_numbers
                scrollX: "100%",//X滑动条
                scrollY: "300px",
                deferRender: false,//延迟渲染
                initComplete: function (settings) { //datatables初始化完毕后会调用这个方法 
                    var _$this = this;
                    var searchHTML = '<label><span><%=Lang.Get("Search")%>:</span> <input type="search" placeholder="<%=Lang.Get("PleaseInputSearch")%>" '
                        + 'aria-controls="datatable1" style="border-top-left-radius: 3px;border-bottom-left-radius: 3px;border-top-right-radius: 0px;border-bottom-right-radius: 0px">'
                        + ' <span class="sp-search" style="display: flex;padding: 0.97rem 1rem;background-color: #eff9ff;border: 1px solid #ced4da;border-radius:2px ;float: right;margin-left: -1.5px">'
                        + '<i class="fa fa-search"></i></span> </label > ';
                    //快捷操作的HTML DOM
                    $(_$this.selector + '_wrapper .dataTables_length').css("text-align", "left");
                    $(_$this.selector + '_wrapper .dataTables_length').css("float", "left");
                    $(_$this.selector + '_wrapper .dataTables_filter').find('label').hide();
                    $(_$this.selector + '_wrapper .dataTables_filter').css("text-align", "right");
                    $(_$this.selector + '_wrapper .dataTables_filter').append(searchHTML);
                    //重写搜索事件
                    
                    //回车事件及键盘事件
                    $(_$this.selector + '_wrapper .dataTables_filter input').bind('keyup',
                        function (e) {
                            if (e.keyCode == 13 || (e.keyCode == 8 && (this.value.length == 0))) {
                                _$this.api().search(this.value).draw();
                            }
                        });
                    //点击查询
                    $(_$this.selector + '_wrapper .dataTables_filter span .fa-search').bind('click',
                        function (e) {
                            _$this.api().search($(this).parent().parent().find("input").val()).draw();
                        });
                },
                columnDefs: [{ //渲染控件
                    targets: 0,  //列的样式名'nosort'
                    orderable: false,    //包含上样式名‘nosort’的禁止排序
                    render: function (data, type, full, meta) {
                        var html = "";
                        if ($("#hidSingle").val() == "true") {
                            html = "<input id='radSel' name='sel' type='radio' class='radio' value='" + data + "' />";
                        } else {
                            html = "<input id='chxSelect' type='checkbox' class='checkbox' value='" + data + "' onclick='this.checked = !this.checked;'/>";
                        }
                        return html
                    }
                },
                ],
                ajax: function (data, callback, settings) {
                    Ajax(data, callback, settings);
                },
                columns: [ 
                    <%=GetValue() %>
                ],
                rowCallback: function (row, data) {//添加单击事件
                    $(row).attr({ "ondblclick": "closeDialogWin(this);", "onclick": "selRow(this);" });
                },

            }).api(); //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
        }

        //Ajax处理加载数据
        function Ajax(data, callback, settings) {
            //封装请求参数
            var param = {};
            param.limit = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候
            param.start = data.start;//开始的记录序号
            param.page = (data.start / data.length) + 1;//当前页码
            param.search = data.search.value; //搜索内容
            param.hidDataSource = $("#hidDataSource").val();
            param.hidFilter = $("#hidFilter").val();
            $.ajax({
                type: "POST",
                url: "/Portal/Ultimus.UWF.Home.V3/SelectPageHandler.ashx",
                cache: false,  //禁用缓存
                data: param,  //传入组装的参数
                dataType: "json",
                async: false,
                success: function (result) {
                    //封装返回数据
                    var returnData = {};
                    returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
                    returnData.recordsTotal = result.recordsTotal;//返回数据全部记录
                    returnData.recordsFiltered = result.recordsFiltered;//后台不实现过滤功能，每次查询均视作全部结果
                    returnData.data = result.data;//返回的数据列表
                    callback(returnData);
                }
            });
        }

        function selRow(ele) {
            if ($(ele).find("input[type=checkbox]").length > 0) {
                if ($(ele).find("input[type=checkbox]").prop("checked")) {
                    $(ele).find("input[type=checkbox]").prop("checked", false);
                }
                else {
                    $(ele).find("input[type=checkbox]").prop("checked", true);
                }
            }

            if ($(ele).find("input[type=radio]").length > 0) {
                if (!$(ele).find("input[type=radio]")[0].checked) {
                    if ($(ele).find("input[type=radio]").prop("checked")) {
                        $(ele).find("input[type=radio]").prop("checked", false);
                    }
                    else {
                        $(ele).find("input[type=radio]").prop("checked", true);
                    }
                }
            }
        }

    </script>
</body>
</html>
