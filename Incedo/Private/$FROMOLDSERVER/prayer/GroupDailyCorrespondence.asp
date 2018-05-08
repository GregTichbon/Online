<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "../private/prayer/GroupDailyCorrespondence.asp"
		response.redirect "../signon"
	'else
	'	secgroup = "Prayer"
	'	secoption = "Daily Texts"
	'	secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
	'	administrator = secresult 
	end if
%>
<HTML>
<HEAD>
<TITLE>Daily Txts</TITLE>
<script language="javascript">
function charsleft(line) {
	document.getElementById('chars' + line).value = 160 - document.getElementById('date' + line).value.length;
}
</script>
</head>
<body>
<%
if request.querystring("msg") <> "" then
	response.write "<strong><font color=""#FF0000"" size=""+2"">" & request.querystring("msg") & "</font></strong>"
end if
%>
<FORM name="prayer" action="GroupDailyCorrespondence_process.asp" method="post">
<input name="group" type="hidden" value="Waikato">
<table width="90%"  border="1" cellspacing="0" cellpadding="5">
<%
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open "GroupDailyCorrespondence", db, 1, 2

	startdate = now()
	for f1=-7 to 13
		thisdate = dateadd("d",f1,startdate)
		thisdate = di.DI_format(thisdate,"dd mmm yyyy")
		rs.filter = "group='Waikato' and date = '" & thisdate & "'"
		if rs.eof then
			message = ""
		else
			message = rs("message")
		end if
		if f1 < 0 then
			response.write "<tr><td>" & di.DI_format(thisdate,"dddd") & "<br>" & thisdate & "</td><td colspan=""2"">" & message & "</td></tr>"
		else
			response.write "<tr><td>" & di.DI_format(thisdate,"dddd") & "<br>" & thisdate & "</td><td><textarea name=""date" & thisdate & """cols=""60"" rows=""3"" id=""date" & f1 & """ onKeyUp=""charsleft(" & f1 & ")"">" & message & "</textarea>" & "</td><td>" & "<input name=""chars" & f1 & """ type=""text"" id=""chars" & f1 & """ value=""" & 160 - len(message) & """ size=""5"" maxlength=""3""></td></tr>"
		end if
	next
	rs.close
	set rs = nothing
	db.close
	set db = nothing
%>
</table>
<input name="submit" type="submit" value="submit">
</FORM>
</BODY>
</HTML>


