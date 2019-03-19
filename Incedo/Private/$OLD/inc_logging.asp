<%
connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
Set logdb = Server.CreateObject("ADODB.Connection")
logdb.Open connection_string
SQL = "INSERT INTO peoplelog (Person,[Page],querystring,[datetime]) VALUES (" & session("Incedo_MemberID") & ",'" & request.servervariables("PATH_INFO") & "'," & nullify(request.servervariables("QUERY_STRING")) & ",'" & GMTDate(now()) & "')"
'response.write sql
'response.end
logdb.execute SQL
logdb.close
set logdb = nothing

function nullify(pass_val)
	if pass_val = "" then
		nullify = "NULL"
	else
		nullify = "'" & pass_val & "'"
	end if
end function

Function GMTDate(passDate)
    Server.Execute "/GetServerGMTOffset.asp"
	GMTDate = dateadd("n", Session("ServerGMTOffset"), passDate)
End Function
%>