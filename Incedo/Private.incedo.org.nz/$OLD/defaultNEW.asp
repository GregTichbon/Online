<%
	if session("Incedo_MemberID")= "" and 1=2 then
		response.redirect "signon"
	end if
	set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	Set rs = Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo Private Menu</title>
<script type="text/javascript" src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js"></script>
<script type="text/javascript" src="../javascript/byrei-dyndiv/byrei-dyndiv_0.8.js"></script>
<script language="JavaScript" type="text/JavaScript">

function test() {
	alert 'here');
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
var months="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec".split(",");
var days="Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday".split(",");
function formatdatetime() {
	now = new Date();
	daynumber = now.getDate();
	dayname = days[now.getDay()];
	month = months[now.getMonth()];
	year = now.getFullYear();
	hour = now.getHours();
	min = now.getMinutes();
	sec = now.getSeconds();
	if (min <= 9) {
		min = "0" + min;
	}
	if (sec <= 9) {
		sec = "0" + sec;
	}
	if (hour > 12) {
		hour = hour - 12;
		add = " pm";
	} else {
		hour = hour;
		add = " am";
	}
	if (hour == 12) {
		add = " pm";
	}
	if (hour == 00) {
		hour = "12";
	}
	document.getElementById('datetime').innerHTML = dayname + ' ' + daynumber + ' ' + month + ' ' + year + '<br>' + ((hour<=9) ? "0" + hour : hour) + ":" + min + ":" + sec + add;
}
function getdivparams() {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++){                      
		var mydiv = divs[i];
		if(mydiv.id.substring(0,4) == 'test') { 
			alert(mydiv.id + '\n' + 'Left=' + mydiv.style.left + '\n' + 'Top=' + mydiv.style.top + '\n' + 'Width=' + mydiv.style.width + '\n' + 'Height=' + mydiv.style.height);
		}
		
	}
}

</script>
<link rel="stylesheet" type="text/css" href="../javascript/byrei-dyndiv/byrei-dyndiv_0.5.css">
<style type="text/css">
#test1a, #test1b, #test1c, #test1d {
	background: #ccc;
	border: 1px solid #aaa;
	position: absolute;
	overflow: hidden;
} 

.dynDiv_setLimit {
	position: relative;
}

#test2a, #test2b, #test2c, #test2d {
	width: 150px;
	height: 150px;
	right: 10px;
	top: 120px;
	border: 1px solid #aaa;
	position: absolute;
	overflow: hidden;
	text-align: center;
	background: #aaa;
	filter:alpha(opacity=50);
	opacity:0.5;
	color: #000;
}
</style>
</head>
<body>
<script language="JavaScript" type="text/JavaScript">

alert('here');
if (window.addEventListener) { //DOM method for binding an event
	window.addEventListener("load", test, false);
	alert(1);
}	
else {
	if (window.attachEvent) { //IE exclusive method for binding an event
		window.attachEvent("onload", test);
		alert(2);
	}
	else {
		if (document.getElementById) { //support older modern browsers
			window.onload=test();
			alert(3);
		}
	}
}
</script>
<div id="test1d">
  <div class="dynDiv_moveParentDiv" align="center">MAIN MENU
    <div class="dynDiv_minmaxDiv">[x]</div>
  </div>
  <div style="padding:10px;">
<p><a href="Documents">Documents</a><br>
            <a href="Forum/">Forums</a><br>
            <a href="noticeboard">Notice Board</a> <br>
            <a href="people">People</a><br>
            <a href="Supporters">Supporters</a><br>
            <a href="connectme">ConnectMe</a><br>
            <a href="thoughts">Thoughts</a><br>
            Pages<br>
            <a href="prayer">Prayer</a><br>
            <a href="Email">Members Email</a><br>
            <a href="FAQ">FAQ</a><br>
            <a href="Radio">Radio<br>
            </a><a href="Polls">Polls</a><br>
            <a href="FeaturedLinks">Featured Links</a> <br>
            Links<br>
            Events<br>
            <a href="news">News</a><br>
            <a href="Security">Security</a> <br>
            <a href="Signon">Sign out</a></p>

  </div>
  <div class="dynDiv_resizeDiv_br"></div>
</div>
<div id="test1a">
  <div class="dynDiv_moveParentDiv" align="center">&nbsp;&nbsp;&nbsp;TIME&nbsp;&nbsp;&nbsp;
    <div class="dynDiv_minmaxDiv">[x]</div>
  </div>
  <div style="padding:10px;"><p>
  <div id="datetime" align="center"></div></p>
  </div>
</div>


<div id="test1b" style="height:100px; width:100px">
  <div class="dynDiv_moveParentDiv" align="center">&nbsp;&nbsp;&nbsp;3X3X3 Prayer Items&nbsp;&nbsp;&nbsp;
    <div class="dynDiv_minmaxDiv">[x]</div>
  </div>
  <div style="padding:10px;"><p>
	<%
		sql = "SELECT * from DailyTxt WHERE [Date] Between Date()-7 And Date() order by [date] Desc"
	rs.open sql, db
	hr = ""
	do until rs.eof
		response.write hr & di.di_format(rs("date"),"dd mmm yy") & " - " & rs("message")
		hr = "<hr>"
		rs.movenext
	loop
	rs.close
%>
</p></div>
  <div class="dynDiv_resizeDiv_br"></div>
</div>

<%
	set rs = nothing
	db.close
	set db = nothing
	set di = nothing
%>
<input type="submit" name="Submit" value="Submit" onClick="getdivparams();">
<script type="text/javascript" src="../ajax/poll.js"></script>
<script language="javascript">
//setInterval("formatdatetime()", 1000);
/*
var db = 'e:/$generic/incedo/incedo.mdb';
var sqlreport = 'SELECT "<tr><td>" & IIf([knownas] Is Null,[firstname],[knownas]) & " " & [lastname] & "</td></tr>" AS Name FROM People WHERE DateDiff("s",[LastPolled],Now())<60 ORDER BY "<tr><td>" & IIf([knownas] Is Null,[firstname],[knownas]) & " " & [lastname] & "</td></tr>"';
var sqlupdate = 'update people set lastpolled = now() where id = <%=session("Incedo_MemberID")%>';
poll(db,sqlreport,sqlupdate);
setInterval("poll(db,sqlreport,sqlupdate)", 30000);
*/
</script>
</body>
</html>
