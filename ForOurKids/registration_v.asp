<%
secure = lcase(request.querystring("secure"))
if secure = "true" then
	if session("forourkids") <> "on" then
		Response.Redirect ("menu.asp")
	end if
end if
ddtypes = array("Business","Government Department","Non-Profit","School","Training Institute","Other")
mode = lcase(request.querystring("mode"))
if mode = "maint" then
	ID = request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\forourkids\forourkids.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")

	sqlstring = "SELECT * FROM volunteer where id = " & ID
	rs.Open sqlstring, db
	    
	postaladdress = rs("postaladdress")
	emailaddress = rs("emailaddress")
	phone = rs("phone")
	mobile = rs("mobile")
	comments = rs("comments")
	
	rs.close
else
	Randomize
	captcha = mid(rnd,3,5)
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FOR OUR KIDS</title>
<link rel="stylesheet" type="text/css" href="styles.css"/>
<link rel="stylesheet" type="text/css" href="tooltip.css"/>
<link rel="stylesheet" type="text/css" href="forms.css"/>
<link rel="stylesheet" type="text/css" media="all" href="calendar/calendar-win2k-1.css" title="win2k-1" />
<script type="text/javascript" src="calendar/calendar_stripped.js"></script>
<script type="text/javascript" src="calendar/calendar-en.js"></script>
<script type="text/javascript" src="calendar/calendar-setup_stripped.js"></script>
<script type="text/javascript" src="Scripts/validateEmail.js"></script>
<script type="text/javascript" src="Scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/tooltips/jquery.tools.min.js"></script>
<script language="JavaScript" type="text/JavaScript">
$(document).ready(function() {
	// select all desired input fields and attach tooltips to them
	$(".tt").tooltip({

		// place tooltip on the right edge
		position: "top center",

		// a little tweaking of the position
		offset: [-2, 10],

		// use the built-in fadeIn/fadeOut effect
		effect: "fade",

		// custom opacity setting
		opacity: 0.7,

		// use this single tooltip element
		tip: '.tooltip'

	});
});
<%
if request.querystring("populate") <> "" then
	onload = " onload=populate('" & request.querystring("populate") & "')"
%>
function populate(param) {
	var frm = document.registration;
	frm.surname.value = 'Surname';
	frm.firstname.value = 'Firstname';
	frm.gender.value = 'Male';
	frm.dateofbirth.value = '1/1/1900';
	frm.residentialaddress.value = 'Residential Address\nResidential Address';
	frm.postaladdress.value = 'Postal Address\nPostal Address';
	frm.employment.value = 'Employment\nEmployment';
	frm.emailaddress.value = 'mail@forourkids.org.nz';
	frm.phonehome.value = '(06) 3447860';
	frm.phonework.value = '(06) 3490543 x 8036';
	frm.phonemobile.value = '(027) 2495088';
	frm.interests.value = 'Interests\nInterests';
	frm.involvement.value = 'Involvement\nInvolvement';
	frm.comments.value = 'Comments\nComments';
}
<%
end if
%>

