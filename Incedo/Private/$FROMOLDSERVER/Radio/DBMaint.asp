<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<%
if request.form("$submit") <> "" then
	'set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\incedo\radio.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	'strSQL = "UPDATE sqllog SET [description] = 'Unknown' WHERE [description] Is Null"
	
	strSQL = mid(request.form("sql"),2,9999)
	if lcase(left(strSQL,7)) = "select " then
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.open strSQL, db
		if not rs.EOF then
			Response.Write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"">"
			records = true
		end if
		do until rs.eof
			response.write "<tr>"
			for each fld in rs.fields
				response.write "<td nowrap>" & fld & "&nbsp;</td>"
			next
			response.write "</tr>"
			rs.movenext
		loop
		if records = true then
			Response.Write "</table>"
		end if
		rs.close
		set rs = nothing
	else
		db.Execute strSQL
		response.write "<strong><font color=""#FF0000"">" & strSQL & " done at: " & now() & "</font></strong>"
	end if
	
	 
	db.Close 
	set db = nothing
end if
%>

<form action="dbmaint.asp" method="post" name="dbmaint" id="dbmaint">
  <p>Alter table <em>tablename</em> &lt;ADD | ALTER&gt; COLUMN <em>ColumnName</em> &lt;TEXT(<em>length</em>) | CURRENCY | INT | MEMO | YESNO&gt; COUNTER </p>
  <p>Alter table <em>tablename</em> DROP COLUMN <em>ColumnName</em></p>
  <p>Create table <em>tablename</em> (<em>ColumnName</em> &lt;TEXT(<em>length</em>) | CURRENCY | INT | MEMO | YESNO&gt; COUNTER)</p>
  <p>SQL: 
    <textarea name="sql" cols="60" rows="5"></textarea>
  </p>
  <p>
    <input name="$submit" type="submit" id="$submit" value="Submit">
</p>
</form>
</body>
</html>



