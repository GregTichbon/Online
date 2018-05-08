<%
set di = server.createobject("DI.IIS")
answer = di.DI_OpenURL("http://www.incedo.org.nz/private/txts/capture/test_process.asp?mode=qs&message=test&email=greg@datainn.co.nz")
set di = nothing

PostData = "encoding=UTF-8&message=test&email=greg@datainn.co.nz"
rslt = PostTo(PostData,"http://www.incedo.org.nz/private/txts/capture/test_process.asp?mode=f")


Function PostTo(Data, URL)
	Dim objXMLHTTP, xml
	On Error Resume Next
	Set xml = Server.CreateObject("MSXML2.ServerXMLHTTP.3.0")
	xml.Open "POST", URL, False
	xml.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	xml.Send Data
	If xml.readyState <> 4 then
		xml.waitForResponse 10
	End If
	If Err.Number = 0  AND http.Status = 200 then
		PostTo = xml.responseText
	else
		PostTo = "Failed"
	End If
	Set xml = Nothing
End Function



%>