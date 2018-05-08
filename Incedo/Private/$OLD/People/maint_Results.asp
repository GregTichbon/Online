<HTML><HEAD></HEAD>
<BODY>

<%
'for each frm in request.form
'	response.write frm & "=" & request.form(frm) & "<br>"
'next
'response.end
'response.write request.queryform("uploadphoto")
'response.end
		set di = server.createobject("DI.IIS")

		if request.form("$create") = "Create" then
			mode = "create"
		elseif Request.Form("$modify") = "Modify/Confirm" then
			if request.form("$changed") = "unchanged" then
				mode = "confirm"
			else
				mode = "modify"
			end if
		elseif Request.Form("$delete") = "Delete" then
			mode = "delete"
		'elseif Request.Form("$confirm") = "Confirm" then
		'	mode = "confirm"
		else
			Response.write Request.Form("$submit") & "Unknown Action"
			Response.End
		end if
'response.write mode
'response.end
		id = request.form("id")
		centre = Request.Form("centre")
		if Request.Form("movedtocentre") <> "" then
			centre = centre & "/" & Request.Form("movedtocentre")
		end if
		
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "people", db, 1, 2
			if mode = "modify" or mode = "delete" or mode = "confirm" then
				.filter = "id = " & id
			end if
			if mode = "delete" then
				.delete
			elseif mode = "modify" or mode = "create" or mode = "confirm" then
				if mode <> "confirm" then
					if mode = "create" then
						.AddNew
					end if
					flds = array("lastname","firstname","othernames","knownas","gender","address","postaladdress","phonehome","phoneministry","phonework","phoneyfc","mobile","email","category","workplace","movedtocentre","notes","membershipdate","additionalemail","prayer","membersupdate","dailytexts","profile","notnzcitizen","skype","msn") ',"parent","spouse"				
on error resume next
					for each fldname in flds
'Response.Write fldname & "=" & Request.Form(fldname) & "<br>"
						if Request.Form(fldname) = "" then
							if fldname = "prayer" or fldname = "membersupdate" or fldname = "dailytexts" or fldname = "notnzcitizen" then
								.Fields(fldname) = false
							else
								.Fields(fldname) = null
							end if
						else
							.fields(fldname) = Request.Form(fldname)
						end if
if err.number <> 0 then 
	Response.Write err.description & "|" & fldname & "=" & Request.Form(fldname) & "|<br>"
	response.end
end if				
					next
on error goto 0
'Response.End 		
'Response.Write di.di_format(request.form("birthdate"),"dd mmm yyyy")
'Response.End 
					if request.form("birthdate") = "" then
						.Fields("birthday") = null
						.Fields("Birthyear") = null
					else
						.Fields("birthday") = di.di_format(request.form("birthdate"),"dd mmm yyyy")
						.Fields("Birthyear") = di.DI_format (request.form("birthdate"),"yyyy")
					end if
					if request.form("appointmentceased") = "" then
						.Fields("appointmentceased") = null
					else
						.Fields("appointmentceased") = di.DI_format (request.form("appointmentceased"),"dd mmm yyyy")
					end if
					centre = Request.Form("centre")
					if Request.Form("movedtocentre") <> "" then
						centre = centre & "/" & Request.Form("movedtocentre")
						.Fields("Centre") = Request.Form("movedtocentre")
						.Fields("movedtocentre") = null	
					else
						.Fields("Centre") = Request.Form("centre")
					end if
					if Request.Form("$dailytexttime") <> "" then
						dailytexttime = split(Request.Form("$dailytexttime"),":")
						.fields("dailytexttime") = dailytexttime(0) * 60 + dailytexttime(1)
					end if	
					if Request.Form("$password") <> "" then
						.fields("password") = Request.Form("$password")
					else
						if mode = "create" then
							.fields("password") = DI.DI_GeneratePassword(6,6)						
						end if
					end if
				end if
				.Fields("verified_by") = "Webpage"
				.Fields("verified_date") = now()
				.Update
				Id = .Fields("ID")
			end if
		end with
		rs.close
'response.write id
'response.end

if 1=2 then
		if mode <> "confirm" then
			db.Execute("delete * from people_ministry where id = " & id)
			rs.Open "people_ministry",db,1,2
			for f1=1 to 10
				if Request.Form("ministry" & f1) <> "---Please Select---"  and Request.Form("ministry" & f1) <> "---Remove---" then
					rs.AddNew 
					rs.Fields("id") = id
					rs.Fields("ministry") = Request.Form("ministry" & f1)
					rs.Fields("title") = Request.Form("title" & f1)
					rs.Update
				end if
			next 
			rs.Close 
		end if
end if

if 1=1 then
	if mode = "delete" then
		sql = "delete * from People_ministry where person = " & id
		db.execute sql
	else
		ministryidsstr = request.form("$ministryid")
		if ministryidsstr = "" then
			delministryids = 0
		else
			delministryids = ministryidsstr
		end if
		sql = "delete * from People_ministry where id in ( " & _
		"SELECT ID " & _
		"FROM people_ministry " & _
		"WHERE person = " & id & " AND id Not In (" & delministryids & "))"
		
