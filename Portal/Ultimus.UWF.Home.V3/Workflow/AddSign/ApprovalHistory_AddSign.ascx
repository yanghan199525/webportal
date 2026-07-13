<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApprovalHistory_AddSign.ascx.cs"
    Inherits="Ultimus.UWF.AddSign.ApprovalHistory_AddSign" %>

<style type="text/css">
    @media (min-width: 1290px) {
    .form-content_1 {
        width:85% !important;
    }
}

    @media (max-width: 568px) {
    .form-content_1 {
        width:67% !important;
    }
}
</style>

<div class="form-content" style="padding-top:1px">
    <div class="container-default">
        <!-- Start Row -->
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default" style="border:0px;margin-bottom:0px">
                    <div class="panel-body form-table">
                        <div class="col-lg-12 col-sm-12 col-xs-12 form-cell" id="trIdear" style="height: 99%" runat="server">
                            <div class="form-label" style="height: 119px">
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>：
                            </div>
                            <div class="form-content form-content_1" style="width:70%">
                                <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" TextMode="MultiLine" Width="102.5%"
                                    MaxLength="1000" Height="100px"></asp:TextBox>
                            </div>
                            <span class=" hidden-xs hidden">( <%=Ultimus.UWF.Common.Logic.Lang.Get("MaxLength")%>：<asp:Label Text="0" runat="server"
                                ID="reachChar" Font-Underline="true" ForeColor="Blue"> </asp:Label>
                                <%=Ultimus.UWF.Common.Logic.Lang.Get("Char")%>：)<br />
                            </span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="hidden">
    <asp:TextBox ID="txtShowAction" runat="server"></asp:TextBox>
</div>
<script type="text/javascript">
    String.prototype.trim = function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    function validateIdear() {



        if ($("#ApprovalHistory1_txtComments").val() == undefined || $("#ApprovalHistory1_txtComments").val().trim() == "") {
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("RequireComments")%>');
            $("#ApprovalHistory1_txtComments").focus();
            return false;
        }

        if ($("#ApprovalHistory1_txtComments").val() != undefined && getLength($("#ApprovalHistory1_txtComments").val()) > 4000) {
            alert('<%=Ultimus.UWF.Common.Logic.Lang.Get("CommentsOverLength")%>');
            return false;
        }
        return true;
    }

    $().ready(function () {
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

</script>
