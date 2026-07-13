<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PrintCirculationUserInfo.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.PrintCirculationUserInfo" %>
<div class="panel hidden"><%=Ultimus.UWF.Common.Logic.Lang.Get("传阅记录")%></div>
<!--Start detail table-->
<table border='1' style='border-collapse: collapse; width: 100%;display:none'>
    <thead>
        <tr>
            <td style="width: 71px; min-width: 71px; max-width: 71px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("No")%></td>
            <td style="width: 202px; min-width: 202px; max-width: 202px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("CirculatedPeople") %></td>
            <td class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_Opinion") %></td>
            <td style="width: 71px; min-width: 71px; max-width: 71px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("TaskList_Status") %></td>
            <td style="width: 120px; min-width: 120px; max-width: 120px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy") %></td>
            <td style="width: 150px; min-width: 150px; max-width: 150px" class="thlbl"><%=Ultimus.UWF.Common.Logic.Lang.Get("CreationTime") %></td>

        </tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OldReadsRep" runat="server">
            <ItemTemplate>
                <tr>
                    <td>
                        <%# Container.ItemIndex+1 %>
                    </td>
                    <td>
                        <%# Eval("READUSERNAME") %>
                    </td>
                    <td style="word-break:break-all" >
                        <%# Eval("OPINION") %>
                    </td>
                    <td>
                        <%# Eval("READFLAG").ToString().Trim()=="1"?"已阅":"待阅" %>
                    </td>
                    <td>
                        <%# Eval("APPLICANTNAME") %>
                    </td>
                    <td>
                        <%# Eval("STARTTIME") %>
                    </td>

                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </tbody>
</table>
<asp:TextBox ID="txtCirDeleteGuid" CssClass="hidden" runat="server"></asp:TextBox>