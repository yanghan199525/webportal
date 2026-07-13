<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="UWF.Process.PR_QUOTATION.Approval" %>

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
                            <a id="cataLogInfo" href="" onclick="CataLogInfo();return false;" style="color: blue; margin-left: 1%">报价单信息查看 </a>
                        </div>

                        <ul class="panel-tools">
                            <li><a class="icon minimise-tool"><i class="fa fa-plus"></i></a></li>
                            <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                        </ul>
                    </div>

                    <div class="panel-body form-table">
                    </div>




                </div>
            </div>
        </div>
        <attach:attachments id="Attachments1" runat="server" readonly="True"></attach:attachments>
        <ah:approvalhistory id="ApprovalHistory1" showaction="true" runat="server"></ah:approvalhistory>
        <btn:buttonlist id="ButtonList1" runat="server"></btn:buttonlist>
        <asp:HiddenField ID="hdIsApproval" runat="server" />
        <asp:HiddenField ID="hdCheckApproved" runat="server" />
    </form>

    <div id='div_lang' data-lang='<%=Lang.GetLang() %>'></div>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.config.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/ueditor/ueditor.all.js'></script>
    <script type='text/javascript' src='<%=WebUtil.GetRootPath()%>/Solution/UPL.Common.BussinessControl/Script/BussinessCommon.js?t=e93c35f8-1fa4-48fa-97ec-91d9177fc795'></script>
    <script type='text/javascript' src='Approval.js?t=732baf2d-06d4-4140-a1bb-36d393a6dd64'></script>
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
        if ($("#hdCheckApproved").val() == "approval") {
            $("#ButtonList1_btnApprove").css("display", "none");
            $("#ButtonList1_btnReject").css("display", "none");
            $("#ButtonList1_btnSubmitCataLog").css("display", "none");
        }
        var StepName = getUrlParam('StepName');
        if (StepName.trim() != "Sourcing Director") {
            $("#ButtonList1_btnSubmitCataLog").css("display", "none");
            $("#cataLogInfo").css("display", "none");
        }
    })
    function CataLogInfo() {
        debugger
        var cataLogID = $("#UserInfo1_fld_DOCUMENTNO").text();
           var incident = getUrlParam('Incident');
        var StepName = getUrlParam('StepName');
        var Type = getUrlParam('Type');
        var TaskID = getUrlParam('TaskID');
        var userName=getUrlParam('UserName');
        var approval = $("#hdCheckApproved").val();
        window.location.href = "https://testingautosmart.sodexo-cn.com/Solution/UWF.Process.PR_QUOTATION/FormV1/cataLogInfo.aspx?cataLogID=" + cataLogID + "&incident=" + incident + "&approval=" + approval + "&Type=" +Type+ "&TaskID=" + TaskID + "&userName=" + userName+"&StepName="+StepName+"&ProcessName=PR_QUOTATION";

        
        //var incident = getUrlParam('Incident');
        //var StepName = getUrlParam('StepName');
        //var Type = getUrlParam('Type');
        //var approval = $("#hdCheckApproved").val();
        //url = "cataLogInfo.aspx?cataLogID=" + cataLogID + "&incident=" + incident + "&approval=" + approval;
        //url = encodeURI(url);
        //height = "500px";
        //if (StepName.trim() == "Sourcing Director" && approval.trim() != "approval" && Type == 'MYTASK') {
        //    buttons = [{
        //        label: '保存',
        //        cssClass: 'btn btn-default btn-md',
        //        action: function (dialog) {
        //            var val = $(dialog.getModalBody().find('#frmWindowArticle'))[0].contentWindow.returnValue1();
        //            if (val == "") {

        //            } else {
        //                console.log(val);
        //                //dialog.close();
        //            }
        //        }
            
        //    //}, {
        //    //    label: '取消',
        //    //    cssClass: 'btn btn-md',
        //    //    action: function (dialog) {
        //    //        dialog.close();
        //    //    }
        //    }];
        //} else {
        //    buttons = [{
        //        label: '取消',
        //        cssClass: 'btn btn-md',
        //        action: function (dialog) {
        //            dialog.close();
        //        }
        //    }];
         
        //}

        //BootstrapDialog.show({
        //    title: '报价单物料清单',
        //    animate: false,
        //    closable: true,
        //    size: BootstrapDialog.SIZE_WIDE,
        //    message: $('<iframe id="frmWindowArticle" src=' + url + ' width="100%" height=' + height + ' frameborder="no" style="border-width:0px;overflow-y:auto;overflow-x:auto;"></iframe>'),
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
