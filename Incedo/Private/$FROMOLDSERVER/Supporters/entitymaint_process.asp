<%
		if Request.Form("$delete") = "Delete" then
			mode = "delete"
		elseif Request.Form("$submit") = "Submit" then
			mode = "submit"
		else
			Response.write "Unknown Action"
			Response.End
		end if
		id = request.form("id")
		if id = "new" then 
			mode = "new"
		end if
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			if mode = "delete" or mode = "submit" or mode = "new" then
				.Open "supporters", db, 1, 2
				if id <> "new" then
					.filter = "id = " & id
				end if
				if mode = "delete" then
					.delete
				else
					if id = "new" then
						.AddNew
					end if
					For Each key in Request.Form
						if left(key,12) = "$mailoutnote" then
							mailoutid = mid(key,13)
							sql = "update supporters_mailout set [note] = "
							if request.form(key) = "" then
								sql = sql & "Null"
							else
								sql = sql & "'" & request.form(key) & "'"
							end if
							sql = sql & ", donation = "
							if request.form("$mailoutdonation" & mailoutid) = "" then
								sql = sql & "Null"
							else
								sql = sql & request.form("$mailoutdonation" & mailoutid) 
							end if
							sql = sql & ", notsent = " 
							if request.form("$mailnotsent" & mailoutid) = "" then
								sql = sql & "Null"
							else
								sql = sql & request.form("$mailnotsent" & mailoutid) 
							end if
							sql = sql & " where id = " & mailoutid
'response.write sql
'response.end
							db.execute sql
						elseif left(key,1) <> "$" and key <> "id" and key <> "classification" then
'on error resume next
							.fields(key) = nullify(request.form(key))
'if err.number <> 0 then
'	Response.Write key & "=" & request.form(key) & " - " & err.description & "<br>"
'	response.end
'end if
						end if
					next
					.fields("modified") = now()
					.Update
					id = .fields("id")
				end if
				.close
			end if
		end with
		set rs = nothing
'response.end
if 1=1 then
		allassociatedregions = split(request.form("$allregionsstring"),"|")
		regions = split(request.form("$associatedregion"),", ")
'response.write request.form("$allassociatedregions") & "<br>" & request.form("$associatedregion") & "<br>"
'response.write "Number of regions=" & ubound(allassociatedregions) & "<br>"
'response.end
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "supporters_Regions", db, 1, 2
			for f1=1 to ubound(allassociatedregions)
'response.write f1 & "=" & allassociatedregions(f1) & "<br>"
				if mode = "delete" then
					.filter = "supporter = " & id & " and region = '" & allassociatedregions(f1) & "'"
					if not .eof then
						.delete
					end if
				else
					'response.write allregions(f1)
					found = false
					for f2=0 to ubound(regions)
						if allassociatedregions(f1) = regions(f2) then
							found = true
							exit for
						end if
					next
					.filter = "supporter = " & id & " and region = '" & allassociatedregions(f1) & "'"
					if .eof then
						if found = true then
							.addnew
							.fields("supporter") = id
							.fields("region") = allassociatedregions(f1)
							.update
						end if
					else
						if found <> true then
							.delete
						end if
					end if
				end if
			next 
			.close
		end with
		
'response.write request.form("$regions") & " = " & request.form("region")
'response.end
		set rs = nothing
end if

''''''region classifications start
classifications = ""
delim = ""
for each frm in request.form
	if left(frm,15) = "$classification" then
		'response.write frm & "=" & request.form(frm) & "<br>"
		classifications = classifications & delim & mid(frm,16,999)
		delim =","
	end if
next


if classifications <> "" then
	delclassifications = classifications
else
	delclassifications = 0
end if
sql = "delete * from supporters_Regions_Classifications where id in ( " & _
"SELECT supporters_Regions_Classifications.ID " & _
"FROM supporters_Regions_Classifications " & _
"WHERE supporters_Regions_Classifications.Supporter = " & id & " AND supporters_Regions_Classifications.RegionClassification Not In (" & delclassifications & "))"

'response.write sql
'response.end
db.execute sql
	
if mode <> "delete" then
	if classifications <> "" then
		classarray = split(classifications,",")
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "Supporters_Regions_Classifications", db, 1, 2
			
			for each val in classarray
				.filter = "supporter = " & id & " and regionclassification = " & val
				'response.write "<br>" & .filter & "=" & .eof
				if .eof then
					.addnew
					.fields("supporter") = id
					.fields("regionclassification") = val
					.update
				end if
			next
			.close
		end with
		set rs = nothing
	end if
end if

''''''region classifications end

''''''electronic comms starts here

if mode = "delete" then
	sql = "delete * from Supporters_Communications where Supporters = " & id
	db.execute sql
else
	commidsstr = request.form("$commid")
	if commidsstr = "" then
		delcomms = 0
	else
		delcomms = commidsstr
	end if
	sql = "delete * from Supporters_communications where id in ( " & _
	"SELECT Supporters_communications.ID " & _
	"FROM Supporters_communications " & _
	"WHERE Supporters_communications.Supporter = " & id & " AND Supporters_communications.id Not In (" & delcomms & "))"
	
'response.write sql
'response.end

	db.execute sql

	if commidsstr <> "" then
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open "Supporters_communications", db, 1, 2
		commids = split(request.form("$commid"),", ")
		commtypes = split(request.form("$commtype"),", ")
		commdetails = split(request.form("$commdetail"),", ")
		commnotes = split(request.form("$commnote"),", ")
		commstatus = split(request.form("$commstatus"),", ")
		for f1=0 to ubound(commids)
			if commids(f1) <> 0 then
				rs.filter = "id = " & commids(f1)
				if rs.eof then
					rs.addnew
					rs.Fields("Supporter") = id
				end if
			else
				rs.AddNew 
				rs.Fields("Supporter") = id
			end if
			rs.Fields("type") = commtypes(f1)
			
			rs.Fields("detail") = commdetails(f1)
			if f1 <= ubound(commnotes) then
				rs.Fields("note") = nullify(commnotes(f1))
			end if
			rs.Fields("status") = commstatus(f1)
			rs.Update
		next 
		rs.close
		set rs = nothing
	end if
end if



''''''electronic comms ends here


''''''mailout starts here
'I don't know why we need this section
if 1=2 then
if mode <> "delete" then
	if classifications <> "" then
		classarray = split(classifications,",")
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "Supporters_mailout", db, 1, 2
			
			for each val in classarray
				.filter = "supporter = " & id & " and regionclassification = " & val
				'response.write "<br>" & .filter & "=" & .eof
				if .eof then
					.addnew
					.fields("supporter") = id
					.fields("regionclassification") = val
					.update
				end if
			next
			.close
		end with
		set rs = nothing
	end if
end if
end if

''''''mailout ends here

		db.Close
		set db = nothing
		if mode <> "delete" then
			response.write "<p><a href=""entitymaint.asp?id=" & id & """>Return to this record</a></p>"
		end if
		response.write "<p><a href=""entitymaintselect.asp"">Start a new search</a></p>"

		if session("incedosupporters_sql") <> "" then
			response.write "<p><a href=""entitymaintselect.asp?id=sql"">Repeat the last search</a></p>"
		end if
		
		if mode = "new" then
			response.write "<p><a href=""entitymaint.asp?id=new"">Create another record</a></p>"
		end if
				
		
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function
%>





