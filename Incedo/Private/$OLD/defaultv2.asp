<%
	if session("Incedo_MemberID")= "" then
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
<script language="JavaScript" type="text/JavaScript">
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
</script>
<style type="text/css">
* {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: x-small;
}
.maindiv {
	position:absolute;
	overflow: auto;
	border: thin solid #000000;
	background-color: #FAD3F9;
	z-index: 2;
}
.titlediv {
	position:relative; 
	left:0px; 
	top:0px;
	width:100%; 
	height:23px;
	background-color: #CAD3F9;
	font-size: small;
}
</style>
</head>
<body>
<div id="col1" style="position:absolute; width:265px; height:100%; left: 0px; top: 0px; background-color: #FFFF00; layer-background-color: #FFFF00; border: 1px none #000000; z-index:1">
  <div style="height:115px; top: 0px;" class="maindiv">
    <div class="titlediv"><b>Main Menu</b></div>
    <p><a href="Documents/Default.asp">Documents</a><br>
      <a href="Forum/">Forums</a><br>
      <a href="noticeboard">Notice Board</a> <br>
      <a href="people">People</a><br>
      <a href="Supporters/default.asp">Supporters</a><br>
      <a href="connectme/default.asp">ConnectMe</a><br>
      <a href="thoughts">Thoughts</a><br>
      <a href="Videos/">Videos</a><br>
      Pages<br>
      <a href="prayer/default.asp">Prayer</a><br>
      <a href="Email/default.asp">Members Email</a><br>
      <a href="faq">FAQ</a><br>
      <a href="Radio">Radio<br>
      </a><a href="Polls">Polls</a><br>
      <a href="FeaturedLinks/">Featured Links</a> <br>
      Links<br>
      Events<br>
      <a href="news">News</a><br>
      <a href="Security">Security</a> <br>
      <a href="Signon/default.asp">Sign out</a></p>
  </div>
</div>
<div id="col2" style="position:absolute; width:265px; height:100%; left: 266px; top: 0px; background-color: #FFCC00; layer-background-color: #FFFF00; border: 1px none #000000; z-index:1">
  <div id="links" style="height:187px; top:405px; background-color:#00FF00" class="maindiv">
    <div class="titlediv"><b>Personal Links</b></div>
    <%
	sql = "select * from people_links where person = " & session("Incedo_MemberID")
	rs.open sql, db
	br = ""
	do until rs.eof
		response.write br & "<a href=""http://" & rs("link") & """ target=""_blank"">" & rs("description") & "</a>"
		br = "<br>"
		rs.movenext
	loop
	rs.close
%>
  </div>
<div id="3x3x3" style="height:115px; left: 266px; top: 384px;" class="maindiv">
  <div class="titlediv"><b>Most Recent Daily (3x3x3) Texts</b></div>
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
</div>
<div style="height:115px; top: 244px; left: 266px;" class="maindiv">
  <div class="titlediv"><b>Current Prayer Items</b></div>
  <%
	sql = "SELECT Title, Narrative, Category FROM PrayerItem  INNER JOIN PrayerCategory ON PrayerItem.CategoryID = PrayerCategory.CategoryID WHERE ExpireOn >= Date() ORDER BY PrayerItem.DateTime"
'response.write sql
	rs.open sql, db
	hr = ""
	do until rs.eof
		response.write hr & rs("Category") & " - " & rs("Title") & "<br>" & rs("narrative")
		hr = "<hr>"
		rs.movenext
	loop
	rs.close
%>
</div>
<%
	sql = "SELECT top 1 id, profile, iif(knownas is null,firstname,knownas) as name, lastname, email, birthday, skype FROM People " & _
		  "WHERE profile is not null and membershipdate Is Not Null AND (AppointmentCeased Is Null Or AppointmentCeased>Date()) " & _
		  "ORDER BY IIf(lastprofiled=Date(),#1/01/1900#,iif(LastProfiled is null,#1/01/1901#,lastprofiled)), firstname, lastname"
'response.write sql
'response.end
	rs.open sql, db
	if not rs.eof then
		if rs("skype") <> "" then
			skype = " Skype: <a href=""skype:" & rs("skype") & "?call""><img src=""http://mystatus.skype.com/smallicon/greg_tichbon"" style=""border: none;"" width=""16"" height=""16"" alt=""My status""></a>"
		else
			skype = ""
		end if
		name = "<a href=""mailto:" & rs("email") & """>" & rs("name") & " " & rs("lastname") & "</a>" & skype
