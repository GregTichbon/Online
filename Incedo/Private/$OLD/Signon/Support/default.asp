<%
	name = Request.Cookies("chatname")
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
	padding: 10px;
}
</style>
</head>
<body background="../../images/background.gif">
<form action="process.asp" method="post" name="chat">
  <div align="center">
    <div class="outerbox">
      <h1> Incedo Online Support </h1>
       <table width="95%"  border="1" cellpadding="5" cellspacing="0" bordercolor="#000000">
         <tr>
           <td width="100"><div align="right">Name</div></td>
           <td><input type="text" name="name" id="name" style="width:99%" value="<%=name%>"></td>
         </tr>
         <tr>
           <td width="100"><div align="right">Question</div></td>
           <td><textarea name="message" rows="3" id="message" style="width:99%"></textarea></td>
         </tr>
         <tr>
           <td colspan="2">
             <div align="right">
               <input name="submit" type="submit" id="submit" value="Submit">
             </div></td>
         </tr>
       </table>
      <br>
    </div>
  </div>
</form>
</body>
</html>
