<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open "dailytxt", db, 1, 2
	for each frm in request.form
		if left(frm,4) = "date" then
			thisdate = mid(frm,5,11)
			rs.filter = "date = '" & thisdate & "'"
			if rs.eof then
				rs.addnew
				rs("date") = thisdate
			end if
			rs("message") = request.form(frm)
			rs.update
		end if
	next
	rs.close
	set rs = nothing
	db.close
	set db = nothing
	response.redirect "dailytxt.asp?msg=Last updated: " & now()
%>



