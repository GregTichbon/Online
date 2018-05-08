<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
if 1=2 then
		secgroup = "Prayer"
		secoption = "Administration"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
		if secresult <> "OK" then
			response.redirect "../signon"
		end if
end if
	end if
%>
<HTML><HEAD><title>Send Email</title></HEAD>
<BODY>
<p>
  <script language=JavaScript src="colorpickerFlooble.js"></script>
  <script language="JavaScript">
function CheckForm() {

	msg = ''
	warn = ''
	delim = ''
	if(document.email.type[1].checked && document.email.passage.value == '') {
		msg = msg + delim + "Please select this Month's Passage";
		delim = '\n';
	}
	if(document.email.type[0].checked == false && document.email.type[1].checked == false) {
		msg = msg + delim + "Please select Reminder or Prayer";
		delim = '\n';
	}
	
	if(msg != '' || warn != '') {
		alert(msg + warn);
		if(msg != '') {
			return(false);
		}
	}
}

function showtype(usetype) {
	if(usetype == 'reminder') {
		obj = document.getElementById('footerrow');		
		obj.style.display = 'none';
		obj = document.getElementById('bookrow');		
		obj.style.display = 'none';
		obj = document.getElementById('titlecolourid');		
		obj.style.display = 'none';
		obj = document.getElementById('contentcolourid');		
		obj.style.display = 'none';
	}
	else {
		obj = document.getElementById('footerrow');		
		obj.style.display = '';
		obj = document.getElementById('bookrow');		
		obj.style.display = '';
		obj = document.getElementById('titlecolourid');		
		obj.style.display = '';
		obj = document.getElementById('contentcolourid');		
		obj.style.display = '';
	}
		
}
</script>
  
<%
additional="Scott Cougill [scott@yfcasiapacific.org]"
additionalsql=" union select 'scott@yfcasiapacific.org', 'Cougill', 'Scott', 0, '' from people"
%>
</p>
<p>The email address for prayer items is <a href="mailto:prayer@incedo.org.nz">prayer@incedo.org.nz</a>.  The password is time.  The account can be accessed at <a href="http://private.incedo.org.nz/mail/am" target="_blank">private.incedo.org.nz/mail/am</a>  </p>
<p>
<form name="email" method="post" action="send_email_process.asp" OnSubmit="return CheckForm();">
  <table width="800" border="1" align="center">
    <tr> 
      <td>Live Run</td>
      <td> 
        <input type="checkbox" name="live" value="yes">
      </td>
    </tr>
    <tr>
      <td>Type</td>
      <td><input name="type" type="radio" value="reminder" onClick="showtype('reminder');">
Reminder
  <input name="type" type="radio" onClick="showtype('prayer');" value="prayer" checked>
        Prayer        </td>
    </tr>
    <tr> 
      <td>Header<br>        </td>
      <td> 
        <textarea name="header" cols="80" rows="15" id="header">Dear ||UseFirstname||

</textarea>
        <br>
      (Available fields: UseFirstName, LastName)      </td>
    </tr>
    <tr id="footerrow">
      <td>Footer</td>
      <td><textarea name="footer" cols="80" rows="15" id="footer"></textarea></td>
    </tr>
    <tr id="titlecolourid">
      <td>Title Colour </td>
      <td>
	  
<a href="javascript:pickColor('titlecolour');" id="titlecolour" style="border: 1px solid #000000; font-family:Verdana; font-size:10px; text-decoration: none;">&nbsp;&nbsp;&nbsp;</a>
<input id="titlecolourfield" size="7" name='titleclr' value="#99CCFF">
<script language="javascript">relateColor('titlecolour', getObj('titlecolourfield').value);</script>	  
	  
	  </td>
    </tr>
    <tr id="contentcolourid">
      <td>Content Colour </td>
      <td>
	<a href="javascript:pickColor('contentcolour');" id="contentcolour" style="border: 1px solid #000000; font-family:Verdana; font-size:10px; text-decoration: none;">&nbsp;&nbsp;&nbsp;</a>
<input id="contentcolourfield" size="7" name='contentclr' value="#CC99FF">
<script language="javascript">relateColor('contentcolour', getObj('contentcolourfield').value);</script>	  
  
	  
	  </td>
    </tr>
    <tr id="bookrow">
      <td>Book for this Month </td>
      <