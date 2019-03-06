<html>
<head>
<title>Send Email</title>
</head>
<body>
<%
	Set db = Server.CreateObject("ADODB.Connection")
	'connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$generic\incedo\connectme.mdb;"
	connection_string = "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=e:\$generic\incedo\connectme.mdb"
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	pagepos = session("incedoconnectme_email_page")

	If pagepos = "" Then
		intPage = 1
		sql = request.form("sql")
		session("incedoconnectme_email_sql") = sql
		message = "<html><head><meta http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1""></head><body bgcolor=""#CCCCCC"">" & request.form("message") & "</body></html>"
		session("incedoconnectme_email_message") = message
		live = request.form("live")
		session("incedoconnectme_email_live") = live
		if live = "yes" then
			set di = server.createobject("DI.IIS")
			set oFs = server.createobject("Scripting.FileSystemObject")
			Fname = server.mappath("Email\Email" & di.di_format(now(),"yyyymmdd") & ".htm")
			set oTextFile = oFs.OpenTextFile(fname, 2, True)
			oTextFile.Write message
			oTextFile.Close
			set oTextFile = nothing
			set oFS = nothing
			set di = nothing
		end if

	else
		intPage = pagepos
		sql = session("incedoconnectme_email_sql")
		message = session("incedoconnectme_email_message")
		live = session("incedoconnectme_email_live")
	end if
	
response.write session("incedoconnectme_email_page") & "<br>"
			
	rs.CursorLocation = 3	'adUseClient
	rs.CursorType = 3		'adOpenStatic
	rs.ActiveConnection = db

response.write sql & "<br>"
'response.end			
	rs.Open sql, db

	rs.PageSize = 10		
	rs.CacheSize = rs.PageSize
	intPageCount = rs.PageCount 
	intRecordCount = rs.RecordCount 
	If CInt(intPage) > CInt(intPageCount) Then intPage = intPageCount
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
			validemail = check_email(rs("email"))
			if session("incedoconnectme_email_live") = "yes" then
				if validemail = " OK." then
if 1=1 then
					Set objMail = Server.CreateObject("CDONTS.NewMail")
					objMail.To = rs("email")
					objMail.From = "northland@incedo.org.nz" '"ConnectMe@incedo.org.nz"
					objMail.Subject = "Incedo ConnectMe Email for " & trim(rs("organisation") & rs("firstname") & " " & rs("surname"))
					objMail.Body = session("incedoconnectme_email_message")
					objMail.MailFormat = 0
					objMail.BodyFormat = 0
					objMail.Send
					Set objMail = Nothing
else
response.write "<br>To: " & rs("email")
response.write "<br>From: " & "ConnectMe@incedo.org.nz"
response.write "<br>Subject: " & "ConnectMe email " & trim(rs("organisationname") & rs("firstname") & " " & rs("surname"))
response.write "<br>Body: " & session("incedoconnectme_email_message") & "<br>"
end if

					sent = " sent"
				end if
			end if
			response.write rs.AbsolutePosition & " " & trim(rs("organisation") & rs("firstname") & " " & rs("surname")) & " " & rs("email") & " " & validemail & sent & "<br>"
			rs.MoveNext
			If rs.EOF Then Exit for
		next
response.write "<br>close<br>"
		rs.close
		set rs = nothing
		db.Close
		set db = nothing
		If cInt(intPage) < cInt(intPageCount) Then
			session("incedoconnectme_email_page") = intpage + 1
%>
			<SCRIPT LANGUAGE="JavaScript">
			//setTimeout("window.location='sendemail_process.asp'",10000)
			window.location="sendemail_process.asp";
			</script>	
<%
			'server.transfer "sendemail_process.asp"
		else 
			Response.Write intRecordCount & " records<br>"
			response.write "<a href=""menu.asp"">Return to Menu</a>"
			session("incedoconnectme_email_page") = ""
			session("incedoconnectme_email_sql") = ""
			session("incedoconnectme_email_message") = ""
			session("incedoconnectme_email_live") = ""
		end if
	end if
	
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
%>
</body>
</html>
