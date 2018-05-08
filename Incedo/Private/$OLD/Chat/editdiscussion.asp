<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

	if request.form("$submit") <> "" then
		Set rs2 = Server.CreateObject("ADODB.RecordSet")
		with rs2
			.Open "discussion", db, 1, 2
			for each fld in request.form
				if left(fld,4) = "name" then
					id = mid(fld,5,999)
					'response.write id & "<br>"
					.filter = "id = " & id
					if not .eof then
						if request.form("delete" & id) then
							'response.write "Delete " & id & "<br>"
							.delete
						else
							.fields("names") = request.form("name" & id)
							.fields("comment") = request.form("comment" & id)
							if request.form("archived" & id) = "-1" then
								.fields("archived") = true
							else
								.fields("archived") = false
							end if
							.update
						end if
					end if
				end if
			next
			.close
		end with
		set rs2 = nothing
	end if
	showarchived = request.querystring("archived")
	if showarchived <> "" then
		sql = "select * from discussion order by id desc"
		qs = "?archived=1"
		msg = "<a href=""editdiscussion.asp"">Show Current</a>"
	else
		sql = "select * from discussion where archived = false order by id desc"
		qs = ""
		msg = "<a href=""?archived=1"">Show All</a>"
	end if
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo</title>
<style>
.outerbox {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	background-color: #FFFFFF;
	width: 780px;
	border: thin solid #000000;
}
</style>
</head>
<body background="file:///E|/Homepage/incedo/images/background.gif">
<div align="center">
  <div class="outerbox">
      <h1>Radio Incedo</h1>
        <form name="form1" method="post" action="<%=qs%>">
          <%=msg%>
            <table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000" width="100%">
		<tr><td>Name</td><td>Comment</td>
		<td>Archive/Delete</td>
		</tr>
        <%
	rs.open sql,db
	do until rs.eof
		id = rs("id")
		s = " style=""width:98%"""
		usenames = rs("names")
		if usenames = "" then usenames = "Unknown"
		if rs("archived") then
			checked = " checked"
		else
			checked = ""
		end if
		response.write "<tr><td><input type=""text"" name=""name" & id & """ value=""" & usenames & """" & s & "></td><td><textarea name=""comment" & id & """" & s & ">" & rs("comment") & "</textarea></td><td><input name=""archived" & id & """ type=""checkbox"" value=""-1""" & checked & "><input name=""delete" & id & """ type=""checkbox"" value=""-1""></td></tr>"
		rs.movenext
	loop
	rs.close
%>
          <tr><td colspan="3"><input name="$submit" type="submit" id="$submit" value="Submit"></td></tr>
		  </table>
        </form>
</div>
</div>
<script type="text/javascript" language="JavaScript" src="http://www.incedo.org.nz/statistics/stats_js.asp"> </script>
</body>
</html>
<%
	set rs = nothing
	db.close
	set db = nothing
%>
