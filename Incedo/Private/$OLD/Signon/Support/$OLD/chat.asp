<%
	'connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\onlinesupport.mdb;"
	'Set db = Server.CreateObject("ADODB.Connection")
	'db.Open connection_string
	'Set rs = Server.CreateObject("ADODB.RecordSet")
	'set rs = nothing
	'db.close
	'set db = nothing

	set di = server.createobject("DI.IIS")
	uniqueid = Request.Cookies("uniqueid")
	if uniqueid = "" then
		uniqueid = di.di_format(now(),"yyyymmddhhnn") & session.sessionid
	end if
	Response.Cookies("uniqueid")= uniqueid
	Response.Cookies("uniqueid").Expires = Date() + 365
	name = Request.Cookies("name")

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
</head>
<body background="../../images/background.gif">
<form name="chat">
  <input type="hidden" name="uniqueid" id="uniqueid" value="<%=uniqueid%>">
  <input type="hidden" name="names" id="names" value="<%=name%>">
  <div align="center">
    <div class="outerbox">
      <h1> Incedo Online Support </h1>
      <div id="messages"></div>
      <textarea name="message" rows="3" id="message" style="width:99%"></textarea>
      <br>
      <input name="submit" type="submit" id="submit" value="Submit">
    </div>
  </div>
</form>
<script language="javascript">
setInterval('refresh()', 2000)
</script>
</body>
</html>
