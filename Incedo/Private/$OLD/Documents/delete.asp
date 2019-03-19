<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo Upload Documents</title>
</head>
<body>
<%
	'response.write Server.MapPath("\") & "<br>" & Server.MapPath(".")
	'response.end
	id = request.querystring("document")
	name = request.querystring("name")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string

	db.execute "delete * from documentupdates where document = " & id

	db.execute "delete * from documents where id = " & id 

	db.close
	set db = nothing
	
	rootfolder = Server.MapPath(".") & "\documents\" & name

	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	if fs.FileExists(name) then
	 	'fs.DeleteFile(name)
	end if
	set fs=nothing

%>
</body>
</html>
