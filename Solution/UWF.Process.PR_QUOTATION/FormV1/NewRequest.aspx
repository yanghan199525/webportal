<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="UWF.Process.PR_QUOTATION.NewRequest" %>

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
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title><%=Lang.Get(Request.QueryString["ProcessName"]) %></title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {

            AfterLoad();
        }

        //Repeater绑定完成
        void AfterBind(object sender, EventArgs e)
        {
            //如果明细表没有数据，那么给明细表加空行
            ProcessFormLogic _form = new ProcessFormLogic();
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <!--定义UserInfo-->
        <ui:userinfo id="UserInfo1" processtitle="PR_QUOTATION" processprefix="PR" tablename="PROC_PR_QUOTATION"
            tablenamedetail="" runat="server"></ui:userinfo>
        <!--End main table-->
        <!--Start 接UserInfo Div的结束标记,请不要删除-->
        </div></div></div></div>
            <!--End 接UserInfo Div的结束标记,请不要删除-->
        <!--1.对Table做循环，判断单行,多行-->
        <!--1.1单行-->
        <div class="row" id="div_panel_PR_QUOTATION">
            <div class="col-md-12">
                <div class="panel panel-default">

                    <div class="panel-title">
                        <div class="fa-title">
                            <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                            <%=Lang.Get("UWF.Process.PR_QUOTATION.PR_QUOTATION") %>
                             <a id="NewCataLogInfo"  href="" onclick="NewCataLogInfo();return false;" style="color:blue;margin-left:1%">报价单信息查看 </a>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-plus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell " id="div_field_CATALOGID" style="height: ">
                            <div class="form-label">
                                <%=Lang.Get("UWF.Process.PR_QUOTATION.CataLogID") %>:
                            </div>
                            <div class="form-field">
                                <div class="form-ctl">
                                    <ult:TextBox ID="fld_CATALOGID" data-type='string' title="" onblur="" data-field="CATALOGID" Variable="" ControlValue="" CssClass="form-control  " runat="server">
                                    </ult:TextBox>
                                </div>
                            </div>
                        </div>

                        <!--补充空单元格-->
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height: ">
                            <div class="form-label">
                            </div>
                            <div class="form-field">
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6 col-xs-12 form-cell hidden-sm hidden-xs" style="height: ">
                            <div class="form-label">
                            </div>
                            <div class="form-field">
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <attach:attachments id="Attachments1" runat="server"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>

        <div class="hidden">
            <asp:TextBox ID="txt_Judge1" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt_Judge2" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt_Judge3" runat="server"></asp:TextBox>
        </div>
    </form>
    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=f75e54f9-a76c-4eae-aa48-438ec8e623f2'></script>
    <script type='text/javascript' src='NewRequest.js?t=f6e543f9-e5a5-4084-b8af-36821f03441a'></script>
</body>
<script>
    $(function () {
        //员工编号 进行显示
        $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").removeAttr("hidden");
        $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").parent("div").css("height", "46px");
        $("#UserInfo1_read_APPLICANTACCOUNT").parent("div").parent("div").css("height", "46px");
        $("#UserInfo1_read_APPLICANTACCOUNT").removeClass("hidden");
        $("#UserInfo1_read_APPLICANTACCOUNT").next().hide();
        //隐藏之前的 申请部门
        $("#UserInfo1_read_DEPARTMENT").parent("div").parent("div").parent("div").hide();
          var StepName = getUrlParam('StepName');
        if (StepName.trim() != "Sourcing Director") {
            $("#NewCataLogInfo").css("display", "none");
        }
    })
    function NewCataLogInfo() {
        debugger
        var cataLogID = $("#fld_CATALOGID").val();
             var incident = getUrlParam('Incident');
        var StepName = getUrlParam('StepName');
        var Type = getUrlParam('Type');
        var TaskID = getUrlParam('TaskID');
        var userName=getUrlParam('UserName');
      
        window.location.href = "https://testingautosmart.sodexo-cn.com/Solution/UWF.Process.PR_QUOTATION/FormV1/NewCataLogInfo.aspx?cataLogID=" + cataLogID + "&incident=" + incident + "&Type=" +Type+ "&TaskID=" + TaskID + "&userName=" + userName+"&StepName="+StepName+"&ProcessName=PR_QUOTATION";


        //var cataLogID = $("#UserInfo1_fld_DOCUMENTNO").text();
        //url = "NewCataLogInfo.aspx?cataLogID=" + cataLogID;
        //url = encodeURI(url);
        //height = "500px";
        //    buttons = [{
        //        label: '取消',
        //        cssClass: 'btn btn-md',
        //        action: function (dialog) {
        //            dialog.close();
        //        }
        //    }];
        
        //BootstrapDialog.show({
        //    title: '报价单物料清单',
        //    animate: false,
        //    closable: true,
        //    size: BootstrapDialog.SIZE_WIDE,
        //    message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:hidden;"></iframe>'),
        //    buttons: buttons
        //});
    }
      function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]); return null; //返回参数值
    }
</script>
</html>
