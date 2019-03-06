***
<%
	if request.querystring("test") = "" then
		live = true
	else
		live = false
	end if
	sql = "SELECT id, Lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) AS UseFirstname, mobile, email " & _
		  "FROM People WHERE ((membershipdate Is Not Null and dailytexts <> true) or (membershipdate Is Null and dailytexts = true)) and Category <> 'Ceased' and mobile is not null " & _
		  "ORDER BY lastname, IIf([knownas] Is Not Null,[knownas],[firstname])"

'		  "and id in (60,646,59,107,934,863,782,713) " & _

'response.write sql & "<br>"
'response.end
		  
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	msgsql = "Select * from dailytxt where [date] = #" & di.DI_format(now(),"dd mmm yyyy") & "#"
	rs.open msgsql,db

	if rs.eof then
		response.write "No txt to send"
		rs.close
	else
		txt = rs("message")
		rs.close
		rs.Open sql, db
		do until rs.eof
			mobile = check_txt(rs("mobile"))
			if left(mobile,1) = "X" then
				bc = bc + 1
				response.write "<b><font color=""#FF0000"">" & rs("usefirstname") & " " & rs("lastname") & " - " & mid(mobile,2) & " - invalid.</font></b><br>"
			else
				gc = gc + 1
				response.write rs("usefirstname") & " " & rs("lastname") & " - " & mobile & " - OK. " & id & "<br>"
				msg = convert(txt,0)
			end if
			rs.movenext
		loop
		rs.close
		response.write gc & " messages"
	end if
	set rs = nothing
	db.Close
	set db = nothing


function check_txt(str)
	check_txt = str
	check_txt = replace(check_txt," ","")
	check_txt = replace(check_txt,"-","")	
	check_txt = replace(check_txt,"(","")
	check_txt = replace(check_txt,")","")
	if isnumeric(check_txt) then
		if left(check_txt,1) = "+" then
			check_txt = cstr(cdbl(check_txt))
			check_txt = "+" & check_txt
		else
			check_txt = cstr(cdbl(check_txt))
			check_txt = "+64" & check_txt
		end if
	else
		check_txt = "X" & str
	end if			
			
												
end function

Function convert(pass_text,pass_mode)
	new_message = ""
    c1 = 0
    Do Until c1 >= Len(pass_text)
        c1 = c1 + 1
        If Mid(pass_text, c1, 2) = "||" Then
            c2 = 2
            Do Until Mid(pass_text, c1 + c2, 2) = "||"
                c2 = c2 + 1
            Loop
            fieldname = Mid(pass_text, c1 + 2, c2 - 2)
on error resume next
			if pass_mode = 0 then
            	new_message = new_message & rs(fieldname)
			else
				new_message = new_message & delim & rs(fieldname)
				delim = "|"
			end if
if err.number <> 0 then
response.write "<br>" & fieldname
response.end
end if
            c1 = c1 + c2 + 1
        Else
			if pass_mode = 0 then
            	new_message = new_message & Mid(pass_text, c1, 1)
			end if
        End If
    Loop
    convert = new_message

End Function

%>
