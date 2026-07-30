<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessStepDetail.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessStepDetail" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls"
    TagPrefix="ult" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>流程步骤属性</title>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <%=WebUtil.IncludeFiles() %>
    <script language="javascript">

        $(document).ready(function () {
            // $("#Close").prop('href', 'ProcessStepList.aspx?PROCESSNAME=' + $("#txtProcessName").val())
            //判断保存草稿
            selectType();
            //$("#ckSaveDarft").attr("checked", "checked");
        })

        //只有当为2发起时，显示保存草稿模块
        function selectType() {
            if ($("#txtSTEPTYPE").val() == "2") {
                $(".spSaveDraft").show();
            } else {
                $(".spSaveDraft").hide();
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12 breadcrumb mb0">
                    <table width="100%">
                        <tr>
                            <td width="10">
                                <i class="icon-th-large"></i>
                            </td>
                            <td width="200">
                                <span class="pl5 strong inline">流程步骤详细信息</span>
                            </td>
                            <td class="pull-right"></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span2">
                    步骤名称:
                </div>
                <div class="span4">
                    <ult:TextBox ID="TextBox3" Destination="BizDB.WF_PROCESSSTEP[ID].STEPNAME"
                        runat="server" CssClass="validate[required] " />
                </div>
                <div class="span2">
                    流程名称:
                </div>
                <div class="span4">
                    <ult:TextBox ID="txtProcessName" Destination="BizDB.WF_PROCESSSTEP[ID].PROCESSNAME"
                        runat="server" CssClass="validate[required] " />
                </div>


            </div>
            <div class="row-fluid">
                <div class="span2">
                    步骤类型<br />
                    <span style="color: red;">(发起为2 其他可为空)</span>
                </div>
                <div class="span4">
                    <ult:TextBox ID="txtSTEPTYPE" Destination="BizDB.WF_PROCESSSTEP[ID].STEPTYPE"
                        runat="server" CssClass=" " onblur="selectType();" />
                </div>

                <div class="span2">
                    PC端表单Url:
                </div>
                <div class="span4">
                    <ult:TextBox ID="txtSummary" Destination="BizDB.WF_PROCESSSTEP[ID].PCFORM"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid">
                <div class="span2">
                    移动端表单Url:
                </div>
                <div class="span4">
                    <ult:TextBox ID="txtMOBILEFORM" Destination="BizDB.WF_PROCESSSTEP[ID].MOBILEFORM"
                        runat="server" CssClass="" />
                </div>
                <div class="span2">
                    动态审批人变量:
                </div>
                <div class="span4">
                    <ult:TextBox ID="txtAPPROVERVARIABLE" Destination="BizDB.WF_PROCESSSTEP[ID].RECIPIENTVARIABLE"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid">
                <div class="span2">
                    动态审批人方法:
                </div>
                <div class="span4">
                    <ult:DropDownList ID="ddlRAMMETHODID" DataTextField="NAME" DataValueField="CODE" Destination="BizDB.WF_PROCESSSTEP[ID].RAMMETHODID"
                        runat="server" CssClass=" " AutoPostBack="true" OnTextChanged="ddlRAMMETHODID_TextChanged">
                    </ult:DropDownList>

                </div>
                <div class="span2">
                    方法参数对应业务字段:
                </div>
                <div class="span4">
                    <%--<ult:TextBox ID="txtSqlWhere" runat="server" Destination="BizDB.WF_PROCESSSTEP[ID].EXT02" CssClass="span4"></ult:TextBox>--%>
                    <ult:TextBox ID="txtMethodParameters" Destination="BizDB.WF_PROCESSSTEP[ID].EXT01"
                        runat="server" CssClass="" />
                </div>
            </div>

            <div class="row-fluid" runat="server" id="divFunctionid" visible="false">
                <div class="span2">
                    岗位审批人:
                </div>
                <div class="span4">
                    <ult:DropDownList ID="ddlFUNCTIONAL" DataTextField="FUNCTIONALNAME" DataValueField="FUNCTIONALID" Destination="BizDB.WF_PROCESSSTEP[ID].FUNCTIONALID"
                        runat="server" CssClass=" " AutoPostBack="true" OnTextChanged="drpFUNCTIONAL_TextChanged">
                    </ult:DropDownList>
                    <ult:TextBox ID="txtFUNCTIONAL" runat="server" Destination="BizDB.WF_PROCESSSTEP[ID].EXT03" Style="display: none"></ult:TextBox>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span2">
                    动态审批人是否多人:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="ckbISRECIPIENTARRAY" Destination="BizDB.WF_PROCESSSTEP[ID].ISRECIPIENTARRAY"
                        runat="server" CssClass="" />
                </div>
                <div class="span2">
                    审批权限:
                </div>
                <div class="span4">
                    <ult:DropDownList ID="drpDOA" DataTextField="TextField" DataValueField="ValueField" Destination="BizDB.WF_PROCESSSTEP[ID].DOAID"
                        runat="server" CssClass=" ">
                    </ult:DropDownList>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span2">
                    审批权限对应的变量:
                </div>
                <div class="span4">
                    <ult:TextBox ID="TextBox2" Destination="BizDB.WF_PROCESSSTEP[ID].DOAVARIABLE"
                        runat="server" CssClass="" />
                </div>

                <div class="span2">
                    批量审批:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="TextBox1" Destination="BizDB.WF_PROCESSSTEP[ID].ISBATCH"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid" style="display: ">
                <div class="span2">
                    加签:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="CheckBox1" Destination="BizDB.WF_PROCESSSTEP[ID].ISADDSIGN"
                        runat="server" CssClass="" />
                </div>

                <div class="span2">
                    退回:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="CheckBox4" Destination="BizDB.WF_PROCESSSTEP[ID].ISRETURN"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid" style="display: ">
                <div class="span2">
                    选择性退回:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="ckSelectReturn" Destination="BizDB.WF_PROCESSSTEP[ID].ISSELECTRETURN"
                        runat="server" CssClass="" />
                </div>
                <div class="span2">
                    拒绝:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="CheckBox3" Destination="BizDB.WF_PROCESSSTEP[ID].ISREJECT"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid" style="display: ">
                <div class="span2">
                    可退回步骤:
                </div>
                <div class="span8">
                    <ult:CheckBoxList ID="cklSelectReturnStep" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Destination="BizDB.WF_PROCESSSTEP[ID].EXT02"></ult:CheckBoxList>
                </div>


            </div>
            <div class="row-fluid" style="display: ">
                <div class="span2">
                    打印:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="CheckBox5" Destination="BizDB.WF_PROCESSSTEP[ID].ISPRINT"
                        runat="server" CssClass="" />
                </div>

                <div class="span2">
                    撤回:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="chkISWITHDRAW" Destination="BizDB.WF_PROCESSSTEP[ID].ISWITHDRAW"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid" style="display: ">
                <div class="span2">
                    作废:
                </div>
                <div class="span4">
                    <ult:CheckBox ID="chkISABORT" Destination="BizDB.WF_PROCESSSTEP[ID].ISABORT"
                        runat="server" CssClass="" />
                </div>

                <div class="span2">
                    序号:
                </div>
                <div class="span4">
                    <ult:TextBox ID="txtORDERNO" Destination="BizDB.WF_PROCESSSTEP[ID].ORDERNO"
                        runat="server" CssClass="" />
                </div>
            </div>
            <div class="row-fluid" style="display: ">
                <div class="span2 spSaveDraft">
                    保存草稿:
                </div>
                <div class="span4 spSaveDraft">
                    <ult:CheckBox ID="ckSaveDarft" Destination="BizDB.WF_PROCESSSTEP[ID].ISSAVEDRAFT" Checked="true"
                        runat="server" CssClass="" />
                    <%--<ult:DropDownList ID="DropDownList1" DataTextField="TextField" DataValueField="ValueField" Destination="BizDB.WF_PROCESSSTEP[ID].ISSAVEDRAFT"
                        runat="server" CssClass=" ">
                        <asp:ListItem Value="">---请选择---</asp:ListItem>
                        <asp:ListItem Value="0">显示</asp:ListItem>
                        <asp:ListItem Value="1">隐藏</asp:ListItem>
                    </ult:DropDownList>--%>
                </div>
            </div>
            <hr />
            <div class="row-fluid center">
                <ult:BtnLoadForm ID="BtnLoadForm1" runat="server" />
                <ult:BtnSave ID="BtnSave2" runat="server" CssClass="btn btn-primary"
                    OnAfterClick="BtnSave2_AfterClick" OnClientClick="attachValidation();" OnClick="BtnSave2_Click" />
                <ult:BtnDelete ID="btnDelete1" runat="server" CssClass="btn"
                    OnClientClick="return ask('您确定要删除吗?');" />
                <a class="btn btn-default hidden" href="javascript:window.close();" id="Close"><i class="icon-chevron-left"></i>关闭</a>
            </div>
            <div class="hidden">
                <ult:TextBox ID="txtID" Source="KeyWords.MaxID.BizDB.WF_PROCESSSTEP.ID" Destination="BizDB.WF_PROCESSSTEP[ID].ID"
                    runat="server"></ult:TextBox>

                <%--            <asp:TextBox ID="txtCondtion" runat="server" Text=" AND ( B.CompanyID ={COMPANY} OR 1=1 )  AND ( A.PROCESSNAME ='All Process' or A.PROCESSNAME ={PROCESSNAME}) And "></asp:TextBox>--%>
            </div>
        </div>
    </form>
</body>
</html>
