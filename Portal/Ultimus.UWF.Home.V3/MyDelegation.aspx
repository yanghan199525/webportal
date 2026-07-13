<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDelegation.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MyDelegation" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <base target="_self"></base>
    <title>
        <%=Lang.Get("Assign_Title") %></title>
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <%=WebUtil.IncludeFormV3Css()%>

    <script type="text/javascript">
        $().ready(function () {
            $("input[type=radio][name=AssignType]").each(function (index) {

                $(this).click(function () {
                    if ($(this).attr("checked") == "checked") {

                        if ($(this).attr("id") == "RadioButton3") {
                            $("#trFuture").css("display", "block");
                            $("tr[idx=trprocessname]").css("display", "none");
                        }
                        else if ($(this).attr("id") == "RadioButton4") {
                            $("#trFuture").css("display", "none");
                            $("tr[idx=trprocessname]").css("display", "block");
                        }
                        else {
                            $("#trFuture").css("display", "none");
                            $("tr[idx=trprocessname]").css("display", "none");
                        }
                    }
                });
            });
            $('#txtBegin').daterangepicker({
                singleDatePicker: true,
                "showDropdowns": true,
                "locale": {
                    "format": "YYYY/MM/DD"
                }
            });
            $('#txtEnd').daterangepicker({
                singleDatePicker: true,
                "showDropdowns": true,
                "locale": {
                    "format": "YYYY/MM/DD"
                }
            });
        });
    </script>
    <style type="text/css">
        body {
            font-family: 微软雅黑;
        }
    </style>
