<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "../private/prayer/GroupDailyRespondents.asp"
		response.redirect "../signon"
	'else
	'	secgroup = "Prayer"
	'	secoption = "Daily Texts"
	'	secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
	'	administrator = secresult 
	end if
%>
<HTML><HEAD><title>Daily Txts</title></HEAD>
<BODY>
	<p>Remove data in both fields to delete a record</p>
	<table border="0">
	<tr><td>ID</td>
	<td>Name</td>
	<td>Mobile</td>
	</tr>
  <form name="offices" method="post" action="GroupDailyRespondents_Process.asp">
  <%
	mode = Request.QueryString("mode")
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "SELECT * from GroupDailyRespondents order by name"
	rs.Open sql, db
	do until rs.EOF
		response.write "<tr>"
		response.write "<td>" & rs("id") & "</td>"
		response.write "<td><input name=""" & rs("id") & """ type=""text"" value=""" & rs("name") & """></td>"
		response.write "<td><input name=""mobile" & rs("id") & """ type=""text"" value=""" & rs("mobile") & """><input name=""group" & rs("group") & """ type=""hidden"" value=""" & rs("group") & """></td>"
		response.write "</tr>"
		rs.MoveNext
	loop
	rs.Close
	set rs = nothing
	db.Close
	set db = nothing
%>
	<tr><td>New</td>
	  <td><input name="new" type="text" id="new" value=""></td>
	  <td><input name="mobilenew" type="text" id="mobilenew" value="">
      <input name="group" type="hidden" id="group" value="Waikato"></td>
	</tr>
     

      <tr><td colspan="3"><div align="right">
        <input name="submit" type="submit" id="submit" value="Submit">
      </div></td>
      </tr>

  </form>
  </table>
 </BODY>
</HTML>
