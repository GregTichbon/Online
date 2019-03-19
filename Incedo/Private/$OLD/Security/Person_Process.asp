
  <%
	for each fld in request.form
		response.write fld & "=" & request.form(fld) & "<br>"
	next
	'response.end
  
  	id = request.form("$id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	with rs
		.Open "People_SecurityOption", db, 1, 2
		for each fld in request.form
			if isnumeric(fld) then
				.filter = "person = " & id & " and option = " & fld
				if .eof then
					.addnew
					.fields("person") = id
					.fields("option") = fld
				end if
				.Fields("value") = request.form(fld)
				.fields("basearea") = request.form("basearea" & fld)
				.update
			end if
		next
		.close
	end with	
	
	set rs = nothing
	db.Close
	set db = nothing
	response.redirect "personlist.asp"
%>
