<%
   	Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
	objXMLHTTP.Open "GET", "http://office.datainn.co.nz?P=0272495088&M=Test", False
	objXMLHTTP.Send
	strPageText = objXMLHTTP.responseText
    response.write strPageText

	objXMLHTTP.Open "GET", "http://office.datainn.co.nz?P=0272495088&M=Test", False
	objXMLHTTP.Send
	strPageText = objXMLHTTP.responseText
    response.write strPageText

	Set objXMLHTTP = Nothing

 %>