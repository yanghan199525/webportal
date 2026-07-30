<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessStepRecipientDetail.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessStepRecipientDetail" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls"
    TagPrefix="ult" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <%=WebUtil.IncludeFiles() %>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12 breadcrumb mb0">
                <table width="100%">
                    <tr>
                        <td width="10">
                            <i class="icon-th-large"></i>
                        </td>
                        <td width="200">
                            <span class="pl5 strong inline">流程步骤详细信息</span>
                        </td>
                        <td class="pull-right">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
         <div class="row-fluid">
            <div class="span4">
                模块:
            </div>
            <div class="span8">
                <ult:TextBox ID="txtMODULE" Destination="BizDB.COM_INTERFACE_CLASS[ID].MODULE" 
                    runat="server" CssClass="validate[required] span8" />
            </div>
            </div>
         <div class="row-fluid">
            <div class="span4">
                接口:
            </div>
            <div class="span8">
                <ult:TextBox ID="TextBox4" Destination="BizDB.COM_INTERFACE_CLASS[ID].INTERFACENAME" 
                    runat="server" CssClass="validate[required] span8" />
            </div>
            </div>
        <div class="row-fluid">
            <div class="span4">
                类名称:
            </div>
            <div class="span8">
                <ult:TextBox ID="txtCODE" Destination="BizDB.COM_INTERFACE_CLASS[ID].CODE" 
                    runat="server" CssClass="validate[required] span8" />
            </div>
            </div>
        <div class="row-fluid">
            <div class="span4">
                类说明:
            </div>
            <div class="span8">
               <ult:TextBox ID="TextBox3" Destination="BizDB.COM_INTERFACE_CLASS[ID].NAME" 
                    runat="server" CssClass="validate[required] span8" />
            </div>
        </div>
         <div class="row-fluid">
            <div class="span4">
                类路径:
            </div>
            <div class="span8">
                <ult:TextBox ID="txtAPPROVERVARIABLE" Destination="BizDB.COM_INTERFACE_CLASS[ID].CLASSNAME" 
                    runat="server" CssClass="span8" />
            </div>            
        </div>
         <div class="row-fluid">
            <div class="span4">
                方法参数:
            </div>
            <div class="span8">
               <ult:TextBox ID="TextBox2" Destination="BizDB.COM_INTERFACE_CLASS[ID].PARAMETERS" 
                    runat="server" CssClass="span8" />
                <asp:Button ID="Button1" runat="server" Text="Get"  OnClick="Button1_Click" style="display : ;"/>
            </div>            
        </div>
        <div class="row-fluid">
            <div class="span4">
               是否激活:
            </div>
            <div class="span8">
               <ult:CheckBox ID="txtISACTIVE" Destination="BizDB.COM_INTERFACE_CLASS[ID].ISACTIVE" 
                    runat="server" CssClass="span8" />                
            </div>            
        </div>
        <hr />
        <div class="row-fluid center">
            <ult:BtnLoadForm ID="BtnLoadForm1" runat="server" />
            <ult:BtnSave ID="BtnSave2" runat="server" CssClass="btn btn-primary"    
                OnAfterClick="BtnSave2_AfterClick"  OnClientClick="attachValidation();"  />
             
            <ult:BtnDelete ID="btnDelete1" runat="server" CssClass="btn"  
                RedirectPage="ProcessStepRecipientList.aspx" OnClientClick="return ask('您确定要删除吗?');" />
            <a class="btn btn-default" href="javascript:history.go(-1);"><i class="icon-chevron-left">
            </i>返回</a>
        </div>
        <div class="hidden">
            <ult:TextBox ID="TextBox1" Source="KeyWords.MaxID.BizDB.COM_INTERFACE_CLASS.ID" Destination="BizDB.COM_INTERFACE_CLASS[ID].ID"
                 runat="server"></ult:TextBox>

        </div>
    </div>
    </form>
</body>
</html>
