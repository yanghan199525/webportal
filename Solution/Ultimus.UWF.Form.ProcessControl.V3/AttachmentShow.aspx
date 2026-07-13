 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AttachmentShow.aspx.cs" Inherits="Ultimus.UWF.Workflow.AttachmentShow" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>

    <script type="text/javascript">

            function deleteAtt(newname, ele) {
                $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx",
                             { method: "delete", newname: newname }, function (data) {
                                 $(ele).parent().parent().remove();
                             });
            }
        function downTempFile(fileName, path) {
            var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/GetDataHandler.ashx?method=downAttachment&fileName=" + fileName + "&path=" + path;
             window.open(url);
         }

        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="overflow-y:auto;height:280px;background-color:white">
    <table class="table table-bordered table-condensed form-detail-table" style="background-color:white">
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
                            <td class="headerTD hidden">
                                <asp:Label ID="Label8" runat="server" Text="步骤名"><%=Ultimus.UWF.Common.Logic.Lang.Get("TaskList_StepName")%></asp:Label>
                            </td>
                            <td class="headerTD hidden-xs">
                                <asp:Label ID="Label5" runat="server" Text="创建人"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateBy")%></asp:Label>
                            </td>
                            <td class="headerTD" style="width:150px">
                        <asp:Label ID="Label6" runat="server" Text="创建时间"><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_CreateDate")%></asp:Label>
                    </td>
                            <td class="headerTD" id="actionRow" runat="server" visible='<%# ReadOnly?false:true %>'>
                                <asp:Label ID="Label7" runat="server" Text="操作"  visible='<%# ReadOnly?false:true %>'><%=Ultimus.UWF.Common.Logic.Lang.Get("DraftList_Operate")%></asp:Label>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="fileinfo">
                        <asp:Repeater ID="Repeater1" runat="server" >
                            <ItemTemplate>
                                <tr>
                                    <td class="hidden-xs">
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <td>
                                    <a target="_blank" onclick="downTempFile('<%# GetFileName(Eval("FileName"))%>','<%# GetUrl(Eval("ProcessName"),Eval("NEWNAME"),Eval("FileType"),Eval("CreateDate")) %>')"><%# Eval("FileName")%></a>
                                        <%--<asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("NEWNAME") %>'
                                            CommandName="Download"><%# Eval("FileName")%></asp:LinkButton>--%>
                                    </td>
                                    <td class="hidden-xs comments " style="display:none">
                                        <%# Eval("Comments")%>
                                    </td>
                                    <td class="hidden">
                                        <%# Eval("STEPNAME")%>
                                    </td>
                                    <td class="hidden-xs">
                                        <%# Eval("CreateBy")%></td>
                                    <td>
                                    <%# Eval("CreateDate")%>
                                </td>
                                    <td id="Td1" runat="server" visible='<%# ReadOnly?false:true %>'>
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="hide" Visible='<%# ReadOnly?false:false %>' CssClass="btn btn-icon btn-sm" OnClientClick="return confirm('确定要删除吗?');"
                                            CommandArgument='<%# Eval("NEWNAME") %>' CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>

                                        <a onclick="if(confirm('Delete Confirm?')){deleteAtt('<%# Eval("NEWNAME") %>',this)}" 
                                            class="btn btn-icon btn-sm"  href="javascript:void(0)" ><i class="fa fa-trash"></i></a>

                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
    </div>

        <div style="display: none">
    <asp:TextBox ID="txtReadonly" runat="server"></asp:TextBox>
</div>
        
    </form>
</body>
</html>
