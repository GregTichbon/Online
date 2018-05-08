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
<HTML><HEAD><TITLE>Incedo People</TITLE>
<%
	set di = server.createobject("DI.IIS")
	ID = request.querystring("id")
		
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sqlstring = "SELECT * FROM people where id = " & ID
	rs.Open sqlstring, db
	centre = rs("centre")
	lastname = rs("lastname")
	firstname = rs("firstname")
	othernames = rs("othernames")
	knownas = rs("knownas")
	gender = rs("gender")
	birthdate = rs("birthday")
	birthyear = rs("birthyear")
	if birthyear = "" then
		birthdate = di.DI_format(birthdate,"dd/mm") & "/????"
	else
		birthdate = di.DI_format(birthdate,"dd/mm/yyyy")
	end if
	address = rs("address")
	postaladdress = rs("postaladdress")
	phonehome = rs("phonehome")
	phoneministry = rs("phoneministry")
	phonework = rs("phonework")
	phoneyfc = rs("phoneyfc")
	mobile = rs("mobile")
	email = rs("email")
	category = rs("category")
	iwi = rs("iwi")
	workplace = rs("workplace")
	'parent = "To do"
	'spouse = "To do"
	appointmentceased = di.DI_format(rs("appointmentceased"),"dd/mm/yyyy")
	movedtocentre = rs("movedtocentre")
	verified_by = rs("verified_by")
	verified_date = rs("verified_date")
	notes = rs("notes")
	membershipdate = di.DI_format(rs("membershipdate"),"dd/mm/yyyy")
	additionalemail = rs("additionalemail")
	membersupdate = rs("membersupdate")
	prayer = rs("prayer")
	dailytexts = rs("dailytexts")
	if membersupdate = true then
		membersupdate = "Yes"
	else
		membersupdate = "No"
	end if
	if prayer = true then
		prayer = "Yes"
	else
		prayer = "No"
	end if
	if dailytexts = true then
		dailytexts = "Yes"
	else
		dailytexts = "No"
	end if
	rs.close
	onload = " onload=setvalues()"
%>

<BODY>
  <TABLE width="800" border=1 align="center" cellPadding=5 cellSpacing=0 bordercolor="#000000">
    <TR> 
      <td colspan="3" height="74"> 
        <p align=center><b><font size="+3">Incedo
        People</font></b><b><font color="#FF0000"><br>
        </font></b></p>
      </td>
    <TR> 
      <td width="31%">ID</td>
      <td colspan="2"><%=ID%> 
        <input type="hidden" name="id" value="<%=id%>">
        Verified <%=di.di_format(verified_date,"dd mmm yyyy")%> by <%=verified_by%>
        <input name="$changed" type="hidden" id="$changed">        <div align="right"></div></td>
    </tr>
    <TR> 
      <td width="31%">Mission Base</td>
      <td colspan="2">
