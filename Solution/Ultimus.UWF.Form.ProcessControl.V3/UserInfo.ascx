<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfo.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.UserInfo" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<%=WebUtil.IncludeCssV3() %>
<%=WebUtil.IncludeJsV3() %>
<%=WebUtil.IncludeFormV3Css()%>

<script type="text/javascript">
    self.moveTo(0, 0);
    self.resizeTo(screen.availWidth, screen.availHeight);
    var _rootPath = "<%=WebUtil.GetRootPath()%>";

    function code128() {
        $("#barcode2").empty().barcode($("#UserInfo1_fld_DOCUMENTNO").text(), "code128", { barWidth: 1, barHeight: 30, showHRI: false });
    }

    $(document).ready(function () {
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
        $("input[data-type=money]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9.]/g, '');
            });
        });
        $("input[data-type=int]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });
        $("input[data-type=number]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9.]/g, '');
            });
        });
        $(".readonlycss").each(function () {
            $(this).css({ 'background-color': "#eeeeee", 'cursor': "not-allowed" });
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
        if (request("type").toLocaleLowerCase() == "myrequest" || request("type").toLocaleLowerCase() == "myapproval"
            || request("type").toLocaleLowerCase() == "myunread" || request("type").toLocaleLowerCase() == "myread"
            || request("type").toLocaleLowerCase() == "report") {
            $(":input[type!=submit][type!=radio][type!=checkbox][type!=button]:visible").each(function () {
                if ($(this).attr("id") == "fld_MAINPROFITCENTERNAME")
                    alert($(this).attr("id"));
                if ($(this).attr("input-type") == "textarea") {
                    $(this).attr("disabled", "disabled");
                } else if ($(this).hasClass("selector")) {
                    var txt = $(this).find("option:selected").text();
                    $(this).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(this).css("width") + ";text-align:center;\">" + txt + "</span>");
                    $(this).css("display", "none");

                } else if ($(this).attr("id") != "CirculationUserInfo_DeleteRow") {
                    $(this).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(this).css("width") + ";text-align:center;\">" + $(this).val() + "</span>");
                    $(this).next().html(FilterHtmls($(this).val()));
                    $(this).css("display", "none");
                }
            })
            $("#Attachments1_uploadrow").remove();

            $("input:radio").each(function () {
                $(this).attr("disabled", "disabled");
            })
            $("input:checkbox").each(function () {
                $(this).attr("disabled", "disabled");
            })
            $(":button").each(function () {
                if ($(this).attr("id") != "ButtonList1_btnChuanYue"
                    && $(this).attr("id") != "ButtonList1_btn_Assign"
                    && $(this).attr("id") != "btn_Assign"
                    && $(this).attr("id") != "btn_cancel"
                    && $(this).attr("id") != "CirculationUserInfo_DeleteRow"
                    && $(this).attr("id") != "ButtonList1_btnAddSign"
                    && !$(this).hasClass("btnJson")) {
                    $(this).css("display", "none");
                }
            })
            $(".btn").each(function () {
                if ($(this)[0].id != "ButtonList1_btnClose"
                    && $(this)[0].id != "ButtonList1_btnCallback"
                    && $(this)[0].id != "ButtonList1_btnProcessCopy"
                    && $(this)[0].id != "ButtonList1_btnReminders"
                    && $(this)[0].id != "ButtonList1_btnAbortIncident"
                    && $(this)[0].id != "ButtonList1_btnPrint"
                    && $(this)[0].id != "ButtonList1_hyFlow"
                    && $(this)[0].id != "ButtonList1_btnChuanYue"
                    && $(this)[0].id != "ButtonList1_btn_Assign"
                    && $(this)[0].id != "ButtonList1_btnApprover"
                    && $(this)[0].id != "ButtonList1_btnAddSign"
                    && $(this)[0].id != "btn_Assign"
                    && $(this)[0].id != "btn_cancel"
                    && $(this)[0].id != "CirculationUserInfo_DeleteRow"
                    && !$(this).hasClass("btnJson")
                ) {
                    $(this).css("display", "none");
                }
            })
            $(".attachment_show .btn").each(function () {
                $(this).css("display", "");
            })
            $(".add-on").each(function () {
                if ($(this).attr("id") != "btn_assignSpan")
                    $(this).css("display", "none");
            })

            $(".selectpicker").each(function () {
                $(this).attr("class", "");
            })
        }

        //$(".form-label").each(function () {
        //    if ($(this).next().children().find("div").attr("data-type") == "wangEditor") {
        //        //$(this).parent().removeAttr("auto");
        //    }

        //    if ($(this).height() < $(this).next().children().height()) {
        //        $(this).height($(this).next().children().height() + 10);
        //    } else {
        //        $(this).next().height($(this).height());
        //    }
        //})

    });

    //给css为attachment的div加上附件上传
    $().ready(function () {
        $(".attachment").each(function () {
            attachUpload(this);
        });

        if (request("type").toLocaleLowerCase() == "myrequest" || request("type").toLocaleLowerCase() == "myapproval") {
            $(".uploadifive-button").each(function () {
                $(this).remove();
            })
        }
    });

    function attachUpload(ele) {
        var formid = '<%=Request.QueryString["formid"]%>';
        var processname = '<%=Request.QueryString["processname"]%>';
        var incident = '<%=Request.QueryString["incident"]%>';
        var id = "";
        var flag = 0;
        var errorCount = 0;
        var successCount = 0;
        $(ele).uploadifive({
            //开启调试  
            'debug': false,
            //是否自动上传  
            'auto': false,
            'buttonText': '<%=Ultimus.UWF.Common.Logic.Lang.Get("Select")%>',
            //文件选择后的容器ID
            'queueID': 'attqueue',
            //按钮样式
            'buttonClass': 'btn btn-icon btn-default hidden-print ',
            'uploadScript': '<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/UploadHandler.ashx?ProcessName=' + processname + '&Incident=' + incident + '&StepName=&FORMID=' + formid + '&USERNAME=',
            'width': '100',
            'height': '34',
            'multi': true,
            'fileTypeDesc': 'All Files ',
            'fileTypeExts': '*.*',
            'fileSizeLimit': '<%=MyLib.ConfigurationManager.AppSettings["AttachmentSizeLimit"]%>',
            'removeTimeout': 1,
            'removeCompleted': true,
            onSelect: function (e, queueId, fileObj) {
                id = $(this).attr("id");
                $(this).data('uploadifive').settings.formData = { 'TYPE': id };
                $(this).uploadifive('upload');
                errorCount = e.errors;
                successCount = e.selected - e.errors;
                flag = 0;
                if (flag == 0) {
                    alert(successCount + '<%=Ultimus.UWF.Common.Logic.Lang.Get("UploadedSuccess")%>' + errorCount + '<%=Ultimus.UWF.Common.Logic.Lang.Get("UploadedFailed")%>');
                    flag = 1;
                }
                //if (e.errors > 0)
                //{
                //    flag = 1;
                //    alert("有" + errorCount + "个上传文件超过大小!");
                //}
                //else
                //{
                //    flag = 0;
                //}
            },
            //返回一个错误，选择文件的时候触发  
            'onSelectError': function (file, errorCode, errorMsg) {
                alert(errorMsg);
                switch (errorCode) {
                    case -100:
                        alert("File number limit" + $('#file_upload').uploadifive('settings', 'queueSizeLimit') + " files！");
                        break;
                    case -110:
                        alert("File [" + file.name + "] size limit" + $('#file_upload').uploadifive('settings', 'fileSizeLimit') + "！");
                        break;
                    case -120:
                        alert("File [" + file.name + "] size error！");
                        break;
                    case -130:
                        alert("File [" + file.name + "] type error！");
                        break;
                }
            },
            //上传到服务器，服务器返回相应信息到data里  
            'onUploadComplete': function (file, data, response) {

                //var ctl = $(this).parent().parent().find(".attachment_show")[0];
                //var t = $(this).attr("id");
                //$(ctl).empty();
                //$.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx",
                //    { method: "getsingleattachment", formid: formid, type: $(this).attr("id") }, function (data) {
                //        var objs = eval(data);
                //        var obj = objs[0];
                //       //单个附件显示的html
                //        //var rows = '<a href="' + obj.URL + '" target="_blank" class="btn btn-icon btn-sm padding-r-5" href="javascript:void(0)" title="' + obj.FILENAME + '"><i class="fa fa-download"></i></a>' +
                //        //    '&nbsp;<a onclick="if(confirm(\'Delete Confirm?\')){deleteSingleAtt(\'' + obj.NEWNAME + '\',this)}" class="btn btn-icon btn-sm" href="javascript:void(0)" ><i class="fa fa-minus"></i></a> ';
                //        //多个附件显示的html
                //         var rows = '<a href="javascript:void(0);" class="btn btn-icon btn-sm padding-r-5" onclick="showForm({title:\'\',url:\'<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/AttachmentShow.aspx?formid=' + formid + '&type=' + t + '\'});" title=""><i class="fa fa-external-link"></i></a>'
                //        $(ctl)[0].innerHTML = rows;
                //    });
            },
            'onQueueComplete': function (file, data) {

            }
        });
    }

    function deleteSingleAtt(newname, ele) {
        $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx",
            { method: "delete", newname: newname }, function (data) {
                $(ele).parent().empty();
            });
    }

    function ReturnPageIsMethod() {
        //Ajax事件
        debugger;
        var ProcessName = request("ProcessName");
        var LOGINNAME;
        if (ProcessName == "0000") {
            LOGINNAME = $("#fld_EMPLOYEENAME_VALUE").val();
        } else {
            LOGINNAME = $("#UserInfo1_fld_APPLICANTACCOUNT").val();
        }
        if (ProcessName == "000") {

            for (i = 0; i < $("input[id$='fld_HANDOVER']").length; i++) {
                var hanval = $("input[id$='fld_HANDOVER']").eq(0).val();
                var han_val = $("input[id$='fld_HANDOVER_VALUE']").eq(0).val();
                if (hanval != "" && han_val != "") {
                    if ($("input[id$='fld_HANDOVER']").eq(i).val() == "" && $("input[id$='fld_HANDOVER_VALUE']").eq(i).val() == "") {
                        $("input[id$='fld_HANDOVER']").eq(i).val(hanval);
                        $("input[id$='fld_HANDOVER_VALUE']").eq(i).val(han_val);
                    }
                }
            }
            for (i = 0; i < $("input[id$='fld_PAYABLEPARTY']").length; i++) {
                var payval = $("input[id$='fld_PAYABLEPARTY']").eq(0).val();
                var pay_val = $("input[id$='fld_PAYABLEPARTY_VALUE']").eq(0).val();
                if (payval != "" && pay_val != "") {
                    if ($("input[id$='fld_PAYABLEPARTY']").eq(i).val() == "" && $("input[id$='fld_PAYABLEPARTY_VALUE']").eq(i).val() == "") {
                        $("input[id$='fld_PAYABLEPARTY']").eq(i).val(payval);
                        $("input[id$='fld_PAYABLEPARTY_VALUE']").eq(i).val(pay_val);
                    }
                }
            }
        }
        var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx";
        var method = "GetUserInformation";
        //$.ajaxSetup({ async: false });
        $.get(url, { method: method, LOGINNAME: LOGINNAME }, function (data) {

            if (data != null) {
                var objs = eval($.parseJSON(data));

                if (ProcessName == "0000") {
                    $("#fld_STAFFDEPARTMENT").val((objs.DEPARTMENT == null || objs.DEPARTMENT == '') ? '' : objs.DEPARTMENT);
                    $("#fld_POST").val((objs.EXT30 == null || objs.EXT30 == '') ? '' : objs.EXT30);
                }
                else {
                    //名称
                    //$("#UserInfo1_fld_APPLICANT").val((objs.USERNAME == null || objs.USERNAME == '') ? '' : objs.USERNAME + "(" + objs.CNNAME + ")");
                    $("#UserInfo1_fld_APPLICANT").val((objs.USERNAME == null || objs.USERNAME == '') ? '' : objs.CNNAME);
                    //账号
                    $("#UserInfo1_fld_APPLICANTACCOUNT").val($("#UserInfo1_fld_APPLICANTACCOUNT").val().replace('/', '\\'));
                    //工号
                    $("#UserInfo1_fld_APPLICANTCODE").val((objs.EMPNO == null || objs.EMPNO == '') ? '' : objs.EMPNO);
                    //部门
                    $("#UserInfo1_fld_DEPARTMENT").val((objs.DEPARTMENT == null || objs.DEPARTMENT == '') ? '' : objs.DEPARTMENT);
                    //部门CODE
                    $("#UserInfo1_fld_DEPARTMENTID").val((objs.DEPARTMENTID == null || objs.DEPARTMENTID == '') ? '' : objs.DEPARTMENTID);
                    //成本中心
                    //getCost(objs.EXT04)
                    $("#UserInfo1_fld_COSTCENTER").val((objs.COSTCENTER == null || objs.COSTCENTER == '') ? '' : objs.COSTCENTER);
                    $("#UserInfo1_fld_COSTCENTERID").val((objs.EXT05 == null || objs.EXT05 == '') ? '' : objs.EXT05);
                    //联系人
                    $("#UserInfo1_fld_APPLICANTTEL").val((objs.MOBILENO == null || objs.MOBILENO == '') ? "" : objs.MOBILENO);
                    //公司
                    $("#UserInfo1_fld_COMPANY").val((objs.COMPANY == null || objs.COMPANY == '') ? '' : objs.COMPANY);
                    $("#UserInfo1_fld_JOBLEVEL").val((objs.EXT16 == null || objs.EXT16 == '') ? '' : objs.EXT16);
                    $("#UserInfo1_fld_GRADE").val((objs.EXT17 == null || objs.EXT17 == '') ? '' : objs.EXT17);
                    $("#UserInfo1_fld_GRADECODE").val((objs.EXT19 == null || objs.EXT19 == '') ? '' : objs.EXT19);
                    $("#UserInfo1_fld_DEPARTMENTLEVEL").val((objs.EXT29 == null || objs.EXT29 == '') ? '' : objs.EXT29);
                    $("#UserInfo1_fld_JUDGELOGIC1").val((objs.EXT09 == null || objs.EXT09 == '') ? '' : objs.EXT09);
                    $("#UserInfo1_fld_JUDGELOGIC2").val((objs.EXT26 == null || objs.EXT26 == '') ? '' : objs.EXT26);
                    //$("#UserInfo1_fld_COMPANYID").val((objs.EXT03 == null || objs.EXT03 == '') ? '' : objs.EXT03);
                    $("#UserInfo1_fld_JUDGELOGIC3").val((objs.ENNAME == null || objs.ENNAME == '') ? '' : objs.ENNAME);
                    //if (ProcessName=="A05012")
                    //{
                    //    $("#fld_STAFFDEPARTMENT").val((objs.DEPARTMENT == null || objs.DEPARTMENT == '') ? '' : objs.DEPARTMENT);
                    //    $("#fld_STAFFDEPARTMENT").val((objs.DEPARTMENT == null || objs.DEPARTMENT == '') ? '' : objs.DEPARTMENT);
                    //}

                    //职级
                    //$("#UserInfo1_fld_COMPANY").val((objs.COMPANY == null || objs.COMPANY == '') ? '' : objs.COMPANY);
                    if (request("type").toLocaleLowerCase() == "newrequest") {
                        $("#UserInfo1_read_APPLICANT").text((objs.APPLICANT == null || objs.APPLICANT == '') ? '' : objs.APPLICANT);
                        $("#UserInfo1_read_APPLICANTCODE").text((objs.EMPNO == null || objs.EMPNO == '') ? '' : objs.EMPNO);
                        $("#UserInfo1_read_DEPARTMENT").text((objs.DEPARTMENT == null || objs.DEPARTMENT == '') ? '' : objs.DEPARTMENT);
                        $("#UserInfo1_read_JOBFUNCTION").text((objs.JOBFUNCTION == null || objs.JOBFUNCTION == '') ? '' : objs.JOBFUNCTION);
                        $("#UserInfo1_read_EMAIL").text((objs.EMAIL == null || objs.EMAIL == '') ? '' : objs.EMAIL);
                        //职级
                        $("#UserInfo1_read_JOBLEVEL").text((objs.EXT16 == null || objs.EXT16 == '') ? '' : objs.EXT16);
                        //职等
                        $("#UserInfo1_read_GRADE").text((objs.EXT17 == null || objs.EXT17 == '') ? '' : objs.EXT17);
                        $("#UserInfo1_read_GRADECODE").text((objs.EXT19 == null || objs.EXT19 == '') ? '' : objs.EXT19);
                        $("#UserInfo1_read_ENNAME").text((objs.ENNAME == null || objs.ENNAME == '') ? '' : objs.ENNAME);

                        //getCost(objs.EXT04)
                        $("#UserInfo1_read_COSTCENTER").text((objs.COSTCENTER == null || objs.COSTCENTER == '') ? '' : objs.COSTCENTER);


                        $("#UserInfo1_read_COMPANY").text((objs.COMPANY == null || objs.COMPANY == '') ? '' : objs.COMPANY);

                        $("#UserInfo1_read_APPLICANTTEL").text((objs.MOBILENO == null || objs.MOBILENO == '') ? "" : objs.MOBILENO);
                        $("#UserInfo1_read_COSTCENTER").next().text((objs.COSTCENTER == null || objs.COSTCENTER == '') ? '' : objs.COSTCENTER);
                        $("#UserInfo1_read_APPLICANTTEL").next().text((objs.MOBILENO == null || objs.MOBILENO == '') ? "" : objs.MOBILENO);
                    } else {
                        $("#UserInfo1_read_APPLICANT").next().text((objs.APPLICANT == null || objs.APPLICANT == '') ? '' : objs.APPLICANT);
                        $("#UserInfo1_read_APPLICANTCODE").next().text((objs.EMPNO == null || objs.EMPNO == '') ? '' : objs.EMPNO);
                        $("#UserInfo1_read_DEPARTMENT").next().text((objs.DEPARTMENT == null || objs.DEPARTMENT == '') ? '' : objs.DEPARTMENT);
                        $("#UserInfo1_read_JOBFUNCTION").next().text((objs.JOBFUNCTION == null || objs.JOBFUNCTION == '') ? '' : objs.JOBFUNCTION);
                        $("#UserInfo1_read_EMAIL").next().text((objs.EMAIL == null || objs.EMAIL == '') ? '' : objs.EMAIL);
                        //getCost(objs.EXT04)
                        //$("#UserInfo1_read_COSTCENTER").next().text((objs.COSTCENTER == null || objs.COSTCENTER == '') ? '' : objs.COSTCENTER);
                        $("#UserInfo1_read_APPLICANTTEL").next().text((objs.MOBILENO == null || objs.MOBILENO == '') ? "" : objs.MOBILENO);
                        $("#UserInfo1_read_COSTCENTER").next().text((objs.COSTCENTER == null || objs.COSTCENTER == '') ? '' : objs.COSTCENTER);
                        $("#UserInfo1_read_APPLICANTTEL").next().text((objs.MOBILENO == null || objs.MOBILENO == '') ? "" : objs.MOBILENO);
                        //职级
                        $("#UserInfo1_read_JOBLEVEL").next().text((objs.EXT16 == null || objs.EXT16 == '') ? '' : objs.EXT16);
                        //职等
                        $("#UserInfo1_read_GRADE").next().text((objs.EXT17 == null || objs.EXT17 == '') ? '' : objs.EXT17);
                        $("#UserInfo1_read_GRADECODE").next().text((objs.EXT19 == null || objs.EXT19 == '') ? '' : objs.EXT19);
                        $("#UserInfo1_read_ENNAME").text((objs.ENNAME == null || objs.ENNAME == '') ? '' : objs.ENNAME);

                    }
                }
                //
                //加个客户端方法,当申请人发生变化时，回调方法
                if (typeof (UserInfoUserChange) == "function") {
                    UserInfoUserChange();
                }
            }
        });
    }

    function getCost(id) {
        if (id != null && id != undefined) {
            var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx";
            var method = "GetCost"
            var id = id;
            $.ajax({
                url: url,
                type: "POST",
                async: false,
                dataType: "json",
                data: { Method: method, id: id },
                success: function (data) {
                    if (data != "") {// || data != null
                        $("#UserInfo1_fld_COSTCENTER").val((data[0].NAME == null || data[0].NAME == '') ? '' : data[0].NAME);
                        $("#UserInfo1_read_COSTCENTER").text((data[0].NAME == null || data[0].NAME == '') ? '' : data[0].NAME);
                    }
                }
            });
        }
    }
    // 禁用回车事件
    document.onkeydown = function (event) {
        var e = event || window.event || arguments.callee.caller.arguments[0];
        // 排除文本域回车事件
        if (e && e.keyCode == 13 && document.activeElement.tagName != "TEXTAREA") {
            return false;
        }
    };
    document.body.onkeydown = function (event) {
        if (event.keyCode == 13 && document.activeElement.tagName != "TEXTAREA") {
            return false;
        }
    }

    // 手机端样式设置
    $(function () {
        if (isMQQ() || isWeixin()) {
            $(".form-table .form-label").css({
                "display": "flex", "justify-content": "flex-end", "align-items": "center"
                , " background-color": "#efefef", "height": "100%"
                , "min-height": "54px", "float": "left", "padding": "5px"
                , "width": "30%", "position": "relative", "z-index": "4"
            });

            $(".form-table .form-field").css({ "width": "69%", "margin-left": "0px" });
            $(".form-table .form-ctl").css({ "width": "auto", "margin-left": "0px" });
        }
    })
    //下载自定义模板
    function ExcelImportInit(TableId, downloadFile, downloadPath, IsReturnsMethod, IsInterceptVerif) {

        <%--downloadPath ="<%=DESEncrypt.Encrypt("+downloadPath+")%>";--%>
        let html = "<a  style='margin-left:5px;' class='btn btn- icon btn-default hidden-print' href='javascript:void(0);' onclick=DownExcelTempFile('" + downloadFile + "','" + downloadPath + "'); ><%=Lang.Get("DownloadTemplete") %></a >" +
            "<div  style='margin-left:10px;margin-top:5px;' id='" + TableId + "_UploadExcel' ></div> " +
            "   <div id='" + TableId + "_UploadetExcel' class='hidden' ></div>";
        $("#" + TableId).parent().parent().find(".btn-default").after("<br/>").after(html);
        ExcelImportData(TableId, IsReturnsMethod, IsInterceptVerif)
        $("#uploadifive-" + TableId + "_UploadExcel")[0].style.marginLeft = "5px";
    }
    //按照表单导出模板
    function ExcelExportInit(TableId, downloadFile, downloadPath, IsReturnsMethod, IsInterceptVerif) {

        <%--downloadPath ="<%=DESEncrypt.Encrypt("+downloadPath+")%>";--%>
        let html = "<a class='btn btn- icon btn-default hidden-print' href='javascript:void(0);' onclick=Export('" + TableId + "'); ><%=Lang.Get("DownloadTemplete") %></a >" + "<div  style='margin-left:10px;margin-top:5px;' id='" + TableId + "_UploadExcel' ></div> " + "   <div id='" + TableId + "_UploadetExcel' class='hidden' ></div>";
        $("#" + TableId).parent().parent().find(".btn-default").after("<br/>").after(html);
        ExcelImportData(TableId, IsReturnsMethod, IsInterceptVerif)
        $("#uploadifive-" + TableId + "_UploadExcel")[0].style.marginLeft = "5px";
    }

    var strExportString;
    function Export(tb) {
        var obj = GetDataTableReal(tb);
        strExportString = obj;
        var url = "/Solution/Ultimus.UWF.Form.ProcessControl.V3/GridExport.aspx";
        window.open(url);
    }

    function GetExportString() {
        return strExportString;
    }



    //明细行通过Excel导入数据到表单
    //IsReturnsMethod：是否有返回方法; true 表示有返回方法
    //IsInterceptVerif：是否需要做拦截验证
    function ExcelImportData(TableId, IsReturnsMethod, IsInterceptVerif) {

        var formid = '<%=Request.QueryString["formid"]%>';
        var processname = '<%=Request.QueryString["processname"]%>';
        var incident = '<%=Request.QueryString["incident"]%>';
        var url = '<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Ajax/HandlerExcelImport.ashx?Method=ExcelImport&ProcessName=' + processname + '&Incident=' + incident + '&StepName=&FORMID=' + formid;
        $("#" + TableId + "_UploadExcel").uploadifive({
            //开启调试  
            'debug': false,
            //是否自动上传  
            'auto': false,
            'buttonText': '<%=Ultimus.UWF.Common.Logic.Lang.Get("UploadDetail")%>',
            //文件选择后的容器ID
            'queueID': TableId + '_UploadetExcel',
            //按钮样式
            'buttonClass': 'btn btn-icon btn-default hidden-print',
            'uploadScript': url,
            'width': '100',
            'height': '34',
            'multi': true,
            //'fileType': ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"],
            'fileSizeLimit': '10MB',
            'removeTimeout': 1,
            'removeCompleted': true,
            onSelect: function (e, queueId, fileObj) {

                showDiv();
                id = $(this).attr("id");
                $(this).data('uploadifive').settings.formData = { 'TYPE': id };
                $(this).uploadifive('upload');
            },
            //返回一个错误，选择文件的时候触发  
            'onSelectError': function (file, errorCode, errorMsg) {
                closeDiv();
                alert("");
                switch (errorCode) {
                    case -100:
                        alert("File number limit" + $('#file_upload').uploadifive('settings', 'queueSizeLimit') + " files！");
                        break;
                    case -110:
                        alert("File [" + file.name + "] size limit" + $('#file_upload').uploadifive('settings', 'fileSizeLimit') + "！");
                        break;
                    case -120:
                        alert("File [" + file.name + "] size error！");
                        break;
                    case -130:
                        alert("File [" + file.name + "] type error！");
                        break;
                }
            },
            //上传到服务器，服务器返回相应信息到data里  
            'onUploadComplete': function (file, data, response) {

                closeDiv();
                //加载Excel 数据到表单
                LoadExcelData(TableId, data, IsReturnsMethod, IsInterceptVerif);
            },
            'onQueueComplete': function (file) {
                closeDiv();
            }
        });
    }

    function DownExcelTempFile(fileName, path) {
        var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Ajax/HandlerExcelImport.ashx?method=DownAttachment&fileName=" + fileName + "&path=" + path;
        window.open(url);
    }
    //加载Excel 数据到表单
    //TableID:table ID
    //data：数据源
    //IsReturnsMethod：是否有返回方法true 表示有返回方法,默认是false
    //IsInterceptVerif：是否需要做拦截验证
    function LoadExcelData(TableID, data, IsReturnsMethod, IsInterceptVerif) {
        var TheadTXT = [];
        var thead = $("#" + TableID + "").find("thead").find("tr");
        thead.find("td").each(function (i) {
            if (i == 0 || i == 1) {

            } else {
                TheadTXT.push($(this).text());
            }
        })
        //导入表单前多拦截验证
        if (IsInterceptVerif) {
            var msg = "Validate Failure!";
            msg = ExcelImportInterceptVerif(data);
            if (msg != "") {
                alert(msg);
                return false;
            }
        }
        if (IsReturnsMethod) {
            ExcelImportReturnsMethod(data, TheadTXT);
        } else {
            if (data) {
                $("#" + TableID + " tbody tr").not(":eq(0)").remove();
                //data 数据处理
                var objs = eval(data);
                var rows = objs.length;

                ////数据加载表单处理
                for (var i = 0; i < rows; i++) {
                    if (i > 0) {
                        addRow(TableID);
                    }
                    var tablerow = $("#" + TableID + " tbody tr").eq(i);
                    for (var key in objs[i]) {
                        if ($.inArray(key, TheadTXT) >= 0) {
                            var j = $.inArray(key, TheadTXT)
                            j += 2;
                            var tablecolums = $(tablerow).find("td").eq(j);
                            if ($(tablecolums).find("input").attr("id") != undefined) {
                                $(tablecolums).find("input").val(objs[i][key]);
                            } else if ($(tablecolums).find("select").attr("id") != undefined) {
                                $(tablecolums).find("select").find("option").filter(function () { return $(this).text() == "" + objs[i][key] + ""; }).attr("selected", true);
                            }
                        }
                    }
                }
                alert("Success");
                return true;
            }
            alert("Failure");
        }
        return false;
    }