</head>
<body style="overflow: hidden;">
    <form id="form1" runat="server">

        <div class="container-default">
            <!-- Start Row -->
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">

                        <div class="panel-title">
                            <div class="fa-title">
                                <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Delegation")%>
                            </div>
                            <ul class="panel-tools">
                                <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                                <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                            </ul>
                        </div>

                        <div class="panel-body form-table">
                            <%--申请日期--%>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden">
                                <div class="form-label">
                                    <td><%=Lang.Get("Assign_FutureTaskAssignDate")%>
                                        <span class="red">*</span>
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <asp:TextBox ID="txtFutureTaskDate" runat="server" Width="150" CssClass="Wdate" Height="20"
                                            onclick="WdatePicker()"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <%--部门--%>
                            <div class="col-lg-4 col-sm-6 col-xs-12 form-cell <%=EnableProcessAssign%> hidden">
                                <div class="form-label">
                                    <asp:RadioButton ID="RadioButton4" runat="server" GroupName="AssignType" Checked="true" />
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <label for="RadioButton4" style="cursor: pointer;">
                                            <%=Lang.Get("Assign_ProcessAssign")%></label>
                                    </div>
                                </div>
                            </div>
                            <%--邮箱--%>
                            <div class="col-lg-12 col-sm-6 col-xs-12 form-cell">
                                <div class="form-label">
                                    <%=Lang.Get("frm_Queue_process")%><span style='color: red'>*</span>
                                    <%--<%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CostCenter")%>:--%>
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl">
                                        <asp:DropDownList ID="dropProcessName" runat="server" Width="250">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-sm-6 col-xs-12 form-cell">
                                <div class="form-label">
                                    <%=Lang.Get("Assign_AssignUser1")%><span style='color: red'>*</span>:
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl" style="width: 303px;">
                                        <%--                                   <div class="input-prepend input-group">
                                                        <ult:TextBox ID="fld_APPROVER"  title="审批人" data-type='string' data-field="APPROVER" onblur="checkExpression(this)" Variable="" 
                                                             CssClass="form-control validate[required]  ReadOnly" ControlValue='<%#Eval("APPROVER")%>' runat="server" >
                                                        </ult:TextBox>
                                                        <span class="add-on input-group-addon" style="cursor:pointer" onclick="selectUser(2, $(this).prev().attr('id'), '', $(this).prev().attr('id')+'_VALUE');"><i class="fa fa-search"></i></span>
                                                    </div>--%>
                                        <div class="input-prepend input-group">
                                            <input id="AssignUserName" style="" runat="server" class="form-control validate[required]  ReadOnly" onfocus="this.blur();" />
                                            <span class="add-on input-group-addon" style="cursor: pointer" onclick="selectUserInfo(1, 'AssignUserName', '', 'AssignUserAccount');"><i class="fa fa-search"></i></span>
                                            <input id="AssignUserAccount" type="hidden" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--申请人电话--%>
                            <div class="col-lg-12 col-sm-6 col-xs-12 form-cell">
                                <div class="form-label">
                                    <%=Lang.Get("TaskList_StartTime")%><span style='color: red'>*</span>
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl" style="width: 303px;">
                                        <asp:TextBox ID="txtBegin" CssClass="form-control" runat="server">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-sm-6 col-xs-12 form-cell">
                                <div class="form-label">
                                    <%=Lang.Get("TaskStatus_EndTime")%><span style='color: red'>*</span>
                                </div>
                                <div class="form-field">
                                    <div class="form-ctl" style="width: 303px;">
                                        <asp:TextBox ID="txtEnd" CssClass="form-control" runat="server">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div style="padding-top: 15px; padding-left: 328px; padding-bottom: 12px;">
                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-default" OnClientClick="return CheckPage()" Style="margin-left: 146px;" />



                            <a href="MyDelegationList.aspx" class="btn btn-warning"><%=Lang.Get("Assign_BackButton") %></a>
                            <script type="text/javascript">


                                function CheckPage() {
                                    var flag = false;
                                    const now = new Date();
                                    const year = now.getFullYear().toString();
                                    const month = (now.getMonth() + 1).toString().padStart(2, '0');
                                    const day = now.getDate().toString().padStart(2, '0');
                                    var datetime = `${year}/${month}/${day}`;
                                    var startDate = new Date($('#txtBegin').val());
                                    var endDate = new Date($('#txtEnd').val());
                                    var timeDiff = Math.abs(endDate.getTime() - startDate.getTime());
                                    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
                                    if ($("#AssignUserAccount").val() == "") {
                                        flag = false;
                                        alert('<%=Lang.Get("Assign_SelectUserMsg") %>');
                                        return flag;

                                    } else if ($("#RadioButton1").attr("checked")) {
                                        if ($("#TaskIDs").val() == "") {
                                            flag = false;
                                            alert('<%=Lang.Get("Assign_SelectTaskMsg") %>');
                                            return flag;

                                        }
                                    } else if ($("#RadioButton4").attr("checked")) {
                                        if ($("#dropProcessName option:selected").val() == "") {
                                            flag = false;
                                            alert('<%=Lang.Get("Assign_SelectProcessMsg") %>');
                                            return flag;

                                        }
                                    }
                                    debugger
                                    if ($("#txtBegin").val() == "") {
                                        flag = false;
                                        alert('<%=Lang.Get("Assign_SelectBeginDateMsg") %>');
                                         return flag;

                                     } else if ($("#txtEnd").val() == "") {
                                         flag = false;
                                         alert('<%=Lang.Get("Assign_SelectEndDateMsg") %>');
                                         return flag;

                                     } else if ($("#txtBegin").val() > $("#txtEnd").val()) {
                                         flag = false;
                                         alert('<%=Lang.Get("起始时间不能大于结束时间") %>');
                                         return flag;

                                     }
                                     else if ($("#txtBegin").val() < datetime) {
                                         flag = false;
                                         alert('<%=Lang.Get("起始时间不能小于当前时间") %>');
                                         return flag;

                                     } else if (diffDays > 30) {
                                         flag = false;
                                         alert('<%=Lang.Get("授权时间不能大于30天") %>');
                                        return flag;

                                    }
                                    return SubmitDialog();


                                    /*
                                     add yang.han date:04-10
                                     */

                                }
                                function SubmitDialog() {
                                    var processName = $("#dropProcessName option:selected").val()
                                    var AssignUserAccount = $("#AssignUserAccount").val().split('\\')[1]
                                    var txtBegin = $("#txtBegin").val().replace('\\', '-')
                                    var txtEnd = $("#txtEnd").val()
                                    var dataStory = "{\"processName\":\"" + processName + "\",\"AssignUserAccount\":\"" + AssignUserAccount + "\",\"txtBegin\":\"" + txtBegin + "\",\"txtEnd\":\"" + txtEnd + "\"}";
                                    console.log(dataStory);
                                    BootstrapDialog.show({
                                        title: '代理确认',
                                        message: 'The delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies.Non -compliance to the DOA as outlined in this document may result in disciplinary actions. 被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。The authority delegated in this document shall not be sub - delegated.上述授权不能二次授权',
                                        animate: false,
                                        closable: false,
                                        autoClose: false,
                                        buttons: [
                                            {
                                                id: 'btn_readButton', // 随机生成的ID
                                                label: '确定',
                                                cssClass: 'btn-default',
                                                action: function (dialog) {
                                                    if (dialog) {
                                                        $.ajax({
                                                            type: "post",
                                                            datatype: "json",
                                                            contentType: "application/json",
                                                            async: false,
                                                            url: 'MyDelegation.aspx/SendEmail',
                                                            data: "{\"processName\":\"" + processName + "\",\"AssignUserAccount\":\"" + AssignUserAccount + "\",\"txtBegin\":\"" + txtBegin + "\",\"txtEnd\":\"" + txtEnd + "\"}",
                                                            success: function (data) {
                                                                debugger
                                                                if (data.d) {
                                                                    alert("操作成功!");
                                                                    dialog.close();
                                                                } else {
                                                                    alert("操作失败，请联系管理员");
                                                                }
                                                            }
                                                        });
                                                    }

                                                }
                                            },
                                            {
                                                id: 'btnCancel', // 随机生成的ID
                                                label: '取消',
                                                cssClass: 'btn-warning',
                                                action: function (dialog) {
                                                    dialog.close();
                                                }
                                            },
                                            {
                                                id: 'btnRead', // 随机生成的ID
                                                label: '',
                                                cssClass: 'btn-primary',

                                            },
                                            // 其他按钮配置...
                                        ],
                                        onshown: function (dialogresult) {
                                            $('#btn_readButton').hide();
                                            $('#btnCancel').hide();
                                            debugger
                                            // 对话框显示后的回调函数
                                            var num = 25;
                                            var timerId = setInterval(function () {
                                                // 每秒检查一次用户是否进行了操作
                                                num--;
                                                // 检查是否已经过了25秒
                                                if (num <= 0) {
                                                    $('#btn_readButton').show();
                                                    $('#btnCancel').show();

                                                    clearInterval(timerId);
                                                    $('#btnRead').hide();

                                                } else {
                                                    $('#btnRead').html(num); // 置灰按钮

                                                }

                                            }, 1000); // 每秒检查一次
                                        }
                                    });
                                    return false;
                                }
                                function closePage() {
                                    alert('<%=Lang.Get("SubmitSuccess") %>');
                                    $(".modal-dialog", parent.document).hide();
                                    //parent.document.location.href = parent.document.location.href;
                                    window.location.href = '../Ultimus.UWF.Home.V3/MyDelegationList.aspx?menuname=代理';
                                }
                            </script>
                        </div>
                    </div>
                </div>

            </div>

            <div class="container-fluid">
                <div class="hidden">

                    <legend><%=Lang.Get("Delegation")%></legend>
                    <%=Lang.Get("Assign_Type")%>
                    <label for="RadioButton1" style="cursor: pointer;">
                        <%=Lang.Get("Assign_SelectTaskAssign")%></label>
                    <asp:RadioButton ID="RadioButton1" runat="server" GroupName="AssignType" />
                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="AssignType" />
                    <label for="RadioButton2" style="cursor: pointer;">
                        <%=Lang.Get("Assign_AllTaskAssign")%></label>
                    <asp:RadioButton ID="RadioButton3" runat="server" GroupName="AssignType" />

                </div>
            </div>
            <asp:HiddenField ID="TaskIDs" runat="server" />
    </form>
</body>
</html>