<%
    if session("YFCPeopleSU") = "1" then  
        response.write "<select name=""centre"" size=""1"">"
		Set rs = Server.CreateObject("ADODB.Recordset")
		sql = "Select * from centres where [type] = 'centre' order by centre"
		rs.open sql, db
		do until rs.eof
			if rs("centre") = centre then selected = " selected" else selected = ""
			response.write  " <option value=""" & rs("centre") & """" & selected & ">" & rs("centre")  & "</option>"
			rs.movenext
		loop
		rs.close
	    Response.Write "</select>"
	else
		Response.Write centre
        Response.Write "<input type=""hidden"" name=""centre"" value=""" & centre & """>"
    end if
%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Last Name</td>
      <td width="47%"> 
        <%=lastname%>
&nbsp; </td>
	  <%
	  	set fs = CreateObject("Scripting.FileSystemObject")
		if fs.FileExists(Server.MapPath("/") & "\private\people\photos\h400\" & id & ".jpg") then
			photoxtra = "<a href=""photos/h400/" & id & ".jpg""><img src=""Photos/Thumbnails/" & id & ".jpg"" border=""0""></a>"
		else
			photoxtra = ""
		end if
		set fs = nothing 
	  %>
      <td width="22%" rowspan="4"><div align="right"><%=photoxtra%><br></div></td>
    </tr>
    <TR> 
      <td width="31%">First Name</td>
      <td width="47%"> 
        <%=firstname%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Other Names</td>
      <td width="47%"> 
        <%=othernames%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Known As</td>
      <td width="47%"> 
        <%=knownas%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Gender</td>
      <td colspan="2"> <%=gender%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Birthdate (dd/mm/yyyy)</td>
      <td colspan="2"> 
        <%=birthdate%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Address</td>
      <td colspan="2"> 
        <%=address%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Postal Address (if different to Address)</td>
      <td colspan="2"> 
        <%=postaladdress%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Home)</td>
      <td colspan="2"> 
       <%=phonehome%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Ministry)</td>
      <td colspan="2"> 
        <%=phoneministry%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Other place of employment) (ie: if part-time)</td>
      <td colspan="2"> 
       <%=phonework%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Incedo)</td>
      <td colspan="2"> 
        <%=phoneyfc%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Phone (Mobile)</td>
      <td colspan="2"> 
        <%=mobile%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Email</td>
      <td colspan="2"> 
        <%=email%>
&nbsp; </td>
    </tr>
    <TR>
      <td>Additional email addresses </td>
      <td colspan="2"><%=additionalemail%>&nbsp;</td>
    </tr>
    <TR> 
      <td width="31%">Category</td>
      <td colspan="2"> 
	<%=category%>
&nbsp; </td>
    </tr>
    <TR>
      <td>Membership Date </td>
      <td colspan="2"><%=membershipdate%>
&nbsp; </td>
    </tr>
    <TR>
      <td>Prayer list</td>
      <td><%=prayer%>&nbsp;</td>
      <td rowspan="3"><font size="-1">If the person is a member, &quot;YES&quot; means the functions are inhibited. If the person is not a member &quot;YES&quot; means the functions are activated. </font></td>
    </tr>
    <TR>
      <td>Members update</td>
      <td><%=membersupdate%>
&nbsp;    </tr>
    <TR>
      <td>Daily Texts</td>
      <td><%=dailytexts%>
&nbsp;    </tr>
    <TR> 
      <td width="31%">Other place of employment (ie: if part-time)</td>
      <td colspan="2"> 
        <%=workplace%>
&nbsp; </td>
    </tr>
    <%if 1=2 then%>
    <TR> 
      <td width="31%">Parent(s) Name(s) (ie: for the child of a Incedo &quot;Person&quot;)</td>
      <td colspan="2"> 
        <%=parent%>
&nbsp; </td>
    </tr>
    <TR> 
      <td width="31%">Spouse Name</td>
      <td colspan="2"> 
       <%=spouse%>
&nbsp; </td>
    </tr>
    <%end if%>
    <TR> 
      <td width="31%">Cessation Date (dd/mm/yyyy)</td>
      <td colspan="2"> 
        <%=appointmentceased%>
&nbsp; </td>
    </tr>
    <TR>
      <td>Notes</td>
      <td colspan="2"><%=notes%>&nbsp;</td>
    </tr>
</table>
<%
if 1=2 then
%> 
  <div align="center">
    <table width="800" border="1" cellpadding="2">
      <tr> 
        <td><b>Ministry</b></td>
        <td><b>Title</b></td>
      </tr>
      
<%

			sqlstring = "SELECT * FROM people_ministry where id = " & ID
			rs.Open sqlstring, db
			cnt = 0
			do until rs.EOF
				cnt = cnt + 1
				Response.Write "<tr>" 
				  Response.Write "<td>" 
				    Response.Write "xxx"
				  Response.Write "</td>"
				  Response.Write "<td>" 
				    Response.Write rs("Title") 
				  Response.Write "</td>"
				Response.Write "</tr>"
				rs.MoveNext 
			loop
			rs.Close 

%>
    </table>
<%
end if
%>
  </div>
</BODY>
</HTML>
