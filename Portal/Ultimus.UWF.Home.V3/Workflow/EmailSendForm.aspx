


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailSendForm.aspx.cs" Inherits="Ultimus.UWF.Workflow.EmailSendForm" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<script src="js/jquery.js" type="text/javascript"></script>--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <base target="_self" />

    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>

</head>
<body>
    <form id="form1" runat="server">
        <div class="form-content">
            <div class="page-header ">
                <div class="left hidden-xs">
                    <img src="<%=WebUtil.GetRootPath()%>/common/assets/img/form_logo.png" alt="logo" />
                </div>
                <h1 class="title center"><strong>
                    <asp:Label ID="txtProcessNameS" runat="server"></asp:Label>
                </strong></h1>
                <ol class="breadcrumb center">
                    <li class="active">
                        <asp:Label ID="txtsteplabel" runat="server"></asp:Label>
                    </li>
                </ol>
                <div class="right">
                    <div class="btn-group">
                        <div id="barcode2">
                        </div>
                        <div id="documentno" style="text-align: center" class="">
                            <asp:Label ID="lblDocumentNo" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>
                 <!--add yang.han time 2021-06-15-->
             <div class="col-lg-12 col-sm-12 col-xs-12 form-cell" id="ChechBox" style="height: 120px;margin:15px 0px;" runat="server">
                 <div class="form-lable" style="padding:0px 10px">
                                 <span style="font-size:16px;color:red;">
                                      <%=Ultimus.UWF.Common.Logic.Lang.Get("Tips")%>
                                     <%--该订单金额已经超过5万，审批前请与客户进行以下确认!--%>
                                 </span>
                             </div>            
                <%-- <div class="form-lable" style="padding:5px 30px">
                                 <span style="font-size:16px;">--%>
                                     <%-- <%=Ultimus.UWF.Common.Logic.Lang.Get("Confirm")%>--%>
                                     <%--该订单金额已经超过5万，审批前请与客户进行以下确认!--%>
                                <%-- </span>
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
            </div>

            <div class="container-default">
                <div class="row">
                    <div class="col-md-12">

                        <div class="panel panel-default" runat="server" id="divApproveResult" visible="false">
                            <div class="title center" style="" runat="server" id="divApproveResultSuss" visible="false">
                                <div class="fa-title">
                                    <i class="fa fa-check-circle" style="color: green; font-size: 50px;"></i><span class="padding-r-5"></span>
                                    <asp:Label ID="lbResult" runat="server" Style="font-size: 14pt;"></asp:Label>
                                </div>
                            </div>
                            <div class="title center" style="font-size: 13pt;" runat="server" id="divApproveResultFail" visible="false">

                                <div class="fa-title">
                                    <i class="fa fa-exclamation-triangle" style="color: yellow; font-size: 50px;"></i>
                                    <span class="padding-r-5"></span>
                                    <asp:Label ID="lbResultFail" runat="server" Style="font-size: 14pt;"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default" runat="server" id="divApprove" visible="false">
                            <div class="panel-body form-table" style="border-top: 1px; border-color: #efefef;">
                                <div class="col-lg-12 col-sm-12 col-xs-12 form-cell  ">
                                </div>
                                  <div  class="col-lg-12 col-sm-12 col-xs-12 form-cell padding-b-20" id="dev_SIGNNAME"  runat="server" style="height: 60px">
                                    <div class="form-label" style="height: 60px; margin-top: 0px;">
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("SIGNNAME")%>：                              </div>
                               <div class="form-content" style="width:75%;">
                                    <asp:DropdownList ID="fld_SIGNNAME" title="" onblur="checkExpression(this)" data-field="SIGNNAME" Variable="" CssClass="form-control  selector validate[required]" Source="" Filter="" ControlValue="" runat="server">
                                    </asp:DropdownList>
                                </div>                            
                                </div>
                                <div class="col-lg-12 col-sm-12 col-xs-12 form-cell padding-b-20" style="height: 120px">
                                    <div class="form-label" style="height: 119px; margin-top: 0px;">
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>：                               
                                    </div>
                                    <div class="form-content" style="width:75%;">
                                        <asp:TextBox ID="txtComments" runat="server" CssClass="form-control validate[required max[1000]]" TextMode="MultiLine"
                                            MaxLength="1000" Height="100px" Style="margin-top: 1px;"></asp:TextBox>
                                    </div>
                                    <span class="hidden-xs hidden-sm hidden-md hidden">( <%=Ultimus.UWF.Common.Logic.Lang.Get("MaxLength")%>：<asp:Label Text="0" runat="server"
                                        ID="reachChar" Font-Underline="true" ForeColor="Blue"> </asp:Label>
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Char")%>：)<br />
                                    </span>
                                </div>

                                                              <div id="appOC" runat="server">
                                    <div class="form-label" style="margin-top: 0px;">
                                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Details")%>：                               
                                    </div>
                                    <div>
                                 <a  style="text-decoration:underline;" id ="appdetails" runat="server">  <%=Ultimus.UWF.Common.Logic.Lang.Get("Details")%> </a>
                                    </div>                       
                                </div>
                                </div>
                        </div>

                        <div class="panel panel-default" runat="server" id="divApproveLog" visible="false">
                            <div class="panel-title">
                                <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("ApprovalHistory")%></div>
                            </div>
                            <div class="panel-body">
                                <!--Start detail table-->
                                <table class="table table-bordered table-condensed form-detail-table" width="100%">
                                    <thead>
                                        <tr>
                                            <td class="" style="width:50px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("No") %></td>
                                            <td style="width: 100px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_Approver")%></td>
                                            <td class="" style="width: 160px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%></td>
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
                                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%>'>
                                                        <%# Eval("StepName")%>
                                                    </td>
                                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>'>
                                                        <%# Eval("Comments")%>
                                                    </td>
                                                    <td data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveAction")%>'>
                                                        <%# Eval("Action")%>
                                                    </td>
                                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveDate")%>'>
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

                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-body" style="border-top: 0px;">

                                <div class="col-lg-12 col-sm-12 col-xs-12  padding-b-20 " style="height: 35px; text-align: center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="确认" OnClientClick="return submitForm();"
                                        OnClick="btnSubmit_Click" class="btn btn-default " Visible="false" />

                                    <asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="btn " OnClientClick="return closeWin();" />
                                   <asp:Button ID="butSIGN" runat="server" Text="加签" OnClientClick="return signSubmit();"
                                        OnClick="btnSIGN_Click" class="btn btn-default " Visible="false" />

                                      <asp:Button ID="btTransfer" runat="server" Text="转办" OnClientClick="return signSubmit();"
                                        OnClick="btnTransfer_Click" class="btn btn-default " Visible="false" />
                                </div>
                            </div>
                        </div>

                    </div>
                    <div style="display: none;">
                        <div style="display: none;">
                        <!--taskid-->
                        <asp:TextBox ID="txttaskid" runat="server"></asp:TextBox>
                        <!--username-->
                        <asp:TextBox ID="txtusername" runat="server"></asp:TextBox>
                        <!--type-->
                        <asp:TextBox ID="txttype" runat="server"></asp:TextBox>
                        <!--processname-->
                        <asp:TextBox ID="txtprocessname" runat="server"></asp:TextBox>
                        <!--incident-->
                        <asp:TextBox ID="txtincident" runat="server"></asp:TextBox>

                        <!--applicant-->
                        <asp:TextBox ID="txtLoginAccount" runat="server"></asp:TextBox>

                        <!--tableName-->
                        <asp:TextBox ID="txttableName" runat="server"></asp:TextBox>

                        <!--FORMID-->
                        <asp:TextBox ID="txtFORMID" runat="server"></asp:TextBox>

                        <%--CPR_APPROVE  &&  提交审批日期--%>
                        <asp:TextBox ID="var_APPROVE" runat="server"></asp:TextBox>

                         <%--USER_SEGMENTDIRECTOR_1  &&  事业部总监1--%>
                        <asp:TextBox ID="var_USER_SEGMENTDIRECTOR_1" runat="server"></asp:TextBox>

                         <%--SEGMENTDIRECTOR--%>
                        <asp:TextBox ID="var_SEGMENTDIRECTOR" runat="server"></asp:TextBox>
                        <asp:TextBox ID="CheckBoxText" runat="server"></asp:TextBox>

                      <%--   <asp:TextBox ID="var_issign" runat="server"></asp:TextBox>--%>
                    </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="hidden">
            <asp:TextBox ID="Check_values" runat="server"></asp:TextBox>
        </div>
    </form>
