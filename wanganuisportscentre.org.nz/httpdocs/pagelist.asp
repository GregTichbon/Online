<%
	if session("wcsc-signedon") = "" then
		response.redirect "signon.asp"
	end if
%>
<html>
<head>
<title>Wanganui Sports Centre Administration</title>
</head>
<body>
    <h1>PAGE LIST</h1>
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\wanganuisportscentre.org.nz\wanganuisportscentre.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * from [pages] order by [reference]"  
	rs.Open sql, db
	do until rs.eof
		response.write "<p><a href=""page.asp?page=" & rs("reference") & """>" & rs("reference") & "</a></p>"
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
%>
	<!--<p><a href="page.asp?page=new">Create a new page</a> </p><br>-->
  <br>
  <a href="admin.asp">Main Menu</a>
</body>
</html>
