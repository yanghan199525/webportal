<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CirculationUserInfo.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.CirculationUserInfo" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="cc1" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Import Namespace="MyLib" %>
<div class="row" id="approvalrow">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-title">
                <div class="fa-title"><i class="fa fa-bars"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("PassRecord")%></div>
                <ul class="panel-tools">
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>
            <div class="panel-body">
                <!--Start detail table-->
                <table id="CirculationItem" class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                    <thead>
                        <tr>
                            <td style="width: 50px;"><%=Lang.Get("No") %></td>
                            <td style="width: 120px;"><%=Lang.Get("CirculatedPeople") %></td>
                            <td class="hidden-xs" ><%=Lang.Get("Form_Opinion") %></td>
                            <td style="width: 100px;"><%=Lang.Get("TaskList_Status") %></td>
                            <td style="width: 120px"><%=Lang.Get("Form_CreateBy") %></td>
                            <td style="width: 150px"><%=Lang.Get("CreationTime") %></td>
                            <td style="width: 50px;"><%=Lang.Get("Action") %></td>
                        </tr>
                    </thead>
                    <tbody class="chuanyuedetail">
                       
                    </tbody>
                </table>
            </div>
            <asp:TextBox ID="txtCirDeleteGuid" CssClass="hidden" runat="server"></asp:TextBox>
        </div>
    </div>
</div>

<script type="text/javascript">
    var processName = "<%=Request.Params["ProcessName"]%>";
    var incident = "<%=Request.Params["Incident"]%>";
    $(function () {
        $.ajax({
            url: "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/Handler/ProcessControl.ashx?method=GETCIRCULATION",
            data: {
                PROCESSNAME: processName, INCIDENT: incident
            },
            cache: false,
            async: false,
            dataType: 'html',
            success: function (data) {
                var chuanyue = $(".chuanyuedetail");
                chuanyue.html(data);
            },
            error: function () {

            }
        })

    })
    function setDeleteGuid(obj) {

    }
    var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/Handler/ProcessControl.ashx?method=DeleteCirRow";
    function CirculationUserInfo_DeleteRowClick(obj) {
        if ($(obj).prev().text() != "") {
            $.ajax({
                url: "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/Handler/ProcessControl.ashx?method=DeleteCirRow",
                data: {
                    ID: $(obj).prev().text()
                },
                success: function (data) {
                    if (data == "1") {
                        alert("删除成功！");
                        deleteRow('CirculationItem', obj, true);
                    } else {
                        alert("删除失败！");
                    }
                },
                error: function () {
                    alert("删除失败！");
                }
            });
        }
    }
</script>
