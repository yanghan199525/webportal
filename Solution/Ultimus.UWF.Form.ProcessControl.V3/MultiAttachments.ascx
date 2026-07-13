<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiAttachments.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.MultiAttachments" %>

<link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/uploadifive/uploadifive.css" rel="stylesheet" type="text/css" />
<script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/uploadifive/jquery.uploadifive.min.js?t=<%=DateTime.Now.Ticks %>" type="text/javascript" lang="javascript"></script>

<style>
    /*.uploadifive {
        margin-bottom: 0px;
    }*/
    /*e4e4e4*/
    .uploadifive-button {
        height: auto !important;
        line-height: normal !important;
        width: auto !important;
    }

    #fileinfo tr td {
        text-align: center;
    }

    #FontStyle {
        color: red;
    }
</style>

<script type="text/javascript">
    $().ready(function () {

        var name, value;
        var str = location.href; //取得整个地址栏
        var pname;
        var stepname;
        var incident;
        var formid;
        var username;
        var applicantaccount;
        formid = document.getElementById("Attachments1_TextBox1").value;
        username = document.getElementById("Attachments1_TextBox2").value;
        applicantaccount = document.getElementById("UserInfo1_txtApplicantAccount").value;


        var num = str.indexOf("?")
        str = str.substr(num + 1); //取得所有参数   stringvar.substr(start [, length ]

        var arr = str.split("&"); //各个参数放到数组里
        for (var i = 0; i < arr.length; i++) {
            num = arr[i].indexOf("=");
            if (num > 0) {
                name = arr[i].substring(0, num);
                value = arr[i].substr(num + 1);
                this[name] = value;

                if (i == 0) {
                    pname = value;
                    // alert(value);
                }
                else if (i == 1) {
                    stepname = value;
                    //alert(value);
                }
                else if (i == 2) {
                    incident = value;
                    // alert(value);
                }

            }
        }

        $("#file_upload").uploadifive({
            //开启调试  
            'debug': false,
            //是否自动上传  
            'auto': false,
            'buttonText': '<%=Ultimus.UWF.Common.Logic.Lang.Get("Select")%>',
            //文件选择后的容器ID  
            'queueID': 'uploadfileQueue',
            //按钮样式
            'buttonClass': 'btn btn-icon btn-default hidden-print',
            'uploadScript': '<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/UploadHandler.ashx?ProcessName=' + pname + '&Incident=' + incident + '&StepName=' + stepname + '&FORMID=' + formid + '&USERNAME=' + encodeURI(username) + '&APPLICANTACCOUNT=' + encodeURI(applicantaccount),
            'width': '68',
            'height': '34',
            'multi': true,
            'fileType': [<%=MyLib.ConfigurationManager.AppSettings["FileType"]%>],
            'fileSizeLimit': '<%=MyLib.ConfigurationManager.AppSettings["AttachmentSizeLimit"]%>',
            'removeTimeout': 5,
            'removeCompleted': true,
            onSelect: function (e, queueId, fileObj) {
                $("#Attachments1_tdUpload").show();
                doUpload();
            },
            //返回一个错误，选择文件的时候触发  
            'onSelectError': function (file, errorCode, errorMsg) {
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
            //检测FLASH失败调用  
            'onFallback': function () {
                //alert("You have not install FLASH, can not upload！");
                $(".comments").show();
                $("#Attachments1_uploadrow").hide();
            },
            //上传到服务器，服务器返回相应信息到data里  
            'onUploadSuccess': function (file, data, response) {
                if (response) {
                }
            },
            'onQueueComplete': function (file) {
                //$("#Attachments1_btn_fresh").click();
                //alert(1);
                $("#fileinfo").empty();
                $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx?t=" + (new Date()).getTime(),
                    { method: "getattachment", formid: formid, type: '' }, function (data) {
                        var objs = eval(data);
                        var rows = "";
                        for (var i = 0; i < objs.length; i++) {
                            var obj = objs[i];
                            var trDelete = "";
                            if ($.trim(obj.STEPNAME) == $.trim($("#UserInfo1_txtStepName").val())) {
                                trDelete = '<a onclick="if(confirm(\'<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>\')){deleteAtt(\'' + encodeURI(obj.NEWNAME) + '\',this,\''
                                    + obj.URL + '\')}" class="btn btn-icon btn-sm" href="javascript:void(0)" ><i class="fa fa-trash"></i></a>';
                            }
                            rows += '<tr>' +
                             '        <td class="hidden-xs attno">' +
                             '       ' + parseInt(i + 1) + '' +
                              '      </td>' +
                              '      <td>' +

                             //'      <a href="' + obj.URL + '" target="_blank">' + obj.FILENAME + '</a>' +
                                '      <a href="javascript:void(0)" onclick="downTempFile(\'' + obj.FILE_NAME + '\',\'' + obj.URL + '\')">' + obj.FILENAME + '</a>' +

                              '      </td>' +
                              '      <td class="hidden-xs comments " style="display:none">' +

                               '     </td>' +
                               '     <td>' +
                               '     ' + obj.STEPNAME + '' +
                               '        <asp:Label ID="lbStepName" runat="server" Text="' + obj.STEPNAME + '" Style="display: none;"></asp:Label>' +
                               '        <asp:Label ID="lbApplicantaccount" runat="server" Text="' + obj.EXT02 + '" Style="display: none;"></asp:Label>' +
                               '     </td>' +
                               '     <td class="hidden-xs">' +
                            '' + obj.CREATEBY + '</td>' +

                               '     <td class="hidden-xs">' +
                            '' + obj.CREATEDATE.replaceAll('T', ' ') + '</td> <td id="Attachments1_Repeater1_ctl' + parseInt(i) + '_Td1">' + trDelete + '  </td> </tr>';
                        }

                        $("#fileinfo").append(rows);
                        //判断是否显示删除按钮
                        controlAttachmentList();
                        if ($("#Attachments1_txt_attCallBack").text() == "true") {
                            ReturnAttachment();
                        }
                    });
                //设计回调方法
                debugger;

            }
        });

    });

        function doUpload() {
            $('#file_upload').uploadifive('upload');

        }

        function closeLoad() {
            $('#file_upload').uploadifive('cancel');
        }

        function deleteAtt(newname, ele, ftpPath) {
            $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx",
                    { method: "delete", newname: newname, path: ftpPath }, function (data) {
                        $(ele).parent().parent().remove();

                        var tabRows = $(".attno");
                        for (var i = 0; i < tabRows.length; i++) {
                            $(tabRows[i]).html(i + 1);

                        }
                    });
        }
        function downTempFile(fileName, path) {
            var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx?method=downAttachment&fileName=" + fileName + "&path=" + path;
            window.open(url);
        }
