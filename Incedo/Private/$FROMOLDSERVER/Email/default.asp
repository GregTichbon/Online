<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Email"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>YFCNZ/Incedo Members Updates</title>
</head>
<body style="text-align:center">
<p><a href="general">General</a></p>
<p> <a href="updates"> Updates </a></p>
</body>
</html>



