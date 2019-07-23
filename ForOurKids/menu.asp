<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>FOR OUR KIDS Administration</title>
</head>
<BODY>
<div align="center">
  <p><font size="+2"><strong>Menu
  </strong></font> </p>
 <%
if request.form("username") = "kof" and request.form("password") = "mentor" then
 	session("forourkids") = "on"
end if
if session("forourkids") = "on" then

 %>
<table width="600" border="1" cellpadding="5" cellspacing="0" bordercolor="#FFFFFF">
	<tr>
	  <td align="center">
	    <p><a href="List.asp?type=p">Partners</a></p>
	    <p><a href="List.asp?type=v">Volunteers</a></p>
	    <p><a href="List.asp?type=e">Employers</a></p>
	    <!--<p><a href="AbstractList.asp">Abstracts</a></p>
	    <p><a href="AbstractSchedule.asp">Abstracts Schedule</a></p>
	    <p><a href="AbstractScheduleDetail.asp">Abstracts Schedule Detail</a> </p>
	    <p><a href="AbstractLocations.asp">Abstracts Locations</a></p>
	    <p><a href="AbstractTimeSlots.asp">Abstracts Time Slots </a></p>
	    <p><a href="abstractexport.asp">Abstract Export </a></p>-->
	    <p><a href="sql.asp">Queries</a></p>
	    <!--<p><a href="dbdownload.asp">Download Database</a></p>-->
      </td>
	</tr>
</table>
 <%
 else
 %>
  <form name="menu" method="post" action="menu.asp">
<table width="600" border="1" cellpadding="5" cellspacing="0" bordercolor="#FFFFFF">
  <tr>
    <td><div align="right">UserName</div></td>
    <td><input name="username" type="text" id="username"></td>
  </tr>
  <tr>
    <td><div align="right">Password</div></td>
    <td><input name="password" type="password" id="password"></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="Submit" value="Submit">
    </div></td>
    </tr>
</table>
  </form>
 <%
 end if
 %>
</div>
</body>
</html>
