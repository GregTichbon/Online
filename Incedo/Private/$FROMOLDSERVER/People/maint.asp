<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "People"
		secoption = "General"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
	end if

	set di = server.createobject("DI.IIS")
	ID = request.querystring("id")

incedopeople = "all"


	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	Set rs = Server.CreateObject("ADODB.Recordset")

	dim ministryministry()
	sql = "SELECT * FROM ministry order by ministry"
	rs.Open sql, db
	do until rs.eof
		c1 = c1 + 1
		redim preserve ministryministry(c1) 
		ministryministry(c1) = rs("ministry")
		rs.movenext
	loop
	rs.close

	if id = "new" then
		if incedopeople <> "all" then 
			centre = incedopeople
		else
			centre = ""
		end if
		lastname = ""
		firstname = ""
		othernames = ""
		knownas = ""
		gender = ""
		birthdate = ""
		birthyear = ""
		address = ""
		postal = ""
		phonehome = ""
		phoneministry = ""
		phonework = ""
		phoneyfc = ""
		phonemobile = ""
		email = ""
		category = ""
		iwi = ""
		workplace = ""
		parent = ""
		spouse = ""
		ceased = ""
		movedtocentre = ""
		verified_by = ""
		verified_date = ""
		notes = ""
		membershipdate = ""
		additionalemail = ""
		membersupdate = ""
		prayer = ""
		dailytexts = ""
		dailytexttime = "9:00"
		profile = ""
		notnzCitizen = ""
		skype = ""
		msn = ""
	else
		sqlstring = "SELECT * FROM people where id = " & ID
		rs.Open sqlstring, db
		if incedopeople <> "all" and rs("centre") <> incedopeople then 
			Response.Redirect "../signon.asp"
		end if
		centre = rs("centre")
		lastname = rs("lastname")
		firstname = rs("firstname")
		othernames = rs("othernames")
		knownas = rs("knownas")
		gender = rs("gender")
		birthdate = rs("birthday")
		birthyear = rs("birthyear")
		if birthyear = "" then
			birthdate = di.DI_format(birthdate,"dd/mm") & "/????"
		else
			birthdate = di.DI_format(birthdate,"dd/mm/yyyy")
		end if
		address = rs("address")
		postaladdress = rs("postaladdress")
		phonehome = rs("phonehome")
		phoneministry = rs("phoneministry")
		phonework = rs("phonework")
		phoneyfc = rs("phoneyfc")
		mobile = rs("mobile")
		email = rs("email")
		category = rs("category")
		iwi = rs("iwi")
		workplace = rs("workplace")
		'parent = "To do"
		'spouse = "To do"
		appointmentceased = di.DI_format(rs("appointmentceased"),"dd/mm/yyyy")
		movedtocentre = rs("movedtocentre")
		verified_by = rs("verified_by")
		verified_date = rs("verified_date")
		notes = rs("notes")
		membershipdate = di.DI_format(rs("membershipdate"),"dd/mm/yyyy")
		additionalemail = rs("additionalemail")
		membersupdate = rs("membersupdate")
		prayer = rs("prayer")
		dailytexts = rs("dailytexts")
		notnzcitizen = rs("notnzcitizen")
		if secresult = "OK" then
			if membersupdate = true then
				membersupdate = " checked"
			else
				membersupdate = ""
			end if
			if prayer = true then
				prayer = " checked"
			else
				prayer = ""
			end if
			if dailytexts = true then
				dailytexts = " checked"
			else
				dailytexts = ""
			end if
			if notnzcitizen = true then
				notnzcitizen = " checked"
			else
				notnzcitizen = ""
			end if
			dailytexttime = rs("dailytexttime")
			if dailytexttime & "" = "" then
				dailytexttime = "9:00"
			else
				dailytexttime = int(dailytexttime/60) & ":" & dailytexttime mod 60
			end if
		end if
		profile = rs("profile")
		skype = rs("skype")
		msn = rs("msn")
		rs.close
	end if	
	onload = " onload=setvalues()"
%>
<HTML>
<HEAD>
<TITLE>Incedo People</TITLE>
<script language="JavaScript">
<!--

	var deleteflag = 0
	var beforeimage = ""
	var afterimage = ""

