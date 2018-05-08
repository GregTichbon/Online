<%
	if session("TeOraHou_MemberID")= "" then
		session("TeOraHou_Returnto") = "forum/default.asp?" & request.querystring
		response.redirect "../signon"
	else
		secgroup = "Forum"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		'if secresult = "Failed" then 		
		'	response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
		'	response.end
		'end if
	end if
%>
<!--#include file="../inc_logging.asp"-->
<!--#include file = "database.inc"-->
<HTML>
<HEAD>
<TITLE>Discussion Forum</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<link href="forum.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function archive(id) {
	if(confirm('Are you sure you want to archive this?')) {
		window.location='archive.asp?id=' + id;
	}
}
</script>
</HEAD>
<body>
<center>
  <b><font size="+1">DISCUSSION FORUM</font></b>
</center>
<p>
<P>
<%			  
cmd.CommandText = "SELECT forumMESSAGES.ID, forumMESSAGES.Topic, forumMESSAGES.ReplyCount, forumMESSAGES.LastThreadPost, forumMESSAGES.DatePosted, [firstname], [lastname], knownas, ForumMessageMember.InhibitEmail " & _
				  "FROM (forumMESSAGES LEFT JOIN People ON forumMESSAGES.AuthorID = People.ID) LEFT JOIN ForumMessageMember ON forumMESSAGES.ID = ForumMessageMember.ForumMessageID " & _
				  "WHERE (((forumMESSAGES.ParentMessage)=0) AND ((ForumMessageMember.ForumMemberID)=" & session("TeOraHou_MemberID") & " Or (ForumMessageMember.ForumMemberID) Is Null)) " & _
				  "ORDER BY forumMESSAGES.LastThreadPost DESC"			  
				  
				  
				  
				  '"WHERE (((forumMESSAGES.ParentMessage)=0) AND ((ForumMessageMember.ForumMemberID)=2 Or (ForumMessageMember.ForumMemberID) Is Null)) " & _
				  '"ORDER BY forumMESSAGES.LastThreadPost DESC"			  
				  
				  
response.write cmd.commandtext
cmd.CommandType = 1
iPageSize = 20
iPage = cint(Request.QueryString("Page"))
if iPage = 0 then iPage = 1
rs.open cmd, , 1, 3
if not rs.Eof and not rs.bof then
	rs.MoveLast
	lTotalRecords = rs.RecordCount
	iTotalPages = int(lTotalRecords / iPageSize)
	if lTotalRecords MOD iPageSize <> 0 then iTotalPages = iTotalPages + 1
	if lTotalRecords <=  iPageSize then
		rs.MoveFirst
		bOnePage = true
		lPageEnd = lTotalRecords
		lPageStart = 1
		iTotalPages = 1
	else
		lPageStart = ((iPage - 1) * iPageSize) + 1
		lPageEnd = lPageStart + (iPageSize - 1)
		if lPageEnd >= lTotalRecords Then 
			lPageEnd = lTotalRecords
			bLastPage = true
		end if
		if iPage > 1 then
			rs.AbsolutePosition = ((iPage - 1) * iPageSize) + 1
		else
			rs.MoveFirst
		end if
	end if
else
	bNoRecords = true
end if
%>
  </SELECT>
  </TD>
  </FORM>
<FORM ACTION = "newpost.asp" METHOD = "POST">
  <TD><INPUT TYPE = "SUBMIT" VALUE = "New Topic"></TD>
</FORM>
</tr>
</TABLE>
<P>
  <%
if not bNoRecords then
    response.write "<P><B>Page " & iPage & " of " & iTotalPages & "</B><P>"
end if
%>
<TABLE WIDTH="100%" border="1" cellpadding="5" cellspacing="0" bordercolor="#999999">
<TR>
  <TD>Topic</TD>
  <TD>Author</TD>
  <TD>Created</TD>
  <TD ALIGN="CENTER">Replies</TD>
  <TD>Last Post</TD>
 <!-- <TD>Inhibit Email</TD>-->
<%
	if secresult = "Full" then
		response.write "<TD>Archive</TD>"
	end if
%>
</TR>
<% 
if bNoRecords then
	if secresult = "Full" then
		tdspan = 7
	else
		tdspan = 6
	end if
	response.write "<TR><TD COLSPAN=""" & tdspan & """><B>There are no messages available at the present time</B></TD></TR>"
else
	set di = server.createobject("DI.IIS")
	for lCtr = lPageStart to lPageEnd
		if Rs("knownas") & "" = "" then
			authorname = RS("firstname")
		else
			authorname = Rs("knownas")
		end if
	    authorname = authorname & " " & RS("lastname")
		response.write "<TD><A HREF='showposts.asp?ID=" & rs("ID") & "'>"  & rs("Topic") & "</A></TD>"
		response.write " <TD>" & AuthorName & "</A></TD>"
		response.write "<TD>" & di.di_format(rs("DatePosted"),"dd mmm yyyy hh:mm") & "</TD>"
		response.write "<TD ALIGN = CENTER>" & rs("ReplyCount") & "</TD>"
		response.write "<TD>" & di.di_format(rs("LastThreadPost"),"dd mmm yyyy hh:mm") & "</TD>"
		'response.write "<TD>" & rs("inhibitemail") & "</TD>"
		if secresult = "Full" then
			response.write "<TD><a href=""javascript:void(0);"" onClick=""archive(" & rs("id") & ")"">Archive</a></TD>"
		end if
		
		response.write "</TR>"
		rs.movenext
	Next
	set di = nothing
end if
%>
</TABLE>
<%
if bOnePage = false and bNoRecords = false then
	response.write "<TABLE WIDTH = '100%'><TR><TD>&nbsp;</TD></TR><TR><TD WIDTH = '10%'>&nbsp;</TD><TD WIDTH = '60%'>"
	if iPage > 1 then
		sPrevQuery = "Page=" & iPage - 1
		response.write "<A HREF = 'default.asp?" & sPrevQuery & "'><B><< Previous Page</B></A>"
	else
		response.write "&nbsp;"
	end if
	response.write "</TD><TD VALIGN = TOP NOWRAP>"
	if bLastPage = false then
		sNextQuery = "Page=" & iPage + 1 
		response.write "<A HREF = 'default.asp?" & sNextQuery & "'><B>Next Page >></B></A>"
	else
		response.write "&nbsp;"
	end if
	response.write "<TD WIDTH = '10%'>&nbsp;</TD>"
	response.write "</TD></TR></TABLE>"
	response.write "<P><CENTER><FONT SIZE =-1>"
	
	for iCtr = 1 to iTotalPages
		sPageQuery = "Page=" & iCtr & sQuery
		if iCtr <> iPage then
			response.write "<A HREF = 'default.asp?" & sPageQuery & "'>"
		else
			response.write "<B>"
		end if
		response.write iCtr
		
		if iCtr <> iPage then
			response.write "</A>"
		else
			response.write "</B>" 
		end if
		if iCtr < iTotalPages then response.write "&nbsp;&nbsp;|&nbsp;&nbsp;"
	Next
	response.write "</FONT></CENTER>"
end if
%>
<P><a href="../default.asp">Return to the Main Page</a></P>
</body>
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
%>