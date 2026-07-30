<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfo_AddSign.ascx.cs" Inherits="Ultimus.UWF.AddSign.UserInfo_AddSign" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<script type="text/javascript">
    self.moveTo(0, 0);
    self.resizeTo(screen.availWidth, screen.availHeight);
    function request(paras) {
        var url = location.href;
        var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
        var paraObj = {}
        for (i = 0; j = paraString[i]; i++) {
            paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
        }
        var returnValue = paraObj[paras.toLowerCase()];
        if (typeof (returnValue) == "undefined") {
            return "";
        } else {
            return returnValue;
        }
    }
    jQuery(document).ready(function () {
        $("input[money=money]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9.]/g, '');
            });
        });
        $("input[money=int]").each(function () {
            $(this).keyup(function () {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });
        $("#ButtonList1_btnSubmit").click(function () {
            form_validation();
        });

        $("span[id^=fld_detail]").each(function () {
            $(this).css("text-align", "center");

        });
        if (request("type").toLocaleLowerCase() == "myrequest") {
            $(":input[type!=submit][type!=radio][type!=checkbox][type!=button]:visible").each(function () {
                if ($(this).hasClass("selector")) {
                    var txt = $(this).find("option:selected").text();
                    $(this).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(this).css("width") + ";text-align:center;\">" + txt + "</span>");
                    $(this).css("display", "none");

                } else {
                    $(this).parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $(this).css("width") + ";text-align:center;\">" + $(this).val() + "</span>");
                    $(this).css("display", "none");
                }
            })

            $("input:radio").each(function () {
                $(this).attr("disabled", "disabled");
            })
            $("input:checkbox").each(function () {
                $(this).attr("disabled", "disabled");
            })

            $(":button").each(function () {
                if ($(this)[0].name != "ButtonList1$btnPrintHtml") {
                    $(this).css("display", "none");
                }
            })
            $(".btn").each(function () {
                if ($(this)[0].name != "ButtonList1$btnClose" && $(this)[0].name != "ButtonList1$btnPrintHtml") {
                    $(this).css("display", "none");
                }
            })
        }
    });
    function form_validation() {
        jQuery("#form1").validationEngine('attach', {
            onValidationComplete: function (form, status) {
                if (status == false) {
                    submitTimes = 0;
                    closeDiv();
                }
            }
        });

    }

</script>

<div class="main">
           
                    <asp:Label ID="lblDocumentNo" runat="server" Visible="false"  ></asp:Label>
                    <asp:Label ID="fld_DOCUMENTNO" runat="server"  ></asp:Label>
                    <asp:Label ID="lblSummary" runat="server" Visible="false"  ></asp:Label>
                    <asp:Label ID="barcode" runat="server" Visible="false"  ></asp:Label>
                    <asp:Label ID="incident" runat="server" Visible="false"  ></asp:Label>
                    <asp:Label ID="lblCOMPANY" runat="server" Visible="false"  ></asp:Label>
                    <asp:Label ID="lblProcessName" runat="server" Visible="false"  ></asp:Label>
                     <asp:Label ID="fld_APPLICANT" runat="server" Text=""></asp:Label>
                     <asp:Label ID="fld_DEPARTMENT" runat="server" Text=""></asp:Label>
                    <asp:Label ID="fld_REQUESTDATE" runat="server" Text=""></asp:Label>
                          
        
       </div>
<div class="hidden">
    <asp:TextBox ID="fld_Status" runat="server" Text="1"></asp:TextBox>
    <asp:TextBox ID="fld_PROCESSNAME" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_INCIDENT" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtStepName" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_FORMID" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtProcessPrefix" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtReadOnly" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableName" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTableNameDetail" runat="server"></asp:TextBox>
    <asp:TextBox ID="var_ApplicantAccount" runat="server" Text=""></asp:TextBox><%--申请人账号--%>
   
   
    <asp:TextBox ID="fld_DEPARTMENTID" runat="server" Text=""></asp:TextBox><%--本部门Id--%>
    <asp:TextBox ID="var_UserMangerAccount" runat="server" Text=""></asp:TextBox><%--部门Manager--%>
    <asp:TextBox ID="var_UserSupervisorAccount" runat="server" Text=""></asp:TextBox><%--申请人主管--%>
    <asp:TextBox ID="var_UserMangerAccount1" runat="server" Text=""></asp:TextBox>
    <asp:TextBox ID="var_UserMangerAccount2" runat="server" Text=""></asp:TextBox>


   
    <asp:TextBox ID="var_AttachmentPath" runat="server" Text=""></asp:TextBox> 
    <asp:TextBox ID="var_AttachmentName" runat="server" Text=""></asp:TextBox> 


    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtTaskId" runat="server"></asp:TextBox>
    <asp:TextBox ID="fld_APPLICANTACCOUNT" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtApplicantAccount" runat="server"></asp:TextBox>
    
    <asp:TextBox ID="fld_PROCESSSUMMARY" runat="server" Text=""  Width="87%"></asp:TextBox>
    <asp:TextBox ID="txtIsVarSubmit" runat="server" Text="0"></asp:TextBox>
    <asp:TextBox ID="txtIsCreateForm" runat="server" Text="0"></asp:TextBox>
    
    <asp:TextBox ID="txtPreFix" runat="server" Text="F"></asp:TextBox>
    
</div>
