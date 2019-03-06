<HTML><HEAD><title>Incedo Security</title></HEAD>
<BODY>
	<table border="0">
	<tr><td>ID</td><td>Option</td><td>Description</td><td>Base/Area Option</td>
	  <td>Delete</td>
	</tr>
  <form name="groups" method="post" action="groupoptions_process.asp">
  <%
  	baseareaoptions = Array("None","Base","Area")
  	baseareaoptionvalues = Array("","Base","Area")
	id = request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

	sql = "SELECT * from securitygroupoptions where [group] = " & id & " order by [option]"
	rs.Open sql, db
	do until rs.EOF
		response.write "<tr>"
		response.write "<td>" & rs("id") & "</td>"
		response.write "<td><input name=""" & rs("id") & """ type=""text"" value=""" & rs("option") & """></td>"
		response.write "<td><input name=""description" & rs("id") & """ type=""text"" value=""" & rs("description") & """></td>"
		response.write "<td><select name=""baseareaoption" & rs("id") & """ size=""1"">"
		for f1=0 to ubound(baseareaoptions)
			if rs("baseareaoption") = baseareaoptionvalues(f1) then
				selected = " selected"
			else
				selected = ""
			end if
			response.write "<option value=""" & baseareaoptionvalues(f1) & """" & selected & ">" & baseareaoptions(f1) & "</option>"
		next
		response.write "</select></td>"
		response.write "<td><input name=""delete" & rs("id") & """ type=""checkbox"" value=""-1""></td>"
		response.write "</tr>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
%>
	<tr><td>New</td>
	  <td><input name="$id" type="hidden" id="$id" value="<%=id%>">
	  <input name="new" type="text" id="new" value=""></td>
	  <td><input name="descriptionnew" type="text" id="descriptionnew" value=""></td>
	  <td><select name="baseareaoptionnew" size="1" id="baseareaoptionnew">
<%
		for f1=0 to ubound(baseareaoptions)
			response.write "<option value=""" & baseareaoptionvalues(f1) & """>" & baseareaoptions(f1) & "</option>"
		next
%>
      </select></td>
	  <td>&nbsp;</td>
	</tr>
     

      <tr><td colspan="6"><div align="right">
        <input name="submit" type="submit" id="submit" value="Submit">
      </div></td>
      </tr>

  </form>
  </table>
    <p><a href="groups.asp">Groups</a></p>
</BODY>
</HTML>
