<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDelegationConfirm.aspx.cs" Inherits="Ultimus.UWF.Home.V3.MyDelegationConfirm" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        #content {
            margin-top: 10px;
            margin-left: auto;
        }

        h3 {
            width: 100%;
            height: 40px;
            line-height: 40px;
            text-align: center;
            /*background-color: #53a3ef;*/
            margin-bottom: 0px;
        }

        #nav {
            margin-top: 0px;
            padding-left: 20px;
            padding-bottom:20px;
            /*border: 2px solid black;*/
        }

        #common {
            width: 100%;
        }

            #common tr {
                width: 100%;
            }

        #commonTxt {
            line-height: 100px;
            height: 100px;
            background-color: #53a3ef;
            text-align: center;
        }

        #txtComments {
            width: 99%;
            height: 100px;
        }
    </style>
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <%=WebUtil.IncludeFormV3Css()%>
</head>
<body>
    <form id="form1" runat="server">
        <div id="content" class="form-content">
            <h3><asp:Label ID="label_info" runat="server">代理信息确认</asp:Label></h3>
            <hr style="height: 1px; border: none; border-top: 1px solid black;" />
            <div id="nav">
                <h5><asp:Label ID="label_txtUser" runat="server">尊敬的用户</asp:Label><asp:Label ID="assignUser" runat="server"></asp:Label>，
                    <asp:Label ID="label_txtTaskUser" runat="server">有一个来自于</asp:Label><asp:Label ID="taskUser" runat="server"></asp:Label><asp:Label ID="label_txtTaskUsers" runat="server">流程代理需要您同意</asp:Label>
             
                </h5>
                <p><asp:Label ID="label_orgNameTxt" runat="server">1.代理流程：</asp:Label><asp:Label ID="Process" runat="server"></asp:Label></p>
                <p>
                    <asp:Label ID="label_startTimeTxt" runat="server">2.代理时间：</asp:Label><asp:Label ID="startTime" runat="server"></asp:Label>至<asp:Label ID="endTime" runat="server"></asp:Label>
                </p>
                <table id="common">
                    <tr>
                        <td id="commonTxt"><asp:Label ID="label_common" runat="server">理由</asp:Label></td>
                        <td colspan="3">
                            <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" MaxLength="1000"
                                Height="100px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-body" style="border-top: 0px;">

                        <div class="col-lg-12 col-sm-12 col-xs-12  padding-b-20 " style="height: 35px; text-align: center">
                            <asp:Button ID="btn_Approval" runat="server" Text="我已知晓并接受" OnClientClick="return submitForm();"
                                OnClick="btnSubmit_Click" class="btn btn-default " />

                            <asp:Button ID="btn_Reject" runat="server" OnClick="btnReject_Click" Text="拒绝" CssClass="btn " OnClientClick="return Reject();" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function Reject() {
            var comments = $("#txtComments").val();
            if (comments.length == 0) {
                alert("拒绝理由不能为空!");
                $("#txtComments").focus();
                return false;
            }
        }
    </script>
</body>
</html>