function CheckForm() {
	if(deleteflag == 1) {
		return(true);
	}
		
	msg = '';
	warn = '';
	delim = '';
	frm = document.people;
	if(document.people.lastname.value == '') {
		msg = msg + delim + 'Last Name';
		delim = '\n';
	}
	if(document.people.firstname.value == '') {
		msg = msg + delim + 'First name';
		delim = '\n';
	}
	if(document.people.gender.value == '') {
		msg = msg + delim + 'Gender';
		delim = '\n';
	}
	if(document.people.address.value == '' && document.people.category.value != 'Ceased') {
		msg = msg + delim + 'Address';
		delim = '\n';
	}
	if(document.people.category.value == '') {
		msg = msg + delim + 'Category';
		delim = '\n';
	}
 	if(document.people.category.value == 'Ceased' && document.people.appointmentceased.value == '') {
 		msg = msg + delim + 'Cessation date';
 		delim = '\n';
 	}
 	if(document.people.movedtocentre.value != '' && document.people.category.value != 'Ceased') {
 		msg = msg + delim + 'A category of "Ceased" and a Cessation date';
 		delim = '\n';
 	}
 	if(document.people.$dailytexttime.value == '') {
 		msg = msg + delim + 'A daily text time - this needs to be based on whether they actually received texts and also needs to check the format';
 		delim = '\n';
 	}
 	if(document.people.$password.value != '' || document.people.$confirmpassword.value != '') {
 		if(document.people.$password.value != document.people.$confirmpassword.value) {
 			msg = msg + delim + 'Matching New Passwords';
 			delim = '\n';
		}
 	}

	if(msg != '') {
		msg = 'The folowing fields must be entered!\n' + msg
		delim = '\n';
	}
	if(document.people.category.value != 'Ceased' || document.people.birthdate.value != '') {
		if(!(IsDate(document.people.birthdate.value))) {
			msg = msg + delim + 'Invalid birthdate (format is "dd/mm/yyyy").';
			delim = '\n';
 		}
 	}

	if(document.people.category.value == 'Ceased') {
		if(!(IsDate(document.people.appointmentceased.value))) {
			msg = msg + delim + 'Invalid Cessation Date (format is "dd/mm/yyyy").';
			delim = '\n';
 		}
 	} else {
 		if(document.people.appointmentceased.value != '') {
 			msg = msg + delim + 'Cessation date not required or category should be set to "Ceased".';
 			delim = '\n';
 		}
 	}
<%    if secresult = "OK" and 1=2 then%>
	if(document.people.membershipdate.value != '') {
		if(!(IsDate(document.people.membershipdate.value))) {
			msg = msg + delim + 'Invalid membership date (format is "dd/mm/yyyy").';
			delim = '\n';
		}
		else {
			if(document.people.prayer.checked == true) {
				msg = msg + delim + 'No need for prayer to be checked.';
			}
			if(document.people.membersupdate.checked == true) {
				msg = msg + delim + 'No need for members update to be checked.';
			}
		}
	}
<% end if %> 		
 	if(document.people.email.value != '') {
		if(!(IsEmail(document.people.email.value))) {
			msg = msg + delim + 'Invalid Email Address.';
			delim = '\n';
 		}
 	}

 	if(document.people.additionalemail.value != '') {
		document.people.additionalemail.value = document.people.additionalemail.value.replace(' ','');
		splitstring = document.people.additionalemail.value.split(',');
		for(i = 0; i < splitstring.length; i++) {
			if(!(IsEmail(splitstring[i]))) {
				msg = msg + delim + 'Invalid Additional Email Address: ' + splitstring[i] + '.';
				delim = '\n';
 			}
		}
 	}

 	
 	if(document.people.category.value == 'Full-time Worker' && document.people.workplace.value != '') {
		warn = warn + delim + 'Warning - This fulltime worker has another workplace.';
		delim = '\n';
 	}
	if(msg == '') {
		afterimage = makeimage();
		if(afterimage != beforeimage) 
			document.people.$changed.value = 'changed'
		else
			document.people.$changed.value = 'unchanged'
	}
	if(msg != '' || warn != '') {
		alert(msg + warn);
		if(msg != '') {
			return(false);
		}
	}
	else {
		var numlinks = frm.$linkid.length;
		if(numlinks==1) {
			frm.$linklink.value = frm.$linklink.value.replace(',',String.fromCharCode(8)); 
			frm.$linkdescription.value = frm.$linkdescription.value.replace(',',String.fromCharCode(8)); 
		}
		else {
			for (var i=0; i<numlinks; i++) {     
				frm.$linklink[i].value = frm.$linklink[i].value.replace(',',String.fromCharCode(8)); 
				frm.$linkdescription[i].value = frm.$linkdescription[i].value.replace(',',String.fromCharCode(8)); 
			}
		} 
		var numministries = frm.$ministryid.length;
		if(numministries==1) {
			frm.$ministryministry.value = frm.$ministryministry.value.replace(',',String.fromCharCode(8)); 
			frm.$ministrytitle.value = frm.$ministrytitle.value.replace(',',String.fromCharCode(8)); 
		}
		else {
			for (var i=0; i<numlinks; i++) {     
				frm.$ministryministry[i].value = frm.$ministryministry[i].value.replace(',',String.fromCharCode(8)); 
				frm.$ministrytitle[i].value = frm.$ministrytitle[i].value.replace(',',String.fromCharCode(8)); 
			}
		} 
	}
}

