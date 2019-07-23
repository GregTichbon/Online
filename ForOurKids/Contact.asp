<%
	Randomize
	captcha = mid(rnd,3,5)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FOR OUR KIDS</title>
<link rel="stylesheet" type="text/css" href="styles.css"/>
<link rel="stylesheet" type="text/css" href="forms.css"/>
<script language="JavaScript" type="text/JavaScript">
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.message;
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
	if(frm.message.value == '') {
		msg = msg + delim + ' - A message';
		delim = '\n';
	}
	if(frm.$captchaverify.value != frm.$captcha.value) {
		msg = msg + delim + ' - Matching Verification Code';
		delim = '\n';
	}
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
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>

<body bgcolor="#000000" onload="MM_preloadImages('now rollover.jpg')">
<div align="center">
<img src="images/FOK%20header.jpg" width="780" height="239" /><br />
<table width="780" border="0" cellpadding="10" cellspacing="0" class="table">
  <tr>
    <td colspan="2"><!--#include file="inc_menu.html"--></td>
  </tr>
  <tr>
    <td><div align="center"><img src="images/email%20button.jpg" width="150" height="56" /></div></td>
    <td><div align="left"><a href="mailto:mail@forourkids.org.nz">mail@forourkids.org.nz</a></div></td>
    </tr>
  <tr>
    <td><img src="images/phone%20button.jpg" width="150" height="56" /></td>
    <td><p align="left">0508 4 OUR KIDS</p></td>
    </tr>
  <tr>
    <td><img src="Images/skype.jpg" width="150" height="56" /></td>
    <td><div align="left">
      <script type="text/javascript" src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js"></script>
      <a href="skype:for_our_kids?call">
      <img src="images/skype.gif" style="border: none;" width="150" height="60" alt="My status" /></a>
    </div></td>
    </tr>
  <tr>
    <td colspan="2"><form action="contact_process.asp" method="post" name="message" id="message" onsubmit="return checkform();">
      <table width="95%"  border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#000000">
        <tr>
          <td width="200" nowrap="nowrap"><div align="right">Name</div></td>
          <td bordercolor="#000000"><div align="left">
              <input name="name" type="text" id="name" />
          </div></td>
        </tr>
        <tr>
          <td width="200" nowrap="nowrap"><div align="right">Email Address </div></td>
          <td bordercolor="#000000"><div align="left">
              <input name="emailaddress" type="text" id="emailaddress" />
          </div></td>
        </tr>
        <tr>
          <td width="200" nowrap="nowrap"><div align="right">Phone Number(s)<br />
                  <span class="style2">(if you'd like us to call) </span> </div></td>
          <td bordercolor="#000000"><div align="left">
              <input name="phone" type="text" id="phone" />
          </div></td>
        </tr>
        <tr>
          <td width="200" nowrap="nowrap"><div align="right">Message</div></td>
          <td bordercolor="#000000"><div align="left">
              <textarea name="message" rows="4" id="message"></textarea>
          </div></td>
        </tr>
            <tr>
              <td width="200" nowrap><div align="right">Verification Code<br />
                Please enter <font color="#FF0000"><strong><span id="captcha"><%=captcha%></span></strong></font> </div></td>
              <td><div align="left">
                  <input name="$captchaverify" type="hidden" id="$captchaverify" value="<%=captcha%>"/>
                  <input name="$captcha" type="text" class="tt" id="$captcha" title="Verification Code" value="" />
                </div></td>
            </tr>
        <tr>
          <td colspan="2" nowrap="nowrap"><div align="center">
              <input name="$submit" type="submit" id="$submit" value="Submit" />
          </div></td>
        </tr>
      </table>
      <br />
    </form></td>
    </tr>
</table>
<p><img src="Images/FOK%20footer.jpg" width="780" height="36" /></p>
</div>
</body>
</html>
