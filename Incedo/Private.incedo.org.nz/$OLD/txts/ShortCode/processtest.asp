<%
if 1=1 then
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objTStream = objFSO.OpenTextFile("e:\homepage\incedo\private\txts\capture\test.txt", 8, True)
	objTStream.writeLine(now() & "<br>" & request.querystring)
	objTStream.Close
	set objFSO = nothing
else
	Set objMail = Server.CreateObject("CDONTS.NewMail")
	objMail.To = "greg@datainn.co.nz"
	objMail.From = "greg@datainn.co.nz"
	objMail.Subject = "SMS Test"
	objMail.Body = now() & "<br>" & request.querystring
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing
end if
%>