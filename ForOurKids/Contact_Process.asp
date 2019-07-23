<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FOR OUR KIDS</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#000000">
<div align="center">
<img src="images/FOK%20header.jpg" width="780" height="239" /><br />
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
	if request.form("$captcha") <> request.form("$captchaverify") then
		response.write "Invalid submission"
	else
		set fp = CreateObject("Scripting.Dictionary") 
		fp.Add "id", 123 'id
				
		set fs = server.CreateObject("Scripting.FileSystemObject")
		set ts = fs.OpenTextFile(Server.MapPath("EmailFormat.htm"),1)
		emailformat = convert(ts.readall)
		ts.Close
		set ts = nothing
		set ts = fs.OpenTextFile(Server.MapPath("ContactAcknowledgment.htm"),1)
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
		objMail.Value("Reply-To") = request.form("emailaddress")
		objMail.Subject = "For Our Kids Registration"
		objMail.Body = acknowledgmentbody
		objMail.MailFormat = 0
		objMail.BodyFormat = 0
		objMail.Send
		Set objMail = Nothing

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
		set fp = nothing
	end if
%>
</td>
    </tr>
</table>
<p><img src="images/FOK%20footer.jpg" width="780" height="36" /></p>
</div>
</body>
</html><%

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
