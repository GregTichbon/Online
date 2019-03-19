<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "People"
		secoption = "General"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
	end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo People Menu</title>
</head>
<body>
<p><strong>Incedo People Menu</strong></p>
<%
	if secresult = "OK" then 
%>
		<p><a href="search.asp">Search</a></p>
		<p><a href="sql.asp">SQL</a></p>
<%
	end if
%>
<p><a href="maint.asp?id=<%=session("Incedo_MemberID")%>">Maintain your details</a></p>
<p><a href="memberslist.asp">Members List</a></p>
<p><a href="membersemail.asp">Members Email Addresses</a> </p>
<p><a href="correspondencelist.asp">Correspondence List</a></p>
<p><a href="emailaccounts.asp">Email Accounts</a></p>
<p><a href="../default.asp">Return to Main Menu </a></p>
<p>&nbsp;</p>
</body>
</html>



