<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Documents"
		secoption = "Full"
		set di = server.createobject("DI.IIS")
		
		set di = nothing
		
	end if

	session("incedoconnectme_email_page") = ""
	session("incedoconnectme_email_sql") = ""
	
	set fs = server.CreateObject("Scripting.FileSystemObject")
	set ts = fs.OpenTextFile(Server.MapPath("EmailTemplate.htm"),1)
	emailtemplate = ts.readall
	emailtemplate = replace(emailtemplate,"'","&#39")
	emailtemplate = replace(emailtemplate,vbcrlf,"")
	ts.Close
	set ts = nothing
	set fs = nothing
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ConnectMe</title>
<script type="text/javascript" src="fckeditor/fckeditor.js"></script>
<script language="JavaScript">

function GetLength(instance) {
	// Get the editor instance that we want to interact with.
	var oEditor = FCKeditorAPI.GetInstance(instance) ;

	// Get the Editor Area DOM (Document object).
	var oDOM = oEditor.EditorDocument ;

	var iLength ;

	// The are two diffent ways to get the text (without HTML markups).
	// It is browser specific.

	if ( document.all )		// If Internet Explorer.
	{
		iLength = oDOM.body.innerText.length ;
	}
	else					// If Gecko.
	{
		var r = oDOM.createRange() ;
		r.selectNodeContents( oDOM.body ) ;
		iLength = r.toString().length ;
	}
	return(iLength);
	//alert( 'Actual text length (without HTML markups): ' + iLength + ' characters' ) ;
}
</script>
</head>
<body>
<form action="sendemail_process.asp" method="post" name="email" id="email">
  <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tr>
      <td><div align="right">Live</div></td>
      <td><input name="live" type="checkbox" id="live" value="yes"></td>
    </tr>
    <tr>
      <td><div align="right">Selection</div></td>
      <td><textarea name="sql" rows="6" id="sql" style="width:100%">
SELECT organisation, surname, firstname, ConnectMe_Communications.Detail AS Email
FROM CommunicationsType INNER JOIN (ConnectMe_Communications INNER JOIN ConnectMe ON ConnectMe_Communications.ConnectMe = ConnectMe.ID) ON CommunicationsType.ID = ConnectMe_Communications.Type
WHERE (((CommunicationsType.Email)=True) AND ((ConnectMe.Region)='Northland'))</textarea></td>
    </tr>
    <tr>
      <td><div align="right">Message</div></td>
      <td> 
	  <script type="text/javascript">
var oFCKeditor = new FCKeditor( 'message' ) ;
oFCKeditor.BasePath	= 'FCKeditor/' ;
oFCKeditor.Value	= '<%=emailtemplate%>' ;
oFCKeditor.Create() ;
</script>	
</td>
    </tr>
    <tr>
      <td colspan="2"><div align="center">
        <input name="submit" type="submit" id="submit" value="Submit">
      </div></td>
    </tr>
  </table>
</form>
</body>
</html>
