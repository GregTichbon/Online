<html>
<head>
<title>Send Email</title>
</head>
<body>
<%
	prefix = session("email_prefix")
	pagepos = session(prefix & "_email_page")

	if pagepos = "Complete" then
		response.write session(prefix & "_email_result")
		'Response.Write intRecordCount & " records<br>"
		'response.write "<a href=""menu.asp"">Return to Menu</a>"
		session("email_prefix") = ""
		session(prefix & "_email_page") = ""
		session(prefix & "_email_sql") = ""
		session(prefix & "_email_message") = ""
		session(prefix & "_email_live") = ""
		session(prefix & "_email_field") = ""
		session(prefix & "_email_sender") = ""
		session(prefix & "_email_subject") = ""
		session(prefix & "_email_result") = ""
		session(prefix & "_email_identifier") = ""
	else
	
		Server.ScriptTimeout = 120
	
		Set db = Server.CreateObject("ADODB.Connection")
		Set rs = Server.CreateObject("ADODB.Recordset")
		
		Set tablers = Server.CreateObject("ADODB.Recordset")
	
		
	
		If pagepos = "" Then
			intPage = 1
			prefix = request.form("prefix")
			session("email_prefix") = prefix
			database = request.form("database")
			session(prefix & "_email_database") = database
			sql = request.form("sql")
			session(prefix & "_email_sql") = sql
			message = request.form("message")
			session(prefix & "_email_message") = message
			live = request.form("live")
			session(prefix & "_email_live") = live
			emailfield = request.form("emailfield")
			session(prefix & "_email_field") = emailfield
			sender = request.form("sender")
			session(prefix & "_email_sender") = sender
			subject = request.form("subject")
			session(prefix & "_email_subject") = subject
			bcc = request.form("bcc")
			session(prefix & "_email_bcc") = bcc
			identifier = request.form("identifier")
			session(prefix & "_email_identifier") = identifier
			'open a file and write the database, sql, message, emailfield, sender, subject into it
			'close the file but keep the filename as a session variable
		else
			intPage = pagepos
			database = session(prefix & "_email_database")
			sql = session(prefix & "_email_sql")
			message = session(prefix & "_email_message")
			live = session(prefix & "_email_live")
			emailfield = session(prefix & "_email_field")
			sender = session(prefix & "_email_sender")
			subject = session(prefix & "_email_subject")
			bcc = session(prefix & "_email_bcc")
			identifier = session(prefix & "_email_identifier")
		end if
		
		'connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & database
		connectionstring = "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & database
	
'response.write connectionstring & "<br>"
'response.end
		db.Open connectionstring
		
'response.write session(prefix & "_email_page") & "<br>"
				
		rs.CursorLocation = 3	'adUseClient
		rs.CursorType = 3		'adOpenStatic
		rs.ActiveConnection = db
	
'response.write sql & "<hr>"
'response.end			
		rs.Open sql, db
	
		rs.PageSize = 10		
		rs.CacheSize = rs.PageSize
		intPageCount = rs.PageCount 
		intRecordCount = rs.RecordCount 
		If CInt(intPage) > CInt(intPageCount) Then intPage = intPageCount
		response.write "Total Records: " & intRecordCount & "<br>"
		If intRecordCount > 0 Then
			rs.AbsolutePage = intPage
			intStart = rs.AbsolutePosition
			If CInt(intPage) = CInt(intPageCount) Then
				intFinish = intRecordCount
			Else
				intFinish = intStart + (rs.PageSize - 1)
			End if
			For intRecord = 1 to rs.PageSize
				sent = ""
				validemail = check_email(rs(emailfield))
				if live = "yes" then
					if validemail = " OK." then
if 1=1 then
						Set objMail = Server.CreateObject("CDONTS.NewMail")
						objMail.To = rs(emailfield)
						'objMail.To = "m.campbell@incedo.org.nz"
						if bcc <> "" then
							objMail.BCC = bcc
						end if
						objMail.From = sender
						objMail.Subject = convert(subject)
						objMail.Body = convert(message)
						objMail.MailFormat = 0
						objMail.BodyFormat = 0
						objMail.Send
						Set objMail = Nothing
else
	response.write "<br>To: " & rs(emailfield)
	response.write "<br>From: " & sender
	'response.write "<br>Subject: " & convert(subject)
	response.write "<br>Body: " & convert(message) & "<br>"
	response.write "<hr>"
	response.end
end if
						sent = " sent"
					end if
				end if
				response.write rs.AbsolutePosition & " " & rs(identifier) & " - " & rs(emailfield) & " " & validemail & sent & "<br>"
				session(prefix & "_email_result") = session(prefix & "_email_result") & rs(identifier) & " - " & rs(emailfield) & " " & validemail & sent & "<br>"
				rs.MoveNext
				If rs.EOF Then Exit for
			next
	'response.write "<br>close<br>"
			rs.close
			
			set tablers = nothing
			set rs = nothing
			
			db.Close
			set db = nothing
			If cInt(intPage) < cInt(intPageCount) Then
				session(prefix & "_email_page") = intpage + 1
			else
				session(prefix & "_email_page") = "Complete"
			end if
