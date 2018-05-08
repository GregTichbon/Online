<%
mode = request.querystring("mode")
if mode = "f" then
	email = request.form("email")
	message = request.form("message")
else
	email = request.querystring("email")
	message = request.querystring("message")
end if
Set objMail = Server.CreateObject("CDONTS.NewMail")
objMail.To = email
objMail.From = "greg@datainn.co.nz"
objMail.Subject = message
objMail.Body = now() & "<br>" & request.querystring
objMail.MailFormat = 0
objMail.BodyFormat = 0
objMail.Send
Set objMail = Nothing
%>