
  <%
 if 1=2 then
for each fld in request.form
	response.write fld & "=" & request.form(fld) & "<br>"
next
response.end
end if
  
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	with rs
		.Open "GroupDailyRespondents", db, 1, 2
		for each fld in request.form
			if (fld = "new" and request.form(fld) <> "") or isnumeric(fld) then
				if fld = "new" then
					.addnew
				else
					.filter = "id = " & fld
				end if
				if request.form(fld) = "" and request.form("mobile" & fld) = "" then
					.delete
				else
					.fields("name") = request.form(fld)
					.fields("mobile") = request.form("mobile" & fld)
					.fields("group") = request.form("group" & fld)
					.update
				end if
			end if
		next
	end with	
	
	'rs.Close
	set rs = nothing
	db.Close
	set db = nothing
	response.redirect "GroupDailyRespondents.asp"
%>



