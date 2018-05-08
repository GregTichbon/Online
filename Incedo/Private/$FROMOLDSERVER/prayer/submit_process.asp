<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	end if
	
		if request.form("$create") = "Create" then
			mode = "create"
		elseif Request.Form("$modify") = "Modify" then
			mode = "modify"
		elseif Request.Form("$delete") = "Delete" then
			mode = "delete"
		else
			Response.write Request.Form("$submit") & "Unknown Action"
			Response.End
		end if
		id = request.form("id")
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "prayeritem", db, 1, 2
			if mode = "modify" or mode = "delete" then
				.filter = "itemid = " & id
			end if
			if mode = "delete" then
				.delete
			elseif mode = "modify" or mode = "create" then
				if mode = "create" then
					.AddNew
					.fields("datetime") = now()
					.fields("submittedby") = session("Incedo_MemberID")
				end if
				.Fields("categoryid") = request.form("category")
				.Fields("title") = request.form("title")
				.Fields("narrative") = request.form("narrative")
				.fields("expireon") = request.form("expireon")
				if mode = "modify" then
					if request.form("closed") = "true" then
						closed = true
					else
						closed = false
					end if
					.fields("closed") = closed
				end if
				.Update
			end if
		end with
		rs.close
		set rs = nothing
		db.Close
		set db = nothing
		response.redirect "default.asp"
%>


