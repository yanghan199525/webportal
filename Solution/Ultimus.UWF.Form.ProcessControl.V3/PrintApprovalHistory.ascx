<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApprovalHistory.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.ApprovalHistory" %>

<div class="panel"><%=Ultimus.UWF.Common.Logic.Lang.Get("ApprovalHistory")%></div>

<table border='1' style='border-collapse: collapse; width: 100%;'>
    <tr>
        <td style="min-width: 10px; max-width: 10px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("No")%></td>
        <td style="min-width: 30px; max-width: 60px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_Approver")%>
        </td>
        <td style="min-width: 50px; max-width: 100px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("History_StepName")%>
        </td>
        <td class="thlbl" style="min-width: 120px;"><%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>
        </td>
        <td style="width: 100px;"
            class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveAction")%>
        </td>
        <td style="width: 140px;"
            class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveDate")%>
        </td>
    </tr>
    <asp:Repeater ID="ApprovalHistoryList" runat="server">
        <ItemTemplate>
            <tr>
                <td>
                    <%# Container.ItemIndex+1 %>
                </td>

                <td>
                    <%# Eval("ApproverName")%>
                </td>
                <td>
                    <%# Eval("StepName")%>
                </td>
                    <td style="word-break:break-all" >
                    <%# Eval("Comments")%>
                </td>
                <td>
                    <%# Eval("Action")%>
                </td>
                <td class="utcdatetime" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("ApproveDate")%>'>
                    <%#MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).Year==1900?"**********":MyLib.ConvertUtil.ToDateTime(Eval("CreateDate")).ToString("yyyy/MM/dd HH:mm:ss") %>
                </td>

            </tr>

        </ItemTemplate>
    </asp:Repeater>

</table>


<div class="hidden">
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
        <div class="col-lg-12 col-sm-12 col-xs-12 form-cell" id="trIdear" style="height: 120px" runat="server">
            <div class="form-label" style="height: 119px">
                <%=Ultimus.UWF.Common.Logic.Lang.Get("Comments")%>：
                               
            </div>
            <div class="form-content">
                <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" TextMode="MultiLine"
                    MaxLength="1000" Height="100px"></asp:TextBox>
            </div>
            <span class="hidden-xs hidden-sm hidden-md">( <%=Ultimus.UWF.Common.Logic.Lang.Get("MaxLength")%>：<asp:Label Text="0" runat="server"
                ID="reachChar" Font-Underline="true" ForeColor="Blue"> </asp:Label>
                <%=Ultimus.UWF.Common.Logic.Lang.Get("Char")%>：)<br />
            </span>
        </div>

    </div>

</div>

<div class="hidden">
    <asp:TextBox ID="txtShowAction" runat="server"></asp:TextBox>
    <asp:HyperLink ID="hyFlow" runat="server" Target="_blank"></asp:HyperLink>
</div>

