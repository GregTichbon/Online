<%
	'for each frm in request.form
	'	response.write frm & "=" & request.form(frm)
	'next
	'response.end

	if request.form("$securitycode") <> request.form("$actualsecuritycode") then
		response.redirect "default.asp"
	end if

	set fs = server.CreateObject("Scripting.FileSystemObject")
	set ts = fs.OpenTextFile(Server.MapPath("contact_acknowledgment.htm"),1)

	content = convert(ts.readall)
	ts.Close
	set ts = nothing
	set fs = nothing
	
	response.write content

if 1=1 then	
	Set objMail = Server.CreateObject ("CDONTS.NewMail")
	objMail.To = "comsports@xtra.co.nz"
	objMail.Bcc = "greg@datainn.co.nz"
	objMail.From = "mail@wanganuisportscentre.org.nz"
	objMail.Value("Reply-To") = request.form("email")
	objMail.Subject = "Wanganui Community Sports Centre Contact Request"
	objMail.Body = content
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing
	
	Set objMail = Server.CreateObject ("CDONTS.NewMail")
	objMail.To = request.form("email")
	objMail.From = "mail@wanganuisportscentre.org.nz"
	objMail.Value("Reply-To") = "comsports@xtra.co.nz"
	objMail.Subject = "Wanganui Community Sports Centre Contact Request"
	objMail.Body = content
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing
	
end if
			
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
			parms = split(fieldname,"|")
			select case lcase(parms(0))
				case "sc" 'request.form
					new_message = new_message & sc.form(parms(1)) 'replace(sc.form(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
				case "rf" 'request.form
					new_message = new_message & replace(request.form(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
				case "sd" 'scripting dictionary
					new_message = new_message & replace(fp.Item(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
				case "rq" 'request.query
					new_message = new_message & replace(request.querystring(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
				case else
					new_message = new_message & "Unknown Paramater 1 - " & lcase(parms(0))
			end select
			c1 = c1 + c2 + 1
		Else
			new_message = new_message & Mid(pass_text, c1, 1)
		End If
	Loop
	convert = new_message

End Function			
%>

