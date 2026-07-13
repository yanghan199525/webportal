<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Ultimus.UWF.Home.V3.Login" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get("Default_ProjectTitle") %></title>

    <script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/js/jquery.min.js" type="text/javascript"></script>
    <%--<%=WebUtil.IncludeCssV3() %>--%>

    <%--<script src="../../Common/Assets37/js/jquery-3.3.1.min.js"></script>--%>
    <script src="<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/common/assets/js/jquery.cookie.js" type="text/javascript"></script>


    <link rel="stylesheet" href="../../Common/Assets37/css/base.css" />
    <style type="text/css">
        body {
            background: #ffffff;
            font-family:微软雅黑;
        }

        .group {
            position: relative;
            margin-bottom: 20px;
        }

        .fa {
            position: absolute;
            top: 11px;
            left: 13px;
            font-size: 16px;
        }


        .hidden {
            display: none;
        }

        .form-control {
            padding-left: 38px;
            height: 40px;
        }
    </style>

    <script type="text/javascript">
        try {
            self.moveTo(0, 0);
            self.resizeTo(screen.availWidth, screen.availHeight);
        } catch (e) {
        }

        $(document).ready(function () {
            //.ASPXAUTH FedAuth FedAuth1 LoginName rememberme rememberme
            debugger
            var rem = $.cookie('rememberme');
            if (rem == 1) {
                $("#cbxRememberMe").attr("checked", "true");
            }
            else {
                $("#cbxRememberMe").removeAttr("checked");
            }
            $("#txtUser").val($.cookie('username'));
            $("#ddlDomains").val($.cookie('domain'));
            $("#txtUser").focus();
            //??????
            document.onkeyup = function (e) {
                var ev = document.all ? window.event : e;
                if (ev.keyCode == 13) {
                    $('#login_btnSubmit').click();
                }
            };

        });
        function checkError() {
            alert('<%=Lang.Get("Login_UserOrPasswordInvalid")%>');
        }

        function validate(ele) {
            if ($("#txtUser").val() == "") {
                alert('<%=Lang.Get("Login_UserRequired")%>');
                return false;
            }
            var chx = $("#cbxRememberMe").attr("checked");
            var name = $("#txtUser").val();
            if (!chx) {
                chx = 0;
                name = "";
            }
            else {
                chx = 1;
            }
            var domain = $("#ddlDomains").val();
            $.cookie('rememberme', chx, { expires: 3 });
            $.cookie('username', name, { expires: 3 });
            $.cookie('domain', domain, { expires: 3 });

            $(ele).val("LOGIN...");
            return true;
        }

        function loginSuccess(obj) {
            $.cookie('login_username', obj, { expires: 3 });
        }
        function Login(ele) {
            if (!validate(ele)) {
                return;
            }
            var param = {};
            param.UserName = $("#txtUser").val();
            param.Domain = $("#ddlDomains").val();
            param.Password = $("#txtPassword").val();
            param.Method = 'BPMLogin';
            $.ajax({
                type: "POST",
                url: "/Portal/Ultimus.UWF.Home.V3/LoginHandler.ashx",
                cache: false,  //????
                data: param,  //???????
                dataType: "json",
                async: false,
                success: function (result) {
                    var obj = eval(result);
                    if (obj.success == "0") {
                        checkError();
                        return;
                    }
                    //cookie
                    if (obj.msg != "") {
                        loginSuccess(obj.msg);
                    }
                    if (obj.success == "1" && $("#hidReturnUrl").val() != "") {
                        var path = window.document.location.protocol + "//" + window.document.location.host;
                        window.location.href = path + $("#hidReturnUrl").val();
                    } else if (obj.success == "1" && $("#hidReturnUrl").val() == "") {
                        var path = window.document.location.protocol + "//" + window.document.location.host;
                        window.location.href = path;
                        <%--var DefaultForm = '<%=MyLib.ConfigurationManager.AppSettings["DefaultForm"] %>';
                        if (DefaultForm == "" || DefaultForm == null) {
                            window.location.href = path + "/Portal/Ultimus.UWF.Home.V3/Default.aspx";
                        } else {
                            window.location.href = path + DefaultForm.replace("~", "");
                        }--%>
                    } else if (obj.success == "2") {  //????????
                        window.location.href = "/Portal/Ultimus.UWF.Home.V3/OrgChart/ChangePassword.aspx";
                    }
                }
            });
        }
        function changeCode() {
            document.getElementById('ibtn_imgcheckingcode').src = document.getElementById('ibtn_imgcheckingcode').src + '?';
        }
      
    </script >

