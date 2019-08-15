***
<%
	set di = server.createobject("DI.IIS")
	
	'theday = di.di_format(now(),"ddd")
	'if theday = "Mon" and theday <> "Wed" and theday <> "Fri" then
	'	response.end
	'end if

	if request.querystring("test") = "" then
		live = true
	else
		live = false
	end if


'response.write sql & "<br>"
'response.end
		  

	Dim iClick 
	Dim res
	Dim msg
	
	Server.ScriptTimeout = 20000
	'connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\datainn.co.nz\VehicleReminders.mdb"
	 connection_string = "Provider=SQLOLEDB;Data Source=VM29E6AC2\MSSQLSERVER2016; Initial Catalog = DataInnovations; User Id = Online; Password=Online"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	db.execute "truncate table VehicleAlerts"
	Set rs = Server.CreateObject("ADODB.Recordset")
	msgsql = "Select * from vehicle"' where registration = 'J224N'"
'response.write msgsql & "<br>"
'response.end
	rs.open msgsql,db
'response.write msgsql & "<br>"
'response.end
	if rs.eof then
		response.write "No Vehicles Loaded"
	else
		do until rs.eof
			if rs("WOFDue") & "" <> "" then
				daystowof = datediff("d",cdate(rs("WOFDue")),date())
				if daystowof >= -7 or daystowof = 7 or daystowof = 14 then
					if now() >= rs("HoldEmailTill") or rs("HoldEmailTill") & "" = "" then
						if not live then
							response.write "<br>1. " & now() & "|" & rs("HoldEmailTill") & "<br>"
						end if
						recipientarray = split(replace(rs("email") & ""," ",""),";")
						for each recipient in recipientarray
							sql = "INSERT INTO VehicleAlerts ( Email, Type, Due, Registration, Description ) " & _
									"SELECT '" & recipient & "', 'WOF', Vehicle.WOFDue, Vehicle.Registration, Vehicle.Description " & _
									"FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
							db.execute sql
							if not live then
								response.write "<p>" & sql & "</p>"
							end if
						next
					end if
					if now() >= rs("HoldMobileTill") or rs("HoldMobileTill") & "" = "" then
						if not live then
							response.write "<br>2. " & now() & "|" & rs("HoldMobileTill") & "<br>"
						end if
						recipientarray = split(replace(rs("mobile")&""," ",""),";")
						for each recipient in recipientarray
							sql = "INSERT INTO VehicleAlerts ( Mobile, Type, Due, Registration, Description ) " & _
									"SELECT '" & recipient & "', 'WOF', Vehicle.WOFDue, Vehicle.Registration, Vehicle.Description " & _
									"FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
							db.execute sql
							if not live then
								response.write "<p>" & sql & "</p>"
							end if
						next
					end if
				end if
			end if
			if rs("registrationDue") & "" <> "" then
				daystoreg = datediff("d",cdate(rs("registrationDue")),date())
				if daystoreg >= -7 or daystoreg = 7 or daystoreg = 14 then
					if now() >= rs("HoldEmailTill") or rs("HoldEmailTill") & "" = "" then
						if not live then
							response.write "<br>3. " & now() & "|" & rs("HoldEmailTill") & "<br>"
						end if						
						recipientarray = split(replace(rs("email") & ""," ",""),";")
						for each recipient in recipientarray
							sql = "INSERT INTO VehicleAlerts ( Email, Type, Due, Registration, Description ) " & _
									"SELECT '" & recipient & "', 'Registration', Vehicle.registrationDue, Vehicle.Registration, Vehicle.Description " & _
									"FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
							db.execute sql
							if not live then
								response.write "<p>" & sql & "</p>"
							end if
						next
					end if
					if now() >= rs("HoldEmailTill") or rs("HoldEmailTill") & "" = "" then
						if not live then
							response.write "<br>4. " & now() & "|" & rs("HoldEmailTill") & "<br>"
						end if
						recipientarray = split(replace(rs("mobile") & ""," ",""),";")
						recipientarray = split(replace(rs("mobile") & ""," ",""),";")
						for each recipient in recipientarray
							sql = "INSERT INTO VehicleAlerts ( mobile, Type, Due, Registration, Description ) " & _
									"SELECT '" & recipient & "', 'Registration', Vehicle.registrationDue, Vehicle.Registration, Vehicle.Description " & _
									"FROM Vehicle where vehicle_ctr = " & rs("vehicle_ctr")
							db.execute sql
							if not live then
								response.write "<p>" & sql & "</p>"
							end if
						next
					end if
				end if
			end if
			rs.movenext
		loop
		rs.close

		if not live then
			sql = "select * from VehicleAlerts order by registration"
			rs.open sql, db
			if not rs.eof then
				line = "<table>"
				do until rs.eof
					line = line & "<tr>"
					for each fld in rs.fields
						line = line & "<td>" & fld & "</td>"
					next
					line = line & "</tr>"
					rs.movenext
				loop
				line = line & "</table>"
			end if
			rs.close
			response.write line
		end if

		sql = "select * from VehicleAlerts where isnull(email,'') <> '' order by email, due"
		rs.open sql, db
		if not rs.eof then
			lastrecipient = "" 
			delim = ""
			msg = "Vehicle Alerts<br><br>"
			do until rs.eof
				if rs("email") <> lastrecipient and lastrecipient <> "" then
					sendemail lastrecipient,msg,live
					msg = "Vehicle Alerts<br><br>"
					delim = ""
				end if
				lastrecipient = rs("email")
				msg = msg & delim & rs("type") & " due for " & rs("registration") & " - " & rs("description") & " on " & di.di_format(rs("due"),"d mmm yyyy")
				delim = "<br><br>"
				rs.movenext
			loop
			sendemail lastrecipient,msg,live
			rs.close
		end if
		
