<%
'Session.Contents.RemoveAll()
secresult = "Failed"
connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
Set secdb = Server.CreateObject("ADODB.Connection")
secdb.Open connection_string
Set secrs = Server.CreateObject("ADODB.RecordSet")
secsql = "SELECT People_SecurityOption.Value, People_SecurityOption.basearea, securitygroupoptions.baseareaoption FROM (People_SecurityOption INNER JOIN SecurityGroupOptions ON People_SecurityOption.Option = SecurityGroupOptions.ID) INNER JOIN SecurityGroup ON SecurityGroupOptions.Group = SecurityGroup.ID " & _
		 "WHERE People_SecurityOption.Person = " & session("Incedo_MemberID") & " AND SecurityGroup.Group = '" & secgroup & "' AND SecurityGroupOptions.Option = '" & secoption & "'"
'response.write secsql
'response.end
secrs.Open secsql, secdb
if not secrs.eof then
'response.write secrs("value")
'response.end
	if secvalue = "" then
		secresult = secrs("value")
		secbaseareaoption = secrs("baseareaoption")
		secbasearea = secrs("basearea")
'response.write secresult & "*" & secbaseareaoption & "*" & secbasearea
'response.end
	else
		if secvalue = secrs("value") then
			secresult = "OK"
		end if
	end if
end if
secrs.close
set secrs = nothing
secdb.close
set secdb = nothing
%>