</body>
<script type="text/javascript">
    String.prototype.trim = function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    function code128() {
        $("#barcode2").empty().barcode($("#lblDocumentNo").text(), "code128", { barWidth: 1, barHeight: 30, showHRI: false });
    }

    $(document).ready(function () {
       
        code128();
        $("#txtComments").keyup(function () {

            $("#reachChar").text(getLength($("#txtComments").val()));
            if (getLength($("#txtComments").val()) > 4000) {
                $("#reachChar").css("color", "red");
            }
            else {
                $("#reachChar").css("color", "blue");
            }
        });
        if ($("#txttype").val() == "1") {
            $("#ChechBox").css("display", "none");
        }
        var value = $("#Check_values").val();
        if (value == "block") {
            $("#ChechBox").css("display", "block");
        } else {
             $("#ChechBox").css("display", "none");
        }
 if (isIE()) {
            alert("请使用Edge浏览器或者谷歌浏览器打开");
        }
    });

    function submitForm() {
        <%--if ($("#txtComments").val() == undefined || $("#txtComments").val().trim() == "") {
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("RequireComments")%>');
                $("#txtComments").focus();
                return false;
            }
            else {
                if ($("#txtComments").val() != undefined && getLength($("#txtComments").val()) > 2000) {
                    alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("CommentsOverLength")%>');
                    return false;
                }
                else {
                    if (!confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>')) {
                        return false;
                    } else { return true; }
                }
            }--%>
        debugger

        //Add yang.han time 2021-11-04
        if ($("#txttype").val() == "0") { // Approval Pass
            //通过时判断是否勾选复选框
             var Check_value1 = $("input[name='Check_Value1']").is(':checked');
             var Check_value2 = $("input[name='Check_Value2']").is(':checked');
            var value = $("#Check_values").val();
            var Email_confirmation = $(".Email_confirmation").text().trim();
            var Telephone_confirmation = $(".Telephone_confirmation").text().trim();
            if (value == "block") {
                if (Check_value1 && Check_value2) {
                    $("#CheckBoxText").val(Email_confirmation+"|"+Telephone_confirmation);
                } else if (!Check_value1 && Check_value2) {
                    $("#CheckBoxText").val(Email_confirmation);
                }
                else if (Check_value1 && !Check_value2) {
                    $("#CheckBoxText").val(Telephone_confirmation);
                }
                else {
                     alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("Communication mode")%>');
                     return false;
                }
            } else {
                $("#ChechBox").css("display","none")
                $("#CheckBoxText").val("");
            }
        }
        else if ($("#txttype").val() != "0" && ($("#txtComments").val() == undefined || $("#txtComments").val().trim() == "")) {
            $("#CheckBoxText").val("");
            $("#ChechBox").css("display","none")
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("RequireComments")%>');
            $("#txtComments").focus();
            return false;
        }
        else {
            $("#CheckBoxText").val("");
            $("#ChechBox").css("display","none")
            if ($("#txtComments").val() != undefined && getLength($("#txtComments").val()) > 2000) {
                alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("CommentsOverLength")%>');
                return false;
            }
            else {
                if (!confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SubmitConfirm") %>')) {
                    return false;
                } else { return true; }
            }
        }
       
    }
    function closeWin() {
        window.opener = null;
        window.open('', '_self');
         window.open('', '_self').close();
        return false;
    }
    function signSubmit() {
         var SIGNNAME = $("#fld_SIGNNAME").val();
            if (SIGNNAME == "") {
                alert('请选择经办人员');
                return false;
            }
        submitForm();

    }


function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window) 
        return true;
    else
        return false;
    }

        //function getByteLen(str) {
        function getLength(val) {
            var cArr = val.match(/[^\x00-\xff]/ig);
            var num = val.length + (cArr == null ? 0 : cArr.length);
            return num;
        } //为UTF-8时，非ASCII字符占用三个字节宽

        //}

</script>

</html>
