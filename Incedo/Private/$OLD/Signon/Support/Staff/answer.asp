<HTML>
<HEAD>
<TITLE>Chat Staff Login</TITLE>
</HEAD>
<BODY>

<FORM METHOD="POST" ACTION="../../Chat/Staff/answer_process.asp">
  <p>YFCNZ Chat Answer Verification
    <input name="staffid" type="hidden" id="staffid" value="<%=request.querystring("staffid")%>">
    <input name="chatid" type="hidden" id="chatid" value="<%=request.querystring("chatid")%>">
  </p>
  <p>Please verify your Password 
    <INPUT NAME="password" TYPE="TEXT" SIZE=10>
  </p>
  <p>    <INPUT TYPE="SUBMIT" VALUE="Verify">
  </p>
</form>
</BODY>
</HTML>
