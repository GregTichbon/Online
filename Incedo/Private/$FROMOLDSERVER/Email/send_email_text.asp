<HTML><HEAD><title>Send Email</title></HEAD>
<BODY bgcolor="#99FFFF">
<form name="email" method="post" action="sendemail_process.asp">
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
        <input type="text" name="database" size="80" value="e:\$generic\yfcnz\people.mdb">
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
        <input type="text" name="sender" size="80" value="mlt@yfc.org.nz">
      </td>
    </tr>
    <tr> 
      <td>Subject</td>
      <td> 
        <input type="text" name="subject" size="80" value="YFCNZ members update for ||usefirstname|| ||lastname||">
      </td>
    </tr>
    <tr> 
      <td>SQL</td>
      <td> 
        <textarea name="sql" cols="80" rows="5">SELECT distinctrow People.Lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) AS UseFirstname, People.Email
FROM People LEFT JOIN People_Ministry ON People.ID = People_Ministry.ID
WHERE (((People.membershipdate) Is Not Null) AND ((People.Category)<>"Ceased")) OR (((People.Category)<>"Ceased") AND ((People_Ministry.Ministry)='National Board'))
ORDER BY IIf([email] Is Null,0,1), lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) </textarea>
      </td>
    </tr>
    <tr> 
      <td>Attached filename (Don't use just paste html into &quot;HTML Text below)</td>
      <td>
        <input type="text" name="issue" size="80" value="e:\homepage\youthforchrist\private\MembersUpdates\12April2005\email.html">
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