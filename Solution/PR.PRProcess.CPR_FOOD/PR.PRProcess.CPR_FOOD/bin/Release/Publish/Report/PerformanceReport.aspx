<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerformanceReport.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.View.Report.PerformanceReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="description" content="jPaginate - jQuery Pagination Plugin" />
    <meta name="keywords" content="jquery, plugin, pagination, fancy" />
    <title>绩效报表</title>
    <%=Ultimus.UWF.Common.Logic.WebUtil.IncludeFiles() %>
    <script src="Charts/amcharts/amcharts.js" type="text/javascript"></script>
    <script src="Charts/amcharts/serial.js" type="text/javascript"></script>
    <script src="MutipleSelect/Js/jquery.multi-select.js" type="text/javascript"></script>
    <script src="jpaginate/jquery.paginate.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="jpaginate/css/style.css" media="screen" />
    <link href="Charts/custom.css" rel="stylesheet" type="text/css" />
    <link href="MutipleSelect/Css/multi-select.css" media="screen" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var chartData; //图表数据

        $(function () {

            changeChartsData('1'); //初始化图表数据

            //加载流程名称下拉选项
            $.ajax({
                type: "POST", async: false,
                url: "../Controller/PerformanceHandler.ashx?tag=GetProcessInfo",
                success: function (date) {
                    var json = eval('(' + date + ')');
                    $("#myselect").append(json.selectInfo);
                }
            });

            //流程名称下拉选项定义
            $('#myselect').multiSelect({ selectableOptgroup: true,
                afterSelect: function (values) {
                    var txt = $('#txtShow').val();
                    txt += ',' + values;
                    if (txt.indexOf(',') == 0) {
                        txt = txt.substring(1);
                    }
                    $('#txtShow').val(txt);
                },
                afterDeselect: function (values) {
                    var txt = ',' + $('#txtShow').val() + ',';
                    for (var i = 0; i < values.length; i++) {
                        txt = txt.replace(',' + values[i] + ',', ',');
                    }
                    if (txt.length > 0 && txt.indexOf(',') == 0) {
                        txt = txt.substring(1);
                    }
                    if (txt.length > 0 && txt.lastIndexOf(',') == txt.length - 1) {
                        txt = txt.substring(0, txt.length - 1);
                    }
                    $('#txtShow').val(txt);
                }
            });
        });

        //初始化图表
        var chart = AmCharts.makeChart("chartdiv", {
            type: "serial", dataProvider: chartData, categoryField: "PROCESSNAME", depth3D: 20, angle: 30,
            categoryAxis: { labelRotation: 0, gridPosition: "start" },
            graphs: [{ valueField: "TS", colorField: "color", type: "column", lineAlpha: 0, fillAlphas: 1}],
            chartCursor: { cursorAlpha: 0, zoomable: false, categoryBalloonEnabled: false }
        });

    </script>
    <script type="text/javascript">
        //获取类型的值，图表还是列表
        function getIsShowCharts() {
            var selectValue = "";
            var inputs = document.getElementById("IsShowCharts").getElementsByTagName("INPUT");
            for (i = 0; i < inputs.length; i++) {
                if (inputs[i].checked == true)
                    selectValue = inputs[i].value;
            }
            return selectValue;
        }

        //切换tab
        function showTabs(reportId) {
            //更改tab样式
            if ($("#tab1").hasClass("active")) $("#tab1").removeClass("active");
            if ($("#tab2").hasClass("active")) $("#tab2").removeClass("active");
            if ($("#tab3").hasClass("active")) $("#tab3").removeClass("active");
            $("#tab" + reportId).addClass("active");
            showChartsOrTable(); //显示图表或列表
        }

        //显示图表或列表
        function showChartsOrTable() {
            var reportId = chooseWhichTab(); //当前选中哪个报表

            $("#tablediv1").hide(); $("#tablediv2").hide(); $("#tablediv3").hide();

            if (getIsShowCharts() == "1") {
                $("#chartParDiv").show(); //显示图表
                changeChartsData(reportId); //刷新图表数据
                $("#tablediv1").hide(); $("#tablediv2").hide(); $("#tablediv3").hide(); //隐藏列表
                $("#pagingParDiv").hide(); //隐藏分页
            } else {
                $("#chartParDiv").hide(); //隐藏图表
                $("#tablediv" + reportId).show(); //显示列表
                $("#pagingParDiv").show(); //显示分页
                changeTabData(reportId); //刷新table数据
            }
        }

        //刷新图表数据
        function changeChartsData(reportId) {
            $.ajax({
                type: "POST", async: true,
                url: "../Controller/PerformanceHandler.ashx?tag=GetProcessTimeConsuming&ReportId=" + reportId + "&ProcessName=" + $('#txtShow').val() + "&StartTime=" + $('#txtStartTime').val() + "&EndTime=" + $('#txtEndTime').val(),
                success: function (date) {
                    var json = eval('(' + date + ')');
                    chartData = json;

                    //刷新图表
                    chart.dataProvider = chartData;
                    chart.validateNow();
                    chart.validateData();
                }
            });
        }

        //点击查询按钮
        function search() {
            var reportId = chooseWhichTab(); //当前选中哪个报表
            showChartsOrTable(); //显示图表或列表
        }

        //刷新列表数据
        function changeTabData(reportId) {
            var reportId = chooseWhichTab(); //当前选中哪个报表

            $("#pagingDiv").remove(); //重建分页
            $("#pagingParDiv").append('<div id="pagingDiv"></div>');
            $.ajax({
                type: "POST",
                url: "../Controller/PerformanceHandler.ashx?tag=GetProcessTimeConsumingTable&ReportId=" + reportId + "&Type=2&Page=1&ProcessName=" + $('#txtShow').val() + "&StartTime=" + $('#txtStartTime').val() + "&EndTime=" + $('#txtEndTime').val(),
                async: false,
                success: function (date) {
                    var json = eval('(' + date + ')');
                    var dataCount = json.count;
                    var pageCount = 1;
                    if (dataCount != 0) {
                        pageCount = parseInt(dataCount / 10) + 1;
                        if (dataCount % 10 == 0) { pageCount = parseInt(dataCount / 10); }
                    } else {
                        pageCount = 1;
                    }
                    $("#pagingDiv").paginate({
                        count: pageCount, //一共几页
                        start: 1, //从几开始
                        display: 5, //显示几个数字
                        border: false, text_color: '#888', background_color: '#EEE', text_hover_color: 'black', background_hover_color: '#CFCFCF',
                        onChange: function (page) {
                            getTabledata(reportId, page); //刷新列表数据
                        }
                    });
                }
            });
            getTabledata(reportId, '1'); //刷新列表数据(初始)
        }

        //获取列表数据，动态填充
        function getTabledata(reportId, page) {
            $.ajax({
                type: "POST", async: true,
                url: "../Controller/PerformanceHandler.ashx?tag=GetProcessTimeConsumingTable&ReportId=" + reportId + "&Type=1&Page=" + page + "&ProcessName=" + $('#txtShow').val() + "&StartTime=" + $('#txtStartTime').val() + "&EndTime=" + $('#txtEndTime').val(),
                success: function (date) {
                    var json = eval('(' + date + ')').TABLE;

                    if (reportId == "1") {
                        $("#table1 tr:not(:first)").each(function () { $(this).remove(); });
                        for (var i = 0; i < json.length; i++) {
                            var row = "<tr><td style=\"text-align:center;\">" + json[i].NUM + "</td><td style=\"text-align:center;\">" + json[i].PROCESSNAME + "</td><td style=\"text-align:center;\">" + json[i].DAYS + "</td><td style=\"text-align:center;\">" + json[i].HOURS + "</td></tr>";
                            $(row).insertAfter($("#table1 tr:last"));
                        }
                    } else if (reportId == "2") {
                        $("#table2 tr:not(:first)").each(function () { $(this).remove(); });
                        for (var i = 0; i < json.length; i++) {
                            var row = "<tr><td style=\"text-align:center;\">" + json[i].NUM + "</td><td style=\"text-align:center;\">" + json[i].PROCESSNAME + "</td><td style=\"text-align:center;\">" + json[i].STEPNAME + "</td><td style=\"text-align:center;\">" + json[i].DAYS + "</td><td style=\"text-align:center;\">" + json[i].HOURS + "</td></tr>";
                            $(row).insertAfter($("#table2 tr:last"));
                        }
                    } else if (reportId == "3") {
                        $("#table3 tr:not(:first)").each(function () { $(this).remove(); });
                        for (var i = 0; i < json.length; i++) {
                            var row = "<tr><td style=\"text-align:center;\">" + json[i].NUM + "</td><td style=\"text-align:center;\">" + json[i].USERNAME + "</td><td style=\"text-align:center;\">" + json[i].USERACCOUNT + "</td><td style=\"text-align:center;\">" + json[i].ORGNAME + "</td><td style=\"text-align:center;\">" + json[i].DAYS + "</td><td style=\"text-align:center;\">" + json[i].HOURS + "</td></tr>";
                            $(row).insertAfter($("#table3 tr:last"));
                        }
                    }
                }
            });
        }

        //判断选择了哪个tab
        function chooseWhichTab() {
            var reportId = "1";
            if ($("#tab1").hasClass("active")) reportId = "1";
            if ($("#tab2").hasClass("active")) reportId = "2";
            if ($("#tab3").hasClass("active")) reportId = "3";
            return reportId;
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server" style="width: 93%; height: 100%;">
    <div>
        <table class="table table-hover table-bordered table-condensed">
            <tr>
                <td class="td-label" style="width: 20%">
                    流程名称：
                </td>
                <td colspan="2" class="td-content" style="width: 80%">
                    <input style="width:98%" id="txtShow" onfocus="$('#selectDiv').show()"  onkeydown="return false;" />
                    <div style="z-index: 5; display: none; position: absolute; background-color: White"
                        id="selectDiv">
                        <table border="1">
                            <tr>
                                <td>
                                    <select multiple="multiple" id="myselect" name="myselect[]">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <input type="button" class="btn" value="确定" onclick="$('#selectDiv').hide()" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td-label" style="width: 20%">
                    过滤时间：
                </td>
                <td class="td-content" style="width: 45%; border-right: 0px;">
                    <input type="text" style="width: 120px" id="txtStartTime" onclick="WdatePicker()"  onkeydown="return false;"
                        class="Wdate" />
                    &nbsp;&nbsp;至&nbsp;&nbsp;
                    <input type="text" style="width: 120px" id="txtEndTime" onclick="WdatePicker()" class="Wdate" onkeydown="return false;" />
                    &nbsp;&nbsp;
                    <input type="button" style="width: 55px" id="btnSearch" class="btn" value="查询" onclick="search();" />
                </td>
                <td class="td-content" style="width: 25%; border-left: 0px;">
                    <asp:RadioButtonList runat="server" Width="200px" ID="IsShowCharts" onclick="showChartsOrTable()"
                        RepeatDirection="Horizontal" RepeatColumns="2">
                        <asp:ListItem Value="1" Text="排行榜" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="2" Text="详细列表"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </div>
    <div id="demo" class="demolayout">
        <ul id="demo-nav" class="demolayout">
            <li><a id="tab1" href="javascript:void(0);" onclick="showTabs(1)" class="active">流程总体耗时报表</a></li>
            <li><a id="tab2" href="javascript:void(0);" onclick="showTabs(2)">步骤总体耗时报表</a></li>
            <li><a id="tab3" href="javascript:void(0);" onclick="showTabs(3)">人员总体耗时报表</a></li>
        </ul>
    </div>
    <div style="width: 100%; height: 100%;">
        <div id="chartParDiv">
            <div id="chartdiv" style="width: 100%; height: 380px;">
            </div>
        </div>
        <div id="tablediv1" style="display: none; width: 100%;">
            <table class="table table-bordered table-hover table-condensed" id="table1">
                <tr>
                    <th width="10%">
                        序号
                    </th>
                    <th width="40%">
                        流程名称
                    </th>
                    <th width="25%">
                        平均耗时（天）
                    </th>
                    <th width="25%">
                        平均耗时（时）
                    </th>
                </tr>
            </table>
        </div>
        <div id="tablediv2" style="display: none; width: 100%;">
            <table class="table table-hover table-bordered table-condensed" id="table2">
                <tr>
                    <th width="10%">
                        序号
                    </th>
                    <th width="30%">
                        流程名称
                    </th>
                    <th width="30%">
                        步骤名称
                    </th>
                    <th width="15%">
                        平均耗时（天）
                    </th>
                    <th width="15%">
                        平均耗时（时）
                    </th>
                </tr>
            </table>
        </div>
        <div id="tablediv3" style="display: none; width: 100%;">
            <table class="table table-hover table-bordered table-condensed" id="table3">
                <tr>
                    <th width="10%">
                        序号
                    </th>
                    <th width="15%">
                        人员姓名
                    </th>
                    <th width="15%">
                        账号
                    </th>
                    <th width="30%">
                        所属组织
                    </th>
                    <th width="15%">
                        平均耗时（天）
                    </th>
                    <th width="15%">
                        平均耗时（时）
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <div id="pagingParDiv" style="display: none;">
        <div id="pagingDiv">
        </div>
    </div>
    </form>
</body>
</html>
