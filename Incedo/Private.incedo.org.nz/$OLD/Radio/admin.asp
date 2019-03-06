<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	
	if request.form("$submit") <> "" then
		Set rsu = Server.CreateObject("ADODB.RecordSet")
		with rsu
			.Open "params", db, 1, 2
			For Each key in Request.Form
				if left(key,1) <> "$" then
					.filter = "key = '" & key & "'"
					if request.form("$seq" & key) = "-1" then
						.delete
					else
						if .eof then
							.addnew
							.fields("key") = key
						end if
						.fields("data") = request.form(key)
						if isnumeric(request.form("$seq" & key)) then
							.fields("seq") = request.form("$seq" & key)
						end if
						.update
					end if
				end if
			next
			if request.form("$keynew") <> "" then
				.addnew
				.fields("key") = request.form("$keynew")
				.fields("data") = request.form("$datanew")
				if isnumeric(request.form("$seqnew")) then
					.fields("seq") = request.form("$seqnew")
				end if
				.update
			end if
			.close
		end with
		set rsu = nothing
	end if
	
	
	
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo</title>
<style>
.outerbox {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	background-color: #FFFFFF;
	width: 780px;
	border: thin solid #000000;
}
</style>
</head>
<body background="../../images/background.gif">
<div align="center">
  <div class="outerbox">
    <h1>Radio Incedo</h1>
    <form action="admin.asp" method="post" name="radio">
	<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000" width="100%">
	<tr><td>Key</td><td>Data</td><td>Seq<br>-1 to delete</td></tr>
 <%
	sql = "select * from params order by seq"
	rs.open sql,db
	do until rs.eof
		response.write "<tr><td width=""160"" align=""right"" nowrap>" & rs("key") & "</td><td><textarea rows=""4"" name=""" & rs("key") & """ id=""" & rs("key") & """ style=""width:98%"">" & rs("data") & "</textarea></td><td><input name=""$seq" & rs("key") & """ type=""text"" id=""$seq" & rs("key") & """ value=""" &  rs("seq") & """ style=""width:30px""</td></tr>"
		rs.movenext
	loop
	rs.close
%>
		<tr>
		  <td width="160" align="right" nowrap>New
	      <input name="$keynew" type="text" id="$keynew"></td><td><textarea rows="4" name="$datanew" id="$datanew" style="width:98%"></textarea></td><td><input name="$seqnew" type="text" id=""$seqnew" value="" style="width:30px"></td></tr>
      <tr>
        <td colspan="3"><input name="$submit" type="submit" id="$submit" value="Submit"></td>
      </tr>
      <tr>
        <td colspan="3"><a href="polllist.asp">Show Polls </a>| <a href="editdiscussion.asp">Edit Discussion</a> </td>
      </tr>
	  </table>
    </form>
  </div>
</div>
<script type="text/javascript" language="JavaScript" src="http://www.incedo.org.nz/statistics/stats_js.asp"> </script>
</body>
</html>
<%
	set rs = nothing
	db.close
	set db = nothing
%>
