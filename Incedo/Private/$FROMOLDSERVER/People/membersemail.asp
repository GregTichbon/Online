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
<HTML><HEAD><title>Incedo People</title></HEAD>
<BODY>
<p align="center"><b><font size="+3">Incedo Members' Email Addresses</font></b><br>
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT Email "
	sql = sql & " from people"
	sql = sql & " where membershipdate is not null and category <> 'Ceased'"
	sql = sql & " ORDER BY lastname, firstname"
'Response.Write sql 
'Response.end
	delim = ""
	rs.Open sql, db
	do until rs.EOF
		email = email & delim & rs("email")
		delim = ";"
		rs.MoveNext
	loop
		
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
%>
<textarea name="email" rows="10" id="email" style="width:100%"><%=email%></textarea>
<a href="mailto:<%=email%>">Send Email</a>
</BODY>
</HTML>




