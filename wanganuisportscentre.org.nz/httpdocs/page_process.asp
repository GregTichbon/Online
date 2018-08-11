
    <%
'	for each frm in request.form
'		response.write frm & "=" & request.form(frm)
'	next
'	response.end
		id = request.form("id")
		if Request.Form("$delete") = "Delete" then
			mode = "delete"
		elseif Request.Form("$submit") = "Submit" then
			mode = "submit"
		elseif Request.Form("$delete") = "" then 
			mode = "submit"
		else
			Response.write "Unknown Action"
			Response.End
		end if
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\wanganuisportscentre.org.nz\wanganuisportscentre.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			if mode = "delete" or mode = "submit" then
				.Open "pages", db, 1, 2
				if id <> "new" then
					.filter = "pageid = " & id
				end if
				if mode = "delete" then
					.delete 
				else
					if id = "new" then
						.AddNew
					end if
					For Each key in Request.Form
						if left(key,1) <> "$" and key <> "id" then
	'on error resume next
							.fields(key) = nullify(request.form(key))
	'Response.Write key & "=" & request.form(key) & " - " & err.description & "<br>"
	'err.clear
						end if
					next
					.Update
				end if
				.close
			end if
		end with
		set rs = nothing
		db.Close
		set db = nothing
	
		response.redirect "pagelist.asp"
		
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function
%>