</script>

<div class="hidden">
    <asp:TextBox ID="fld_Status" runat="server" Text="1"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSNAME" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_INCIDENT" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSVERSION" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtSetpType" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtStepName" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_FORMID" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtProcessPrefix" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtReadOnly" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableName" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableNameDetail" runat="server"></asp:TextBox>
    <asp:TextBox ID="var_ApplicantAccount" runat="server" Text=""></asp:TextBox><%--申请人账号--%>
    <asp:TextBox ID="fld_DEPARTMENTID" runat="server" Text=""></asp:TextBox>--%><%--本部门Id--%>

    <%--<asp:TextBox ID="var_AttachmentPath" runat="server" Text=""></asp:TextBox>--%>
    <%--<asp:TextBox ID="var_AttachmentName" runat="server" Text=""></asp:TextBox>--%>


    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTaskId" runat="server"></asp:TextBox>
    <%--    <asp:TextBox ID="fld_APPLICANTACCOUNT" runat="server"></asp:TextBox>--%>
    <asp:TextBox ID="txtApplicantAccount" runat="server"></asp:TextBox>
    <%-- <asp:TextBox ID="fld_PROCESSSUMMARY" runat="server" Text="" Width="87%"></asp:TextBox>--%>

    <asp:TextBox ID="txtIsVarSubmit" runat="server" Text="0"></asp:TextBox>
    <asp:TextBox ID="txtIsCreateForm" runat="server" Text="0"></asp:TextBox>
    <asp:Label ID="lblSummary" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="barcode" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="incident" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblCOMPANY" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblProcessName" runat="server" Visible="false"></asp:Label>
    <asp:TextBox ID="fld_CREATEBY" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_CREATEBYACCOUNT" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_CREATEBYCODE" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTACCOUNT" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTCODE" runat="server" Text=""></asp:TextBox>
        <asp:TextBox ID="fld_DEPARTMENT" runat="server" Text=""></asp:TextBox>
   <%-- <asp:TextBox ID="fld_COSTCENTER" runat="server" Text=""></asp:TextBox>--%>
    <asp:TextBox ID="fld_APPLICANT" class="form-control" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_JOBFUNCTION" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTTEL" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_EMAIL" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_GRADE" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_GRADECODE" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_JOBLEVEL" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_COMPANY" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_COMPANYID" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_DEPARTMENTLEVEL" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_JUDGELOGIC1" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_JUDGELOGIC2" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_JUDGELOGIC3" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="fld_COSTCENTERID" runat="server" Text=""></asp:TextBox>
