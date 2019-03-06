var xmlHttp;
function inhibitemail(passid,passchecked,memberid) {
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=stateChanged;
	var url="inhibitemail.asp";
	url=url+"?sid="+Math.random();
	url=url+"&messageid="+passid;
	url=url+"&personid="+memberid;
	url=url+"&checked="+passchecked;
	
	xmlHttp.open("GET",url,true);  
	/*
	What is this true/false all about?
	Optional. Variant that specifies true for asynchronous operation (the call returns immediately), or 
	false otherwise. If true, assign a callback handler to the onreadystatechange property to determine 
	when the call has completed. If not specified, the default is true. 
	*/
	xmlHttp.send(null);
	//document.getElementById("currentinfo").innerHTML; //only needed if false above
}

function closeforum(passid,passchecked) {
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=stateChanged;
	var url="closeforum.asp";
	url=url+"?sid="+Math.random();
	url=url+"&messageid="+passid.substring(6);
	url=url+"&checked="+passchecked;
	
	xmlHttp.open("GET",url,true);  
	/*
	What is this true/false all about?
	Optional. Variant that specifies true for asynchronous operation (the call returns immediately), or 
	false otherwise. If true, assign a callback handler to the onreadystatechange property to determine 
	when the call has completed. If not specified, the default is true. 
	*/
	xmlHttp.send(null);
	//document.getElementById("currentinfo").innerHTML; //only needed if false above
}


function stateChanged() { 
	//only needed in true above, however MSexplorer will go through here too.
	//if (xmlHttp.readyState==4) {
		//alert(document.getElementById("currentinfo").innerHTML);
		//var mySplitResult = xmlHttp.responseText.split('~~~');
		//document.getElementById("photos").innerHTML = mySplitResult[0];
		//alert(xmlHttp.responseText);
	//}
}

function GetXmlHttpObject() {
	var xmlHttp=null;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer
		try {
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	return xmlHttp;
}