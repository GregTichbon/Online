***
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\datainnovations\general.mdb;"
	Set dbw = Server.CreateObject("ADODB.Connection")
	dbw.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

	email = request.querystring("email")
	
	connection_string = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Port=3307;Database=hmailserver;User=email;Password=reports;Option=3;"
	Set db = CreateObject("ADODB.Connection")
	db.ConnectionString = connection_string
	db.Open	
	
	Set rsaccounts = Server.CreateObject("ADODB.RecordSet")
	
	sql = "SELECT accountaddress, accountlastlogontime from hm_accounts where accountaddress = '" & email & "'"
	
	rsaccounts.Open sql, db
	
	if not rsaccounts.EOF then
		sql = "select max(lastaccessed) as maxlastaccessed from emailaccess where email = '" & email & "'"
		rs.Open sql, dbw
		'dim lastrecordedaccessed as Date
		'dim lastaccessed as Date
		if rs.EOF then
			lastrecordedaccessed = cdate("1-Jan-2000")
		else
			lastrecordedaccessed = cdate(rs("maxlastaccessed"))
		end if
		rs.close
		lastaccessed = rsaccounts("accountlastlogontime")
		if lastaccessed > lastrecordedaccessed then
			sql = "insert into emailaccess (Email, lastaccessed) values ('" & email & "', '" & lastaccessed & "')"
			dbw.execute sql
		end if
		response.write rsaccounts("accountaddress") & "," & lastrecordedaccessed & ", " & lastaccessed
	end if
	
	rsaccounts.close
	set rsaccounts = nothing
	db.close
	set db = nothing
	
	set rs = nothing
	dbw.close
	set dbw = nothing
	
%>