function setdelete() {
	deleteflag = 1;
}

function IsEmail(argEmail) {
	var lat=argEmail.indexOf('@')
	var lstr=argEmail.length
	var ldot=argEmail.indexOf('.')
	if (argEmail.indexOf('@')==-1) {
		return false
	}
	if (argEmail.indexOf('@')==-1 || argEmail.indexOf('@')==0 || argEmail.indexOf('@')==lstr) {
		return false
	}
	if (argEmail.indexOf('.')==-1 || argEmail.indexOf('.')==0 || argEmail.indexOf('.')==lstr) {
		return false
	}
	if (argEmail.indexOf('@',(lat+1))!=-1) {
		return false
	}
	if (argEmail.substring(lat-1,lat)=='.' || argEmail.substring(lat+1,lat+2)=='.') {
		return false
	}
	if (argEmail.indexOf('.',(lat+2))==-1) {
		return false
	}
	if (argEmail.indexOf(" ")!=-1) {
		return false
	}
	return true;
}

function IsDate(argDate) {
	date_split = argDate.split('/');

	//check for date parts
	if(date_split.length != 3) 
		return(false);
		
	//check for zero values
	for(i=0;i<date_split.length;i++) {
		if(parseFloat(date_split[i]) == 0) 
			return(false);
	}
	
	//check for 4-digit year
	if(date_split[2].length != 4) 
		return(false);

	//check for valid date, e.g. 29/02/1997
	tday = parseFloat(date_split[0]);
	tmonth = parseFloat(date_split[1]);
	tyear = parseFloat(date_split[2]);
	var date = new Date(parseFloat(date_split[2]),parseFloat(date_split[1]-1),parseFloat(date_split[0]));
	if(date.getDate() != tday) 
		return(false);

	if(date.getMonth() != (tmonth-1))
		return(false);
	
	if(date.getFullYear() != tyear)
		return(false);
		
	return(true);
}

function setvalues() {
	/*for (i=1;i<11;i++) {
		minopts(i)
	}*/
	for (i=0;i<document.people.gender.length;i++) {
		if(document.people.gender[i].value == "<%=gender%>") {
			document.people.gender[i].selected = true;
		}
	}
	for (i=0;i<document.people.category.length;i++) {
		if(document.people.category[i].value == "<%=category%>") {
			document.people.category[i].selected = true;
		}
	}
	for (i=0;i<document.people.movedtocentre.length;i++) {
		if(document.people.movedtocentre[i].value == "<%=movedtocentre%>") {
			document.people.movedtocentre[i].selected = true;
		}
	}
	beforeimage = makeimage();
	//alert(beforeimage);
}

function makeimage (){
	var dataimage = ""
	var elements = document.people.elements
	for (var i = 0; i < elements.length; i++) {
		if(elements.item(i).type == "checkbox") {
			dataimage = dataimage + "|" + elements.item(i).checked;
		} else {
			dataimage = dataimage + "|" + elements.item(i).value;
		}
	}
	return dataimage;
}

