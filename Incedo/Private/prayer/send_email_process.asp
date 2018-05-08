<HTML><HEAD><title>Send email</title></HEAD>
<BODY>
 <%
'for each fld in request.form
' 	response.write "<br>" & fld & "=" & request.form(fld)
'next
'response.end
 
	Server.ScriptTimeout = 20000

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
		
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	if request.form("header") <> "" then
		if request.form("type") = "reminder" then
			link = "<p>You can ||membersoption||add prayer items by emailing <a href=""mailto:prayer@incedo.org.nz"">prayer@incedo.org.nz</a>"
			body = "<div align=""center""><table width=""90%"" border=""0""><tr><td><div align=""center""><img src=""http://www.incedo.org.nz/private/prayer/IncedoHeader2.gif""> </div></td></tr><tr><td>" & replace(request.form("header"),vbcrlf,"<br>") & "<br><br>" & link & "</td></tr></table></div><br>"
		else
			'session("addemail") = request.form("addemail")
			sql = "select prayerItem.*, prayerCategory.Category from prayerItem INNER JOIN prayerCategory ON prayerItem.CategoryID = prayerCategory.CategoryID where closed <> yes and expireon > now() order by itemid"
	
			rs.Open sql, db
			prayer = "" 
			do until rs.eof
				prayer = prayer & "<div align=""center""><table width=""100%"" border=""0"" cellpadding=""5"" cellspacing=""0"">"
				prayer = prayer & "<tr bgcolor=""" & request.form("titleclr") & """><td width=""15%"">" & rs("category") & "</td><td>" & rs("Title") & "</td></tr>"
				prayer = prayer & "<tr bgcolor=""" & request.form("contentclr") & """><td colspan=""2"">" & rs("narrative") & "</td></tr>"
				prayer = prayer & "</table></div><br>"
				rs.movenext
			loop
			rs.close
	'Birthdays
			birthdays = "<div align=""center""><strong><font color=""#FF0000"" size=""+2"">Birthdays</font></strong>"
			sql = "SELECT IIf([knownas] Is Not Null,[knownas],[firstname]) & ' ' & lastname AS name, Centre, email, mobile, Format([birthday],'dd mmm') as birthdate FROM People where birthday <> null and membershipdate <> null and category <> 'ceased' and CDate(Format(now(),'dd mmm ') & '2000') between CDate(Format([birthday],'dd mmm ') & '2000')-7 and CDate(Format([birthday],'dd mmm ') & '2000')+7  ORDER BY IIf(CDate(Format([birthday],'dd mmm ') & '2000')+7>=CDate(Format(Now(),'dd mmm ') & '2000'),0,1), CDate(Format([birthday],'dd mmm ') & '2000')"
			rs.Open sql, db
			birthdays = birthdays & "<table width=""70%"" border=""1"" cellpadding=""5"" cellspacing=""0"">"
			do until rs.eof
				if rs("email") & "" <> "" then
					birthemail = "<a href=""mailto:" & rs("email") & """>" &  rs("email") & "</a>"
				else
					birthemail = "&nbsp;"
				end if
				birthdays = birthdays & "<tr><td>" & rs("birthdate") & "</td><td>" & rs("name") & "</td><td>" & rs("centre") & "</td><td>" & birthemail & "</td><td>" & rs("mobile") & "</td></tr>"
				rs.movenext
			loop
			birthdays = birthdays & "</table></div><br>"
			rs.close
	'Passage
			if request.form("passage") = "" then
				passage = ""
			else
				passage = "<p>This months book is " & request.form("passage") & ". You maybe able to download audio chapters of " & request.form("passage") & " from <a href=""http://www.incedo.org.nz/private/bible"">www.incedo.org.nz/private/bible</a></div></p>"
			end if
	'Link
			link = "<p>You can ||membersoption||add prayer items by emailing <a href=""mailto:prayer@incedo.org.nz"">prayer@incedo.org.nz</a>"
		
			body = "<div align=""center""><table width=""90%"" border=""0""><tr><td><div align=""center""><img src=""http://www.incedo.org.nz/private/prayer/IncedoHeader2.gif""> </div></td></tr><tr><td>" & replace(request.form("header"),vbcrlf,"<br>") & "<br><br>" & prayer & birthdays & passage & replace(request.form("footer"),vbcrlf,"<br>") & link & "</td></tr></table></div><br>"
		end if
		
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		Set objTStream = objFSO.OpenTextFile(Server.Mappath(".") & "\prayer.txt",2,true)
		objTStream.WriteLine body
		objTStream.Close
		set objTStream = nothing
		set objFSO = nothing	
	else
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		Set objTStream = objFSO.OpenTextFile(Server.Mappath(".") & "\prayer.txt",1)
		body = objTStream.readall
		objTStream.Close
		set objTStream = nothing
		set objFSO = nothing	
	end if
	
	sql = "SELECT email, lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) AS UseFirstname, id, password from people where (category <> 'Ceased' and ((membershipdate is not null and prayer <> true) or (membershipdate is null and prayer = true))) or id = 60 order by lastname, IIf([knownas] Is Not Null,[knownas],[firstname])"' & session("addemail")
	live = request.form("live")
	nav = Request.QueryString("NAV")
	if live = "yes" or nav <> "" then
		badcnt = request.querystring("bc")
		if badcnt = "" then badcnt = 0
		batch = 10
		If Request.QueryString("NAV") = "" Then
			intPage = 1	
		else
			intPage = Request.QueryString("NAV")
		end if
				
		rs.CursorLocation = 3	'adUseClient
		rs.CursorType = 3		'adOpenStatic
		rs.ActiveConnection = db
				
		rs.Open sql, db
	
		rs.PageSize = batch	
		rs.CacheSize = rs.PageSize
		intPageCount = rs.PageCount 
		intRecordCount = rs.RecordCount 
		If CInt(intPage) > CInt(intPageCount) Then intPage = intPageCount
		If CInt(intPage) <= 0 Then intPage = 1
		If intRecordCount > 0 Then
			rs.AbsolutePage = intPage
			intStart = rs.AbsolutePosition
			If CInt(intPage) = CInt(intPageCount) Then
				intFinish = intRecordCount
			Else
				intFinish = intStart + (rs.PageSize - 1)
			End if
		End If
		If intRecordCount > 0 Then
			For intRecord = 1 to rs.PageSize
				email = rs("email")
				valid = check_email(email)
				if valid <> " OK." then
					'response.write "<b><font color=""#FF0000"">" & rs("usefirstname") & " " & rs("lastname") & " - " & email & " - " & valid & "</font></b><br>"
					badcnt = badcnt + 1
				else
