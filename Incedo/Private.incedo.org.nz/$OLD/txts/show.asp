<html>
<title>Check txt</title>
<body>
<table>
<%

connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\txtmessages.mdb"
	
Set db = Server.CreateObject("ADODB.Connection")
db.Open connection_string
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "replies", db, 1, 2
do until rs.eof
	Response.Write  "<tr><td>" & rs("MessageId") & "</td><td>" & rs("datetime") & "</td><td>" & rs("reportstatusdescription") & "</td><td>" & rs("mobilenumber") & "</td><td>" & rs("MessageText") & "</td></tr>"
	rs.movenext
loop
rs.close
set rs = nothing
db.close
set db = nothing
%>
</table></body>
</html>