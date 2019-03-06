<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

%>	
<HTML><HEAD><title>Incedo Supporters</title></HEAD>
<script language="JavaScript">
function clearfield(myaction) {
	if(myaction=='showall') {
		if(document.search.showall.checked) {
			document.search.searchname.value = ''
			document.search.searchnumber.value = ''
		}
	}
	else {
		if(myaction=="searchname") {
			if(document.search.searchname.value != '') {
				document.search.showall.checked = false;
				document.search.searchnumber.value = ''
			}
			else {
				document.search.showall.checked = true;
			}
		}
		else {
			if(myaction=="searchnumber") {
				if(document.search.searchnumber.value != '') {
					document.search.showall.checked = false;
					document.search.searchname.value = ''
				}
				else {
					document.search.showall.checked = true;
				}
			}
		}
	}
}
</script>
<BODY>
<form action="entitymaintselect.asp" method="post" name="search" id="search">
  <p>Search for any part of name
    <input name="searchname" type="text" id="searchname" onkeyup="clearfield('searchname');">
    or Show all 
    <input name="showall" type="checkbox" id="showall" onclick="clearfield('showall');" value="Yes">
  </p>
  <p>Loaded from 
    <select name="camefrom" size="1" id="camefrom">
      <option value="">All</option>
      <option value="Auckland">Auckland</option>
      <option value="Bay of Plenty">Bay of Plenty</option>
      <option value="Christchurch">Christchurch</option>
      <option value="Gisborne">Gisborne</option>
      <option value="Hawkes Bay">Hawkes Bay</option>
      <option value="Marlborough">Marlborough</option>
      <option value="Nelson">Nelson</option>
      <option value="New Zealand">New Zealand</option>
      <option value="Northland">Northland</option>
      <option value="Otago">Otago</option>
      <option value="South Auckland">South Auckland</option>
      <option value="Southland">Southland</option>
      <option value="Taranaki">Taranaki</option>
      <option value="Timaru">Timaru</option>
      <option value="Tracy">Tracy</option>
      <option value="Waikato">Waikato</option>
      <option value="Wanganui">Wanganui</option>
      <option value="Wellington">Wellington</option>

    </select> 
  </p>
  <p>Region / Classification 
    <select name="regionclassification" size="1" id="regionclassification">
      <option value="">All</option>
<%
		sql = "SELECT * FROM Regions_Classifications ORDER BY Region, Classification"
		rs.Open sql, db
		do until rs.EOF
			response.write "<option value=""" & rs("id") & """>" & rs("region") & " - " & rs("Classification") & "</option>"
			rs.movenext
		loop
	  	rs.close
%>	  
    </select>
</p>
  <p>or ID 
    <input name="searchnumber" type="text" id="searchnumber" onkeyup="clearfield('searchnumber');">
  </p>
  <p>
    <input name="submit" type="submit" id="submit" value="Submit">
  </p>
</form>
<p><a href="entitymaint.asp?id=new">Create a new entry</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="default.asp">Return to the menu</a></p>
<p>
  <%
  	usesql = request.querystring("id")
	searchname = request.form("searchname")
	showall = request.form("showall")
	camefrom = request.form("camefrom")
	regionclassification = request.form("regionclassification")
	searchnumber = request.form("searchnumber")
	if searchname <> "" or showall = "Yes" or searchnumber <> "" or usesql <> "" then
%>
</p>
<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<%

		if searchnumber <> "" then
			if isnumeric(searchnumber) then
				sql = "SELECT id FROM Supporters WHERE id = " & searchnumber
				rs.Open sql, db
				if rs.eof then
					found = false
				else
					found = true
				end if
			else
				found = false
			end if
			rs.close
			set rs = nothing
			db.close
			set db = nothing
			if found then
				response.redirect "entitymaint.asp?id=" & searchnumber
			else
				response.redirect "entitymaintselect.asp"
			end if
			response.end
		elseif usesql <> "" then
			sql = session("incedosupporters_sql")
		else
			sql = "SELECT distinct supporters.ID, Organisation, Surname, Firstnames, region, Status, camefrom from supporters LEFT JOIN Supporters_Regions_Classifications ON supporters.ID = Supporters_Regions_Classifications.Supporter"
			usewhere = " where"
			useand = ""
			if searchname <> "" then
				sql = sql & usewhere & " organisation Like '%" & searchname & "%' or firstnames Like '%" & searchname & "%' or surname Like '%" & searchname & "%'"
				usewhere = ""
				useand = " and"
			end if
			if camefrom <> "" then
				sql = sql & usewhere & useand & " camefrom = '" & camefrom & "'"
			end if
			if regionclassification <> "" then
				sql = sql & usewhere & useand & " Supporters_Regions_Classifications.RegionClassification = " & regionclassification 
			end if
			
			sql = sql & " ORDER BY organisation, surname, firstnames"
'response.write sql
'response.end
		end if
		session("incedosupporters_sql") = sql
		rs.Open sql, db
		cnt = 0
		doheader = true
		do until rs.EOF
			cnt = cnt + 1
			if doheader = true then
				response.write "<tr>"
				Response.write "<th nowrap>Amend</td>"
				for each fld in rs.Fields
					Response.write "<th nowrap>" & fld.name & "</td>"
				next
				Response.Write "</tr>"
				doheader = false
			end if
			response.write "<tr>"
			Response.write "<td><a href=entitymaint.asp?id=" & rs("ID") & "><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
			for each fld in rs.fields
				Response.write "<td nowrap>" & fld.value & "&nbsp;</td>"
			next
			Response.Write "</tr>"
			rs.MoveNext
		loop
		rs.Close

		Response.Write cnt & " records."
%>
</table>
<%
	end if
	set rs = nothing
	db.Close
	set db = nothing
%>
</BODY>
</HTML>
