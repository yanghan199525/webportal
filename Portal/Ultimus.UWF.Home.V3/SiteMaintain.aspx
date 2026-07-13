<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SiteMaintain.aspx.cs" Inherits="Ultimus.UWF.Home.V3.SiteMaintain" %>
<%@ Register assembly="Ultimus.UWF.Form" namespace="Ultimus.UWF.Form.WebControls" tagprefix="cc1" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0"/>
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management"/>
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>数采分店维护</title>
    <!-- ========== Css Files ========== -->
    <link href="../../common/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
      <div style="margin-left:5%"> <h4> <span class="btn btn-rounded btn-default btn-icon cursor-default"> <i class="fa fa-envelope-o"></i></span> 数采分店维护列表</h4></div>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-3" >
                    <asp:FileUpload ID="ExcelFileUpload" runat="server" />
                </div>
                <div class="col-lg-3" style="text-align:left">
                    <asp:Button class="btn btn-success" ID="UploadBtn" runat="server" Text="确定上传" OnClick="UploadBtn_Click" />
                </div>
                <div class="col-lg-4"></div>
            </div> 
         </div>
         <table class="table table-condensed table-bordered">
                                    <thead>
                                        <tr>
                                          <th>送货地址</th>
                                          <th>分店编号</th>
                                          <th>分店名称</th>
                                          <th>分店经理</th>
                                        </tr>
                                      </thead>
                             <asp:Repeater ID="Repeater1" runat="server" >
                                 <ItemTemplate>
                                     
                                      <tbody>
                                        <tr>
                                          <td><%# Eval("address") %></td>
                                          <td><%# Eval("siteCode") %></td>
                                             <td><%# Eval("siteName") %></td>
                                          <td><%# Eval("siteManage") %></td>
                                        </tr>
                                      </tbody>
                             </ItemTemplate>
                        </asp:Repeater>

                </table>
    </form>
</body>
</html>
