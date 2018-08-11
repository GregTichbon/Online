<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
    <%
    Set objMail = Server.CreateObject("CDONTS.NewMail")
    objMail.To = "greg@datainn.co.nz; gtichbon@teorahou.org.nz; dean@gingercat.net.nz"
    objMail.From = "greg@datainn.co.nz" '"gtichbon@teorahou.org.nz"
    objMail.Subject = "Test of SMTP Service"
    objMail.Body = "An email (via Microsoft SMTP) and a text message are sent every day at 8:30am.  If they don't arrive there may be an issue."
    objMail.MailFormat = 0
    objMail.BodyFormat = 0
    objMail.Send
    Set objMail = Nothing

	Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    URL = "http://office.datainn.co.nz/?P=0272495088&M=An email (via Microsoft SMTP) and a text message are sent every day at 8:30am.  If they don't arrive there may be an issue."
    objXMLHTTP.Open "GET", replace(URL," ","%20"), False
    objXMLHTTP.Send




    %>
</body>
</html>