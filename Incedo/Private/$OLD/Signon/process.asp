	<%
		id = request.form("id")
		password = request.form("password")
		remembermembershipid = request.form("remembermembershipid")
		rememberpassword = request.form("rememberpassword")
		if remembermembershipid <> "-1" then
			Response.Cookies("Incedo_MemberID") = ""
		end if
		if remembermembershipid <> "-1" then
			Response.Cookies("Incedo_Password") = ""
		end if
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql = "Select * from [people] where [id] = " & id & " and [password] = '" & password & "'"
		rs.open sql, db
		if not rs.eof then
			session("Incedo_MemberID") = rs("id")
			session("Incedo_firstname") = rs("firstname")
			session("Incedo_lastname") = rs("lastname")
			session("Incedo_knownas") = rs("knownas")
			sql = "update [people] set lastloggedon = '" & GMTDate(now()) & "' where id = " & rs("id")
			db.execute sql
			if remembermembershipid = "-1" then
				Response.Cookies("Incedo_MemberID") = id
				Response.Cookies("Incedo_MemberID").Expires = Date + 365
			end if
			if rememberpassword = "-1" then
				Response.Cookies("Incedo_Password") = password
				Response.Cookies("Incedo_Password").Expires = Date + 365
		end if
			if session("Incedo_Returnto") <> "" then
				redirectto = session("Incedo_Returnto")
				session("Incedo_Returnto") = ""
				response.redirect "../" & redirectto
			else
				redirect = "../default.asp"
			end if
		else 
			session("message") = "Invalid Membership ID/Password"
			session("Incedo_MemberID") = ""
			session("Incedo_firstname") = ""
			session("Incedo_lastname") = ""
			session("Incedo_knownas") = ""
			redirect = "default.asp"
		end if
		rs.close
		set rs = nothing
		db.Close
		set db = nothing

		response.redirect redirect

Function GMTDate(passDate)
    Server.Execute "\GetServerGMTOffset.asp"
	'Session("ServerGMTOffset") = 240
	GMTDate = dateadd("n", Session("ServerGMTOffset"), passDate)
End Function
%>
