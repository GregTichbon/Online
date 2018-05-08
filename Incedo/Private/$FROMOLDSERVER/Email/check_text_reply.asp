<html>
<title>Check txt</title>
<body>
<%
'Option Explicit

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
      Response.Write("<tr><td>" & now() & "</td><td>" & reply.reportstatus & "</td><td>" & status(reply.reportstatus) & "</td><td>" & Reply.MessageId & "</td><td>" & Reply.PhoneNumber & "</td><td>" & Reply.MessageText & "</td></tr>")
   Next
   response.write "</table>"
End If

response.write "<br>Done"
%>
</body>
</html>


