<%
myto = request.form("to")
myfrom = request.form("from")
%>
<form name="form1" method="post" action="">
  <p>From 
    <input name="from" type="text" id="from" value="<%=myfrom%>" size="100">
</p>
  <p>To 
    <input name="to" type="text" id="to"  value="<%=myto%>" size="100">
</p>
  <p>Include Image 
    <input name="image" type="checkbox" id="image" value="1">
</p>
  <p>Use 
    <input name="system" type="radio" value="cdosys" checked>
CDOSYS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="system" type="radio" value="cdonts">
CDONTS</p>
  <p><img src="http://www.incedo.org.nz/private/Email/Updates/20090501/IncedoHeader.gif" width="584" height="220"></p>
  <p>
    <input type="submit" name="Submit" value="Submit">
  </p>
</form>
<%
	if request.form("Submit") <> "" then
		id = now()
		response.write id
		if request.form("image") = 1 then
			image = "<img src=""http://www.incedo.org.nz/private/Email/Updates/20090501/IncedoHeader.gif"">"
		end if
		subject = id & " from: " & request.form("from") & " to: " & request.form("to")
		body = "<html><body>" & id & " from: " & request.form("from") & " to: " & request.form("to") & image & "</body></html>"
		if request.form("system") = "cdonts" then
			Set objMail = Server.CreateObject("CDONTS.NewMail")
			objMail.To = myto
			objMail.From = myfrom
			objMail.Subject = subject
			objMail.body = body
			objMail.MailFormat = 0
			objMail.BodyFormat = 0
			objMail.Send
			Set objMail = Nothing
		else
			Set myMail=CreateObject("CDO.Message")
			myMail.Subject = subject
			myMail.From = myfrom
			myMail.To = myto
			myMail.HTMLBody = body
			myMail.Send
			set myMail=nothing		
		end if
	end if
%>
