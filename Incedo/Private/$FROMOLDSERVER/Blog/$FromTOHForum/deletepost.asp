<%
	if session("TeOraHou_MemberID")= "" then
		session("TeOraHou_Returnto") = "forum/default.asp?" & request.querystring
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
	parent=request.querystring("parent")
	id=request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\teorahou\teorahou.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "select * from ForumMessages where id = " & id
	rs1.Open sql, db
	if not rs1.eof then
		parent = rs1("parentmessage")
		threadparent = rs1("threadparent")
		sql = "update ForumMessages SET ParentMessage = " & parent & " WHERE ParentMessage = " & id
		db.execute sql
		sql = "delete * FROM ForumMessages where id = " & id
		db.execute sql
		sql = "update ForumMessages SET replycount = replycount - 1 WHERE threadparent = " & threadparent & " and parentmessage = 0"
		db.execute sql
	end if
	rs1.close
	set rs1 = nothing
	db.close
	set db = nothing
	response.redirect "showposts.asp?id=" & parent
%>


