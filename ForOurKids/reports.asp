<HTML><HEAD><title>Reports</title></HEAD>
<BODY>
<%
	mydatabase = "e:\$Generic\ForOurKids\ForOurKids.mdb"
	mydatabasecontrol = "nursed"
	
	Response.Write "<script>" & vbcrlf
	Response.write "var d = new Array();" & vbcrlf
	Response.write "var s = new Array();" & vbcrlf
	Response.write "var c = new Array();" & vbcrlf
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\ForOurKids\ForOurKids.mdb"
		
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	cnt = 0
	with rs
		.Open "reportslog", db, 1, 2
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




<form name="frm" method="post" action="reports_process.asp" onsubmit="return verifyform()">
  <p>Description <br>
    <INPUT name="desc" size=100 value=""> <br>
    <input type="hidden" name="id" value="">
    <input type="hidden" name="database" value="<%=mydatabase%>">
    <input type="hidden" name="databasecontrol" value="<%=mydatabasecontrol%>">
  <p>Sql Statement <br>
    <textarea name="sql" cols="100" rows="10"></textarea>
    <br>
  </p>
  <table width="400" border="1" cellpadding="8" cellspacing="0" bordercolor="#000000">
    <tr>
      <td><div align="center">
        <input type="radio" name="sord" value="change">
        Change
          
      </div></td>
      <td><div align="center">
        <input type="radio" name="sord" value="add">
        Add
          
      </div></td>
      <td><div align="center">
        <input type="radio" name="sord" value="delete">
        Delete
          
      </div></td>
    </tr>
    <tr>
      <td><div align="center">
        <input type="checkbox" name="execute" value="yes" checked>
        Execute
          
      </div></td>
      <td><div align="center">
        <input type="checkbox" name="dump" value="yes">
        Dump to File
          
      </div></td>
      <td><div align="center">
        <input type="submit" name="submit" value="Submit">
      </div></td>
    </tr>
  </table>
  <p>    <input type="hidden" name="opt" value="">
  </p>
</form>
<script>
	showselects()
</script>
</BODY>
</HTML>
