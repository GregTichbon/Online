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
      <td>        <select name="passage" size="1" id="passage">
            <option>---Please Select---</option>
			<option value="Genesis">Genesis</option>
			<option value="Exodus">Exodus</option>
			<option value="Leviticus">Leviticus</option>
			<option value="Numbers">Numbers</option>
			<option value="Deuteronomy">Deuteronomy</option>
			<option value="Joshua">Joshua</option>
			<option value="Judges">Judges</option>
			<option value="Ruth">Ruth</option>
			<option value="1 Samuel">1 Samuel</option>
			<option value="2 Samuel">2 Samuel</option>
			<option value="1 Kings">1 Kings</option>
			<option value="2 Kings">2 Kings</option>
			<option value="1 Chronicles">1 Chronicles</option>
			<option value="2 Chronicles">2 Chronicles</option>
			<option value="Ezra">Ezra</option>
			<option value="Nehemiah">Nehemiah</option>
			<option value="Esther">Esther</option>
			<option value="Job">Job</option>
			<option value="Psalms">Psalms</option>
			<option value="Proverbs">Proverbs</option>
			<option value="Ecclesiastes">Ecclesiastes</option>
			<option value="Song of Solomon">Song of Solomon</option>
			<option value="Isaiah">Isaiah</option>
			<option value="Jeremiah">Jeremiah</option>
			<option value="Lamentations">Lamentations</option>
			<option value="Ezekiel">Ezekiel</option>
			<option value="Daniel">Daniel</option>
			<option value="Hosea">Hosea</option>
			<option value="Joel">Joel</option>
			<option value="Amos">Amos</option>
			<option value="Obadiah">Obadiah</option>
			<option value="Jonah">Jonah</option>
			<option value="Micah">Micah</option>
			<option value="Nahum">Nahum</option>
			<option value="Habakkuk">Habakkuk</option>
			<option value="Zephaniah">Zephaniah</option>
			<option value="Haggai">Haggai</option>
			<option value="Zechariah">Zechariah</option>
			<option value="Malachi">Malachi</option>
			<option value="Matthew">Matthew</option>
			<option value="Mark">Mark</option>
			<option value="Luke">Luke</option>
			<option value="John">John</option>
			<option value="Acts (of the Apostles)">Acts (of the Apostles)</option>
			<option value="Romans">Romans</option>
			<option value="1 Corinthians">1 Corinthians</option>
			<option value="2 Corinthians">2 Corinthians</option>
			<option value="Galatians">Galatians</option>
			<option value="Ephesians">Ephesians</option>
			<option value="Philippians">Philippians</option>
			<option value="Colossians">Colossians</option>
			<option value="1 Thessalonians">1 Thessalonians</option>
			<option value="2 Thessalonians">2 Thessalonians</option>
			<option value="1 Timothy">1 Timothy</option>
			<option value="2 Timothy">2 Timothy</option>
			<option value="Titus">Titus</option>
			<option value="Philemon">Philemon</option>
			<option value="Hebrews">Hebrews</option>
			<option value="James">James</option>
			<option value="1 Peter">1 Peter</option>
			<option value="2 Peter">2 Peter</option>
			<option value="1 John">1 John</option>
			<option value="2 John">2 John</option>
			<option value="3 John">3 John</option>
			<option value="Jude">Jude</option>
			<option value="Revelation">Revelation</option>
         </select></td>
    </tr>
<%
if 1=2 then
%>
</p>
<tr>
      <td>Additional recipients </td>
      <td><%=additional%>
        <input name="addemail" type="hidden" value="<%=additionalsql%>"></td>
</tr>
<%
end if
%>
    <tr> 
      <td colspan="2"> 
        <div align="center"> 
          <input type="submit" name="submit" value="                 Submit                  ">
        </div>
      </td>
    </tr>
  </table>
</form>
</BODY>
</HTML>
