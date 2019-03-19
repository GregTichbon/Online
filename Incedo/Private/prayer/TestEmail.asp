<%
	Set objMail = Server.CreateObject("CDONTS.NewMail")
	objMail.To = "gtichbon@teorahou.org.nz"
	' objMail.To = "dean@gingercat.net.nz"
	objMail.BCC = "g.tichbon@incedo.org.nz"
	objMail.From = "website@changemaker.co.nz" 
	'objMail.value("Reply-To") = request.form("email")
	objMail.Subject = "Test"
	objMail.Body = "Test"
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing
    %>



