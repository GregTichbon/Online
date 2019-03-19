<%
'for each var in request.form
'	response.write var & " = " & request.form(var) & "<br>"	
'next
'response.end
'commented out because session may expire ehilst writing comments.
	'if session("Incedo_MemberID")= "" then
	'	response.redirect "../signon"
	'end if
%>
<!--#include file = "database.inc"-->
<%
editmessage = request.form("editmessage")
threadparent = request.form("threadparent")
parentmessage = request.form("parentmessage")
sTopic = prepStringForSQL(Request("topic"))
sComments = prepStringForSQL(Request("comments"))
if request.form("knownas") <> "" then
	name = request.form("knownas") 
else
	name = request.form("firstname") 
end if
name = name & " " & request.form("lastname") 
thedatetime = GMTDate(now())
if editmessage = "new" then
	sSQL = "INSERT INTO FORUMMESSAGES (AUTHORID,TOPIC,COMMENTS,LASTTHREADPOST,DATEPOSTED) VALUES (" & request.form("memberid") & "," & sTopic & "," & sComments & ",'" & thedatetime & "','" & thedatetime & "')"
	conn.execute sSQL
	sSQL = "UPDATE FORUMMESSAGES SET THREADPARENT = ID WHERE THREADPARENT = 0"
	conn.execute sSQL
	message = "A new topic was added to the forum entitled: " & sTopic & " by " & name & "<br>Click <a href=""http://www.incedo.org.nz/private/forum/default.asp"">Here</a> to go directly to the forums"
elseif editmessage = "1" then
	'sSql = "Insert the old record into an archive record"
	if request.form("delete") = "Delete" then
		sSQL = "Delete * from FORUMMESSAGES WHERE ID = " & parentmessage
		conn.execute sSQL
		sSQL = "UPDATE FORUMMESSAGES SET REPLYCOUNT = REPLYCOUNT - 1 WHERE ID = " & threadparent
		conn.execute sSQL
		'maybe send message to people with Full security
	else
		sSQL = "UPDATE FORUMMESSAGES SET TOPIC = " & sTopic & ", COMMENTS = " & sComments & " WHERE ID = " & parentmessage
		conn.execute sSQL
		if inhibitmessage <> "" then
			message = "A message was edited by: " & xxx & " under the topic: " & xx & " entitled: " & xx & " by " & xx
		end if
	end if
else
	sSQL = "INSERT INTO FORUMMESSAGES (AUTHORID,TOPIC,COMMENTS,THREADPARENT,PARENTMESSAGE,LASTTHREADPOST,DATEPOSTED) VALUES (" & request.form("memberid") & "," & sTopic & "," & sComments & "," & threadparent & "," & parentmessage & ",'" & thedatetime & "','" & thedatetime & "')"
	conn.execute sSQL
	sSQL = "UPDATE FORUMMESSAGES SET REPLYCOUNT = REPLYCOUNT + 1, LASTTHREADPOST = '" & thedatetime & "' WHERE ID = " & threadparent
	conn.execute sSQL
	message = "A new message was added under the topic entitled: " & sTopic & " by " & name & "<br>Click <a href=""http://www.incedo.org.nz/private/forum/showposts.asp?id=" & threadparent & """>Here</a> to go directly to it"
end if
if lcase(request.servervariables("SERVER_NAME")) = "localhost" then
	local = true
else
	local = false
end if
if message <> "" and 1=1 and local = false then
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT lastname, firstname, knownas, Email from people where membershipdate is not null and category <> 'Ceased' and email is not null"
	'sql = "SELECT lastname, iif(knownas is null,firstname,knownas) as [name], Email from people where membershipdate is not null and [category] <> 'Ceased' and id = 60"
'response.write sql
'response.end
	rs1.Open sql, conn
	do until rs1.eof
		Set objMail = Server.CreateObject("CDONTS.NewMail")
		objMail.To = rs1("email")
		objMail.From = "webmaster@incedo.org.nz"
		objMail.Subject = "Incedo Forum Update"
		objMail.Body = message
		objMail.MailFormat = 0
		objMail.BodyFormat = 0
		objMail.Send
		Set objMail = Nothing
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
end if
%>
<!--#include file = "database_cleanup.inc"-->
<%
if editmessage = "new" then
	response.redirect "default.asp"
else
	response.redirect "showposts.asp?id=" & threadparent
end if

Function isBlank(Value)
	if isNull(Value) then
		bAns = true
	else
		bAns = trim(Value) = ""
	end if
	isBlank = bAns
end function

Function FixNull(Value)
	if isNull(Value) then
		sAns = ""
	else
		sAns = trim(Value)
	end if
	FixNull = sAns
end function

Function prepStringForSQL(sValue)
	Dim sAns
	sAns = Replace(sValue, Chr(39), "''")
	sAns = "'" & sAns & "'"
	prepStringForSQL = sAns
End Function

function ReplaceComments(sInput)
	dim sAns
	sAns = replace(sInput, "  ", "&nbsp; ")
	sAns = replace(sAns, chr(34), "&quot;")
	sAns = replace(sAns, "<!--", "&lt;!--")
	sAns = replace(sAns, "-->", "--&gt;")
	ReplaceComments = sAns
end function

function HTMLFormat(sInput)
	dim sAns
	sAns = replace(sInput, "  ", "&nbsp; ")
	sAns = replace(sAns, chr(34), "&quot;")
	sIllStart = "<" & chr(37)
	sIllEnd = chr(37)  & ">"
	if instr(sAns, sIllStart) > 0 or instr(sAns, sIllEnd) > 0 then
		sAns = replace(sAns, "<" & chr(37), "")
		sAns = replace(sAns, chr(37)  & ">", "")
		bIllegal = true
	end if
	sAns = replace(sAns, ">", "&gt;")
	sAns = replace(sAns, "<", "&lt;")
	sAns = replace(sAns, vbcrlf, "<BR>")
	HTMLFormat = sAns
end function

Function GMTDate(passDate)
    Server.Execute "/GetServerGMTOffset.asp"
	GMTDate = dateadd("n", Session("ServerGMTOffset"), passDate)
End Function
%>


