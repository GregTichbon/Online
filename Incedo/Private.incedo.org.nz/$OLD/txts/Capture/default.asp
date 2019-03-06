<%
	'Number = 8244
	'msg = trim(mid(request.querystring("msg"),4))
	'http://www.incedo.org.nz/private/txts/capture/?msg=Soxweather&mobile=0274266494&to=8244 Note the tag (INZ) does not come through
	msg = request.querystring("msg")
	msgnospaces = lcase(replace(msg," ",""))
	mobile = request.querystring("mobile")
	set di = server.createobject("DI.IIS")
	select case true
		case left(msgnospaces,4) = "test"
			message = "Thanks - you've just spent 20c on a test - you must be made of money!"
			respondto(message)
		case left(msgnospaces,6) = "summer"
			message = "Thanks - you're in the draw!"
			respondto(message)
		case left(msgnospaces,8) = "mymentor"
			message = "Thanks - we appreciate you taking the time to let us know who has had a significant input into your life."
			respondto(message)
		case left(msgnospaces,9) = "beamentor"
			message = "Thanks - we appreciate you taking the time to offer yourself to be a mentor, we will be in touch."
			respondto(message)
		case left(msgnospaces,6) = "soxset"
			message = mid(msg,findstart("soxset"))
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objTStream = objFSO.OpenTextFile("e:\homepage\incedo\private\txts\capture\soxweather.txt", 2, True)
			objTStream.writeLine(message)
			objTStream.Close
			set objFSO = nothing
			respondto(message)
		case msgnospaces = "soxweather"
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objTStream = objFSO.OpenTextFile("e:\homepage\incedo\private\txts\capture\soxweather.txt", 1)
			message = objTStream.readall
			objTStream.Close
			set objFSO = nothing
			respondto(message)
		case left(msgnospaces,2) = "y1" and 1=2
			connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\YFCNZ\y-one.mdb;"
			Set db = Server.CreateObject("ADODB.Connection")
			db.Open connection_string
			if msgnospaces = "y1" then 'schedule
				set fs = server.CreateObject("Scripting.FileSystemObject")
				set ts = fs.OpenTextFile(Server.MapPath("y1Schedule.txt"),1)
				message = ts.readall
				ts.Close
				set ts = nothing
				set fs = nothing
				db.execute "INSERT INTO Texts (Mobile, [DateTime], Message, [Type]) SELECT '" & mobile & "', Now(), '" & Message & "', 'Schedule'"
			elseif left(msgnospaces,7) = "y1start" then
				duration = mid(msgnospaces,8)
				db.execute "INSERT INTO VoteControl (VoteStart, VoteEnd) SELECT Now(), DateAdd('n'," & duration & ",Now())"
				message = "Running for " & duration & " minutes"
			elseif msgnospaces = "y1results" then
				Set rs = Server.CreateObject("ADODB.RecordSet")
				'sql = "SELECT top 1 VoteStart, VoteEnd FROM VoteControl WHERE VoteEnd < Now() ORDER BY VoteStart DESC"
				sql = "SELECT top 1 VoteStart, VoteEnd FROM VoteControl ORDER BY VoteStart DESC"
				rs.Open sql, db
				votestart = di.di_format(rs("votestart"),"dd mmm yyyy hh:mm:ss")
				voteend = di.di_format(rs("voteend"),"dd mmm yyyy hh:mm:ss")
'response.write voteend & "<br>" & now() & "<br>"
				elapsed = datediff("s",rs("voteend"),now())
				mins = int(abs(elapsed) / 60)
				secs = abs(elapsed) - (mins * 60)
				mins = mins & ":" & right("0" & secs,2)
				if elapsed < 0 then
					elapsedmsg = "Still running: " & mins & " minutes to go"
				else
					elapsedmsg = "Finished " & mins & " minutes ago"
				end if
				rs.close
				sql = "SELECT [Message], Sum(1) AS Votes FROM Texts WHERE [DateTime] Between #" & votestart & "# And #" & voteend & "# AND [Type] = 'Vote' GROUP BY [Message]"
