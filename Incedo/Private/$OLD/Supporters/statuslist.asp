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
<HTML><HEAD><title>Incedo Supporters</title></HEAD>
<BODY>
<p><a href="classificationmaint.asp?id=new">Create a new entry</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="default.asp">Return to the menu</a></p>
<p>
</p>
<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<%

		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.RecordSet")
		sql = "SELECT * from Status"
		rs.Open sql, db
		cnt = 0
		doheader = true
		do until rs.EOF
			cnt = cnt + 1
			if doheader = true then
				response.write "<tr>"
				Response.write "<th nowrap>Amend</td>"
				for each fld in rs.Fields
					Response.write "<th nowrap>" & fld.name & "</td>"
				next
				Response.Write "</tr>"
				doheader = false
			end if
			response.write "<tr>"
			Response.write "<td><a href=classificationmaint.asp?id=" & rs("status") & "><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
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
</BODY>
</HTML>