if 1=2 then
		Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
	
		sql = "select * from VehicleAlerts where isnull(mobile,'') <> '' order by mobile, due"
		rs.open sql, db
		if not rs.eof then
			if 1=2 then
				Set iClick = Server.Createobject("M4USMS.SMS2")
				iclick.ServerMode = false
				res = iClick.SMSConnect("YouthForChris001","0244981")
				if res <> 0 then
					Response.Write("Error no. " & res & " while trying to connect.")
					response.end
				end if		
				iClick.IDMode = 1 'userIDs: 1=System assigned, 2=User assigned
				valid = 168 '2 days
				
				lastrecipient = "" 
				delim = ""
			end if
			msg = "Vehicle Alerts: "
			do until rs.eof
				if rs("mobile") <> lastrecipient and lastrecipient <> "" then
					mobile = check_txt(lastrecipient)
					if left(mobile,1) = "X" then
						bc = bc + 1
						response.write "<b><font color=""#FF0000"">" & mid(mobile,2) & " - invalid.</font></b><br>"
					else
						gc = gc + 1
						response.write mobile & " - OK. " & id & "<br>"
						'msg = convert(txt,0)
						if live then
							if 1=2 then
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
							NewURLBase = "http://office.datainn.co.nz/?P=" & mobile & "&M="
							
							NewURL = NewURLBase & msg
							response.write "<br>" & NEWURL						
							objXMLHTTP.Open "GET", replace(NewURL," ","%20"), False
							objXMLHTTP.Send
							
							strPageText = objXMLHTTP.responseText							
							response.write "<br>" & strPageText							
						else
							response.write msg & "<br>______________________________________________<br>"
						end if
					end if
					msg = "Vehicle Alerts: "
					delim = ""
				end if
				lastrecipient = rs("mobile")
				msg = msg & delim & rs("type") & ":" & rs("registration") & "-" & di.di_format(rs("due"),"ddmmm")
				delim = " - "
				rs.movenext
			loop
			mobile = check_txt(lastrecipient)
			if left(mobile,1) = "X" then
				bc = bc + 1
				response.write "<b><font color=""#FF0000"">" & mid(mobile,2) & " - invalid.</font></b><br>"
			else
				gc = gc + 1
				response.write mobile & " - OK. " & id & "<br>"
				'msg = convert(txt,0)
				if live then
					if 1=2 then
						res = iClick.AddMessageEx(cstr(mobile),cstr(msg),0)		
						If res <> 0 Then
						   Response.Write("A. Error no. " & res & " while trying to add a message.<br>")
						End If
						res = iClick.SendMessages
						If res <> 0 Then
						   Response.Write("B. Error no. " & res & " while trying to send a message.<br>")
						Else
						   Response.Write(gc & " messages sent successfully.<br>")
						End If
					end if
					NewURLBase = "http://office.datainn.co.nz/?P=" & mobile & "&M="

					NewURL = NewURLBase & msg & " http://datainn.co.nz/vehiclereminders"
					response.write "<br>" & NEWURL						
					objXMLHTTP.Open "GET", replace(NewURL," ","%20"), False
					objXMLHTTP.Send

					strPageText = objXMLHTTP.responseText							
					response.write "<br>" & strPageText							
				else
					response.write msg & "<br>______________________________________________<br>"
				end if
			end if
			rs.close
		end if
end if
		
	end if
	set rs = nothing
	db.Close
	set db = nothing
	
	set di = nothing
	
	
	


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

function sendemail (email,msg,live)
if live or 1 = 1 then
	Set objMail = Server.CreateObject("CDONTS.NewMail")
	objMail.To = email
	objMail.From = "greg@datainn.co.nz" '"gtichbon@teorahou.org.nz"
	objMail.Subject = "Vehicle updates: " & di.di_format(date(),"d mmmm yyyy")
	objMail.Body = "<p>" & msg & "</p><p><a href=""http://datainn.co.nz/vehiclereminders"">Vehicle Reminders</a></p>"
	objMail.MailFormat = 0
	objMail.BodyFormat = 0
	objMail.Send
	Set objMail = Nothing
	response.write "<br>Email sent to: " & email & "<br>"
else
	response.write email & "-" & msg & "<br>______________________________________________<br>"
end if
end function


%>
