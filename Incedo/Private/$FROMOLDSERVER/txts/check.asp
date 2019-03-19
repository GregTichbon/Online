<html>
<title>Check txt</title>
<body>
<%
'Option Explicit

connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\incedo\txtmessages.mdb"
	
Set db = Server.CreateObject("ADODB.Connection")
db.Open connection_string
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "replies", db, 1, 2


Dim iClick
Dim res
Dim reply
dim status(4)
status(0) = "Reply"
status(1) = "Received by Server"
status(2) = "Received by Mobile"
status(3) = "Failed"

Set iClick = Server.Createobject("M4USMS.SMS2")

iclick.ServerMode = false
res = iClick.SMSConnect("YouthForChris001","0244981")
'res = iClick.SMSConnect("loadtest03","katherine")
If res <> 0 Then
   Response.Write("Error no. " & res & " while trying to connect.")
End If

res = iClick.CheckReply()
If res <> 0 Then
   Response.Write("Error no. " & res & " while trying to check for reply.")
End If

'reportstatus: 0 = actual reply, 1 - received by server, 2 - received by phone, 3 - failed
If iClick.ReplyFound Then
   Response.Write("Reply(s) found when checking for reply.<p>")
   response.write "<table border=""1"">"
   For Each reply in iClick.Replies
      Response.Write  "<tr><td>" & Reply.MessageId & "</td><td>" & now() & "</td><td>" & reply.reportstatus & "</td><td>" & status(reply.reportstatus) & "</td><td>" & Reply.PhoneNumber & "</td><td>" & Reply.MessageText & "</td></tr>"
	  rs.addnew
	  rs.fields("MessageID") = Reply.MessageId
	  rs.fields("DateTime") = now()
	  rs.fields("reportstatus") = reply.reportstatus
	  rs.fields("reportstatusdescription") = status(reply.reportstatus)
	  rs.fields("mobilenumber") = Reply.PhoneNumber
	  rs.fields("message") = Reply.MessageText
	  rs.update
   Next
   response.write "</table>"
End If
rs.close
set rs = nothing
db.close
set db = nothing
	

response.write "<br>Done"
%>
</body>
</html>


