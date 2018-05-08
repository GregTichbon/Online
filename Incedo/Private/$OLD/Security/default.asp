<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Security"
		secoption = "Main"
%>
	<!--#include file="../inc_security.asp"-->		
<%
	end if
%>
<HTML>
<HEAD>
<title>Incedo Security</title>
</HEAD>
<BODY>
<%
if secresult = "Yes" then 
%>
	<p><a href="personlist.asp">Person</a></p>
	<p><a href="groups.asp">Group</a></p>
<%
else
	response.write "You do not have access to maintain security, you may only view these.  You may email the people below."
end if
%>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
  <tr>
    <td>Name</td>
    <td>Group</td>
    <td>Option</td>
    <td>Description</td>
    <td>Value</td>
    <td>Base/Areas</td>
  </tr>
<%
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT people.id, people.Lastname, IIf(knownas Is Null,firstname,knownas) AS name, people.Email, SecurityGroup.Group, SecurityGroupOptions.Option, SecurityGroupOptions.Description, People_SecurityOption.Value, People_SecurityOption.BaseArea FROM ((people INNER JOIN People_SecurityOption ON people.ID = People_SecurityOption.Person) INNER JOIN SecurityGroupOptions ON People_SecurityOption.Option = SecurityGroupOptions.ID) INNER JOIN SecurityGroup ON SecurityGroupOptions.Group = SecurityGroup.ID ORDER BY people.Lastname, IIf(knownas Is Null,firstname,knownas), SecurityGroup.Group, SecurityGroupOptions.Option"
	rs.open sql, db
	do until rs.eof
		response.write "<tr><td>"
		if rs("id") <> lastid then
			response.write "<a href=""mailto:" & rs("email") & """>" & rs("name") & " " & rs("lastname") & "</a>"
			if secresult = "Yes" then 
				response.write " <a href=""person.asp?id=" & rs("id") & """>Edit</a>"
			end if
			lastid = rs("id")
		else
			response.write "&nbsp;"
		end if
		response.write "</td><td>" & rs("group") & "</td><td>" & rs("option") & "</td><td>" & rs("description") & "&nbsp;</td><td>" & rs("value") & "</td><td>" & rs("basearea") & "&nbsp;</td></tr>"
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.close
	set db = nothing
%>
</table>
<p><a href="../default.asp">Main Menu </a></p>
</BODY>
</HTML>
