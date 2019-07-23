<%
if 1=2 then
	id = request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\pirates\pirates.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * from fundraising where id = " & id
	rs.Open sql, db
	if rs.eof then
		msg = "Invalid fundraising campaign"
		title = "FUNDRAISING"
	else
		msg = ""
		dollars = rs("amount")
		height = int(dollars / 1000 * 40.5)
		top = 440 - height
		title = rs("title")
		description = rs("description")
		current = rs("current")
	end if
	rs.close
	set rs = nothing
	db.close
	set db = nothing
end if	

'Volunteers
max1 = 5000
intervals1 = 10
value1 = 100
height1 = int(value1 / max1 * 335)
top1 = 365 - height1
rowheight = 332 / intervals1 
tableheight1 = rowheight * (intervals1 + 1)
tabletop1 = 332 - tableheight1 + 35

'Employers
max2 = 40
intervals2 = 8
value2 = 35
height2 = int(value2 / max2 * 335)
top2 = 365 - height2
rowheight = 332 / intervals2 
tableheight2 = rowheight * (intervals2 + 1)
tabletop2 = 332 - tableheight2 + 35

'Community Partners
max3 = 200
intervals3 = 10
value3 = 10
height3 = int(value3 / max3 * 332)
top3 = 365 - height3
rowheight = 332 / intervals3 
tableheight3 = rowheight * (intervals3 + 1)
tabletop3 = 332 - tableheight3 + 35
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>For Our Kids</title>
<style type="text/css">
<!--
.bar {
	background-color: #FF0000;
	width: 16px;
}
.value {
	background-color: #FF0000;
}
td.grid {
	text-align: right;
	vertical-align: bottom;
	border-bottom-style: dotted;
	border-bottom-color: #FFFFFF;
	color: #FFFFFF;
}
-->
</style>
<script type="text/javascript">
function fixbrowser() {
	var browser=navigator.appName;
	var b_version=navigator.appVersion;
	var version=parseFloat(b_version);
	//alert(browser + ' ' + version);
	if(browser == 'Netscape') {
		//alert('here');
		document.getElementById('Layer2').style.left = -40 + 'px';
	}
}
</script>
</head>
<body>
<div align="center">
  <table>
  <tr>
  <td>
  <div style="position:relative; width:221px; height:500px; background-image: url(&quot;Images/thermometer.gif&quot;); z-index:1;">
    <div style="position:absolute; left:70px; height:<%=height1%>px; top:<%=top1%>px; z-index:2;" class="bar"></div>
    <div style="position:absolute; left:20px; top:<%=(max1-value1)/max1*335+20%>px; z-index:3;" class="value"><%=value1%></div>
    <div style="position:absolute; left:100px; top:<%=tabletop1%>px; height:<%=tableheight1%>px; width:100px; z-index:4;">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<%
step = max1 / intervals1
line = max1
for f1=0 to intervals1
	response.write "<tr><td class=""grid"">" & line & "</td></tr>"
	line = line - step
next
%>
    </table>
	</div>
  </div>
  Volunteers Signed Up
  </td>
  <td>
  <div style="position:relative; width:221px; height:500px; background-image: url(&quot;Images/thermometer.gif&quot;); z-index:1;">
    <div style="position:absolute; left:70px; height:<%=height2%>px; top:<%=top2%>px; z-index:2;" class="bar"></div>
    <div style="position:absolute; left:20px; top:<%=(max2-value2)/max2*335+20%>px; z-index:3;" class="value"><%=value2%></div>
    <div style="position:absolute; left:100px; top:<%=tabletop2%>px; height:<%=tableheight2%>px; width:100px; z-index:4;">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<%
step = max2 / intervals2
line = max2
for f1=0 to intervals2
	response.write "<tr><td class=""grid"">" & line & "</td></tr>"
	line = line - step
next
%>
    </table>
	</div>
  </div>
  Employers Signed Up
  </td>
  <td>
  <div style="position:relative; width:221px; height:500px; background-image: url(&quot;Images/thermometer.gif&quot;); z-index:1;">
    <div style="position:absolute; left:70px; height:<%=height3%>px; top:<%=top3%>px; z-index:2;" class="bar"></div>
    <div style="position:absolute; left:20px; top:<%=(max3-value3)/max3*335+20%>px; z-index:3;" class="value"><%=value3%></div>
    <div style="position:absolute; left:100px; top:<%=tabletop3%>px; height:<%=tableheight3%>px; width:100px; z-index:4;">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<%
step = max3 / intervals3
line = max3
for f1=0 to intervals3
	response.write "<tr><td class=""grid"">" & line & "</td></tr>"
	line = line - step
next
%>
    </table>
	</div>
  </div>
    Community Partners Signed Up
  </td>
  </tr>
  </table>
</div>
</body>
</html>
