<HTML><HEAD><title>Download</title></HEAD>
<BODY>
<%
		Server.ScriptTimeout = 20000
		set di = server.createobject("DI.IIS")
		centre = session("YFCPeople")
		
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\people.mdb"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		
		Set rs = Server.CreateObject("ADODB.Recordset")
		pagerec = ""
		use_tab = ""
		
		flds = array("id","lastname","firstname","othernames","knownas","gender","birthday","birthyear","address","postaladdress","phonehome","phoneministry","phonework","phoneyfc","mobile","email","category","workplace","appointmentceased") ',"parent","spouse"				
		fldt = array("ID","Last Name","First Name","Other Names","Known As","Gender","Birthday","Birth Year","Address","Postal Address","Phone (Home)","Phone (Minsitry)","Phone (Work)","Phone (Incedo)","Phone (Mobile)","Email","Category","Workplace","Date Ceased") ',"parent","spouse"				
 
		for each fldname in fldt
			pagerec = pagerec & use_tab & """" & fldname & """"
			use_tab = ","
		next
		if session("YFCPeopleSU") = "1" then 
			pagerec = pagerec & ",Centre"
		end if 
		pagerec = pagerec & chr(13)
	
		Set rs = Server.CreateObject("ADODB.RecordSet")
		sql = "SELECT * from people"
		if lcase(centre) = "all" then
			sql = sql & " ORDER BY AppointmentCeased, lastname, firstname"
		else
			sql = sql & " where centre = '" & centre & "' ORDER BY AppointmentCeased, lastname, firstname"
		end if
'Response.Write sql 
'Response.end
		rs.Open sql, db
		do until rs.eof
			use_tab = ""
			for each fldname in flds
				if fldname = "birthday" then
					myfld = di.DI_format(rs(fldname),"dd mmmm")
				else	
					myfld = rs(fldname)
				end if
				if isnull(myfld) then myfld = ""
				myfld = replace(myfld,vbcrlf,vblf)
				pagerec = pagerec & use_tab & """" & myfld & """"
				use_tab = ","
			next
		    if session("YFCPeopleSU") = "1" then 
				pagerec =  pagerec & ",""" & rs("centre") & """" 
			end if 

			pagerec = pagerec & chr(13)
			rs.movenext
		loop
'Response.Write Server.Mappath("download") & "\" & centre & ".csv"
'Response.end		
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		Set objTStream = objFSO.OpenTextFile(Server.Mappath("download") & "\" & centre & ".csv",2,true)
		objTStream.WriteLine (pagerec)
		objTStream.Close
		set objTStream = nothing
		set objFSO = nothing	
		Response.Write "<a href=""download\" & centre & ".csv?id=" & now() & """>Download</a>"		
		rs.close
		set rs = nothing
		db.Close
		set db = nothing

%>
</BODY>
</HTML>
