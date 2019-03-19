***
<%

	Dim iClick 
	Dim res
	Dim msg
	
	Server.ScriptTimeout = 20000
	Set iClick = Server.Createobject("M4USMS.SMS2")
	iclick.ServerMode = false
	res = iClick.SMSConnect("YouthForChris001","0244981")
	If res <> 0 Then
	    Response.Write("Error no. " & res & " while trying to connect.")
	else
		iClick.IDMode = 1 'userIDs: 1=System assigned, 2=User assigned
		valid = 168 '2 days
		'AddMessageEx([Number As String], [MsgText As String], [Delay As Long = -1], [Id As Long = -1], [Valid As Byte = Empty], [Report As Boolean = False]) As Long
		mobile = check_txt("0272495088")
		if left(mobile,1) = "X" then
			response.write "Invalid Number"
		else
			msg = "Test"
			res = iClick.AddMessageEx(cstr(mobile),cstr(msg),0)		
			If res <> 0 Then
				Response.Write("A. Error no. " & res & " while trying to add a message.<br>")
			else
				res = iClick.SendMessages
				If res <> 0 Then
				   Response.Write("B. Error no. " & res & " while trying to send a message.<br>")
				End If
			end if
		end if
	end if

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


%>
