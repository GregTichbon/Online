<HTML><HEAD><title>Reports</title></HEAD>
<BODY>
<p align="left"> 
  <%
		Server.ScriptTimeout = 20000
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$generic\ForOurKids\ForOurKids.mdb"
		Set sqldb = Server.CreateObject("ADODB.Connection")
		sqldb.Open connection_string
		Set sqlrs = Server.CreateObject("ADODB.Recordset")
		
		desc = Request.Form("desc")
		sql = request.form("sql")
		exec = Request.Form("execute")
		opt = Request.form("opt")
		id = Request.Form("id")
		dump = Request.form("dump")
		usedb = Request.Form("database")
		usedbcontrol = Request.Form("databasecontrol")
		if opt = "add" or opt = "change" or opt = "delete" then
			with sqlrs
				.Open "reportslog", sqldb, 1, 2
				if opt = "add" then
					.addnew
					.fields("dbcontrol") = usedbcontrol
				else
					.filter = "[id] = " & id
				end if	
				if opt = "delete" then
					if .eof <> true then
						.delete
					end if
				else
					.fields("description") = replace(desc,"""","'")
					.fields("statement") = replace(replace(sql,vbcrlf," "),"""","'")
					.update
				end if
				.close
			end with
		end if
		set sqlrs = nothing
		sqldb.close
		set sqldb = nothing
		
		if exec = "yes" then
			connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & usedb
			Set usedb = Server.CreateObject("ADODB.Connection")
			usedb.Open connection_string
			response.write "<b>" & desc & "</b><br>"
			Response.Write sql & "<br>"
			if ucase(left(sql,6)) = "SELECT" then
				cnt = 0
				Set rs = Server.CreateObject("ADODB.Recordset")
				rs.Open sql, usedb
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
							myfld = replace(myfld,"""","""""")
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
					Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
					fname = Server.Mappath(".") & "\reportresults.csv"
'response.write fname
'response.end
					Set objTStream = objFSO.OpenTextFile(fname,2,true)
					objTStream.WriteLine (pagerec)
					objTStream.Close
					set objTStream = nothing
					set objFSO = nothing	
					Response.Write "<a href=""reportresults.csv?id=" & now() & """>Download</a>"		
				else
					pagerec = pagerec & "</table>"
					Response.Write pagerec
				end if
				rs.close
				set rs = nothing
			else
				usedb.execute sql
				response.write "Done"
			end if
			usedb.Close
			set usedb = nothing
		end if
		
		if exec <> "yes" then
			Response.Redirect("reports.asp")
		end if

%>
  </p>
</BODY>
</HTML>
