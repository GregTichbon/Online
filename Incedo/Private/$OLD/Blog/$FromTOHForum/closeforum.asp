<%
		messageid = request.querystring("messageid")
		checked = request.querystring("checked")
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\teorahou\teorahou.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "ForumMessages", db, 1, 2
			.filter = "id = " & messageid 
			.fields("closed") = checked
			.Update
		end with
		rs.close
		set rs = nothing
		db.Close
		set db = nothing
%>
