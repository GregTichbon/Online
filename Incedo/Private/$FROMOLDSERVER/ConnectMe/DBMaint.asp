<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
%>	
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<%
if request.form("$submit") <> "" then
	'set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\connectme.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	'strSQL = "UPDATE sqllog SET [description] = 'Unknown' WHERE [description] Is Null"
	
	strSQL = mid(request.form("sql"),2,9999)
	db.Execute strSQL
	
	 
	db.Close 
	set db = nothing
	response.write "<strong><font color=""#FF0000"">" & strSQL & " done at: " & now() & "</font></strong>"
end if
%>
<form action="DBMaint.asp" method="post" name="dbmaint" id="dbmaint">
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