function minopts(opt) {
/*
	//var nextopt = parseFloat(opt) + 1
	if (document.getElementById("ministry" + opt).value == "---Please Select---" || document.getElementById("ministry" + opt).value == "---Remove---") { 
		document.getElementById("title" + opt).style.display="none"
		//if (nextopt < 11) {
		//	document.getElementById("ministry" + nextopt).style.display="none"
		//}
	}
	else {
		document.getElementById("title" + opt).style.display=""
		//if (nextopt < 11) {
		//	document.getElementById("ministry" + nextopt).style.display=""
		//}
	}
*/}
function drawministryoptions(addsub) {
	var tbl = document.getElementById("ministrytable");
	if(addsub == 0) {
		//add a row
		var targetnumrows = tbl.rows.length;
		var row = tbl.insertRow(tbl.rows.length);

		var cell = row.insertCell(0);
		var ministryid = document.createElement("input");
		ministryid.setAttribute("type", "hidden");
		ministryid.setAttribute("id", "$ministryid");
		ministryid.setAttribute("name", "$ministryid");
		ministryid.setAttribute("value", "0");
		cell.appendChild(ministryid);
		
		var ministryministry = document.createElement("select");
		ministryministry.setAttribute("id", "$ministryministry");
		ministryministry.setAttribute("name", "$ministryministry");
		cell.appendChild(ministryministry);
		ministryministry.style.cssText = 'width:98%'		
	   
		theOption=document.createElement("OPTION");
		theText=document.createTextNode("--- Please Select ---");
		theOption.appendChild(theText);
		ministryministry.appendChild(theOption);

<%
for f1=1 to ubound(ministryministry)
		response.write "theOption=document.createElement('OPTION');"
		response.write "theText=document.createTextNode('" & ministryministry(f1) & "');"
		response.write "theOption.value = '" & ministryministry(f1) & "';"
		response.write "theOption.appendChild(theText);"
		response.write "ministryministry.appendChild(theOption);"
next
%>		
		cell = row.insertCell(1);
		var ministrytitle = document.createElement("input");
		ministrytitle.setAttribute("type", "text");
		ministrytitle.setAttribute("id", "$ministrytitle");
		ministrytitle.setAttribute("name", "$ministrytitle");
		//ministrydetail.setAttribute("value", "");
		cell.appendChild(ministrytitle);
		ministrytitle.style.cssText = 'width:98%'		

		cell = row.insertCell(2);
		var ministrydelete = document.createElement("div");
		ministrydelete.setAttribute("id", "$ministrydelete" + targetnumrows);
		ministrydelete.innerHTML = '<a href="javascript:drawministryoptions(' + targetnumrows + ');">Delete</a>';
		cell.appendChild(ministrydelete);

	}
	else {
		tbl.deleteRow(addsub);
		for(var i=1; i < tbl.rows.length; i++) {
			if(i >= addsub) {
				document.getElementById('$ministrydelete' + (i+1)).innerHTML = '<a href="javascript:drawministryoptions(' + i + ');">Delete</a>';
				document.getElementById('$ministrydelete' + (i+1)).setAttribute("id", "$ministrydelete" + i)
			}
		}
   }
}

function drawlinkoptions(addsub) {
	var tbl = document.getElementById("linktable");
	if(addsub == 0) {
		//add a row
		var targetnumrows = tbl.rows.length;
		var row = tbl.insertRow(tbl.rows.length);

		var cell = row.insertCell(0);
		var linkid = document.createElement("input");
		linkid.setAttribute("type", "hidden");
		linkid.setAttribute("id", "$linkid");
		linkid.setAttribute("name", "$linkid");
		linkid.setAttribute("value", "0");
		cell.appendChild(linkid);
	   
		var linklink = document.createElement("input");
		linklink.setAttribute("type", "text");
		linklink.setAttribute("id", "$linklink");
		linklink.setAttribute("name", "$linklink");
		//linkurl.setAttribute("value", "");
		cell.appendChild(linklink);
		linklink.style.cssText = 'width:98%'		
		
		cell = row.insertCell(1);
		var linkdescription = document.createElement("input");
		linkdescription.setAttribute("type", "text");
		linkdescription.setAttribute("id", "$linkdescription");
		linkdescription.setAttribute("name", "$linkdescription");
		//linkdescription.setAttribute("size", "60");
		//linkdescription.setAttribute("value", "");
		cell.appendChild(linkdescription);
		linkdescription.style.cssText = 'width:98%'		
		
		cell = row.insertCell(2);
		var linkdelete = document.createElement("div");
		linkdelete.setAttribute("id", "$linkdelete" + targetnumrows);
		linkdelete.innerHTML = '<a href="javascript:drawlinkoptions(' + targetnumrows + ');">Delete</a>';
		cell.appendChild(linkdelete);

	}
	else {
		tbl.deleteRow(addsub);
		for(var i=1; i < tbl.rows.length; i++) {
			if(i >= addsub) {
				document.getElementById('$linkdelete' + (i+1)).innerHTML = '<a href="javascript:drawlinkoptions(' + i + ');">Delete</a>';
				document.getElementById('$linkdelete' + (i+1)).setAttribute("id", "$linkdelete" + i)
			}
		}
   }
}
//-->
</script>
</head>

