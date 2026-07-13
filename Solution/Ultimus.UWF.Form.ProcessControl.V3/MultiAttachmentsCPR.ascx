<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiAttachmentsCPR.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.MultiAttachmentsCPR" %>

<link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/uploadifive/uploadifive.css" rel="stylesheet" type="text/css" />
<script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/uploadifive/jquery.uploadifive.min.js" type="text/javascript" lang="javascript"></script>

<style>
    .uploadifive {
        margin-bottom: 0px;
    }
    /*e4e4e4*/
    .uploadifive-button {
        background-color: #e4e4e4;
        background-image: linear-gradient(bottom, #e4e4e4 0%, #e4e4e4 100%);
        background-image: -o-linear-gradient(bottom, #e4e4e4 0%, #e4e4e4 100%);
        background-image: -moz-linear-gradient(bottom, #e4e4e4 0%, #e4e4e4 100%);
        background-image: -webkit-linear-gradient(bottom, #e4e4e4 0%, #e4e4e4 100%);
        background-image: -ms-linear-gradient(bottom, #e4e4e4 0%, #e4e4e4 100%);
        background-image: -webkit-gradient( linear, left bottom, left top, color-stop(0, #e4e4e4), color-stop(1, #e4e4e4) );
        /*background-position: center top;*/
        background-repeat: no-repeat;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        /*border: 2px solid #e4e4e4;*/
        color: #333;
        font: 14px 微软雅黑,Arial, Helvetica, sans-serif;
        text-align: center;
        /*text-shadow: 0 0px 0 rgba(0,0,0,0);*/
        width: 100%;
        cursor: pointer !important;
    }

        .uploadifive-button:hover {
            background-color: #e4e4e4;
            background-image: linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
            background-image: -o-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
            background-image: -moz-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
            background-image: -webkit-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
            background-image: -ms-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
            background-image: -webkit-gradient( linear, left bottom, left top, color-stop(0, #e4e4e4), color-stop(1, #eeeeee) );
            background-position: center bottom;
            cursor: pointer !important;
        }

        .uploadifive-button input {
            cursor: pointer;
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
        formid = document.getElementById("Attachments1_TextBox1").value;
        username = document.getElementById("Attachments1_TextBox2").value;
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


        $("#file_upload_Supplier").uploadifive({
            //开启调试  
            'debug': false,
            //是否自动上传  
            'auto': false,
            'buttonText': '<%=Ultimus.UWF.Common.Logic.Lang.Get("Select")%>',
            //文件选择后的容器ID  
            'queueID': 'uploadfileQueue_Supplier',
            'uploadScript': '<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/UploadHandler.ashx?ProcessName=' + pname + '&Incident=' + incident + '&StepName=' + stepname + '&FORMID=' + formid + '&USERNAME=' + encodeURI(username) + '&TYPE=SUPPLIER',
            'width': '68',
            'height': '34',
            'multi': true,
            'fileTypeDesc': 'All Files ',
            'fileTypeExts': '*.*',
            'fileSizeLimit': '<%=MyLib.ConfigurationManager.AppSettings["AttachmentSizeLimit"]%>',
            'removeTimeout': 5,
            'removeCompleted': true,
            onSelect: function (e, queueId, fileObj) {
                $("#Attachments1_tdUpload_Supplier").show();
                doUpload_supplier();
            },
            //返回一个错误，选择文件的时候触发  
            'onSelectError': function (file, errorCode, errorMsg) {
                switch (errorCode) {
                    case -100:
                        alert("File number limit" + $('#file_upload_Supplier').uploadifive('settings', 'queueSizeLimit') + " files！");
                        break;
                    case -110:
                        alert("File [" + file.name + "] size limit" + $('#file_upload_Supplier').uploadifive('settings', 'fileSizeLimit') + "！");
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
                $("#Attachments1_uploadrow_Supplier").hide();
            },
            //上传到服务器，服务器返回相应信息到data里  
            'onUploadSuccess': function (file, data, response) {
                if (response) {
                }
            },
            'onQueueComplete': function (file) {
                //$("#Attachments1_btn_fresh").click();
                //alert(1);
                debugger
                //alert($("#Attachments1_txtTypeSupplier").val());
                $("#fileinfo_Supplier").empty();
                $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx?t=" + (new Date()).getTime(),
                    { method: "getattachment", formid: formid, type: $("#Attachments1_txtTypeSupplier").val() }, function (data) {
                        debugger
                        var objs = eval(data);
                        var rows = "";
                        for (var i = 0; i < objs.length; i++) {
                            var obj = objs[i];
                            rows += '<tr>' +
                             '        <td class="hidden-xs attno">' +
                             '       ' + parseInt(i + 1) + '' +
                              '      </td>' +
                              '      <td>' +
                              '      <a href="' + obj.URL + '" target="_blank">' + obj.FILENAME + '</a>' +

                              '      </td>' +
                              '      <td class="hidden-xs comments " style="display:none">' +

                               '     </td>' +
                               '     <td>' +
                               '     ' + obj.STEPNAME + '' +
                               '     </td>' +

                               '     <td class="hidden-xs">' +
                            '' + obj.CREATEBY + '</td>' +

                             '       <td id="Attachments1_Repeater_Supplier_ctl' + parseInt(i) + '_Td_Supplier">' +
                              ' <a onclick="if(confirm(\'<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>\')){deleteAtt_supplier(\'' + obj.NEWNAME + '\',this)}" class="btn btn-icon btn-sm" href="javascript:void(0)" ><i class="fa fa-trash"></i></a>         ' +
                              '      </td>' +

                              '  </tr>';
                        }

                        $("#fileinfo_Supplier").append(rows);
                    });
            }
        });

        $("#file_upload_Approver").uploadifive({
            //开启调试  
            'debug': false,
            //是否自动上传  
            'auto': false,
            'buttonText': '<%=Ultimus.UWF.Common.Logic.Lang.Get("Select")%>',
            //文件选择后的容器ID  
            'queueID': 'uploadfileQueue_Approver',
            'uploadScript': '<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/UploadHandler.ashx?ProcessName=' + pname + '&Incident=' + incident + '&StepName=' + stepname + '&FORMID=' + formid + '&USERNAME=' + encodeURI(username) + '&TYPE=APPROVER',
            'width': '68',
            'height': '34',
            'multi': true,
            'fileTypeDesc': 'All Files ',
            'fileTypeExts': '*.*',
            'fileSizeLimit': '<%=MyLib.ConfigurationManager.AppSettings["AttachmentSizeLimit"]%>',
            'removeTimeout': 5,
            'removeCompleted': true,
            onSelect: function (e, queueId, fileObj) {
                $("#Attachments1_tdUpload_Approver").show();
                doUpload_Approver();
            },
            //返回一个错误，选择文件的时候触发  
            'onSelectError': function (file, errorCode, errorMsg) {
                switch (errorCode) {
                    case -100:
                        alert("File number limit" + $('#file_upload_Approver').uploadifive('settings', 'queueSizeLimit') + " files！");
                        break;
                    case -110:
                        alert("File [" + file.name + "] size limit" + $('#file_upload_Approver').uploadifive('settings', 'fileSizeLimit') + "！");
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
                $("#Attachments1_uploadrow_Approver").hide();
            },
            //上传到服务器，服务器返回相应信息到data里  
            'onUploadSuccess': function (file, data, response) {
                if (response) {
                }
            },
            'onQueueComplete': function (file) {
                //$("#Attachments1_btn_fresh").click();
                //alert(1);
                $("#fileinfo_Approver").empty();
                $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx?t=" + (new Date()).getTime(),
                    { method: "getattachment", formid: formid, type: $("#Attachments1_txtTypeApprover").val() }, function (data) {
                        var objs = eval(data);
                        var rows = "";
                        for (var i = 0; i < objs.length; i++) {
                            var obj = objs[i];
                            rows += '<tr>' +
                             '        <td class="hidden-xs attno">' +
                             '       ' + parseInt(i + 1) + '' +
                              '      </td>' +
                              '      <td>' +
                              '      <a href="' + obj.URL + '" target="_blank">' + obj.FILENAME + '</a>' +

                              '      </td>' +
                              '      <td class="hidden-xs comments " style="display:none">' +

                               '     </td>' +
                               '     <td>' +
                               '     ' + obj.STEPNAME + '' +
                               '     </td>' +

                               '     <td class="hidden-xs">' +
                            '' + obj.CREATEBY + '</td>' +

                             '       <td id="Attachments1_Repeater_Approver_ctl' + parseInt(i) + '_Td_Approver">' +
                              ' <a onclick="if(confirm(\'<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>\')){deleteAtt_approver(\'' + obj.NEWNAME + '\',this)}" class="btn btn-icon btn-sm" href="javascript:void(0)" ><i class="fa fa-trash"></i></a>         ' +
                              '      </td>' +

                              '  </tr>';
                        }

                        $("#fileinfo_Approver").append(rows);
                    });
            }
        });

    });

        function doUpload_supplier() {
            $('#file_upload_Supplier').uploadifive('upload');

        }

        function closeLoad_supplier() {
            $('#file_upload_Supplier').uploadifive('cancel');
        }

        function deleteAtt_supplier(newname, ele) {
            $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx",
                    { method: "delete", newname: newname }, function (data) {
                        $(ele).parent().parent().remove();

                        var tabRows = $(".attno");
                        for (var i = 0; i < tabRows.length; i++) {
                            $(tabRows[i]).html(i + 1);

                        }

                    });
        }

        function doUpload_Approver() {
            $('#file_upload_Approver').uploadifive('upload');

        }

        function closeLoad_Approver() {
            $('#file_upload_Approver').uploadifive('cancel');
        }

        function deleteAtt_approver(newname, ele) {
            $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx",
                { method: "delete", newname: newname }, function (data) {
                    $(ele).parent().parent().remove();

                    var tabRows = $(".attno");
                    for (var i = 0; i < tabRows.length; i++) {
                        $(tabRows[i]).html(i + 1);

                    }

                });
        }

</script>
<script type="text/javascript" lang="javascript">
    $().ready(function () {
        $("#fileinfo_Supplier td").each(function () {
            $(this).css("text-align", "center");
        });
        $("#fileinfo_Approver td").each(function () {
            $(this).css("text-align", "center");
        });
    })
</script>

<div class="row" id="rowAtt_Supplier" runat="server">
    <div class="col-md-12">
        <div class="panel panel-default" id="filelist_Supplier">
            <div class="panel-title">
                <div class="fa-title"><i class="fa fa-paperclip"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Expense_Attachment")%>（供应商 Suppliers）</div>

                <ul class="panel-tools">
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>
            <div class="panel-body">

                <!--Start detail table-->
                <table class="table table-bordered table-condensed form-detail-table">
                    <thead>
                        <tr>
                            <td class="headerTD hidden-xs">
                                <asp:Label ID="Label2" runat="server" Text="No."></asp:Label>
                            </td>
                            <td class="headerTD">
                                <asp:Label ID="Label3" runat="server" Text="文件名称"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_FileName")%></asp:Label>
                            </td>

                            <td class="headerTD hidden-xs  comments" style="display: none">
                                <asp:Label ID="Label4" runat="server" Text="描述"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Description")%></asp:Label>
                            </td>
                            <td class="headerTD">
                                <asp:Label ID="Label5" runat="server" Text="步骤名"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%></asp:Label>
                            </td>
                            <td class="headerTD hidden-xs">
                                <asp:Label ID="Label6" runat="server" Text="创建人"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy")%></asp:Label>
                            </td>
                            <%--<th>
                        <asp:Label ID="Label6" runat="server" Text="创建时间"></asp:Label>
                    </th>--%>
                            <td class="headerTD" id="actionRow_Supplier" runat="server">
                                <asp:Label ID="Label7" runat="server" Text="操作"><%=Ultimus.UWF.Common.Logic.Lang.Get("DraftList_Operate")%></asp:Label>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="fileinfo_Supplier">
                        <asp:Repeater ID="Repeater_Supplier" runat="server" OnItemCommand="Repeater_Supplier_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td class="hidden-xs attno">
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <td>
                                        <a href="<%# GetUrl(Eval("ProcessName"),Eval("NEWNAME"),Eval("FileType"),Eval("CreateDate")) %>" target="_blank"><%# Eval("FileName")%></a>
                                        <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("NEWNAME") %>'
                                            CommandName="Download"><%# Eval("FileName")%></asp:LinkButton>--%>
                                    </td>
                                    <td class="hidden-xs comments " style="display: none">
                                        <%# Eval("Comments")%>
                                    </td>
                                    <td>
                                        <%# Eval("STEPNAME")%>
                                    </td>

                                    <td class="hidden-xs">
                                        <%# Eval("CreateBy")%></td>
                                    <%--<td>
                                    <%# Eval("CreateDate")%>
                                </td>--%>
                                    <td id="Td_Supplier" runat="server" visible='<%# ReadOnly?false:true %>'>
                                        <asp:LinkButton ID="LinkButton_Supplier" runat="server" class="hide" Visible='<%# ReadOnly?false:false %>' CssClass="btn btn-icon btn-sm" OnClientClick="return confirm('确定要删除吗?');"
                                            CommandArgument='<%# Eval("NEWNAME") %>' CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>

                                        <a onclick="if(confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>')){deleteAtt_supplier('<%# Eval("NEWNAME") %>',this)}"
                                            class="btn btn-icon btn-sm" href="javascript:void(0)"><i class="fa fa-trash"></i></a>

                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div id="uploadrow_Supplier" runat="server">
                    <div id="uploadfileQueue_Supplier" style="padding: 3px;">
                    </div>

                    <table>
                        <tr>
                            <td>
                                <div id="file_upload_Supplier">
                                </div>
                            </td>
                            <td class="padding-l-5 hidden" id="tdUpload_Supplier">
                                <span class="btn " onclick="doUpload_supplier();"><i class="fa fa-upload"></i></span>
                                <span class="btn " onclick="closeLoad_supplier();"><i class="fa fa-close"></i></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row" id="rowAtt_Approver" runat="server">
    <div class="col-md-12">
        <div class="panel panel-default" id="filelist_Approver">
            <div class="panel-title">
                <div class="fa-title"><i class="fa fa-paperclip"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Expense_Attachment")%>（审批人 Approvers）</div>

                <ul class="panel-tools">
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>
            <div class="panel-body">

                <!--Start detail table-->
                <table class="table table-bordered table-condensed form-detail-table">
                    <thead>
                        <tr>
                            <td class="headerTD hidden-xs">
                                <asp:Label ID="Label8" runat="server" Text="No."></asp:Label>
                            </td>
                            <td class="headerTD">
                                <asp:Label ID="Label9" runat="server" Text="文件名称"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_FileName")%></asp:Label>
                            </td>

                            <td class="headerTD hidden-xs  comments" style="display: none">
                                <asp:Label ID="Label10" runat="server" Text="描述"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Description")%></asp:Label>
                            </td>
                            <td class="headerTD">
                                <asp:Label ID="Label11" runat="server" Text="步骤名"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%></asp:Label>
                            </td>
                            <td class="headerTD hidden-xs">
                                <asp:Label ID="Label12" runat="server" Text="创建人"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy")%></asp:Label>
                            </td>
                            <%--<th>
                        <asp:Label ID="Label6" runat="server" Text="创建时间"></asp:Label>
                    </th>--%>
                            <td class="headerTD" id="actionRow_Approver" runat="server">
                                <asp:Label ID="Label13" runat="server" Text="操作"><%=Ultimus.UWF.Common.Logic.Lang.Get("DraftList_Operate")%></asp:Label>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="fileinfo_Approver">
                        <asp:Repeater ID="Repeater_Approver" runat="server" OnItemCommand="Repeater_Approver_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td class="hidden-xs attno">
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <td>
                                        <a href="<%# GetUrl(Eval("ProcessName"),Eval("NEWNAME"),Eval("FileType"),Eval("CreateDate")) %>" target="_blank"><%# Eval("FileName")%></a>
                                        <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("NEWNAME") %>'
                                            CommandName="Download"><%# Eval("FileName")%></asp:LinkButton>--%>
                                    </td>
                                    <td class="hidden-xs comments " style="display: none">
                                        <%# Eval("Comments")%>
                                    </td>
                                    <td>
                                        <%# Eval("STEPNAME")%>
                                    </td>

                                    <td class="hidden-xs">
                                        <%# Eval("CreateBy")%></td>
                                    <%--<td>
                                    <%# Eval("CreateDate")%>
                                </td>--%>
                                    <td id="Td_Approver" runat="server" visible='<%# ReadOnly?false:true %>'>
                                        <asp:LinkButton ID="LinkButton_Approver" runat="server" class="hide" Visible='<%# ReadOnly?false:false %>' CssClass="btn btn-icon btn-sm" OnClientClick="return confirm('确定要删除吗?');"
                                            CommandArgument='<%# Eval("NEWNAME") %>' CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>

                                        <a onclick="if(confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>')){deleteAtt('<%# Eval("NEWNAME") %>',this)}"
                                            class="btn btn-icon btn-sm" href="javascript:void(0)"><i class="fa fa-trash"></i></a>

                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div id="uploadrow_Approver" runat="server">
                    <div id="uploadfileQueue_Approver" style="padding: 3px;">
                    </div>

                    <table>
                        <tr>
                            <td>
                                <div id="file_upload_Approver">
                                </div>
                            </td>
                            <td class="padding-l-5 hidden" id="tdUpload_Approver">
                                <span class="btn " onclick="doUpload_Approver();"><i class="fa fa-upload"></i></span>
                                <span class="btn " onclick="closeLoad_Approver();"><i class="fa fa-close"></i></span>
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
    <asp:TextBox ID="txtTypeSupplier" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTypeApprover" runat="server"></asp:TextBox>
</div>
<div class="hidden">
    <!--<asp:Label ID="Label1" runat="server" Text="描述：" CssClass="strong" ></asp:Label> -->

</div>


<script type="text/javascript">
    function freshatt() {

        document.getElementById("Attachments1_btn_fresh").click();
        document.getElementById("ButtonList1_btnSubmit").onfocus();

    }


    $().ready(function () {
        if ($("#Attachments1_txtReadonly").val() == "1") {
            $("#Attachments1_actionRow_Supplier").hide();
            $("#Attachments1_actionRow_Approver").hide();
        }
    });
</script>
