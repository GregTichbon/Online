<html>
<head>
<title>YFCNZ</title>
<script language="JavaScript">
function CheckForm() {
	var cnt = 0
	for (var i=0; i<document.bible.elements.length; i++) {
		if(document.bible.elements[i].name == 'chapter') {
			if(document.bible.elements[i].checked == true) {
				cnt = cnt + 1
			}
		}
	}
	if(cnt == 0 || cnt > 7) {
		alert('Please chose between 1 and 7 chapters');
		return false
	} else
		return true
}
</script>
</head>
<body>
<form name="bible" method="post" action="process.asp" OnSubmit="return CheckForm();">
  <p>Please select the chapters you require and then click on Submit.<br> 
  There is a limit of 7 chapters that you can download at any one time.</p>
  <p>    <%

Function fsoFiles(theFolder)
  Dim rsFSO, objFSO, objFolder, File
  Const adInteger = 3
  Const adDate = 7
  Const adVarChar = 200
  
  'create an ADODB.Recordset and call it rsFSO
  Set rsFSO = Server.CreateObject("ADODB.Recordset")
  
  'Open the FSO object
  Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
  
  'go get the folder to output it's contents
  Set objFolder = objFSO.GetFolder(theFolder)
  
  'Now get rid of the objFSO since we're done with it.
  Set objFSO = Nothing
  
  'create the various rows of the recordset
  With rsFSO.Fields
    .Append "Name", adVarChar, 200
    '.Append "Type", adVarChar, 200
    '.Append "DateCreated", adDate
    '.Append "DateLastAccessed", adDate
    '.Append "DateLastModified", adDate
    .Append "Size", adInteger
    '.Append "TotalFileCount", adInteger
  End With
  rsFSO.Open()
	
  'Now let's find all the files in the folder
  For Each File In objFolder.Files
    If left(lcase(file.name),len(request.querystring("book"))) = lcase(request.querystring("book")) and right(lcase(file.name),4) = ".mp3" then
      rsFSO.AddNew
      rsFSO("Name") = File.Name
      'rsFSO("Type") = File.Type
      'rsFSO("DateCreated") = File.DateCreated
      'rsFSO("DateLastAccessed") = File.DateLastAccessed
      'rsFSO("DateLastModified") = File.DateLastModified
      rsFSO("Size") = File.Size
      rsFSO.Update
    End If

  Next
  rsFSO.Sort = "Name "

  'Now get out of the objFolder since we're done with it.
  Set objFolder = Nothing

  'now make sure we are at the beginning of the recordset
  'not necessarily needed, but let's do it just to be sure.
  rsFSO.MoveFirst()
  Set fsoFiles = rsFSO
	
End Function

'Now let's call the function and open the recordset on the page
'the folder we will be displaying
Dim strFolder
strFolder = Server.MapPath("chapters")

'the actual recordset we will be creating with the fsoFiles function
Dim rsFSO 'now let's call the function and open the recordset

Set rsFSO = fsoFiles(strFolder)

  While Not rsFSO.EOF
  	response.write "<input type=""checkbox"" name=""chapter"" value=""e:\homepage\incedo\private\bible\chapters\" &  rsFSO("Name") & """>" &  rsFSO("Name") & " (" &  formatnumber(rsFSO("Size")/1024,0,,,-1) & "Kb)<br>"
     rsFso.MoveNext()
   Wend
  
  'finally, close out the recordset
  rsFSO.close()
  Set rsFSO = Nothing
	
	
	
	
%>
  </p>
  <p>
    <input name="submit" type="submit" id="submit" value="Submit">
    <input name="clear" type="reset" id="clear" value="Clear">
      </p>
</form>
</body>
</html>
