<HTML>
<HEAD>
</HEAD>
<BODY>
<%
	nickname = request.form("nickname")
	question = request.form("question")
	zone = request.form("zone")
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	with rs
		.Open "[session]", db, 1, 2
		.AddNew 
		.fields("session") = session.sessionid & di.DI_format(now,"yyyymmddhhmmss")
		.fields("nickname") = nickname
		if Request.ServerVariables("HTTP_X_FORWARDED_FOR") <> "" then
			IP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		else
			IP = Request.ServerVariables("Remote_Host")
		end if		
		.fields("ipaddress") = ip
		.fields("starttime") = now()
		.fields("zone") = zone
		.update
		id = .fields("id")
		session("chatid") = id
		session("chatnickname") = nickname
		.close
		.Open "[dialogue]", db, 1, 2
		.AddNew 
		.fields("session") = id
		.fields("datetime") = now()
		.fields("narrative") = nickname & ": " & question
		.update
		.close
	end with
	set rs = nothing
	db.close
	set db = nothing
	response.redirect "main.asp"
%>
</BODY>
</HTML>