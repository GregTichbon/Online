<%
	password = request.form("password")
	
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	ok = false
	rs.Open "staff", db, 1, 2
	rs.filter = "id = " & request.form("staffid")
	if lcase(rs.fields("password")) = lcase(password) then
	
	'''''Put code in here to say if someone else has bet you to it.
	
		sql = "update [session] SET Staff = " & request.form("staffid") & " where id = " & request.form("chatid")
'response.write sql
'response.end
		db.execute sql
		session("chatstaff") = request.form("staffid")
		session("chatid") = request.form("chatid")
		ok = true
	end if
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	if ok then
		response.redirect "main.asp"
	else
%>
<html><title></title><body>
Invalid Password
<a href="../../Chat/Staff/answer.asp">Try again</a>
</body></html>
<%
end if
%>
