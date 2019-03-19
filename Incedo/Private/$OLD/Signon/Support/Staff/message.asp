<%
If not Request.Form("message")="" THEN
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	Set rs = Server.CreateObject("ADODB.Recordset")
	db.Open connection_string
	rs.Open "dialogue", db, 1, 2
	
	'sql = "insert into [dialogue] ([session],[datetime],[narrative],staff) values (" & session("chatid") & ",'" & now() & "','" & session("chatnickname") & ": " & request.form("message") & "'," & session("chatstaff") & ")"
'response.write sql
'response.end
	'db.execute sql
	rs.addnew
	rs.fields("session") = session("chatid")
	rs.fields("datetime") = now()
	rs.fields("narrative") = session("chatnickname") & ": " & request.form("message")	
	rs.fields("staff") = session("chatstaff")
	rs.update 
	rs.close
	set rs = nothing	
	db.close
	set db = nothing
end if
%>
<HTML>
<HEAD><TITLE>Message Page</TITLE>
<script language="JavaScript">
  //window.onbeforeunload = confirmExit;
  //function confirmExit() {
  //	popupWin = window.open('http://www.yfc.org.nz','test')
    //return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
	//return false;
	//}
function unload() {
	//popupWin = window.open('http://yfc.org.nz','_blank')
	//alert('hello');
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></HEAD>
<BODY BGCOLOR="#006600" TEXT="#FFFFFF" LINK="#3333CC" onUnload="unload();">
<FORM METHOD="POST" ACTION="../../Chat/Staff/message.asp">
<FONT SIZE=2>Type your message and click send.</FONT><BR>
<TABLE BORDER=0 CELLSPACING=0>
<TR>
<TD>
<INPUT NAME="message" TYPE="TEXT" SIZE=30>
</TD>
<TD>
  <input type="IMAGE" src="../../Chat/Staff/send.gif" border=0></TD>
<TD>
<A HREF="../../Chat/Staff/logoff.asp" TARGET="_top"><IMG SRC="../../Chat/Staff/exit.gif" WIDTH=87 HEIGHT=19 BORDER=0></A>
</TD>
<TD>
<A HREF="../../Chat/Staff/kick.asp" TARGET="_top"><IMG SRC="../../Chat/Staff/kick.gif" WIDTH=87 HEIGHT=19 BORDER=0></A>
</TD>
<TD>
<A HREF="../../Chat/Staff/help.asp" TARGET="_top"><IMG SRC="../../Chat/Staff/help.gif" WIDTH=87 HEIGHT=19 BORDER=0></A>
</TD>
</TABLE>
</FORM>
</BODY>
</HTML>