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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Incedo Upload Documents</title>
</head>

<body>
<form action="upload_process.asp" method="post" enctype="multipart/form-data" name="document" id="document">
  <p>&nbsp;</p>
  <table width="600" border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
    <tr>
      <td>File:</td>
      <td><input name="document" type="file" id="document" style="width:100%"></td>
    </tr>
    <tr>
      <td>Description:</td>
      <td><textarea name="description" rows="5" id="description" style="width:100%"></textarea></td>
    </tr>
    <tr>
      <td>Your Name: (need to use ID) </td>
      <td><input name="who" type="text" id="who" style="width:100%"></td>
    </tr>
    <tr>
      <td>History: </td>
      <td><input name="detail" type="text" id="detail" style="width:100%" value="Made available"></td>
    </tr>
    <tr>
      <td colspan="2"><div align="center">
        <input name="submit" type="submit" id="submit" value="Submit">
      </div></td>
    </tr>
  </table>
  <p>&nbsp;  </p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;  </p>
</form>
<p>&nbsp;</p>
</body>
</html>