</script>

<div class="row" id="rowAtt" runat="server">
    <div class="col-md-12">
        <div class="panel panel-default" id="filelist">
            <div class="panel-title">
                <div class="fa-title">
                    <i class="fa fa-paperclip"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Expense_Attachment")%>
                    <span class="paddind_l-5" id="FontStyle">(上传附件单个最大支持为：<%= MyLib.ConfigurationManager.AppSettings["AttachmentSizeLimit"]%>)</span>


                </div>
                <ul class="panel-tools">
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>
            <div class="panel-body">

                <!--Start detail table-->
                <table class="table table-bordered table-condensed form-detail-table form-resp-table">
                    <thead>
                        <tr>
                            <td class="" style="width: 50px">
                                <asp:Label ID="Label2" runat="server" Text="No."><%=Ultimus.UWF.Common.Logic.Lang.Get("No")%></asp:Label>
                            </td>
                            <td class="">
                                <asp:Label ID="Label3" runat="server" Text="文件名称"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_FileName")%></asp:Label>
                            </td>

                            <td class="  comments" style="display: none">
                                <asp:Label ID="Label4" runat="server" Text="描述"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Description")%></asp:Label>
                            </td>
                            <td class="">
                                <asp:Label ID="Label8" runat="server" Text="步骤名"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%></asp:Label>
                            </td>
                            <td class="">
                                <asp:Label ID="Label5" runat="server" Text="创建人"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy")%></asp:Label>
                            </td>
                            <td class="headerTD" style="width: 150px">
                                <asp:Label ID="Label6" runat="server" Text="上传时间"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_UploadDate")%></asp:Label>
                            </td>
                            <td class="hidden-xs" id="actionRow" runat="server" style="width: 50px">
                                <asp:Label ID="Label7" runat="server" Text="操作"><%=Ultimus.UWF.Common.Logic.Lang.Get("DraftList_Operate")%></asp:Label>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="fileinfo">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand" OnItemDataBound="Repeater1_ItemDataCommand">
                            <ItemTemplate>
                                <tr>
                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("No")%>'>
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_FileName")%>'>
                                        <%--   <a href="<%# GetUrl(Eval("ProcessName"),Eval("NEWNAME"),Eval("FileType"),Eval("CreateDate")) %>" target="_blank"><%# Eval("FileName")%></a>--%>
                                        <%--   <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("ProcessName").ToString() +"&"+ Eval("NEWNAME")+"&"+Eval("FileType")+"&"+Eval("CreateDate") %>'
                                            CommandName="Download"><%# Eval("FileName")%></asp:LinkButton>--%>
                                        <a href="javascript:void(0)" onclick="downTempFile('<%# GetFileName(Eval("FileName"))%>','<%# GetUrl(Eval("ProcessName"),Eval("NEWNAME"),Eval("FileType"),Eval("CreateDate")) %>')">
                                            <%# Eval("FileName")%></a>
                                    </td>
                                    <td class="hidden-xs comments " style="display: none" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Description")%>'>
                                        <%# Eval("Comments")%>
                                    </td>
                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%>'>
                                        <%# Eval("STEPNAME")%>
                                        <asp:Label ID="lbStepName" runat="server" Text='<%# Eval("STEPNAME")%>' Style="display: none;"></asp:Label>
                                        <asp:Label ID="lbApplicantaccount" runat="server" Text='<%# Eval("EXT02")%>' Style="display: none;"></asp:Label>
                                    </td>

                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy")%>'>
                                        <%# Eval("CreateBy")%></td>
                                    <asp:Label ID="lbCreateByAccount" runat="server" Text='<%# Eval("CreateBy")%>' Style="display: none;"></asp:Label>
                                    <td class="utcdatetime" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_UploadDate")%>'>
                                        <%# MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).ToString("yyyy/MM/dd HH:mm:ss")%>
                                    </td>
                                    <td id="Td1">
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="hide" Visible='<%# ReadOnly?false:false %>' CssClass="btn btn-icon btn-sm" OnClientClick="return confirm('确定要删除吗?');"
                                            CommandArgument='<%# Eval("NEWNAME") %>' CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>

                                        <a onclick="if(confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>')){deleteAtt('<%# Eval("NEWNAME") %>',this,'<%# GetUrl(Eval("ProcessName"),Eval("NEWNAME"),Eval("FileType"),Eval("CreateDate")) %>')}"
                                            class="btn btn-icon btn-sm" href="javascript:void(0)"><i class="fa fa-trash"></i></a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div id="uploadrow" runat="server">
                    <div id="uploadfileQueue" style="padding: 3px;">
                    </div>

                    <table>
                        <tr>
                            <td>
                                <div id="file_upload">
                                </div>
                            </td>
                            <td class="padding-l-5 hidden" id="tdUpload">
                                <span class="btn " onclick="doUpload();"><i class="fa fa-upload"></i></span>
                                <span class="btn " onclick="closeLoad();"><i class="fa fa-close"></i></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<div style="display: none">
    <asp:TextBox ID="txtMust" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtReadonly" runat="server"></asp:TextBox>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <asp:Button ID="btn_fresh" runat="server" Text="Button" OnClick="btn_fresh_Click" />
    <asp:TextBox ID="txtSingle" runat="server"></asp:TextBox>
    <asp:TextBox ID="txt_attCallBack" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
