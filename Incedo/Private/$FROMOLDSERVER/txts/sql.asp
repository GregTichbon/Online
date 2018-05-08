<HTML><HEAD><title>TXT SQL</title></HEAD>
<BODY bgcolor="#99FFFF">
<%
	area = "TXT"
	database = "e:\$generic\yfcnz\txtmessages.mdb"
	Response.Write "<script>" & vbcrlf
	Response.write "var d = new Array();" & vbcrlf
	Response.write "var s = new Array();" & vbcrlf
	Response.write "var c = new Array();" & vbcrlf
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\YFCNZ\SQL.mdb"
		
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	cnt = 0
	with rs
		.Open "sqllog", db, 1, 2
		do until .EOF
			if .fields("area") = "TXT" then 
				cnt = cnt + 1
				Response.Write "d[" & cnt & "] = """ & .fields("description") & """;" & vbcrlf
				Response.Write "s[" & cnt & "] = """ & replace(.fields("statement"),vbcrlf," ") & """;" & vbcrlf
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

		var sqlresolved;
		var spos = 0;
		var epos;
		var ans;
		sqlresolved = document.frm.sql.value;
		do {
			spos = sqlresolved.indexOf("??");
			if (spos > -1) {
				epos = sqlresolved.indexOf("??",spos + 2);
				ans = prompt(sqlresolved.substring(spos + 2,epos),'');
				sqlresolved = sqlresolved.replace(sqlresolved.substring(spos,epos + 2),ans)
			}		
		}
		while (spos != -1);
		document.frm.sqlresolved.value = sqlresolved;
	}
	
</script>




<form name="frm" method="post" action="sql_results.asp" onsubmit="return verifyform()">
  <input type="hidden" name="area" value="<%=area%>">
  <input type="hidden" name="database" value="<%=database%>">
  <input type="hidden" name="sqlresolved" value="">
  <p>Description <br>
    <INPUT name="desc" size=100 value=""> <br>
    <input type="hidden" name="id" value="">
  <p>Sql Statement <br>
    <textarea name="sql" cols="100" rows="10"></textarea>
    <br>
  </p>
  <table border="1" cellpadding="5" bordercolor="#000000" width="450" align="left">
    <tr> 
      <td width="150" align="center">Change 
        <input type="radio" name="sord" value="change">
      </td>
      <td width="150" align="center">Add 
        <input type="radio" name="sord" value="add">
      </td>
      <td width="150" align="center">Delete 
        <input type="radio" name="sord" value="delete">
      </td>
    </tr>
    <tr> 
      <td width="150" align="center">Dump to File 
        <input type="checkbox" name="dump" value="yes">
      </td>
      <td width="150" align="center">Execute 
        <input type="checkbox" name="execute" value="yes" checked>
      </td>
      <td width="150" align="center"> 
        <input type="submit" name="submit" value="Submit">
      </td>
    </tr>
  </table>
  <p>
    <input type="hidden" name="opt" value="">
    <br>
  </p>
  <br>
  <br>
  <br>
  <br>
</form>
<script>
	showselects()
</script>
</BODY>
</HTML>



