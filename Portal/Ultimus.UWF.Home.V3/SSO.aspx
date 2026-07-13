<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SSO.aspx.cs" Inherits="Ultimus.UWF.Home.V3.SSO" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
        <div style="display: none">
            <asp:TextBox ID="txt_DingTalk_Code" runat="server"></asp:TextBox>
        </div>
    </form>
    <script src="../../Common/Assets37/js/jquery-3.3.1.min.js"></script>
    <script src="/Portal/Ultimus.UWF.Home.V3/js/dingtalk.open.js"></script>

    <script>
        if (dd.env.platform !== "notInDingTalk") {
            //进行钉钉登录操作
            dd.ready(function () {
                // dd.ready参数为回调函数，在环境准备就绪时触发，jsapi的调用需要保证在该回调函数触发后调用，否则无效。
                dd.runtime.permission.requestAuthCode({
                    corpId: '<%=MyLib.ConfigurationManager.AppSettings["DingTalk_Corpid"] %>',
                    onSuccess: function (result) {
                        code = result.code // 通过该免登授权码可以获取用户身份
                        var param = {};
                        param.code = code;
                        param.Method = 'DingTalk_SSO';
                        $.ajax({
                            type: "POST",
                            url: "/Portal/Ultimus.UWF.Home.V3/LoginHandler.ashx",
                            cache: false,  //禁用缓存
                            data: param,  //传入组装的参数
                            dataType: "json",
                            async: false,
                            success: function (result) {
                                var obj = eval(result);
                                if (obj.success == "0") {
                                    checkError();
                                    return;
                                }
                                if (obj.success == "1") {
                                    //var path = window.document.location.protocol + "//" + window.document.location.host;
                                    var url ='<%=MyLib.ConfigurationManager.AppSettings["DingTalk_Default"] %>';
                                    window.location.href = url;
                                }
                            }
                        });
                    },
                    onFail: function (err) { }
                });
            });
        } else {
            debugger;
            var url ='<%=MyLib.ConfigurationManager.AppSettings["DingTalk_Default"] %>';
            window.location.href = url;
        }
    </script>
</body>
</html>
