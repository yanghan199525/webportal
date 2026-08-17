<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportList.aspx.cs" Inherits="UWF.Process.MPR_SERVICE.ReportList" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>MPR_SERVICE Report</title>
    <link rel="stylesheet" href="../../../common/assets37/css/base.min.css">
    <link rel="stylesheet" href="../../../common/assets/css/style.css">
    <style type="text/css">
        table td {
            padding: .3rem !important;
        }

        table th {
            padding: .3rem !important;
        }
        /*table tbody td {
            padding: 0;
        }*/
        .main-card {
            line-height: unset;
        }

            .main-card .form-group {
                margin: 0;
            }
        /*提示框样式*/
        .tooltip-inner {
            background: #fafafa !important; /*修改背景色*/
            text-align: left !important; /*字体左对齐*/
            color: #363636 !important; /*字体颜色*/
            border: 1px solid #dedede; /*添加boder*/
            width: 200px;
            max-width: 400px !important;
        }

        .tooltip-arrow {
            border-bottom-color: #ffffff !important; /*修改三角形的颜色*/
            opacity: 0; /*三角形透明*/
        }

        .tooltip {
            opacity: 1 !important; /*让整个tooltip不透明*/
        }

        .label {
            display: inline;
            padding: .2em .6em .3em;
            font-weight: bold;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: .25em;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="app-container app-theme-white body-tabs-shadow fixed-header fixed-sidebar">
            <!-- Panel Header -->
            <div class="app-page-title" style="height: 5rem; margin: 0; padding: 0;">
                <div class="page-title-wrapper pl-3 pr-3 mr-3" style="height: 4.5rem;">
                    <div class="page-title-heading">
                        <div class="page-title-icon">
                            <i class="pe-7s-medal icon-gradient bg-tempting-azure"></i>
                        </div>
                        <div>
                            <div class="page-title-subheading"><h4>MPR_SERVICE <%= Lang.Get("Report") %></h4></div>
                        </div>
                    </div>
                    <div class="page-title-actions">
                        <ult:Button ID="Button1" runat="server" Text="查询" CssClass="mr-2 btn btn-info" />
                        <asp:LinkButton ID="lbExport" runat="server" CssClass="mr-2 btn btn-primary" OnClick="lbExport_Click">
                            <span class="btn-icon-wrapper pr-2 opacity-7">
                                <i class="fa fa-business-time fa-w-20"></i>
                            </span>
                            <%= Lang.Get("Export") %>
                        </asp:LinkButton>
                        <a class="btn mr-3 btn-light" href="javascript:location.href=location.href;"><i class="fa lnr-sync"></i><%= Lang.Get("Default_Refresh") %></a>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="main-card card mt-3 mr-3 ml-3">
                <div class="card-body pb-2">
                    <div class="form-row">
                        <!-- Panel Search -->
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label for="txt_DOCUMENTNO">
                                    <%=Lang.Get("AP_Form_DocumentNo")%>:
                                </label>
                                <ult:TextBox ID="txt_DOCUMENTNO" runat="server" CssClass="form-control" Destination="DOCUMENTNO"></ult:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label for="txt_REQUESTDATESTART"><%=Lang.Get("Form_RequestDate")%>:</label>
                                <div class="input-group">
                                    <ult:TextBox ID="txt_REQUESTDATESTART" data-type="date" runat="server" CssClass="form-control" Destination="Scope.Start.REQUESTDATE"></ult:TextBox>
                                    <div class="input-group-prepend datepicker-trigger">
                                        <div class="input-group-text">
                                            <i class="fa fa-calendar-alt"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="position-relative form-group">
                                <label for="txt_REQUESTDATEEND"><%=Lang.Get("To_RequestDate")%>:</label>
                                <div class="input-group">
                                    <ult:TextBox ID="txt_REQUESTDATEEND" data-type="date" runat="server" CssClass="form-control" Destination="Scope.End.REQUESTDATE"></ult:TextBox>
                                    <div class="input-group-prepend datepicker-trigger">
                                        <div class="input-group-text">
                                            <i class="fa fa-calendar-alt"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-1">
                            <div class="position-relative form-group">
                                <label>&nbsp;</label>
                                <div>
                                    <button type="button" data-toggle="collapse" data-target="#exConditions" aria-expanded="true" aria-controls="exConditions"
                                            class="ml-3 mb-2 mr-2 btn-icon btn-icon-only btn btn-light" onclick="tabFormTitle(this)">
                                        <i class="exIcon fa fa-chevron-left btn-icon-wrapperr"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="collapse" id="exConditions">
                        <div class="form-row">
                            <div class="col-md-4">
                                <div class="position-relative form-group">
                                    <label for="txt_STATUS"><%=Lang.Get("TaskList_Status")%>:</label>
                                    <div class="input-group">
                                        <ult:DropDownList ID="txt_STATUS" data-type="string" runat="server" CssClass="form-control" Destination="STATUS">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="1">处理中</asp:ListItem>
                                            <asp:ListItem Value="2">已完成</asp:ListItem>
                                            <asp:ListItem Value="3">退回</asp:ListItem>
                                            <asp:ListItem Value="4">终止</asp:ListItem>
                                            <asp:ListItem Value="0">未知</asp:ListItem>
                                        </ult:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="position-relative form-group">
                                    <label for="txt_APPLICANT">
                                        <%=Lang.Get("Form_Applicant")%>:
                                    </label>
                                    <ult:TextBox ID="txt_APPLICANT" runat="server" CssClass="form-control" Destination="APPLICANT"></ult:TextBox>
                                </div>
                            </div>


                        </div>
                    </div>
                    <!-- Table -->
                    <div style="width: 100%; overflow-x: scroll;">
                        <table id="detailTable" class="table table-hover table-striped table-bordered mt-3">
                            <thead>
                                <tr>
                                    <th>
                                        <%=Lang.Get("A01001.NumberNo")%>
                                    </th>
                                    <th>
                                        <%=Lang.Get("A01001.Monitor")%>
                                    </th>
                                    <th style="text-align:center;width: 135px">
                                        <%=Lang.Get("AP_Form_DocumentNo")%>
                                    </th>
                                    <th style="text-align: center; width: 22px">
                                        <%=Lang.Get("Form_Status")%>
                                    </th>
                                    <th style="text-align: center; width: 55px">
                                        <%=Lang.Get("Form_Applicant")%>
                                    </th>
                                    <th style="text-align: center; width: 40px">
                                        <%=Lang.Get("Form_Department")%>
                                    </th>
                                    <th style="text-align: center; width: 90px">
                                        <%=Lang.Get("Form_RequestDate")%>
                                    </th>
                                        <th nowrap="nowrap" style="min-width:100px;text-align:center;">
                                            <%=Lang.Get("UWF.Process.MPR_SERVICE.SITECODE") %>
                                        </th>
                                    <th>PDF</th>
                                </tr>
                            </thead>
                            <tbody>
                                <ult:Repeater ID="rptList" OnItemCommand="rpSource_ItemCommand" Source="BizDB.PROC_MPR_SERVICE" PagerID="AspNetPager1" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%#  Container.ItemIndex + 1%>
                                            </td>
                                            <td>
                                                <span class="btn btn-icon btn-smk"
                                                      onclick="window.open('../../../Portal/Ultimus.UWF.Home.V3/TaskStatus.aspx?ProcessName=<%#Server.UrlEncode(Eval(" PROCESSNAME").ToString().Trim())%>
                                                    &Incident=<%#Eval("INCIDENT")%>');">
                                                    <%=Lang.Get("A01001.Monitor")%>

                                                </span>
                                            </td>
                                            <td>
                                                <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval(" FormID") %>
                                                    ','<%#Eval("ProcessName") %>','<%#Eval("Incident") %>');return false;" style="cursor:head">
                                                    <%#Eval("DOCUMENTNO")%>
                                                </a>
                                            </td>
                                            <td style="text-align:center;vertical-align:middle;">
                                                <span class='<%#GetStatusClass(Eval("STATUS").ToString())%>'><%#GetStatus(Eval("STATUS").ToString())%></span>
                                            </td>
                                            <td class="hidden">
                                                <%#Eval("STATUS")%>
                                            </td>
                                            <td>
                                                <%#Eval("APPLICANT")%>
                                            </td>
                                            <td>
                                                <%#Eval("DEPARTMENT")%>
                                            </td>
                                            <td>
                                                <%# Eval("REQUESTDATE")!=DBNull.Value?String.Format("{0:yyyy-MM-dd}", MyLib.ConvertUtil.ToDateTime(Eval("REQUESTDATE"))):""%>
                                            </td>
                                                    <td data-toggle="tooltip" data-placement="bottom" title='<%#Eval("SITECODE")%>'>
                                                        <%# WriteContext(Eval("SITECODE"))%>
                                                    </td>
                                            <td>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("FORMID")+"," +Eval("DOCUMENTNO")+","+Eval("INCIDENT")+","+Eval("PROCESSNAME") %>'
                                                                CommandName="Download">PDF文件</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </ult:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Pager -->
            <nav class="navigation ml-3" aria-label="Page navigation example">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="pagination mb-5"
                                      NumericButtonCount="5" CurrentPageButtonClass="page-link page-item active"
                                      FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                                      NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                                      AlwaysShow="false" PageSize="10">
                </webdiyer:AspNetPager>
            </nav>
        </div>
    </form>
    <script type="text/javascript" src="../../../Common/assets37/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="../../../Common/assets37/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../../../Common/assets37/js/datatables/datatables.min.js"></script>
    <script type="text/javascript" src="../../../Common/assets37/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../../Common/assets/js/autoNumeric.js"></script>
    <script type="text/javascript" src="../../../Common/Assets/js/common.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".pagination a").addClass("page-link").removeClass("mb-5");
            InitDate();
            var width = ($("#detailTable").width() / $("#detailTable").parent().width()) * 100 + 10;
            $("#detailTable").css("width", width + "%");
            $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
            $('[data-toggle="tooltip"]').each(function () {
                if ($.trim($(this).text()).length >= 10) {
                    $(this).tooltip();
                };
            })
        });

        // 表单头部收缩切换
        function tabFormTitle(obj) {
            // 折叠
            $("#exConditions").on('hidden.bs.collapse', function () {
                $(".exIcon").removeClass("fa-chevron-down").removeClass("fa-chevron-left");
                $(".exIcon").addClass("fa-chevron-left");
            })
            // 展开
            $("#exConditions").on('shown.bs.collapse', function () {
                $(".exIcon").removeClass("fa-chevron-down").removeClass("fa-chevron-left");
                $(".exIcon").addClass("fa-chevron-down");
            })
        }

        function InitDate() {
            $('input[data-type="date"]').each(function () {
                $(this).removeAttr("lay-key");
                laydate.render({
                    elem: this
                    , theme: '#4b87f5'
                    , min: '2000-12-30'// 固定格式，格式不能变
                    , max: '2100-12-30'
                    , format: 'yyyy/MM/dd' //可任意组合
                });
            })
        }
    </script>
    <script type='text/javascript' src='ReportList.js?t=639223109423840643'></script>
</body>

</html>