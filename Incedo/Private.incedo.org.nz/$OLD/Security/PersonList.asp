<HTML>
<HEAD>
<title>Incedo Security</title>
</HEAD>
<BODY>
<form name="personlist" method="post" action="person.asp">
  <select name="id" size="1" id="id">
    <option>----Please Select---</option>
    <%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * from people order by lastname, firstname"
	rs.Open sql, db
	do until rs.EOF
		response.write "<option value=""" & rs("id") & """>" & rs("lastname") & ", " & rs("firstname") & "</option>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
%>
  </select>
  <input type="submit" name="Submit" value="Submit">
</form>
<p><a href="default.asp">Security Menu</a> </p>
</BODY>
</HTML>
