<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\yfcnz\txtmessages.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	Set rs = Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Text Capture</title>
</head>
<body>
<%
	id = request.querystring("id")
	if id = "" then
		if request.form("$submit") = "" then
			sql = "select * from [control] order by querystring"
			rs.open sql, db
			first = true
			do until rs.eof
				if first then
					response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"">"
					response.write "<tr><td>From</td><td>To</td><td>Preface</td><td>Response</td><td>Edit</td></tr>"
					first = false
				end if
				response.write "<tr><td>" & rs("fromtime") & "</td><td>" & rs("totime") & "</td><td>" & rs("querystring") & "</td><td>" & rs("response") & "</td><td><a href=""capturesetup.asp?id=" & rs("id") & """>...</a></tr>"
				rs.movenext
			loop
			rs.close
			if not first then
				response.write "</table>"
			end if
		elseif request.form("$submit") = "Submit Password" then
			sql = "select * from [control] where id = " & request.form("$id") & " and [password] = '" & request.form("password") & "'"
			rs.open sql, db
			if rs.eof then
				session("yfc-txtcapture") = ""
				redirect = "setup.asp"
			else
				session("yfc-txtcapture") = request.form("$id")
				redirect = "setup.asp"
			end if
		else
			response.write "UPDATE"
		
		end if
	else
		if session("yfc-txtcapture") = "" then
			'get password
%>
<form action="setup.asp" method="post" name="password" id="password">
  Please enter the password:
    <input name="$id" type="hidden" id="$id" value="<%=id%>"> 
  <input name="password" type="password" id="password">
  <input name="$submit" type="submit" id="$submit" value="Submit Password">
</form>
<p>
  <%
		else
			'if request.form("$id") <> "" then
			'	response.write "Update"
			'	response.end
			'else
				'amend screen
				sql = "select * from [control] where id = " & id
				rs.open sql, db
				if not rs.eof then
					fromtime = rs("fromtime")
					totime = rs("totime")
					querystring = rs("querystring")
					myresponse = rs("response")
					password = rs("password")
%>
</p>
<form action="setup.asp" method="post" name="maint" id="maint">
    <input name="$id" type="hidden" id="$id" value="<%=id%>"> 
  <table width="600"  border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
    <tr>
      <td><div align="right">From</div></td>
      <td><input name="fromtime" type="text" id="fromtime" value="<%=fromtime%>"></td>
    </tr>
    <tr>
      <td><div align="right">To</div></td>
      <td><input name="totime" type="text" id="totime" value="<%=totime%>"></td>
    </tr>
    <tr>
      <td><div align="right">Preface</div></td>
      <td><input name="querystring" type="text" id="querystring" value="<%=querystring%>"></td>
    </tr>
    <tr>
      <td><div align="right">Response</div></td>
      <td><textarea name="response" cols="80" rows="3" id="response"><%=myresponse%></textarea></td>
    </tr>
    <tr>
      <td><div align="right"></div></td>
      <td><input name="$submit" type="submit" id="$submit" value="Submit"></td>
    </tr>
  </table>
</form>
  <%
				end if
				rs.close
  			'end if
		end if
	end if
	set rs = nothing
	db.close
	set db = nothing
	
	if redirect <> "" then
		response.redirect redirect
	end if
	
%>
</body>
</html>



