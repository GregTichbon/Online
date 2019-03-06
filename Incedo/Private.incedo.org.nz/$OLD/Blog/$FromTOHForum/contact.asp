<HTML>
<HEAD>
	<TITLE>DISCUSSION FORUM: Contact</TITLE>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
</HEAD>
<body>
<P><center><b><font size="+1">DISCUSSION FORUM: Contact</font></b></center><p>
<%
		id = request.querystring("id")
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\teorahou\teorahou.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.RecordSet")
		sql = "SELECT People.Lastname, People.Firstname, People.KnownAs, People_Communication.Type, People_Communication.Detail, People_Communication.Note " & _
		      "FROM People LEFT JOIN People_Communication ON People.ID = People_Communication.PeopleID where people.id = " & id & " order by [type]"
		rs.Open sql, db
		cnt = 0
		doheader = true
		if not rs.eof then
			response.write "<table border=""1"" cellpadding=""10"" cellspacing=""0"" bordercolor=""#000000"">"
			do until rs.EOF
				cnt = cnt + 1
				if doheader = true then
					response.write "<tr>"
					Response.write "<th nowrap>Type</th><th nowrap>Detail</th><th nowrap>Notes</th>"
					Response.Write "</tr>"
					doheader = false
				end if
				response.write "<tr>"
				select case lcase(rs("type"))
					case "email"
						detail = "<a href=""mailto:" & rs("detail") & """>" & rs("detail") & "</a>"
					case "skype"
						detail = "<a href=""skype:" & rs("Detail") & "?call""><img src=""http://mystatus.skype.com/smallicon/" & rs("detail") & """ style=""border: none;"" width=""16"" height=""16"">" & rs("detail") & "</a> "
					case else
						detail = rs("detail")
				end select
				Response.write "<td nowrap>" & rs("type") & "&nbsp;</td><td nowrap>" & detail & "&nbsp;</td><td nowrap>" & rs("note") & "&nbsp;</td>"
				Response.Write "</tr>"
				rs.MoveNext
			loop
			response.write "</table>"
		else
			response.write "There are no contact details recorded for this person"
		end if		
		rs.Close
		set rs = nothing
		db.Close
		set db = nothing
%>
</body>
</HTML>
