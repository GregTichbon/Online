<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>
<body>

<%
	Set objMail = Server.CreateObject ("CDONTS.NewMail")
	objMail.To = "gtichbon@teorahou.org.nz"
	objMail.From = "mail@forourkids.org.nz"
	'objMail.Value("Reply-To") = request.form("email")
	objMail.Subject = "For Our Kids Test Email Test"
	objMail.Body = "Test"
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing
%>



</body>
</html>
