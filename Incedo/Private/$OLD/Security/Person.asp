<HTML>
<HEAD>
<title>Incedo Security</title>
</HEAD>
<BODY>
<table width="100%" border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
  <tr>
    <!--<td>ID </td>-->
    <td nowrap>Option</td>
    <td>Description</td>
    <td>Base/Area Option</td>
  </tr>
  <form name="person" method="post" action="person_process.asp">
    <%
	id = request.form("id")
	if id = "" then id = request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT SecurityGroupOptions.ID, SecurityGroupOptions.Option, SecurityGroupOptions.Description, SecurityGroupOptions.BaseAreaOption, securitygroup.group, P.Value, P.BaseArea " & _
		  "FROM ((SELECT People_SecurityOption.* FROM People_SecurityOption WHERE People_SecurityOption.Person = " & id & ") AS P " & _
		  "RIGHT JOIN SecurityGroupOptions ON P.Option = SecurityGroupOptions.ID) INNER JOIN SecurityGroup ON SecurityGroupOptions.Group = SecurityGroup.ID"
response.write sql
'response.end
	rs.Open sql, db
	do until rs.EOF
		response.write "<tr>"
		'response.write "<td>" & rs("id") & "</td>"
		response.write "<td nowrap>" & rs("group") & " - " & rs("option") & "<br>" & rs("description") & "</td>"
		response.write "<td><input name=""" & rs("id") & """ type=""text"" value=""" & rs("value") & """ style=""width:100%""></td>"
		response.write "<td>"
		if rs("BaseAreaOption") & "" <> "" then
			sql = "select * from bases where [Type] = '" & rs("BaseAreaOption") & "' order by centre"
			rs1.Open sql, db
			delim = ""
			do until rs1.EOF
'response.write "<br>*" & rs("basearea") & "-" & rs1("centre") & "*<br>"
				if instr(", " & rs("basearea") & ",",", " & rs1("centre") & ",") > 0 then
					checked = " checked"
				else
					checked = ""
				end if
				response.write delim & "<input type=""checkbox"" name=""basearea" & rs("id") & """ value=""" & rs1("centre") & """" & checked & ">" & rs1("centre")
				delim = " | "
				rs1.movenext
			loop
			rs1.close
		else
			response.write "&nbsp;"
		end if
		response.write "</td>"
		response.write "</tr>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	set rs1 = nothing
	db.Close
	set db = nothing
%>
    <tr>
      <td colspan="3"><div align="center">
          <input name="$id" type="hidden" id="$id" value="<%=id%>">
          <input name="submit" type="submit" id="submit" value="Submit">
        </div></td>
    </tr>
  </form>
</table>
</BODY>
</HTML>
