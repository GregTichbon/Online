<%
	if session("forum_memberid")= "" then
		response.redirect "signon"
	end if
%>
<!--#include file = "database.inc"-->
<%
if Request("SubmitMessage") <> "" then bNew = true
if request("SubmitReply") <> "" or request("Reply") <> "" then bReply = true
if request("ApplyMessage") <> "" then bApply = true
bValid = bNew or bReply or bApply
if bApply then 
	bAddNew =  request("MessageType") = "New"
	if bAddNew then
		sTopic = prepStringForSQL(Request("Topic"))
		sComments = ReplaceComments(Request("Message"))
		sComments = prepStringForSQL(sComments)
		sSQL = "INSERT INTO MESSAGES (AUTHORID,TOPIC,COMMENTS) VALUES (" & session("forum_memberid") & "," & sTopic & "," & sComments & ")"
'response.write ssql
'response.end
		conn.execute sSQL
		sSQL = "UPDATE MESSAGES SET THREADPARENT = ID WHERE THREADPARENT = 0"
		conn.execute sSQL
	else
		sOrigAuthor = Request("OrigAuthor")
		if sOrigAuthor = "" then sOrigAuthor = Request.QueryString("OrigAuthor")
		iThread = Request("ThreadID") 
		iParent = Request("ParentID")
		sTopic = prepStringForSQL(Request("Topic")) & ","
		sComments = prepStringForSQL(Request("Message"))
		if iThread = 0 then iThread = iParent
		sSQL = "INSERT INTO MESSAGES (PARENTMESSAGE,THREADPARENT,AUTHORNAME,TOPIC,COMMENTS) VALUES (" & iParent & "," &  iThread & "," & session("authorid") & sTopic & sComments & ")"
		conn.execute sSQL
		cmd.CommandText = "LASTMESSAGE"
		cmd.CommandType = 4
		set rs = cmd.Execute
		sID = rs("ID")
		rs.close
		sSQL = "UPDATE MESSAGES SET REPLYCOUNT = REPLYCOUNT + 1, LASTTHREADPOST = NOW() WHERE ID = " & iThread
		conn.execute sSQL
	end if 'bAddNew
%>
<!--#include file = "database_cleanup.inc"-->
<%
   response.redirect "default.asp"
end if 'bApply
%>
<HTML>
<HEAD>
	<TITLE>DISCUSSON FORUM: PREVIEW MESSAGE</TITLE>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
</HEAD>
<BODY>
<% 
if not bValid then
	response.write "You cannot navigate to this page without entering a forum message.  Please "
	response.write "return to the <A HREF = 'default.asp'>forum index</A> and try again."
	response.end
end if
'Write to db and redirect home.
response.write "<HR>"
if bReply then
	ParentID = Request("ParentID")
	ThreadID = request("ThreadID")
	sOrigAuthor = request("OrigAuthor")
end if
sTopic = request("Topic")
if sOrigAuthor = "" then sOrigAuthor = request.QueryString("OrigAuthor")
sOrigMessage = HTMLFormat(Request("Message"))
%>
<CENTER><FONT SIZE = +2 COLOR=RED><B>Preview Message</B></FONT></CENTER><P>
Please review your post.  If everything is OK, click Submit below.  Otherwise,
click the Back button on your browser to make corrections.<P>
<FORM ACTION = "PreviewMessage.asp" METHOD = "POST">
<%
if bReply Then 
%>
	<INPUT TYPE="HIDDEN" NAME="ParentID" VALUE="<%= ParentID %>">
	<INPUT TYPE="HIDDEN" NAME="ThreadID" VALUE="<%= ThreadID %>">
<% 
end if
%>
<INPUT TYPE="HIDDEN" NAME="Topic" VALUE="<%= sTopic %>">
<INPUT TYPE="HIDDEN" NAME="Message" VALUE="<%= sOrigMessage %>">
<INPUT TYPE = "HIDDEN" NAME = "MessageType" 
<% 
if bReply then
	Response.Write "VALUE = 'REPLY'"
else
	Response.Write "VALUE = 'New'"
end if
%>
<TABLE>
	<TR><TD><B>Topic:</FONT></B></TD>
	<TD><%=  sTopic  %></TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR><TD COLSPAN = 2><B>Message:</B></TD></TR>
</TABLE>
<TABLE WIDTH = 95%><TR>
<TR>
<TD WIDTH = 100%>
<%=  sOrigMessage  %>
</TD></TR></TABLE><P>

<CENTER><INPUT TYPE="Submit" NAME = "ApplyMessage" VALUE = "Submit"></CENTER>
<!--#include file = "footer.inc"-->
</FORM>
<% 
if bIllegal then
%>
	<FONT COLOR = "RED" SIZE = = -1>Your message was altered to delete the ASP delimiters &lt;<%= chr(37) %> and <%= chr(37) %>&gt;</FONT><P>
<%
end if
%>
<!--#include file = "database_cleanup.inc"-->
</HTML>
<%
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
%>