if 1=1 then	
					Set objMail = Server.CreateObject("CDONTS.NewMail")
					objMail.To = email
					objMail.From = "prayer@incedo.org.nz"
					objMail.Subject = "Incedo Prayer update"
					if rs("id") = 0 then
						membersoption = ""
					else
						membersoption = "view and add prayer items at anytime at <a href=""http://www.incedo.org.nz/private/prayer"">www.incedo.org.nz/private/prayer</a> Your membership ID is ||id|| and password is ||password|| or " 
					end if
					usebody = replace(body,"||membersoption||",membersoption)
					usebody =  convert(usebody)
					objMail.Body = "<html><body>" & usebody & "</body></html>"
					objMail.MailFormat = 0
					objMail.BodyFormat = 0
					objMail.Send
					Set objMail = Nothing

end if
				end if
				rs.MoveNext
				If rs.EOF Then Exit for
			next
			response.write "<br>" & intFinish & " out of " & intRecordCount & " records done.<br>"
			rs.Close
			If cInt(intPage) < cInt(intPageCount) Then
				Response.Write "<form name=""redirect"">" & vbcrlf
				Response.Write "<center>" & vbcrlf
				Response.Write "<b>The next batch of " & batch & " email will be sent in <input type=""text"" size=""3"" name=""redirect2""> seconds</b> - Done/Stop(ped) <input type=""radio"" name=""done"" value=""done"">" & vbcrlf
				Response.Write "</center>" & vbcrlf
				Response.Write "</form>" & vbcrlf
				Response.Write "<script>" & vbcrlf
				thepage = "http://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL") & "?nav=" & intPage + 1 & "&bc=" & badcnt
				thepage = replace(thepage,"\","\\")
				Response.Write "var targetURL = '" & thepage & "'" & vbcrlf
				Response.Write "var countdownfrom=5" & vbcrlf
				Response.Write "var currentsecond=document.redirect.redirect2.value=countdownfrom+1" & vbcrlf
				Response.Write "function countredirect(){" & vbcrlf
				Response.Write "if (document.redirect.done.checked == true) {" & vbcrlf
				Response.Write "	return" & vbcrlf
				Response.Write "}" & vbcrlf
				Response.Write "	if (currentsecond!=1){" & vbcrlf
				Response.Write "		currentsecond-=1" & vbcrlf
				Response.Write "		document.redirect.redirect2.value=currentsecond" & vbcrlf
				Response.Write "	}" & vbcrlf
				Response.Write "	else {" & vbcrlf
				Response.Write "		document.redirect.done.checked = true;" & vbcrlf
				Response.Write "		window.location=targetURL;" & vbcrlf
				Response.Write "		return" & vbcrlf
				Response.Write "	}" & vbcrlf
				Response.Write "	setTimeout('countredirect()',1000)" & vbcrlf
				Response.Write "}" & vbcrlf
				Response.Write "countredirect()" & vbcrlf
				Response.Write "</script>" & vbcrlf
			else
				response.write "<br>" & badcnt & " invalid email addresses."
			end if
		end if
	else
		response.write body
		response.write "<hr>"
		rs.Open sql, db
		bc = 0
		gc = 0
		do until rs.eof
			email = rs("email")
			invalid = check_email(email)
			if invalid <> " OK." then
				bc = bc + 1
				response.write "<b><font color=""#FF0000"">" & rs("usefirstname") & " " & rs("lastname") & " - " & email & " - " & invalid & "</font></b><br>"
			else
				gc = gc + 1
				response.write rs("usefirstname") & " " & rs("lastname") & " - " & email & " - " & invalid & "<br>"
			end if
			rs.movenext
		loop
		response.write "<p>" & gc & " To send<br>"
		response.write "<p>" & bc & " Invalid addresses<br>"
	end if
	set rs = nothing
	db.Close
	set db = nothing

function check_email(str)
	if isnull(str) then
		check_email = " No Address."
		exit function
	end if

	len_str = len(str)
	at_pos = instr(str,"@")
	dot_pos = instr(str,".")
	check_email =  ""

	if len_str < 5 then
		check_email =  " Too short."
		exit function
	end if
			
	if at_pos = 0 then
		check_email =  " No @ symbol."
		exit function
	end if
						
	if instr(at_pos+1,str,"@") then
		check_email =  " More than 1 @ symbol."
		exit function
	end if
			
	if dot_pos = 0 then			
		check_email =  " No Dot."
		exit function
	end if
						
	if dot_pos = 1  then			
		check_email =  " Dot is first character."
		exit function
	end if

	if dot_pos = len_str then			
		check_email =  " Dot is last charater."
		exit function
	end if

	if mid(str,at_pos-1,1) = "."  then
		check_email =  " Dot is first character before @ symbol."
		exit function
	end if
				
	if mid(str,at_pos+1,1) = "." then
		check_email =  " Dot is first character after @ symbol."
		exit function
	end if

	if instr(str," ") then
		check_email =  " There is a space."
		exit function
	end if
	
	check_email =  " OK."
	
												
end function

Function convert(pass_text)
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
'response.write fieldname
            new_message = new_message & rs(fieldname)
            c1 = c1 + c2 + 1
        Else
            new_message = new_message & Mid(pass_text, c1, 1)
        End If
    Loop
    convert = new_message

End Function

%> 
 
</BODY>
</HTML>



