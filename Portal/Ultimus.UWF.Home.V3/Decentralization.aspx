<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Decentralization.aspx.cs" Inherits="Ultimus.UWF.Home.V3.Decentralization" %>


<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management" />
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Decentralization Report</title>
    <link href="../../../common/assets/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../../../common/assets/css/bootstrap3.3.2.css" rel="stylesheet" />
    <link href="../../../common/assets/css/shortcuts.css" rel="stylesheet" />
    <link href="../../../common/assets/css/report.css" rel="stylesheet" />
    <%=WebUtil.IncludeCssV3() %>
    <%=WebUtil.IncludeJsV3() %>
    <%=WebUtil.IncludeFormV3Css()%>
    <style type="text/css">
        #authInfo {
            width: 859px;
        }
    </style>
</head>
<body>
    <form id="authForm" runat="server">
        <div id="authCN">

        </div>
        <div style="margin: 20px 50px;">
            <div>
                <asp:Label ID="label_sdInfo" runat="server">事业部总监信息</asp:Label>
            </div>
            <hr style="height: 1px; border: none; border-top: 1px solid black;" />
            <div class="panel-body SearchNumber">

                <div class="col-md-2 col-sm-6 col-xs-12">
                    <asp:Label ID="label_epmNo" runat="server">事业部总监员工号:</asp:Label>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <asp:TextBox Height="30px" ID="empNo" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <asp:Label ID="label_empName" runat="server">事业部总监员工姓名:</asp:Label>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <asp:TextBox Height="30px" ID="empName" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                </div>
            </div>
            <br />
            <div>
                <asp:Label ID="label_rdInfo" runat="server">事业部下属RD信息</asp:Label>
            </div>
            <hr style="height: 1px; border: none; border-top: 1px solid black;" />
            <div class="panel-body">
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <asp:Label ID="label_orgName" runat="server">事业部</asp:Label>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <asp:DropDownList ID="DropDownListRD" runat="server" Width="200px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                    <asp:Label ID="label_rdType" runat="server">RD授权状态</asp:Label>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <asp:DropDownList ID="DropDownListType" runat="server" Width="200px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>未授权/Unauthorized</asp:ListItem>
                        <asp:ListItem>已授权/Authorized</asp:ListItem>
                        <asp:ListItem>已过期/Expired</asp:ListItem>
                        <asp:ListItem>已拒绝/ Rejected</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-1 col-sm-6 col-xs-12">
                    <asp:Button ID="btn_Serch" runat="server" class="btn btn-success" Text="查询" OnClick="btn_Serch_Click" />
                </div>
                <div class="col-md-2 col-sm-6 col-xs-12">
                </div>
            </div>
        </div>
        <div>
            <table class="table table-condensed table-bordered auth" id="authInfo" style="width: 100%">
                <thead>
                    <tr>
                        <th> <asp:Label ID="label_sdOrgName" runat="server">SD所属事业部</asp:Label></th>
                        <th> <asp:Label ID="label_rdName" runat="server">RD姓名</asp:Label></th>
                        <th> <asp:Label ID="label_rdEmpNo" runat="server">RD员工编号</asp:Label></th>
                        <th> <asp:Label ID="label_isOrgName" runat="server">RD是否仍在事业部</asp:Label></th>
                        <th> <asp:Label ID="label_rdOrgName" runat="server">RD所属事业部</asp:Label></th>
                        <th> <asp:Label ID="label_authType" runat="server">授权状态</asp:Label></th>
                        <th> <asp:Label ID="label_startTime" runat="server">授权开始日期</asp:Label></th>
                        <th> <asp:Label ID="label_endTime" runat="server">授权截至时间</asp:Label></th>
                        <th> <asp:Label ID="label_authRange" runat="server">授权范围</asp:Label></th>
                        <th> <asp:Label ID="label_operation" runat="server">操作</asp:Label></th>
                    </tr>
                </thead>
                <asp:Repeater ID="OrgInfo" runat="server">
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td class="sdOrgName"><%# Eval("sdOrgName") %></td>
                                <td class="name"><%# Eval("rdName") %></td>
                                <td class="empNo"><%# Eval("rdCode") %></td>
                                <td class="isCause"><%# Eval("isOrg") %></td>
                                <td class="cause"><%# Eval("orgName") %></td>
                                <td class="authType"><%# Eval("authType") %></td>
                                <td class="startTime">
                                    <asp:TextBox class="deliverydate" title="" Text='<%# Eval("startTime") %>' data-field='startTime' data-type="text" Format="" Variable='startTime' CssClass="form-control Wdate validate[required,funcCall[futureDateTime]]" runat="server" data-errormessage-type-mismatch="授权开始时间必须大于当前时间" onClick="WdatePicker({ dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    </asp:TextBox>
                                </td>
                                <td class="endTime">
                                    <asp:TextBox title="" Text='<%# Eval("endTime") %>' data-field='endTime' data-type="text" Format="" Variable='endTime' CssClass="form-control Wdate  validate[required,funcCall[futureEndTime]]" runat="server" data-errormessage-type-mismatch="授权结束时间不能超过当前财年截至时间" onClick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    </asp:TextBox>
                                </td>
                                <td class="authRange">
                                    <span class="rangeTxt"><%# Eval("authRange") %></span>
                                    <select class="Range" style="display:none"> 
                                       <%-- <option selected="selected"><%# Eval("authRange").ToString()=="0"?"BPM单外流程":Eval("authRange") %></option>--%>
                                         <option>单外采购流程审批</option>
                                    </select>
                                    <select class="RangeEN" style="display:none"> 
                                       <%-- <option selected="selected"><%# Eval("authRange").ToString()=="0"?"BPM单外流程":Eval("authRange") %></option>--%>
                                         <option>Approval of Out-of-Catalogue Purchase</option>
                                    </select>
                                </td>
                                <td class="operation">
                                    <input type="button" class="btn btn-success btn_Auth" value='<%# Eval("operation") %>' onclick="Auth_Click(this)" />
                                </td>
                            </tr>
                        </tbody>
                    </ItemTemplate>
                </asp:Repeater>

            </table>
        </div>

        <div class="panel-heading padding-t-5 padding-b-15">
            <span class="f-bold padding-l-5"><i class="fa fa-th-list"></i>
                 <asp:Label ID="log_info" runat="server">SD授权信息操作记录</asp:Label></span>
        </div>
        <div class="padding-l-5 padding-r-5" style="overflow-x: auto; width:98%; ">
            <table class="table table-condensed table-bordered " style="width: 1500px;">
                <thead>
                    <tr>
                        <th> <asp:Label ID="log_sdName" runat="server">授权操作人名称</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_sdEmpNo" runat="server">授权操作人编号</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_sdCreate" runat="server">授权操作时间</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_orgName" runat="server">事业部</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_rdName" runat="server">RD姓名</asp:Label>
                        </th>
                        <th><asp:Label ID="log_rdempNo" runat="server">RD员工编号</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_rdCreate" runat="server">RD操作时间</asp:Label>
                        </th>
                         <th><asp:Label ID="log_startTime" runat="server">授权开始时间 </asp:Label>
                        </th>
                         <th> <asp:Label ID="log_endTime" runat="server">授权结束时间</asp:Label>
                        </th>
                         <th> <asp:Label ID="log_desc" runat="server">授权说明</asp:Label>
                        </th>
                         <th> <asp:Label ID="log_range" runat="server">授权范围</asp:Label>
                        </th>
                        <th> <asp:Label ID="log_content" runat="server">操作内容</asp:Label>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <ult:Repeater ID="rptInfo" Source="" PagerID="AspNetPager2"
                        runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%#Eval("sdName")%>
                                </td>
                                <td>
                                    <%#Eval("sdEmpNo")%>
                                </td>
                                <td>
                                     <%# Eval("sdCreatTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("sdCreatTime"))):""%>
                                </td>
                                <td>
                                    <%#Eval("sdOrgName")%>
                                </td>
                                <td>
                                    <%#Eval("rdName")%>
                                </td>
                                <td>
                                    <%#Eval("rdEmpNo")%>
                                </td>
                                <td>
                                      <%# Eval("rdCreatTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("rdCreatTime"))):""%>
                                </td>
                                <td>
                                     <%# Eval("authStartTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("authStartTime"))):""%>
                                </td>
                                <td>
                                    <%# Eval("authEndTime")!=DBNull.Value?String.Format("{0:yyyy-MM-dd HH:mm:ss}", MyLib.ConvertUtil.ToDateTime(Eval("authEndTime"))):""%>
                                </td>
                                <td>
                                    <%#Eval("authDesc")%>
                                </td>
                                <td>
                                    <%#Eval("authRange")%>
                                </td>
                                <td>
                                    <%#Eval("comments")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </ult:Repeater>
                </tbody>
            </table>
        </div>
        <!-- Pager -->
        <div class="pull-right">
            <webdiyer:AspNetPager ID="AspNetPager2" runat="server" CssClass="asppager"
                NumericButtonCount="5" CurrentPageButtonClass="btn"
                FirstPageText="<i class='fa fa-step-backward'></i>" PrevPageText="<i class='fa fa-chevron-left'></i>"
                NextPageText="<i class='fa fa-chevron-right'></i>" LastPageText="<i class='fa fa-step-forward'></i>"
                AlwaysShow="false" PageSize="10">
            </webdiyer:AspNetPager>
        </div>
             <asp:HiddenField ID="hdLanguaes" runat="server" />
    </form>

