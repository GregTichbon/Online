<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
%>
	<!--#include file="inc_logging.asp"-->
<%
	end if
	'response.write request.querystring
	response.redirect request.querystring
%>