%>
<div style="height:187px; top: 524px; left: 266px;" class="maindiv">
  <div class="titlediv"><b>Member of the day - <%=name%></b></div>
  <%

		'response.write rs("firstname") & " " & rs("lastname") & "<br>"
		response.write "<a href=""people/photos/h400/" & rs("id") & ".jpg"" target=""_blank""><img src=""people/photos/thumbnails/" & rs("id") & ".jpg"" border=""0"" hspace=""5"" vspace=""5"" align=""left""></a>"
		'response.write "Birthdate: " & di.di_format(rs("birthday"),"dd mmmm") & "<br>"
		'response.write "<a href=""mailto:" & rs("email") & """>" & rs("email") & "</a><br>"
		response.write rs("profile")
		sql = "update people set lastprofiled = date() where id = " & rs("id")
		db.execute sql
%>
</div>
<%		
	end if
	rs.close
%>
<div style="height:115px; top: 736px; left: 266px;" class="maindiv">
  <div class="titlediv"><b>Featured Links</b></div>
  <%
	sql = "SELECT * FROM featuredlinks where InternalFeatureFrom <= date() and InternalFeatureTo >= date() order by InternalFeatureFrom"
	rs.open sql, db
	hr = ""
	do until rs.eof
		response.write hr & rs("description") & "<br><a href=""featuredlink.asp?" & rs("link") & """ target=""_blank"">" & rs("link") & "</a>"
		hr = "<hr>"
		rs.movenext
	loop
	rs.close
%>
</div>
<div style="height:115px; top: 877px; left: 266px;" class="maindiv">
  <div class="titlediv"><b>Members Birthdates</b></div>
  <%
	sql = "SELECT IIf([knownas] Is Not Null,[knownas],[firstname]) & ' ' & lastname AS name, Centre, email, mobile, skype, Format([birthday],'dd mmm') as birthdate FROM People where birthday <> null and membershipdate <> null and category <> 'ceased' and CDate(Format(now(),'dd mmm ') & '2000') between CDate(Format([birthday],'dd mmm ') & '2000')-7 and CDate(Format([birthday],'dd mmm ') & '2000')+7  ORDER BY IIf(CDate(Format([birthday],'dd mmm ') & '2000')+7>=CDate(Format(Now(),'dd mmm ') & '2000'),0,1), CDate(Format([birthday],'dd mmm ') & '2000')"
	rs.open sql, db
	if not rs.eof then
		response.write "<table>"
		do until rs.eof
			if rs("skype") <> "" then
				skype = "Skype: <a href=""skype:" & rs("skype") & "?call""><img src=""http://mystatus.skype.com/smallicon/greg_tichbon"" style=""border: none;"" width=""16"" height=""16"" alt=""My status""></a>"
			else
				skype = "&nbsp;"
			end if
			response.write "<tr><td>" & rs("name") & "</td><td>" & rs("birthdate") & "</td><td>" & rs("centre") & "</td><td><a href=""mailto:" & rs("email") & """>" & rs("email") & "</a></td><td>" & rs("mobile") & "</td><td>" & skype & "</td></tr>"
			rs.movenext
		loop
		response.write "</table>"
	end if
	rs.close
%>
</div>
<div id="online" style="height:115px; top: 1260px; left: 567px;" class="maindiv">
  <div class="titlediv"><b>Who's online</b></div>
