var xmlHttp;

function currentinfo() { 
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null) {
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=stateChanged;
	var url="currentinfo.asp";
	url=url+"?sid="+Math.random();
	url=url+"&mode=display";
	url=url+"&names="+document.getElementById('names').value;
	url=url+"&uniqueid="+document.getElementById('uniqueid').value;
	url=url+"&admin="+document.getElementById('admin').value;
	url=url+"&hide="+document.getElementById('hide').value;
	url=url+"&votes=";
	delim = '';
	for(i=0; i<document.radio.elements.length; i++) {
		if(document.radio.elements[i].name.substring(0,4) == 'vote') {
			if(document.radio.elements[i].checked) {
				url=url+delim+document.radio.elements[i].value;
				delim=',';
			}
		}
	}
	if(document.radio.submitcomment.checked) {
		url=url+"&comment="+document.radio.comment.value;
		document.radio.submitcomment.checked = false;
		document.radio.comment.value = '';
	}
	
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
	if (xmlHttp.readyState==4) {
		//alert(document.getElementById("currentinfo").innerHTML);
		var mySplitResult = xmlHttp.responseText.split('~~~');
		document.getElementById("currentinfo").innerHTML = mySplitResult[0];
		document.getElementById("discussion").innerHTML = mySplitResult[1];
	}
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