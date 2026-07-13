<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delegation.aspx.cs" Inherits="Ultimus.UWF.Home.V3.Delegation" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <base target="_self"></base>
    <title>
            <script type='text/javascript' src='NewRequest.js?t=2c190ce2-6db8-40eb-8fb3-ab8529768599'></script>

        <%=Lang.Get("Assign_Title") %></title>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath() %>/common/assets/js/My97DatePicker/lang/en.js'></script>
        <%=WebUtil.IncludeFiles() %>
   <%--<script type="text/javascript" src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Assets/js/selectorNew.js"></script>--%>
       <%=WebUtil.IncludeJsV3()%>
     <script type="text/javascript" >
         $(function(){
             $('#txtStartDate').daterangepicker({
                 singleDatePicker: true,
                 "showDropdowns": true,
                 "locale": {
                     "format": "YYYY/MM/DD"
                 }
             });
             $('#txtEndDate').daterangepicker({
                 singleDatePicker: true,
                 "showDropdowns": true,
                 "locale": {
                     "format": "YYYY/MM/DD"
                 }
             });
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
         })
    </script>
<%--        <link href="../../common/assets/css/root.css" rel="stylesheet" />--%>
            <link href="css/root.css" rel="stylesheet" />

    <style>
        body
        {
            font-family:微软雅黑;
        }
    </style>
</head>
<body style="overflow: hidden;">
    <form id="form1" runat="server">
    <div>
        <table class="TableData" width="98%">
            <tr class=" hidden">
                <td colspan="3" class="banner">
                    <%=Lang.Get("Assign_Type")%>
                </td>
            </tr>
            <tr style="text-align: left; height: 20px;" class=" hidden">
                <td width="20">
                    <asp:RadioButton ID="RadioButton1" runat="server" GroupName="AssignType" />
                </td>
                <td>
                    <label for="RadioButton1" style="cursor: pointer;">
                        <%=Lang.Get("Assign_SelectTaskAssign")%></label>
                </td>
                <td>
                </td>
            </tr>
            <tr class="TableDataRow hidden" style="text-align: left; height: 20px;">
                <td>
                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="AssignType" />
                </td>
                <td>
                    <label for="RadioButton2" style="cursor: pointer;">
                        <%=Lang.Get("Assign_AllTaskAssign")%></label>
                </td>
            </tr>
            <tr class="TableDataRow hidden" style="text-align: left; height: 20px;"  >
                <td>
                    <asp:RadioButton ID="RadioButton3" runat="server" GroupName="AssignType" />
                    <script type="text/javascript">
                        function furClick() {
                            //alert(1);
                            //alert($("#RadioButton3").attr("checked"));
                        }
                    </script>
                </td>
                <td>
                    <label for="RadioButton3" style="cursor: pointer;">
                       <%=Lang.Get("Assign_FutureTaskAssign")%> </label>
                </td>
                <td>
                </td>
            </tr>
            <tr>
            <td colspan="2">
            <table>
            <tr id="trFuture" style="height: 20px; display: none;" class=" hidden">
                <td> <%=Lang.Get("Assign_FutureTaskAssignDate")%>
                        <span class="red">*</span>
                </td>
                <td colspan="2">
                    <div style="border: 1px;">
                       
                        <asp:TextBox ID="txtFutureTaskDate" runat="server" Width="150" CssClass="Wdate" Height="20"
                            onclick="WdatePicker()"></asp:TextBox>
                    </div>
                </td>
            </tr>
            </table>
            </td>
            </tr>
            
            <tr class="TableDataRow <%=EnableProcessAssign%> hidden" style="text-align: left; height: 20px;">
                <td>
                    <asp:RadioButton ID="RadioButton4" runat="server" GroupName="AssignType"  Checked="true" />
                </td>
                <td>
                    <label for="RadioButton4" style="cursor: pointer;">
                        <%=Lang.Get("Assign_ProcessAssign")%></label>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="banner">
                   <%=Lang.Get("Delegation")%><%=Lang.Get("frm_Queue_process")%>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table cellpadding="2">
                        <tr idx="trprocessname" class="TableDataRow" style=" ">
                             <td > <%=Lang.Get("frm_Queue_process")%><span class="red">*</span>
                             </td>
                            <td>
                               
                                <asp:DropDownList ID="dropProcessName" runat="server" Width="250">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr idx="trprocessname" class="TableDataRow" style="">
                            <td>
                             <%=Lang.Get("Assign_Date")%>
                                <span class="red">*</span>
                            </td>
                            <td>
                                                               <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            <%=Lang.Get("TaskList_StartTime")%>:
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <div class="input-prepend input-group">

                                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="add-on input-group-addon"><i class="fa fa-calendar"></i></span>--                                                                                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                <span class="add-on input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