<BODY bgcolor="#FFFFFF"<%=onload%>>
<div align="center">
<FORM name="people" action="maint_Results.asp" method="post" OnSubmit="return CheckForm();">
  <TABLE cellSpacing=0 cellPadding=3 width="800" border=2 align="center">
    <TR> 
      <td colspan="3" height="74"> 
        <p align=center><b><font size="+3">Incedo
        People</font></b></p>
        <ul>
          <li><b align="center">            Please ensure all the information for all &quot;paid staff&quot;, board 
                    members, &quot;overseas workers&quot;, and volunteers regularly contributing 20 hours or more per 
            week or heading up ministry areas are entered.</b></li>
          <li><b align="center"> If you have time please feel free to enter the information for spouses 
            and children as well.</b></li>
          <li><b align="center"> You can not delete people. If they are no longer involved please set 
            the category to &quot;Ceased&quot; and set the cessation date.</b></li>
          <li><b align="center"> All dates must be entered as dd/mm/yyyy eg: 14/02/2004</b><b>.</b></li>
          <li><b> Click on the &quot;Modify/Confirm&quot; button when you have verified and, where need be, corrected the information.<font color="#FF0000"><br>
                    </font></b></li>
      </ul></td></tr>
    <TR> 
      <td width="31%">ID</td>
      <td><%=ID%> 
        <input type="hidden" name="id" value="<%=id%>">
        Verified <%=di.di_format(verified_date,"dd mmm yyyy")%> by <%=verified_by%>
        <input name="$changed" type="hidden" id="$changed"></td>
      <td><div align="right"><a href="default.asp">Return to List </a></div></td>
    </tr>
    <TR> 
      <td width="31%">Mission Base</td>
      <td colspan="2">
