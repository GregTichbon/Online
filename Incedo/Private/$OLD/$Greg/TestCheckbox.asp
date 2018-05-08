<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<script language="JavaScript">
function setoptions(optname) {
	document.getElementsByName(optname)[1].checked = !(document.getElementsByName(optname)[0].checked);
}
</script>
</head>

<body>
<form name="maint" method="post" action="">
  <input type="checkbox" id="mine" name="mine" value="-1" onClick="javascript:setoptions(this.name)">
  <input type="checkbox" id="mine" name="mine" value="0">
</form>
</body>
</html>
