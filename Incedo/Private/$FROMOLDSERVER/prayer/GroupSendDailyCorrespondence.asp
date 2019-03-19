***
<%
	set di = server.createobject("DI.IIS")
	
	'theday = di.di_format(now(),"ddd")
	'if theday <> "Mon" and theday <> "Wed" and theday <> "Fri" then
	'	response.end
	'end if

	if request.querystring("test") = "" then
		live = true
	else
		live = false
	end if
	sql = "SELECT name, mobile from GroupDailyRespondents"

'response.write sql & "<br>"
'response.end
		  

	Dim iClick 
	Dim res
	Dim msg
	
	Server.ScriptTimeout = 20000
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	msgsql = "Select * from GroupDailyCorrespondence where [group] = 'Waikato' and [date] = #" & di.DI_format(now(),"dd mmm yyyy") & "#"
response.write msgsql & "<br>"
'response.end
	rs.open msgsql,db

	if rs.eof then
		response.write "No txt to send"
		rs.close
	else
		txt = rs("message")
		rs.close
		if txt = "" then
			txt = "no txt message"
			response.write "No txt message"
		else
			if live then
				Set iClick = Server.Createobject("M4USMS.SMS2")
				iclick.ServerMode = false
				res = iClick.SMSConnect("YouthForChris001","0244981")
			else
				res = 0
			end if
			If res <> 0 Then
			   Response.Write("Error no. " & res & " while trying to connect.")
			else
				if live then
					iClick.IDMode = 1 'userIDs: 1=System assigned, 2=User assigned
					iClick.AutoSplit = True
					valid = 168 '2 days
					'AddMessageEx([Number As String], [MsgText As String], [Delay As Long = -1], [Id As Long = -1], [Valid As Byte = Empty], [Report As Boolean = False]) As Long
				end if
				rs.Open sql, db
				do until rs.eof
					mobile = check_txt(rs("mobile"))
					if left(mobile,1) = "X" then
						bc = bc + 1
						response.write "<b><font color=""#FF0000"">" & rs("name") & " - " & mid(mobile,2) & " - invalid.</font></b><br>"
					else
						gc = gc + 1
						response.write rs("Name") & " - " & mobile & " - OK. " & id & "<br>"
						msg = convert(txt,0)
						response.write msg
						if live then
							res = iClick.AddMessageEx(cstr(mobile),cstr(msg),0)		
							If res <> 0 Then
							   Response.Write("A. Error no. " & res & " while trying to add a message.<br>")
							End If
							if gc mod 100 = 0 then
								res = iClick.SendMessages
								If res <> 0 Then
								   Response.Write("B. Error no. " & res & " while trying to send a message.<br>")
								Else
								   Response.Write(gc & " messages sent successfully.<br>")
								End If
							end if
						end if
					end if
					rs.movenext
				loop
				rs.close
			
				if live then
					if gc mod 100 <> 0 then
						res = iClick.SendMessages
						If res <> 0 Then
						   Response.Write("C. Error no. " & res & " while trying to send a message.<br>")
						Else
						   Response.Write(gc & " message sent successfully.<br>")
						End If
					end if
				end if
			
				response.write gc & " messages"
			end if
		end if
	end if
	set rs = nothing
	db.Close
	set db = nothing
	
	Set objMail = Server.CreateObject("CDONTS.NewMail")
	objMail.To = "d.white@incedo.org.nz, g.tichbon@incedo.org.nz"
	objMail.From = "prayer@incedo.org.nz"
	objMail.Subject = "Incedo group update was sent at " & now()
	objMail.Body = "<p>" & txt & "</p><p>" & gc & " messages</p>"
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing


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



