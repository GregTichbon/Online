
<HTML>
<HEAD>
	<script language="JavaScript">
	<!-- hide from JavaScript-challenged browsers
	function openWindow(url, name) {
	 	popupWin = window.open(url, name, 'scrollbars,resizable,width=400,height=250')
	}
	// done hiding -->
	</script>
</HEAD>
<BODY>
<%
	zone = 1
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\$GENERIC\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT Count(*) AS online FROM Staff INNER JOIN Staff_Zones ON Staff.ID = Staff_Zones.Staff WHERE Staff.Online = True AND Staff_Zones.[Zone] = " & zone 

	rs.Open sql, db
	if rs("online") > 0 then
%>		
<A HREF="javascript:openWindow('chat/main.asp?zone=<%=zone%>', 'remote');"><img src="../Chat/online.gif" border="0"></A>
<%
end if

	rs.close
	set rs = nothing
	db.close
	set db = nothing
%>
</BODY>
</HTML>