<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HongKongOrganizational.aspx.cs" Inherits="Ultimus.UWF.Home.V3.HongKongOrganizational" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>香港组织架构维护</title>
    <!-- ========== Css Files ========== -->
    <link href="../../common/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
</head>
<body>
    <div style="margin-left: 5%">
        <h4><span class="btn btn-rounded btn-default btn-icon cursor-default"><i class="fa fa-envelope-o"></i></span>香港组织架构人员上传</h4>
    </div>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <asp:FileUpload ID="ExcelFileUpload" runat="server" />
                </div>
                <div class="col-lg-3" style="text-align: left">
                    <asp:Button class="btn btn-success" ID="UploadBtn" runat="server" Text="确定上传" OnClick="UploadBtn_Click" />
                </div>
                <div class="col-lg-4"></div>
            </div>
        </div>
    </form>
</body>
</html>
