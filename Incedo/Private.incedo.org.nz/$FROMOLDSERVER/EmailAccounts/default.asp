<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	domain = request.querystring("domain")
	email = request.querystring("email")
	secure = request.querystring("3l")
	if mid(domain,3,1) <> secure then
		'response.write "3l" &  mid(domain,3,1)
		'response.write secure
		'response.end
	end if
	unused = request.querystring("unused")
	if unused <> "" then 
		unuseddate = dateadd("m",-1,now()) 
	else
		unuseddate = dateadd("m",1,now()) 
	end if 
%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Email Accounts</title>
</head>
<body>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<%

	connection_string = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Port=3307;Database=hmailserver;User=email;Password=reports;Option=3;"
	Set db = CreateObject("ADODB.Connection")
	db.ConnectionString = connection_string
	db.Open	
	Set rsdomains = Server.CreateObject("ADODB.RecordSet")
	Set rsaccounts = Server.CreateObject("ADODB.RecordSet")
	Set rsaliases = Server.CreateObject("ADODB.RecordSet")
	set rslist = Server.CreateObject("ADODB.RecordSet")
	'set rsmessages = Server.CreateObject("ADODB.RecordSet")
	
	
	sql = "SELECT * from hm_domains "
	if domain <> "" and domain <> "all" then
		sql = sql & " where domainname = '" & domain & "'"
	end if
	sql = sql & " order by domainname"
	
	rsdomains.Open sql, db
	do until rsdomains.EOF
		headingsdone = ""
		response.write "<tr><td colspan=""9"" bgcolor=""yellow""><a href=""?domain=" & rsdomains("domainname") & """>" & rsdomains("domainname") & "</a></td></tr>"
		'sql = "SELECT accountid, accountadminlevel, accountaddress, accountactive, accountmaxsize, accountforwardenabled, accountforwardaddress, accountforwardkeeporiginal, accountenablesignature, accountsignatureplaintext, accountsignaturehtml, accountlastlogontime, accountpersonfirstname, accountpersonlastname from hm_accounts where accountdomainid = " & rsdomains("domainid") & " order by accountaddress"
		'sql = "SELECT accountaddress as 'Address', accountactive as 'Active', accountmaxsize as 'Max Size', accountforwardenabled as 'Forwarding Enabled', accountforwardaddress as 'Forward To', accountforwardkeeporiginal as 'Forward & Keep', accountlastlogontime as 'Last Logged On' from hm_accounts where accountdomainid = " & rsdomains("domainid") 
		
	  if domain <> "" then
		sql = "SELECT A.accountaddress as 'Address', A.accountactive as 'Active', A.accountmaxsize as 'Max Size', A.accountforwardenabled as 'Forwarding Enabled', A.accountforwardaddress as 'Forward To', A.accountforwardkeeporiginal as 'Forward & Keep', A.accountlastlogontime as 'Last Logged On' " & _
					  ", (sum(M.messagesize) / 1048576) as 'Size', Count(*) as 'Email' " & _
			  "from hm_accounts A " & _
			  "left outer join hm_messages M on A.accountid = M.messageaccountid " & _
			  "where A.accountdomainid = " & rsdomains("domainid")
		
		if email <> "" then
			sql = sql & " and A.accountaddress = '" & email & "'"
		end if
		sql = sql & " group by A.accountaddress, A.accountactive, A.accountmaxsize, A.accountforwardenabled, A.accountforwardaddress, A.accountforwardkeeporiginal, A.accountlastlogontime"
		sql = sql & " order by A.accountactive desc, A.accountaddress"

if 1=2 then
	'FlagSeen = 1,
	'FlagDeleted = 2,
	'FlagFlagged = 4,
	'FlagAnswered = 8,
	'FlagDraft = 16,
	'FlagRecent = 32,
	'FlagVirusScan = 64
	
	
	sql = "SELECT A.accountaddress as 'Address', A.accountlastlogontime as 'Last Logged On' " & _
				  ", M.* " & _
		  "from hm_accounts A " & _
		  "left outer join hm_messages M on A.accountid = M.messageaccountid " & _
		  "where A.accountdomainid = " & rsdomains("domainid") '& " and A.accountaddress = 'g.tichbon@incedo.org.nz'"
	end if
if 1=2 then
	sql = "select * from hm_folders"			
end if  
			  
'response.write sql
'response.end	

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
			if cdate(rsaccounts("Last Logged On")) < unuseddate or 1=1 then
				if bgcolour = "#FFCCFF" then bgcolour = "#CCFFFF" else bgcolour = "#FFCCFF"
				response.write "<tr bgcolor=""" & bgcolour & """>"
				for each fld in rsaccounts.fields
					fldval = fld
					'response.write fld
					if fld.name = "Address" then
						response.write "<td><a href=""folders.asp?email=" & fldval & """>" & fldval & "</a></td>"
					elseif fld.name = "Forward To" then
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
						response.write "<td>" & fldval & "&nbsp;</td>"
					else
						if fldval = "0" then fldval = ""
						response.write "<td>" & fldval & "&nbsp;</td>"
					end if
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
					response.write "<tr bgcolor=""" & bgcolour & """><td colspan=""9"">Aliases: " & aliases & "</td></tr>"
				end if
				rsaliases.close
			end if
			rsaccounts.movenext
		loop
		if unused = "" and email = "" then
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
				response.write "<tr bgcolor=""#00FF00""><td colspan=""9"">Distribution Lists" & dl & "</td></tr>"
			end if
			rslist.close
		end if
		if email = "" then
			sql = "select aliasname, aliasvalue from hm_aliases where aliasactive = 1 and aliasdomainid = " & rsdomains("domainid") & " "  & _
			"order by aliasname, aliasvalue"
			rslist.open sql,db
			if not rslist.eof then
				an = ""
				lastan = ""
				do until rslist.eof
					if rslist("aliasname") <> lastan then
						an = an & "<br><b>" & rslist("aliasname") & "</b>: "
						delim = ""
						lastan = rslist("aliasname")
					end if
					an = an & delim & rslist("aliasvalue")
					delim = "; "
					rslist.movenext
				loop
				response.write "<tr bgcolor=""#00FFFF""><td colspan=""9"">Aliases" & an & "</td></tr>"
			end if
			rslist.close
		end if
			rsaccounts.close
		end if
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



