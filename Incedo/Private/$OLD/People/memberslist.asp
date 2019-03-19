<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "people/memberslist.asp"
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		

		
	end if
%>	
<HTML><HEAD><title>Incedo People</title></HEAD>
<BODY>
<p align="center"><b><font size="+3">Incedo Members' List</font></b><br>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT id as ID, lastname as [Name], firstname, knownas, centre as [Mission Base], iif(PostalAddress is null,Address,PostalAddress) as [Postal Address], Email, PhoneHome, PhoneMinistry, PhoneWork, PhoneYFC, Mobile, Birthday "
	sql = sql & " from people"
	sql = sql & " where membershipdate is not null and category <> 'Ceased'"
	sql = sql & " ORDER BY lastname, firstname"
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
				if fld.name <> "ID" and left(fld.name,5) <> "Phone" and fld.name <> "Mobile" and fld.name <> "firstname" and fld.name <> "knownas" then
					Response.write "<th nowrap>" & fld.name & "</td>"
				end if
			next
			response.write "<th nowrap>Phone</td>"
			response.write "<th nowrap>Photo</td>"
			Response.Write "</tr>"
			doheader = false
		end if
	  	
		set fs = CreateObject("Scripting.FileSystemObject")
		id = rs("id")
		fname = Server.MapPath("/") & "\people\photos\h400\" & id & ".jpg"
		if fs.FileExists(fname) then
			photoxtra = "<a href=""photos/h400/" & id & ".jpg""><img src=""Photos/Thumbnails/" & id & ".jpg"" border=""0""></a>"
		else
			photoxtra = "&nbsp;" 
		end if
		set fs = nothing 
		
		
		response.write "<tr>"
		phone = ""
		phonedelim = ""
		for each fld in rs.fields
			fldname = lcase(fld.name)
			useval = fld.value
			select case fldname
				case "postal address" 
					useval = replace(useval & "",vbcrlf,"<br>")
				case "email"
					if useval <> "" then
						useval = "<a href=""mailto:" & useval & """>" & useval & "</a>"
					end if
				case "phonehome", "phoneministry", "phonework", "phoneyfc", "mobile"
					if fldname = "phonehome" and useval <> "" then
						phone = phone & phonedelim & "Home: " & useval
						phonedelim = "<br>"
					end if
					if fldname = "phoneministry" and useval <> "" then
						phone = phone & phonedelim & "Ministry: " & useval
						phonedelim = "<br>"
					end if
					if fldname = "phonework" and useval <> "" then
						phone = phone & phonedelim & "Work: " & useval
						phonedelim = "<br>"
					end if
					if fldname = "phoneyfc" and useval <> "" then
						phone = phone & phonedelim & "Incedo: " & useval
						phonedelim = "<br>"
					end if
					if fldname = "mobile" and useval <> "" then
						phone = phone & phonedelim & "Mobile: " & useval
						phonedelim = "<br>"
					end if
				case "name"
					useval = rs("name") & ", " & rs("firstname")
					if rs("knownas") & "" <> "" then
						useval = useval & "<br>(" & rs("knownas") & ")"
					end if
				case "birthday"
					useval = di.di_format(rs("birthday"),"dd mmm")  
			end select
			if fld.name <> "ID" and left(fld.name,5) <> "Phone" and fld.name <> "Mobile" and fld.name <> "firstname" and fld.name <> "knownas" then
				Response.write "<td nowrap>" & useval & "&nbsp;</td>"
			end if
		next
		response.write "<td nowrap>" & phone & "&nbsp;</td>"
		response.write "<td>" & photoxtra & "</td>"
		Response.Write "</tr>"
		rs.MoveNext
	loop
		
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
	Response.Write cnt & " records."
	
	set di = nothing
%>
</table>
</BODY>
</HTML>

