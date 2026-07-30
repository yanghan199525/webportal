<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DOAList.aspx.cs" Inherits="Ultimus.UWF.Workflow.DOAManager.DOAList" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>DOA List</title>
  <%--  <script src="../../../../js/jquery.js" type="text/javascript"></script>
    <script src="../js/selector.js" type="text/javascript"></script>
    <script src="../../../../Js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="../../../../js/languages/jquery.validationEngine-zh_CN.js" type="text/javascript"></script>
    <script src="../../../../js/jquery.validationEngine.js" type="text/javascript"></script>--%>
    <%=WebUtil.IncludeFiles() %>    
     <script type="text/javascript" language="javascript">
         function ShowDia(DOAID, ID) {
            var iWidth = "1000";      //弹出窗口的宽度;
            var iHeight = "500";      //弹出窗口的高度; 
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;       //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;           //获得窗口的水平位置;
            window.open("DOAItemDetail.aspx?DOAID=" + DOAID + "&ID=" + ID + "", "", "height=" + iHeight + ",width=" + iWidth + ",top=" + iTop + ",left=" + iLeft + ",scrollbars=yes,resizable=yes ");
         }
         function ADDDia(DOAID,TYPE) {
             var iWidth = "1000";      //弹出窗口的宽度;
             var iHeight = "500";      //弹出窗口的高度; 
             var iTop = (window.screen.availHeight - 30 - iHeight) / 2;       //获得窗口的垂直位置;
             var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;           //获得窗口的水平位置;
             window.open("DOAItemDetail.aspx?DOAID=" + DOAID+"&TYPE=" +TYPE+"", "", "height=" + iHeight + ",width=" + iWidth + ",top=" + iTop + ",left=" + iLeft + ",scrollbars=yes,resizable=yes ");
         }
        function Delete() {
            if (confirm("是否确认删除")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="display: none;">
            <asp:Button ID="btnLoadList" runat="server" Text="LoadList" OnClick="btnLoadList_Click" />
        </div>
        <div class="pt10">
            <div class="row-fluid">
                <div class="span4" style="width: 17%">  
                    <asp:Literal ID="litType" runat="server" Text="类型："></asp:Literal>
                    <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="ddlType_SelectedIndexChanged" style=" width:80%;">                        
                        <asp:ListItem Value="0">流程</asp:ListItem>
                        <asp:ListItem Value="1">岗位</asp:ListItem>
                        <asp:ListItem Value="2" Selected="True">自定义</asp:ListItem>                       
                    </asp:DropDownList>                   
                    <div style="overflow: scroll; border: 1px solid; height: 480px;">
                        <asp:TreeView ID="tvFunction" runat="server" OnSelectedNodeChanged="tvFunction_SelectedNodeChanged" ShowLines="True">
                            <SelectedNodeStyle Font-Bold="true" />
                        </asp:TreeView>
                    </div>
                     <asp:Button ID="btnAddNode" runat="server" Text="新增审批权限" CssClass="btn btn-primary" OnClick="btnAddNode_Click" />
                </div>
                <div class="span4" style="float: right; width: 80%;" id="divInfo" runat="server" visible="false">
                    <table class="table table-condensed table-bordered">
                        <tr>
                            <td class="banner" colspan="2">审批权限
                            </td>
                        </tr>
                         <tr runat="server" visible="true">
                            <td class="td-label"><span style="color: red">*</span>父节点：
                            </td>
                            <td class="td-content">
                                <asp:HiddenField ID="hidParentNodeId" runat="server" />
                                <asp:TextBox ID="txtParentNodeName" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                       
                            <td class="td-label"><span style="color: red">*</span>名称：
                            </td>
                            <td class="td-content">
                                <asp:HiddenField ID="hfNew" runat="server" />
                                <asp:TextBox ID="txtJobFunction" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr runat="server" visible="true">
                            <td class="td-label"><span style="color: red">*</span>编号：
                            </td>
                            <td class="td-content">
                                <asp:TextBox ID="txtFunctionCode" runat="server"></asp:TextBox>
                            </td>
                            <td class="td-label">是否有效：
                            </td>
                            <td class="td-content" colspan="3">
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked="TRUE" />是
                            </td>
                          </tr> 
                        <tr>
                            <td class="td-label">授权成员： 
                            </td>
                            <td class="td-content" colspan="3">
                                <asp:TextBox ID="txtMember" TextMode="MultiLine" Rows="3" Width="80%" runat="server"></asp:TextBox>
                                <%--<asp:Button ID="Button1" runat="server" Text="..." CssClass="btn btn-primary" onclick="selectUser(0,'txtMember','hidmeberID');"/>--%>
                                <button type="button" class="btn" onclick="selectUser(2,'txtMember','hidmeberID');">...</button>
                            </td>
                            <asp:HiddenField ID="hidmeberID" runat="server" />
                        </tr>
                             <tr>
                            <td colspan="4">
                                <table class=" table table-hover table-bordered table-condensed listTable" style="width: 100%; overflow: hidden;">
                                    <thead>
                                        <tr class="bg">

                                            <th style="width:10%">序号
                                            </th>
                                            <th>条件中文名称
                                            </th>
                                            <th>条件英文名称
                                            </th>                                           
                                            <th>操作
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbody1">
                                        <asp:HiddenField ID="hfColumns" runat="server" Value="id,EXTINDEX,EXTKEY,EXTNAME" />
                                        <asp:Repeater ID="rep_Conditions" runat="server" OnItemCommand="rep_Conditions_ItemCommand">
                                            <ItemTemplate>
                                                <tr class="TableDataRow">
                                                    <td style="text-align: center;width:10%">
                                                        <asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ID") %>' />
                                                        <asp:TextBox ID="txtEXTINDEX" runat="server" Text='<%# Eval("EXTINDEX") %>' style="text-align: center;width:80%"></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <asp:TextBox ID="txtEXTKEY" runat="server" Text='<%# Eval("EXTKEY") %>'></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <asp:TextBox ID="txtEXTNAME" runat="server" Text='<%# Eval("EXTNAME") %>'></asp:TextBox>
                                                    </td>                                                                                                      
                                                    <td style="text-align: center">
                                                        <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return   confirm('您确定删除此列扩展条件吗，关联此条件的值将删除！');" CommandArgument='<%#Eval("ID") %>' CommandName="Delete"><%=Lang.Get("SecurityList_Delete") %></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                    <span style="color: red">*序号请填写1~15的数字，不能重复。</span>
                                </table>
                                <div style="text-align: right">
                                    <asp:Button ID="btnAddRow" runat="server" CssClass="btn btn-primary" Text="新增/Add" OnClick="btnAddRow_Click" />
                                </div>
                            </td>
                        </tr>                                         
                        <tr>
                            <td colspan="4" style="text-align: center">
                                <asp:HiddenField ID="hidId" runat="server" />
                                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                                <asp:Button ID="Button2" runat="server" Text="返回" CssClass="btn btn-primary" OnClick="Button2_Click" />                                
                            </td>
                        </tr>
                    </table>
                </div>


                <div class="span4" style="float: right; width: 80%;" id="div1" runat="server" visible="false">
                    <table class="table table-condensed table-bordered">
                        <tr>
                            <td class="banner" colspan="3">详细信息
                            </td>
                            <td style="text-align: right" class="banner">
                                  <asp:Button ID="btnEditFunction"  runat="server" Text="编辑审批权限" CssClass="btn btn-primary" OnClick="Button4_Click" />
                    <asp:Button ID="btnDeleteNode" runat="server" Text="删除审批权限" CssClass="btn btn-primary" OnClientClick="return confirm('您确定要删除吗，关联此下的审批表都将删除！');" OnClick="btnDeleteNode_Click" />
                      
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">权限名称：
                            </td>
                            <td class="td-content">
                                <asp:HiddenField ID="hidFunctionName" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <asp:Label ID="lbDOAName" runat="server"></asp:Label>
                            </td>
                       
                            <td class="td-label">权限编号：
                            </td>
                            <td class="td-content">
                                <asp:Label ID="lblFunctionCode" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">是否有效：
                            </td>
                            <td class="td-content" colspan="3">
                                <asp:Label ID="Label4" runat="server" Text="是"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">授权成员： 
                            </td>
                            <td class="td-content" colspan="3">
                                <asp:Label ID="TextBox5" TextMode="MultiLine" Rows="3" Width="80%" runat="server" CssClass="input-medium"></asp:Label>
                            </td>
                        </tr>
                       
                       
                    </table>
                </div>
                
                <div style="float: right; width: 80%;" id="divDetail" runat="server" visible="false">
                    <table class="table table-condensed table-bordered">
                        <tr>
                            <td class="banner" style="width: 60%">
                                <asp:Label ID="lblTitle" runat="server" Text="" Visible="false"></asp:Label><asp:TextBox ID="txtKeyWord"  placeholder="输入岗位名称、说明 进行模糊搜索" runat="server"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="查询" OnClick="btnSearch_Click" class="btn btn-primary" />
                            </td>
                            <td style="text-align: right" class="banner">
                                <a onclick="ADDDia('<%=Server.UrlEncode(hfTreeId.Value) %>','<%=Server.UrlEncode(hfTreeType.Value) %>')" href="javascript:void(0);" class="btn btn-primary">增加权限表达式</a>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <div style="overflow-x:hidden; overflow-y: scroll; height: 450px;" id="divFunction"
                                    runat="server">
                                    <table class=" table table-hover table-bordered table-condensed listTable" style="width: 100%; overflow: hidden;">
                                        <thead>
                                            <tr class="bg">
                                                <th style="width: 65px">操作
                                                </th>
                                                <%--  <th>
                                                    <asp:CheckBox ID="cbk_all" runat="server" />
                                                </th>
                                                <th>No.
                                                </th>--%>
                                                <th>流程名称
                                                </th>
                                                <th style="width: 65px">名称
                                                </th>                                                
                                               
                                                 <%=GetTitle(hfTreeId.Value) %>
                                                <th>权限表达式
                                                </th>
                                                  <th>步骤
                                                </th>
                                                <th>权限介绍
                                                </th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody id="tbody">
                                            <asp:Repeater ID="rep_DOAITEM" runat="server" OnItemCommand="rep_Function_ItemCommand">
                                                <ItemTemplate>
                                                    <tr class="TableDataRow">
                                                        <%--<td style="text-align: center">
                                                            <asp:CheckBox ID="cbk_select" runat="server" />
                                                          
                                                        </td>
                                                        <td style="text-align: center">
                                                            <%# Container.ItemIndex+1 %>
                                                        </td>--%>
                                                        <td style="text-align: center">
                                                            <a onclick="ShowDia('<%#Eval("DOAID") %>','<%#Eval("ID") %>')" href="javascript:void(0);" 
                                                                >编辑</a>&nbsp;&nbsp;                                 
                                                            <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return Delete();" CommandArgument='<%#Eval("ID") %>' CommandName="Delete"><%=Lang.Get("SecurityList_Delete") %></asp:LinkButton>
                                                        </td>
                                                         <td style="text-align: center">
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("PROCESSNAME") %>'></asp:Label>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <asp:HiddenField ID="hfID" Value='<%# Eval("ID") %>' runat="server" />
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ITEMNAME") %>'></asp:Label>
                                                        </td>
                                                          <%# GetValue(Eval("ID").ToString(),Eval("DOAID").ToString()) %>
                                                        <td style="text-align: center">
                                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("ITEMExpression") %>'></asp:Label>
                                                        </td>
                                                           <td style="text-align: center">
                                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("APPROVALVALUE") %>'></asp:Label>
                                                        </td>  
                                                        <td style="text-align: center">
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("REMARK") %>'></asp:Label>
                                                        </td>                                                   
                                                        
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                        <tr>
                                            <td colspan="25" style="text-align: left; padding: 5px;">
                                                <webdiyer:AspNetPager ID="AspNetPager" runat="server" CustomInfoHTML="Count %RecordCount%"
                                                    HorizontalAlign="left" Width="100%" CssClass="aspNetPager" OnPageChanged="AspNetPager_PageChanged"
                                                    PageSize="10" AlwaysShow="true" SubmitButtonStyle="display:none" InputBoxStyle="display:none"
                                                    NextPageText="下一页" FirstPageText="首页" LastPageText="末页" PrevPageText="上一页">
                                                </webdiyer:AspNetPager>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <asp:HiddenField ID="hfFunctionName" runat="server" />
                    <asp:HiddenField ID="hfTreeId" runat="server" />
                    <asp:HiddenField ID="hfDOANewid" runat="server" />
                    <asp:HiddenField ID="hfTreeType" runat="server" Value="1" />                   
                </div>
              
            </div>
        </div>
    </form>
</body>
</html>
