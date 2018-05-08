<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Email Accounts</title>
</head>
<body>
<%
	domain = request.querystring("domain")
	connection_string = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Port=3307;Database=hmailserver;User=email;Password=reports;Option=3;"
	Set db = CreateObject("ADODB.Connection")
	db.ConnectionString = connection_string
	db.Open	
	Set rsdomains = Server.CreateObject("ADODB.RecordSet")
	
	
	sql = "SELECT * from hm_domains where domainname = '" & domain & "'"
	
	rsdomains.Open sql, db
	
	if not rsdomains.eof then
		Set rsaccounts = Server.CreateObject("ADODB.RecordSet")
		sql = "SELECT accountaddress as 'Address' from hm_accounts where accountdomainid = " & rsdomains("domainid") & " and accountactive = 1 order by accountaddress"
		rsaccounts.Open sql, db
		do until rsaccounts.EOF
			response.write rsaccounts("address") & "; "
			rsaccounts.movenext
		loop
		rsaccounts.close
		set rsaccounts = nothing
	end if
	rsdomains.close
	set rsdomains = nothing
	db.close
	set db = nothing
	
%>
</table>
</body>
</html>



