Database maintenance closed
<%
response.end
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		if request.form("process") = "Submit" then
			Set rs = Server.CreateObject("ADODB.RecordSet")
			with rs
				.Open "tidy", db, 1, 2
				for each frm in request.form
					if left(frm,11) = "responsible" then
						myid = mid(frm,12,99)
						.filter = "id = " & myid
						.fields("responsible") = nullify(request.form("responsible" & myid))
						.fields("complete") = nullify(request.form("complete" & myid))
						.update
					end if
				next
				.close
			end with
			set rs = nothing
			response.write "Records updated"
		end if
%>
<HTML><HEAD><title>Incedo Supporters</title>
</HEAD>
<BODY>
<form action="noteselection.asp" method="post" name="maint" id="maint">
<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<%

		Set rs = Server.CreateObject("ADODB.RecordSet")
		sql = "SELECT * FROM tidy order by [type],[what]"
		rs.Open sql, db
		doheader = true
		do until rs.eof
			if doheader = true then
				response.write "<tr>"
				for each fld in rs.Fields
					if fld.name <> "ID" then
						Response.write "<th nowrap>" & fld.name & "</th>"
					end if
				next
				Response.Write "</tr>"
				doheader = false
			end if
			response.write "<tr>"
			Response.write "<td nowrap>" & rs("type") & "</td>"
			Response.write "<td nowrap>" & rs("what") & "</td>"
			Response.write "<td nowrap><input name=""responsible" & rs("id") & """ type=""text"" id=""responsible" & rs("id") & """ value=""" & rs("responsible") & """></td>"
			Response.write "<td nowrap><input name=""complete" & rs("id") & """ type=""text"" id=""complete" & rs("id") & """ value=""" & rs("complete") & """></td>"
			response.write "</tr>"
			rs.movenext
		loop
		rs.close
		
		set rs = nothing
		db.Close
		set db = nothing
%>
</table>
	<input name="process" type="submit" id="process" value="Submit">
</form>
</BODY>
</HTML>
<%
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function
%>
