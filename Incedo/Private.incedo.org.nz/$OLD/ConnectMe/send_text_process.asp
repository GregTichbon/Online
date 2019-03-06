<HTML><HEAD><title>Send txt</title></HEAD>
<BODY bgcolor="#99FFFF">
<%
	Dim iClick 
	Dim res
	Dim msg
	
	database = "e:\$generic\incedo\connectme.mdb"
	
	live = request.form("live")
	sql = request.form("sql")
	txt = request.form("txt")
	mobilenumber = request.form("mobilenumber")
	idfld = request.form("id")
	batch = request.form("batch")

	Server.ScriptTimeout = 20000
	set di = server.createobject("DI.IIS")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & database
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	
if live = "yes" then
	Set iClick = Server.Createobject("M4USMS.SMS2")
	iclick.ServerMode = false
	res = iClick.SMSConnect("YouthForChris001","0244981")
	'res = iClick.SMSConnect("loadtest03","katherine")
	If res <> 0 Then
	   Response.Write("Error no. " & res & " while trying to connect.")
	   response.end
	End If
	
	iClick.IDMode = 2 'userIDs: 1=System assigned, 2=User assigned
	valid = 168 '2 days
	'AddMessageEx([Number As String], [MsgText As String], [Delay As Long = -1], [Id As Long = -1], [Valid As Byte = Empty], [Report As Boolean = False]) As Long
end if	
	rs.Open sql, db
	do until rs.eof
		mobile = check_txt(rs(mobilenumber))
		if left(mobile,1) = "X" then
			bc = bc + 1
			response.write "<b><font color=""#FF0000"">" & mid(mobile,2) & " - invalid.</font></b><br>"
		else
			gc = gc + 1
			id = di.DI_format(batch,"0000") & di.DI_format(rs(idfld),"00000")
			response.write mobile & " - OK. " & id & "<br>"
			msg = convert(txt,0)
if live = "yes" then
			res = iClick.AddMessageEx(cstr(mobile),cstr(msg),0,clng(id),cbyte(valid),false)		
			If res <> 0 Then
			   Response.Write("Error no. " & res & " while trying to add a message.<br>")
			End If
			if gc mod 100 = 0 then
				res = iClick.SendMessages
				If res <> 0 Then
				   Response.Write("Error no. " & res & " while trying to send a message.<br>")
				Else
				   Response.Write(gc & " messages sent successfully.<br>")
				End If
			end if
end if
		end if
		rs.movenext
	loop
	rs.close
	set rs = nothing
	db.Close
	set db = nothing

if live = "yes" then
	if gc mod 100 <> 0 then
		res = iClick.SendMessages
		If res <> 0 Then
		   Response.Write("Error no. " & res & " while trying to send a message.<br>")
		Else
		   Response.Write(gc & " message sent successfully.<br>")
		End If
	end if
end if
response.write gc & " messages"

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
</BODY>
</HTML>