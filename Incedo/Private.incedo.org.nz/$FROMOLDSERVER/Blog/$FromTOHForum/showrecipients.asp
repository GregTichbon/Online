<%
	if session("TeOraHou_MemberID")= "" then
		response.end
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
<!--#include file = "database.inc"-->
<HTML>
<HEAD>
<TITLE>Recipients</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
</HEAD>
<body>
<P><center><b><font size="+1">Recipients</font></b></center><p>
<%
		id = request.querystring("id")
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\teorahou\teorahou.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.RecordSet")


		sql = "SELECT FMM.inhibitemail, ForumMembers.Status, IIf([email] Is Null,'No Email','') AS ForumEmail, IIf([knownas] Is Null,[firstname],[knownas]) AS name, people.Lastname " & _
			"FROM (people RIGHT JOIN ForumMembers ON people.ID = ForumMembers.MemberID) LEFT JOIN (SELECT ForumMessageMember.ForumMemberID, ForumMessageMember.inhibitemail FROM ForumMessageMember WHERE ForumMessageMember.ForumMessageID = " & id & ")  AS FMM ON ForumMembers.MemberID = FMM.ForumMemberID " & _
			"WHERE (((IIf([email] Is Null,'No Email','')) Is Not Null) AND ((people.Category) Is Null Or (people.Category)<>'Ceased')) " & _
			"ORDER BY FMM.inhibitemail DESC , ForumMembers.Status DESC , IIf([email] Is Null,'No Email',''), IIf([knownas] Is Null,[firstname],[knownas]), people.Lastname;"

		rs.Open sql, db
		doheader = true
		if not rs.eof then
			response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"">"
			do until rs.EOF
				cnt = cnt + 1
				if doheader = true then
					response.write "<tr>"
					Response.write "<th nowrap>Recipient</th><th nowrap>Note</th>"
					Response.Write "</tr>"
					'response.write "<tr>"
					'Response.write "<td colspan=""2"">" & sql & "</td>"
					'Response.Write "</tr>"
					doheader = false
				end if
				status = rs("status") & ""
				forumemail = rs("forumemail") & ""
				inhibitemail = rs("inhibitemail")
				
				if status <> "Live" or ForumEmail <> "" then
					message = "Not setup for forums"
				elseif inhibitemail then
					message = "Notifiation inhibited for this topic"
				else
					message = "&nbsp;"
				end if
				response.write "<tr>"
				Response.write "<td nowrap>" & rs("name") & " " & rs("lastname") & "</td><td nowrap>" & message & "</td"
				Response.Write "</tr>"
				rs.MoveNext
			loop
			response.write "</table>"
		else
			response.write "There are no recipients for this topic"
		end if		
		rs.Close
		set rs = nothing
		db.Close
		set db = nothing
%>
</body>
</HTML>



