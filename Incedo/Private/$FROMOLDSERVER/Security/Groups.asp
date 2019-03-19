<HTML><HEAD><title>Incedo Security</title></HEAD>
<BODY>
	<table border="0">
	<tr><td>ID</td><td>Group</td></tr>
  <form name="groups" method="post" action="groups_process.asp">
  <%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * from securitygroup order by [group]"
	rs.Open sql, db
	do until rs.EOF
		response.write "<tr>"
		response.write "<td>" & rs("id") & "</td>"
		response.write "<td><input name=""" & rs("id") & """ type=""text"" value=""" & rs("group") & """></td><td><a href=""groupoptions.asp?id=" & rs("id") & """>Options</a></td>"
		response.write "</tr>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
%>
	<tr><td>New</td>
	  <td><input name="new" type="text" id="new" value=""></td>
	</tr>
     

      <tr><td colspan="5"><div align="right">
        <input name="submit" type="submit" id="submit" value="Submit">
      </div></td>
      </tr>

  </form>
  </table>
    <p><a href="default.asp">Security Menu</a></p>
</BODY>
</HTML>