</div>
<div style="height:115px; top: 1017px; left: 266px;" class="maindiv">
  <div class="titlediv"><b>Who's been online</b></div>
  <%
	sql = "select iif(knownas is null,firstname,knownas) as name, lastname, lastloggedon from people where lastloggedon is not null order by lastloggedon desc"
	'---------Option to go to MSN, Skype, or own online chat"
	rs.open sql, db
	if not rs.eof then
		response.write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" bordercolor=""#000000"">"
		response.write "<tr><td>Name</td><td>Last Logged On</td></tr>"
		do until rs.eof
			response.write "<tr><td>" & rs("name") & " " & rs("lastname") & "</td><td>" & di.di_format(rs("lastloggedon"),"dd mmm yy hh:nnam/pm") & "</td></tr>"
			rs.movenext
		loop
		response.write "</table>"
	end if
	rs.close
%>
</div>
<div style="height:168px; top: 50px;" class="maindiv">
  <div class="titlediv"><b>News</b></div>
  <%
	sql = "select * from news where startdate <= date() and enddate >= date() order by startdate, enddate"
	rs.open sql, db
	hr = ""
	do until rs.eof
		if rs("content") & ""  = "" then
			link = ""
		else
			link = " <a href=""news.asp?id=" & rs("newsid") & """ target=""_blank"">...</a>"
		end if
		response.write hr & di.di_format(rs("datetime"),"dd mmm yy hh:nnam/pm") & " <b>" & rs("title") & "</b><br>" & rs("description") & link
		hr = "<hr>"
		rs.movenext
	loop
	rs.close
%>
</div>
<div style="height:115px; top: 1157px; left: 266px;" class="maindiv">
  <div class="titlediv"><b>Trading Post </b></div>
  <p>Coming one day.</p>
  <p>In the mean-time Greg is looking for a <font size="+1"><strong>beach-buggy</strong></font> and a <font size="+1"><strong>small garden shed</strong></font>. If you know of either of these can you please contact him.</p>
  <p>Skype: <a href="skype:greg_tichbon?call"><img src="http://mystatus.skype.com/smallicon/greg_tichbon" style="border: none;" width="16" height="16" alt="My status" /></a> Email: <a href="mailto:g.tichbon@incedo.org.nz">g.tichbon@incedo.org.nz</a> Mobile: (027)2495088
    <%
	'sql = "select * from news where startdate <= date() and enddate >= date() order by startdate, enddate"
	'rs.open sql, db
	'do until rs.eof
	'	response.write rs("datetime") & " <b>" & rs("title") & "</b><br>" & rs("description") & " <a href=""news.asp?id=" & rs("newsid") & """ target=""_blank"">...</a><hr>"
	'	rs.movenext
	'loop
	'rs.close
%>
  </p>
</div>
<%
	set rs = nothing
	db.close
	set db = nothing
	set di = nothing
%>
<div id="datetime" style="position:absolute; height:74px; z-index:1; left: 630px; top: 227px;" class="maindiv">
  <div class="titlediv"><b>Date / Time</b></div>
</div>
<script type="text/javascript" src="../ajax/poll.js"></script>
<script language="javascript">
setInterval("formatdatetime()", 1000);
var db = 'e:/$generic/incedo/incedo.mdb';
var sqlreport = 'SELECT "<tr><td>" & IIf([knownas] Is Null,[firstname],[knownas]) & " " & [lastname] & "</td></tr>" AS Name FROM People WHERE DateDiff("s",[LastPolled],Now())<60 ORDER BY "<tr><td>" & IIf([knownas] Is Null,[firstname],[knownas]) & " " & [lastname] & "</td></tr>"';
var sqlupdate = 'update people set lastpolled = now() where id = <%=session("Incedo_MemberID")%>';
poll(db,sqlreport,sqlupdate);
setInterval("poll(db,sqlreport,sqlupdate)", 30000);
</script>
</div>
</body>
</html>
