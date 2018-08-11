<%
	password = request.form("password")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\wanganuisportscentre.org.nz\wanganuisportscentre.mdb"
	
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT * from params where [key] = 'password' and [value] = '" & password & "'"
'response.write sql
'response.end
	rs.Open sql, db
	if rs.eof then
		session("wcsc-signedon") = ""
		response.redirect "signon.asp"
	else
		session("wcsc-signedon") = -1
		response.redirect "admin.asp"
	end if
	rs.close
	set rs = nothing
	db.Close
	set db = nothing
%>