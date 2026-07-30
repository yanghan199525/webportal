<%@ Page Language="C#" AutoEventWireup="true" Inherits="Ultimus.UWF.AddSign.Approval" CodeBehind="Approval.aspx.cs" %>

<%@ Register Src="../../../Portal/Ultimus.UWF.Workflow/AddSign/UserInfo_AddSign.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../../Portal/Ultimus.UWF.Workflow/AddSign/ApprovalHistory_AddSign.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../../Portal/Ultimus.UWF.Workflow/AddSign/ButtonList_AddSign.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>加签流程 Add Sign </title>
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>

    <style  type="text/css">        
      
    </style>
    <script type="text/javascript" language="javascript">  
        //function ifonload()
        //{
        //    this.style.height = Math.max(this.contentWindow.document.body.scrollHeight, this.contentWindow.document.documentElement.scrollHeight, 200) + "px";

        //}
     </script>
</head>
<body style="background-color:#f5f5f5">
    <form id="form1" runat="server"  >   
      <div  style="display:none;">
          <ui:UserInfo id="UserInfo1" processtitle="" processprefix="" tablename="WF_ADDSIGN"
            tablenamedetail="" runat="server" ReadOnly="true"></ui:UserInfo>
      </div>    
      <iframe  id="PIframe" runat="server" width="100%"  scrolling="no" frameborder="0"  
          style="background-color:#eaecee;margin:0 0 -1px;"  >
      </iframe>       
      <div >
             <div style="padding-top:10px;padding-left:14px;padding-right:18px;">
              <center>
                <div class="info">
                    <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
                    <btn:buttonlist id="ButtonList1" runat="server"  ></btn:buttonlist>
                    <div style="display:none;">
                        <asp:Label ID="read_PARENTSUMMARY"  runat="server"   />
                         <asp:Label ID="read_PARENTPROCESSNAME" runat="server" CssClass="" ReadOnly="true"></asp:Label>
                         <asp:Label ID="read_PARENTINCIDENT" runat="server" CssClass="" ReadOnly="true"></asp:Label>
                        <asp:TextBox ID="read_PARENTTASKID" runat="server"></asp:TextBox>
                        <asp:TextBox ID="var_PageURL" runat="server" Text=""></asp:TextBox>
            
                    </div>
                    </div>
              </center>
              </div>
      </div>
    </form>
                    <div style="padding-bottom:20px;"></div>
                    <div style="padding-bottom:50px;background-color:#fff;"></div>
</body>
</html>