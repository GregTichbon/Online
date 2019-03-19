<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "faq/default.asp?" & request.querystring
		response.redirect "../signon"
	else
%>
	<!--#include file="../inc_logging.asp"-->
<%
	if 1=2 then
		secgroup = "Documents"
		secoption = "Standard"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult <> "OK" then
			response.end
		end if		
	end if
	end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo</title>
</head>
<body>
<strong><a name="10"></a>Who do I contact to make an insurance claim?</strong><br>
  Melanie Hands: <a href="mailto:melanie.hands@crombielockwood.co.nz">melanie.hands@crombielockwood.co.nz</a> - DDI: (06) 350 2142 | Fax: (06) 350 2140 | FREEPHONE: 0800 CROMBIE ext 692
  <hr>
<strong><a name="20" id="20"></a>Does Incedo have a freecalling phone number?</strong><br>
  Yes - 0508INCEDO 0508462336<br>
  Mal Green answers the calls on his mobile.
<hr>
<strong><a name="30" id="30"></a>Can we send out text messages and email</strong><br>
Yes, if you can supply Greg with a file of names and mobile number/email addresses he can send these out. Text messages cost 10c+GST each.
<hr>
<strong><a name="40" id="40"></a>Can we receive text messages and automatically respond to them in some way?</strong><br>
Yes - Greg can set up a code word and then collect the mobile number and message that has been sent and then can record, analyse, and respond appropriately.
<hr>
<strong><a name="50" id="50"></a>Do we have a database of Incedo Supporters</strong>?<br>
Yes - We rationalised all supporters databases from YFC National and Centres into one central database that is accessible online to all members. We did this to remove multiple occurences of the same people and to make for simplified maintenance. Each entity can be assigned to one or more bases and can be furthur classified for that base however that base decides. Data can easilly be extracted for bases and classifications and merged to letters and labels. There should not be any other supporter type databases used or maintained within Incedo.
<hr>
<strong><a name="60" id="60"></a>What is X3 Watch? </strong><br>
X3watch is accountability software designed to help with online integrity. When you browse the internet and access a site which may contain questionable material, the program will record the site name. A person of your choice (an accountability partner) will receive an email containing all questionable sites you may have visited. This information is meant to encourage open and honest conversation between friends and help you be more accountable to your online adventures.
<br><br>This software is available from <a href="http://x3watch.com/">x3watch.com</a> for both Microsoft Windows and Mac platforms. It is required on all Incedo owned computers.
<br><br>
Our accountability people are Sue Gardiner (<a href="mailto:s.gardiner@incedo.org.nz">s.gardiner@incedo.org.nz</a>), Marg Row (<a href="mailto:m.row@hotmail.com">m.row@hotmail.com</a>), Judith Crump (<a href="mailto:thecrumps@xtra.co.nz">thecrumps@xtra.co.nz</a>). You can choose one. Any questions to Mal (<a href="mailto:m.green@incedo.org.nz">m.green@incedo.org.nz</a>)
<hr>
</body>
</html>