<%
    if secresult = "OK" then   
        response.write "<select name=""centre"" size=""1"">"
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql = "Select * from bases where [type] = 'Base' order by centre"
		rs.open sql, db
		do until rs.eof
			if rs("centre") = centre then selected = " selected" else selected = ""
			response.write  " <option value=""" & rs("centre") & """" & selected & ">" & rs("centre")  & "</option>"
			rs.movenext
		loop
		rs.close
	    Response.Write "</select>"
	else
		Response.Write centre
        Response.Write "<input type=""hidden"" name=""centre"" value=""" & centre & """>"
    end if
%>
      </td>
    </tr>
    <TR> 
      <td width="31%">Last Name</td>
      <td width="47%"> 
        <input type="text" name="lastname" value="<%=lastname%>" style="width:98%">
      </td>
	  <%
	  if id = "new" then
	  	photoxtra = ""
	  else
	  	set fs = CreateObject("Scripting.FileSystemObject")
		if fs.FileExists(Server.MapPath("/") & "\private\people\photos\h400\" & id & ".jpg") then
			photoxtra = "<a href=""photos/h400/" & id & ".jpg""><img src=""Photos/Thumbnails/" & id & ".jpg"" border=""0""></a>"
		else
			photoxtra = ""
		end if
		set fs = nothing 
	  end if
	  %>
      <td width="22%" rowspan="4"><div align="right"><%=photoxtra%><br><a href="uploadphoto.asp?id=<%=id%>">Add/Change Photo</a> </div></td>
    </tr>
    <TR> 
      <td width="31%">First Name</td>
      <td width="47%"> 
        <input type="text" name="firstname" value="<%=firstname%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Other Names</td>
      <td width="47%"> 
        <input type="text" name="othernames" value="<%=othernames%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Known As</td>
      <td width="47%"> 
        <input type="text" name="knownas" value="<%=knownas%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Gender</td>
      <td colspan="2"> 
        <select name="gender" size="1">
          <option value="">--- Please Select ---</option>
          <option value="Male">Male</option>
          <option value="Female">Female</option>
        </select>
      </td>
    </tr>
    <TR> 
      <td width="31%">Birthdate (dd/mm/yyyy)</td>
      <td colspan="2"> 
        <input type="text" name="birthdate" value="<%=birthdate%>">
      </td>
    </tr>
    <TR> 
      <td width="31%">Profile</td>
      <td colspan="2"> 
        <textarea name="profile" rows="5" cols="50" wrap="OFF" style="width:98%"><%=profile%></textarea>
      </td>
    </tr>
    <TR> 
      <td width="31%">Address</td>
      <td colspan="2"> 
        <textarea name="address" rows="5" cols="50" wrap="OFF" style="width:98%"><%=address%></textarea>
      </td>
    </tr>
    <TR> 
      <td width="31%">Postal Address (if different to Address)</td>
      <td colspan="2"> 
        <textarea name="postaladdress" rows="5" cols="50" wrap="OFF" style="width:98%"><%=postaladdress%></textarea>
      </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Home)</td>
      <td colspan="2"> 
        <input type="text" name="phonehome" value="<%=phonehome%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Ministry)</td>
      <td colspan="2"> 
        <input type="text" name="phoneministry" value="<%=phoneministry%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Other place of employment) (ie: if part-time)</td>
      <td colspan="2"> 
        <input type="text" name="phonework" value="<%=phonework%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Incedo)</td>
      <td colspan="2"> 
        <input type="text" name="phoneyfc" value="<%=phoneyfc%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Mobile)</td>
      <td colspan="2"> 
        <input type="text" name="mobile" value="<%=mobile%>" style="width:98%">
      </td>
    </tr>
    <TR> 
      <td width="31%">Email</td>
      <td colspan="2"> 
        <input type="text" name="email" value="<%=email%>" style="width:98%">
      </td>
    </tr>
    <TR>
      <td>Additional email addresses (seperate with commas </td>
      <td colspan="2"><input name="additionalemail" type="text" id="additionalemail" value="<%=additionalemail%>" style="width:98%"></td>
    </tr>
    <TR>
      <td>Skype Address </td>
      <td colspan="2"><input name="skype" type="text" id="skype" value="<%=skype%>" style="width:98%"></td>
    </tr>
    <TR>
      <td>MSN Address </td>
      <td colspan="2"><input name="msn" type="text" id="msn" value="<%=msn%>" style="width:98%"></td>
    </tr>
    <TR> 
      <td width="31%">Category</td>
      <td colspan="2"> 
        <select name="category" size="1">
          <option value="">--- Please Select ---</option>
          <option value="Full-time Worker">Full-time Worker</option>
          <option value="Part-time Worker">Part-time Worker</option>
          <option value="Overseas Worker">Overseas Worker</option>
          <option value="Casual Worker">Casual Worker</option>
          <option value="Volunteer Worker">Volunteer Worker</option>
          <option value="Spouse/Partner">Spouse</option>
          <option value="Child">Child</option>
          <option value="Ceased">Ceased</option>
          <option value="Other">Other</option>
        </select>
      </td>
    </tr>
    <TR>
      <td>Membership Date </td>
<%if secresult = "OK" then%>
      <td colspan="2"><input name="membershipdate" type="text" id="membershipdate" value="<%=membershipdate%>">
      </td>
    </tr>
    <TR>
      <td>Not NZ Citizen </td>
      <td colspan="2"><input name="notnzcitizen" type="checkbox" id="notnzcitizen" value="true"<%=notnzcitizen%>></td>
    </tr>
    <TR>
      <td>Prayer list</td>
      <td><input name="prayer" type="checkbox" id="prayer" value="true"<%=prayer%>></td>
      <td rowspan="3"><font size="-1">If the person is a member, ie: they have a membership date, selection of these boxes will inhibit the function. If the person is not a member selection of these boxes will activate the function. </font></td>
    </tr>
    <TR>
      <td>Members update</td>
      <td><input name="membersupdate" type="checkbox" id="membersupdate" value="true"<%=membersupdate%>>
    </tr>
    <TR>
      <td>Daily Texts (time hh:mm) </td>
      <td><input name="dailytexts" type="checkbox" id="3x3x3" value="true"<%=dailytexts%>>
        <input name="$dailytexttime" type="text" id="$dailytexttime" maxlength="5" value="<%=dailytexttime%>"></td>
    </tr>
<%else%>
      <td colspan="2"><%=membershipdate%><input name="membershipdate" type="hidden" value="<%=membershipdate%>"></td>
		<input name="prayer" type="hidden" value="<%=prayer%>">
		<input name="membersupdate" type="hidden" value="<%=membersupdate%>">
		<input name="dailytexts" type="hidden" value="<%=dailytexts%>">
		<input name="notnzcitizen" type="hidden" value="<%=notnzcitizen%>">
		</td>
    </tr>
<% end if %>
    <TR> 
      <td width="31%">Other place of employment (ie: if part-time)</td>
      <td colspan="2"> 
        <input type="text" name="workplace" value="<%=workplace%>" style="width:98%">
      </td>
    </tr>
    <%if 1=2 then%>
    <TR> 
      <td width="31%">Parent(s) Name(s) (ie: for the child of a Incedo &quot;Person&quot;)</td>
      <td colspan="2"> 
        <input type="text" name="parents" value="<%=parent%>">
      </td>
    </tr>
    <TR> 
      <td width="31%">Spouse Name</td>
      <td colspan="2"> 
        <input type="text" name="spouse" value="<%=spouse%>">
      </td>
    </tr>
    <%end if%>
    <TR> 
      <td width="31%">Cessation Date (dd/mm/yyyy)</td>
      <td colspan="2"> 
        <input type="text" name="appointmentceased" value="<%=appointmentceased%>">
      </td>
    </tr>
    <TR>
      <td>Notes</td>
      <td colspan="2"><textarea name="notes" cols="40" rows="3" id="notes" style="width:98%"><%=notes%></textarea></td>
    </tr>
    <TR>
      <td>New Password </td>
		  <td colspan="2"><input name="$password" type="password" id="$password"></td>
    </tr>
    <TR>
      <td>Confirm New Password </td>
      <td colspan="2"><input name="$confirmpassword" type="password" id="$confirmpassword"></td>
    </tr>
    <TR> 
      <td width="31%">Moved to other Mission Base</td>
      <td colspan="2"> 
        <select name="movedtocentre" size="1">
          <option value="">N/A</option>
          <%
			Set rs = Server.CreateObject("ADODB.Recordset")
			sql = "Select * from bases where [type] = 'Base' order by centre"
			rs.open sql, db
			do until rs.eof
				response.write  " <option value=""" & rs("centre") & """>" & rs("centre")  & "</option>"
				rs.movenext
			loop
			rs.close
%>
        </select>
      </td>
    </tr>
  </table>
  
<%if 1=1 then%>
    <table width="800" border="2" align="center" cellpadding="3" cellspacing="0">
      <tr>
        <th><div align="center">Ministries and Roles</div></th>
        <th width="10"><a href="javascript:drawministryoptions(0);">Add</a></th>
      </tr>
    </table>
    
    <table width="800" border="2" align="center" cellpadding="3" cellspacing="0" id="ministrytable">
      <tr><th width="10">Ministry/Roll</th>
        <th>Title</th>
        <th width="10">Delete</th>
      </tr>
      <%
	if id <> "new" then
		sqlstring = "SELECT * FROM people_ministry where person = " & ID & " order by ID"
		rs.Open sqlstring, db
		do until rs.eof
			row = row + 1
			response.write "<tr>"
			response.write "<td>"
			response.write "<input name=""$ministryid"" type=""hidden"" id=""$ministryid"" value=""" & rs("id") & """>"
			response.write "<select name=""$ministryministry"" size=""1"" id=""$ministryministry"">"
			for f1=1 to ubound(ministryministry)
				if ministryministry(f1) = rs("ministry") then selected = " selected" else selected = ""
				response.write "<option value=""" & ministryministry(f1) & """" & selected & ">" & ministryministry(f1) & "</option>"
			next
			response.write "</select>"
			response.write "</td>"
			response.write "<td>"
			response.write "<input name=""$ministrytitle"" type=""text"" id=""$ministrytitle"" style=""width:98%"" value=""" & rs("title") & """>"
			response.write "</td>"
			response.write "<td>"
			response.write "<div id=""$ministrydelete" & row & """><a href=""javascript:drawministryoptions(" & row & ")"">Delete</a></div>"
			response.write "</td>"
			response.write "</tr>"
			rs.movenext
		loop
		rs.close
	end if
