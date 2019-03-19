<%
myfile = Request.QueryString("document")
%>
<html>
<div align="center">
<%
set di = server.createobject("DI.IIS")
connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
Set db = Server.CreateObject("ADODB.Connection")
db.Open connection_string
Set rs = Server.CreateObject("ADODB.RecordSet")
sql = "SELECT Documents.Document, Documents.Description, DocumentUpdates.* FROM Documents LEFT JOIN DocumentUpdates ON Documents.ID = DocumentUpdates.Document " & _
	  "WHERE Documents.ID = " & myfile & " ORDER BY DocumentUpdates.Date DESC"
rs.Open sql, db
if not rs.EOF then
	myfullfile = "e:\homepage\incedo\private\documents\documents\" & rs("documents.document")
	Set fs = createobject("Scripting.FileSystemObject")
	Set f = fs.getfile(myfullfile)
	flastmod = f.datelastmodified
	set f = nothing
	set fs = nothing
	Response.Write "<p>Document: " & rs("documents.document") & "<br>Description: " & rs("Description") & "<br>Last Modified: " & di.di_format(flastmod,"dd mmm yyyy") & "</p>"
%>
  <table width="100%" border="1">
    <tr> 
      <td>Date</td>
      <td>Who</td>
      <td>Detail</td>
    </tr>
<%	
	do until rs.EOF 
		Response.Write "<tr><td>" & di.di_format(rs("Date"),"dd mmm yyyy") & "</td><td>" & rs("Who") & "</td><td>" & rs("Detail") & "</td></tr>"
		rs.MoveNext 
	loop
	response.write "</table>"
	response.write "<p><a href=""requests.asp?document=" & myfile & """>Download</a></p>"
end if
rs.close
set rs = nothing
db.close
set db = nothing
set di = nothing
%>
</table>
</div>
</html>


