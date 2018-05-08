<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
%>	
<HTML><HEAD><title>Living Hope</title></HEAD>

<BODY>
<p>Yeah, I'll get on to it one day</p>
<p><a href="default.asp">Return to menu </a></p>
</BODY>
</HTML>



