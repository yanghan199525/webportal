<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssociatedProcess.ascx.cs"
    Inherits="Ultimus.UWF.Form.ProcessControl.V3.AssociatedProcess" %>

<div class="row" id="rowAtt" runat="server">
    <div class="col-md-12">
        <div class="panel panel-default" id="filelist">
            <div class="panel-title">
                <div class="fa-title"><i class="fa fa-paperclip"></i><span class="padding-r-5"></span><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_AssociatedProcess")%></div>
                <ul class="panel-tools">
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>
            <div class="panel-body">

                <!--Start detail table-->
                <table class="table table-bordered table-condensed form-detail-table form-resp-table" width="100%">
                    <thead>
                        <tr>
                            <td class="th_no" style="width: 50px">
                                <asp:Label ID="Label2" runat="server" Text="No."><%=Ultimus.UWF.Common.Logic.Lang.Get("No")%></asp:Label>
                            </td>
                            <td class="th_DocumentNo" style="width: 15%">
                                <asp:Label ID="Label3" runat="server" Text="流程单号"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_DocumentNo")%></asp:Label>
                            </td>
                            <td class="th_processName" style="width: 15%">
                                <asp:Label ID="Label4" runat="server" Text="流程名"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_ProcessName")%></asp:Label>
                            </td>
                            <td class="">
                                <asp:Label ID="Label8" runat="server" Text="流程摘要"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_Summary")%></asp:Label>
                            </td>
                            <td class="headerTD " style="width: 10%">
                                <asp:Label ID="Label5" runat="server" Text="申请人"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_CreateBy")%></asp:Label>
                            </td>
                            <td class="headerTD hidden-xs hidden">
                                <asp:Label ID="Label6" runat="server" Text="上传时间"><%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_UploadDate")%></asp:Label>
                            </td>
                            <td class="headerTD" id="actionRow" runat="server" style="width: 50px">
                                <asp:Label ID="Label7" runat="server" Text="操作"><%=Ultimus.UWF.Common.Logic.Lang.Get("DraftList_Operate")%></asp:Label>
                            </td>
                        </tr>
                    </thead>
                    <tbody id="fileinfo_AssociatedProcess">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td class="td_no" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("No")%>'>
                                        <%# Container.ItemIndex+1 %>
                                    </td>
                                    <td class="td_DocumentNo"  data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_DocumentNo")%>'>
                                        <a target="_blank" href="javascript:void(0)" onclick="javascript:objReport.openForm('<%#Eval("ASSOCIATEDFORMID") %>','<%#Eval("ASSOCIATEDPROCESSNAME") %>','<%#Eval("ASSOCIATEDINCIDENT") %>');return false;" style="cursor: head">
                                            <%#Ultimus.UWF.Common.Logic.Lang.Get(MyLib.ConvertUtil.ToString(Eval("DOCUMNET")))%>
                                        </a>
                                    </td>
                                    <td class="td_processName" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_ProcessName")%>'>
                                      <%#Ultimus.UWF.Common.Logic.Lang.Get(MyLib.ConvertUtil.ToString(Eval("PROCESSNAME")))%>
                                    </td>
                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_Summary")%>'>
                                        <%# Eval("DISPLAYSUMMARY")%>
                                    </td>
                                    <td class="" data-label='<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_CreateBy")%>'>
                                        <%# Eval("CreateBy")%></td>
                                    <td class="hidden hidden-xs">
                                        <%# Eval("CreateDate")%>
                                    </td>
                                    <td class="" id="Td1" runat="server" visible='<%# ReadOnly?false:true %>'>
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="hide" Visible='<%# ReadOnly?false:false %>' CssClass="btn btn-icon btn-sm" OnClientClick="return confirm('确定要删除吗?');"
                                            CommandArgument='<%# Eval("NEWGUID") %>' CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>

                                        <a onclick="if(confirm('<%=Ultimus.UWF.Common.Logic.Lang.Get("SecurityList_ConfirmDelete")%>')){deleteAttAP('<%# Eval("NEWGUID") %>',this)}"
                                            class="btn btn-icon btn-sm" href="javascript:void(0)"><i class="fa fa-trash"></i></a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div id="uploadrow" runat="server">
                    <input style="margin-top: 4px" id="btnChuanYue1" class="btn btn-icon btn-default hidden-print" onclick="OpenCorrelationList()" type="button" value='<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_AssociatedProcess")%>' />
                </div>
            </div>
        </div>
    </div>
</div>

<div style="display: none">
    <asp:TextBox ID="txtMust" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtReadonly" runat="server"></asp:TextBox>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <asp:Button ID="btn_fresh" runat="server" Text="Button" OnClick="btn_fresh_Click" />
    <asp:TextBox ID="txtSingle" runat="server"></asp:TextBox>
    <asp:TextBox ID="txtType" runat="server"></asp:TextBox>
</div>
<div class="hidden">
</div>

<script type="text/javascript">
    $(function () {
        //$("#fileinfo_AssociatedProcess td").each(function () {
        //    $(this).css("text-align", "center");
        //});
        if ($("#AssociatedProcess_txtReadonly").val() == "1") {
            $("#AssociatedProcess_actionRow").hide();
        }
    })

    function deleteAttAP(guid, ele) {
        $.get("<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/UploadAssociatedProcessHandler.ashx",
                    { method: "delete", guid: guid }, function (data) {
                        $(ele).parent().parent().remove();

                        var tabRows = $(".attno");
                        for (var i = 0; i < tabRows.length; i++) {
                            $(tabRows[i]).html(i + 1);
                        }
                    });
    }

    function freshatt() {
        document.getElementById("AssociatedProcess_btn_fresh").click();
        document.getElementById("ButtonList1_btnSubmit").onfocus();
    }

    function pint() {
        var plength = document.getElementById("fileinfo_AssociatedProcess").rows.length;
        return plength;
    }

    function OpenCorrelationList() {
        var formid = document.getElementById("AssociatedProcess_TextBox1").value;
        var username = document.getElementById("AssociatedProcess_TextBox2").value;
        var url = "<%=Ultimus.UWF.Common.Logic.WebUtil.GetRootPath()%>/Solution/Ultimus.UWF.Form.ProcessControl.V3/CorrelationList.aspx?formid="
           + formid + "&ProcessName=" + request("ProcessName") + "&Incident=" + request("Incident") + "&StepName=" + request("StepName") + "&USERNAME=" + encodeURI(username) + '&parseInt=' + pint();

        var dialog = { title: '<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_AssociatedProcess")%>', size: 'Wide' };
        var iframe = { id: 'frameWindow', src: '"' + url + '"', scrolling: "yes" };
        var buttons = { method: 'correlationList()', num: "2", btnOK: '<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_BtnOk")%>', btnClose: '<%=Ultimus.UWF.Common.Logic.Lang.Get("AP_Form_BtnClose")%>' };
        var dia = { dialog: dialog, iframe: iframe, buttons: buttons };
        showDialog(dia);
    }
</script>
