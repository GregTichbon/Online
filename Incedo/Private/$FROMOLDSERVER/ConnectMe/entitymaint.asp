<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if


	commstatuses = array("Yes","No")
	id = request.querystring("id")
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\connectme.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

	dim commids()
	dim commtypes() 
	dim commtxt()
	dim commemail()
	sql = "SELECT * FROM communicationstype order by id, communicationstype"
	rs.Open sql, db
	do until rs.eof
		c1 = c1 + 1
		redim preserve commtypes(c1) 
		redim preserve commids(c1) 
		redim preserve commtxt(c1) 
		redim preserve commemail(c1) 
		commids(c1) = rs("id")
		commtypes(c1) = rs("communicationstype")
		commtxt(c1) = rs("txt")
		commemail(c1) = rs("email")
		rs.movenext
	loop
	rs.close
	

	if id <> "new" then
		sql = "SELECT * FROM ConnectMe where id = " & id
		rs.Open sql, db
		if not rs.eof then
			organisation = rs.fields("organisation") & ""
			firstname = rs.fields("firstname") & ""
			surname = rs.fields("surname") & ""
			title = rs.fields("title") & ""
			initials = rs.fields("initials") & ""
			knownas = rs.fields("knownas") & ""
			greeting = rs.fields("greeting") & ""
			recipient = rs.fields("recipient") & ""
			postaladdress = rs.fields("postaladdress") & ""
			nzpostalcode = rs.fields("nzpostalcode") & ""
			nzpostalsuburb = rs.fields("nzpostalsuburb") & ""
			nzpostalcity = rs.fields("nzpostalcity") & ""
			region = rs.fields("region") & ""
			status = rs.fields("status") & ""
			statusreviewdate = rs.fields("statusreviewdate") & ""
			birthdate = rs.fields("birthdate")
			created = rs.fields("created")
			modified = rs.fields("modified")
			newpostcode = rs.fields("newpostcode")
			if newpostcode then newpostcodechecked = " checked"
			if organisation <> "" and (firstname & surname & title & initials & knownas <> "") then
				mytype = "both"
			elseif organisation <> "" then
				mytype = "group"
			elseif firstname & surname & title & initials & knownas <> "" then
				mytype = ""
			else
				mytype = "none"
			end if
			notes = rs.fields("notes") & ""
			caregivers = rs.fields("caregivers") & ""
			includeemail = rs.fields("includeemail")
			if includeemail then includeemailchecked = " checked"
			includetxt  = rs.fields("includetxt")
			if includetxt then includetxtchecked = " checked"
			includepost  = rs.fields("includepost")
			if includepost then includepostchecked = " checked"
		else
			includeemailchecked = " checked"
			includetxtchecked = " checked"
			includepostchecked = " checked"
			region = "Northland"
		end if
		rs.close
	else
		includeemailchecked = " checked"
		includetxtchecked = " checked"
		includepostchecked = " checked"
		region = "Northland"
		mytype = "none"
	end if
%>
<html>
<head>
<title>Incedo ConnectMe</title>
<script type="text/javascript" src="Javascript/validateEmail.js"></script>
<script language="JavaScript">
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;
	if(frm.organisation.value == '' && frm.firstname.value == '' && frm.surname.value == '') {
		msg = msg + delim + ' - Name';
		delim = '\n';
	}
	if(frm.organisation.value != '' && (frm.firstname.value != '' || frm.surname.value != '')) {
		msg = msg + delim + ' - An organisation or a person/';
		delim = '\n';
	}
	/*
	if(frm.email.value != '') {
		if(!(IsEmail(frm.email.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}
	*/