%>
    </table>
<%else%>
    <table width="800" border="1" cellpadding="2" align="center">
      <tr> 
        <td><b>Ministry</b></td>
        <td><b>Title</b></td>
      </tr>
      
<%
		dim minopts(100)
		sqlstring = "Select * from ministry"
		rs.Open sqlstring, db
		mcnt = 1
		minopts(mcnt) = "---Please Select---"
		mcnt = 2
		minopts(mcnt) = "---Remove---"
		do until rs.EOF
			mcnt = mcnt + 1
			minopts(mcnt) = rs("ministry")
			rs.MoveNext 
		loop
		rs.Close 

		if id <> "new" then
			sqlstring = "SELECT * FROM people_ministry where id = " & ID
			rs.Open sqlstring, db
			cnt = 0
			do until rs.EOF
				cnt = cnt + 1
				Response.Write "<tr>" 
				  Response.Write "<td>" 
				    Response.Write "<select name=""ministry" & cnt & """ onchange=""minopts(" & cnt & ")"">"
					  for f1=1 to mcnt
						 if minopts(f1) = rs("ministry") then selected = " selected" else selected = ""
						 Response.Write "<option value=""" & minopts(f1) & """" & selected & ">" & minopts(f1) & "</option>"
				      next 
				    Response.Write "</select>"
				  Response.Write "</td>"
				  Response.Write "<td>" 
				    Response.Write "<input type=""text"" name=""title" & cnt & """ value=""" & rs("Title") & """ size=""50"">"
				  Response.Write "</td>"
				Response.Write "</tr>"
				rs.MoveNext 
			loop
			rs.Close 
		end if
	for f1=cnt+1 to 10