function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.registration;
<%if mode="maint" then%>
	if(frm.emailaddress.value != '') {
		if(!(IsEmail(frm.emailaddress.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}
<%else%>
	if(frm.surname.value == '') {
		msg = msg + delim + ' - Surname';
		delim = '\n';
	}
	if(frm.firstname.value == '') {
		msg = msg + delim + ' - First name';
		delim = '\n';
	}
	if(frm.gender.value == '') {
		msg = msg + delim + ' - Gender';
		delim = '\n';
	}
	if(frm.emailaddress.value == '') {
		msg = msg + delim + ' - Email address';
		delim = '\n';
	}
	else {
		if(!(IsEmail(frm.emailaddress.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}
	if(frm.postaladdress.value == '') {
		msg = msg + delim + ' - Postal Address';
		delim = '\n';
	}
	if((frm.$captchaverify.value * 2 + 1) != frm.$captcha.value) {
		msg = msg + delim + ' - Matching Verification Code';
		delim = '\n';
	}
<%end if%>
	if(msg != '') {
		alert('You must enter:\n' + msg);
		return(false);
	}
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
</script>
</head>
<body<%=onload%> bgcolor="#000000">
<div class="tooltip"></div>
<div align="center"> <img src="Images/FOK%20header.jpg" width="780" height="239" /><br />
  <table width="780" border="0" cellpadding="10" cellspacing="0" class="table">
    <tr>
      <td><div align="center">
        <!--#include file="inc_menu.html"-->
<img src="images/volunteers.jpg" width="200" height="56" /> </div></td>
    </tr>
    <tr>
      <td><form name="registration" method="post" action="registration_process.asp" onSubmit="return checkform();">
          <input type="hidden" name="mode" value="<%=mode%>">
          <input name="$rtype" type="hidden" id="$rtype" value="volunteer">
          <table width="95%"  border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#000000">
            <tr>
              <td width="200" nowrap><div align="right">Surname</div></td>
              <td><div align="left">
                  <input name="surname" type="text" id="surname">
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Firstname</div></td>
              <td><div align="left">
                  <input name="firstname" type="text" id="firstname">
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Gender</div></td>
              <td><div align="left">
                  <select name="gender" size="1" id="gender">
                    <option value="">--- Please Select ---</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                  </select>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Date of Birth </div></td>
              <td><div align="left">
                  <input name="dateofbirth" type="text" class="date" id="dateofbirth">
                  <img src="calendar/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger">
                  <script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "dateofbirth",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger",      // ID of the button
	  showsTime   : false
    }
  );
            </script>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Residential Address </div></td>
              <td><div align="left">
                  <textarea name="residentialaddress" rows="3" id="residentialaddress"></textarea>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Postal Address</div></td>
              <td><div align="left">
                  <textarea name="postaladdress" rows="3" id="postaladdress"></textarea>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Current Place(s) of Employment </div></td>
              <td><div align="left">
                  <textarea name="employment" rows="3" class="tt" id="employment" title="FOR OUR KIDS is aiming to get employers on board with this initiative.  Knowing where you work will help us in approaching them to discuss this with them.  Please let us know who you currently work for"></textarea>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Email Address </div></td>
              <td><div align="left">
                  <input name="emailaddress" type="text" id="emailaddress">
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Home Phone Number </div></td>
              <td><div align="left">
                  <input name="phonehome" type="text" id="phonehome">
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Work Phone Number(s) </div></td>
              <td><div align="left">
                  <textarea name="phonework" rows="3" id="phonework"></textarea>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Mobile Number </div></td>
              <td><div align="left">
                  <input name="phonemobile" type="text" id="phonemobile">
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Interests</div></td>
              <td><div align="left">
                  <textarea name="interests" rows="4" id="interests" class="tt" title="What are you interested in that could help us find you places to volunteer in."></textarea>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Involvement</div></td>
              <td><div align="left">
                  <textarea name="involvement" rows="4" id="involvement" class="tt" title="Are you currently involved in any voluntary work?  Please give details."></textarea>
                </div></td>
            </tr>
            <tr>
              <td width="200" nowrap><div align="right">Comments</div></td>
              <td><div align="left">
                  <textarea name="comments" rows="4" id="comments" class="tt" title="Feel free to make any other comments or ask questions."></textarea>
                </div></td>
            </tr>
<%if mode="maint" then%>
            <tr>
              <td width="200" nowrap><div align="right">Administration Notes</div></td>
              <td><div align="left">
                  <textarea name="notes" rows="4" id="notes" class="tt" title="This area is for administration only"></textarea>
                </div></td>
            </tr>
<%
else
%>
            <tr>
              <td width="200" nowrap><div align="right">Verification Code<br />
                Please enter <font color="#FF0000"><strong><span id="captcha"><%=captcha * 2 + 1%></span></strong></font> </div></td>
              <td><div align="left">
                  <input name="$captchaverify" type="hidden" id="$captchaverify" value="<%=captcha%>"/>
                  <input name="$captcha" type="text" class="tt" id="$captcha" title="Verification Code" value="" />
                </div></td>
            </tr>
<%   
end if
%>
           <tr>
              <td colspan="2" nowrap><div align="center">
                  <input name="$submit" type="submit" id="$submit" value="Submit">
                </div></td>
            </tr>
          </table>
        </form></td>
    </tr>
  </table>
  <p><img src="Images/FOK%20footer.jpg" width="780" height="36" /></p>
</div>
</body>
</html>
