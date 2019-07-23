<%
	if session("forourkids")= "" then
		response.redirect "menu.asp"
	end if

%>
<HTML><HEAD><title>Incedo People</title></HEAD>
<script language="JavaScript">
function clearfield(myaction) {
	if(myaction=='showall') {
		if(document.search.showall.checked) {
			document.search.searchname.value = ''
		}
	}
	else {
		if(document.search.searchname.value != '') {
			document.search.showall.checked = false;
		}
		else {
			document.search.showall.checked = true;
		}
	}
}

</script>

<BODY>
<form action="search.asp" method="post" name="search" id="search">
  <p>Search for any part of name
    <input name="searchname" type="text" id="searchname" onkeyup="clearfield('searchname');">
<%if 1=1 then%>
    <br>
    or Show all 
    <input name="showall" type="checkbox" id="showall" onclick="clearfield('showall');" value="Yes">
<%end if%>
    <br>
    <input name="submit" type="submit" id="submit" value="Submit">
  </p>
</form>
<%
	searchname = request.form("searchname")
	showall = request.form("showall")
	if searchname <> "" or showall = "Yes" then
%>
<table border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
<%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\forourkids\forourkids.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT ID, Surname, Firstname, Gender, DateofBirth from volunteer"
	if searchname <> "" then
		sql = sql & " where surname Like '%" & searchname & "%' or firstname like '%" & searchname & "%'"
	end if
	sql = sql & " order by surname, firstname"
	rs.Open sql, db
	cnt = 0
	doheader = true
	do until rs.EOF
		cnt = cnt + 1
		if doheader = true then
			response.write "<tr>"
			Response.write "<th nowrap>Edit</td>"
			for each fld in rs.Fields
				Response.write "<th nowrap>" & fld.name & "</td>"
			next
			Response.Write "</tr>"
			doheader = false
		end if
		response.write "<tr>"
		Response.write "<td><a href=""registration v.asp?id=" & rs("ID") & """><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
		for each fld in rs.fields
			Response.write "<td nowrap>" & fld.value & "&nbsp;</td>"
		next
		Response.Write "</tr>"
		rs.MoveNext
	loop
		
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
	Response.Write cnt & " records."
%>
</table>
<%end if%>
</BODY>
</HTML>
