<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
  <tr><td>Email</td><td>Last Accessed</td></tr>
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\datainnovations\general.mdb;"
	Set dbw = Server.CreateObject("ADODB.Connection")
	dbw.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

	email = request.querystring("email")
	
	sql = "select email, lastaccessed from emailaccess"
	if email <> "" then
		sql = sql & " where email = '" & email & "'"
	end if
	sql = sql & " order by email, lastaccessed desc" 
	
	rs.Open sql, dbw
	do until rs.eof
		response.write "<tr><td>" & rs("email") & "</td><td>" & rs("lastaccessed") & "</td></tr>"
		rs.movenext
	loop
	rs.close
	
	set rs = nothing
	dbw.close
	set dbw = nothing
	
%>
</table>



