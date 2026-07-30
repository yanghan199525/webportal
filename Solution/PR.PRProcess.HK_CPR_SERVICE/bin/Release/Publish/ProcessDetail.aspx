<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessDetail.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessDetail" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls"
    TagPrefix="ult" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程属性</title>
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
                            <span class="pl5 strong inline">流程详细信息</span>
                        </td>
                        <td class="pull-right">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row-fluid">
            
            <div class="span2">
                流程名称*:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtProcessName" Destination="BizDB.WF_PROCESS[ID].PROCESSNAME" 
                    runat="server" CssClass="validate[required] " />
            </div>
            <div class="span2">
                模块*:
            </div>
            <div class="span4">
                 
                        <ult:DropDownList ID="ddlModule" runat="server" Destination="BizDB.WF_PROCESS[ID].MODULE"  CssClass="validate[required] "></ult:DropDownList>

                <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="../Ultimus.UWF.Form/SolutionList.aspx?menuname=Solution">维护模块</asp:HyperLink>
            </div> 
            </div>
        <div class="row-fluid">
            <div class="span2">
                分类*:
            </div>
            <div class="span4">
                <ult:DropDownList ID="ddlCategory" DataTextField="DisplayName" DataValueField="CategoryID" Destination="BizDB.WF_PROCESS[ID].CATEGORYID" 
                    runat="server" CssClass="validate[required] " />
                <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl="ProcessCategoryList.aspx?menuname=流程分类">维护分类</asp:HyperLink>
            </div> 
            <div class="span2">
               缩写/Document No前缀*:
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox5" Destination="BizDB.WF_PROCESS[ID].SHORTNAME" 
                    runat="server" CssClass="validate[required] " />
            </div>
             </div>
        <div class="row-fluid">
            <div class="span2">
                中文名称*:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtCNNAME" Destination="BizDB.WF_PROCESS[ID].CNNAME" 
                    runat="server" CssClass="validate[required]  " />
            </div>
       
            <div class="span2">
                英文名称*:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtEnName" Destination="BizDB.WF_PROCESS[ID].ENNAME" 
                    runat="server" CssClass="validate[required]  " />
            </div>
        </div>
        
        <div class="row-fluid">
            <div class="span2">
                默认表单Url:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtSummary" Destination="BizDB.WF_PROCESS[ID].DEFAULTPCFORM" 
                    runat="server" CssClass="" placeholder="在Data Schema发布后，自动填写" />
            </div>
             <div class="span2">
                流程Owner: 
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox7" CssClass="" onclick="selectUser(2,'TextBox7','TextBox8');"  Destination="BizDB.WF_PROCESS[ID].PROCESSOWNER" 
                    runat="server" />
                <span class="hidden"><ult:TextBox ID="TextBox8" CssClass=" hidden" Destination="BizDB.WF_PROCESS[ID].PROCESSOWNERID" 
                    runat="server" /></span>
            </div>
            
        </div>
          <div class="row-fluid">
              <div class="span2">
               业务主表:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtTABLENAME" Destination="BizDB.WF_PROCESS[ID].TABLENAME" 
                    runat="server" CssClass=""  placeholder="在Data Schema发布后，自动填写"/>
            </div>
            <div class="span2">
               业务明细表:
            </div>
            <div class="span4">
                <ult:TextBox ID="txtDetailTableNames" Destination="BizDB.WF_PROCESS[ID].DETAILTABLENAMES" 
                    runat="server" CssClass=""  placeholder="在Data Schema发布后，自动填写"/>
            </div>
        </div>
        
         <div class="row-fluid">
            <div class="span2">
              <label for="TextBox4"> 业务流程报表显示:</label>
            </div>
            <div class="span4">
                <ult:CheckBox ID="TextBox4" Checked="true"  Destination="BizDB.WF_PROCESS[ID].HASREPORT" 
                    runat="server" />
            </div> 
            <div class="span2">
              <label for="CheckBox1">在新建申请中隐藏:</label>
            </div>
            <div class="span4">
                <ult:CheckBox ID="CheckBox1" Checked="true"  Destination="BizDB.WF_PROCESS[ID].UnEnbleStart" 
                    runat="server" />
            </div>
        </div>
         
        <div class="row-fluid">
            <div class="span2">
              <label for="TextBox4"> 图标:</label>
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox6" CssClass="" Destination="BizDB.WF_PROCESS[ID].ICON" 
                    runat="server" />
            </div>
            <div class="span2">
              <label for="TextBox4"> Namespace:</label>
            </div>
            <div class="span4">
                <ult:TextBox ID="txtNamespace" CssClass=""  Enabled="false"
                    runat="server" />
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2">
              <label for="TextBox4"> 排序:</label>
            </div>
            <div class="span4">
                <ult:TextBox ID="TextBox2" CssClass="" Destination="BizDB.WF_PROCESS[ID].ORDERNO" 
                    runat="server" />
            </div>
            <div class="span2">
              
            </div>
            <div class="span4">
            </div>
                 
        </div>
        <hr />
        <div class="row-fluid center">
            <ult:BtnLoadForm ID="BtnLoadForm1" runat="server" />
            <ult:BtnSave ID="BtnSave2" runat="server" CssClass="btn btn-primary"   OnBeforeClick="BtnSave2_BeforeClick"
                OnClientClick="attachValidation();" OnAfterClick="BtnSave2_AfterClick" />
             
            <ult:BtnDelete ID="btnDelete1" runat="server" CssClass="btn"  OnAfterClick="btnDelete1_AfterClick"
                 OnClientClick="return ask('您确定要删除吗?');" />
            <a class="btn btn-default hidden" href="javascript:window.close();"><i class="icon-chevron-left">
            </i>关闭</a>
            <asp:Button ID="btnExport" runat="server" Text="导出为SQL" CssClass="btn" OnClick="btnExport_Click" />
            <asp:Button ID="btnClear" runat="server" Text="清除缓存" CssClass="btn" OnClick="btnClear_Click" />
            <a class="btn btn-default " href="ProcessStepList.aspx?PROCESSNAME=<%=Request.QueryString["pname"] %>">维护步骤<i class="icon-chevron-right">
            </i></a>
        </div>
        <div class="hidden">
            <ult:TextBox ID="TextBox1" Source="KeyWords.MaxID.BizDB.WF_PROCESS.ID" Destination="BizDB.WF_PROCESS[ID].ID"
                 runat="server"></ult:TextBox>
            <ult:TextBox ID="txtDISPLAYNAME" Source="KeyWords.MaxID.BizDB.WF_PROCESS.DISPLAYNAME" Destination="BizDB.WF_PROCESS[ID].DISPLAYNAME"
                 runat="server"></ult:TextBox>
        </div>
    </div>
    </form>
</body>
</html>