<%
if 1=2 then
%>	
	missingdetails = false;
	missingtypes = false;
	commasused = false;
	numrows = document.getElementById("commtable").rows.length - 1
	
	for (i = 0; i < numrows; i++ ) {
		if(numrows <= 1) {
			mycommtype = document.maint.commtype.value;
			mycommdetail = document.maint.commdetail.value;
			mycommnote = document.maint.commnote.value;
		}
		else {
			mycommtype = document.maint.commtype[i].value;
			mycommdetail = document.maint.commdetail[i].value;
			mycommnote = document.maint.commnote[i].value;
		}
			
		if(mycommtype != '') {
			if(mycommdetail == '') {
				missingdetails = true;
			}
		}
		else {
			if(mycommdetail != '' || mycommnote != '') {
				missingtypes = true;
			}
		}
		if(mycommdetail.indexOf(",") > 0 || mycommnote.indexOf(",") > 0) {
			commasused = true;
		}
	}

	if(missingdetails == true) {
		msg = msg + delim + 'Details for all communication types';
		delim = '\n';
	}

	if(missingtypes == true) {
		msg = msg + delim + 'Types for all communication details';
		delim = '\n';
	}
	
	if(commasused == true) {
		msg = msg + delim + 'Commas can not be used in the communications details or notes';
		delim = '\n';
	}
<%
end if
%>
	if(msg != '') {
		alert('You must enter valid information for the following:\n' + msg);
		return(false);
	}
}

function setoptions(optname, occur) {
	var frm = document.maint;
	switch(optname) {
		case 'newpostcode' :
			frm.newpostcode[1].checked = !(frm.newpostcode[0].checked);
			break;
		case 'includeemail' :
			frm.includeemail[1].checked = !(frm.includeemail[0].checked);
			break;
		case 'includetxt' :
			frm.includetxt[1].checked = !(frm.includetxt[0].checked);
			break;
		case 'includepost' :
			frm.includepost[1].checked = !(frm.includepost[0].checked);
			break;
		/*
		case '$classification' :
			obj = document.getElementsByName('$classification' + occur);
			obj[1].checked = !(obj[0].checked);
			//alert(obj[0].checked + '|' + obj[1].checked);
			break;
		*/
		default :
			alert(optname + ' not allowed');
	}
}

function selecttype() {
	var frm = document.maint;
	if(frm.$type[0].checked) {
		obj = document.getElementById('people');		
		obj.style.display = '';
		obj = document.getElementById('group');		
		obj.style.display = 'none';
	} 
	else {
		if(frm.$type[1].checked) {
			obj = document.getElementById('group');		
			obj.style.display = '';
			obj = document.getElementById('people');		
			obj.style.display = 'none';
		} 
		else {
			if('<%=mytype%>' == 'both') {
				alert('This record has information for both  and organisation / group');
				obj = document.getElementById('group');		
				obj.style.display = '';
				obj = document.getElementById('people');		
				obj.style.display = '';
			}
			else {
				if('<%=mytype%>' == 'none') {
					obj = document.getElementById('group');		
					obj.style.display = 'none';
					obj = document.getElementById('people');		
					obj.style.display = 'none';
				}
				else {
					alert('Error in type')
				}
			}
		}
	}
}


function startup() {
	var frm = document.maint;
	switch('<%=mytype%>') {
		case '' :
			frm.$type[0].checked = true;
			break;
		case 'group' :
			frm.$type[1].checked = true;
			break;
	}
	selecttype();
}

if (window.onload) {
	var func = window.onload; 
	window.onload = function() {
		func();
		startup();
	}
} 
else {
	window.onload = startup;
}
var popUpWin=0;
function popUpWindow(URLStr) {
	if(URLStr != '') {
		if(popUpWin) {
			if(!popUpWin.closed) popUpWin.close();
		}
		popUpWin = open(URLStr, 'popUpWin','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,copyhistory=0,width=650,height=400,left=50,top=50,screenX=50,screenY=50');
		popUpWin.focus
	}
}
function showoutertab(mylayer) {
	myArray = new Array('divclassifications','divnotes')
	for (i=0; i < myArray.length; ++i) {
		//alert(myArray[i] + '|' + mylayer);
		if(myArray[i] == mylayer) {
			document.getElementById(myArray[i]).style.display = "";
		}
		else {
			document.getElementById(myArray[i]).style.display = "none";
		}
	}
}

