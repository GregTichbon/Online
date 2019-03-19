<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	
	id = request.form("id")
	useid = id
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	with rs
		.Open "poll", db, 1, 2
		if id = "new" then
			.addnew
			.fields("datetime") = now()
		else
			.filter = "pollid = " & id
		end if
		.fields("proposition") = request.form("proposition")
		if request.form("active") = "-1" then
			.fields("active") = true
		else
			.fields("active") = false
		end if
		if request.form("showresults") = "-1" then
			.fields("showresults") = true
		else
			.fields("showresults") = false
		end if
		.update
		newid = .fields("pollid")
		useid = newid
		.close
	end with
	set rs = nothing

	Set rs = Server.CreateObject("ADODB.RecordSet")
	with rs
		.Open "polloptions", db, 1, 2
		if id = "new" then
			for f1=1 to 5
				if trim(request.form("answer" & f1)) & "" <> "" then
					c1 = c1 + 1
					.addnew
					.fields("poll") = newid
					.fields("seq") = c1
					.fields("answer") = request.form("answer" & f1)
					.update
				end if
			next
		else
			for f1=1 to 5
				.filter = "poll = " & id & " and seq = " & f1
				if not .eof then
					if trim(request.form("answer" & f1)) & "" = "" then
						.delete
						'response.write "delete " & f1 & "<br>"
					else
						c2 = c2 + 1
						.fields("seq") = c2
						.fields("answer") = request.form("answer" & f1)
						.update
						'response.write "update " & f1 & "," & c2 & "<br>"
					end if
				else
					if trim(request.form("answer" & f1)) & "" <> "" then
						.addnew
						.fields("poll") = id
						'response.write "add " & f1 & "<br>"
						c2 = c2 + 1
						.fields("seq") = c2
						.fields("answer") = request.form("answer" & f1)
						.update
						'response.write "update " & f1 & "," & c2 & "<br>"
					end if
				end if
			next
		end if
		.close
	end with
	set rs = nothing
	db.close
	set db = nothing
	
	response.redirect "pollmaint.asp?id=" & useid
%>



