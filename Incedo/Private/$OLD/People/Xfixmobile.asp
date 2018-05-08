<HTML><HEAD><title>Fix Mobile</title></HEAD>
<BODY>
  <%
	Server.ScriptTimeout = 20000
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$generic\Incedo\people.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "select id, mobile from people where mobile <> ''"
	rs.Open sql, db
	do until rs.eof
		mobiletext = rs("mobile")
		mobiletext = replace(mobiletext," ","")
		mobiletext = replace(mobiletext,"-","")	
		mobiletext = replace(mobiletext,"(","")
		mobiletext = replace(mobiletext,")","")
		if mobiletext <> rs("mobile") then
			response.write mobiletext & "<br>"
			if mobiletext = "" then mobiletext = null
			sql = "UPDATE People SET mobile = '" & mobiletext & "' WHERE id = " & rs("id")
			db.execute sql	
		end if
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	response.write "Done"
	
%>
</BODY>
</HTML>
