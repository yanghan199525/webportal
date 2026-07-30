<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessConfiguration.aspx.cs"
    Inherits="Ultimus.UWF.Workflow.ProcessConfiguration" %>
<%@ Register Assembly="Ultimus.UWF.Form" Namespace="Ultimus.UWF.Form.WebControls" TagPrefix="ult" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Ultimus BPM , Ultimus Business Process Management">
    <meta name="keywords" content="ultimus, bpm, workflow, business process management" />
    <base target="_self" />
    <title>流程配置 Process Configuration</title>
    <link href="../../common/assets/css/root.css" rel="stylesheet" />
    <script>
    </script>
</head>
<body style="overflow-x: hidden">
    <form id="form1" runat="server">
        <div class="container-default">
        
        <div class="row" >
            <div class="col-md-3"  style="background-color:#fff;height: 880px;">
                  

                 <div class="padding-l-15 padding-t-5 " style="height: 860px;overflow-y:auto">
                    <asp:TreeView ID="tvFunction" runat="server" ShowExpandCollapse="true"   
                        ShowLines="true" >
                        <NodeStyle ForeColor="Black"/>
                        <SelectedNodeStyle Font-Bold="true" />
                        <NodeStyle ImageUrl="../../Common/Assets/img/ProcessIcon.png" />
                    </asp:TreeView>

                </div>
                 

            </div>
            <div class="col-md-9 padding-l-5">
                
                  <!-- Nav tabs -->
                  <ul class="nav nav-tabs nav-line " role="tablist">
                    
                    <li role="presentation"  class="active"  id="tab1" runat="server"><a href="#" onclick="openProp();" aria-controls="home5" role="tab" data-toggle="tab">属性</a></li>
                    <li role="presentation" id="tab2" runat="server"><a href="#" onclick="openDataSchema();" aria-controls="profile5" role="tab" data-toggle="tab">数据定义</a></li>
                    <li role="presentation" id="tab5" runat="server"><a href="#" onclick="openDataSource();" aria-controls="messages5" role="tab" data-toggle="tab">数据源</a></li>
                    <li role="presentation" id="tab3" runat="server"><a href="#" onclick="openFunctionalApprover();" aria-controls="messages5" role="tab" data-toggle="tab">岗位审批人</a></li>
                    <li role="presentation" id="tab4" runat="server"><a href="#" onclick="openDoA();" aria-controls="messages5" role="tab" data-toggle="tab">审批权限</a></li>
                    <li role="presentation" id="tab6" runat="server"><a href="#" onclick="openLanguage();" aria-controls="messages5" role="tab" data-toggle="tab">多语言</a></li>
                      <li role="presentation" id="tab7" runat="server" class="hidden"><a href="#" onclick="openForm();" aria-controls="home5" role="tab" data-toggle="tab">表单预览</a></li>
                    <li role="presentation" id="tab8" runat="server" class="hidden"><a href="#" onclick="openFlow();" aria-controls="messages5" role="tab" data-toggle="tab">流程图</a></li>
                  </ul>

                  <!-- Tab panes -->
                  <div class=" ">
                    <iframe id="frmProperty" runat="server" name="property" frameborder="0" width="99%" height="800"></iframe>
                  </div>

                
    </div>

                
            </div>
            </div>

        </div>

        <div class="hidden">
           </div>  
    </form>
    <%=WebUtil.IncludeJsV3()%>
    <script type="text/javascript">
        //移除treeview自带的事件
        function TreeView_SelectNode(data, node, nodeId) {
            if (!data) {
                return;
            }
            if ((typeof (data.selectedClass) != "undefined") && (data.selectedClass != null)) {
                var id = data.selectedNodeID.value;
                if (id.length > 0) {
                    var selectedNode = document.getElementById(id);
                    if ((typeof (selectedNode) != "undefined") && (selectedNode != null)) {
                        WebForm_RemoveClassName(selectedNode, data.selectedHyperLinkClass);
                        selectedNode = WebForm_GetParentByTagName(selectedNode, "TD");
                        WebForm_RemoveClassName(selectedNode, data.selectedClass);
                    }
                }
                WebForm_AppendToClassName(node, data.selectedHyperLinkClass);
                node = WebForm_GetParentByTagName(node, "TD");
                WebForm_AppendToClassName(node, data.selectedClass)
            }
            data.selectedNodeID.value = nodeId;

            eval(node.childNodes[0].href);
        }

        var _url;
        var _process = "";

        clickProcess("ProcessDetail.aspx?processname=<%=Request.QueryString["processname"]%>", "<%=Request.QueryString["processname"]%>");

        function clickCategory(url)
        {
            $("#frmProperty").attr("src", url);
            $("#tab2").hide();
            $("#tab3").hide();
            $("#tab4").hide();
            $("#tab5").hide();
            $("#tab6").hide();
            _url = url;
        }

        function clickProcess(url, process) {
            if (!process) {
                return;
            }
            $("#frmProperty").attr("src", url);
            $("#tab1").show();
            $("#tab2").show();
            $("#tab3").show();
            $("#tab4").show();
            $("#tab5").show();
            $("#tab6").show();
            $("#tab7").show();
            $("#tab8").show();
            _url = url;
            _process = process;
            $("#tab1").addClass("active");
            $("#tab2").removeClass("active");
            $("#tab3").removeClass("active");
            $("#tab4").removeClass("active");
            $("#tab5").removeClass("active");
            $("#tab6").removeClass("active");
            $("#tab7").removeClass("active");
            $("#tab8").removeClass("active");

        }

        function clickStep(url) {
            $("#frmProperty").attr("src", url);
            $("#tab2").hide();
            $("#tab3").hide();
            $("#tab4").hide();
            $("#tab5").hide();
            $("#tab6").hide();
            $("#tab7").hide();
            $("#tab8").hide();
            $("#tab1").addClass("active");
            _url = url;
        }

        function openForm() {
            $("#frmProperty").attr("src", "../Ultimus.UWF.WorkFlow/OpenForm.aspx?type=newrequest&processname=" + _process);
        }


        function openFlow() {
            $("#frmProperty").attr("src", "../Ultimus.UWF.Home.V3/TaskStatus.aspx?processname=" + _process);
        }

        function openProp() {
            $("#frmProperty").attr("src", _url);
        }

        function openDataSchema() {
            window.open("../Ultimus.UWF.Form/DataSchemaFields.aspx?processname="+_process);
            $("#frmProperty").attr("src", "");
        }

        function openDataSource() {
            $("#frmProperty").attr("src", "../Ultimus.UWF.Form/DatasourceList.aspx");
        }

        function openFunctionalApprover() {
            $("#frmProperty").attr("src", "FunctionalApprover/FunctionList.aspx?processname=" + _process);
        }

        function openDoA() {
            $("#frmProperty").attr("src", "DOAManager/DOALIST.aspx?processname=" + _process);
        }

        function openLanguage() {
            $("#frmProperty").attr("src", "../Ultimus.UWF.Configuration/LanguageList.aspx?namespace=" + _process);
        }
    </script>
</body>
</html>
