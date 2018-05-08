<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	set rs = nothing
	db.close
	set db = nothing

	set di = server.createobject("DI.IIS")
	uniqueid = Request.Cookies("uniqueid")
	if uniqueid = "" then
		uniqueid = di.di_format(now(),"yyyymmddhhnn") & session.sessionid
	end if
	Response.Cookies("uniqueid")= uniqueid
	Response.Cookies("uniqueid").Expires = Date() + 365
	names = Request.Cookies("names")

	admin = request.querystring("admin")
	hide = request.querystring("hide")
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
	padding: 10px;
}
</style>
<script type="text/javascript" src="ajax/ajax.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<form name="chat">
<input type="hidden" name="uniqueid" id="uniqueid" value="<%=uniqueid%>">
<input type="hidden" name="admin" id="admin" value="<%=admin%>">
<input type="hidden" name="hide" id="hide" value="<%=hide%>">
<input type="hidden" name="userid" id="userid" value="<%=session("Incedo_MemberID")%>">
<div align="center">
  <div class="outerbox">
      <h1> Incedo Chat</h1>
      <hr>
<%if hide = "" then%>
          <p align="left">&nbsp;</p>
<%else%>
<input type="hidden" name="names" id="names" value="">
<%end if%>
            <div id="currentinfo"><br>
      </div>
			<div align="right" id="discussioninput" style="display:<%=discussiondisplay%>">
				<textarea name="comment" rows="3" id="comment" style="width:99%"></textarea>
				<br>
				<input name="$submit" type="button" id="$submit" value="Submit" onclick='currentinfo(1);'>
      </div>
			</p>
		  <div id="discussion"></div>
            <p>&nbsp;</p>
</div>
</div>
</form>
<script language="javascript">
setInterval('currentinfo(0)', 2000)
</script>
</body>
</html>
