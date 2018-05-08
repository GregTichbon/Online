<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if
%>	
<HTML><HEAD><title>Incedo Supporters</title>
<style type="text/css">
<!--
.hideme {
	visibility: hidden;
}
-->
</style>
</HEAD>
<script language="JavaScript">
function clearfield(myaction) {
	if(myaction=='showall') {
		if(document.search.showall.checked) {
			document.search.searchname.value = '';
			document.search.startingwith.selectedIndex = -1;
			document.search.duplicates.selectedIndex = -1;
		}
	}
	else {
		if(myaction=='searchname') {
			if(document.search.searchname.value != '') {
				document.search.showall.checked = false;
				document.search.startingwith.selectedIndex = -1;
				document.search.duplicates.selectedIndex = -1;
			}
			else {
				//document.search.showall.checked = true;
			}
		}
		else {
			if(myaction=='duplicates') {
				if(document.search.duplicates.selectedIndex != -1) {
					document.search.searchname.value = '';
					document.search.showall.checked = false;
					document.search.startingwith.selectedIndex = -1;
					document.search.camefrom.selectedIndex = 0;
				}
			}
			else { 
				if(document.search.startingwith.selectedIndex != -1) {
					document.search.searchname.value = '';
					document.search.showall.checked = false;
					document.search.duplicates.selectedIndex = -1;
				}
			}
		}
	}
}
function popUp(URL,winname) {
	var page = window.open(URL, winname);
	page.focus()
}
</script>
<BODY>
<form action="tidyup.asp" method="post" name="search" id="search">
  <p>Search for any part of name
    <input name="searchname" type="text" id="searchname" onkeyup="clearfield('searchname');">
  or show all (upto the first 200) 
    <input name="showall" type="checkbox" id="showall" onclick="clearfield('showall');" value="Yes">
    or  starting from 
    <select name="startingwith" size="1" id="startingwith" onchange="clearfield('startingwith');">
      <option value=""></option>
      <%
	  for f1=1 to 26
			code = chr(64+f1)
			response.write "<option value=""" & code & """>" & code & "</option>"
      next
	  
%>
    </select>
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
  <p>--------------------- OR ---------------------</p>
  <p>Duplicates starting from 
    <select name="duplicates" size="1" id="duplicates" onchange="clearfield('duplicates');">
      <option value=""></option>
<%
	  for f1=1 to 26
			code = chr(64+f1) 
			response.write "<option value=""" & code & """>" & code & "</option>"
'xx = xx & code & "<br>"
			for f2=1 to 26
				code = chr(64+f1) & chr(64+f2)
				response.write "<option value=""" & code & """>" & code & "</option>"
'xx = xx & code & "<br>"
			next
	 next
	  
%>	  
    </select>  
<% 'response.write xx			%>
</p>
  <p>
<%if request.querystring("sql") <> "" then %>
    SQL<br>
    <textarea name="sql" id="sql" style="width:100%"></textarea>   
<%end if%> 
    <!--
    <input name="duplicates" type="text" id="duplicates" onkeyup="clearfield('searchname');">
  -->
    
</p>
  <p>    <input name="submit" type="submit" id="submit" value="Search">
  </p>
</form>
<p>
<!--<a href="noteselection.asp" target="IncedoNote">NOTE YOUR SELECTION</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<a href="entitymaint.asp?id=new" target="IncedoMaint">Create a new entry</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="default.asp">Return to the menu</a>
-->
<A HREF="javascript:void(0)"" onClick="javascript:popUp('noteselection.asp','IncedoNote');">NOTE YOUR SELECTION</A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<A HREF="javascript:void(0)"" onClick="javascript:popUp('entitymaint.asp?id=new','IncedoMaint');">Create a new entry </A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A HREF="javascript:void(0)"" onClick="javascript:popUp('instructions.asp','IncedoInstructions');">Instructions</A>
<p>
  <%
  	usesql = request.querystring("id")
	searchname = request.form("searchname")
	showall = request.form("showall")
	camefrom = request.form("camefrom")
	duplicates = request.form("duplicates")
	startingwith = request.form("startingwith")
	passedsql = request.form("sql")
 
	if searchname <> "" or showall = "Yes" or duplicates <> "" or usesql <> "" or startingwith <> "" or passedsql <> "" or request.form("process") = "Submit" then
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\supporters.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string

		if request.form("process") = "Submit" then
			Set rs = Server.CreateObject("ADODB.RecordSet")
			with rs
				.Open "supporters", db, 1, 2
				for each frm in request.form
					if left(frm,12) = "organisation" then
						myid = mid(frm,13,99)
						.filter = "id = " & myid
						.fields("organisation") = nullify(request.form("organisation" & myid))
						.fields("recipient") = nullify(request.form("recipient" & myid))
						.fields("surname") = nullify(request.form("surname" & myid))
						.fields("firstnames") = nullify(request.form("firstnames" & myid))
						.fields("title") = nullify(request.form("title" & myid))
						.fields("postaladdress") = nullify(request.form("postaladdress" & myid))
						.fields("status") = nullify(request.form("status" & myid))
						.fields("duplicateof") = nullify(request.form("duplicateof" & myid))
						.update
					end if
				next
				.close
			end with
			set rs = nothing
			response.write "Records updated"
		else
%>
</p>
<form action="tidyup.asp" method="post" name="maint" id="maint">
<table border="1" bordercolor="#000000" cellpadding="5" cellspacing="0">
<%

			Set rs = Server.CreateObject("ADODB.RecordSet")
			dim statuses(10)
			sql = "SELECT * FROM status order by status"
			rs.Open sql, db
			do until rs.eof
	'response.write cnt
				scnt = scnt + 1
				statuses(scnt) = rs("status")
				rs.movenext
			loop
			rs.close
			
			if usesql <> "" then
				sql = session("incedosupporters_sql")
			elseif passedsql <> "" then
				max = 9999
				sql = passedsql
			elseif duplicates <> "" then
				max = 200
				'sql = "SELECT id, organisation, Recipient, Surname, FirstNames, Title, Region, Status, PostalAddress, camefrom FROM Supporters WHERE (status is null or status = 'verified') and Surname like '" & duplicates & "%' and surname In (SELECT [Surname] FROM [Supporters] As Tmp where status is null or status = 'verified' GROUP BY [Surname] HAVING Count(*)>1) ORDER BY organisation, Surname, firstnames"
				sql = "SELECT id, organisation, Recipient, Surname, FirstNames, Title, Region, Status, duplicateof, PostalAddress, camefrom FROM Supporters WHERE Surname >= '" & duplicates & "' and surname In (SELECT [Surname] FROM [Supporters] As Tmp GROUP BY [Surname] HAVING Count(*)>1) ORDER BY organisation, Surname, firstnames, status"
	response.write sql
	'response.end
			else
				max = 200
				sql = "SELECT id as ID, Organisation as [Organisation], Recipient, Surname, Firstnames, Title, PostalAddress, Status, DuplicateOf, CameFrom from supporters"
				usewhere = " where"
				useand = ""
				if searchname <> "" then
					max = 200
					sql = sql & usewhere & " (organisation Like '%" & searchname & "%' or firstnames Like '%" & searchname & "%' or surname Like '%" & searchname & "%')"
					usewhere = ""
					useand = " and"
				end if
				
				if startingwith <> "" then
					max = 200
					'sql = sql & usewhere & " (organisation Like '" & startingwith & "%' or surname Like '" & startingwith & "%')"
					sql = sql & usewhere & " (organisation >= '" & startingwith & "' or surname >= '" & startingwith & "')"
					usewhere = ""
					useand = " and"
				end if
				
				if camefrom <> "" then
					sql = sql & usewhere & useand & " camefrom = '" & camefrom & "'"
					usewhere = ""
					useand = " and"
				end if
				'sql = sql & usewhere & useand & " (status is null or status = 'Verified')"
				
				sql = sql & " ORDER BY (organisation & surname & firstnames)"
			end if
'response.write sql & "<br>"
'response.end
			session("incedosupporters_sql") = sql
			rs.Open sql, db
			cnt = 0
			doheader = true
			do until rs.EOF
				cnt = cnt + 1
				if doheader = true then
					response.write "<tr>"
					Response.write "<th nowrap>Amend</th>"
					response.write "<th nowrap>ID</th><th nowrap>Organisation<br>Recipient</th><th nowrap>Title<br>Firstname(s)<br>Surname</th><th nowrap>Postal Address</th><th nowrap>Status</th><th nowrap>Duplicate<br>Of</th><th nowrap>Came From</th>"
					'for each fld in rs.Fields
					'	Response.write "<th nowrap>" & fld.name & "</th>"
					'next
					Response.Write "</tr>"
					doheader = false
				end if
				response.write "<tr>"
				Response.write "<td><a href=entitymaint.asp?id=" & rs("ID") & " target=""IncedoMaint""><div align=""center""><img src=""edit.gif"" border=""0""></div></a></td>"
				if 1=1 then
					Response.write "<td nowrap>" & rs("id") & "</td>"
					Response.write "<td nowrap>"
					response.write "<input name=""organisation" & rs("id") & """ type=""text"" id=""organisation" & rs("id") & """ value=""" & rs("organisation") & """><br>"
					response.write "<input name=""recipient" & rs("id") & """ type=""text"" id=""recipient" & rs("id") & """ value=""" & rs("recipient") & """>"
					response.write "</td>"
					'Response.write "<td nowrap><input name=""surname" & rs("id") & """ type=""text"" id=""surname" & rs("id") & """ value=""" & rs("surname") & """></td>"
					'Response.write "<td nowrap><input name=""firstnames" & rs("id") & """ type=""text"" id=""firstnames" & rs("id") & """ value=""" & rs("firstnames") & """></td>"
					'Response.write "<td nowrap><input name=""title" & rs("id") & """ type=""text"" id=""title" & rs("id") & """ value=""" & rs("title") & """></td>"
					
					Response.write "<td nowrap>"
					response.write "<input name=""title" & rs("id") & """ type=""text"" id=""title" & rs("id") & """ value=""" & rs("title") & """><br>"
					response.write "<input name=""firstnames" & rs("id") & """ type=""text"" id=""firstnames" & rs("id") & """ value=""" & rs("firstnames") & """><br>"
					response.write "<input name=""surname" & rs("id") & """ type=""text"" id=""surname" & rs("id") & """ value=""" & rs("surname") & """>"
					response.write "</td>"
					
					Response.write "<td nowrap><textarea name=""postaladdress" & rs("id") & """ cols=""40"" rows=""4"" wrap=""OFF"" id=""postaladdress" & rs("id") & """>" & rs("postaladdress") & "</textarea></td>"
					Response.write "<td nowrap>"
	
	Response.write "<select name=""status" & rs("id") & """ size=""1"" id=""status" & rs("id") & """>"
	Response.write "<option value=""""" & selected & "></option>"
	for f1=1 to scnt
	'Response.write "<option value=""" & f1 & """>" & f1 & "</option>"
	thisstatus = statuses(f1)
	if thisstatus = rs("status") then
		selected = " selected"
	else
		selected = ""
	end if
	Response.write "<option value=""" & statuses(f1) & """" & selected & ">" & statuses(f1) & "</option>"
	next
	Response.write "</select></td>"
	
					response.write "<td nowrap><input name=""duplicateof" & rs("id") & """ type=""text"" size=""5"" maxlength=""5"" id=""duplicateof" & rs("id") & """ value=""" & rs("duplicateof") & """></td>"
					Response.write "<td nowrap>" & rs("camefrom") & "</td>"
				else
					for each fld in rs.fields
						select case lcase(fld.name)
							case "id","camefrom"
								Response.write "<td nowrap>" & fld.value & "&nbsp;</td>"
							case else
								Response.write "<td nowrap><input name=""" & fld.name & rs("id") & """ type=""text"" id=""" & fld.name & rs("id") & """ value=""" & fld.value & """>"
						end select
					next
				end if
				Response.Write "</tr>"
				if cnt = max then
					exit do
				end if
				rs.MoveNext
			loop
			rs.Close
	
			set rs = nothing
		end if
		db.Close
		set db = nothing
		if cnt > 0 then
			Response.Write cnt & " records. (" & max & " maximum shown)"
		end if
%>
</table>
<% if cnt > 0 then %>
	<input name="process" type="submit" id="process" value="Submit">
<% end if %>
</form>
<%
	end if
%>
</BODY>
</HTML>
<%
function nullify(pass_val)
	if pass_val = "" then
		nullify = null
	else
		nullify = pass_val
	end if
end function
%>