function drawcommoptions(addsub) {
	var tbl = document.getElementById("commtable");
	if(addsub == 0) {
		//add a row
		var targetnumrows = tbl.rows.length;
		var row = tbl.insertRow(tbl.rows.length);
		

		var cell = row.insertCell(0);

		var commid = document.createElement("input");
		commid.setAttribute("type", "hidden");
		commid.setAttribute("id", "$commid");
		commid.setAttribute("name", "$commid");
		commid.setAttribute("value", "0");
		cell.appendChild(commid);

		var commtype = document.createElement("select");
		commtype.setAttribute("id", "$commtype");
		commtype.setAttribute("name", "$commtype");
		cell.appendChild(commtype);
	   
		theOption=document.createElement("OPTION");
		theText=document.createTextNode("--- Please Select ---");
		theOption.appendChild(theText);
		commtype.appendChild(theOption);

<%
for f1=1 to ubound(commids)
		response.write "theOption=document.createElement('OPTION');"
		response.write "theText=document.createTextNode('" & commtypes(f1) & "');"
		response.write "theOption.value = '" & commids(f1) & "';"
		response.write "theOption.appendChild(theText);"
		response.write "commtype.appendChild(theOption);"
next
%>		

		cell = row.insertCell(1);
		var commdetail = document.createElement("input");
		commdetail.setAttribute("type", "text");
		commdetail.setAttribute("id", "$commdetail");
		commdetail.setAttribute("name", "$commdetail");
		//commdetail.setAttribute("value", "");
		cell.appendChild(commdetail);
		
		cell = row.insertCell(2);
		var commnote = document.createElement("input");
		commnote.setAttribute("type", "text");
		commnote.setAttribute("id", "$commnote");
		commnote.setAttribute("name", "$commnote");
		commnote.setAttribute("size", "60");
		//commnote.setAttribute("value", "");
		cell.appendChild(commnote);
		
		cell = row.insertCell(3);
		var commdelete = document.createElement("div");
		commdelete.setAttribute("id", "$commdelete" + targetnumrows);
		commdelete.innerHTML = '<a href="javascript:drawcommoptions(' + targetnumrows + ');">Delete</a>';
		cell.appendChild(commdelete);

		cell = row.insertCell(3);
		var commstatus = document.createElement("select");
		commstatus.setAttribute("id", "$commstatus");
		commstatus.setAttribute("name", "$commstatus");
		cell.appendChild(commstatus);

<%
for f1=0 to ubound(commstatuses)
		response.write "theOption=document.createElement('OPTION');"
		response.write "theText=document.createTextNode('" & commstatuses(f1) & "');"
		response.write "theOption.value = '" & commstatuses(f1) & "';"
		response.write "theOption.appendChild(theText);"
		response.write "commstatus.appendChild(theOption);"
next
%>		
	}
	else {
		tbl.deleteRow(addsub);
		for(var i=1; i < tbl.rows.length; i++) {
			if(i >= addsub) {
				document.getElementById('$commdelete' + (i+1)).innerHTML = '<a href="javascript:drawcommoptions(' + i + ');">Delete</a>';
				document.getElementById('$commdelete' + (i+1)).setAttribute("id", "$commdelete" + i)
			}
		}
   }
}
</script>
<style type="text/css">
<!--
.fields {
	width: 100%;
}
.style3 {font-size: large}
.style4 {font-size: x-small}
-->
</style>
</head>
<body>
<div align="center">
  <form name="maint" method="post" action="entitymaint_process.asp" OnSubmit="return checkform();">
    <input name="id" type="hidden" id="id" value="<%=id%>">
    <table border="1" cellspacing="0" cellpadding="5" width="600">
      <tr>
        <td width="150"><div align="right">Type</div></td>
        <td width="206"><div align="center">
            <input name="$type" type="radio" onClick="javascript:selecttype()" value="">
            Person / </div></td>
        <td width="206"><div align="center">
            <input name="$type" type="radio" onClick="javascript:selecttype()" value="group">
            Organisation / Group</div></td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600" id="group" style="display:none">
      <tr>
        <td width="150"><div align="right">Organisation</div></td>
        <td><input name="organisation" type="text" value="<%=organisation%>" class="fields"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Recipient</div></td>
        <td><input name="recipient" type="text" class="fields" id="recipient" value="<%=recipient%>" size="50"></td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600" id="people" style="display:none">
      <tr>
        <td width="150"><div align="right">First name(s)</div></td>
        <td><input name="firstname" type="text" value="<%=firstname%>" class="fields"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Surname</div></td>
        <td><input name="surname" type="text" value="<%=surname%>" class="fields"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Initials</div></td>
        <td><input name="initials" type="text" id="initials" value="<%=initials%>" size="50"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Title</div></td>
        <td><input name="title" type="text" id="title" value="<%=title%>" size="50"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Known as </div></td>
        <td><input name="knownas" type="text" id="knownas" value="<%=knownas%>" class="fields"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Birthdate</div></td>
        <td><input name="birthdate" type="text" id="birthdate" value="<%=birthdate%>" class="fields"></td>
      </tr>
	  <tr>
        <td width="150"><div align="right">Caregivers</div></td>
        <td><textarea name="caregivers" cols="50" rows=5 class="fields" id="notes"><%=caregivers%></textarea></td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600">
      <tr>
        <td width="150"><div align="right">Greeting</div></td>
        <td><input name="greeting" type="text" class="fields" id="greeting" value="<%=greeting%>" size="50"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Postal Address </div></td>
        <td><textarea name="postaladdress" cols="50" rows=5 class="fields" id="postaladdress"><%=postaladdress%></textarea></td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600">
      <tr>
        <td width="150"><div align="right">NZ Postal City </div></td>
        <td><select name="nzpostalcity" size="1" id="nzpostalcity">
            <option value=""></option>
            <%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * FROM nzpostalcity order by city"
	rs1.Open sql, db
	do until rs1.eof
		thiscity = rs1("city")
		if nzpostalcity = thiscity then
			selected = " selected"
		else
			selected = ""
		end if
		response.write "<option value=""" & thiscity & """" & selected & ">" & thiscity & "</option>"
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
%>
          </select></td>
      </tr>
      <tr>
        <td width="150"><div align="right">NZ Postal Suburb </div></td>
        <td><input name="nzpostalsuburb" type="text" class="fields" id="nzpostalsuburb" value="<%=nzpostalsuburb%>" size="20"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">NZ Postal Code</div></td>
        <td><input name="nzpostalcode" type="text" id="nzpostalcode" value="<%=nzpostalcode%>" size="10" maxlength="4">
          New Post Code
          <input type="checkbox" name="newpostcode" id="newpostcode" onClick="javascript:setoptions('newpostcode')" value="-1"<%=newpostcodechecked%>>
          <input name="newpostcode" type="checkbox" id="newpostcode" style="display:none" value="0">
&nbsp;&nbsp;<a href="javascript:void(0)" onClick="popUpWindow('http://www.nzpost.co.nz/Cultures/en-NZ/OnlineTools/PostCodeFinder/APLT.htm')">Search</a></td>
      </tr>
      <tr>
        <td width="150"><div align="right">  Region</div></td><td>
<%if 1=1 then%>
          <input name="region" type="hidden" id="region" value="<%=region%>">
		  <%=region%>
<%else%>
        <select name="region" size="1" id="region">
            <option value="">---Please Select---</option>
            <%
	for f1=1 to numregions
		thisregion = regions(f1)
		if region = thisregion then
			selected = " selected"
		else
			selected = ""
		end if
		response.write "<option value=""" & thisregion & """" & selected & ">" & thisregion & "</option>"
	next
%>
          </select>
<%end if%>
        </td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600">
      <tr>
        <td width="150"><div align="right">Action status</div></td>
        <td><select name="status" size="1" id="status">
            <option value=""></option>
            <%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * FROM status order by status"
	rs1.Open sql, db
	do until rs1.eof
		thisstatus = rs1("status")
		if status = thisstatus then
			selected = " selected"
		else
			selected = ""
		end if
		response.write "<option value=""" & thisstatus & """" & selected & ">" & thisstatus & "</option>"
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
%>
          </select>
          <span style="visibility:hidden">Review:
          <input name="statusreviewdate" type="text" id="statusreviewdate" value="<%=statusreviewdate%>" size="20">
          </span></td>
      </tr>
      <%
if id <> "new" then
%>
      <tr>
        <td width="150"><div align="right">Include General </div></td>
        <td> 
		<input type="checkbox" name="includeemail" id="includeemail" onClick="javascript:setoptions('includeemail')" value="-1"<%=includeemailchecked%>>
		<input name="includeemail" type="checkbox" id="includeemail" style="display:none" value="0">
		Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		<input type="checkbox" name="includetxt" id="includetxt" onClick="javascript:setoptions('includetxt')" value="-1"<%=includetxtchecked%>>
		<input name="includetxt" type="checkbox" id="includetxt" style="display:none" value="0">
		Txts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		<input type="checkbox" name="includepost" id="includepost" onClick="javascript:setoptions('includepost')" value="-1"<%=includepostchecked%>>
		<input name="includepost" type="checkbox" id="includepost" style="display:none" value="0">
		Post          

</td>
      </tr> 
	       <tr>
        <td width="150"><div align="right">Notes</div></td>
        <td><textarea name="notes" cols="50" rows=5 class="fields" id="notes"><%=notes%></textarea></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Created</div></td>
        <td><%=created%>&nbsp;</td>
      </tr>
      <tr>
        <td width="150"><div align="right">Modified</div></td>
        <td><%=modified%>&nbsp;</td>
      </tr>
      <%
end if
%>
    </table>

    <table width="800" border="2" align="center" cellpadding="3" cellspacing="0">
      <tr>
        <th><div align="center">Communications</div></th>
        <th><a href="javascript:drawcommoptions(0);">Add</a></th>
      </tr>
    </table>
    <table width="800" border="2" align="center" cellpadding="3" cellspacing="0" id="commtable">
      <th>Type</th>
        <th>Detail</th>
        <th>Notes</th>
        <th>Use</th>
        <th>Delete</th>
      </tr>
<%
	if id <> "new" then
		sqlstring = "SELECT ConnectMe_Communications.ID, ConnectMe_Communications.Type, ConnectMe_Communications.Detail, ConnectMe_Communications.Note, ConnectMe_Communications.Status, CommunicationsType.CommunicationsType, CommunicationsType.Email, CommunicationsType.Txt " & _
				    "FROM CommunicationsType INNER JOIN ConnectMe_Communications ON CommunicationsType.ID = ConnectMe_Communications.Type " & _
 				    "where connectme = " & ID & " order by CommunicationsType.id"
		rs.Open sqlstring, db
		do until rs.eof
			row = row + 1
			response.write "<tr>"
			response.write "<td>"
			response.write "<select name=""$commtype"" size=""1"" id=""$commtype"">"
			for f1 = 1 to ubound(commids)
				if commids(f1) = rs("type") then selected = " selected" else selected = ""
				response.write "<option value=""" & commids(f1) & """" & selected & ">" & commtypes(f1) & "</option>"
			next
			response.write "</select>"
			response.write "</td>"
			response.write "<td>"
			response.write "<input name=""$commid"" type=""hidden"" id=""$commid"" value=""" & rs("id") & """>"
			response.write "<input name=""$commdetail"" type=""text"" id=""commdetail"" value=""" & rs("detail") & """>"
			response.write "</td>"
			response.write "<td>"
			response.write "<input name=""$commnote"" type=""text"" id=""commnote"" size=""60"" value=""" & rs("note") & """>"
			response.write "</td>"
			response.write "<td>"
			response.write "<select name=""$commstatus"" size=""1"" id=""$commstatus"">"
			for f1 = 0 to ubound(commstatuses)
				if commstatuses(f1) = rs("status") then selected = " selected" else selected = ""
				response.write "<option value=""" & commstatuses(f1) & """" & selected & ">" & commstatuses(f1) & "</option>"
			next
			response.write "</select>"
			response.write "</td>"
			response.write "<td>"
			response.write "<div id=""$commdelete" & row & """><a href=""javascript:drawcommoptions(" & row & ")"">Delete</a></div>"
			response.write "</td>"
			response.write "</tr>"
			'response.write "<td>" & rs("type") & "</td><td>" & rs("detail") & "</td><td>" & rs("note") & "</td><td>Delete</td></tr>"
			rs.movenext
		loop
		rs.close
	end if
