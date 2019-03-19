<HTML><HEAD><title>TXT SQL</title></HEAD>
<BODY bgcolor="#99FFFF">
<p align="left"> 
  <%
		Server.ScriptTimeout = 20000
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$generic\yfcnz\sql.mdb"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set sqlrs = Server.CreateObject("ADODB.Recordset")
		
		desc = Request.Form("desc")
		desc = replace(desc,"""","'")
		sql = request.form("sql")
		sql = replace(sql,"""","'")
		exec = Request.Form("execute")
		opt = Request.form("opt")
		id = Request.Form("id")
		dump = Request.form("dump")
		area = Request.Form("area")
		database = Request.Form("database")
		sqlresolved = Request.Form("sqlresolved")
		if opt = "add" or opt = "change" or opt = "delete" then
			with sqlrs
				.Open "sqllog", db, 1, 2
				if opt = "add" then
					.addnew
					.fields("area") = area
				else
					.filter = "[id] = " & id
				end if	
				if opt = "delete" then
					if .eof <> true then
						.delete
					end if
				else
					.fields("database") = database
					.fields("description") = desc
					.fields("statement") = replace(sql,vbcrlf," ")
					.update
				end if
				.close
			end with
		end if
		set sqlrs = nothing
		db.close
		set db = nothing
		
		if exec = "yes" then
			connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & database 
			Set db = Server.CreateObject("ADODB.Connection")
			db.Open connection_string
			response.write "<b>" & desc & "</b><br>"
			Response.Write sqlresolved & "<br>"
			if ucase(left(sqlresolved,6)) = "SELECT" then
				cnt = 0
				Set rs = Server.CreateObject("ADODB.Recordset")
				rs.Open sqlresolved, db
				if dump = "yes" then
					pagerec = ""
					use_tab = ""
					for each fld in rs.Fields 
						pagerec = pagerec & use_tab & """" & fld.name & """"
						use_tab = ","
					next
					pagerec = pagerec & chr(13)
				else
					pagerec = "<table cellSpacing=0 cellPadding=3 border=1>"
					pagerec = pagerec & "<tr>"
					for each fld in rs.Fields 
						pagerec = pagerec & "<td>" & fld.name & "</td>"
					next
					Response.Write "</tr>"
				end if
				do until rs.eof
					cnt = cnt + 1
					if dump =  "yes" then
						use_tab = ""
					else
						pagerec = pagerec & "<tr>"
					end if
					for each fld in rs.Fields 
						myfld = fld.Value
						if dump = "yes" then
							if isnull(myfld) then myfld = ""
							myfld = replace(myfld,vbcrlf,vblf)
							pagerec = pagerec & use_tab & """" & myfld & """"
							use_tab = ","
						else
							if trim(myfld) = "" or isnull(myfld) then myfld = "&nbsp;"
							pagerec = pagerec & "<td>" & myfld & "</td>"
						end if
					next
					if dump = "yes" then
						pagerec = pagerec & chr(13)
					else
						pagerec = pagerec & "</tr>"
					end if
					rs.movenext
				loop
				if cnt > 1 then
					Response.Write "Total Records = " & cnt
				end if
				if dump = "yes" then
					fname = Server.Mappath("\") & "\connectme\sqlresults.csv"
'Response.Write fname
'Response.End 					
					Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
					Set objTStream = objFSO.OpenTextFile(fname,2,true)
					objTStream.WriteLine (pagerec)
					objTStream.Close
					set objTStream = nothing
					set objFSO = nothing	
					Response.Write "<a href=""sqlresults.csv"">Download</a>"		
				else
					pagerec = pagerec & "</table>"
					Response.Write pagerec
				end if
				rs.close
				set rs = nothing
			end if
		else
			db.execute sqlresolved
			response.write "Done"
		end if
		db.Close
		set db = nothing
		
		if exec <> "yes" then
			Response.Redirect("sql.asp")
		end if

%>
  </p>
</BODY>
</HTML>



