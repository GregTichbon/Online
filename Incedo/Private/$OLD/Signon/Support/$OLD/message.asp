<%
If not Request.Form("message")="" THEN
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\yfcnz\onlinesupport.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	Set rs = Server.CreateObject("ADODB.Recordset")
	db.Open connection_string
	rs.Open "dialogue", db, 1, 2

	'sql = "insert into [dialogue] ([session],[datetime],[narrative]) values (" & session("chatid") & ",'" & now() & "','" & session("chatnickname") & ": " & request.form("message") & "')"
'response.write sql
'response.end
	'db.execute sql
	rs.addnew
	rs.fields("session") = session("chatid")
	rs.fields("datetime") = now()
	rs.fields("narrative") = session("chatnickname") & ": " & request.form("message")	
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
</HEAD>
<BODY BGCOLOR="#006699" TEXT="#FFFFFF" LINK="#FF0000" onUnload="unload();">
<FORM METHOD="POST" ACTION="../Chat/message.asp">
<FONT SIZE=2>Type your message and click send.</FONT><BR>
<TABLE BORDER=0 CELLSPACING=0>
<TR>
<TD>
<INPUT NAME="message" TYPE="TEXT" SIZE=30>
</TD>
<TD>
<INPUT TYPE="IMAGE" SRC="../Chat/send.gif" WIDTH=40 HEIGHT=24 BORDER=0>
</TD><TD>&nbsp;</TD>
<TD VALIGN=TOP>
<A HREF="../Chat/logoff.asp" TARGET="_top"><IMG SRC="../Chat/exit.gif" WIDTH=35 HEIGHT=26 BORDER=0></A>
</TD>
</TABLE></FORM>
</BODY>
</HTML>