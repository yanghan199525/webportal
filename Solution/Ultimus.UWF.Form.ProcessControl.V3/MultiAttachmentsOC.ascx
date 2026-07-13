<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiAttachmentsOC.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.MultiAttachmentsOC" %>

<link href="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/uploadifive/uploadifive.css" rel="stylesheet" type="text/css" />
<script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/uploadifive/jquery.uploadifive.min.js" type="text/javascript" lang="javascript"></script>


<style>
.uploadifive
{
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
    background-image: -webkit-gradient(
        linear,
        left bottom,
        left top,
        color-stop(0, #e4e4e4),
        color-stop(1, #e4e4e4)
    );
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
    cursor:pointer !important;
}

.uploadifive-button:hover {
	background-color: #e4e4e4;
	background-image: linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
	background-image: -o-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
	background-image: -moz-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
	background-image: -webkit-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
	background-image: -ms-linear-gradient(top, #e4e4e4 0%, #eeeeee 100%);
	background-image: -webkit-gradient(
		linear,
		left bottom,
		left top,
		color-stop(0, #e4e4e4),
		color-stop(1, #eeeeee)
	);
	background-position: center bottom;
    cursor:pointer !important;
}
 .uploadifive-button input{
        cursor:pointer;
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


        $("#Supperfile_upload").uploadifive({
            //开启调试  
            'debug': false,
            //是否自动上传  
            'auto': false,
            'buttonText': '<%=Ultimus.UWF.Common.Logic.Lang.Get("Select")%>',
            //文件选择后的容器ID  
            'queueID': 'uploadfileQueue',
            'uploadScript': '<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/UploadHandler.ashx?ProcessName=' + pname + '&Incident=' + incident + '&StepName=' + stepname + '&FORMID=' + formid + '&USERNAME=' + encodeURI(username)+ '&TYPE=supper',
            'width': '68',
            'height': '34',
            'multi': true,
            'fileTypeDesc': 'All Files ',
            'fileTypeExts': '*.*',
            'fileSizeLimit': '<%=MyLib.ConfigurationManager.AppSettings["AttachmentSizeLimit"]%>',
            'removeTimeout': 5,
            'removeCompleted': true,
            onSelect: function (e, queueId, fileObj) {
                $("#Attachments1_tdUpload").show();
                SupperdoUpload();
            },
            //返回一个错误，选择文件的时候触发  
            'onSelectError': function (file, errorCode, errorMsg) {
                switch (errorCode) {
                    case -100:
                        alert("File number limit" + $('#Supperfile_upload').uploadifive('settings', 'queueSizeLimit') + " files！");
                        break;
                    case -110:
                        alert("File [" + file.name + "] size limit" + $('#Supperfile_upload').uploadifive('settings', 'fileSizeLimit') + "！");
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
                $("#Supperfileinfo").empty();
                $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx?t=" + (new Date()).getTime(),
                    { method: "getattachment", formid: formid, type: 'supper' }, function (data) {
                        var objs = eval(data);
                        var rowsSupper = "";
                        for (var i = 0; i < objs.length; i++) {
                            var obj = objs[i];
                            rowsSupper += '<tr>'+
                             '        <td class="hidden-xs attno">'+
                             '       '+parseInt(i+1)+''+
                              '      </td>'+
                              '      <td>'+
                              '      <a href="'+obj.URL+'" target="_blank">'+obj.FILENAME+'</a>' +
                                        
                              '      </td>'+
                              '      <td class="hidden-xs comments " style="display:none">'+
                                        
                               '     </td>'+
                               '     <td>'+
                               '     '+obj.STEPNAME+''+
                               '     </td>'+
                                    
                               '     <td class="hidden-xs">'+
                            ''+obj.CREATEBY+'</td>'+
                                    
                             '       <td id="Attachments1_Repeater1_supper_ctl' + parseInt(i) + '_Td1">' +
                              ' <a onclick="if(confirm(\'<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>\')){deleteAtt_supper(\'' + obj.NEWNAME + '\',this)}" class="btn btn-icon btn-sm" href="javascript:void(0)" ><i class="fa fa-trash"></i></a>         ' +
                              '      </td>'+

                              '  </tr>';
                        }

                        $("#Supperfileinfo").append(rowsSupper);
                });
            }
        });


    });

    function SupperdoUpload() {
        $('#Supperfile_upload').uploadifive('upload');

    }

    function SuppercloseLoad() {
        $('#Supperfile_upload').uploadifive('cancel');
    }

    function deleteAtt_supper(newname, ele) {
        $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandlerSupper.ashx",
                    { method: "delete", newname: newname }, function (data) {
                        $(ele).parent().parent().remove();

                        var tabRows = $(".attno");
                        for (var i = 0; i < tabRows.length; i++) {
                            $(tabRows[i]).html(i+1);

                        }

                    });
    }

</script>
<script type="text/javascript" lang="javascript">
    $().ready(function () {
        $("#Supperfileinfo td").each(function () {
            $(this).css("text-align", "center");
        });
    })
</script>

<div class="row" id="rowAtt" runat="server">
    <div class="col-md-12">
        <div class="panel panel-default" id="filelist">
            <div class="panel-title">
                <div class="fa-title"><i class="fa fa-paperclip"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Expense_Attachment")%>(供应商用 For Supplier)</div>

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
                            
                            <td class="headerTD hidden-xs  comments" style="display:none" >
                                <asp:Label ID="Label4" runat="server" Text="描述"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Description")%></asp:Label>
                            </td>
                            <td class="headerTD">
                                <asp:Label ID="Label8" runat="server" Text="步骤名"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%></asp:Label>
                            </td>
                            <td class="headerTD hidden-xs">
                                <asp:Label ID="Label5" runat="server" Text="创建人"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy")%></asp:Label>
                            </td>
                            <%--<th>
                        <asp:Label ID="Label6" runat="server" Text="创建时间"></asp:Label>
                    </th>--%>
                            <td class="headerTD" id="actionRow" runat="server" >
                                <asp:Label ID="Label7" runat="server" Text="操作"><%=Ultimus.UWF.Common.Logic.Lang.Get("DraftList_Operate")%></asp:Label>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="Supperfileinfo">
                        <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater2_ItemCommand">
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
                                    <td class="hidden-xs comments " style="display:none">
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
                                    <td id="Td1" runat="server" visible='<%# ReadOnly?false:true %>'>
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="hide" Visible='<%# ReadOnly?false:false %>' CssClass="btn btn-icon btn-sm" OnClientClick="return confirm('确定要删除吗?');"
                                            CommandArgument='<%# Eval("NEWNAME") %>' CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>

                                        <a onclick="if(confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>')){deleteAtt_supper('<%# Eval("NEWNAME") %>',this)}" 
                                            class="btn btn-icon btn-sm"  href="javascript:void(0)" ><i class="fa fa-trash"></i></a>

                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div id="uploadrow"  runat="server">
                    <div id="uploadfileQueue" style="padding: 3px;">
                    </div>

                    <table>
                        <tr>
                            <td>
                                <div id="Supperfile_upload">
                                </div>
                            </td>
                            <td class="padding-l-5 hidden" id="tdUpload">
                                <span class="btn " onclick="SupperdoUpload();"><i class="fa fa-upload"></i></span>
                                <span class="btn " onclick="SuppercloseLoad();"><i class="fa fa-close"></i></span>
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
    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
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
            $("#Attachments1_actionRow").hide();
        }
    });
</script>