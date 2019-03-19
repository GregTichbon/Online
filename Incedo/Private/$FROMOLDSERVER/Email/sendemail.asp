<%
	prefix = session("email_prefix")
	session(prefix & "_email_page") = ""
	session(prefix & "_email_database") = ""
	session(prefix & "_email_sql") = ""
	session(prefix & "_email_message") = ""
	session(prefix & "_email_live") = ""
	session(prefix & "_email_field") = ""
	session(prefix & "_email_sender") = ""
	session(prefix & "_email_subject") = ""
	session(prefix & "_email_bcc") = ""
	session(prefix & "_email_result") = ""
	session(prefix & "_email_identifier") = ""
	session("email_prefix") = ""
%>
<HTML><HEAD><title>Email</title></HEAD>
<BODY>
<form name="email" method="post" action="sendemail_process.asp">
  <table width="800" border="1" align="center">
    <tr> 
      <td>Live Run</td>
      <td> 
        <input type="checkbox" name="live" value="yes">
        <input name="prefix" type="hidden" id="prefix" value="tra">
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
        <input type="text" name="database" size="80" value="C:\inetpub\vhosts\incedo.org.nz\incedo.mdb">
      </td>
    </tr>
    <tr> 
      <td>Email Field Name</td>
      <td> 
        <input type="text" name="emailfield" size="20" value="email">
      </td>
    </tr>
    <tr>
      <td>Identifier Field Name</td>
      <td><input name="identifier" type="text" id="identifier" value="ID" size="20"></td>
    </tr>
    <tr>
      <td>Sender</td>
      <td>
        <input type="text" name="sender" size="80" value="@incedo.org.nz">
      </td>
    </tr>
    <tr>
      <td>BCC</td>
      <td><input name="bcc" type="text" id="bcc" size="40"></td>
    </tr>
    <tr> 
      <td>Subject</td>
      <td>
        <input type="text" name="subject" size="80" value="Incedo Members Update for ||usefirstname|| ||lastname||">
</td>
    </tr>
    <tr> 
      <td>SQL</td>
      <td> 
        <textarea name="sql" cols="80" rows="5">SELECT DISTINCTROW People.ID, People.Lastname, IIf([knownas] Is Not Null,[knownas],[firstname]) AS UseFirstname, People.Email, People.membershipdate, People.Category, People.membersupdate
FROM People
WHERE (((People.membershipdate) Is Not Null) AND ((People.Category)<>'Ceased') AND ((People.membersupdate)<>True)) OR (((People.membershipdate) Is Null) AND ((People.Category)<>'Ceased') AND ((People.membersupdate)=True))
ORDER BY IIf([email] Is Null,0,1), People.Lastname, IIf([knownas] Is Not Null,[knownas],[firstname]);
</textarea>
      </td>
    </tr>
    <tr> 
      <td>HTML Text</td>
      <td> 
        <textarea name="message" cols="80" rows="15" id="message"></textarea>
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
