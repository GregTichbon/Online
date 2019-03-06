<%
	if session("Incedo_MemberID")= "" then
		'response.redirect "../signon"
	end if
	id = request.querystring("id")
	dim answer(5)
	if id <> "new" then
		connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\$Generic\Incedo\radio.mdb;"
		Set db = Server.CreateObject("ADODB.Connection")
		db.Open connection_string
		Set rs = Server.CreateObject("ADODB.RecordSet")
		sql = "select * from poll where pollid = " & request.querystring("id")
		rs.open sql,db
		if not rs.eof then
			datetime = rs("datetime")
			proposition = rs("proposition")
			if rs("active") then
				activechecked = " checked"
			end if
			if rs("showresults") then
				showresultschecked = " checked"
			end if
		end if
		rs.close
		sql = "select * from polloptions where poll = " & request.querystring("id") & " order by seq"
		rs.open sql,db
		do until rs.eof
			c1 = c1 + 1
			answer(c1) = rs("answer")
			rs.movenext
		loop
		rs.close
		set rs = nothing
		db.close
		set db = nothing
	end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo</title>
<style>
.outerbox {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	background-color: #FFFFFF;
	width: 780px;
	border: thin solid #000000;
}
</style>
</head>
<body background="../../images/background.gif">
<div align="center">
  <div class="outerbox">
      <h1>Radio Incedo</h1>
	  
	  <form name="poll" method="post" action="pollmaint_process.asp">
        <table width="100%"  border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
          <tr>
            <td width="150"><div align="right">Date/Time</div></td>
            <td><div align="left">
              <input name="id" type="hidden" id="id" value="<%=id%>">
              <%=datetime%></div></td>
          </tr>
          <tr>
            <td width="150"><div align="right">Proposition</div></td>
            <td>
              <textarea name="proposition" id="proposition" style="width:100%"><%=proposition%></textarea>            </td>
          </tr>
          <tr>
            <td width="150"><div align="right">Active</div></td>
            <td>              <div align="left">
              <input name="active" type="checkbox" id="active" value="-1"<%=activechecked%>>            
            </div></td>
          </tr>
          <tr>
            <td width="150"><div align="right">Show Results </div></td>
            <td>              <div align="left">
              <input name="showresults" type="checkbox" id="showresults" value="-1"<%=showresultschecked%>>            
            </div></td>
          </tr>
          <tr>
            <td width="150"><div align="right">Answer 1 </div></td>
            <td>              <input name="answer1" type="text" id="answer1" style="width:100%" value="<%=answer(1)%>">            </td>
          </tr>
          <tr>
            <td width="150"><div align="right">Answer 2 </div></td>
            <td>              <input name="answer2" type="text" id="answer2" style="width:100%" value="<%=answer(2)%>">            </td>
          </tr>
          <tr>
            <td width="150"><div align="right">Answer 3 </div></td>
            <td>              <input name="answer3" type="text" id="answer3" style="width:100%" value="<%=answer(3)%>">            </td>
          </tr>
          <tr>
            <td width="150"><div align="right">Answer 4 </div></td>
            <td>              <input name="answer4" type="text" id="answer4" style="width:100%" value="<%=answer(4)%>">            </td>
          </tr>
          <tr>
            <td width="150"><div align="right">Answer 5 </div></td>
            <td>              <input name="answer5" type="text" id="answer5" style="width:100%" value="<%=answer(5)%>">            </td>
          </tr>
          <tr>
            <td colspan="2"><input name="$submit" type="submit" id="$submit" value="Submit"></td>
          </tr>
          <tr>
            <td colspan="2"><a href="polllist.asp">Return to Poll Listing </a></td>
          </tr>
        </table>
</form>
  </div>
</div>
<script type="text/javascript" language="JavaScript" src="http://www.incedo.org.nz/statistics/stats_js.asp"> </script>
</body>
</html>



