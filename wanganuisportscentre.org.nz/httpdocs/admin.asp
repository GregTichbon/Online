<%
	if session("wcsc-signedon") = "" then
		response.redirect "signon.asp"
	end if
%>
<html>
<head>
<title>Wanganui Sports Centre Administration Menu</title>
</head>
<body>
    ADMINISTRATION MENU
	<p><a href="pagelist.asp">Maintain Pages</a></p>
	<!--<hr width="300">
    <p><a href="sql.asp">Query Database</a>  </p>-->
    <p><a href="signout.asp">Sign Out </a> </p><br>
</body>
</html>