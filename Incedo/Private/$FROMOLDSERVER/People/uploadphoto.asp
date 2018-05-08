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
<title>Incedo People</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<form action="uploadphotoProcess.asp?id=<%=request.querystring("id")%>" method="post" enctype="multipart/form-data" name="photos" id="photos">
  <input name="filename" type="file" id="filename" size="30">
  <input name="submit" type="submit" id="submit" value="Submit">
</form>
</body>
</html>



