<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	Set rs2 = Server.CreateObject("ADODB.RecordSet")
	
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
        <a href="pollmaint.asp?id=new">Create a new Poll</a>
        <%
	response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"" width=""100%"">"
	response.write "<tr><td>Date/Time</td><td>Proposition</td><td>Active</td><td>Show Results</td><td>Edit</td></tr>"
	sql = "select * from poll order by datetime DESC"
	rs.open sql,db
	do until rs.eof
		response.write "<tr><td>" & rs("datetime") & "</td><td>" & rs("proposition") & "</td><td>" & rs("active") & "</td><td>" & rs("showresults") & "</td><td><a href=""pollmaint.asp?id=" & rs("pollid") & """>Edit</a></td></tr>"
		sql = "select * from polloptions where poll = " & rs("pollid") & " order by seq"
		rs2.open sql,db
		polloptions = ""
		delim = ""
		do until rs2.eof
			polloptions = polloptions & delim & rs2("Answer")
			delim = "<br>"
			rs2.movenext
		loop
		rs2.close
		response.write "<tr><td colspan=""5"" align=""left"">" & polloptions & "</td></tr>"
		rs.movenext 
	loop
	rs.close
		response.write "<tr><td colspan=""5"" align=""centre""><a href=""admin.asp"">Return to Admin Menu</a></td></tr>"
%>
  </div>
</div>
<script type="text/javascript" language="JavaScript" src="http://www.incedo.org.nz/statistics/stats_js.asp"> </script>
</body>
</html>
<%
	set rs2 = nothing
	set rs = nothing
	db.close
	set db = nothing
%>



