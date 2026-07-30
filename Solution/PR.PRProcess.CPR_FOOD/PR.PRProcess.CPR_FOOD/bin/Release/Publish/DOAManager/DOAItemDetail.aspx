<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DOAItemDetail.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.DOAManager.DOAItemDetail" ValidateRequest="false" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls"
    TagPrefix="ult" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>审批权限详细信息/ DOA Info</title>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <%=WebUtil.IncludeFiles() %>
    <script type="text/javascript">
      function closeWin() {
            window.opener.$("#btnLoadList").click();
            window.opener = null;
            window.open('', '_self');
            window.close();
            return false;
      }
   </script>
</head>
<body>
    <form id="form1" runat="server">
       
            <div class=" container ">
                <div class="row">
                <table class="table table-condensed table-bordered">              
                    <tr>
                        <td  style="width:99%" colspan="4">审批权限详细信息/ DOA Info
                        </td>                        
                    </tr>           
                    <tr>
            <td  style="width:30px;background-color:#f5f5f5;text-align:right !important;">
                流程名称 :
            </td>            
            <td style="width:30%">
                <asp:DropDownList ID="drpPROCESSNAME"   runat="server" CssClass="validate[required] "  AutoPostBack="true" OnSelectedIndexChanged="drpPROCESSNAME_SelectedIndexChanged">

                </asp:DropDownList>
            </td>
            
            <td style="width:50px;background-color:#f5f5f5;text-align:right !important;">
                名称 :
            </td>
            <td style="width:30%"> 
                <ult:TextBox ID="txtRMCODE" Destination="BizDB.WF_DOAITEM[ID].ITEMNAME" 
                    runat="server" CssClass="validate[required] " />
            </td>
            </tr>
                    <tr >
            <td class="td-label">
                审批权限说明:
            </td>
            <td class="td-content">
               <ult:TextBox ID="txtRemark" Destination="BizDB.WF_DOAITEM[ID].REMARK" 
                    runat="server" CssClass="validate[required] td-content" />
            </td>
       <td class="td-label">
                是否启用:
            </td>               
            <td class="td-content">
                <asp:CheckBox ID="ckISACTIVE"  Checked="true" 
                    runat="server" CssClass="td-content" />
            </td>  
                  
        </tr>    
                    <tr >
                    <td class="td-label" style="width:20%">
                权限表达式<br />(SQL Where语句):
            </td>
            <td  colspan="3" >
                <asp:TextBox ID="txtITEMExpression" TextMode="MultiLine"   Rows="3"
                    runat="server" CssClass=""  style="width:90%"/>
            </td>        
        </tr>                  
                    <tr>
                        <div runat="server" id="tr1"  visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT01" runat="server" Text="EXT01"></asp:Label>
                        </td>
                        <td class="td-content"  >
                            <asp:TextBox ID="txtEXT01" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT01"></asp:TextBox>
                        </td>
                        </div>
                    
                        <div runat="server" id="tr2" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT02" runat="server" Text="EXT02"></asp:Label>
                        </td>
                        <td class="td-content" >
                            <asp:TextBox ID="txtEXT02" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT02"></asp:TextBox>
                        </td>
                         </div>
                    </tr>
                    <tr >
                        <div runat="server" id="tr3" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT03" runat="server" Text="EXT03"></asp:Label>
                        </td>
                        <td class="td-content" >
                            <asp:TextBox ID="txtEXT03" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT03"></asp:TextBox>
                        </td>
                            </div>
                    <div runat="server" id="tr4" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT04" runat="server" Text="EXT04"></asp:Label>
                        </td>
                        <td class="td-content"  >
                            <asp:TextBox ID="txtEXT04" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT04"></asp:TextBox>
                        </td>
                    </div></tr>
                    <tr>
                    <div runat="server" id="tr5" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT05" runat="server" Text="EXT05"></asp:Label>
                        </td>
                        <td class="td-content" >
                            <asp:TextBox ID="txtEXT05" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT05"></asp:TextBox>
                        </td>
                    </div>
                    <div runat="server" id="tr6" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT06" runat="server" Text="EXT06"></asp:Label>
                        </td>
                        <td class="td-content"  >
                            <asp:TextBox ID="txtEXT06" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT06"></asp:TextBox>
                        </td>
                    </div> 
                   </tr>
                    <tr>
                    <div runat="server" id="tr7" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT07" runat="server" Text="EXT07"></asp:Label>
                        </td>
                        <td class="td-content" >
                            <asp:TextBox ID="txtEXT07" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT07"></asp:TextBox>
                        </td>
                    </div>
                    <div runat="server" id="tr8" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT08" runat="server" Text="EXT08"></asp:Label>
                        </td>
                        <td class="td-content"  >
                            <asp:TextBox ID="txtEXT08" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT08"></asp:TextBox>
                        </td>
                    </div>
             </tr>
                    <tr runat="server" id="tr9" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT09" runat="server" Text="EXT09"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <asp:TextBox ID="txtEXT09" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT09"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr10" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT10" runat="server" Text="EXT10"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <asp:TextBox ID="txtEXT10" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT10"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr11" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT11" runat="server" Text="EXT11"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <asp:TextBox ID="txtEXT11" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT11"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr12" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT12" runat="server" Text="EXT12"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <asp:TextBox ID="txtEXT12" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT12"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr13" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT13" runat="server" Text="EXT13"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <asp:TextBox ID="txtEXT13" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT13"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr14" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT14" runat="server" Text="EXT14"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <ult:TextBox ID="txtEXT14" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT14"></ult:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="tr15" visible="false">
                        <td class="td-label">
                            <asp:Label ID="lblEXT15" runat="server" Text="EXT15"></asp:Label>
                        </td>
                        <td class="td-content" colspan="3" >
                            <asp:TextBox ID="txtEXT15" runat="server" Destination="BizDB.WF_DOAITEM[ID].EXT15"></asp:TextBox>
                        </td>
                    </tr> 
                    <tr >
            <td class="td-label" style="width:20%">
                审批步骤:
            </td>
            <td  colspan="3" >
                <ult:CheckBoxList ID="cklSelectReturnStep" runat="server" RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" Destination="BizDB.WF_DOAITEM[ID].APPROVALVALUE" Separator='|'></ult:CheckBoxList>     

            </td>        
        </tr> 
                    <tr style="display:none;">
                    <td class="td-label">
                       测试审批权限表达式:
                    </td>
                    <td class="td-content">
                        <asp:TextBox ID="txtTableName"  runat="server" CssClass="td-content"  placeholder="表名"/> 
                        <asp:Button ID="Button1" runat="server" Text="Test"  OnClick="Button1_Click"/>
                        <asp:Label ID="Msg" runat="server" Text="Label"></asp:Label>
                    </td>            
        </tr>           
                   
                    <tr class="row-fluid center">
                        <td colspan="3">
                        <ult:BtnLoadForm ID="BtnLoadForm1" runat="server" />
                        <asp:Button ID="BtnSave" runat="server" CssClass="btn btn-primary"    
                        OnClick="BtnSave_Click"   Text="保存"    OnClientClick="attachValidation();"  />
                        <ult:BtnSaveAndClear ID="BtnSave1" runat="server" CssClass="btn" 
                            OnClientClick="attachValidation();" />
                        <ult:BtnDelete ID="btnDelete1" runat="server" CssClass="btn"  
                            RedirectPage="DOAList.aspx" OnClientClick="return ask('您确定要删除吗?');" />
                        <a class="btn btn-default" href="javascript:window.close();"><i class="icon-chevron-left">
                        </i>关闭</a>
                            </td>
                    </tr>
                    <tr class="hidden">
                        <td>
                        <ult:TextBox ID="TextBox1" Source="KeyWords.MaxID.BizDB.WF_DOAITEM.ID" Destination="BizDB.WF_DOAITEM[ID].ID"
                             runat="server"></ult:TextBox>
                        <ult:TextBox ID="txtDOAID" Destination="BizDB.WF_DOAITEM[ID].DOAID"
                             runat="server"></ult:TextBox>
                            </td>

                    </tr>
    </table>
                </div></div>
            
    </form>
</body>
</html>
