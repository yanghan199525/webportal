<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetCOOByOd.aspx.cs" Inherits="Ultimus.UWF.Home.V3.SetCOOByOd" %>

<%@ Register assembly="Ultimus.UWF.Form" namespace="Ultimus.UWF.Form.WebControls" tagprefix="cc1" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0"/>
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management"/>
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>通过OD配置COO列表</title>
    <!-- ========== Css Files ========== -->
    <link href="../../common/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
            <div style="margin-left:5%"> <h4> <span class="btn btn-rounded btn-default btn-icon cursor-default"> <i class="fa fa-envelope-o"></i></span> 通过OD配置COO列表</h4></div>
     
     <form id="form1" runat="server" style="width:100%">
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
            <div class="row" style="margin-top:2%">
                <div class="col-lg-4" >
                   <span style="font-size:16px;padding-right:3%">用户编号:</span>
                      <asp:TextBox ID="txt_EMPNO" runat="server"  Destination="EMPNO" Width="70%" Height="30px"></asp:TextBox>
                </div>
                <div class="col-lg-4" style="text-align:left">
                     <span style="font-size:16px;padding-right:3%">ND编号:</span>
                      <asp:TextBox ID="txt_ND" data-type="string" runat="server" Destination="ND" Width="70%" Height="30px">
                            </asp:TextBox>
                </div>
                <div class="col-lg-4">
                     <asp:Button ID="btn_Search" runat="server" Text="查询" CssClass="btn btn-default " OnClick="btn_Search_Click"/>
                </div>
            </div>
        </div>
     <%--     <div class="panel-body" style="margin:2% 5% 2%;">
         <div class="col-lg-4 col-sm-6 col-xs-12 padding-b-5" >
                    <div class="form-group">
                        <div class="col-md-4">
                            用户名:
                        </div>
                        <div class="col-md-8">
                           
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 col-xs-12 padding-b-5">
                    <div class="form-group">
                        <div class="col-md-4">
                           
                        </div>
                        <div class="col-md-8">
                         
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 col-xs-12 padding-b-5">
                   
                </div>
              </div>--%>
                  <table class="table table-hover">
                                    <thead>
                                        <tr>
                                          <th>用户编号</th>
                                          <th>ND编号</th>
                                        </tr>
                                      </thead>
                             <asp:Repeater ID="Repeater1" runat="server" >
                                 <ItemTemplate>
                                     
                                      <tbody>
                                        <tr>
                                          <td><%# Eval("EMPNO") %></td>
                                          <td><%# Eval("ND") %></td>
                                        </tr>
                                      </tbody>
                             </ItemTemplate>
                        </asp:Repeater>

                </table>
        <div class="pull-right">
               <webdiyer:AspNetPager ID="AspNetPager1" runat="server" PageSize="2" 
                        AlwaysShow="true" OnPageChanged="AspNetPager1_PageChanged"
                        ShowCustomInfoSection="Right" FirstPageText="首页" LastPageText="尾页"
                        PrevPageText="上一页" NextPageText="下一页"
                        CustomInfoHTML="一共%RecordCount%条数据   第<font color='red'><b>%CurrentPageIndex%</b></font>页，共%PageCount%页.">
                    </webdiyer:AspNetPager>
            </div>
         </form>
         
</body>
</html>