%>
    </table>

    <span class="style3"><a href="javascript:showoutertab('divclassifications');">Classifications</a> | <a href="javascript:showoutertab('divnotes');">Notes</a></span> <br>
    <div id="divclassifications" style="display:none">
	Classifications<br>
<%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	response.write "<table width=""500"" border=""1"" cellspacing=""0"" cellpadding=""1"">" & vbcrlf
	if id = "new" then
		sql = "SELECT Regions_Classifications.ID, Regions_Classifications.Classification, null as supporter, null as notes " & _
			  "FROM Regions_Classifications WHERE Regions_Classifications.Region = '" & region & "'"
	else
		sql = "SELECT Regions_Classifications.ID, Regions_Classifications.Classification, SQ.connectme, SQ.Notes " & _
			  "FROM Regions_Classifications LEFT JOIN ( " & _
			  "SELECT ConnectMe_Regions_Classifications.connectme, ConnectMe_Regions_Classifications.RegionClassification, ConnectMe_Regions_Classifications.Notes " & _
			  "FROM ConnectMe_Regions_Classifications " & _
			  "WHERE ConnectMe_Regions_Classifications.connectme = " & id & " " & _
			  ") as SQ ON Regions_Classifications.ID = SQ.RegionClassification " & _
			  "WHERE Regions_Classifications.Region = '" & region & "' " & _
			  "ORDER BY Regions_Classifications.Classification"
	end if
