<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.UserInfo" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<%=WebUtil.IncludeCssV3() %>
<%=WebUtil.IncludeJsV3() %>
<link href="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/css/form.css" type="text/css" rel="stylesheet" />
<link href="../../../Solution/Ultimus.UWF.Form.ProcessControl.V3/css/print.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">
    self.moveTo(0, 0);
    self.resizeTo(screen.availWidth, screen.availHeight);
    var _rootPath="<%=WebUtil.GetRootPath()%>";

    function request(paras) {
        var url = location.href;
        var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
        var paraObj = {}
        for (i = 0; j = paraString[i]; i++) {
            paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
        }
        var returnValue = paraObj[paras.toLowerCase()];
        if (typeof (returnValue) == "undefined") {
            return "";
        } else {
            return returnValue;
        }
    }

    function code128() {
        $("#barcode2").empty().barcode($("#UserInfo1_fld_DOCUMENTNO").text(), "code128", { barWidth: 1, barHeight: 30, showHRI: false });
    }

    jQuery(document).ready(function () {
        code128();

        $("input[money=money]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9.]/g, '');
            });
        });
        $("input[money=int]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });
        $(".readonlycss").each(function () {
            $(this).css({'background-color': "#eeeeee", 'cursor': "not-allowed" });
            $(this).attr("onfocus", "this.blur()");
            var oldTip = $(this).attr("title");
            $(this).attr("title", "");            
            $(this).click(function () {
                return false;
            });
            $(this).keydown(function () {
                return false;
            });
        });
        $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
        $('.autonumber').focus(function () {
            $('.autonumber').autoNumeric('init', { vMin: '-9999999999999.99', vMax: '9999999999999.99' });
        });

        $('.show-datetime').daterangepicker({
            singleDatePicker: true,
            "showDropdowns": true,
            "locale": {
                "format": "YYYY/MM/DD"
            }
        });
        $('.show-money').css("text-align", "right");
        $('.show-year').datetimepicker({
            format: 'yyyy',
            weekStart: 1,
            autoclose: true,
            startView: 4,
            minView: 4,
            forceParse: false,
            language: 'zh-CN'
        });
        $("span[id^=fld_detail]").each(function () {
            $(this).css("text-align", "center");

        });
        if (request("type").toLocaleLowerCase() == "myrequest") {
            $(":input[type!=submit][type!=radio][type!=checkbox][type!=button]:visible").each(function () {
                if ($(this).hasClass("selector")) {
                    var txt = $(this).find("option:selected").text();
                    $(this).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(this).css("width") + ";text-align:center;\">" + txt + "</span>");
                    $(this).css("display", "none");

                } else {
                    $(this).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(this).css("width") + ";text-align:center;\">" + $(this).val() + "</span>");
                    $(this).css("display", "none");
                }
            })

            $("input:radio").each(function () {
                $(this).attr("disabled", "disabled");
            })
            $("input:checkbox").each(function () {
                $(this).attr("disabled", "disabled");
            })
            $(":button").each(function () {
                $(this).css("display", "none");
            })
            $(".btn").each(function () {
                if ($(this)[0].name != "ButtonList1$btnClose" && $(this)[0].name != "ButtonList1$btnCallback" && $(this)[0].id != "ButtonList1_btnPrint") {
                    $(this).css("display", "none");
                }
            })
            $(".add-on").each(function () {
                    $(this).css("display", "none");
            })
            $(".selectpicker").each(function () {
                $(this).attr("class", "");
            })
        }

        $(".form-label").each(function () {
            //$(this).css('hight', $(this).next().height());
            //alert($(this).height()); alert($(this).next().children().height());
            if ($(this).height() < $(this).next().children().height()) {
                $(this).height($(this).next().children().height() + 10);
            } else {
                $(this).next().height($(this).height());
            }
        })
    });


    function printpage() {
        if (window.print) {
            window.print();
        }
    }


    $(document).ready(function () {
        printpage();
    });
</script>

<div class="hidden">
    <asp:TextBox ID="fld_Status" runat="server" Text="1"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSNAME" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_INCIDENT" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtStepName" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_FORMID" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtProcessPrefix" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtReadOnly" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableName" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableNameDetail" runat="server"></asp:TextBox>

    <asp:TextBox ID="var_ApplicantAccount" runat="server" Text=""></asp:TextBox><%--申请人账号--%>
    <asp:TextBox ID="fld_DEPARTMENTID" runat="server" Text=""></asp:TextBox><%--本部门Id--%>

    <%--<asp:TextBox ID="var_AttachmentPath" runat="server" Text=""></asp:TextBox>--%>
    <%--<asp:TextBox ID="var_AttachmentName" runat="server" Text=""></asp:TextBox>--%>


    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTaskId" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTACCOUNT" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtApplicantAccount" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSSUMMARY" runat="server" Text="" Width="87%"></asp:TextBox>

    <asp:TextBox ID="txtIsVarSubmit" runat="server" Text="0"></asp:TextBox>
    <asp:TextBox ID="txtIsCreateForm" runat="server" Text="0"></asp:TextBox>

    <asp:Label ID="lblSummary" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="barcode" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="incident" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblCOMPANY" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblProcessName" runat="server"></asp:Label>

</div>

<%--<!-- Start Page Loading -->
    <div class="loading">
        <img src="<%=WebUtil.GetRootPath() %>/common/assets/img/loading.gif" alt="loading-img"></div>
    <!-- End Page Loading -->--%>

<!-- //////////////////////////////////////////////////////////////////////////// -->
<!-- START CONTENT -->
<div class="form-content">

    <!-- Start Page Header -->
    <div class="page-header ">
        <div class="left">
            <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/form_logo.jpg" alt="logo" />
        </div>
        <h1 class="title center"><strong><%=lblProcessName.Text.Split(',')[0] %></strong></h1>
        <ol class="breadcrumb center">
            <li class="active"><%=lblProcessName.Text.Split(',').Length>1?lblProcessName.Text.Split(',')[1]:"" %></li>
        </ol>
        <div class="right">
            <div class="btn-group">
                <div id="barcode2">
                </div>

                <div id="documentno" style="text-align: center">
                    <asp:Label ID="lblDocumentNo" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="fld_DOCUMENTNO" runat="server"></asp:Label>

                </div>
            </div>
        </div>

    </div>
    <!-- End Page Header -->

    <!-- //////////////////////////////////////////////////////////////////////////// -->
    <!-- START CONTAINER -->
    <div class="container-default">
        <!-- Start Row -->
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_BasicInfo")%>
                        </div>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:</span>
                            </div>
                            <div class="form-content">
                                <asp:Label ID="fld_APPLICANT" runat="server" Text=""></asp:Label>
                            </div>
                        </div>

                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-group">
                                <div class="form-label">
                                    <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Department")%>:
                                </div>
                                <div class="form-content">
                                    <asp:Label ID="fld_DEPARTMENT" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-sm-12 col-xs-12 form-cell">
                            <div class="form-group">
                                <div class="form-label">
                                    <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_RequestDate")%>:
                                </div>
                                <div class="form-content">
                                    <asp:Label ID="fld_REQUESTDATE" runat="server" Text="" CssClass="utcdatetime"></asp:Label>
                                </div>
                            </div>
                        </div>

                    <%--</div>
                </div>
            </div>

        </div>
        <!-- End Row -->--%>
