<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FOR OUR KIDS</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#000000">
<div align="center">
<img src="Images/FOK%20header.jpg" width="780" height="239" /><br />
<table width="780" border="0" cellpadding="10" cellspacing="0" class="table">
  <tr>
    <td><!--#include file="inc_menu.html"--></td>
  </tr>
  <tr>
    <td>
	
<%
'for each frm in request.form
'	response.write frm & "=" & request.form(frm) & "<br>"
'next
'response.end
		rtype = request.form("$rtype")
		if lcase(request.servervariables("SERVER_NAME")) = "localhost" then
			local = true
		else
			local = false
		end if
		
		if request.querystring("mode") = "test" then
			test = "&mode=test"
		else
			test = ""
		end if

		if request.form("$submit") = "Submit" or request.form("$submit") = "Add" then
			mode = "create"
		elseif Request.Form("$submit") = "Submit Changes" then
			mode = "modify"
		elseif Request.Form("$submit") = "Delete" then
			mode = "delete"
		else
			Response.write Request.Form("$submit") & "Unknown Action"
			Response.End
		end if
		
		if mode = "create" and request.form("$captcha") <> request.form("$captchaverify") then
			response.write "Invalid submission"
			'response.write "<br>" & request.form("$captcha") & "," & request.form("$captchaverify") 
		else 

			id = request.form("id")
			connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\ForOurKids\ForOurKids.mdb"
			
			Set db = Server.CreateObject("ADODB.Connection")
			db.Open connection_string
			Set rs = Server.CreateObject("ADODB.Recordset")
			with rs
				.Open rtype, db, 1, 2
				if mode = "modify" or mode = "delete" then
					.filter = "id = " & id
				end if
				if mode = "delete" then
					.delete
				elseif mode = "modify" or mode = "create" then
					if mode = "create" then
						.AddNew
					end if
on error resume next
					For Each key in Request.Form
						if left(key,1) <> "$" and request.form(key) <> "" and key <> "id" and key <> "mode" then
							.fields(key) = request.form(key)
if err.number <> 0 then
	Response.Write key & "=" & request.form(key) & "<br>"
	errflag = 1
	err.clear
end if
						end if
					next
if errflag = 1 then
	response.end
end if
on error goto 0
					.Update
					Id = .Fields("ID")
				end if
				.close
			end with
			
		
			set rs = nothing
			db.Close
			set db = nothing
	
			set fp = CreateObject("Scripting.Dictionary") 
			fp.Add "id", 123 'id
			if request.form("mode") = "admin" and rtype = "volunteer" then
				fp.add "notes", "<tr><td><div align=""right""><strong>Notes</strong></div></td><td><div align=""left"">" & request.form("notes") & "&nbsp;</div></td></tr>"
			end if
			set fs = server.CreateObject("Scripting.FileSystemObject")
			set ts = fs.OpenTextFile(Server.MapPath("EmailFormat.htm"),1)
			emailformat = convert(ts.readall)
			ts.Close
			set ts = nothing
			set ts = fs.OpenTextFile(Server.MapPath("RegistrationAcknowledgment" & rtype & ".htm"),1)
			acknowledgment = convert(ts.readall)
			ts.Close
			set ts = nothing
			set fs = nothing
			
			response.write acknowledgment
	
if 1=1 and not local then	
	
			acknowledgmentbody = replace(emailformat,"CONTENT",acknowledgment)
	
			Set objMail = Server.CreateObject ("CDONTS.NewMail")
			objMail.To = "mail@forourkids.org.nz"
			objMail.BCC = "greg@datainn.co.nz"
			objMail.From = "mail@forourkids.org.nz"
			if request.form("emailaddress") <> "" then
				objMail.Value("Reply-To") = request.form("emailaddress")
			end if
			objMail.Subject = "For Our Kids Registration"
			objMail.Body = acknowledgmentbody
			objMail.MailFormat = 0
			objMail.BodyFormat = 0
			objMail.Send
			Set objMail = Nothing
			
			if request.form("mode") = "" then
				Set objMail = Server.CreateObject ("CDONTS.NewMail")
				objMail.To = request.form("emailaddress")
				objMail.From = "mail@forourkids.org.nz"
				objMail.Subject = "For Our Kids Registration"
				objMail.Body = acknowledgmentbody
				objMail.MailFormat = 0
				objMail.BodyFormat = 0
				objMail.Send
				Set objMail = Nothing
			end if
end if
			set fp = nothing
	end if
%>
	
	</td>
    </tr>
</table>
<p><img src="Images/FOK%20footer.jpg" width="780" height="36" /></p>
</div>
</body>
</html>
<%

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
