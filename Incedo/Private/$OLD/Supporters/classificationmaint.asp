<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if

	id = request.querystring("id")
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	if id <> "new" then
		sql = "SELECT * FROM regions_classifications where id = " & id
		rs.Open sql, db
		if not rs.eof then
			region = rs.fields("region") & ""
			classification = rs.fields("classification") & ""
		end if
		rs.close
	end if
%>
<html>
<head>
<title>Incedo Supporters</title>
<script type="text/javascript" src="Javascript/validateEmail.js"></script>
<script language="JavaScript">
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;
	if(frm.region.value == '') {
		msg = msg + delim + ' - Region';
		delim = '\n';
	}
	if(frm.classification.value == '') {
		msg = msg + delim + ' - Classification';
		delim = '\n';
	}

	if(msg != '') {
		alert('You must enter valid information for the following:\n' + msg);
		return(false);
	}
}

</script>
<style type="text/css">
<!--
.fields {
	width: 100%;
}
-->
</style>
</head>
<body>
<div align="center">
    <form name="maint" method="post" action="classificationmaint_process.asp" OnSubmit="return checkform();">
	<input name="id" type="hidden" id="id" value="<%=id%>">
    <table border="1" cellspacing="0" cellpadding="5" width="600">
        <tr>
          <td width="150"><div align="right">Region</div></td>
          <td><select name="region" size="1" id="region">
            <option value="">---Please Select---</option>
            <%
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * FROM regions order by region"
	rs1.Open sql, db
	do until rs1.eof
		thisregion = rs1("region")
		if region = thisregion then
			selected = " selected"
		else
			selected = ""
		end if
		response.write "<option value=""" & thisregion & """" & selected & ">" & thisregion & "</option>"
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
%>
          </select></td>
        </tr>
        <tr>
          <td width="150"><div align="right">Classification</div></td>
          <td><input name="classification" type="text" class="fields" id="classification" value="<%=classification%>" size="20"></td>
        </tr>
	  </table>
<br>
<input name="$reset" type="reset" id="$reset" value="Reset">
          <input name="$submit" type="submit" id="$submit" value="Submit">
<%
if id <> "new" and 1=2 then
%>		
          <input name="$delete" type="submit" id="$delete" value="Delete">
<%
end if
%>
  </form>
  </div>

<%
	set rs = nothing
	db.close
	set db = nothing
%>
</div>
</body>
</html>

