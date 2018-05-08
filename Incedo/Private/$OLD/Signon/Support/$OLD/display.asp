<HTML>
<HEAD>
<META HTTP-EQUIV="REFRESH" CONTENT="5;display.asp">
</HEAD>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000" LINK="#FF0000" VLINK="#FF0000">
<FONT SIZE=2>
<table width="100%">
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\incedo\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	sql = "UPDATE [session] set lastrefresh = '" & now() & "'"
	db.execute sql
	

	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "select * from dialogue where [session] = " & session("chatid") & " order by id"
	rs.Open sql, db
	do until rs.eof
		if rs("staff") <> "" then
			tdcolour = " bgcolor=""#66FFCC"""
		else
			tdcolour = ""
		end if
		response.write "<tr><td" & tdcolour & ">" & rs("narrative") & "</td></tr>"
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
%>
</table>
</FONT>
</BODY>
</HTML>