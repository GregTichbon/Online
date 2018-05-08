<%@language="jscript"%> 
<%
	var curDateTime = new Date()
    Session("ServerGMTOffset") = curDateTime.getTimezoneOffset() + (13*60);
%>