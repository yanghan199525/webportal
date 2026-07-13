function DocWrite(strHTML)
{
document.write(strHTML);
}
function AddNewFrame(url,bottom)
{
    var newFrame = window.parent.document.createElement("frame");
    newFrame.id = "CustomURL";
    newFrame.name = "CustomURL";
    newFrame.src = url;
    var frameset = window.parent.document.getElementById("theMain");
    if(bottom == true)
    	frameset.rows = "70%, *"
    else
	frameset.cols = "70%, *";
    frameset.appendChild(newFrame);
}
function RemoveAddedFrame()
{
	var frameset = window.parent.document.getElementById("theMain");
	var customframe = window.parent.document.getElementById("CustomURL");
	if(customframe != null)
	{
		frameset.removeChild(customframe);
		frameset.rows = "100%"
		frameset.cols = "100%";
	}
}

<!-- ********** TEXT FOR ultimuswait.htm  PAGE *********** -->

function ultimuswait_showlocalebodytext(strLanguage)
{
var currlocale = strLanguage.substring(0,2);

if("en" == currlocale){
document.title = "Please Wait While The Form Loads"; 
document.write("<CENTER><H1>Loading Form. <\/H1><\/CENTER>");
document.write("<CENTER><H1>Please Wait.....<\/H1><\/CENTER>");
}
else if ("de" == currlocale){   
document.title = "Bitte warten Sie, während das Formular lädt";		
document.write("<CENTER><H1>Das Formular wird geladen.<\/H1><\/CENTER>");
document.write("<CENTER><H1>Bitte warten..... <\/H1><\/CENTER>");
}
else if ("es" == currlocale)
{
document.title = "Por favor espere mientras se carga el formulario"; 
document.write("<CENTER><H1>Cargando Formulario. <\/H1><\/CENTER>");
document.write("<CENTER><H1>Por favor espere.....<\/H1><\/CENTER>");
}
else
{
	document.title = "Please Wait While The Form Loads"; 
	document.write("<CENTER><H1>Loading Form Default. <\/H1><\/CENTER>");
	document.write("<CENTER><H1>Please Wait..... <\/H1><\/CENTER>");
}
}


<!-- ********** TEXT FOR ultimussubmit.htm  PAGE *********** -->


function ultimussubmit_showlocalebodytext(strLanguage)
{
var currlocale = strLanguage.substring(0,2);

if("en" == currlocale){
	document.title = "Form Submitted";
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Form Submitted 
Successfully...</FONT></B></CENTER>");
}
else if ("de" == currlocale){   
	document.title = "Das Formular wurde gesendet";		
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Das Formular wurde erfolgreich 
gesendet...</FONT></B></CENTER>");
}
else if ("es" == currlocale){   
	document.title = "Formulario Enviado";		
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Formulario Enviado con Éx
ito...</FONT></B></CENTER>");
}
else
{
	document.title = "Form Submitted";
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Form Submitted 
Successfully...</FONT></B></CENTER>");
}
}


<!-- ********** TEXT FOR ultimussubmitwait.htm  PAGE *********** -->


function ultimussubmitwait_showlocalebodytext(strLanguage)
{
var currlocale = strLanguage.substring(0,2);

if("en" == currlocale){
	document.title = "Form Submitted";
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Submitting Form.</FONT></B></CENTER>");
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Please Wait...</FONT></B></CENTER>");
}
else if ("de" == currlocale){   
			document.title = "Das Formular wurde gesendet";		
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Das Formular wird 
gesendet.</FONT></B></CENTER>");
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Bitte warten...</FONT></B></CENTER>");
}
else if ("es" == currlocale){   
			document.title = "Formulario Enviado";		
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Enviando Formulario.</FONT></B></CENTER>");
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Por favor espere...</FONT></B></CENTER>");
}
else
{
	document.title = "Form Submitted";
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Submitting Form.</FONT></B></CENTER>");
	document.write("<CENTER><B><FONT FACE=\"Arial,Helvetica\" SIZE=\"+3\">Please Wait...</FONT></B></CENTER>");
}
}


<!-- ********** TEXT FOR FORM_DOESNOTEXISTS_ERROR.htm  PAGE *********** -->


function FORM_DOESNOTEXISTS_ERROR_showlocalebodytext(strLanguage)
{
var currlocale = strLanguage.substring(0,2);

if("en" == currlocale){
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"6\">The following error occurred while opening 
a form:</font></b></p>");
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"4\">The requested form cannot be opened. <br> 
The Default Form for this Step is not available.</font></b></p>");
}
else if ("de" == currlocale){   
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"6\">Der folgende Fehler ist beim Öffnen eines 
Formulars aufgetreten:</font></b></p>");
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"4\">Das angeforderte Formular kann nicht geöf
fnet werden. <br> Das Standardformular für diesese Aufgabe ist nicht verfügbar.</font></b></p>");
}
else if ("es" == currlocale){   
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"6\">El siguiente error ocurri?luego de abrir 
el formulario:</font></b></p>");
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"4\">El formulario solicitado no se puede 
abrir. <br> El formulario predeterminado para esta etapa no est?disponible.</font></b></p>");
}
else
{
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"6\">The following error occurred while opening 
a form:</font></b></p>");
	document.write("<p align=\"center\"><b><font color=\"#000000\" size=\"4\">The requested form cannot be opened. <br> 
The Default Form for this Step is not available.</font></b></p>");
}
}

<!-- ********** TEXT FOR FCO install message  PAGE *********** -->
function FCONotInstalled_ShowTranslatedMessageBox(strLanguage)
{
var currlocale = strLanguage.substring(0,2);
if("en" == currlocale)
	{
		//alert("This task cannot be opened as the “FCO?component is not available on your machine. Please contact 
Ultimus System Administrator for further assistance.");
		alert("Ultimus Forms cannot be opened as the necessary Ultimus .NET control is not installed on this 
machine");
	}
else if("de" == currlocale)
	{
		alert("Das Ultimus Formular kann nicht geöffnet werden, da die notwendige .NET Komponente nicht auf diesem 
Computer installiert ist.");
	}
else if ("es" == currlocale)
	{
		alert("No se puede abrir el formulario de Ultimus. El control .NET requerido no est?instalado en su estación 
de trabajo.");
	}
else
	{
		alert("Ultimus Forms cannot be opened as the necessary Ultimus .NET control is not installed on this 
machine");
	}
}


var path = "http://localhost:8080";

document.write("<script language='javascript' src='" + path + "/assets/js/jquery.js'></script>");
document.write("<script language='javascript' src='" + path + "/assets/js/standard.js'></script>");
