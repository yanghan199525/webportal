<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QianChenInfo.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.QianChenInfo" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<script type="text/javascript">
    $(function () {
        $("#QianChenInfo1_fld_SIGNATURE").next().attr("onclick", "$('#QianChenInfo1_fld_SIGNATURE').click()")
        if (request("type").toLocaleLowerCase() == "mytask" || request("type").toLocaleLowerCase() == "myrequest" || request("type").toLocaleLowerCase() == "myapproval" || request("type").toLocaleLowerCase() == "addsign") {
            $("#QianChenInfo1_fld_SIGNATURE").addClass("ReadOnly");
            $("#QianChenInfo1_fld_SIGNATURE").next().removeAttr("onclick");
            $("#QianChenInfo1_fld_SIGNATURE").parent().append("<asp:Label ID=\"read_SIGNATURE\"  onclick=\"OpenFormid(this, 'PROC_SCM_SIGNATURE')\" style=\"color: blue; cursor: pointer\"   CssClass=\"form - control ReadOnly\">" + $("#QianChenInfo1_fld_SIGNATURE").val() + "</asp:Label>");
            $("#QianChenInfo1_fld_SIGNATURE").css("display", "none");
            $("#QianChenInfo1_fld_SIGNATURE").next().css("display", "none");
            if (request("type").toLocaleLowerCase() == "myrequest" || request("type").toLocaleLowerCase() == "myapproval") {
                $("#QianChenInfo1_fld_SIGNATURE").next().next().css("display", "none");
            }
            $("#QianChenInfo1_fld_PURPOSE").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#QianChenInfo1_fld_PURPOSE").css("width") + ";text-align:center;\">" + $("#QianChenInfo1_fld_PURPOSE").val() + "</span>");
            $("#QianChenInfo1_fld_PURPOSE").css("display", "none");
            $("#QianChenInfo1_fld_EXECUTIONDATE").parent().append("<span style=\"word-break:break-all;word-wrap:break-word;width:" + $("#QianChenInfo1_fld_EXECUTIONDATE").css("width") + ";text-align:center;\">" + $("#QianChenInfo1_fld_EXECUTIONDATE").val() + "</span>");
            $("#QianChenInfo1_fld_EXECUTIONDATE").css("display", "none");

            //$("#QianChenInfo1_fld_SIGNATURE").next().next().text().attr("onclick", "OpenFormid(this,'PROC_SCM_TRAVELOUTWORK')");
        }
        $("#QianChenInfo1_fld_SIGNATURE").attr("onclick", "getPURPOSE()");
    })


    function getPURPOSE() {
        $("#QianChenInfo1_fld_SIGNATURE").attr("onclick", " selectDataSource({ element: this, title: '', fields:'QianChenInfo1_fld_PURPOSE,QianChenInfo1_fld_EXECUTIONDATE', dataSource: '签呈列表', filter: 'APPLICANTCODE=&apos;" + $("#UserInfo1_fld_APPLICANTACCOUNT").val().split('\\')[1] + "&apos;', single: true, IsMethod: true });");
    }


</script>
<!-- Start Row -->
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-title">
                <div class="fa-title">
                    <i class="fa fa-check-square-o"></i><span class="padding-r-5"></span>
                    <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_SIGNATUREINFO")%>
                </div>
                <ul class="panel-tools">
                    <li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
                    <li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
                </ul>
            </div>
            <div class="panel-body form-table">
                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell">
                    <div class="form-label input-prepend input-group">
                        <span><%=Ultimus.UWF.Common.Logic.Lang.Get("Form_SIGNATURE")%>:</span>
                    </div>
                    <div class="form-field">
                        <div class="form-ctl">
                            <div class="input-prepend input-group">
                                <asp:TextBox ID="fld_SIGNATURE" title="" data-type='string' data-field="SIGNATURE" onblur="" Variable=""
                                    CssClass="form-control " onclick="selectDataSource({element:this,title:'',fields:'QianChenInfo1_fld_PURPOSE,QianChenInfo1_fld_EXECUTIONDATE',dataSource:'签呈列表',filter:'',single:true,IsMethod:true});" ControlValue='<%#Eval("SIGNATURE")%>' runat="server"> 
                                </asp:TextBox>
                                <span class="add-on input-group-addon " style="cursor: pointer"><i class="fa fa-search"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell ">
                    <div class="form-label">
                        <%=Ultimus.UWF.Common.Logic.Lang.Get("Form_PURPOSE")%>:
                    </div>
                    <div class="form-field">
                        <div class="form-ctl">
                            <asp:TextBox ID="fld_PURPOSE" runat="server" data-field="PURPOSE" Text="" format="" variable="" CssClass="form-control ReadOnly"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 col-xs-12 form-cell" id="div_field_DATEAVAILABLE" style="">
                    <div class="form-label">
                        <%=Lang.Get("Form_Executiondate") %>:
                    </div>
                    <div class="form-field">
                        <div class="form-ctl">
                            <asp:TextBox ID="fld_EXECUTIONDATE" title="" data-field="EXECUTIONDATE" format="{yyyy-MM-dd}" variable="" CssClass="form-control ReadOnly" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- End Row -->
