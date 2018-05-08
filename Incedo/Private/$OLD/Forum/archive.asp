<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "forum/default.asp?" & request.querystring
		response.redirect "../signon"
	else
		secgroup = "Forum"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		'if secresult = "Failed" then 		
		'	response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
		'	response.end
		'end if
	end if
%>
<!--#include file="../inc_logging.asp"-->
<!--#include file = "database.inc"-->
<%
	id=request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	Set rs2 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * " & _	
		  "FROM ForumMessages where threadparent = " & id & " order by id"
	rs1.Open sql, db
	rs2.Open "ForumArchive", db, 1, 2
	do until rs1.eof 
		rs2.addnew
		for each fld in rs1.fields
			'if fld.name <> "ID" then
				'response.write fld.name & "<br>"
				rs2(fld.name) = rs1(fld.name)
			'end if
		next
		rs2.update
		'response.write rs1("topic") & "<br>"
		rs1.movenext
	loop
	db.execute "delete * from ForumMessages where threadparent = " & id
	rs2.close
	set rs2 = nothing
	rs1.close
	set rs1 = nothing
	db.close
	set db = nothing
	response.redirect "default.asp"
%>