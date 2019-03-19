<%
if 	session("chatstaff") = "" or session("chatnickname") = "" then
	response.redirect "default.asp"
else
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="REFRESH" CONTENT="5;monitor.asp">
<title>Chat - Monitor</title>
<script language="JavaScript">
<!-- hide from JavaScript-challenged browsers
function openWindow(url, name) {
    popupWin = window.open(url, '_blank', 'scrollbars,resizable,width=400,height=250')
  	//popupWin = window.open('test.asp', '_blank', 'scrollbars,resizable,width=400,height=250');
    window.location.href = 'monitor.asp';

}
// done hiding -->
</script>
</HEAD>
<BODY>
Your Zones:
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "select * from [zones] where id in (" & session("chatzones") & ")"
	rs.Open sql, db
	do until rs.eof
		response.write rs("id") & " - " & rs("name") & "&nbsp;"
		rs.movenext
	loop
	rs.close
	set rs = nothing

%>

<br><br>

<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<tr><td>Nickname</td><td>Zone</td><td>Question</td><td>Started</td><td>Duration</td><td>Last Post</td><td>Last Staff Post</td><td>Last Refresh</td><td>Last Staff Refresh</td><td>Staff</td><td>Action</td></tr>
<%
	set di = server.createobject("DI.IIS")

	Set rs = Server.CreateObject("ADODB.Recordset")
	Set rs1 = Server.CreateObject("ADODB.Recordset")
	'sql = "SELECT [Session].*, Staff.[Name] FROM [Session] LEFT JOIN Staff ON [Session].Staff = Staff.ID WHERE [Session].EndTime Is Null and [zone] in (" & session("chatzones") & ") order by [session].id"
	sql = "SELECT [Session].*, Staff.[Name] as staffname, Zones.[Name] as zonename " & _
		  "FROM Zones INNER JOIN ([Session] LEFT JOIN Staff ON [Session].Staff = Staff.ID) ON Zones.ID = [Session].[Zone] " & _
		  "WHERE ((([Session].EndTime) Is Null) AND (([Session].[Zone]) In (" & session("chatzones") & "))) " & _
		  "ORDER BY [Session].ID"
'response.write sql
'response.end
	rs.Open sql, db
	do until rs.eof
		sql = "SELECT top 1 * FROM dialogue where [session] = " & rs("id") & " order by id"
		rs1.Open sql, db
		narrative = rs1("Narrative")
		rs1.close
		sql = "SELECT top 1 * FROM dialogue where [session] = " & rs("id") & " and staff is null order by id DESC"
		rs1.Open sql, db
		lastpost = datediff("s",rs1("datetime"),now())
		lastpost = formattime(lastpost)
		rs1.close
		sql = "SELECT top 1 * FROM dialogue where [session] = " & rs("id") & " and staff is not null order by id DESC"
		rs1.Open sql, db
		if rs1.eof then
			laststaffpost = datediff("s",rs("starttime"),now())
			laststaffpost = formattime(laststaffpost)
			laststaffpost = "None " & laststaffpost
		else
			laststaffpost = datediff("s",rs1("datetime"),now())
			laststaffpost = formattime(laststaffpost)
		end if
		rs1.close
		if isnull(rs("staffname")) then
			'answer = " <a href=""answer.asp?staffid=" & session("chatstaff") & "&chatid=" & rs("id") & """ target=""_blank"">Answer</a> / <a href=""close.asp?chatid=" & rs("id") & """ target=""_blank"">Close</a>"
			answer = " <A HREF=""javascript:openWindow('answer.asp?staffid=" & session("chatstaff") & "&chatid=" & rs("id") & "', 'staffchat" & rs("id") & "');"">Answer</a> / " 
			sound = "<bgsound src=""alert.wav"" loop=""-1""><script language=""JavaScript"">window.moveTo(0,0);window.resizeTo(screen.width,screen.height);</script>"
		else
			answer = rs("staffname")
		end if
		duration = datediff("s",rs("starttime"),now())
		duration = formattime(duration)
		elapsedrefresh = datediff("s",rs("lastrefresh"),now())
		elapsedrefresh = formattime(elapsedrefresh)
		elapsedstaffrefresh = datediff("s",rs("laststaffrefresh"),now())
		elapsedstaffrefresh = formattime(elapsedstaffrefresh)
		response.write "<tr><td>" & rs("nickname") & "</td><td>" & rs("zone") & " - " & rs("zonename") & "</td><td>" & Narrative & "</td><td>" & di.di_format(rs("starttime"),"dd/mm/yy hh:mm:ss") & "</td><td>" & duration & "</td><td>" & lastpost & "</td><td>" & laststaffpost & "</td><td>" & elapsedrefresh & "</td><td>" & elapsedstaffrefresh & "</td><td>" & answer & "</td><td><A HREF=""javascript:openWindow('close.asp?id=" & rs("id") & "', 'close" & rs("id") & "');"">Close</a></td></tr>"
		rs.movenext
	loop
	set rs1 = nothing
	rs.close
%> 
</table>
<br><br>Support Staff<br>
<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<tr><td>Name</td><td>Status</td><td>Zone</td><td>Chats</td></tr>

<%

	sql = "SELECT Staff.ID, Staff.Name, Staff.Online, Staff_Zones.[Zone] FROM Staff INNER JOIN Staff_Zones ON Staff.ID = Staff_Zones.Staff WHERE Staff_Zones.[Zone] In (" & session("chatzones") & ") ORDER BY Staff.Name"
	sql = "SELECT Staff.ID, Staff.Name as staffname, Staff.Online, Staff_Zones.[Zone], Zones.Name as zonename " & _
		  "FROM [Zones] INNER JOIN (Staff INNER JOIN Staff_Zones ON Staff.ID = Staff_Zones.Staff) ON [Zones].ID = Staff_Zones.[Zone] " & _
		  "WHERE (((Staff_Zones.[Zone]) In (" & session("chatzones") & "))) " & _
		  "ORDER BY Staff.Name, Zones.Name"

'response.write sql
'response.end
	rs.Open sql, db
 	do until rs.eof
		if rs("online") = true then
			status = "Online"
		else
			status = "Offline"
		end if
		if rs("staffname") = laststaffname then
			staffname = "&nbsp;"
			status = "&nbsp;"
		else
			staffname = rs("staffname")
			laststaffname = staffname
		end if
		response.write "<tr><td>" & staffname & "</td><td>" & status & "</td><td>" & rs("zone") & " - " & rs("zonename") & "</td><td>" & "to do" & "</td></tr>"
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	set di = nothing

	response.write sound
%>
</table>
<a href="../../Chat/Staff/logoff.asp"><br>
Logoff</a>
</BODY>
</HTML>
<%
function formattime(passseconds)
	hrs = int((passseconds / 3600))
	mins = passseconds - (hrs * 3600)
	mins = int((mins / 60))
	secs = passseconds - (hrs * 3600) - (mins * 60)
	formattime = hrs & ":" & right("0" & mins,2) & ":" & right("0" & secs,2)
	
end function
end if
%>

