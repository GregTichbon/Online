<HTML><HEAD><TITLE>Incedo People</TITLE>
<%
	set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	with rs
		.Open "people", db, 1, 2
		.Filter = "[password] = null"
		do until .EOF
			pw = DI.DI_GeneratePassword(6,6)
			Response.Write .fields("lastname") & ", " & .Fields("firstname") & " = " & pw & "<br>"
			.Fields("password") = pw
			.Update 
			.MoveNext
		loop
		.Close
	end with
	set rs = nothing
	db.Close
	set db = nothing 	
%>
</BODY>
</HTML>
