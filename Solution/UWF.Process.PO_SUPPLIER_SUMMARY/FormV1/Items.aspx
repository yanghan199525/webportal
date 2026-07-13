<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Items.aspx.cs" Inherits="UWF.Process.PO_SUPPLIER_SUMMARY.Items" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/UserInfo.ascx" TagName="UserInfo" TagPrefix="ui" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ApprovalHistory.ascx" TagName="ApprovalHistory" TagPrefix="ah" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/MultiAttachments.ascx" TagName="Attachments" TagPrefix="attach" %>
<%@ Register Src="../../Ultimus.UWF.Form.ProcessControl.V3/ButtonList.ascx" TagName="ButtonList" TagPrefix="btn" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="Ultimus.UWF.Form.ProcessControl.V3" %>
<%@ Import Namespace="Ultimus.UWF.Workflow.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">   
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>物料清单</title>
    <!-- ========== Css Files ========== -->

    <link href="../../../common/assets/css/root.css" rel="stylesheet" />
     <style>
        body {
            background-color: #fff;
           
        }
         .SearchNumber {
             margin-top:1%;
             margin-left:4%;
             margin-bottom:1%;
         }
        .tdrow {
            padding-top: 2px !important;
            padding-bottom: 2px !important;
        }

        @media screen and (max-width: 1024px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }

        @media screen and (min-width: 1024px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="background-color:white;">
         <div class="ArticleTable">
                <table class="table table-bordered table-condensed form-detail-table form-resp-table ArticleList" id="AtricleList">
                    <thead>
                        <tr>                       
                            <th>
                               <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.SupplierCode") %>
                            </th>
                            <th class="hidden">
                               <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.BATCHNUMBER") %>
                            </th>
                            <th>
                               <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLECODE") %>
                            </th>
                            <th>
                               <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.ARTICLENAME") %>
                            </th>
                             <th>
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.GRReceivingQuantity") %>
                            </th>
                            <th>
                               <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATEORDER") %>
                            </th>
                            <th >
                              <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.TAXRATESUPPLIER") %>
                            </th>
                            <th>
                               <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICEORDER") %>
                            </th>
                            <th>
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICESUPPLIER") %>
                            </th>
                            <th>
                                <%=Lang.Get("UWF.Process.PO_SUPPLIER_NETPRICE.NETPRICEDIFFER") %>
                            </th>                           
                        </tr>
                    </thead>
                    <tbody class="Articles">
                        <asp:Repeater ID="ArticleSource" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td ><%#Eval("SUPPLIERCODE")%></td>
                                    <td class="hidden"><%#Eval("BATCHNUMBER")%></td>
                                    <td><%#Eval("ARTICLECODE")%></td>
                                    <td><%#Eval("ARTICLENAME")%></td> 
                                    <td><%#Eval("GRRECEIVINGQUANTITY")%></td>  
                                    <td><%#Eval("TAXRATEORDER")%></td>
                                    <td><%#Eval("TAXRATESUPPLIER")%></td>
                                    <td><%#Eval("NETPRICEORDER")%></td>
                                    <td><%#Eval("NETPRICESUPPLIER")%></td>
                                    <td><%#Eval("NETPRICEDIFFER")%></td>                                
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        <div class="hidden">        
                <asp:HiddenField ID="hdSiteCode" runat="server" />

            </div>
    </form>  
<%=WebUtil.IncludeJsV3() %>
</body>
</html>
