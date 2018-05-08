	<style type="text/css">
<!--
.test {
	height: 200px;
	overflow: auto;
}
-->
</style>
<%
	admin = request.querystring("admin")
	hide = request.querystring("hide")
	uniqueid = request.querystring("uniqueid")
	names = request.querystring("names")

	Response.Cookies("names")= names
	Response.Cookies("names").Expires = Date() + 365
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	
	Set rs2 = Server.CreateObject("ADODB.RecordSet")
	with rs2
		.Open "listening", db, 1, 2
		.filter = "uniqueid = '" & uniqueid & "'"
		if .eof then 
			.AddNew
			.fields("uniqueid") = uniqueid
			.fields("hide") = hide
			.fields("joined") = now()
		end if
		.fields("name") = names
		.fields("lastpolled") = now()
		if request.ServerVariables("Remote_Host") <> request.ServerVariables("Remote_addr") then
			.fields("ipaddress") = request.ServerVariables("Remote_Host") & " | " & request.ServerVariables("Remote_addr")
		else
			.fields("ipaddress") = request.ServerVariables("Remote_Host")
		end if
		.update
		.close
	end with
		
	votes = split(request.querystring("votes"),",")
	with rs2
		.Open "votes", db, 1, 2
		for each vote in votes
			voteparts = split(vote,"|")
			.filter = "uniqueid = '" & uniqueid & "' and poll = " & voteparts(0)
			'response.write myfilter & " set to:  " & voteparts(1) & "<br>"
			if .eof then 
				.AddNew
				.fields("uniqueid") = uniqueid
				.fields("poll") = voteparts(0)
			end if
			.fields("polloption") = voteparts(1)
			.update
		next
		.close
	end with
	set rs2 = nothing
	
	response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"" width=""100%"">"
	sql = "select * from params where seq <> 0 order by seq"
	rs.open sql,db
	do until rs.eof
		response.write "<tr><td width=""160"" align=""right"" nowrap>" & rs("key") & "</td><td align=""left"">" & rs("data") & "</td></tr>"
		rs.movenext
	loop
	rs.close

	sql = "select * from listening order by name"
	response.write "<tr><td width=""160"" align=""right"" nowrap>Listening</td><td align=""left""><table width=""100%"">"
	rs.open sql,db
	do until rs.eof
		lastpolled = datediff("s",rs("lastpolled"),now())
		if lastpolled < 180 then
			if lastpolled > 60 then
				msg = " Probably gone"
			elseif lastpolled > 20 then
				msg = " May have gone"
			else
				msg = ""
			end if
			if rs("name") <> "" then
				name = rs("name")
			else
				name = "Unknown" 
			end if
			if rs("hide") & "" = "" or admin <> "" then
				if rs("hide") <> "" then
					name = name & " Hidden"
				end if
				bgcolour = ""
				if admin <> "" then
					name = name & " - " & rs("uniqueid") & "<br>" & rs("ipaddress") 
					if colour = "99FFFF" then
						colour = "FFCCFF"
					else
						colour = "99FFFF"
					end if
					bgcolour = " bgcolor=""#" & colour & """"
					'" bgcolor=""#99FFFF"""
				end if
				response.write "<tr><td" & bgcolour & ">" & name & msg & "</td></tr>"
				delim = "" '"<br>"
			end if
		end if
		rs.movenext
	loop
	rs.close
	response.write "</table></td></tr>"	
	
	response.write "</table>"
	sql = "select * from poll where active = true or showresults = true order by pollid"
	rs.open sql,db
	if not rs.eof then
		response.write "<br><strong>Polls</strong><br>"
		Set rs2 = Server.CreateObject("ADODB.RecordSet")
		Set rs3 = Server.CreateObject("ADODB.RecordSet")
		do until rs.eof
			response.write "<br>" & rs("proposition")
			response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"" width=""100%""><tr>"
			sql = "SELECT PollOptions.PollOptionsID, PollOptions.Poll, PollOptions.Seq, PollOptions.Answer, Count(Votes.UniqueID) AS CountOfUniqueID " & _
				  "FROM PollOptions LEFT JOIN Votes ON PollOptions.PollOptionsID = Votes.PollOption " & _
				  "GROUP BY PollOptions.PollOptionsID, PollOptions.Poll, PollOptions.Seq, PollOptions.Answer " & _
				  "HAVING PollOptions.Poll = " & rs("pollid") & " order by seq"
'response.write sql
'response.end
			rs2.open sql,db
			do until rs2.eof
				bgcolour = ""
				sql = "SELECT PollOption FROM Votes WHERE UniqueID = '" & uniqueid & "' AND Poll = " & rs("pollid")
				rs3.open sql,db
				if not rs3.eof then
					if rs3("PollOption") = rs2("PollOptionsID") then
						bgcolour = " bgcolor=""#cc99ff"""
					end if
				end if
				rs3.close
				response.write "<td" & bgcolour & ">"
				if rs("active") and names <> "" then
					response.write "<input name=""vote" & rs("pollid") & """ type=""radio"" value=""" & rs("pollid") & "|" & rs2("polloptionsid") & """> " 
				end if
				response.write rs2("answer")
				if rs("showresults") then
					response.write "<br>" & rs2("CountOfUniqueID") & " votes"
				end if	
				if admin <> "" then
					sql = "SELECT Listening.Name, Listening.UniqueID " & _
						  "FROM (Votes INNER JOIN PollOptions ON Votes.PollOption = PollOptions.PollOptionsID) INNER JOIN Listening ON Votes.UniqueID = Listening.UniqueID " & _
						  "WHERE Votes.PollOption = " & rs2("PollOptionsID")
					rs3.open sql,db
					do until rs3.eof
						if rs3("name") & "" = "" then
							usename = rs3("UniqueID")
						else
							usename = rs3("name")
						end if
						response.write "<br>" & usename
						rs3.movenext
					loop
					rs3.close
				end if
				response.write "</td>"
				rs2.movenext
			loop
			rs2.close
			response.write "</tr></table>"
			rs.movenext
		loop
		set rs3 = nothing
		set rs2 = nothing
	else
		response.write "<br>There are no polls currently running or results to show<br>"
	end if
	rs.close
		
	'response.write "<br><strong>Discussion</strong><br>"
	
	'It would be good to have the "static input box" on default.asp at the top of this list
	'Could have two ajax calls, or return a string that can be split and posted to different innerHTMLs
	
	
	'response.write "<div class=""test"">"
	response.write "~~~"
	response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"" width=""100%"">"
	sql = "select top 50 * from discussion where archived = false order by id desc"
	rs.open sql,db
	do until rs.eof
		if colour = "FFFF99" then 
			colour = "539D9D"
		else
			colour = "FFFF99"
		end if
		usenames = rs("names")
		if usenames = "" then usenames = "Unknown"
		response.write "<tr><td align=""left"" bgcolor=""#" & colour & """><font color=""Red"">" & usenames & "</font> " & rs("comment") & "</td></tr>"
		rs.movenext
	loop
	rs.close
	response.write "</table>"	
	'response.write "</div>"

	
	comment = replace(request.querystring("comment"),"'","''")
	if comment <> "" then
		sql = "INSERT INTO Discussion ( UniqueID, [Names], Comment ) SELECT '" & uniqueid & "','" & names & "','" & comment & "'" 
		'response.write sql
		db.execute sql
	end if
	
	set rs = nothing
	db.close
	set db = nothing
%>
