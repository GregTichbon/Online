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
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb;"
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
		sql = "SELECT * FROM supporters where id = " & id
		rs.Open sql, db
		if not rs.eof then
			organisation = rs.fields("organisation") & ""
			firstnames = rs.fields("firstnames") & ""
			surname = rs.fields("surname") & ""
			title = rs.fields("title") & ""
			initials = rs.fields("initials") & ""
			knownas = rs.fields("knownas") & ""
			greeting = rs.fields("greeting") & ""
			recipient = rs.fields("recipient") & ""
			family = rs.fields("family")
			if family then familychecked = " checked"
			email = rs.fields("email") & ""
			country = rs.fields("country") & ""
			postaladdress = rs.fields("postaladdress") & ""
			nzpostalcode = rs.fields("nzpostalcode") & ""
			nzpostalsuburb = rs.fields("nzpostalsuburb") & ""
			nzpostalcity = rs.fields("nzpostalcity") & ""
			region = rs.fields("region") & ""
			overseas = rs.fields("overseas")
			if overseas then overseaschecked = " checked"
			status = rs.fields("status") & ""
			statusreviewdate = rs.fields("statusreviewdate") & ""
			created = rs.fields("created")
			modified = rs.fields("modified")
			newpostcode = rs.fields("newpostcode")
			if newpostcode then newpostcodechecked = " checked"
			if organisation <> "" and (firstnames & surname & title & initials & knownas <> "" or family = true) then
				mytype = "both"
			elseif organisation <> "" then
				mytype = "group"
			elseif firstnames & surname & title & initials & knownas <> "" or family = true then
				mytype = ""
			else
				mytype = "none"
			end if
			notes = rs.fields("notes") & ""
			camefrom = rs.fields("camefrom") & ""
		end if
		rs.close
	else
		mytype = "none"
	end if
	allregionsstring = ""
	dim regions(20)
	numregions = 0
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * FROM regions order by region"
	rs1.Open sql, db
	do until rs1.eof
		thisregion = rs1("region")
		allregionsstring = allregionsstring & "|" & thisregion
		allregions = allregions & delim & "'" & thisregion & "'"
		delim = ","
		numregions = numregions + 1
		regions(numregions) = thisregion
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
%>
<html>
<head>
<title>Incedo Supporters</title>
<script type="text/javascript" src="Javascript/validateEmail.js"></script>
<script language="JavaScript">
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;
	if(frm.organisation.value == '' && frm.firstnames.value == '' && frm.surname.value == '') {
		msg = msg + delim + ' - Name';
		delim = '\n';
	}
	if(frm.organisation.value != '' && (frm.firstnames.value != '' || frm.surname.value != '')) {
		msg = msg + delim + ' - An organisation or a person/';
		delim = '\n';
	}
	if(frm.email.value != '') {
		if(!(IsEmail(frm.email.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}

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

function setoptions(optname) {
	document.getElementsByName(optname)[1].checked = !(document.getElementsByName(optname)[0].checked);
/*	
	var frm = document.maint;
	switch(optname) {
		case 'family' :
			frm.family[1].checked = !(frm.family[0].checked);
			break;
		case 'overseas' :
			frm.overseas[1].checked = !(frm.overseas[0].checked);
			break;
		case 'newpostcode' :
			frm.newpostcode[1].checked = !(frm.newpostcode[0].checked);
			break;
*/
		/*
		case '$classification' :
			obj = document.getElementsByName('$classification' + occur);
			obj[1].checked = !(obj[0].checked);
			//alert(obj[0].checked + '|' + obj[1].checked);
			break;
		*/
/*		default :
			alert(optname + ' not allowed');
	}
*/
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

function selectpostal() {
	var frm = document.maint;
	var obj = document.getElementById('nzpost');
	if(frm.country.value == 'New Zealand') {
		obj.style.display = '';
	}
	else {
		if(frm.nzpostalcode.value != '' || frm.nzpostalsuburb.value != '' || frm.nzpostalcity.value != '') {
			alert('You must clear out the NZ Postal details first');
			frm.country.value == 'New Zealand';
		}
		else {
			obj.style.display = 'none';
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
	selectpostal();
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
	myArray = new Array('regions','classifications','mailouts')
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
function showtab(mylayer) {
	myArray = new Array(<%=allregions%>)
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
        <td><input name="firstnames" type="text" value="<%=firstnames%>" class="fields"></td>
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
        <td width="150"><div align="right">Family</div></td>
        <td><input name="family" type="checkbox" id="family" onClick="javascript:setoptions('family')" value="-1"<%=familychecked%>>
          <input name="family" type="checkbox" id="family" style="display:none" value="0"></td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600">
      <tr>
        <td width="150"><div align="right">Greeting</div></td>
        <td><input name="greeting" type="text" class="fields" id="greeting" value="<%=greeting%>" size="50"></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Country</div></td>
        <td><select name="country" size="1" id="country" onchange="javascript:selectpostal()">
            <option value=""></option>
            <%
		
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\generic.mdb;"
	Set dbc = Server.CreateObject("ADODB.Connection")
	dbc.Open connection_string
	Set rsc = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * FROM country order by country"
	rsc.Open sql, db
	do until rsc.eof
		thiscountry = rsc("country")
		if country = thiscountry then
			selected = " selected"
		else
			selected = ""
		end if
		response.write "<option value=""" & thiscountry & """" & selected & ">" & thiscountry & "</option>"
		rsc.movenext
	loop
	rsc.close
	set rsc = nothing
	dbc.close
	set dbc = nothing
%>
          </select></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Overseas flag </div></td>
        <td>          <input type="checkbox" name="overseas" id="overseas" onClick="javascript:setoptions('overseas')" value="-1"<%=overseaschecked%>>
          <input name="overseas" type="checkbox" id="overseas" style="display:none" value="0">
<span class="style4">(Will use country eventually) </span></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Postal Address </div></td>
        <td><textarea name="postaladdress" cols="50" rows=5 class="fields" id="postaladdress"><%=postaladdress%></textarea></td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600" id="nzpost" style="display:''">
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
        <td width="150"><div align="right"> Residential Region</div></td>
        <td><select name="region" size="1" id="region">
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
          <input name="$allregionsstring" type="hidden" id="$allregionsstring" value="<%=allregionsstring%>">
        </td>
      </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="5" width="600">
      <tr>
        <td width="150"><div align="right">Email</div></td>
        <td><input name="email" type="text" class="fields" value="<%=email%>" size="50"></td>
      </tr>
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
        <td width="150"><div align="right">Notes</div></td>
        <td><textarea name="notes" cols="50" rows=5 class="fields" id="notes"><%=notes%></textarea></td>
      </tr>
      <tr>
        <td width="150"><div align="right">Came from </div></td>
        <td><%=camefrom%></td>
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
		sqlstring = "SELECT Supporters_Communications.ID, Supporters_Communications.Type, Supporters_Communications.Detail, Supporters_Communications.Note, Supporters_Communications.Status, CommunicationsType.CommunicationsType, CommunicationsType.Email, CommunicationsType.Txt " & _
				    "FROM CommunicationsType INNER JOIN Supporters_Communications ON CommunicationsType.ID = Supporters_Communications.Type " & _
 				    "where Supporter = " & ID & " order by CommunicationsType.id"
'response.write sqlstring
'response.end
					
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

    <span class="style3"><a href="javascript:showoutertab('regions');">Regions</a> | <a href="javascript:showoutertab('classifications');">Mission Base Classifications</a> | <a href="javascript:showoutertab('mailouts');">Mailouts</a></span> <br>
      <div id="regions" style="display:none">Regions
        <table width="500" border="1" cellspacing="0" cellpadding="1">
<%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	for f1=1 to numregions
		myregion = regions(f1)
		checked = ""
		if id <> "new" then
			sql = "SELECT * FROM supporters_Regions where supporter = " & id & " and region = '" & myregion & "'"
'response.write "<tr><td>" & sql & "</td></tr>"
'response.end
			rs1.Open sql, db
			if not rs1.eof then
				checked = " checked"
			end if
			rs1.close
		end if
		response.write "<tr><td>" & myregion & "</td><td><input type=""checkbox"" name=""$associatedregion"" value=""" & myregion & """" & checked & "></td></tr>"
	next
	set rs1 = nothing
%>
        </table>
      </div>	
    <div id="classifications" style="display:none">
	Mission Base Classifications<br>
<%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	delim = ""
	for f1=1 to numregions
		myregion = regions(f1)
		if id <> "new" then
			sql = "SELECT Count(Supporters_Regions_Classifications.ID) AS CountOfID " & _
			"FROM Regions_Classifications INNER JOIN Supporters_Regions_Classifications ON Regions_Classifications.ID = Supporters_Regions_Classifications.RegionClassification " & _
			"WHERE Supporters_Regions_Classifications.Supporter = " & id & " AND Regions_Classifications.Region = '" & myregion & "'"		
			rs1.open sql,db
			regionclass = rs1("CountOfID")
			rs1.close
		end if
		if regionclass > 0 then
			response.write delim & "<a href=""javascript:showtab('" & myregion & "');""><b>" & myregion & "</b></a>"
		else
			response.write delim & "<a href=""javascript:showtab('" & myregion & "');"">" & myregion & "</a>"
		end if
		delim = " | "
	next
%>
      <%
	for f1=1 to numregions
		myregion = regions(f1)
	 	response.write "<div id=""" & myregion & """ style=""display:none"">" & myregion & vbcrlf
	    response.write "<table width=""500"" border=""1"" cellspacing=""0"" cellpadding=""1"">" & vbcrlf
		if id = "new" then
			sql = "SELECT Regions_Classifications.ID, Regions_Classifications.Classification, null as supporter, null as notes " & _
				  "FROM Regions_Classifications WHERE Regions_Classifications.Region = '" & myregion & "'"
		else
			sql = "SELECT Regions_Classifications.ID, Regions_Classifications.Classification, SQ.Supporter, SQ.Notes " & _
				  "FROM Regions_Classifications LEFT JOIN ( " & _
				  "SELECT supporters_Regions_Classifications.Supporter, supporters_Regions_Classifications.RegionClassification, supporters_Regions_Classifications.Notes " & _
				  "FROM supporters_Regions_Classifications " & _
				  "WHERE supporters_Regions_Classifications.Supporter = " & id & " " & _
				  ") as SQ ON Regions_Classifications.ID = SQ.RegionClassification " & _
				  "WHERE Regions_Classifications.Region = '" & myregion & "' " & _
				  "ORDER BY Regions_Classifications.Classification"
		end if

'response.write sql
'response.end
		rs1.Open sql, db
		bon = ""
		boff = ""
		do until rs1.eof
			if rs1("supporter") & "" <> "" then
				checked = " checked"
				bon = "<b>"
				boff = "</b>"			
			else
				checked = ""
			end if
			'response.write "<tr><td>" & rs1("Classification") & "</td><td><input type=""checkbox"" name=""$classification" & rs1("id") & """ id=""$classification" & rs1("id") & """" & checked & " onClick=""javascript:setoptions('$classification', " & rs1("id") & ")"" value=""-1""" & classchecked & "><input type=""checkbox"" name=""$classification" & rs1("id") & """ id=""$classification" & rs1("id") & """ style=""display:none"" value=""0""></td></tr>" & vbcrlf
			'It was setting the value of the option to zero in javascript when an option was unchecked, but now I have written code on the processing page
			'that automatically deletes those not passed through.
			response.write "<tr><td>" & rs1("Classification") & "</td><td><input type=""checkbox"" name=""$classification" & rs1("id") & """ id=""$classification" & rs1("id") & """" & checked & " value=""-1""></td></tr>" & vbcrlf
			rs1.movenext
		loop
		rs1.close
		response.write "</table>" & vbcrlf
		response.write "</div>" & vbcrlf
	next
	set rs1 = nothing
%>
    </div>
	<div id="mailouts" style="display:none">
	Mailouts
        <table width="800" border="1" cellspacing="0" cellpadding="1">
		<tr><td width="100">Date/Description</td><td width="200">Label</td><td width="400">Note</td><td width="100">Donation</td><td>Not Sent<td></tr>
<%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
		if id <> "new" then
			sql = "SELECT Supporters_Mailout.ID, Mailout.Description, Mailout.Date, Supporters_Mailout.Note, Supporters_mailout.label, Supporters_Mailout.Donation, Supporters_Mailout.notsent " & _
				  "FROM Supporters_Mailout INNER JOIN Mailout ON Supporters_Mailout.Mailout = Mailout.MailoutID " & _
				  "WHERE Supporters_Mailout.Supporter = " & id
			rs1.Open sql, db
			do until rs1.eof
				if rs1("notsent") then notsentchecked = " checked" else notsentchecked = ""
				response.write "<tr><td>" & rs1("date") & "<br>" & rs1("description") & "</td><td nowrap>" & replace(rs1("label"),vbcrlf,"<br>") & "</td><td><textarea name=""$mailoutnote" & rs1("id") & """ cols=""50"" rows=""5"" class=""fields"" id=""mailoutnote" & rs1("id") & """>" & rs1("note") & "</textarea></td><td><input name=""$mailoutdonation" & rs1("id") & """ type=""text"" class=""fields"" id=""$mailoutdonation" & rs1("id") & """ value=""" & rs1("donation") & """></td><td><input type=""checkbox"" name=""$mailnotsent" & rs1("id") & """ id=""$mailnotsent" & rs1("id") & """ value=""-1"" onClick=""javascript:setoptions(this.name)""" & notsentchecked & "><input type=""checkbox"" name=""$mailnotsent" & rs1("id") & """ id=""$mailnotsent" & rs1("id") & """ value=""0"" style=""display:none""</td></tr>"
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
if id <> "new" and session("incedosupporters_level") = 9 then
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



