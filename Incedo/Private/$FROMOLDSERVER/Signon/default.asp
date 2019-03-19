<%
	session("Incedo_MemberID")= ""
	session("Incedo_lastname")= "" 
	session("Incedo_firstname")= "" 
	session("Incedo_knownas")= "" 
	if request.cookies("Incedo_MemberID") <> "" then
		rememberMemberID = " checked"
	end if
	if request.cookies("Incedo_Password") <> "" then
		rememberPassword = " checked"
	end if
%>
<HTML>
<HEAD>
<TITLE>Incedo Signon</TITLE>
</HEAD>
<script language="JavaScript">
<!--
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.signon;
	if(frm.id.value == '') {
		msg = msg + delim + ' - Membership ID';
		delim = '\n';
	}
	else {
		if(isNaN(frm.id.value)) {
			msg = msg + delim + ' - A numeric Membership ID';
			delim = '\n';
		}
	}
	if(frm.password.value == '') {
		msg = msg + delim + ' - Password';
		delim = '\n';
	}
	
	if(msg != '') {
		alert('You must enter:\n' + msg);
		return(false);
	}
}
//-->
</script>
    <div align="center">
  <p></p><b></b></p>
  <form name="signon" method="post" action="process.asp" OnSubmit="return checkform();">
      <table width="800" border="0">
        <tr> 
          <td><div align="right">Membership ID </div></td>
          <td><input name="id" type="text" id="id" value="<%=request.cookies("Incedo_MemberID")%>">
          </td>
        </tr>
        <tr> 
          <td><div align="right">Password</div></td>
          <td> 
            <input type="password" name="password" value="<%=request.cookies("Incedo_Password")%>">
          </td>
        </tr>
<tr>
          <td><div align="right">Remember Membership ID</div></td>
          <td><input name="remembermembershipid" type="checkbox" id="remembermembershipid" value="-1"<%=rememberMemberID%>></td>
        </tr>
        <tr>
          <td><div align="right">Remember Password </div></td>
          <td><input name="rememberpassword" type="checkbox" id="rememberpassword" value="-1"<%=rememberPassword%>></td>
        </tr>      </table>
    <p><b><font color="#FF0000"><%=session("message")%></font></b></p>
    <p>
      <input type="submit" name="submit" value=" Submit ">
    </p>
  </form>

  </div>
</BODY>
</HTML>



