<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "documents/default.asp?" & request.querystring
		response.redirect "../signon"
	else
%>
	<!--#include file="../inc_logging.asp"-->
<%
	if 1=2 then
		secgroup = "Documents"
		secoption = "Standard"
		secvalue = "Yes"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult <> "OK" then
			response.end
		end if		
	end if
	end if

myfile = Request.QueryString("document")
connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
Set db = Server.CreateObject("ADODB.Connection")
db.Open connection_string
Set RS = Server.CreateObject("ADODB.RecordSet")
sql = "select * from documents where id = " & myfile
rs.open sql,db
if rs.eof then

else

	'--declare variables
	Dim File
	Dim strAbsFile
	Dim strFileExtension
	Dim objFSO
	Dim objFile
	Dim objStream
	File = rs("document")
	'-- set absolute file location
	strAbsFile = "e:\homepage\incedo\private\documents\documents\" & file
	'-- create FSO object to check if file exists and get properties
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	'-- check to see if the file exists
	If objFSO.FileExists(strAbsFile) Then
		Set objFile = objFSO.GetFile(strAbsFile)
		'-- first clear the response, and then set the appropriate headers
		Response.Clear
		'-- the filename you give it will be the one that is shown
		' to the users by default when they save
		Response.AddHeader "Content-Disposition", "attachment; filename=" & objFile.Name
		Response.AddHeader "Content-Length", objFile.Size
		Response.ContentType = "application/force-download" 'octet-stream"
		Set objStream = Server.CreateObject("ADODB.Stream")
		objStream.Open
		'-- set as binary
		objStream.Type = 1
		Response.CharSet = "UTF-8"
		'-- load into the stream the file
		objStream.LoadFromFile(strAbsFile)
		'-- send the stream in the response
		Response.BinaryWrite(objStream.Read)
		objStream.Close
		Set objStream = Nothing
		Set objFile = Nothing
	Else 'objFSO.FileExists(strAbsFile)
		Response.Clear
		Response.Write("No such file exists.")
	End If
	Set objFSO = Nothing
 

end if
rs.close
set rs = nothing
db.close
set db = nothing
%> 





