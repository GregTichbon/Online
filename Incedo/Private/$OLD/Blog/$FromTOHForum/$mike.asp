<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>
<body>
Hello World<br>
<!--#include file = "database.inc"-->

<%

	envelope1 = 1
	envelope1 = envelope1 + 1
	envelope1 = envelope1 + 1
	envelope1 = envelope1 + 1


	do until envelope1 > 100
		envelope1 = envelope1 + 1
		if envelope1 > 100 then response.end
		response.write envelope1
	loop


	for f1=1 to 10
		if f1 > 5 then response.write "BIG: "
		response.write f1 & "<br>"
	next
	response.write "It is now: " & now()
	
%>
</body>
</html>