'response.write sql
	rs1.Open sql, db
	do until rs1.eof
		if id = "new" then
			checked = ""
		else
			if rs1("connectme") & "" <> "" then
				checked = " checked"
			else
				checked = ""
			end if
		end if
		'response.write "<tr><td>" & rs1("Classification") & "</td><td><input type=""checkbox"" name=""$classification" & rs1("id") & """ id=""$classification" & rs1("id") & """" & checked & " onClick=""javascript:setoptions('$classification', " & rs1("id") & ")"" value=""-1""" & classchecked & "><input type=""checkbox"" name=""$classification" & rs1("id") & """ id=""$classification" & rs1("id") & """ style=""display:none"" value=""0""></td></tr>" & vbcrlf
		'It was setting the value of the option to zero in javascript when an option was unchecked, but now I have written code on the processing page
		'that automatically deletes those not passed through.
		response.write "<tr><td>" & rs1("Classification") & "</td><td><input type=""checkbox"" name=""$classification" & rs1("id") & """ id=""$classification" & rs1("id") & """" & checked & " value=""-1""></td></tr>" & vbcrlf
		rs1.movenext
	loop
	rs1.close
	response.write "</table>" & vbcrlf
	set rs1 = nothing
%>   
    </div>

	<div id="divnotes" style="display:none">
	Notes
        <table width="800" border="1" cellspacing="0" cellpadding="1">
		<tr><td width="100">Date/Description</td><td width="400">Note</td></tr>
<%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
		if id <> "new" then
			sql = "SELECT ConnectMe_Notes.ID, ConnectMe_Notes.Note " & _
				  "FROM ConnectMe_Notes " & _
				  "WHERE ConnectMe_Notes.ConnectMe = " & id
			
			rs1.Open sql, db
			do until rs1.eof
				response.write "<tr><td>" & rs1("date") & "<br>" & rs1("Note") & "</td></tr>"
				rs1.movenext
			loop
			rs1.close
		end if
	set rs1 = nothing
%>
        </table>
	</div>

    <br>
    <input name="$reset" type="reset" id="$reset" value="Reset">
    <input name="$submit" type="submit" id="$submit" value="Submit">
<%
if id <> "new" then 'and session("incedoConnectMe_level") = 9 then
%>
    <input name="$delete" type="submit" id="$delete" value="Delete">
<%
end if
%>
  </form>
<%
	set rs = nothing
	db.close
	set db = nothing
%>
</div>
</body>
</html>



