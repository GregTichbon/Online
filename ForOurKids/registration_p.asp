<%
secure = lcase(request.querystring("secure"))
if secure = "true" then
	if session("forourkids") <> "on" then
		Response.Redirect ("menu.asp")
	end if
end if
ddtypes = array("Sports Group","Interest Based Group","Support Group","School","Other")
mode = lcase(request.querystring("mode"))
if mode = "maint" then
	ID = request.querystring("id")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\forourkids\forourkids.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")

	sqlstring = "SELECT * FROM partner where id = " & ID
	rs.Open sqlstring, db
	    
	'organisationname = rs("organisationname")
	'otype = rs("type")
	'employees = rs("employees")
	postaladdress = rs("postaladdress")
	contactperson = rs("contactperson")
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
	frm.organisationname.value = 'Organisation';
	//frm.type.value = 'Other';
	frm.description.value = 'Description\nDescription';
	frm.location.value = 'Location\nLocation';
	frm.postaladdress.value = 'Postal Address\nPostalAddress';
	frm.contactperson.value = 'Contact Person';
	frm.emailaddress.value = 'mail@forourkids.org.nz';
	frm.phonehome.value = '(06) 3447860';
	frm.phonemobile.value = '(027) 2495088';
	frm.phonework.value = '(027) 2495088';
	frm.volunteersneeded.value = 'Volunteers Needed\nVolunteers Needed';
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
	if(frm.organisationname.value == '') {
		msg = msg + delim + ' - Organisation Name';
		delim = '\n';
	}
	if(frm.emailaddress.value != '') {
		if(!(IsEmail(frm.emailaddress.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}
<%else%>
	if(frm.organisationname.value == '') {
		msg = msg + delim + ' - Organisation Name';
		delim = '\n';
	}
	if(frm.type.value == '') {
		msg = msg + delim + ' - Type';
		delim = '\n';
	}
	if(frm.contactperson.value == '') {
		msg = msg + delim + ' - Contact Person';
		delim = '\n';
	}
	if(frm.emailaddress.value != '') {
		if(!(IsEmail(frm.emailaddress.value))) {
			msg = msg + delim + ' - A valid email address';
			delim = '\n';
		}
	}
	if(frm.emailaddress.value == '' && frm.phonehome.value == '' && frm.phonemobile.value == '' && frm.phonework.value == '') {
		msg = msg + delim + ' - An email address and/or a phone number';
		delim = '\n';
	}
	if(frm.$captchaverify.value != frm.$captcha.value) {
		msg = msg + delim + ' - Matching Verification Code';
		delim = '\n';
	}
<%end if%>
	if(msg != '') {
		alert('You must enter:\n' + msg);
		return(false);
	}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
</script>
</head>
<body<%=onload%> bgcolor="#000000" onload="MM_preloadImages('Images/now%20rollover.jpg')">
<div class="tooltip"></div>
<div align="center"> <img src="Images/FOK%20header.jpg" width="780" height="239" /><br />
  <table width="780" border="0" cellpadding="10" cellspacing="0" class="table">
    <tr>
      <td><div align="center">
        <!--#include file="inc_menu.html"-->
<img src="Images/community%20partners.jpg" width="200" height="56" /> </div></td>
    </tr>
    <tr>
    <td>
	
    <form name="registration" method="post" action="registration_process.asp" onSubmit="return checkform();">
<input type="hidden" name="mode" value="<%=mode%>">
      <input name="$rtype" type="hidden" id="$rtype" value="partner">
      <table width="95%"  border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#000000">
        <tr>
          <td nowrap><div align="right">Organisation Name </div></td>
          <td><div align="left">
              <input name="organisationname" type="text" id="organisationname">
            </div></td>
        </tr>
        <tr>
          <td nowrap><div align="right">Type</div></td>
          <td><div align="left">
              <select name="type" size="1" id="type">
                <option value="">--- Please Select ---</option>
<%
					for each val in ddtypes
						if val = otype then
							selected = " selected"
						else 
							selected = ""
						end if
						response.write "<option value=""" & val & """" & selected & ">" & val & "</option>"
					next
%>
              </select>
            </div></td>
        </tr>
        <tr>
          <td width="200" nowrap><div align="right">Description</div></td>
          <td><textarea name="description" rows="3" id="description" class="tt" title="Please give a brief description on what your organisation does"></textarea></td>
        </tr>
        <tr>
          <td width="200" nowrap><div align="right">Location</div></td>
          <td><div align="left">
              <textarea name="location" rows="3" id="location" class="tt" title="Where abouts to you offer your services/programmes to?"></textarea>
            </div></td>
        </tr>
        <tr>
          <td width="200" nowrap><div align="right">Postal Address</div></td>
          <td><div align="left">
              <textarea name="postaladdress" rows="3" id="postaladdress"></textarea>
            </div></td>
        </tr>
        <tr>
          <td nowrap><div align="right">Contact Person </div></td>
          <td><div align="left">
              <input name="contactperson" type="text" id="contactperson" class="tt" title="Who should we contact to discuss FOR OUR KIDS with?">
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
          <td width="200" nowrap><div align="right">Volunteers Needed </div></td>
          <td><div align="left">
              <textarea name="volunteersneeded" rows="10" id="volunteersneeded" class="tt" title="What sort of voluntary help would you like? Please provide information about time, type, how many hours per week etc."></textarea>
            </div></td>
        </tr>
        <tr>
          <td width="200" nowrap><div align="right">Comments</div></td>
          <td><div align="left">
              <textarea name="comments" rows="4" id="comments" class="tt" title="Feel free to make any other comments or ask questions."></textarea>
            </div></td>
        </tr>
<%
if mode <> "maint" then
%>
            <tr>
              <td width="200" nowrap><div align="right">Verification Code<br />
                Please enter <font color="#FF0000"><strong><span id="captcha"><%=captcha%></span></strong></font> </div></td>
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
    </form>
	
	
    </td>
    </tr>
  </table>
  <p><img src="Images/FOK%20footer.jpg" width="780" height="36" /></p>
</div>
</body>
</html>