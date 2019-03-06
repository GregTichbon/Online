<HTML>
<HEAD>
<TITLE>Y-One Schedule</TITLE>
<script language="javascript">
function calccharsleft() {
	document.getElementById('charsleft').innerHTML = 160 - document.getElementById('message').value.length;
}
</script>
</head>
<body>
<p><strong><font size="+2">Y1 Schedule</font></strong></p>
<p>  
  <%
if request.form("submit") <> "" then
	set fs = server.CreateObject("Scripting.FileSystemObject")
    set ts = fs.OpenTextFile(Server.MapPath("y1Schedule.txt"), 2, True)
    ts.Write request.form("message")
    ts.Close
	set ts = nothing
	set fs = nothing
	response.redirect "y1.asp?msg=Message Saved"
else
	if request.querystring("msg") <> "" then
		response.write "<strong><font color=""#FF0000"" size=""+2"">" & request.querystring("msg") & "</font></strong>"
	end if
	set fs = server.CreateObject("Scripting.FileSystemObject")
	set ts = fs.OpenTextFile(Server.MapPath("y1Schedule.txt"),1)
	message = ts.readall
	charsleft = 160 - len(message)
	ts.Close
	set ts = nothing
	set fs = nothing
%> 
  
</p>
<FORM name="y1" action="y1.asp" method="post">
  <textarea name="message" cols="80" rows="3" id="message" onKeyUp="javascript:calccharsleft()"><%=message%></textarea><span id="charsleft"><%=charsleft%></span>
<input name="submit" type="submit" value="Submit">
</FORM>
<%
end if
%>
</BODY>
</HTML>