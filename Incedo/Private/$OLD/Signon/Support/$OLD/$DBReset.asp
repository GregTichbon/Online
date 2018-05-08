<html>
<head>
<title></title>
</head>
<body>

<%

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	sql = "delete * from [session]"
	db.Execute sql	 
	response.write "<br>" & sql & " Done " & now()

	sql = "delete * from [dialogue]"
	db.Execute sql	 
	response.write "<br>" & sql & " Done " & now()

	sql = "delete * from [staffonline]"
	db.Execute sql	 
	response.write "<br>" & sql & " Done " & now()

	sql = "UPDATE Staff SET Staff.Online = False"
	db.Execute sql	 
	response.write "<br>" & sql & " Done " & now()

	db.Close 
	set db = nothing
	

%>

</body>
</html>
