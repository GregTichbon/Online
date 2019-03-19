<%
	'for each fld in request.form
		'response.write fld & " = " & request.form(fld) & "<br>"
	'next
	set di = server.createobject("DI.IIS")
	chapters = replace(request.form("chapter"),","," ")
	fname = "e:\homepage\incedo\private\bible\download\" & session.sessionid & ".zip"
response.write chapters & "<br>" & fname
'response.end
	Response.write di.DI_zip(chapters,fname,"-a")
	
	set fs = CreateObject("Scripting.FileSystemObject")
	stime = timer()
	do until fs.FileExists(fname) or timer() - stime > 10
		
	loop
	if fs.FileExists(fname) then
		'Response.Write session.sessionid & ".zip"
		response.redirect "download/" & session.sessionid & ".zip"
	else
		Response.Write "File not created"
	end if
%>

