<%
for each var in request.servervariables
	response.write var & "=" & request.servervariables(var) & "<br>"
next
%>
