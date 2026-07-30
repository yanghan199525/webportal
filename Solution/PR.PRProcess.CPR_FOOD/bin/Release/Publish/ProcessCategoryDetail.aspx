<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessCategoryDetail.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessCategoryDetail" %>

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
                            <span class="pl5 strong inline">流程分类详细信息</span>
                        </td>
                        <td class="pull-right">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2">
                中文名称:
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox2" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].DISPLAYNAME" 
                    runat="server" CssClass="validate[required] " />
            </div>
            <div class="span2">
                英文名称:
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox3" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].CATEGORYNAME" 
                    runat="server" CssClass="validate[required] " />
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2">
                排序:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtSummary" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].ORDERNO" 
                    runat="server" CssClass="validate[custom[integer]] " />
            </div>
            <div class="span2">
                图标:
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox4" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].ICON" 
                    runat="server" CssClass="" />
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2">
                模块:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtModule" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].MODULE" 
                    runat="server" CssClass="validate[required] " />
            </div>
            <div class="span2">
                
            </div>
            <div class="span4">
                 
            </div>
        </div>
        <hr />
        <div class="row-fluid center">
            <ult:BtnLoadForm ID="BtnLoadForm1" runat="server" />
            <ult:BtnSave ID="BtnSave2" runat="server" CssClass="btn btn-primary"  
                RedirectPage="ProcessCategoryList.aspx" OnClientClick="attachValidation();" />
            <ult:BtnSaveAndClear ID="BtnSave1" runat="server" CssClass="btn" 
                OnClientClick="attachValidation();" />
            <ult:BtnDelete ID="btnDelete1" runat="server" CssClass="btn"  
                RedirectPage="ProcessCategoryList.aspx" OnClientClick="return ask('您确定要删除吗?');" />
            <a class="btn btn-default" href="ProcessCategoryList.aspx"><i class="icon-chevron-left">
            </i>返回</a>
        </div>
        <div class="hidden">
            <ult:TextBox ID="TextBox1" Source="KeyWords.MaxID.BizDB.WF_PROCESSCATEGORY.ID" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].ID"
                 runat="server"></ult:TextBox>
           <ult:TextBox ID="txtCategoryid" Destination="BizDB.WF_PROCESSCATEGORY[CATEGORYID].CATEGORYID"
                 runat="server"></ult:TextBox>

        </div>
    </div>
    </form>
</body>
</html>
