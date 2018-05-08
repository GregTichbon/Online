<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "Polls/letterhead08Apr2008"
		response.redirect "../../signon"
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo Private Polls</title>
</head>
<body>
<%
pollid = 1	
pollopen = false
showresults = false
sql = "select * from poll where pollid = " & pollid 
rs.open sql,db
if rs.eof then
	response.write "Poll not found"
else
	response.write "<p><strong>" & rs("description") & "</strong></p>"
	if now() < rs("startdatetime") then
		response.write "This poll has not yet started"
	else
		if now() > rs("enddatetime") then
			response.write "This poll has closed"
		else
			pollopen = true
		end if
	end if
	showresults = rs("showresults")
end if	
rs.close
		
if request.form("$vote") <> "" then
	db.execute "delete * from pollitem where pollid = " & pollid & " and responseid = " & session("Incedo_MemberID")
	with rs
		.Open "pollitem", db, 1, 2
		For Each key in Request.Form
			if left(key,1) <> "$" then
				.addnew
				.fields("pollid") = pollid
				.fields("responseid") = session("Incedo_MemberID")
				.fields("Questionid") = key
				.fields("Answer") = request.form(key)
			end if
			.update
		next
		.close
	end with
	response.write "Thanks for your vote"
else
	if pollopen then
%>
		<form action="default.asp" method="post" name="poll" id="poll">
<%
	end if
%>
		<table><tr>
<%
		sql = "select * from pollitem where pollid = " & pollid & " and responseid = " & session("Incedo_MemberID") & " and questionid = 'option'"
'response.write sql
'response.end
		rs.open sql, db
		if not rs.eof then
			alreadyselected = rs("answer")
		end if
		rs.close
		for f1=1 to 8
			if f1 = cint(alreadyselected) then
				checked = " checked"
			else
				checked = ""
			end if
			response.write "<td align=""center""><img src=""" & f1 & ".gif""><br>"
			if pollopen then 
				response.write "<input name=""option"" type=""radio"" value=""" & f1 & """" & checked & ">"
			else
				if checked <> "" then
					response.write "X"
				end if
			end if
			
			response.write "</td>"
		next 
		sql = "select * from pollitem where pollid = " & pollid & " and responseid = " & session("Incedo_MemberID") & " and questionid = 'comment'"
		rs.open sql, db
		if not rs.eof then
			comment = rs("answer")
		end if
		rs.close
%>
</tr></table>
		<p>Comment<br>
<%
	if pollopen then
%>
		  <textarea name="comment" cols="100" rows="4"><%=comment%></textarea>
		  </p>
		<p>
		  <input name="$vote" type="submit" id="$vote" value="Vote">
		  </p>
		</form>
<%
	else
		response.write comment
	end if
	if request.querystring("results") <> "" or showresults then
		c1 = 0
		response.write "<table border=""1"">"
		response.write "<tr><td>Answer</td><td>Votes</td></tr>"
		sql = "SELECT PollItem.Answer, Count(PollItem.Answer) AS Votes FROM PollItem WHERE PollItem.PollID = " & pollid & " AND PollItem.QuestionID = 'option' GROUP BY PollItem.Answer ORDER BY Count(PollItem.Answer) DESC"
		rs.open sql,db
		do until rs.eof
			c1 = c1 + rs("votes")
			response.write "<tr><td>" & rs("answer") & "</td><td>" & rs("votes") & "</td></tr>"
			rs.movenext
		loop
		rs.close
		response.write "<tr><td>Total</td><td>" & c1 & "</td></tr>"
		response.write "</table>"
	
		response.write "<table border=""1"">"
		sql = "SELECT pollitem.*, [firstname] & ' ' & [Lastname] AS Name FROM pollitem INNER JOIN People ON pollitem.ResponseID = People.ID WHERE pollitem.PollID = " & pollid
		rs.open sql,db
		do until rs.eof
			response.write "<tr><td>" & rs("name") & "</td><td>" & rs("questionid") & "</td><td>" &  rs("answer") & "</td></tr>"
			rs.movenext
		loop
		rs.close
		response.write "</table>"
	end if
end if
set rs = nothing
db.close
set db = nothing
%>
</body>
</html>



