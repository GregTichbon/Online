<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	email = request.querystring("email")
%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Email Accounts</title>
</head>
<body>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<tr><td colspan="3" bgcolor="yellow"><%=email%></td></tr>

<%

	connection_string = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Port=3307;Database=hmailserver;User=email;Password=reports;Option=3;"
	Set db = CreateObject("ADODB.Connection")
	db.ConnectionString = connection_string
	db.Open	
	Set rs = Server.CreateObject("ADODB.RecordSet")
	
	sql = "select F.foldername as 'Folder', (sum(M.messagesize) / 1048576) as 'Size', count(m.messageid) as 'Email' from hm_accounts A " & _
			"left outer join hm_messages M on M.messageaccountid = A.AccountID " & _
			"left outer join hm_imapfolders F on F.folderid = M.messagefolderid " & _
			"where accountaddress = '" & email & "' " & _
			"group by F.foldername " & _
			"order by F.foldername"

'response.write sql
	
	headingsdone = ""
	rs.Open sql, db
	do until rs.EOF
		if headingsdone = "" then
			response.write "<tr>"
			for each fld in rs.fields
				response.write "<td>" & fld.name & "</td>"
			next
			response.write "</tr>"
			headingsdone = "Yes"
		end if
		for each fld in rs.fields
			response.write "<td>" & fld & "&nbsp;</td>"
		next
		response.write "</tr>"
		rs.movenext
	loop
	rs.close


	set rs = nothing
	db.close
	set db = nothing
	
%>
</table>
</body>
</html>



