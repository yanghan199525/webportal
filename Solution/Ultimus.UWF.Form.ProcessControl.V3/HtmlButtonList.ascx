<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HtmlButtonList.ascx.cs" Inherits="Ultimus.UWF.Form.ProcessControl.V3.HtmlButtonList" %>

<div style="display:none">
    <input id="fld_FORMID" type="text" name="MainTable[FORMID]" value="<%=GetParentPage().GetFormValue("FORMID") %>" />
    <input id="txtTaskID" type="text" name="QueryString[TaskID]" value="<%=Request["TaskID"] %>" />
    <input id="txtProcessName" type="text" name="QueryString[ProcessName]" value="<%=Request["ProcessName"] %>" />
    <input id="txtIncident" type="text" name="QueryString[Incident]" value="<%=Request["Incident"] %>" />
    <input id="txtType" type="text" name="QueryString[Type]" value="<%=Request["Type"] %>" />
    <input id="txtStepName" type="text" name="QueryString[StepName]" value="<%=Request["StepName"] %>" />
</div>