<%--                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-5  col-xs-5">
                                            -
                                        </div>
                                        <div class="col-md-7  col-xs-7">
                                            <div class="input-prepend input-group">

                                            </div>
                                        </div>
                                    </div>
                                </div>--%>
<%--                                <asp:TextBox ID="txtBegin" runat="server" CssClass="Wdate" Height="20px" Width="100"
                                    onclick="WdatePicker()"></asp:TextBox>
                                &nbsp;&nbsp;-
                                <asp:TextBox ID="txtEnd" runat="server" CssClass="Wdate" Height="20px" Width="100"
                                    onclick="WdatePicker({minDate:'#F{$dp.$D(\'txtBegin\')}'})"></asp:TextBox>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="banner">
                   <%=Lang.Get("Assign_AssignUser1")%> 
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <%=Lang.Get("Assign_AssignUser")%><span class="red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input id="AssignUserName" style="width: 200px;" runat="server" class="TextSearch" onfocus="this.blur();" />
                    <input type="button" value="..." class="btn Button" 
                        style="cursor:pointer" onclick="parent.selectUserInfo(2, $('#AssignUserName').attr('id'), '', $('#AssignUserAccount').attr('id'), null, true);"/>
                    <input id="AssignUserAccount" type="hidden" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                &nbsp;</td>
            </tr>
            <tr class="TableDataRow" style="text-align: left; height: 20px;">
                <td colspan="2" align="center">
                    <asp:Button ID="Button1" runat="server"  CssClass="btn  btn-primary" OnClientClick="return CheckPage()" 
                        OnClick="Button1_Click" />

                    <a href="DelegationList.aspx"  class="btn btn-default" target="_blank"><%=Lang.Get("Cancel_Delegation") %></a>
                    <script type="text/javascript">
                        function CheckPage() {
                            
                            var flag = true;
                            if ($("#AssignUserAccount").val() == "") {
                                flag = false;
                                alert('<%=Lang.Get("Assign_SelectUserMsg") %>');
                            } else if ($("#RadioButton1").attr("checked")) {
                                if ($("#TaskIDs").val() == "") {
                                    flag = false;
                                    alert('<%=Lang.Get("Assign_SelectTaskMsg") %>');
                                }
                            } else if ($("#RadioButton4").attr("checked")) {
                                if ($("#dropProcessName option:selected").val() == "") {
                                    flag = false;
                                    alert('<%=Lang.Get("Assign_SelectProcessMsg") %>');
                                } else if ($("#txtBegin").val() == "") {
                                    flag = false;
                                    alert('<%=Lang.Get("Assign_SelectBeginDateMsg") %>');
                                } else if ($("#txtBegin").val() == "") {
                                    flag = false;
                                    alert('<%=Lang.Get("Assign_SelectEndDateMsg") %>');
                                }
                            }
                            return flag;
                        }

                        function closePage() {
                            alert('<%=Lang.Get("SubmitSuccess") %>');
                            $(".modal-dialog", parent.document).hide();
                            parent.document.location.href = parent.document.location.href;
                        }

                    </script>
                    <input type="button" class="btn Button hidden" value='<%=Lang.Get("Assign_CloseButton") %>'
                        onclick="window.close()" />
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="TaskIDs" runat="server" />
    </form>
</body>
</html>
