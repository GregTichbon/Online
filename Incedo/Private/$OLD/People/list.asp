<HTML><HEAD><title>Incedo People</title></HEAD>
<BODY bgcolor="#FFFFFF">
<p align="center"><b><font size="+3">Incedo</font></b><br>
<table border="1">
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT id as ID, lastname as [Last Name], firstname as [First Name], knownas as [Known As], category as Category, format(MembershipDate,'dd mmm yyyy') as [Membership Date], verified_by as [Verified By], format(verified_date,'dd mmm yyyy') as [Verified Date]"
centre = "All"
	if centre = "All" then
		sql = sql & ", centre as Centre"
	else
		sql = sql & " and centre = '" & centre & "'"
	end if
	sql = sql & " from people"
sql = sql & " where category <> 'Ceased'"
	sql = sql & " ORDER BY id, lastname, firstname"
'Response.Write sql 
'Response.end
	rs.Open sql, db
	cnt = 0
	doheader = true
	do until rs.EOF
		cnt = cnt + 1
		if doheader = true then
			response.write "<tr>"
			'Response.write "<th nowrap>Amend</td>"
			for each fld in rs.Fields
				Response.write "<th nowrap>" & fld.name & "</td>"
			next
			response.write "<th nowrap>Photo</td>"
			Response.Write "</tr>"
			doheader = false
		end if
	  	
		set fs = CreateObject("Scripting.FileSystemObject")
		id = rs("id")
		fname = Server.MapPath("/") & "\private\people\photos\h400\" & id & ".jpg"
		if fs.FileExists(fname) then
			photoxtra = "<a href=""photos/h400/" & id & ".jpg""><img src=""Photos/Thumbnails/" & id & ".jpg"" border=""0""></a>"
		else
			photoxtra = "&nbsp;" '& fname
		end if
		set fs = nothing 
		
		
		response.write "<tr>"
		'Response.write "<td><a href=maint.asp?id=" & rs("ID") & "><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
		for each fld in rs.fields
			Response.write "<td nowrap>" & fld.value & "&nbsp;</td>"
		next
		response.write "<td>" & photoxtra & "<br><a href=""uploadphoto.asp?id=" & id & """>Add/Change Photo</a></td>"
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
</BODY>
</HTML>

