<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "private/emailaccounts"
		response.redirect "../signon"
	end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Email Accounts</title>
</head>
<body>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<%
	domain = request.querystring("domain")
	connection_string = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Port=3307;Database=hmailserver;User=email;Password=reports;Option=3;"
	Set db = CreateObject("ADODB.Connection")
	db.ConnectionString = connection_string
	db.Open	
	Set rsdomains = Server.CreateObject("ADODB.RecordSet")
	Set rsaccounts = Server.CreateObject("ADODB.RecordSet")
	Set rsaliases = Server.CreateObject("ADODB.RecordSet")
	set rslist = Server.CreateObject("ADODB.RecordSet")
	
	
	sql = "SELECT * from hm_domains where domainname = 'incedo.org.nz'"
	
	rsdomains.Open sql, db
	do until rsdomains.EOF
		headingsdone = ""
		'sql = "SELECT accountid, accountadminlevel, accountaddress, accountactive, accountmaxsize, accountforwardenabled, accountforwardaddress, accountforwardkeeporiginal, accountenablesignature, accountsignatureplaintext, accountsignaturehtml, accountlastlogontime, accountpersonfirstname, accountpersonlastname from hm_accounts where accountdomainid = " & rsdomains("domainid") & " order by accountaddress"
		sql = "SELECT accountaddress as 'Address', accountactive as 'Active', accountforwardenabled as 'Forwarding Enabled', accountforwardaddress as 'Forward To', accountforwardkeeporiginal as 'Forward & Keep', accountlastlogontime as 'Last Logged On' from hm_accounts where accountdomainid = " & rsdomains("domainid") & " order by accountaddress"
		rsaccounts.Open sql, db
		do until rsaccounts.EOF
			if headingsdone = "" then
				response.write "<tr>"
				for each fld in rsaccounts.fields
					response.write "<td>" & fld.name & "</td>"
				next
				response.write "</tr>"
				headingsdone = "Yes"
			end if
			if bgcolour = "#FFCCFF" then bgcolour = "#CCFFFF" else bgcolour = "#FFCCFF"
			response.write "<tr bgcolor=""" & bgcolour & """>"
			for each fld in rsaccounts.fields
				fldval = fld
				'response.write fld
				if fld.name = "Forward To" then
					sql = "select R.distributionlistrecipientaddress from hm_distributionlists L " & _
						  "inner join hm_distributionlistsrecipients R on R.distributionlistrecipientlistid = L.distributionlistid " & _
						  "where distributionlistaddress = '" & fld & "'"
'response.write sql				
					rslist.open sql,db
					if not rslist.eof then
						fwd = ""
						delim = ""
						do until rslist.eof
							fwd = fwd & delim & rslist("distributionlistrecipientaddress")
							delim = ";"
							rslist.movenext
						loop
						fldval = fld & "<br>(" & fwd & ")"
					end if
					rslist.close
				end if
				if fldval = "0" then fldval = ""
				response.write "<td>" & fldval & "&nbsp;</td>"
			next
			response.write "</tr>"
			sql = "SELECT * from hm_aliases where aliasvalue = '" & replace(rsaccounts("address"),"'","''") & "'"
			rsaliases.Open sql, db
			aliases = ""
			delim = ""
			do until rsaliases.EOF
				aliases = aliases & delim & rsaliases("aliasname")
				delim = "; "
				rsaliases.movenext
			loop
			if aliases <> "" then
				response.write "<tr bgcolor=""" & bgcolour & """><td colspan=""6"">Aliases: " & aliases & "</td></tr>"
			end if
			rsaliases.close
			rsaccounts.movenext
		loop

'distribution lists
		sql = "select dl.distributionlistaddress, dlr.distributionlistrecipientaddress from hm_distributionlists dl " & _
			  "inner join hm_distributionlistsrecipients dlr on dlr.distributionlistrecipientlistid = dl.distributionlistid " & _
			  "where dl.distributionlistenabled = 1 and dl.distributionlistdomainid = " & rsdomains("domainid") & " "  & _
			  "order by dl.distributionlistaddress, dlr.distributionlistrecipientaddress"
		rslist.open sql,db
		if not rslist.eof then
			dl = ""
			lastdl = ""
			do until rslist.eof
				if rslist("distributionlistaddress") <> lastdl then
					dl = dl & "<br><b>" & rslist("distributionlistaddress") & "</b>: "
					delim = ""
					lastdl = rslist("distributionlistaddress")
				end if
				dl = dl & delim & rslist("distributionlistrecipientaddress")
				delim = "; "
				rslist.movenext
			loop
			response.write "<tr bgcolor=""#00FF00""><td colspan=""7"">Distribution Lists" & dl & "</td></tr>"
		end if
		rslist.close


		rsaccounts.close
		rsdomains.movenext
	loop
	rsdomains.close
	set rslist = nothing
	set rsaliases = nothing
	set rsaccounts = nothing
	set rsdomains = nothing
	db.close
	set db = nothing
	
%>
</table>
</body>
</html>



