<HTML><HEAD><title>Connect|Me Email</title></HEAD>
<BODY bgcolor="#99FFFF">
<form name="email" method="post" action="send_email_results.asp">
  <table width="800" border="1" align="center">
    <tr> 
      <td>Live Run</td>
      <td> 
        <input type="checkbox" name="live" value="yes">
      </td>
    </tr>
    <tr> 
      <td>Description</td>
      <td> 
        <textarea name="description" cols="80">Test</textarea>
      </td>
    </tr>
    <tr> 
      <td height="2">Database</td>
      <td height="2"> 
        <input type="text" name="database" size="80" value="e:\$generic\yfcnz\yfcnzdb.mdb">
      </td>
    </tr>
    <tr> 
      <td>Email Field Name</td>
      <td> 
        <input type="text" name="emailfield" size="20" value="email">
      </td>
    </tr>
    <tr> 
      <td>Sender</td>
      <td> 
        <input type="text" name="sender" size="80" value="connectme@yfc.org.nz">
      </td>
    </tr>
    <tr> 
      <td>Subject</td>
      <td> 
        <input type="text" name="subject" size="80" value="Connect|Me update for ||firstname|| ||surname||">
      </td>
    </tr>
    <tr> 
      <td>SQL</td>
      <td> 
        <textarea name="sql" cols="80" rows="5">Select * from people where email is not null and holdemail <> true order by email, surname, firstname</textarea>
      </td>
    </tr>
    <tr> 
      <td>Attached filename (Don't use just paste html into &quot;HTML Text below)</td>
      <td>
        <input type="text" name="issue" size="60" value="e:\homepage\youthforchrist\connectme\issue05\default.asp">
      </td>
    </tr>
    <tr> 
      <td>HTML Text</td>
      <td> 
        <textarea name="html" cols="80" rows="15"></textarea>
      </td>
    </tr>
    <tr> 
      <td height="2">Non-HTML Text</td>
      <td height="2"> 
        <textarea name="nonhtml" cols="80" rows="5">Not yet functional ...</textarea>
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
<p align="center">&nbsp;</p>
</BODY>
</HTML>