%>
			<SCRIPT LANGUAGE="JavaScript">
			//setTimeout("window.location='sendemail_process.asp'",10000)
			window.location="sendemail_process.asp";
			</script>	
<%
			'server.transfer "sendemail_process.asp"
		end if
	end if
%>
</body>
</html>
<%
function check_email(str)
	if isnull(str) then
		check_email = " No Address."
		exit function
	end if

	len_str = len(str)
	at_pos = instr(str,"@")
	dot_pos = instr(str,".")
	check_email =  ""

	if len_str < 5 then
		check_email =  " Too short."
		exit function
	end if
			
	if at_pos = 0 then
		check_email =  " No @ symbol."
		exit function
	end if
						
	if instr(at_pos+1,str,"@") then
		check_email =  " More than 1 @ symbol."
		exit function
	end if
			
	if dot_pos = 0 then			
		check_email =  " No Dot."
		exit function
	end if
						
	if dot_pos = 1  then			
		check_email =  " Dot is first character."
		exit function
	end if

	if dot_pos = len_str then			
		check_email =  " Dot is last charater."
		exit function
	end if

	if mid(str,at_pos-1,1) = "."  then
		check_email =  " Dot is first character before @ symbol."
		exit function
	end if
				
	if mid(str,at_pos+1,1) = "." then
		check_email =  " Dot is first character after @ symbol."
		exit function
	end if

	if instr(str," ") then
		check_email =  " There is a space."
		exit function
	end if
	
	check_email =  " OK."
end function

Function convert(pass_text)

	new_message = ""
	c1 = 0
	Do Until c1 >= Len(pass_text)
		c1 = c1 + 1
		If Mid(pass_text, c1, 2) = "||" Then
			c2 = 2
			Do Until Mid(pass_text, c1 + c2, 2) = "||"
				c2 = c2 + 1
			Loop
			fieldname = Mid(pass_text, c1 + 2, c2 - 2)
			on error resume next
			if tablemode then
				if tablerecord then
					new_message = new_message & tablers(fieldname)
				end if
			else
				new_message = new_message & rs(fieldname)
			end if
			if err.number <> 0 then
				response.write "Error: Field name: " & fieldname
				response.end
			end if
			on error goto 0
			'write rs(fieldname) into the text file
			c1 = c1 + c2 + 1
		ElseIf Mid(pass_text, c1, 2) = "@@" Then
			if tablemode then
				c2 = 2
				Do Until Mid(pass_text, c1 + c2, 2) = "@@"
					c2 = c2 + 1
				Loop
				tableend = Mid(pass_text, c1 + 2, c2 - 2)
				if lcase(tableend) = "end" then
					if tablerecord then
						tablers.movenext
					end if
					if tablers.eof then
						tablemode = false
						tablerecord = false
						tablers.close
						c1 = c1 + c2 + 1
					else
						c1 = tabledatastart
					end if
				else
					response.write "Error is table format"
					response.end
				end if
			else
				c2 = 2
				Do Until Mid(pass_text, c1 + c2, 2) = "@@"
					c2 = c2 + 1
				Loop
				tablesql = convert(Mid(pass_text, c1 + 2, c2 - 2))
				tablers.Open tablesql, db
				tablemode = true
				if tablers.eof then
					tablerecord = false
				else
					tablerecord = true
				end if
				c1 = c1 + c2 + 1
				tabledatastart = c1
			end if
		ElseIf Mid(pass_text, c1, 2) = "~~" Then
			if logicmode then
				c3 = 2
				Do Until Mid(pass_text, c1 + c3, 2) = "~~"
					c3 = c3 + 1
				Loop
				if lcase(Mid(pass_text, c1 + 2, c3 - 2)) = "end" then
					c1 = c1 + c3 + 1
					logicmode = false
				else
					response.write "Error is logic format"
					response.end
				end if
			else
				c3 = 2
				Do Until Mid(pass_text, c1 + c3, 2) = "~~"
					c3 = c3 + 1
				Loop
				logicfld = convert(Mid(pass_text, c1 + 2, c3 - 2))
				if left(logicfld,1) = "!" then
					logicfld = mid(logicfld,2,999)
					logicfld = not rs(logicfld)
				else
					logicfld = rs(logicfld)
				end if
				if logicfld then
					c1 = c1 + c3 + 1
					logicmode = true
				else
					c1 = c1 + c3 + 2
					do until lcase(mid(pass_text, c1, 7)) = "~~end~~"
						c1 = c1 + 1
					loop
					c1 = c1 + 6
'response.write c1
'response.end
					logicmode = false
				end if
			end if
		else
			new_message = new_message & Mid(pass_text, c1, 1)
		End If
	Loop
	convert = new_message

End Function
%>