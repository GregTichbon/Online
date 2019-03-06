<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Prayer"
		secoption = "Administration"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
		administrator = secresult 
	end if
	set di = server.createobject("DI.IIS")
%>
<HTML><HEAD><title>Prayer Pages</title></HEAD>
<BODY>
<table width="800" align="center">
  <tr> 
     <td> 
      <div align="center"><font size="+3" face="Georgia, Times New Roman, Times, serif" color="#ff0000"><b>Incedo Prayer Page</b></font></div>
    </td>
  </tr>
</table>
<p>
  <%
	'if administrator = "OK" then
%>
	<a href="dailytxt.asp">Maintain Daily Txts</a> |
	<a href="send_email.asp">Send Email</a>
</p>
<p>
    <%
'end if
%>
    <font size="+2"><strong>Prayer Items</strong></font></p>
<p><a href=submit.asp?id=New>Add</a></p>
<table border="1" bordercolor="#000000" cellpadding="5">
  <%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "select PrayerItem.*, IIf([knownas] Is Null,[Firstname],[knownas]) & ' ' & [lastname] & ' (' & [centre] & ')' AS Name, People.Email " & _
          "FROM PrayerItem LEFT JOIN People ON PrayerItem.SubmittedBy = People.ID where closed <> yes and expireon > now() order by itemid"
	rs.Open sql, db
	do until rs.EOF
		response.write "<tr><td>"
		if session("Incedo_MemberID") = rs("submittedby") or administrator = "OK" then
			response.write "<a href=""submit.asp?id=" & rs("itemid") & """><img src=""edit.gif"" border=""0""></a>"
		else 
			response.write "&nbsp;"
		end if
		response.write "</td>"
		response.write "<td><b>" & rs("title") & "</b><br>" & rs("narrative")
		if administrator = "OK" then
			response.write "<br>Submitted on: " & di.di_format(rs("datetime"),"dd mmm yyyy") & " by: " & rs("name") & " <a href=""mailto:" & rs("email") & """>" & rs("email") & "</a>&nbsp;&nbsp;&nbsp;Expires on: " & di.di_format(rs("expireon"),"dd mmm yyyy")
		end if
		Response.Write "</td></tr>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
%>
</table>
<p>
  <%
if administrator = "OK" then
%> 
The email address for prayer items is <a href="mailto:prayer@incedo.org.nz">prayer@incedo.org.nz</a>.  The password is time.  The account can be accessed <a href="http://private.incedo.org.nz/mail/am" target="_blank">here</a><%
end if
%>
</p>
<p>Instructions: &nbsp;&nbsp;&nbsp;&nbsp;<a href="Incedo%20Daily%20Prayer%20text%20Info%202015.pdf" target="_blank">PDF</a></p>
</BODY>
</HTML>
