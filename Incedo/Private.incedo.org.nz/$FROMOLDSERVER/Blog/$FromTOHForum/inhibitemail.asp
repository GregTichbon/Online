<%
		messageid = request.querystring("messageid")
		personid = request.querystring("personid")
		checked = request.querystring("checked")
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\teorahou\teorahou.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "ForumMessageMember", db, 1, 2
			.filter = "forummessageid = " & messageid & " and forummemberid = " & personid
			if .eof then
				.AddNew
				.fields("forummessageid") = messageid
				.fields("forummemberid") = personid
				response.write "NEW"
			end if
			.fields("inhibitemail") = checked
			.Update
		end with
		rs.close
		set rs = nothing
		db.Close
		set db = nothing
%>



