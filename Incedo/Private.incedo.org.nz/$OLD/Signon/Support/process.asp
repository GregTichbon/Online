<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\incedo\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	Set rs = Server.CreateObject("ADODB.Recordset")
	db.Open connection_string
	rs.Open "discussion", db, 1, 2
	if request.form("name") <> "" then
		session("chatname") = request.form("name")
	end if

	rs.addnew
	rs.fields("session") = session("chatid")
	rs.fields("name") = session("chatname")
	rs.fields("message") = request.form("message")	
	rs.update 
	rs.close
	set rs = nothing	
	db.close
	set db = nothing
%>
