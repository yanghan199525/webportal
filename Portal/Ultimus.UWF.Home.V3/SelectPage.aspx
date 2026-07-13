<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPage.aspx.cs" Inherits="Ultimus.UWF.Home.V3.SelectPage" EnableViewState="false" ViewStateMode="Disabled" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=0">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <title>Task List</title>
    <!-- ========== Css Files ========== -->
    <%=WebUtil.IncludeCssV3() %>
    <style>
        body {
            background-color: #fff;
        }

        .tdrow {
            padding-top: 2px !important;
            padding-bottom: 2px !important;
        }

        @media screen and (max-width: 568px) {
            .task {
                width: 350px !important;
                display: block !important;
            }
        }

        @media screen and (min-width: 568px) {
            .task {
                width: 100% !important;
                display: block !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table id="tasklist" class="table  table-condensed  table-hover table-nofooter task  " style="display: none">
            <thead>
                <tr>
                    <td data-orderable="false"></td>
                    <asp:Repeater ID="rptCols" runat="server">
                        <ItemTemplate>
                            <td><%#Eval("DisplayName") %></td>
                        </ItemTemplate>
                    </asp:Repeater>
                    <td class="hidden"></td>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptList" runat="server" OnItemDataBound="rptList_ItemDataBound">
                    <ItemTemplate>
                        <tr>
                            <td data-orderable="false" class="tdrow">
                                <%-- <asp:RadioButton ID="rbSelect" runat="server" />
                                <asp:CheckBox ID="cbxSelect" runat="server" />--%>

                                <%=GetControl() %>
                                
                                     
                            </td>
                            <%#GetCols(Eval("RowData")) %>
                            <td class="hidden rowdata"><%#Eval("RowData") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <div class="hidden">
            <asp:HiddenField ID="hidQuery" runat="server" />
            <asp:HiddenField ID="hidCaption" runat="server" />
            <asp:HiddenField ID="hidWidth" runat="server" />
            <asp:HiddenField ID="hidOrder" runat="server" />
            <asp:HiddenField ID="hidDBName" runat="server" />
            <asp:HiddenField ID="hidSingle" runat="server" Value="true" />
            <asp:HiddenField ID="hidFilter" runat="server" />
            <asp:HiddenField ID="hidDataSource" runat="server" />
            <asp:HiddenField ID="hidSql" runat="server" />
        </div>
    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script type="text/javascript">
        function returnValue() {
            var single = $("#hidSingle").val();
            var rowdata;
            //单选
            if (single == "true") {
                $("#tasklist").find("input[type=radio]").each(function () {
                    if ($(this).prop("checked")) {
                        rowdata = $(this).parent().parent().find(".rowdata").text();
                    }
                });
                if (!rowdata) {
                    return false;
                }
                rowdata = "[" + rowdata + "]";
            }
            else {
                //多选
                $("#tasklist").find("input[type=checkbox]").each(function () {
                    if ($(this).prop("checked")) {
                        if (!rowdata) {
                            rowdata = $(this).parent().parent().find(".rowdata").text();
                        }
                        else {
                            rowdata = rowdata + ',' + $(this).parent().parent().find(".rowdata").text();
                        }
                    }
                });
                if (!rowdata) {
                    return false;
                }
                rowdata = "[" + rowdata + "]";
            }
            return eval(rowdata.replace(/\|/g, ",").replace(/\：/g, ":"));
        }

        $(document).ready(function () {
            $('#tasklist').DataTable({
                "info": false,
                "filter": true,
                "pageLength": 5,
                "scrollY": 230,
                'paginationType': 'simple',
                "info": true,
                "lengthChange": false,
                "initComplete": function (settings, json) {
                    $("#tasklist").css("display", "");
                },
                "oLanguage": {
                    "sZeroRecords": "<%=Lang.Get("Form_sZeroRecords") %>",
                     "sInfo": "<%=Lang.Get("Form_sInfo") %>", //总记录数
                    "sInfoEmpty": "",
                    "sSearch": "<%=Lang.Get("Form_Search") %>",
                     "oPaginate": {
                         "sFirst": "<%=Lang.Get("Form_First") %>",
                        "sPrevious": "<%=Lang.Get("Form_Previous") %>",
                        "sNext": "<%=Lang.Get("Form_Next") %>",
                        "sLast": "<%=Lang.Get("Form_Last") %>"
                    }
                 }
            });

            //$("input[id$=rbSelect]").attr("name", "sel");

        });

        function selRow(ele) {
            if ($(ele).parent().find("input[type=checkbox]")) {
                if ($(ele).parent().find("input[type=checkbox]").prop("checked")) {
                    $(ele).parent().find("input[type=checkbox]").prop("checked", false);
                }
                else {
                    $(ele).parent().find("input[type=checkbox]").prop("checked", true);
                }
            }

            if ($(ele).parent().find("input[type=radio]")) {
                if ($(ele).parent().find("input[type=radio]").prop("checked")) {
                    $(ele).parent().find("input[type=radio]").prop("checked", false);
                }
                else {
                    $(ele).parent().find("input[type=radio]").prop("checked", true);
                }
            }
        }

    </script>
</body>
</html>