</div>

<div id="attqueue" class="hidden"></div>

<%--<!-- Start Page Loading -->
    <div class="loading">
        <img src="<%=WebUtil.GetRootPath() %>/common/assets/img/loading.gif" alt="loading-img"></div>
    <!-- End Page Loading -->--%>

<!-- //////////////////////////////////////////////////////////////////////////// -->
<!-- START CONTENT -->
<div class="form-content">

    <!-- Start Page Header -->
    <div class="page-headersodexo " style="">
        <div class="left hidden-xs">
            <a href="../../../">
                <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/form_logo.png" alt="logo"  /></a>
            <%-- <img src="<%=WebUtil.IncludeAssets("form_logo")%>" alt="logo" style="width: 163;" /></a>--%>
        </div>
        <h1 class="title center"><strong><%=Lang.Get(Request.QueryString["ProcessName"]) %></strong></h1>
        <ol class="breadcrumb center">
            <%--<li class="active"><%=Request.QueryString["StepName"] %></li>--%>
        </ol>
        <div class="right">
            <div class="btn-group">
                <div id="barcode2" class="hidden-xs">
                </div>
                <%--<div id="qrcode">
                    <asp:Image ID="imgQRCode" runat="server"  />
                </div>--%>
                <div id="documentno" style="text-align: center" class="hidden-xs">
                    <asp:Label ID="lblDocumentNo" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="fld_DOCUMENTNO" runat="server"></asp:Label>

                </div>
            </div>
            <div class="btn-group hidden-print hidden" id="editBtn" runat="server" visible="false">
                <a class="btn btn-light" href="../../../Portal/Ultimus.UWF.Workflow/ProcessConfiguration.aspx?PROCESSNAME=<%=Request.QueryString["ProcessName"] %>" target="_blank">Edit Page</a>
                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <span class="caret"></span>
                    <span class="sr-only">Toggle Dropdown</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="../../../Portal/Ultimus.UWF.Form/DataSchemaFields.aspx?PROCESSNAME=<%=Request.QueryString["ProcessName"] %>" target="_blank">Edit DataSchema</a></li>
                    <%--<li class="divider"></li>
                    <li><a  href="../../../Portal/Ultimus.UWF.Workflow/ProcessStepList.aspx?PROCESSNAME=<%=Request.QueryString["ProcessName"] %>" target="_blank" >Edit Process Steps</a></li>--%>
                </ul>
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
                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>


                    <div class="panel-body form-table">
                        <%--申请人--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label input-prepend input-group">
                                <span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Applicant")%>:</span>
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_APPLICANT" runat="server" Text='' CssClass=""></asp:Label>                                   
                                    <script type="text/javascript">
                                        $(function () {
                                            if ((request("type").toLocaleLowerCase() == "mytask" && $("#UserInfo1_txtSetpType").val() != "2") || request("type").toLocaleLowerCase() == "addsign") {
                                                $("#UserInfo1_fld_PROCESSSUMMARY").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_PROCESSSUMMARY").css("width") + ";text-align:center;\"></span>");
                                                $("#UserInfo1_fld_PROCESSSUMMARY").css("display", "none");
                                                $("#UserInfo1_fld_PROCESSSUMMARY").next().html($("#UserInfo1_fld_PROCESSSUMMARY").val());
                                                $("#UserInfo1_fld_APPLICANT").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_APPLICANT").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_APPLICANT").val() + "</span>");
                                                $("#UserInfo1_fld_APPLICANT").css("display", "none");

                                                $("#UserInfo1_read_APPLICANT").text($("#UserInfo1_fld_APPLICANT").val());
                                                //$("#UserInfo1_fld_APPLICANT").next().html($("#UserInfo1_fld_APPLICANT").val());
                                            }
                                            if (request("type").toLocaleLowerCase() != "newrequest") {
                                                $("#UserInfo1_fld_PROCESSSUMMARY").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_PROCESSSUMMARY").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_PROCESSSUMMARY").val() + "</span>");
                                                $("#UserInfo1_fld_PROCESSSUMMARY").css("display", "none");
                                                $("#UserInfo1_read_APPLICANT").text($("#UserInfo1_fld_APPLICANT").val());
                                                $("#UserInfo1_read_APPLICANTCODE").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_APPLICANTCODE").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_APPLICANTCODE").val() + "</span>");
                                                $("#UserInfo1_read_APPLICANTCODE").css("display", "none");
                                                $("#UserInfo1_read_DEPARTMENT").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_DEPARTMENT").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_DEPARTMENT").val() + "</span>");
                                                $("#UserInfo1_read_DEPARTMENT").css("display", "none");
                                                $("#UserInfo1_read_JOBFUNCTION").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_JOBFUNCTION").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_JOBFUNCTION").val() + "</span>");
                                                $("#UserInfo1_read_JOBFUNCTION").css("display", "none");
                                                $("#UserInfo1_read_EMAIL").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_EMAIL").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_EMAIL").val() + "</span>");
                                                $("#UserInfo1_read_EMAIL").css("display", "none");
                                                $("#UserInfo1_read_COSTCENTER").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_COSTCENTER").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_COSTCENTER").val() + "</span>");
                                                $("#UserInfo1_read_COSTCENTER").css("display", "none");
                                                $("#UserInfo1_read_APPLICANTTEL").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_APPLICANTTEL").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_APPLICANTTEL").val() + "</span>");
                                                $("#UserInfo1_read_APPLICANTTEL").css("display", "none");
                                                $("#UserInfo1_read_JOBLEVEL").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_JOBLEVEL").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_JOBLEVEL").val() + "</span>");
                                                $("#UserInfo1_read_JOBLEVEL").css("display", "none");
                                                $("#UserInfo1_read_COMPANY").parent().append("<span id=span_COMPANY style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_COMPANY").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_COMPANY").val() + "</span>");
                                                $("#UserInfo1_read_COMPANY").css("display", "none");
                                                $("#UserInfo1_read_GRADE").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_GRADE").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_GRADE").val() + "</span>");
                                                $("#UserInfo1_read_GRADE").css("display", "none");
                                                $("#UserInfo1_read_ENNAME").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#UserInfo1_fld_JUDGELOGIC3").css("width") + ";text-align:center;\">" + $("#UserInfo1_fld_JUDGELOGIC3").val() + "</span>");
                                                $("#UserInfo1_read_ENNAME").css("display", "none");                                                
                                            }              
                                        })
                                    </script>
                                </div>
                            </div>
                        </div>
                        <%--岗位--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden">
                            <div class="form-label">
                                <%--<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_AccountNo")%>:--%>
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_JobFunction")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <%--岗位--%>
                                    <asp:Label ID="read_JOBFUNCTION" runat="server" Text="" CssClass=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <%--员工编号--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" hidden="hidden">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_AccountNo")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_APPLICANTCODE" runat="server" Text="" CssClass=""></asp:Label>
                                    <asp:Label ID="read_APPLICANTACCOUNT" runat="server" Text="" CssClass="hidden"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <%--申请部门--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Department")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_DEPARTMENT" Text="" runat="server" />                                   
                                </div>
                            </div>
                        </div>
                        <%--申请日期--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_RequestDate")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="fld_REQUESTDATE" CssClass="utcdatetime" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        

                        <%--职级--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " hidden="hidden">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_JobLevel")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_JOBLEVEL" runat="server" Text="" CssClass=""></asp:Label>

                                </div>
                            </div>
                        </div>
                        <%--职等--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" hidden="hidden">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Officialrank")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_GRADE" runat="server" Text="" CssClass=""></asp:Label>
                                    <asp:Label ID="read_GRADECODE" runat="server" Text="" CssClass="hidden"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <%--成本中心--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" hidden="hidden">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Costcenter")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_COSTCENTER" runat="server" Text="" CssClass=""></asp:Label>
                                    <%--<asp:Label ID="read_EXT08" runat="server" Text="" CssClass="hidden"></asp:Label>--%>
                                </div>
                            </div>
                        </div>


                       
                        <%--ERP--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" hidden="hidden">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_EMPNO")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_ENNAME" runat="server" Text="" CssClass=""></asp:Label>

                                </div>
                            </div>
                        </div>

                        <%--空格--%>
                        <%--<div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                            </div>
                        </div>--%>
                        <%--公司--%>
                        <div hidden class="col-lg-6 col-sm-6 col-xs-12 form-cell">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Corporation")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_COMPANY" runat="server" Text="" CssClass=""></asp:Label>                                   
                                </div>
                            </div>
                        </div>

                        <%--邮箱--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " style="display: none">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Email")%>:
                                <%--<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CostCenter")%>:--%>
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_EMAIL" runat="server" Text="" CssClass=""></asp:Label>
                                </div>
                            </div>
                        </div>

                        <%--申请人电话--%>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell  " style="display: none">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_ApplicantTel")%>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:Label ID="read_APPLICANTTEL" runat="server" Text="" CssClass=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-lg-12 col-sm-12 form-cell" ></div>
                        <%--摘要--%>
                        <div hidden class="col-lg-12 col-sm-12 col-xs-12 form-cell " id="div_PROCESSSUMMARY">
                            <div class="form-label">
                                <%--<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_ProcessTitle")%>:--%>
                                摘要：
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <asp:TextBox ID="fld_PROCESSSUMMARY" placeholder="请输入此次申请的目的和原因" runat="server" Text="" class="form-control border-left-color validate[required,maxSize[50]]" onkeydown="if(event.keyCode==13){return false;}"></asp:TextBox>
                                </div>
                                <script type="text/javascript">
                                    $(function () {

                                        if ('<%=Lang.GetLang()%>'.toUpperCase() == "EN-US") {
                                            $("#UserInfo1_fld_PROCESSSUMMARY").attr("placeholder", "Please enter the proposal and reason for this application");
                                        }
                                    })
                                </script>
                            </div>
                        </div>

                        <%--</div>
                </div>
            </div>

        </div>
        <!-- End Row -->--%>
