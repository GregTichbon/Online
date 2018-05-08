<HTML><HEAD><title>Send Txt</title>
<script language="javascript">
function charsleft() {
	var frm = document.frmtxt;
	frm.chars.value = 160 - frm.txt.value.length;
}
</script>
</HEAD>
<BODY bgcolor="#99ffff">
<form name="frmtxt" method="post" action="send_text_process.asp">
  <table width="800" border="1" align="center">
    <tr> 
      <td>Live Run</td>
      <td> 
        <input type="checkbox" name="live" value="yes">
        </td>
    </tr>
    <tr> 
      <td>Description</td>
      <td><TEXTAREA name=description cols=80>Test</TEXTAREA>
      </td>
    </tr>
    <tr>
      <td height="2">Batch</td>
      <td height="2"><input name="batch" id="batch" value="1001" ></td>
    </tr>
    <tr> 
      <td height="2">Database</td>
      <td height="2"> 
        <input name="database" size="80" value="e:\$generic\incedo\connectme.mdb" >
      </td>
    </tr>
    <tr> 
      <td> Mobile Number Field </td>
      <td> 
        <input name="mobilenumber" id="mobilenumber" value="mobiletext" >
      </td>
    </tr>
    <tr>
      <td>ID Field </td>
      <td><input name="id" id="id" value="id" ></td>
    </tr>
    <tr> 
      <td>SQL</td>
      <td><TEXTAREA name=sql rows=5 cols=80>Select * from people where mobiletext is not null and mobiletext <> ''  order by firstname</TEXTAREA>
      </td>
    </tr>
    <tr> 
      <td> Text<br>
      <input name="chars" type="text" id="chars" value="160" size="5" maxlength="3"> 
      characters left </td>
      <td><TEXTAREA name=txt cols=80 rows=15 id="txt" onKeyUp="charsleft()" maxlength="180">||firstname||</TEXTAREA>
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="center"> 
          <input type="submit" name="submit" value="                 Submit                  ">
        </div>
      </td>
    </tr>
  </table>
</form>
</BODY>
</HTML>
