
  <%
 if 1=2 then
for each fld in request.form
	response.write fld & "=" & request.form(fld) & "<br>"
next
response.end
end if
    Session.LCID = 5129
  	set di = server.createobject("DI.IIS")

	'connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\datainn.co.nz\VehicleReminders.mdb"
 	connection_string = "Provider=SQLOLEDB;Data Source=VM29E6AC2\MSSQLSERVER2016; Initial Catalog = DataInnovations; User Id = Online; Password=Online"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	with rs
		.Open "vehicle", db, 1, 2
		for each fld in request.form
			if (fld = "new" and request.form(fld) <> "") or isnumeric(fld) then
				if fld = "new" then
					.addnew
				else
					.filter = "vehicle_ctr = " & fld
				end if
				if request.form("_delete" & fld) = "-1" then
					.delete
				else
					.fields("registration") = nullify(request.form(fld))
					.fields("description") = nullify(request.form("description" & fld))
'response.write "*" & request.form("wofdue" & fld) & "*"
'response.end 					
                    wofdue = nullify(request.form("wofdue" & fld))
                    registrationdue = nullify(request.form("registrationdue" & fld))
                    servicedue = nullify(request.form("servicedue" & fld))
                    HoldemailUntill = nullify(request.form("Holdemailtill" & fld))
                    HoldmobileUntill = nullify(request.form("Holdmobiletill" & fld))


                    'wofdue = nullify(di.di_format(request.form("wofdue" & fld),"dd mmm yyyy"))
                    'registrationdue = nullify(di.di_format(request.form("registrationdue" & fld),"dd mmm yyyy"))
                    'response.write wofdue & " - " & request.form("wofdue" & fld) & "<br>"

					.fields("wofdue") = wofdue
					.fields("registrationdue") = registrationdue
					.fields("servicedue") = servicedue

					.fields("notes") = nullify(request.form("notes" & fld))
					.fields("email") = nullify(request.form("email" & fld))
					.fields("mobile") = nullify(request.form("mobile" & fld))

					.fields("Holdemailtill") = HoldemailUntill
					.fields("Holdmobiletill") = HoldmobileUntill
					.update
				end if
			end if
		next
	end with	
	
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
	response.redirect "default.asp"
	
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function	


Function datefix(myDate)
if 1=1 then
	datefix = MyDate
else

      if myDate = "" then
        datefix = null
      else
        d = Day(myDate)
        m = Month(myDate)    
        y = Year(myDate)
        datefix= m & "-" & d & "-" & y
      end if
      'response.write myDate & " = " & datefix & "<br>"
end if
End Function
%>