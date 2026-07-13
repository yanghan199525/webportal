<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectDepartment.aspx.cs" Inherits="Ultimus.UWF.OrgChart.SelectDepartment" %>
<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="keywords" content="jQuery Tree, Tree Widget, Tree" /> 
    <meta name="description" content="The jqxTree can display a checkboxes next to its items. You can also enable three-state checkboxes. In this mode, when the user
     checks an item, its sub items also become checked. When there is an unchecked item, the parent item is in indeterminate state." />
    <title id='Description'>The jqxTree can display a checkboxes next to its items. You can also enable three-state checkboxes. In this mode, when the user
     checks an item, its sub items also become checked. When there is an unchecked item, the parent item is in indeterminate state.</title>
    <link rel="stylesheet" href="/Common/Assets/jqwidgets/styles/jqx.base.css" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/scripts/demos.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxpanel.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxtree.js"></script>
    <script type="text/javascript" src="<%=WebUtil.GetRootPath()%>/Common/Assets/jqwidgets/jqxcheckbox.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // create jqxTree
            var _jobData = null;
            $.ajax({
                async: false,
                url: "../Handler/OrgHandler.ashx?method=GETALLDEPARTMENT",
                dataType: "json",
                success: function (data, status, xhr) {
                    _jobData = data;
                }
            });
            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'DEPARTMENTID' },
                    { name: 'PARENTID' },
                    { name: 'DEPARTMENTNAME' },
                ],
                id: 'DEPARTMENTID',
                localdata: _jobData
            };
            // create data adapter.
            var dataAdapter = new $.jqx.dataAdapter(source);
            // perform Data Binding.
            dataAdapter.dataBind();
            var records = dataAdapter.getRecordsHierarchy('DEPARTMENTID', 'PARENTID', 'items', [{ name: 'DEPARTMENTNAME', map: 'label' }]);
            
            $('#jqxTree').jqxTree({ source: records, height: '400px', hasThreeStates: false, checkboxes: true, width: '330px' });
            $('#jqxTree').css('visibility', 'visible');
            $("#jqxTree").jqxTree('selectItem', $("#home")[0]);
            $('#jqxTree').on('checkChange', function (event) {
                console.log(event);
                var args = event.args;
                var element = args.element;
                var checked = args.checked;
                $("span[class*='jqx-checkbox-check-checked']").removeClass("jqx-checkbox-check-checked");
                $(element).find(".jqx-checkbox-default span:first").addClass("jqx-checkbox-check-checked");
                
            });
        });
    </script>
</head>
<body class='default'>
   
    <div id='jqxWidget'>
        <div style='float: left;'>
            <div id='jqxTree' style='visibility: visible; float: left; margin-left: 20px;'>
               
            </div>
             
        </div>

    </div>
</body>
</html>