</div>
<div class="hidden">
    <!--<asp:Label ID="Label1" runat="server" Text="描述：" CssClass="strong" ></asp:Label> -->

</div>


<script type="text/javascript">
    $().ready(function () {
        controlAttachmentList();
    });

    function freshatt() {
        document.getElementById("Attachments1_btn_fresh").click();
        document.getElementById("ButtonList1_btnSubmit").onfocus();
    }

    function controlAttachmentList() {
        var type = request("Type").toUpperCase();
        if ($("#Attachments1_txtReadonly").val() == "1" || type == "MYAPPROVAL") {
            $("#Attachments1_actionRow").hide();
        }

        var stepName = $("#UserInfo1_txtStepName").val();
        var fld_Applicantaccount = $("#UserInfo1_txtApplicantAccount").val();
        $("#fileinfo tr").each(function () {
            var rowStepName = $(this).find("span[id$=lbStepName]").text();
            var applicantaccount = $(this).find("span[id$=lbApplicantaccount]").text();
            if (stepName && rowStepName && applicantaccount) {
                //只有当前步骤可以进行删除
                if (stepName != rowStepName || applicantaccount != fld_Applicantaccount || type == "MYAPPROVAL") {
                    $(this).find("td[id$=Td1]").html("");
                }
            }
            if ($("#Attachments1_txtReadonly").val() == "1" || type == "MYAPPROVAL") {
                $(this).find("td[id$=Td1]").remove();
            }
        });
    }
</script>
