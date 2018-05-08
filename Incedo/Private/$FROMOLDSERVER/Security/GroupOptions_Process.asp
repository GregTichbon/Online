
  <%
	'for each fld in request.form
	'	response.write fld & "=" & request.form(fld) & "<br>"
	'next
	'response.end
  
  	groupid = request.form("$id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	with rs
		.Open "securitygroupoptions", db, 1, 2
		for each fld in request.form
			if (fld = "new" and request.form(fld) <> "") or isnumeric(fld) then
				if fld = "new" then
					.addnew
				else
					.filter = "id = " & fld
				end if
				if request.form("delete" & fld) = "-1" then
					.delete
				else
					.Fields("group") = groupid
					.fields("option") = request.form(fld)
					.fields("description") = request.form("description" & fld)
					.fields("baseareaoption") = request.form("baseareaoption" & fld)
					.update
				end if
			end if
		next
		.close
	end with	
	
	set rs = nothing
	db.Close
	set db = nothing
	response.redirect "groupoptions.asp?id=" & groupid
%>



