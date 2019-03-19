<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "FAQ"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>YFCNZ Members Updates</title>
</head>

<body style="text-align:center">
<br>
<%
	Dim rsTemp
	Const adVarChar = 200
	Const adInteger = 3
	Const adDate = 7
	
	Set rsTemp = Server.CreateObject("ADODB.Recordset")
	rsTemp.Fields.Append "Filename", adVarChar, 255
	rsTemp.Open

	set fs = CreateObject("Scripting.FileSystemObject")
	mypath = "."
	path = Server.MapPath(mypath)

	set folder = fs.GetFolder(path)
	for each item in folder.subfolders
		rsTemp.AddNew
		rsTemp.Fields("filename").Value = item.name
	next
	set folder = nothing
	set fs = nothing
	
	rsTemp.Sort = "filename DESC"
	rsTemp.MoveFirst
	Do While Not rsTemp.EOF
		myDate = rsTemp("filename")
		myDate = mid(myDate,7,2) & "/" & mid(myDate,5,2) & "/" & mid(myDate,1,4)
		response.write "<a href=""" & rsTemp("filename") & """>" & myDate & "</a><br>"
		rsTemp.movenext
	loop
	rsTemp.Close
	Set rsTemp = Nothing

	set di = nothing
%>
</body>
</html>