%>
      <tr> 
        <td> 
          <select name="ministry<%=f1%>" onchange=minopts(<%=f1%>)>
            <%
				for f2=1 to mcnt
				   Response.Write "<option value=""" & minopts(f2) & """>" & minopts(f2) & "</option>"
			    next 
			    %>
          </select>
        </td>
        <td> 
          <input type="text" name="title<%=f1%>" size="50">
        </td>
      </tr>
<% next %>
    </table>
<%end if%>
    <table width="800" border="2" align="center" cellpadding="3" cellspacing="0">
      <tr>
        <th><div align="center">Links</div></th>
        <th width="10"><a href="javascript:drawlinkoptions(0);">Add</a></th>
      </tr>
    </table>
    
    <table width="800" border="2" align="center" cellpadding="3" cellspacing="0" id="linktable">
	<tr>
      <th>Link</th>
        <th>Description</th>
        <th width="10">Delete</th>
      </tr>
      <%
	if id <> "new" then
		sqlstring = "SELECT ID, [Description], [link] FROM People_Links where Person = " & ID & " order by ID"
		rs.Open sqlstring, db
		do until rs.eof
			row = row + 1
			response.write "<tr>"
			response.write "<td>"
			response.write "<input name=""$linkid"" type=""hidden"" id=""$linkid"" value=""" & rs("id") & """>"
			response.write "<input name=""$linklink"" type=""text"" id=""$linklink"" style=""width:98%"" value=""" & rs("link") & """>"
			response.write "</td>"
			response.write "<td>"
			response.write "<input name=""$linkdescription"" type=""text"" id=""$linkdescription"" style=""width:98%"" value=""" & rs("description") & """>"
			response.write "</td>"
			response.write "<td>"
			response.write "<div id=""$linkdelete" & row & """><a href=""javascript:drawlinkoptions(" & row & ")"">Delete</a></div>"
			response.write "</td>"
			response.write "</tr>"
			rs.movenext
		loop
		rs.close
	end if
%>
    </table>
    <br>
<%    

if secresult = "OK" then   
    response.write "<input type=""submit"" name=""$create"" value=""Create"">"
end if
    if id <> "new" then
		response.write "<input type=""submit"" name=""$modify"" value=""Modify/Confirm"">"
if secresult = "OK" then   
		response.write "<input type=""submit"" name=""$delete"" value=""Delete"" onClick=""setdelete()"">"
end if
	end if
	'response.write "<input type=""submit"" name=""$confirm"" value=""Confirm"";>"
    'response.write "<P><INPUT id=reset type=reset value="" Reset Form "" name=$reset>"
%>
</FORM>
</div>
</BODY>
</HTML>



