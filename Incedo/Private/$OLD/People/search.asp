<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if

%>
<HTML><HEAD><title>Incedo People</title></HEAD>
<script language="JavaScript">
function clearfield(myaction) {
	if(myaction=='showall') {
		if(document.search.showall.checked) {
			document.search.searchname.value = ''
		}
	}
	else {
		if(document.search.searchname.value != '') {
			document.search.showall.checked = false;
		}
		else {
			document.search.showall.checked = true;
		}
	}
}

</script>

<BODY bgcolor="#FFFFFF">
<p align="center"><b><font size="+3">Incedo People</font></b></p>
<%if 1=2 then%>
  <a href=maint.asp?id=New>Add</a> <a href="download.asp">Download File</a> (Downloading the file will allow you to open and view the information in Excel)
  <br>
<%end if%>
<form action="search.asp" method="post" name="search" id="search">
  <p>Search for any part of name
    <input name="searchname" type="text" id="searchname" onkeyup="clearfield('searchname');">
<%if 1=2 then%>
    <br>
    or Show all 
    <input name="showall" type="checkbox" id="showall" onclick="clearfield('showall');" value="Yes">
<%end if%>
    <br>
    <input name="submit" type="submit" id="submit" value="Submit">
  </p>
</form>
<%
	searchname = request.form("searchname")
	showall = request.form("showall")
	if searchname <> "" or showall = "Yes" then
%>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT id as ID, lastname as [Last Name], firstname as [First Name], knownas as [Known As], category as Category, format(AppointmentCeased,'dd mmm yyyy') as [Cessation Date], verified_by as [Verified By], format(verified_date,'dd mmm yyyy') as [Verified Date], membershipdate as [Membership Date]"
	if searchname <> "" then
		sql = sql & ", centre as [Mission Base] from people where lastname Like '%" & searchname & "%' or firstname like '%" & searchname & "%' or knownas like '%" & searchname & "%' ORDER BY iif(AppointmentCeased is null,0,1), lastname, firstname"
	else
		if centre = "All" then
			sql = sql & ", centre as Centre from people ORDER BY iif(AppointmentCeased is null,0,1), lastname, firstname"
		else
			sql = sql & " from people where centre = '" & centre & "' ORDER BY iif(AppointmentCeased is null,0,1), lastname, firstname"
		end if
	end if
	rs.Open sql, db
	cnt = 0
	doheader = true
	do until rs.EOF
		cnt = cnt + 1
		if doheader = true then
			response.write "<tr>"
			if session("Incedo_MemberID") = 60 then
				Response.write "<th nowrap>Edit</td>"
			else
				Response.write "<th nowrap>View</td>"
			end if
			for each fld in rs.Fields
				Response.write "<th nowrap>" & fld.name & "</td>"
			next
			Response.Write "</tr>"
			doheader = false
		end if
		response.write "<tr>"
		if session("Incedo_MemberID") = 60 then
			Response.write "<td><a href=maint.asp?id=" & rs("ID") & "><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
		else
			Response.write "<td><a href=view.asp?id=" & rs("ID") & "><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
		end if
		for each fld in rs.fields
			Response.write "<td nowrap>" & fld.value & "&nbsp;</td>"
		next
		Response.Write "</tr>"
		rs.MoveNext
	loop
		
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
	Response.Write cnt & " records."
%>
</table>
<%
end if
%>
</BODY>
</HTML>
