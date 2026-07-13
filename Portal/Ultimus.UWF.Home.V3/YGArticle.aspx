<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YGArticle.aspx.cs" Inherits="Ultimus.UWF.Home.V3.YGArticle" %>
<%@ Register assembly="Ultimus.UWF.Form" namespace="Ultimus.UWF.Form.WebControls" tagprefix="cc1" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0"/>
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management"/>
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>数采物料维护</title>
    <!-- ========== Css Files ========== -->
    <link href="../../common/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
    <div style="margin-left:5%"> <h4> <span class="btn btn-rounded btn-default btn-icon cursor-default"> <i class="fa fa-envelope-o"></i></span> 数采物料维护列表</h4></div>
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
        <div style="overflow-x: auto; width:98%;">
              <table class="table table-condensed table-bordered" style="width: 1500px;">
                                    <thead>
                                        <tr>
                                          <th>供应商编号</th>
                                          <th>供应商名称</th>
                                          <th>物料编号</th>
                                          <th>物料名称</th>
                                          <th>物品分类编号</th>
                                          <th>订购单位</th>
                                          <th>订购-库存转化率</th>
                                          <th>库存单位</th>
                                          <th>库存-消耗转化率</th>
                                          <th>消耗单位</th>
                                          <th>分店价格</th>
                                          <th>票种</th>
                                          <th>税率</th>
                                          <th>未税结算价</th>
                                        </tr>
                                      </thead>
                             <asp:Repeater ID="Repeater1" runat="server" >
                                 <ItemTemplate>
                                      <tbody>
                                        <tr>
                                          <td><%# Eval("supplierCode") %></td>
                                          <td><%# Eval("supplierName") %></td>
                                          <td><%# Eval("SKU") %></td>
                                          <td><%# Eval("skuName") %></td>
                                          <td><%# Eval("categroyCode") %></td>
                                          <td><%# Eval("orderUnit") %></td>
                                          <td><%# Eval("conversion") %></td>
                                          <td><%# Eval("InventoryUnit") %></td>
                                          <td><%# Eval("consumption") %></td>
                                          <td><%# Eval("consumptionUnit") %></td>
                                          <td><%# Eval("sitePrice") %></td>
                                          <td><%# Eval("InvoiceType") %></td>
                                          <td><%# Eval("taxCode") %></td>
                                          <td><%# Eval("NetGoodsAmount") %></td>
                                        </tr>
                                      </tbody>
                             </ItemTemplate>
                        </asp:Repeater>

                </table>
        </div>
       
    </form>
</body>
</html>
