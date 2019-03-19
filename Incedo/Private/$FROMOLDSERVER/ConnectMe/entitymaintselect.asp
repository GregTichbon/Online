<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\connectme.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")

%>	
<HTML><HEAD><title>Incedo ConnectMe</title></HEAD>
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
				//document.search.showall.checked = false;
				document.search.searchnumber.value = '';
				document.search.searchemail.value = '';
			}
			else {
				//document.search.showall.checked = true;
			}
		}
		else {
			if(myaction=="searchnumber") {
				if(document.search.searchnumber.value != '') {
					//document.search.showall.checked = false;
					document.search.searchname.value = '';
					document.search.searchemail.value = '';
				}
				else {
					//document.search.showall.checked = true;
				}
			}
			else {
				if(myaction=="searchemail") {
					if(document.search.searchemail.value != '') {
						//document.search.showall.checked = false;
						document.search.searchname.value = '';
						document.search.searchnumber.value = '';
					}
					else {
						//document.search.showall.checked = true;
					}
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
<%if 1=2 then%>
    or Show all 
    <input name="showall" type="checkbox" id="showall" onclick="clearfield('showall');" value="Yes">
<%end if%>
  </p>
<%if 1=2 then%>
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
<%end if%>
</p>
  <p>or ID 
    <input name="searchnumber" type="text" id="searchnumber" onkeyup="clearfield('searchnumber');">
  </p>
  <p>or Email Address
    <input name="searchemail" type="text" id="searchemail" onkeyup="clearfield('searchemail');">
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
	searchemail = request.form("searchemail")
	showall = request.form("showall")
	regionclassification = request.form("regionclassification")
	searchnumber = request.form("searchnumber")
	if searchname <> "" or showall = "Yes" or searchnumber <> "" or searchemail <> "" or usesql <> "" then
%>
</p>
<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<%

		if searchnumber <> "" then
			if isnumeric(searchnumber) then
				sql = "SELECT id FROM ConnectMe WHERE id = " & searchnumber
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
		elseif usesql <> "" then
			sql = session("incedoConnectMe_sql")
		else
			if regionclassification <> "" then
				sql = "SELECT distinct ConnectMe.ID, Organisation, Surname, firstname, region, Status from ConnectMe LEFT JOIN ConnectMe_Regions_Classifications ON ConnectMe.ID = ConnectMe_Regions_Classifications.connectme"
				usewhere = " where"
				useand = ""
			elseif searchemail <> "" then
				sql = "SELECT distinct ConnectMe.ID, Organisation, Surname, firstname, region, ConnectMe.Status FROM ConnectMe INNER JOIN (CommunicationsType INNER JOIN ConnectMe_Communications ON CommunicationsType.ID = ConnectMe_Communications.Type) ON ConnectMe.ID = ConnectMe_Communications.ConnectMe WHERE CommunicationsType.Email=Yes"
				usewhere = ""
				useand = " and"
			else
				sql = "SELECT distinct ConnectMe.ID, Organisation, Surname, firstname, region, Status from ConnectMe"
				usewhere = " where"
				useand = ""
			end if
			if searchname <> "" then
				sql = sql & usewhere & " organisation Like '%" & searchname & "%' or firstname Like '%" & searchname & "%' or surname Like '%" & searchname & "%'"
				usewhere = ""
				useand = " and"
			end if
			if searchemail <> "" then
				sql = sql & usewhere & useand & " ConnectMe_Communications.Detail Like '%" & searchemail & "%'"
				usewhere = ""
				useand = " and"
			end if
			if regionclassification <> "" then
				sql = sql & usewhere & useand & " ConnectMe_Regions_Classifications.RegionClassification = " & regionclassification 
			end if
			sql = sql & " ORDER BY organisation, surname, firstname"
'response.write sql
'response.end
		end if
		session("incedoConnectMe_sql") = sql
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



