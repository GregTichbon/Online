<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "Select * from params where key = 'Station Address'"
	rs.open sql,db
	if not rs.eof then
		stationaddress = rs("data")
	end if
	rs.close
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
	if names <> "" then discussiondisplay = "" else discussiondisplay = "none"

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
<script>
<%if hide = "" then%>
function nameentered() {
	if(document.getElementById('names').value == '') {
		document.getElementById('discussioninput').style.display = 'none';
	}
	else {
		document.getElementById('discussioninput').style.display = '';
	}
}
<%end if%>
</script>
</head>
<body background="../../images/background.gif">
<form name="radio">
<input type="hidden" name="uniqueid" id="uniqueid" value="<%=uniqueid%>">
<input type="hidden" name="admin" id="admin" value="<%=admin%>">
<input type="hidden" name="hide" id="hide" value="<%=hide%>">
<div align="center">
  <div class="outerbox">
      <h1>Radio Incedo<img src="../../images/INCEDOLOGO.gif" width="194" height="293" hspace="10" vspace="0" border="0" align="right" class="image"></h1></h1>
          <p align="left">Welcome to Radio Incedo.</p>
          <p align="left">Radio Incedo is a talkback format internet based radio show.</p>
          <p align="left">Please feel free to call in and make your comments.</p>
          <p align="left">You can also make comments in the discussion box below.</p>
          <p align="left">There may also be polls that you can vote in. </p>
      <p align="left">Incedo Radio can take calls on
        <script type="text/javascript" src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js"></script> 
          SKYPE.
&nbsp;If you don't have the latest Skype installed please do so <a href="http://www.skype.com/go/downloading" target="_blank">here</a> </p>
          <p align="left">You may also contact us on MSN</p>
          <p align="left">Please enter your name(s) below.</p>
          <p align="left"> Please turn off your online radio reception when on a call.</p>
          <hr>
<%if hide = "" then%>
          <p align="left">What's your name(s) (You need to enter this to be allowed to enter the discussion and vote in the polls)
            <textarea name="names" id="names" rows="3" style="width:99%" onKeyUp="javascript:nameentered();"><%=names%></textarea>
          </p>
<%else%>
<input type="hidden" name="names" id="names" value="">
<%end if%>
          <%=stationaddress%>
            <div id="currentinfo"></div>
			<p align="center"><strong>Discussion</strong><br>
            <div align="right" id="discussioninput" style="display:<%=discussiondisplay%>">
				<textarea name="comment" rows="3" id="comment" style="width:99%"></textarea>
				<br>Submit: <input type="checkbox" name="submitcomment" value="yes">
            </div>
			</p>
		  <div id="discussion"></div>
            <p>&nbsp;</p>
</div>
</div>
</form>
<script language="javascript">
setInterval('currentinfo()', 2000)
</script>
<script type="text/javascript" language="JavaScript" src="http://www.incedo.org.nz/statistics/stats_js.asp"> </script>
</body>
</html>



