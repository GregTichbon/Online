<%
IF len(session("chatid")) = 0 THEN
%>
<HTML>
<HEAD>
<TITLE>Chat - Login</TITLE>
<BODY>
<BR>

<FORM METHOD="POST" ACTION="../../Chat/Staff/signon.asp">
<input type="hidden" name="zone" value="<%=request.querystring("zone")%>">
Nickname <INPUT NAME="nickname" TYPE="TEXT" SIZE=10><br>
Question <INPUT NAME="question" TYPE="TEXTAREA"><br>
<INPUT TYPE="SUBMIT" VALUE="Enter chat">
</form>
</BODY>
</HTML>
<%
else
%>

<HTML>
<HEAD><TITLE>Chat - Staff</TITLE></HEAD>
<FRAMESET ROWS="180,70" FRAMEBORDER="0" BORDER="false">
<FRAME SRC="../../Chat/Staff/display.asp" SCROLLING="auto">
<FRAME SRC="../../Chat/Staff/message.asp" SCROLLING="no">
</FRAMESET><noframes></noframes>
</HTML>
<%
end if
%>