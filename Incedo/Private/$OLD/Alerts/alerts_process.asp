
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
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			if mode = "delete" or mode = "submit" then
				.Open "alerts", db, 1, 2
				if id <> "new" then
					.filter = "alertsid = " & id
				end if
				if mode = "delete" then
					newid = id
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
	err.clear
	errflag = 1
end if
						end if
					next
on error goto 0
					if request.form("$rssupdate") then
						.fields("rssdate") = GMTDate(now())
					end if
					.fields("updated") = GMTDate(now())
'response.write request.form("$date") & " " & request.form("$starthour") & ":" & request.form("$startmin")
'response.end
if errflag = 1 then
	response.end
end if
					.Update
				end if
				.close
			end if
		end with
		set rs = nothing
		db.Close
		set db = nothing
	
		response.redirect "default.asp"
		
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function

Function GMTDate(passDate)
    Server.Execute "/GetServerGMTOffset.asp"
	GMTDate = dateadd("n", Session("ServerGMTOffset"), passDate)
End Function
%>


