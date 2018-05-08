<%
'for each var in request.form
'	response.write var & " = " & request.form(var) & "<br>"	
'next
'response.end
'commented out because session may expire ehilst writing comments.
	'if session("TeOraHou_MemberID")= "" then
	'	response.redirect "../signon"
	'end if
%>
<!--#include file = "database.inc"-->
<%
editmessage = request.form("editmessage")
threadparent = request.form("threadparent")
parentmessage = request.form("parentmessage")
stitle = prepStringForSQL(Request("title"))
sblog = prepStringForSQL(Request("blog"))
if request.form("knownas") <> "" then
	name = request.form("knownas") 
else
	name = request.form("firstname") 
end if
name = name & " " & request.form("lastname") 
thedatetime = GMTDate(now())
if editmessage = "new" then
	sSQL = "INSERT INTO blog (AUTHOR,title,blog) VALUES (" & request.form("memberid") & "," & stitle & "," & sblog & ",'" & thedatetime & "','" & thedatetime & "')"
	conn.execute sSQL
	sSQL = "UPDATE blog SET THREADPARENT = ID WHERE THREADPARENT = 0"
	conn.execute sSQL
	message = "A new topic was added to the forum entitled: " & sTopic & " by " & name & "<br>Click <a href=""http://www.incedo.org.nz/private/blog/default.asp"">Here</a> to go directly to the blog"
elseif editmessage = "1" then
	'sSql = "Insert the old record into an archive record"
	if request.form("delete") = "Delete" then
		sSQL = "Delete * from blog WHERE ID = " & parentmessage
		conn.execute sSQL
		sSQL = "UPDATE blog SET REPLYCOUNT = REPLYCOUNT - 1 WHERE ID = " & threadparent
		conn.execute sSQL
		'maybe send message to people with Full security
	else
		sSQL = "UPDATE blog SET title = " & stitle & ", blog = " & blog & " WHERE ID = " & parentmessage
		conn.execute sSQL
		if inhibitmessage <> "" then
			message = "A message was edited by: " & xxx & " under the title: " & xx & " entitled: " & xx & " by " & xx
		end if
	end if
else
	sSQL = "INSERT INTO blog (AUTHORID,title,blog,THREADPARENT,PARENTMESSAGE,LASTTHREADPOST,DATEPOSTED) VALUES (" & request.form("memberid") & "," & stitle & "," & blog & "," & threadparent & "," & parentmessage & ",'" & thedatetime & "','" & thedatetime & "')"
	conn.execute sSQL
	sSQL = "UPDATE blog SET REPLYCOUNT = REPLYCOUNT + 1, LASTTHREADPOST = '" & thedatetime & "' WHERE ID = " & threadparent
	conn.execute sSQL
	message = "A new message was added under the topic entitled: " & sTopic & " by " & name & "<br>Click <a href=""http://www.incedo.org.nz/private/blog/showposts.asp?id=" & threadparent & """>Here</a> to go directly to it"
end if
if lcase(request.servervariables("SERVER_NAME")) = "localhost" then
	local = true
else
	local = false
end if
if message <> "" and 1=1 and local = false then
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT lastname, firstname, knownas, Email from people where membershipdate is not null and category <> 'Ceased' and email is not null"
	sql = "SELECT people.Lastname, people.Firstname, people.KnownAs, ForumMembers.[email], ForumMembers.Status " & _
		  "FROM people INNER JOIN ForumMembers ON people.ID = ForumMembers.MemberID " & _
		  "WHERE (((ForumMembers.email) Is Not Null) AND ((ForumMembers.Status)='Live') AND ((people.Category) Is Null Or (people.Category)<>'Ceased'))"

	sql = "SELECT people.Lastname, people.Firstname, people.KnownAs, ForumMembers.email, ForumMembers.Status, ForumMessageMember.InhibitEmail, ForumMessageMember.ForumMessageID " & _
		  "FROM (people RIGHT JOIN ForumMembers ON people.ID = ForumMembers.MemberID) LEFT JOIN ForumMessageMember ON ForumMembers.MemberID = ForumMessageMember.ForumMemberID " & _
		  "WHERE (((ForumMembers.email) Is Not Null) AND ((ForumMembers.Status)='Live') AND ((people.Category) Is Null Or (people.Category)<>'Ceased') AND ((ForumMessageMember.InhibitEmail) Is Null Or (ForumMessageMember.InhibitEmail)=False) AND ((ForumMessageMember.ForumMessageID) Is Null Or (ForumMessageMember.ForumMessageID)=" & threadparent & "))"

	sql = "SELECT ForumMembers.Email, people.Lastname, people.Firstname, people.KnownAs " & _
			"FROM (people RIGHT JOIN ForumMembers ON people.ID = ForumMembers.MemberID) LEFT JOIN (SELECT ForumMessageMember.ForumMemberID, ForumMessageMember.inhibitemail FROM ForumMessageMember WHERE ForumMessageMember.ForumMessageID = " & threadparent & ")  AS FMM ON ForumMembers.MemberID = FMM.ForumMemberID " & _
			"WHERE (((FMM.inhibitemail) Is Null Or (FMM.inhibitemail)=False) AND ((ForumMembers.Status)='Live') AND ((ForumMembers.Email) Is Not Null) AND ((people.Category) Is Null Or (people.Category)<>'Ceased')) order by email"

'response.write sql
'response.end
	rs1.Open sql, conn
	do until rs1.eof
		if 1=1 then
			response.write rs1("email") & "<br>"
		end if
		Set objMail = Server.CreateObject("CDONTS.NewMail")
		objMail.To = rs1("email")
		objMail.From = "webmaster@incedo.org.nz"
		objMail.Subject = "Incedo Blog Update"
		objMail.Body = message
		objMail.MailFormat = 0
		objMail.BodyFormat = 0
		objMail.Send
		Set objMail = Nothing
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
	'response.end
end if


%>
<!--#include file = "database_cleanup.inc"-->
<%
if 1=1 then
	if editmessage = "new" then
		response.write "<a href=""default.asp"">Continue</a>"
	else
		response.write "<a href=""showposts.asp?id=" & threadparent & """>Continue</a>"
	end if
else
	if editmessage = "new" then
		response.redirect "default.asp"
	else
		response.redirect "showposts.asp?id=" & threadparent
	end if
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


