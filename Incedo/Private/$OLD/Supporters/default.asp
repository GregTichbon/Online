<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo</title>
</head>
<body>
<p><a href="entitymaintselect.asp">Supporter Maintenance</a></p>
<p><a href="entityreports.asp">Supporter Reports</a></p>
<p><a href="classificationlist.asp">Classifications Maintenance</a></p>
<p><a href="statuslist.asp">Status Maintenance</a></p>
<p><a href="sql.asp">Supporter SQL </a></p>
<p><a href="../default.asp">Return to Main Menu</a></p>
</body>
</html>
