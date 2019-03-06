<%
	if 1=2 then
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "people/correspondencelist.asp"
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
	end if
%>	
<HTML><HEAD><title>Incedo People</title></HEAD>
<BODY>
<p align="center"><b><font size="+3">Incedo Correspondence List</font></b><br>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	'sql = "SELECT distinctrow Lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) AS Firstname, Category, Email, mobile as Mobile, membershipdate as [Membership Date], iif(membershipdate is null,'No','Yes') as Member, MembersUpdate as [Members Update], Prayer, DailyTexts as [Daily Text] FROM People  WHERE (membershipdate Is Not Null and appointmentceased is null) or membersupdate = true or prayer = true or dailytexts = true  ORDER BY iif(membershipdate is null,1,0), lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) "
	sql = "SELECT distinctrow Lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) AS Firstname, Category, Email, mobile as Mobile, iif(membershipdate is null,'No','Yes') as Member,  membershipdate as [Membership Date], DailyTexts as [Daily Text] FROM People  WHERE (membershipdate Is Not Null and appointmentceased is null) or dailytexts = true  ORDER BY iif(membershipdate is null,1,0), lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) "
'Response.Write sql 
'Response.end
	rs.Open sql, db
	cnt = 0
	doheader = true
	do until rs.EOF
		cnt = cnt + 1
		if doheader = true then
			response.write "<tr>"
			for each fld in rs.Fields
				Response.write "<th nowrap>" & fld.name & "</td>"
			next
			Response.Write "</tr>"
			doheader = false
		end if
	  	
		response.write "<tr>"
		for each fld in rs.fields
			useval = fld.value
			if fld.name = "Members Update" or fld.name = "Prayer" or fld.name = "Daily Text" then
				if rs("member") = "No" then
					if useval = "True" then
						useval = "Yes"
					else
						useval = ""
					end if
				else
					if useval = "True" then
						useval = ""
					else
						useval = "Yes"
					end if
				end if
			elseif fld.name = "Email" then
				useval = "<a href=""mailto:" & useval & """>" & useval & "</a>"
			end if
			Response.write "<td nowrap>" & useval & "&nbsp;</td>"
		next
		Response.Write "</tr>"
		rs.MoveNext
	loop
		
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
	Response.Write cnt & " records."
%>
</table>
</BODY>
</HTML>




