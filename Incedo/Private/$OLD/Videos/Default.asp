<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Videos"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult = "Failed" then 		
			response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
			response.end
		end if
	end if
%>
<html>
<head>
<title>Incedo Videos</title>
</head>
<body>
    <h1>VIDEO LIST</h1>
    <table border="1" cellspacing="0" cellpadding="1">
	<tr><td>Edit</td>
	<td>Link</td>
	<td>Title</td>
	<td>Description</td>
	<td>External Dates </td>
	<td>Internal Dates </td>
	</tr>
    <%
	set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * " & _	
		  "FROM videos order by ExternalShowFrom desc, externalShowto desc"
	rs.Open sql, db
	do until rs.eof 
		response.write "<tr><td><a href=""video.asp?id=" & rs("id") & """> Edit</a></td><td>" & rs("link") & "</td><td>" & rs("title") & "</td><td>" & rs("description") & "</td><td>" & di.di_format(rs("ExternalShowFrom"),"dd mmm yy") & " - " & di.di_format(rs("externalShowto"),"dd mmm yy") & "</td><td>" & di.di_format(rs("internalShowfrom"),"dd mmm yy") & " - " & di.di_format(rs("internalShowto"),"dd mmm yy") & "</td></tr>"
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	set di = nothing
%>
	<tr><td colspan="5"><a href="video.asp?id=new">Create</a></td></tr>

</table>
    <p><a href="../default.asp">Main Menu</a> </p>
    <p>&nbsp;</p>
</body>
</html>