</head >
            <body>
                <form id="form1" class="form" runat="server" style="border: 0;">
                    <div class="app-container app-theme-white body-tabs-shadow">
                        <div class="app-container">
                            <div class="h-100">
                    <div class="h-100 no-gutters row">
                        <div class="d-none d-lg-block col-lg-8" >
                                        <div class="slider-light">
                                            <div class="slick-slider">
                                                <div>
                                                    <div class="position-relative h-100 d-flex justify-content-center align-items-center bg-plum-plate" tabindex="-1">
                                                        <div class="slide-img-bg" style="background-image: url('../../Common/Assets37/images/originals/city.jpg'); "></div>
                                                        <div class="slider-content">
                                                        
                                              
                                                        </div>
                                                    </div>
                                                </div>
                                              
                                            </div>
                                        </div>
                        </div>
                        <div class="h-150  d-flex bg-white justify-content-center align-items-center col-md-12 col-lg-4" >
                            <div class="mx-auto app-login-box col-sm-12 col-md-10 col-lg-9" >

                                           <div class="" style="text-align:left;">

                                                <img src="../../Common/Assets37/images/logoSodexo.png"/>
                                            </div>
                                            <h4 class="mb-0">
                                                <span>输入您的索迪斯用户名和密码
                                                </span></h4>


                                <%--                            <h6 class="mt-3">No account? <a href="javascript:void(0);" class="text-primary">Sign up now</a></h6>
                                --%>

                                <div class="divider row"></div>

                                <div class="login-form">


                                    <div class="form-area" style="padding: 0">
                                        <div class="group">
                                            <asp:TextBox ID="txtUser" runat="server" class="form-control" placeholder="用户名 "></asp:TextBox>
                                            <i class="fa fa-user"></i>
                                    </div>
                                    <div class="group">
                                        <asp:TextBox ID="txtPassword" runat="server" autocomplete="off" class="form-control" TextMode="Password" placeholder="密码"></asp:TextBox>
                                            <i class="fa fa-key"></i>
                                </div>
                        
                                <asp:TextBox ID="tbx_imgcheckingcode" runat="server" Width="82px" Height="25px"></asp:TextBox>
            <%-- ondblclick ?????????????--%>
                          <asp:Image ID="ibtn_imgcheckingcode" src="ValidateNum.aspx" Height="40px"  Width="70px" onclick="this.src=this.src+'?'" runat="server" />
                               <a href="javascript:changeCode()" style="text-decoration: underline; font-size: 10px;">换一张</a><br />
                        <asp:Label ID="CodeMsg" runat="server" style="color:red;"></asp:Label>
                                <div class="group hidden">
                                    <asp:DropDownList ID="ddlDomains" runat="server" class="form-control" data-placeholder="Domain">
                                            </asp:DropDownList>

                                            <i class="fa fa-at hidden-xs"></i>
                            </div>


                                      


                        </div>

                        <div class="hidden">
                    <asp:HiddenField ID="hidReturnUrl" runat="server" />
                    <asp:HiddenField ID="codeSession" runat="server"/>
                                    </div>


                    </div>


                    <div>
                                    <%-- <div class="form-row">
                                        <div class="col-md-6">
                                            <div class="position-relative form-group">
                                                <label for="exampleEmail" class="">Email</label>

                                                <input name="email" id="exampleEmail" placeholder="Email here..." type="email" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="position-relative form-group">
                                                <label for="examplePassword" class="">Password</label>
                                                <input name="password" id="examplePassword" placeholder="Password here..." type="password"
                                                    class="form-control">
                                            </div>
                                        </div>
                                    </div>--%>
                     <%--   <div class="checkbox checkbox-primary">
                            <asp:CheckBox ID="cbxRememberMe" Checked="true" runat="server" />
                                        <label for="cbxRememberMe"><%=Lang.Get("Login_RememberMe")%></label>
                        </div>--%>


                        <div class="divider row"></div>
                        <div class=" align-items-center">
                            <div class="ml-auto">
                              <%--  <a href="<%=Lang.Get("loginhelpurl")%>" target="_blank" class="btn-lg btn btn-link"><%=Lang.Get("loginhelp")%></a>--%>

                                <asp:Button ID="btnSubmit" runat="server" Text="登录" value="登录" OnClientClick="return validate(this);"
                                    class="btn btn-primary btn-lg" OnClick="btnSubmit_Click" />
                                            <input type="button" id="login_btnSubmit" style="width: 170px" runat="server" class="btn btn-primary btn-lg hidden" onclick="Login(this)" />

                                            <%--<button class="btn btn-primary btn-lg">Login to Dashboard</button>--%>
                                
                        </div>

                    </div>
                    <br/>
                    <div>
                        <table>
                            <tr>
                                <th>Sodexo China</th>
                                <th>Other countries</th>
                            </tr>
                            <tr>
                                <td style="font-size:12px">如需帮助，请联系IT服务台<br />
400 011 5071 或 021-2356 6666<br />
或发送电子邮件至<br>IT.Helpdesk.CN@sodexo.com</td>
                                 <td style="font-size:12px">Need help?
Contact your local technical support team</td>
                            </tr>
                        </table>
                    </div>
                    <br>
                    <div>
                        <p>
                            Legal Warning
                        <p />
                            <span style="font-size:12px; margin-top:0px" >
                                Use of this Sodexo computer system is limited to authorized users. This network contains confidential and proprietary information and is to be accessed and used exclusively by Sodexo employees and its authorized agents and contractors. Unauthorized access is strictly prohibited and violators are subject to prosecution to the full extent of the law. All users of Sodexo network resources, including Internet access, must comply with Sodexo policies for such use. Sodexo reserves the right to monitor, access, retrieve, read, and disclose communications at any time, and to engage in automated monitoring, and investigation of irregularities. By continuing to use this system you indicate your awareness of and consent of these terms.
                            </span>
                    </div>

                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div >

            <div class="topbanner " style="display: none">
                <div class="poswrap">
                    <h1 class="toptitle">BPM Login</h1>
                </div>
            </div>


    </form >


            <script src="../../Common/Assets37/js/bootstrap.bundle.min.js"></script>
    <script src="../../Common/Assets37/js/metismenu.js"></script>
    <script src="../../Common/Assets37/js/scripts-init/app.js"></script>
    <script src="../../Common/Assets37/js/scripts-init/themes-option.js"></script>


    <!--Slick Carousel -->
    <script src="../../Common/Assets37/js/vendors/carousel-slider.js"></script>
    <script src="../../Common/Assets37/js/scripts-init/carousel-slider.js"></script>
</body>
</html>
