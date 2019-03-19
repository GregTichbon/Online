<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<%
for each frm in request.form
	response.write frm & "=" & request.form(frm) & "<br>"
next
%>
<form action="$testupload.asp" method="post"  name="form1">
  <input type="text" name="textfield">
  <input name="fname" type="file" id="fname" value="E:\Homepage\nursed\Javascript\ColourPickerImages\sv.png">
  <input name="submit" type="submit" id="submit" value="Submit">
</form>
</body>
</html>
