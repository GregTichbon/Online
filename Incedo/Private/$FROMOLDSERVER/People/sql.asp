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
<HTML><HEAD><title>People SQL</title></HEAD>
<BODY bgcolor="#99FFFF">
<%
	mydatabase = "C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	mydatabasecontrol = "yfcpeople"
	
	Response.Write "<script>" & vbcrlf
	Response.write "var d = new Array();" & vbcrlf
	Response.write "var s = new Array();" & vbcrlf
	Response.write "var c = new Array();" & vbcrlf
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\sql.mdb"
		
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	cnt = 0
	with rs
		.Open "sqllog", db, 1, 2
		do until .EOF
			if .Fields("dbcontrol") = mydatabasecontrol then
				cnt = cnt + 1
				Response.Write "d[" & cnt & "] = """ & replace(.fields("description"),"""","'") & """;" & vbcrlf
				Response.Write "s[" & cnt & "] = """ & replace(replace(.fields("statement"),vbcrlf," "),"""","'") & """;" & vbcrlf
				Response.Write "c[" & cnt & "] = """ & .fields("id") & """;" & vbcrlf
			end if
			.MoveNext
		loop
		.Close 
	end with
	set rs = nothing
	db.Close
	set db = nothing
%>  

	function showselects()
	{
		for (i = 1; i < d.length; ++ i) {
			document.write ("<a onclick=selectline(d[" + i + "],s[" + i + "],c[" + i + "]) href=#><b>" + d[i] + "</b></a><br>");
			document.write (s[i] + "</p>");
		}
	}
	
	function selectline(pass_desc,pass_sql,pass_id)
	{
		document.frm.desc.value = pass_desc;
		document.frm.sql.value = pass_sql;
		document.frm.id.value = pass_id;
		document.frm.sql.focus();
		return false;
	}
	
	function verifyform()
	{
		var selected = ""
		for (i = 0; i < document.frm.sord.length; ++ i) {
			if (document.frm.sord[i].checked) {
				selected = document.frm.sord[i].value;
			}
			document.frm.sord[i].checked = false;
		}
		document.frm.opt.value = selected;
		
		if (document.frm.desc.value == "" && selected != "") {
			alert("Description Required");
			document.frm.desc.focus();
			return false;
		}
		
		if (document.frm.sql.value == "") {
			alert("Sql Statement Required");
			document.frm.sql.focus();
			return false;
		}
	}
	
</script>




<form name="frm" method="post" action="sql_results.asp" onsubmit="return verifyform()">
  <p>Description <br>
    <INPUT name="desc" size=100 value=""> <br>
    <input type="hidden" name="id" value="">
    <input type="hidden" name="database" value="<%=mydatabase%>">
    <input type="hidden" name="databasecontrol" value="<%=mydatabasecontrol%>">
  <p>Sql Statement <br>
    <textarea name="sql" cols="100" rows="10"></textarea>
    <br>
    Execute 
    <input type="checkbox" name="execute" value="yes" checked>
    Change 
    <input type="radio" name="sord" value="change">
    Add 
    <input type="radio" name="sord" value="add">
    Delete 
    <input type="radio" name="sord" value="delete">
    Dump to File 
    <input type="checkbox" name="dump" value="yes">
    <input type="hidden" name="opt" value="">
    <input type="submit" name="submit" value="Submit">
  </p>
  </form>
<script>
	showselects()
</script>
</BODY>
</HTML>



