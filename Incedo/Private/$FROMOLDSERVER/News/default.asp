<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "News"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult = "Failed" then 		
			response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
			response.end
		end if
	end if
'response.write secbasearea & "<br>"
%>
<html>
<head>
<title>Incedo News</title>
</head>
<body>
    <h1>NEWS LIST</h1>
    <table border="1" cellspacing="0" cellpadding="1">
	<tr><td>Edit</td><td>Title</td><td>Date</td><td>Start Date</td><td>End Date</td></tr>
    <%
	set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * " & _	
		  "FROM news order by datetime desc"
	rs.Open sql, db
'response.write "*" & secbasearea &"*<br>"
	do until rs.eof 
		bases = split(secbasearea,", ")
		for each base in bases
			if instr(rs("basearea"),", " & base & ",") > 0 then
				'response.write "<tr><td><a href=""news.asp?id=" & rs("newsid") & """> Edit</a></td><td>" & rs("title") & "</td><td>" & di.di_format(rs("datetime"),"dd mmm yy hh:mm") & "</td><td>" & di.di_format(rs("startdate"),"dd mmm yy") & "</td><td>" & di.di_format(rs("enddate"),"dd mmm yy") & "</td><td>" & rs("basearea") & "</td></tr>"
				response.write "<tr><td><a href=""news.asp?id=" & rs("newsid") & """> Edit</a></td><td>" & rs("title") & "</td><td>" & di.di_format(rs("datetime"),"dd mmm yy hh:mm") & "</td><td>" & di.di_format(rs("startdate"),"dd mmm yy") & "</td><td>" & di.di_format(rs("enddate"),"dd mmm yy") & "</td></tr>"
				exit for
			end if
		next
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	set di = nothing
%>
	<tr><td colspan="5"><a href="news.asp?id=new">Create</a></td></tr>

</table>
    <p><a href="../default.asp">Main Menu</a> </p>
    <p>&nbsp;</p>
</body>
</html>



