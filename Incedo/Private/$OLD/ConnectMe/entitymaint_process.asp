<%
'for each fld in request.form
'	if left(fld,5) = "$comm" then
'		response.write fld & "=" & request.form(fld) & "<br>"
'	end if
'next
'response.end

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
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\connectme.mdb"
		
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			if mode = "delete" or mode = "submit" or mode = "new" then
				.Open "ConnectMe", db, 1, 2
				if id <> "new" then
					.filter = "id = " & id
				end if
				if mode = "delete" then
					.delete
				else
					if id = "new" then
						.AddNew
						'.fields("created") = now() 'is this done at the db?
					end if
					For Each key in Request.Form
						if left(key,1) <> "$" and key <> "id" then
on error resume next
							.fields(key) = nullify(request.form(key))
if err.number <> 0 then
	Response.Write key & "=" & request.form(key) & " - " & err.description & "<br>"
	response.end
end if
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
on error goto 0
'response.end

''''''region classifications start

if mode = "delete" then
	sql = "delete * from ConnectMe_Regions_Classifications where connectme = " & id
	db.execute sql
else
	classifications = ""
	delim = ""
	for each frm in request.form
		if left(frm,15) = "$classification" then
			classifications = classifications & delim & mid(frm,16,999)
			delim =","
		end if
	next

	if classifications = "" then
		delclassifications = 0
	else
		delclassifications = classifications
	end if
	sql = "delete * from ConnectMe_Regions_Classifications where id in ( " & _
	"SELECT ConnectMe_Regions_Classifications.ID " & _
	"FROM ConnectMe_Regions_Classifications " & _
	"WHERE ConnectMe_Regions_Classifications.connectme = " & id & " AND ConnectMe_Regions_Classifications.RegionClassification Not In (" & delclassifications & "))"
	
	db.execute sql

	if classifications <> "" then
		classarray = split(classifications,",")
		Set rs = Server.CreateObject("ADODB.Recordset")
		with rs
			.Open "ConnectMe_Regions_Classifications", db, 1, 2
			for each val in classarray
				.filter = "connectme = " & id & " and regionclassification = " & val
				if .eof then
					.addnew
					.fields("connectme") = id
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
	sql = "delete * from ConnectMe_Communications where connectme = " & id
	db.execute sql
else
	commidsstr = request.form("$commid")
	if commidsstr = "" then
		delcomms = 0
	else
		delcomms = commidsstr
	end if
	sql = "delete * from ConnectMe_communications where id in ( " & _
	"SELECT ConnectMe_communications.ID " & _
	"FROM ConnectMe_communications " & _
	"WHERE ConnectMe_communications.connectme = " & id & " AND ConnectMe_communications.id Not In (" & delcomms & "))"
	
'response.write sql
'response.end

	db.execute sql

	if commidsstr <> "" then
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open "ConnectMe_communications", db, 1, 2
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
					rs.Fields("connectme") = id
				end if
			else
				rs.AddNew 
				rs.Fields("connectme") = id
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


''''''notes starts here


''''''notes ends here

		db.Close
		set db = nothing
'response.end
		if mode <> "delete" then
			response.write "<p><a href=""entitymaint.asp?id=" & id & """>Return to this record</a></p>"
		end if
		response.write "<p><a href=""entitymaintselect.asp"">Start a new search</a></p>"

		if session("incedoConnectMe_sql") <> "" then
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


