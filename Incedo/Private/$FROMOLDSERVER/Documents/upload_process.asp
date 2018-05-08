<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo Upload Documents</title>
</head>
<body>
<%
	'response.write Server.MapPath("\") & "<br>" & Server.MapPath(".")
	'response.end
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	Set rs2 = Server.CreateObject("ADODB.RecordSet")
	rs1.Open "documents", db, 1, 2
	rs2.Open "documentupdates", db, 1, 2

	rootfolder = Server.MapPath(".") & "\documents\"
	set SC = server.createobject("SCUpload.Upload")
	SC.upload
	for i = 1 to SC.files.count
		for j = 1 to SC.files(i).item.count
			SC.files(i).item(j).save rootfolder
			rs1.AddNew
			rs1.fields("document") = SC.files(i).item(j).filename
			rs1.fields("description") = SC.Forms("description").Item(1).Value
			rs1.Update
			id = rs1.fields("id")
			
			rs2.fields("document") = id
			rs2.fields("date") = date()
			rs2.fields("detail") = SC.Forms("detail").Item(1).Value
			rs2.fields("who") = SC.Forms("who").Item(1).Value
			rs2.Update
		next 
	next 
	set SC = nothing
	set sir = nothing

	rs2.close
	set rs2 = nothing
	rs1.close
	set rs1 = nothing
	db.close
	set db = nothing
%>
</body>
</html>



