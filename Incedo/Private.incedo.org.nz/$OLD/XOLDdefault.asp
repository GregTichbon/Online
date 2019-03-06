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
<script language="JavaScript" type="text/JavaScript">
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
</script>
<style type="text/css">
.maindiv {
	position:absolute; 
	overflow: auto; 
	width:642px; 
	border: thin solid #000000;
	background-color: #FAD3F9;
}
.titlediv {
	position:absolute; 
	width:642px; 
	height:23px;
	background-color: #CAD3F9;
}
</style>
</head>
<body>
<table width="254" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="254"><p><a href="Documents/Default.asp">Documents</a><br>
        <a href="Forum/">Forums</a>      <br>
      <a href="people">People</a><br>
      <a href="Supporters/default.asp">Supporters</a><br>
      <a href="connectme/default.asp">ConnectMe<br>
      </a>Pages<br>
      <a href="prayer/default.asp">Prayer</a><br>
      <a href="Email/default.asp">Members Email</a><br>
      <a href="faq">FAQ</a><br>
      <a href="Radio">Radio<br>
      </a><a href="Polls">Polls</a><br>
      <a href="FeaturedLinks/">Featured Links</a>      <br>
      Links<br>
      Events<br>
      <a href="news">News</a><br>
      <a href="Security">Security</a>      <br>
        <a href="Signon/default.asp">Sign out</a></p>
    </td>
  </tr></table>
<div style="left: 266px; top: 360px;" class="titlediv"><b>Most Recent Daily (3x3x3) Texts</b></div>
	<div style="height:115px; left: 266px; top: 384px;" class="maindiv">
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
<div style="left: 266px; top: 219px;" class="titlediv"><b>Current Prayer Items</b></div>
	<div style="height:115px; top: 244px; left: 266px;" class="maindiv">
	<%
	sql = "SELECT Title, Narrative, Category FROM PrayerItem  INNER JOIN PrayerCategory ON PrayerItem.CategoryID = PrayerCategory.CategoryID WHERE ExpireOn >= Date() ORDER BY PrayerItem.DateTime"
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
	sql = "SELECT top 1 id, profile, iif(knownas is null,firstname,knownas) as name, lastname, email, birthday FROM People " & _
		  "WHERE (((lastprofiled) Is Null Or (lastprofiled)>=Date()) AND ((membershipdate) Is Not Null) AND ((AppointmentCeased) Is Null Or (AppointmentCeased)>Date())) " & _
		  "ORDER BY Lastname, Firstname, lastprofiled"
'response.write sql
'response.end
	rs.open sql, db
	if not rs.eof then
		name = "<a href=""mailto:" & rs("email") & """>" & rs("name") & " " & rs("lastname") & "</a>"
%>
<div style="left: 266px; top: 500px;" class="titlediv"><b>Member of the day - <%=name%></b></div>
	<div style="height:187px; top: 524px; left: 266px;" class="maindiv">
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
<div style="left: 266px; top: 711px;" class="titlediv"><b>Featured Links</b></div>
	<div style="height:115px; top: 736px; left: 266px;" class="maindiv">
	<%
	sql = "SELECT * FROM featuredlinks where InternalFeatureFrom <= date() and InternalFeatureTo >= date() order by InternalFeatureFrom"
	rs.open sql, db
	hr = ""
	do until rs.eof
		response.write hr & rs("description") & "<br><a href=""" & rs("link") & """ target=""_blank"">" & rs("link") & "</a>"
		hr = "<hr>"
		rs.movenext
	loop
	rs.close
%>
</div>
<div style="left: 266px; top: 851px;" class="titlediv"><b>Members Birthdates</b></div>
	<div style="height:115px; top: 877px; left: 266px;" class="maindiv">
	<%
	sql = "SELECT IIf([knownas] Is Not Null,[knownas],[firstname]) & ' ' & lastname AS name, Centre, email, mobile, Format([birthday],'dd mmm') as birthdate FROM People where birthday <> null and membershipdate <> null and category <> 'ceased' and CDate(Format(now(),'dd mmm ') & '2000') between CDate(Format([birthday],'dd mmm ') & '2000')-7 and CDate(Format([birthday],'dd mmm ') & '2000')+7  ORDER BY IIf(CDate(Format([birthday],'dd mmm ') & '2000')+7>=CDate(Format(Now(),'dd mmm ') & '2000'),0,1), CDate(Format([birthday],'dd mmm ') & '2000')"
	rs.open sql, db
	if not rs.eof then
		response.write "<table>"
		do until rs.eof
			response.write "<tr><td>" & rs("name") & "</td><td>" & rs("birthdate") & "</td><td>" & rs("centre") & "</td><td><a href=""mailto:" & rs("email") & """>" & rs("email") & "</a></td><td>" & rs("mobile") & "</td></tr>"
			rs.movenext
		loop
		response.write "</table>"
	end if
	rs.close
%>
</div>
<div style="left: 266px; top: 1271px;" class="titlediv"><b>Who's online</b></div>
	<div style="height:115px; top: 1295px; left: 266px;" class="maindiv">
	Maybe coming one day!
	<%
	sql = "select iif(knownas is null,firstname,knownas) as name, lastname, centre, email from people WHERE datediff('s',lastpolled,now()) < 60 order by lastname, firstname"
	'---------Option to go to MSN, Skype, or own online chat"
	rs.open sql, db
	if not rs.eof then
		response.write "<table>"
		do until rs.eof
			response.write "<tr><td>" & rs("name") & " " & rs("lastname") & "</td><td>" & rs("centre") & "</td><td><a href=""mailto:" & rs("email") & """>" & rs("email") & "</a></td></tr>"
			rs.movenext
		loop
		response.write "</table>"
	end if
	rs.close
%>
</div>
<div style="left: 266px; top: 992px;" class="titlediv"><b>Who's been online</b></div>
<div style="height:115px; top: 1017px; left: 266px;" class="maindiv">
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
<div style="left: 266px; top: 26px;" class="titlediv"><b>News</b></div>
<div style="height:168px; top: 50px; left: 266px;" class="maindiv">
	<p><b>News</b></p>
	<%
	sql = "select * from news where startdate <= date() and enddate >= date() order by startdate, enddate"
	rs.open sql, db
	hr = ""
	do until rs.eof
		response.write hr & di.di_format(rs("datetime"),"dd mmm yy hh:nnam/pm") & " <b>" & rs("title") & "</b><br>" & rs("description") & " <a href=""news.asp?id=" & rs("newsid") & """ target=""_blank"">...</a>"
		hr = "<hr>"
		rs.movenext
	loop
	rs.close
%>
</div>
<div style="left: 266px; top: 1133px;" class="titlediv"><b>Buy, Sell, and Exchange</b></div>
<div style="height:115px; top: 1157px; left: 266px;" class="maindiv">
	Coming one day!
	<%
	'sql = "select * from news where startdate <= date() and enddate >= date() order by startdate, enddate"
	'rs.open sql, db
	'do until rs.eof
	'	response.write rs("datetime") & " <b>" & rs("title") & "</b><br>" & rs("description") & " <a href=""news.asp?id=" & rs("newsid") & """ target=""_blank"">...</a><hr>"
	'	rs.movenext
	'loop
	'rs.close
%>
</div>
<%
	set rs = nothing
	db.close
	set db = nothing
	set di = nothing
%>
</body>
</html>
