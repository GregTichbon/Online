<html>
<head>
<title>Wanganui Sports Centre Administration</title>
</head>
<body>
    <h1>SIGNON</h1>
<%if 1=2 and request.querystring("override") = "" then%>
      The Database is unable to be maintained at the moment.  Please try again later.<br><br><a href="">Main Page</a>
<%else%>
    <form name="signon" method="post" action="signon_process.asp">
          Password
          <input name="password" type="password" id="password">
      <input type="submit" name="$submit" value="Submit">
    </form>
<%end if%>
</body>
</html>
