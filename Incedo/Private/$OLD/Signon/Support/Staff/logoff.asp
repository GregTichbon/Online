<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	with rs
		.Open "[session]", db, 1, 2
		.filter = "id = " & session("chatid")
		.fields("endtime") = now()
		.update
		.close
	end with
	set rs = nothing
	db.close
	set db = nothing
	session("chatid") = ""
	session("chatnickname") = ""

%>
<HTML>
<HEAD>
<script language="JavaScript">
{close();}
</SCRIPT>
</HEAD>
<BODY>
</BODY>
</HTML>