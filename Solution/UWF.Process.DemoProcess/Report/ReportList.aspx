<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportList.aspx.cs" Inherits="UWF.Process.DemoProcess.ReportList" %>
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
    <title>Demo Process Report</title>
    <link rel="stylesheet" href="../../../common/assets37/css/base.min.css">
</head>

<body>
    <form id="form1" runat="server">
        <div class="app-container app-theme-white body-tabs-shadow fixed-header fixed-sidebar">
            <!-- Panel Header -->
            <div class="app-page-title" style="margin-bottom: 0;">
                <div class="page-title-wrapper">
                    <div class="page-title-heading">
                        <div class="page-title-icon">
                            <i class="pe-7s-medal icon-gradient bg-tempting-azure"></i>
                        </div>
                        <div>
                            Data Tables
                                    <div class="page-title-subheading">Demo Process <%= Lang.Get("Report") %></div>
                        </div>
                    </div>
                    <div class="page-title-actions">
                        <asp:LinkButton ID="lbExport" runat="server" CssClass="btn-shadow mr-3 btn btn-info" OnClick="lbExport_Click">
                           <span class="btn-icon-wrapper pr-2 opacity-7">
                                            <i class="fa fa-business-time fa-w-20"></i>
                                        </span>
                         <%= Lang.Get("Export") %></asp:LinkButton>
                        <a class="btn-shadow btn mr-3 btn-light" href="javascript:location.href=location.href;"><i class="fa lnr-sync"></i><%= Lang.Get("Default_Refresh") %></a>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="main-card mb-3 card">
                <div class="card-body">
                  <div class="row">
                        <!-- Panel Search -->
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label for="txt_DOCUMENTNO"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_DocumentNo")%>:
                                </label>
                                <ult:TextBox ID="txt_DOCUMENTNO" runat="server" CssClass="form-control" Destination="DOCUMENTNO"></ult:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label for="txt_REQUESTDATESTART" ><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_RequestDate")%>:</label>
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
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label for="txt_REQUESTDATEEND" ><%=Ultimus.UWF.Common.Logic.Lang.Get("To_RequestDate")%>:</label>
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
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label for="txt_APPLICANT">
                                    <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:</label>
                                 <ult:TextBox ID="txt_APPLICANT" runat="server" CssClass="form-control" Destination="APPLICANT"></ult:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="position-relative form-group">
                                <label> </label>
                                <div>
                                    <ult:Button ID="Button1" runat="server" Text="Search" CssClass="btn-shadow mr-3 btn btn-info" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Table -->
                    <table id="detailTable" class="table table-hover table-striped table-bordered">
                        <thead>
                            <tr>
                                <th style="min-width:100px"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_DocumentNo")%>
                                </th>
                                <th style="min-width:100px"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>
                                </th>
                                <th style="min-width:100px"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Department")%>
                                </th>
                                <th style="min-width:100px"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_RequestDate")%>
                                </th>
                                <th style="min-width:100px"><%=Lang.Get("UWF.Process.DemoProcess.ApplicationType") %>
                                </th>
                                <th style="min-width:100px"><%=Lang.Get("UWF.Process.DemoProcess.AppointedVendor") %>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <ult:Repeater ID="rptList" Source="BizDB.PROC_DEMOPROCESS" PagerID="AspNetPager1" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval("FormID") %>','<%#Eval("ProcessName") %>','<%#Eval("Incident") %>');return false;" style="cursor:head">
                                                <%#Eval("DOCUMENTNO")%>
                                            </a>
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
                                        <td>
                                             <%#Eval("ApplicationType")%>
                                            </td>
                                        <td>
                                             <%#Eval("AppointedVendor")%>
                                            </td>
                                    </tr>
                                </ItemTemplate>
                            </ult:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
            }

            <!-- Pager -->
            <nav class="navigation" aria-label="Page navigation example">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="pagination mb-5"
                    NumericButtonCount="5" CurrentPageButtonClass="page-link page-item active"
                    FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                    NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                    AlwaysShow="false" PageSize="10">
                </webdiyer:AspNetPager>
            </nav>
        </div>
    </form>
    <script src="../../../common/assets/js/jquery-3.4.1.min.js" type="text/javascript"></script>
    <!--TABLES -->
    <script src="../../../Common/assets/js/datatables/datatables.min.js"></script>

    <!--laydate-->
    <script src="../../../Common/assets/laydate/laydate.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".pagination a").addClass("page-link").removeClass("mb-5");
            InitDate();
            $("#detailTable").dataTable({
                "scrollX": true,
                "autoWidth": true,
                "paging": false,
                "info": false, // 用来描述表格主要信息的字符串
                "deferRender": true,// 控制Datatables的延迟渲染，可以提高初始化的速度
                "searching": false,
                "ordering": false
            });
            //iFrameHeight();
        });

        function iFrameHeight() {
            var ifm = parent.window.frames["FormMain"];
            var subWeb = parent.window.frames ? parent.window.frames["FormMain"].contentDocument : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
                ifm.width = subWeb.body.scrollWidth;
            }
        }

        function InitDate() {
            $('input[data-type="date"]').each(function () {
                $(this).removeAttr("lay-key");
                laydate.render({
                    elem: this
                    , theme: '#4b87f5'
                    , min: '2000-12-30'// 格式不能变
                    , max: '2100-12-30'
                    , format: 'yyyy/MM/dd' //可任意组合
                });
            })
        }
    </script>
    <script type='text/javascript' src='ReportList.js?t=637063256296209451'></script>
</body>

</html>