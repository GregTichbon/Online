<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "news.asp?" & request.querystring
		response.redirect "../signon"
	else
%>
	<!--#include file="inc_logging.asp"-->
<%
	end if

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	id = request.querystring("id")
	if id <> "new" then
		set di = server.createobject("DI.IIS")
		sql = "SELECT * from thoughts where thoughtsid = " & id  
		rs.Open sql, db
		if not rs.eof then
			title = rs("title")
			description = rs("description")
			content = rs("content")
		end if
		rs.close
		set di = nothing
	end if
%>
<html>
<head>
<title>Incedo Thoughts</title>
</head>
<body>
    <h1 align="center">THOUGHTS</h1>
      <div align="center">
        <table width="780" border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
          <tr>
            <td><div align="right">Title</div></td>
            <td><%=title%></td>
          </tr>
		  <tr>
		    <td><div align="right">Description</div></td>
		    <td><%=description%></td>
		  </tr>
		  <tr>
            <td colspan="2"><%=content%>
		    </td>
	      </tr>
        </table>
      </div>
</body>
</html>
<%
		set rs = nothing
		db.close
		set db = nothing
%>