'response.write sql
'response.end
	
		db.execute sql
	
		if ministryidsstr <> "" then
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open "People_ministry", db, 1, 2
			ministryid = split(request.form("$ministryid"),", ")
			ministryministry = split(request.form("$ministryministry"),", ")
			ministrytitle = split(request.form("$ministrytitle"),", ")
			for f1=0 to ubound(ministryid) 
				if ministryid(f1) <> 0 then
					rs.filter = "id = " & ministryid(f1)
					if rs.eof then
						rs.addnew
						rs.Fields("person") = id
					end if
				else
					rs.AddNew 
					rs.Fields("person") = id
				end if
				rs.Fields("ministry") = ministryministry(f1)
				rs.Fields("title") = replace(ministrytitle(f1),chr(8),",") 
				rs.Update
			next 
			rs.close
			set rs = nothing
		end if
	end if

end if		
		
if 1=1 then
	if mode = "delete" then
		sql = "delete * from People_links where person = " & id
		db.execute sql
	else
		linkidsstr = request.form("$linkid")
		if linkidsstr = "" then
			dellinks = 0
		else
			dellinks = linkidsstr
		end if
		sql = "delete * from people_links where id in ( " & _
		"SELECT ID " & _
		"FROM people_links " & _
		"WHERE person = " & id & " AND id Not In (" & dellinks & "))"
		
	'response.write sql
	'response.end
	
		db.execute sql
	
		if linkidsstr <> "" then
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open "people_links", db, 1, 2
			linkids = split(request.form("$linkid"),", ")
			linklink = split(request.form("$linklink"),", ")
			linkdescription = split(request.form("$linkdescription"),", ")
			for f1=0 to ubound(linkids) 
				if linkids(f1) <> 0 then
					rs.filter = "id = " & linkids(f1)
					if rs.eof then
						rs.addnew
						rs.Fields("person") = id
					end if
				else
					rs.AddNew 
					rs.Fields("person") = id
				end if
				rs.Fields("link") = replace(linklink(f1),chr(8),",") 
				rs.Fields("description") = replace(linkdescription(f1),chr(8),",") 
				rs.Update
			next 
			rs.close
			set rs = nothing
		end if
	end if

end if		
		
		
		set rs = nothing
		db.Close
		set db = nothing

		set fp = CreateObject("Scripting.Dictionary") 
		if mode = "confirm" then
			status = "No changes, confirmation only"
		else
			status = "Changes made"
		end if
		fp.Add "status", status
		if request.form("prayer") = "true" then
			prayer = "Yes"
		else
			prayer = "No"
		end if
		fp.Add "prayer", prayer
		if request.form("membersupdate") = "true" then
			membersupdate = "Yes"
		else
			membersupdate = "No"
		end if
		fp.Add "membersupdate", membersupdate
		if request.form("dailytexts") = "true" then
			dailytexts = "Yes"
		else
			dailytexts = "No"
		end if
		fp.Add "dailytexts", dailytexts
		if request.form("notnzcitizen") = "true" then
			notnzcitizen = "Yes"
		else
			notnzcitizen = "No"
		end if
		fp.Add "notnzcitizen", notnzcitizen
'response.write request.form("membersupdate")
'response.write request.form("prayer")
		'fp.Add "birthdate", di.di_format(request.form("birthdate"),"dd mmm yyyy")
		set fs = server.CreateObject("Scripting.FileSystemObject")
			
		set ts = fs.OpenTextFile(Server.MapPath("acknowledgment.htm"),1)
		info = convert(ts.readall)
		
		if Request.Form("$delete") = "Delete" then
			info = "The following record has been DELETED<br>" & info
		end if
		info = info & "<table border=""1"" cellpadding=""5"" cellspacing=""2"">"
		info = info & "<tr><td width=""300""><strong>Ministry</strong></td><td width=""300""><strong>Title</strong></td></tr>"

		for f1=1 to 10
			if Request.Form("ministry" & f1) <> "---Please Select---"  and Request.Form("ministry" & f1) <> "---Remove---" then
				info = info & "<tr><td>" & Request.Form("ministry" & f1) & "</td><td>" & Request.Form("title" & f1) & "</td></tr>"
			end if
		next 
		info = info & "</table>"
			
		ts.Close
		set ts = nothing
		set fs = nothing
		
if 1=1 then
		if mode <> "confirm" then
			useto = "; mlt@incedo.org.nz"
		else
			useto = ""
		end if
		Set objMail = Server.CreateObject("CDONTS.NewMail")
		objMail.To = "neo@incedo.org.nz" & useto
		objMail.From = "webmaster@incedo.org.nz"
		objMail.Subject = "Incedo people maintenance - " & centre & " - " & Request.Form("lastname") & ", " & Request.Form("firstname")
		objMail.Body = info
		objMail.MailFormat = 0
		objMail.BodyFormat = 0
		objMail.Send
		Set objMail = Nothing
end if

	set di = nothing
	
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
		            parms = split(fieldname,"|")
		            select case lcase(parms(0))
						case "rf" 'request.form
							new_message = new_message & replace(request.form(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
						case "sd" 'scripting dictionary
							new_message = new_message & replace(fp.Item(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
						case "rq" 'request.query
							new_message = new_message & replace(request.querystring(parms(1)),vbcrlf,"<br>")' & "&nbsp;"
						case else
							new_message = new_message & "Unknown Paramater 1 - " & lcase(parms(0))
					end select
		            c1 = c1 + c2 + 1
		        Else
		            new_message = new_message & Mid(pass_text, c1, 1)
		        End If
		    Loop
		    convert = new_message

		End Function			

		'Response.Write info
		response.redirect "default.asp"
%>		
</BODY>
</HTML>