'response.write sql & "<br>"
'response.end
				rs.Open sql, db
				message = "Results" & vbcrlf & elapsedmsg & vbcrlf
				do until rs.eof
					message = message & rs("message") & "=" & rs("votes") & vbcrlf
					rs.movenext
				loop
				rs.close
				set rs = nothing
			elseif len(msgnospaces) = 3 and (right(msgnospaces,1) = "a" or right(msgnospaces,1) = "b") then 'voting
				Set rs = Server.CreateObject("ADODB.RecordSet")
				sql = "SELECT count(*) as running FROM VoteControl where now() between votestart and voteend"
				rs.Open sql, db
				if rs("running") = 0 then
					usetype = "Invalid Vote"
					message = "I'm sorry voting is not currently activated"
				else
					usetype = "Vote"
					message = "Thank you for your vote"
				end if
				db.execute "INSERT INTO Texts (Mobile, [DateTime], Message, [Type]) SELECT '" & mobile & "', Now(), '" & right(msgnospaces,1) & "', '" & usetype & "'"
			else
				db.execute "INSERT INTO Texts (Mobile, [DateTime], Message, [Type]) SELECT '" & mobile & "', Now(), '" & msg & "', 'Unknown'"
				message = "I'm sorry, I didn't understand your message"
			end if
			respondto(message)
			db.close
			set db = nothing
		case left(msgnospaces,4) = "fuse" and 1=2
			connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\fuse\fuse2008.mdb;"
			Set db = Server.CreateObject("ADODB.Connection")
			db.Open connection_string
			sql = "INSERT INTO [TXTS] (message), Mobile, [datetime]) SELECT '" & mid(msg,5) & "', '" & mobile & "', '" & di.di_format(dateadd("h",4,now()),"dd mmm yyyy hh:mm:ss") & "'"
'response.write sql			
'response.end
			db.execute sql
			db.close
			set db = nothing
			message = "Thanks from Fuse"
			respondto(message)
		case else	
			message = "I'm sorry, I didn't understand your message"
			respondto(message)
	end select

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\incedo\txtscaptured.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	message = replace(message,"'","''")
	msg = replace(msg,"'","''")
	sql = "INSERT INTO TXTS (Message, Mobile, [datetime], response) SELECT '" & msg & "', '" & mobile & "', '" & di.di_format(dateadd("h",4,now()),"dd mmm yyyy hh:mm:ss") & "', '" & message & "'"
'response.write sql			
'response.end
	db.execute sql
	db.close
	set db = nothing
	set di = nothing

	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objTStream = objFSO.OpenTextFile("e:\homepage\incedo\private\txts\capture\received.txt", 8, True)
	objTStream.writeLine(now() & "|" & mobile & "|" & msg & "|" & message)
	objTStream.Close
	set objFSO = nothing
	
function findstart(header)
	findstart = 0
	myheader = ""
	for f1=1 to len(msg)
		mychar = mid(msg,f1,1)
		if mychar <> " " then
			myheader = myheader & mychar
			if lcase(myheader) = lcase(header) then
				for f2=f1+1 to len(msg)
					if mid(msg,f2,1) <> " " then
						findstart = f2
						exit function
					end if
				next
			end if
		end if
	next
end function

function respondto(message)
	'method = "response"
	method = "post"
	if method = "response" then
		response.write message
	elseif method = "post" then
		data = "<?xml version='1.0' encoding='UTF-8'?>"
		data = data & "<send>"
		data = data & "<message>"
		data = data & "<timestamp>" & di.di_format(now(),"yyyymmddhhnnss") & "</timestamp>"
		data = data & "<userId>incedo</userId>"
		data = data & "<password>Aeraixe3</password>"
		data = data & "<messageId>" & di.di_format(now(),"yyyymmddhhnnss") & "</messageId>"
		data = data & "<to>" & mobile & "</to>"
		data = data & "<from>8244</from>"
		data = data & "<inReplyToId/>"
		data = data & "<deliveryInstruction/>"
		data = data & "<processingInstruction/>"
		data = data & "<rateCode/>"
		data = data & "<body>" & message & "</body>"
		data = data & "</message>"
		data = data & "<environment>0</environment>"
		data = data & "<application>Incedo</application>"
		data = data & "</send>"
		url = "https://www.lateralnz.com/HTTP/LateralServer/?XML=" & data

		set xmlhttp = CreateObject("Msxml2.ServerXMLHTTP.3.0") 
		xmlhttp.open "GET", url, false, "incedo", "Aeraixe3" 
		xmlhttp.send "" 
		answer = xmlhttp.responseText 
		set xmlhttp = nothing 
		
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		Set objTStream = objFSO.OpenTextFile("e:\homepage\incedo\private\txts\capture\debug.txt", 8, True)
		objTStream.writeLine(url)
		objTStream.writeLine("")
		objTStream.writeLine(answer)
		objTStream.writeLine("-------------------------------------------------------------------------------------------------------------")
		objTStream.Close
		set objFSO = nothing
	end if

end function
%>	
