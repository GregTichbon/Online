<%
	if session("Incedo_MemberID")= "" then
	session("Incedo_Returnto") = "email/default.asp"
		response.redirect "../signon"
	else
		secgroup = "Email"
		secoption = "Full"
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
