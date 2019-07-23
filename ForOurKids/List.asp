<HTML><HEAD>
<title>Australasian Nurse Educators Conference</title>
<BODY>
<div align="center">
<p>  <font size="+2"><strong>Registration List
  </strong></font> </p> 
<%		
	if session("forourkids") <> "on" then
		response.redirect "menu.asp"
	end if
	rtype = request.querystring("type")
	select case rtype
		case "v"
			sql = "Select id, surname, firstname from volunteer order by surname, firstname"
		case "p"
			sql = "Select id, organisationname from partner order by organisationname"
		case "e"
			sql = "Select id, organisationname from employer order by organisationname"
		case else
			response.redirect "menu.asp"
	end select
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\forourkids\forourkids.mdb"
	
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	cnt = 0
	rs.open sql, db
	pagerec = "<table cellSpacing=0 cellPadding=5 border=1>"
	pagerec = pagerec & "<tr>"
	for each fld in rs.Fields 
		pagerec = pagerec & "<td>" & fld.name & "</td>"
	next
	Response.Write "</tr>"
	do until rs.eof
		cnt = cnt + 1
		pagerec = pagerec & "<tr>"
		for each fld in rs.Fields 
			myfld = fld.Value
			if trim(myfld) = "" or isnull(myfld) then myfld = "&nbsp;"
			if fld.name = "id" then
				myfld = "<a href=""registration_" & rtype & ".asp?id=" & myfld & "&mode=maint&secure=true"">" & myfld & "</a>"
			end if
			pagerec = pagerec & "<td>" & myfld & "</td>"
		next
		pagerec = pagerec & "</tr>"
		rs.movenext
	loop
	if cnt > 1 then
		Response.Write "Total Records = " & cnt
	end if
	pagerec = pagerec & "</table>"
	Response.Write pagerec
	rs.close
	set rs = nothing
	db.close
	set db = nothing

%>
</div>
</BODY>
</HTML>