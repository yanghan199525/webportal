<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApprovalHistory_AddSign.ascx.cs"
    Inherits="Ultimus.UWF.AddSign.ApprovalHistory_AddSign" %>

<div class="panel" style="width:100%;"> 
    <table style="width:100%">
        <tr id="trIdear" runat="server">
            <td class="labelTD">
                <%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%> ：
            </td>
            <td class="textTD" colspan="3">
                <span>( <%=Ultimus.UWF.Common.Logic.Lang.Get("MaxLength")%>：<asp:Label Text="0" runat="server"
                    ID="reachChar" Font-Underline="true" ForeColor="Blue"> </asp:Label>
                    <%=Ultimus.UWF.Common.Logic.Lang.Get("Char")%>：)<br />
                </span>
                <asp:TextBox ID="txtComments" runat="server" Width="90%" Height="100" TextMode="MultiLine"
                    MaxLength="1000"></asp:TextBox>
            </td>
        </tr>
    </table>
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
