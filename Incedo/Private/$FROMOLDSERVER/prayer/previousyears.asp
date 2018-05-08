<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
if 1=2 then
		secgroup = "Prayer"
		secoption = "Administration"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->		
<%
		if secresult <> "OK" then
			response.redirect "../signon"
		end if
end if
	end if
	set di = server.createobject("DI.IIS")

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
		
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	
	if request.form("submit") <> "" then
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open "DailyTxt", db, 1, 2
		for each key in request.form
			if left(key,8) = "message_" then
				thedate = mid(key,9,2) & " Aug 2016"
				'response.write thedate & "<br>"
				text = request.form(key)
				'response.write text & "<br>"
				with rs
					.filter = "[date] = #" & thedate & "#"
					if .eof then
						'response.write "AddNew<br>"
						.AddNew
						.fields("date") = thedate
					end if
					'response.write "Message<br>"
					.fields("message") = text
				end with
			end if
			'response.write "Update<br>"

			rs.update
			'response.write key
		next
		rs.close
		set rs = nothing
	
	end if
	
	
	
%>
<HTML><HEAD><title></title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
			$(".rb").click(function () {
			//alert(this.id);
				thekey = this.id.substring(3);
				//alert(thekey);
				//alert($("#orig_" + thekey).html());
				//alert(thekey.substring(0,2));
				newval = $("#orig_" + thekey).text();
				newval = newval.replace("3x3x3:Praise,Pray 4 U, World, Incedo ","");
				$("#message_" + thekey.substring(0,2)).val(thekey.substring(4,6) + ":" + newval);
			})

		})
		</script>
</HEAD>
<BODY>
<form name="form1" id="form1" method="post" action="">
<table>
<%
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	PY = "SELECT DailyTxt.Message, Day([date]) AS [Day], Month([date]) AS [Month], Year([date]) AS [Year], DailyTxt.Date FROM DailyTxt ORDER BY Day([date]), Year([date])"
	
	TY = "SELECT DailyTxt.ID, DailyTxt.Message, Day([date]) AS [Day], Month([date]) AS [Month], Year([date]) AS [Year], DailyTxt.Date FROM DailyTxt WHERE (((Year([date]))=2016)) ORDER BY Day([date])"

	sql = "SELECT PY.Message, PY.Day, PY.Month, PY.Year, PY.date, TY.ID, TY.Message as tymessage FROM (" & PY & ") " & _
		  "PY LEFT JOIN (" & TY & ") TY ON (PY.Month = TY.Month) AND (PY.Day = TY.Day) " & _
		  "WHERE (((PY.Month)=8)) ORDER BY PY.Day, PY.Year;"
		  'response.write sql
	rs.open sql,db
	do until rs.eof
		theday = di.di_format(rs("date"),"dd") 'day(rs("date"))
		themonth = di.di_format(rs("date"),"MM")
		thekey = di.di_format(rs("date"),"ddMMYY")
		if theday <> lastday then
			response.write "<tr><td bgcolor=""Yellow"" colspan=""3"">" & rs("day") & "</td></tr>" & vbcrlf
			response.write "<tr><td colspan=""3""><input style=""width:100%"" name=""message_" & theday & """ type=""text"" id=""message_" & theday & """ value=""" & rs("tymessage") & """></td></tr>" & vbcrlf
			lastday = theday 
		end if
		response.write "<tr><td>" & rs("date") & "</td><td><span id=""orig_" & thekey & """>" & rs("message") & "</td><td><input name=""rb"" class=""rb"" id=""rb_" & thekey & """ type=""radio"" value=""" & thekey & "/" & month(rs("date")) & """></td></tr>" & vbcrlf
		rs.movenext
	loop
	rs.close
	db.close
	
	set rs = nothing
	set db = nothing
%>

	
</table>
<input name="submit" type="submit" value="submit">
</form>

</BODY>
</HTML>



