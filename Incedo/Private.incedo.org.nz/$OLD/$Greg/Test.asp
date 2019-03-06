<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
<title>Untitled Document</title> 
<script language="JavaScript"> 
function checkform() { 
        var msg = '' 
        var delim = '' 
        var frm = document.form1; 
        frm.fld[0].value = frm.fld[0].value.replace(',',String.fromCharCode(8)); 
        frm.fld[1].value = frm.fld[1].value.replace(',',String.fromCharCode(8)); 
        frm.fld[2].value = frm.fld[2].value.replace(',',String.fromCharCode(8)); 
		alert(frm.fld.length);
		for (var i=0; i<frm.fld.length; i++) {     
			alert(frm.fld[i].value);
		} 
} 
</script> 
</head> 

<body> 
<% 
        for each fld in request.form 
                response.write fld & "=" & request.form(fld) & "|" & replace(request.form(fld),chr(8),",") & "<br>" 
        next 
%>      
<form name="form1" method="post" action="XTEST.asp" OnSubmit="return checkform();"> 
  <p> 
    <input name="fld" type="text" id="fld"> 
</p> 
  <p> 
    <input name="fld" type="text" id="fld"> 
  </p> 
  <p> 
    <input name="fld" type="text" id="fld"> 
  </p> 
  <p> 
    <input type="submit" name="Submit" value="Submit"> 
</p> 
</form> 
</body> 
</html> 
