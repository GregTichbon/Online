<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "documents/default.asp?" & request.querystring
		response.redirect "../signon"
	else
%>
	<!--#include file="../inc_logging.asp"-->
<%
	if 1=2 then
		secgroup = "Documents"
		secoption = "Standard"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult <> "OK" then
			response.end
		end if		
	end if
	end if
%>
<html>
<head>
<title>Incedo - Documents</title>
</head>
<body>
<div align="center">
    <table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
      <tr>
        <td align="center"><b>Documents</b></td>
        <td align="center"><b>View Modifications</b></td>
      </tr>
<%   

Set fs = createobject("Scripting.FileSystemObject")

connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
Set db = Server.CreateObject("ADODB.Connection")
db.Open connection_string
Set rs = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT * FROM documents ORDER BY description"
RS.Open Sql, db
do while not rs.EOF 
	myfile = rs("id")
	myfullfile = "e:\homepage\incedo\private\documents\documents\" & rs("document")
	if  fs.FileExists(myfullfile) then 
		Set f = fs.getfile(myfullfile)
		flastmod = f.datelastmodified
		fsize = formatnumber(f.size / 1024,2)
		Response.Write "<tr>"
		Response.Write "<td><a href=Requests.asp?document=" & myfile & ">" & rs("Description") & "</a> (" & fsize & "k)</td>"
		Response.Write "<td><a href=History.asp?document=" & myfile & ">" & "View mods </a></td>"
		Response.Write "<td><a href=delete.asp?document=" & myfile & "&name=" & rs("document") & ">" & "Delete</a></td>"
		Response.Write "</tr>"
	else
		Response.Write "<tr><td>" & rs("Description") & "</td>"
		Response.Write "<td>Not available</td>"
		Response.Write "</tr>"
	end if
	rs.MoveNext 
loop
rs.close
set rs = nothing
db.close
set db = nothing
%>
    </table>
</div>
</body>
</html>



