<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApprovalHistory.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.ApprovalHistory" %>
<div class="row" id="approvalrow">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-title">
                <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("ApprovalHistory")%></div>
                <ul class="panel-tools">
                    <li style="color: blue;" id="lb_Char">
                        <asp:HyperLink ID="hyFlow" runat="server" Target="_blank"></asp:HyperLink></li>
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>


            <div class="panel-body">
                <!--Start detail table-->
                <table class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                    <thead>
                        <tr>
                            <td class="" style="width: 50px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("No") %></td>
                            <td style="width: 100px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_Approver")%></td>
                            <td class="hidden-xs" style="width: 160px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%></td>
                            <td><%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%></td>
                            <td style="width: 150px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveAction")%></td>
                            <td style="width: 150px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveDate")%></td>
                        </tr>
                    </thead>
                    <tbody>

                        <asp:Repeater ID="ApprovalHistoryList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("No")%>'>
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <%-- <td><%# Eval("Level") %></td>--%>
                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("History_Approver")%>'>
                                        <%# Eval("ApproverName")%>
                                    </td>
                                    <td class="hidden-xs" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%>'>
                                        <%# Eval("StepName")%>
                                    </td>
                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>'>
                                        <%# Eval("Comments")%>
                                    </td>
                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveAction")%>'>
                                        <%# Eval("Action")%>
                                    </td>
                                    <td class="utcdatetime" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveDate")%>'>
                                        <%#MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).Year==1900?"**********":MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).ToString("yyyy/MM/dd HH:mm:ss") %>
                                    </td>
                                    <%-- <td class="hidden-sm hidden-md hidden-lg">
                                        <%#MyLib.ConvertUtil.ToDateTime( Eval("CreateDate")).ToString("MM/dd") %>
                                    </td>--%>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div class="hidden-print">
                    <div class="panel-body form-table" style="border-top: 0px;">
                        <div class="col-lg-12 col-sm-12 col-xs-12 form-cell hidden" id="trAction" runat="server">
                            <div class="form-label">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveAction")%>：
                            </div>
                            <div class="form-content">
                                <span class="radio radio-primary inline">
                                    <asp:RadioButton ID="rbApprove" runat="server" Text="同意" GroupName="action" CssClass="" />
                                </span>
                                <span class="radio radio-primary inline">
                                    <asp:RadioButton ID="rbReturn" runat="server" Text="退回" GroupName="action" />
                                </span>
                                <span class="radio radio-primary inline">
                                    <asp:RadioButton ID="rbSelectReturn" runat="server" Text="选择退回" GroupName="action" />
                                </span>
                                <span class="radio radio-primary inline">
                                    <asp:RadioButton ID="rbReject" runat="server" Text="拒绝" GroupName="action" />
                                </span>
                            </div>
                        </div>

                        <div class="col-lg-6 col-sm-8 col-xs-12 form-cell hidden" id="selectReturn" runat="server">
                            <div class="form-label">
                                选择退回
                            </div>
                            <div class="form-content">
                                <asp:DropDownList ID="rblStepList" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default" style="padding-top:5px">
            <div class="panel-body form-table">
                <div class="col-lg-12 col-sm-12 col-xs-12 form-cell" id="ChechBox" style="height: 120px;margin:15px 0px;" runat="server">
                             <div class="form-lable" style="padding:0px 10px">
                                 <span style="font-size:16px;color:red;">
                                      <%=Ultimus.UWF.Common.Logic.Lang.Get("Tips")%>
                                     <%--该订单金额已经超过5万，审批前请与客户进行以下确认!--%>
                                 </span>
                             </div>
                            <%-- <div class="form-lable" style="padding:5px 30px">
                                 <span style="font-size:16px;">
                                      <%=Ultimus.UWF.Common.Logic.Lang.Get("Confirm")%>--%>
                                     <%--该订单金额已经超过5万，审批前请与客户进行以下确认!--%>
                              <%--   </span>
                             </div>--%>
                              <div class="form-content" style="padding:5px 40px;">
                                 <div>
                                    <input type="checkbox" name="Check_Value1" style="vertical-align:middle;" value="1" />
                                    <span style="vertical-align:middle;" class="Telephone_confirmation" >
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Telephone confirmation")%>
                                        <%--已与客户完成电话确认--%>
                                    </span>
                                </div>
                                 <div>
                                    <input type="checkbox" name="Check_Value2" style="vertical-align:middle;" value="2" />
                                    <span style="vertical-align:middle;" class="Email_confirmation">
                                         <%=Ultimus.UWF.Common.Logic.Lang.Get("Email confirmation")%>
                                        <%--已与客户完成邮件确认--%>
                                    </span>
                                 </div>
                            </div>
                           
                       </div>
                <div  class="col-lg-12 col-sm-12 col-xs-12 form-cell padding-b-20" id="dev_SIGNNAME"  runat="server" style="height: 60px"  Visible="false">
                                    <div class="form-label" style="height: 60px; margin-top: 0px;">
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("SIGNNAME")%>：                              </div>
                               <div class="form-content" style="width:80%;">
                                    <asp:DropdownList ID="fldSIGNNAME" runat="server" style="width:100%" >
                                    </asp:DropdownList>
                                </div>                                   
                                </div>
                <div class="col-lg-12 col-sm-12 col-xs-12 form-cell" id="trIdear" runat="server">
                    <div class="form-label" style="height: 119px">
                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>：
                               
                    </div>
                    <div class="form-content" style="width:80%">
                        <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" TextMode="MultiLine"
                            MaxLength="1000" Height="100px" style="width:100%"></asp:TextBox>
                    </div>
                    <span class=" hidden-xs hidden-sm hidden-md hidden">( <%=Ultimus.UWF.Common.Logic.Lang.Get("MaxLength")%>：<asp:Label Text="0" runat="server"
                        ID="reachChar" Font-Underline="true" ForeColor="Blue"> </asp:Label>
                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Char")%>：)<br />
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="hidden">
    <asp:TextBox ID="txtShowAction" runat="server"></asp:TextBox>
     <asp:TextBox ID="Check_values" runat="server"></asp:TextBox>
     <asp:TextBox ID="CheckBoxText" runat="server"></asp:TextBox>
</div>
<script type="text/javascript">
    String.prototype.trim = function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    function validateIdear() {

        var vatShowAction = $("#ApprovalHistory1_txtShowAction").val();
        //alert(vatShowAction);
        if (vatShowAction == "1" || vatShowAction == "") {
            if (!$("#ApprovalHistory1_rbReturn").prop("checked")
                && !$("#ApprovalHistory1_rbSelectReturn").prop("checked")
                && !$("#ApprovalHistory1_rbApprove").prop("checked")
                && !$("#ApprovalHistory1_rbReject").prop("checked")) {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveActionRequire")%>');
                return false;
            }
        }
        //判断如果是同意时必须勾选复选框
        debugger
        var a = $("#ApprovalHistory1_rbApprove").prop('checked');
        var Check_value1 = $("input[name='Check_Value1']").is(':checked');
        var Check_value2 = $("input[name='Check_Value2']").is(':checked');
        var Email_confirmation = $(".Email_confirmation").text().trim();
        var Telephone_confirmation = $(".Telephone_confirmation").text().trim();
        if (a) {
            var value = $("#ApprovalHistory1_Check_values").val();
            if (value == "block") {
                if (Check_value1 && Check_value2) {
                    $("#ApprovalHistory1_CheckBoxText").val(Email_confirmation+"|"+Telephone_confirmation);
                } else if (!Check_value1 && Check_value2) {
                    $("#ApprovalHistory1_CheckBoxText").val(Email_confirmation);
                }
                else if (Check_value1 && !Check_value2) {
                    $("#ApprovalHistory1_CheckBoxText").val(Telephone_confirmation);
                }
                else {
                    alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("Communication mode")%>');
                     return false;
                }
            } else {
                $("#ApprovalHistory1_ChechBox").css("display","none");
                $("#ApprovalHistory1_CheckBoxText").val("");
            }
        } else {
            $("#ApprovalHistory1_CheckBoxText").val("");
        }
        var f = $("#ApprovalHistory1_rbReturn").prop("checked");
        var h = $("#ApprovalHistory1_rbReject").prop("checked");
        var s = $("#ApprovalHistory1_rbSelectReturn").prop("checked");
        if (f || h||s) {
            if ($("#ApprovalHistory1_txtComments").val() != undefined && $("#ApprovalHistory1_txtComments").val().trim() == "") {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("RequireComments")%>');
                $("#ApprovalHistory1_txtComments").focus();
                return false;
            }
        }
        if ($("#ApprovalHistory1_txtComments").val() != undefined && getLength($("#ApprovalHistory1_txtComments").val()) > 1000) {
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("CommentsOverLength")%>');
            return false;
        }
        return true;
    }
    function appForm() {
        if (GetQueryString("fromterminal") == 'app') {
            $("#approvalrow").css("display", "none");
        }
    }
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]); return null;
    }
    $().ready(function () {
        appForm();
         var value = $("#ApprovalHistory1_Check_values").val();
        if (value == "hidden") {
            $("#ApprovalHistory1_ChechBox").css("display", "none");
        }
        $("#ApprovalHistory1_txtComments").keyup(function () {

            $("#ApprovalHistory1_reachChar").text(getLength($("#ApprovalHistory1_txtComments").val()));
            if (getLength($("#ApprovalHistory1_txtComments").val()) > 4000) {
                $("#ApprovalHistory1_reachChar").css("color", "red");
            }
            else {
                $("#ApprovalHistory1_reachChar").css("color", "blue");
            }
        });
    });
    //function getByteLen(str) {
    function getLength(val) {
        var cArr = val.match(/[^\x00-\xff]/ig);
        var num = val.length + (cArr == null ? 0 : cArr.length);
        return num;
    } //为UTF-8时，非ASCII字符占用三个字节宽

    //}
     function signValidate() {
         var SIGNNAME = $("#fldSIGNNAME").val();
            if (SIGNNAME == "") {
                alert('请选择经办人员');
                return false;
            }
     }

</script>
