<%
		if Request.Form("$delete") = "Delete" then
			mode = "delete"
		elseif Request.Form("$submit") = "Submit" then
			mode = "submit"
		else
			Response.write "Unknown Action"
			Response.End
		end if
		id = request.form("id")
		if id = "new" then 
			mode = "new"
		end if
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\connectme.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "regions_classifications", db, 1, 2
			if id <> "new" then
				.filter = "id = " & id
			end if
			if mode = "delete" then
				.delete
			else
				if id = "new" then
					.AddNew
				end if
				For Each key in Request.Form
					if left(key,1) <> "$" and key <> "id" then
on error resume next
						.fields(key) = nullify(request.form(key))
if err.number <> 0 then
	Response.Write key & "=" & request.form(key) & " - " & err.description & "<br>"
	response.end
end if
					end if
				next
				.Update
			end if
			.close
		end with
		set rs = nothing

		db.close
		set db = nothing
		
		response.redirect "classificationlist.asp"
		
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function
%>


