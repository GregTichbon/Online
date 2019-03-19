<%
	set di = server.createobject("DI.IIS")
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set dbi = Server.CreateObject("ADODB.Connection")
	dbi.Open connection_string
	Set rsi = Server.CreateObject("ADODB.Recordset")
	
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\yfcnz\people.mdb"
	Set dby = Server.CreateObject("ADODB.Connection")
	dby.Open connection_string
	Set rsy = Server.CreateObject("ADODB.Recordset")
	rsy.Open "people", dby, 1, 2
	
	sql = "select * from people"
	rsi.open sql,dbi
	do until rsi.eof
		rsy.filter = "id = " & rsi("id")
		if rsy.eof then
			response.write "Record missing<br>"
		else
			response.write rsi("id") & " | " & rsi("password") & " | " & rsy("password") & ""
			if rsi("password") & "" = "" and rsy("password") & "" = "" then
				newpassword = di.di_generatepassword(5,8)
				dbi.execute "update people set [password] = '" & newpassword & "' where id = " & rsi("id")
				dby.execute "update people set [password] = '" & newpassword & "' where id = " & rsy("id")
				response.write "Password created"
			else
				if rsi("password") & "" <> rsy("password") & "" then
					response.write "Different password"
				end if
			end if
			response.write "<br>"
	end if
		rsi.movenext
	loop
	
	rsy.close
	set rsy = nothing
	dby.close
	set dby = nothing
	
	
	rsi.close
	set rsi = nothing
	dbi.close
	set dbi = nothing
	set di = nothing
%>

	