</body>
      <script type='text/javascript' src='My97DatePicker/WdatePicker.js?t=e005db86-f756-42ef-afc6-af444545f4w30'></script>
        <script type='text/javascript' src='My97DatePicker/dayjs.min.js?t=e005db86-f756-42ef-afc6-af444545f4w30'></script>
        <script src="js/Loading.js"></script>
        <script type="text/javascript">

            $(function () {
                $(".rangeTxt").each(function () {
                    if ($(this).text() == "0") {
                       var languaes=$("#hdLanguaes").val();
                        $(this).css("display", "none")
                        if (languaes == "zh-CN") {
                             $(this).siblings(".Range").css("display","block")
                        } else {
                             $(this).siblings(".RangeEN").css("display","block")
                        }
                       
                    } 
                });
            })
            function futureDateTime(field, rules, i, options) {
                debugger
                var InputTime = new Date(field.val());
                time = field.val();
                var datetime = new Date();
                if (InputTime < datetime) {
                    options.allrules.validate2fields.alertText = "授权开始时间必须大于当前时间,Authorization start time must be greater than current time";
                    return options.allrules.validate2fields.alertText;
                };
            };
            function futureEndTime(field, rules, i, options) {
                debugger
                var InputTime = new Date(field.val());
                var startTime = new Date(field.parent().siblings(".startTime").find("input").val());
                var startyear = startTime.getFullYear();
                var startmonth = startTime.getMonth() + 1;
                var endyear = InputTime.getFullYear();
                var endmonth = InputTime.getMonth() + 1;
                //如果当年授权开始时间是8月初则结束时间不能超过当前财年8月底
                if (InputTime < startTime) {
                    options.allrules.validate2fields.alertText = "授权结束时间不能早于开始时间,Authorization end time cannot be earlier than start time";
                    return options.allrules.validate2fields.alertText;
                } else if (endyear - startyear <= 1) {
                    if (startmonth < 9 && endmonth >= 9) {
                        options.allrules.validate2fields.alertText = "授权时间不能大于当前授权起始时间财年,Authorization time cannot be greater than the current authorization start time fiscal year";
                        return options.allrules.validate2fields.alertText;
                    } else if (startmonth >= 9 && endmonth >= 9 && endyear - startyear == 1) {
                        options.allrules.validate2fields.alertText = "授权时间不能大于当前授权起始时间财年,Authorization time cannot be greater than the current authorization start time fiscal year";
                        return options.allrules.validate2fields.alertText;
                    }
                } else {
                    options.allrules.validate2fields.alertText = "授权时间不能大于当前授权起始时间财年,Authorization time cannot be greater than the current authorization start time fiscal year";
                    return options.allrules.validate2fields.alertText;
                }
            };

            function Auth_Click(ele) {
                var type = 0;
                if ($(ele).val() == "授权"||$(ele).val() == "auth") {
                    type = 1;
                }
                var startTime = new Date($(ele).parent().siblings(".startTime").find("input").val());
                var endTime = new Date($(ele).parent().siblings(".endTime").find("input").val());
                if (startTime == "" || endTime == "") {
                    alert("授权时间不能为空,Authorization time cannot be empty");
                }
                var rdName = $(ele).parent().siblings(".name").text();
                var rdEmpNo = $(ele).parent().siblings(".empNo").text();
                var orgName = $(ele).parent().siblings(".cause").text();
                var sdOrgName = $(ele).parent().siblings(".sdOrgName").text();
                var sdEmpNo = $("#empNo").val();
                var sdEmpName = $("#empName").val();
                var languaes=$("#hdLanguaes").val();
                if (languaes == "zh-CN") {
                    var authRange = $(ele).parent().siblings(".authRange").children(".Range").find("option:selected").val();
                } else {
                    var authRange = $(ele).parent().siblings(".authRange").children(".RangeEN").find("option:selected").val();
                }

                var startyear = startTime.getFullYear();
                var startmonth = startTime.getMonth() + 1;
                var endyear = endTime.getFullYear();
                var endmonth = endTime.getMonth() + 1;

                var datetime = new Date();
                datetime.setHours(0);
                datetime.setMinutes(0);
                datetime.setSeconds(0);
                datetime=dayjs(datetime).format('YYYY-MM-DD HH:mm:ss')
                var startTime = dayjs(startTime).format('YYYY-MM-DD HH:mm:ss')
                var endTime = dayjs(endTime).format('YYYY-MM-DD HH:mm:ss')
                if (type == 0) {
                    debugger
                    var txt = "\xa0\xa0\xa0\xa0\xa0\xa0尊敬的用户:" + sdEmpName + ",请确认是否将收回您Buysmart中所有单外采购审批控制中Segment Director节点的审批权限下放给您下属的RD用户:" + rdName + " \n\xa0\xa0\xa0\xa0\xa0\xa0 Dear user:" + sdEmpName + "Please confirm whether to delegate the approval authority of the Segment Director node in the approval control of all out of order purchases in Buymart back to your subordinate RD users:" + rdName + "";
                } else {
                    if (startTime <= datetime) {
                        alert("授权开始时间必须大于当前时间,Authorization start time must be greater than current time");
                        $(ele).parent().siblings(".startTime").find("input").val("");
                        $(ele).parent().siblings(".startTime").find("input").focus();
                        return false;
                    };

                    if (endTime < startTime) {
                        alert("授权结束时间不能早于开始时间,Authorization end time cannot be in start time");
                        $(ele).parent().siblings(".endTime").find("input").val("");
                        $(ele).parent().siblings(".endTime").find("input").focus();
                        return false;
                    } else if (endyear - startyear <= 1) {
                        if (startmonth < 9 && endmonth >= 9) {
                            alert("授权时间不能大于当前授权起始时间财年,Authorization time cannot be greater than the current authorization start time fiscal year")
                            $(ele).parent().siblings(".endTime").find("input").val("");
                            $(ele).parent().siblings(".endTime").find("input").focus();
                            return false;
                        } else if (startmonth >= 9 && endmonth >= 9 && endyear - startyear == 1) {
                            alert("授权时间不能大于当前授权起始时间财年,Authorization time cannot be greater than the current authorization start time fiscal year")
                            $(ele).parent().siblings(".endTime").find("input").val("");
                            $(ele).parent().siblings(".endTime").find("input").focus();
                            return false;
                        }
                    } else {
                        alert("授权时间不能大于当前授权起始时间财年,Authorization time cannot be greater than the current authorization start time fiscal year")
                        $(ele).parent().siblings(".endTime").find("input").val("");
                        $(ele).parent().siblings(".endTime").find("input").focus();
                        return false;
                    }
                    var txt = "\xa0\xa0\xa0\xa0\xa0\xa0尊敬的用户" + sdEmpName + "，请确认是否将您Buysmart中所有单外采购审批控制中Segment Director节点的审批权限下放给您下属的RD。授权后RD在Segment Director节点下的审批操作会被视为您亲自操作，授权信息如下：\n 1.事业部名称：" + orgName + "\n 2.被授权RD：" + rdName + "\n 3.授权日期：" + startTime + "至" + endTime + "\n \xa0\xa0\xa0\xa0\xa0\xa0Dear\xa0" + sdEmpName + "Please confirm whether to delegate the approval authority of the Segment Director node in the approval control of all out of order purchases in your Buysmart to your subordinate RD. After authorization, the approval of RD under the Segment Director node will be considered as your own operation. The authorization information is as follows:\n 1.BU Name：" + orgName + "\n 2.Authorized RD：" + rdName + "\n 3.Authorized Time：" + startTime + "至" + endTime + " \n \xa0 \xa0\xa0\xa0\xa0\xa0\xa0The delegatee has the necessary professional skills and accepts to exercise the DOA in full compliance with all Group and Dimension procedures and policies.Non - compliance to the DOA as outlined in this document may result in disciplinary actions.被授权人拥有完成审批所需的专业知识及技能，并将完全按照集团及相关流程政策执行审批。不遵守本文件中概述的DOA可能会导致纪律处分。\n \xa0\xa0\xa0\xa0\xa0\xa0The authority delegated in this document shall not be sub - delegated.上述授权不能二次授权。"
                }
                var languaes = $("#hdLanguaes").val();
                if (languaes == "zh-CN") {
                      BootstrapDialog.confirm({
                    title: '提示',
                    message: txt,
                    type: BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
                    // BootstrapDialog.TYPE_PRIMARY
                    closable: true, // <-- Default value is false，点击对话框以外的页面内容可关闭
                    draggable: true, // <-- Default value is false，可拖拽
                    btnCancelLabel: '取消', // <-- Default value is 'Cancel',
                    btnOKLabel: '确定', // <-- Default value is 'OK',
                    btnOKClass: 'btn-default', // <-- If you didn't specify it, dialog type
                    btnCancelClass: 'btn-warning',
                    size: BootstrapDialog.SIZE_SMALL,
                    // 对话框关闭的时候执行方法
                    onhide: function () {

                    },
                    callback: function (result) {
                        if (result) {
                            $.ajax({
                                type: "post",
                                datatype: "json",
                                contentType: "application/json",
                                async: false,
                                url: 'Decentralization.aspx/SendEmail',
                                data: "{\"rdName\":\"" + rdName + "\",\"rdEmpNo\":\"" + rdEmpNo + "\",\"sdEmpNo\":\"" + sdEmpNo + "\",\"sdEmpName\":\"" + sdEmpName + "\",\"startTime\":\"" + startTime + "\",\"endTime\":\"" + endTime + "\",\"sdOrgName\":\"" + sdOrgName + "\",\"type\":\"" + type + "\",\"authRange\":\"" + authRange + "\",\"orgName\":\"" + orgName + "\"}",
                                success: function (data) {
                                    debugger
                                    if (data.d) {
                                        alert("操作成功!");
                                        location.reload()
                                    } else {
                                        alert("操作失败，请联系管理员");
                                    }
                                }
                            });

                        }
                    }
                });
                } else {
                      BootstrapDialog.confirm({
                    title: 'Tips',
                    message: txt,
                    type: BootstrapDialog.TYPE_PRIMARY, // <-- Default value is
                    // BootstrapDialog.TYPE_PRIMARY
                    closable: true, // <-- Default value is false，点击对话框以外的页面内容可关闭
                    draggable: true, // <-- Default value is false，可拖拽
                    btnCancelLabel: 'Cancel', // <-- Default value is 'Cancel',
                    btnOKLabel: 'OK', // <-- Default value is 'OK',
                    btnOKClass: 'btn-default', // <-- If you didn't specify it, dialog type
                    btnCancelClass: 'btn-warning',
                    size: BootstrapDialog.SIZE_SMALL,
                    // 对话框关闭的时候执行方法
                    onhide: function () {

                    },
                    callback: function (result) {
                        if (result) {
                            $.ajax({
                                type: "post",
                                datatype: "json",
                                contentType: "application/json",
                                async: false,
                                url: 'Decentralization.aspx/SendEmail',
                                data: "{\"rdName\":\"" + rdName + "\",\"rdEmpNo\":\"" + rdEmpNo + "\",\"sdEmpNo\":\"" + sdEmpNo + "\",\"sdEmpName\":\"" + sdEmpName + "\",\"startTime\":\"" + startTime + "\",\"endTime\":\"" + endTime + "\",\"sdOrgName\":\"" + sdOrgName + "\",\"type\":\"" + type + "\",\"authRange\":\"" + authRange + "\",\"orgName\":\"" + orgName + "\"}",
                                success: function (data) {
                                    debugger
                                    if (data.d) {
                                        alert("Operation succeeded!");
                                        location.reload()
                                    } else {
                                        alert("Operation failed, please contact the administrator");
                                    }
                                }
                            });

                        }
                    }
                });
                }
              

            }
        </script>
</html>
