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
	userid = request.querystring("userid")
	uniqueid = request.querystring("uniqueid")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	
	Set rs2 = Server.CreateObject("ADODB.RecordSet")
	with rs2
		.Open "onlinechatonline", db, 1, 2
		.filter = "uniqueid = '" & uniqueid & "'"
		if .eof then 
			.AddNew
			.fields("uniqueid") = uniqueid
			.fields("hide") = hide
			.fields("joined") = now()
		end if
		.fields("userid") = userid
		.fields("lastpolled") = now()
		if request.ServerVariables("Remote_Host") <> request.ServerVariables("Remote_addr") then
			.fields("ipaddress") = request.ServerVariables("Remote_Host") & " | " & request.ServerVariables("Remote_addr")
		else
			.fields("ipaddress") = request.ServerVariables("Remote_Host")
'response.write .fields("ipaddress")
'response.end
		end if
		.update
		.close
	end with
		
	set rs2 = nothing
	
	response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"" width=""100%"">"
	sql = "select * from OnlineChatParams where seq <> 0 order by seq"
	rs.open sql,db
	do until rs.eof
		response.write "<tr><td width=""160"" align=""right"" nowrap>" & rs("key") & "</td><td align=""left"">" & rs("data") & "</td></tr>"
		rs.movenext
	loop
	rs.close

	sql = "select * from onlineChatPeople order by name"
	response.write "<tr><td width=""160"" align=""right"" nowrap>Online</td><td align=""left""><table width=""100%"">"
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
		
	
	
	'response.write "<div class=""test"">"
	response.write "~~~"
	response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"" width=""100%"">"
	sql = "select top 50 * from onlinechat order by id desc"
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
		sql = "INSERT INTO onlinechat ( UniqueID, [Names], Comment ) SELECT '" & uniqueid & "','" & names & "','" & comment & "'" 
		'response.write sql
		db.execute sql
	end if
	
	set rs = nothing
	db.close
	set db = nothing
%>
