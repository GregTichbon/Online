<%
if 1=2 then
	set di = server.createobject("DIHTTP.HTTP")
	response.write "----------------------------------------------------------------------------------------<br>"
	response.write di.send("www.foodmachineryaustralasia.co.nz/admin/index.asp","fma","food4asia")
	'response.write di.send("www.datainn.co.nz","","")
	response.write "<br>----------------------------------------------------------------------------------------"
	set di = nothing
elseif 1=2 then	
      Set xmlHTTP = CreateObject("MSXML2.ServerXMLHTTP.3.0")
  
      xmlHTTP.open "GET", "www.datainn.co.nz", false
      xmlHTTP.send()
      CurrentPage = xmlHTTP.ResponseText
      CurrentStatus = xmlHTTP.Status
      CurrentReadiness = xmlHTTP.readyState
       
      If CurrentStatus = 200 AND CurrentReadiness = 4 Then
         TheBody = GetBody(CurrentPage,StartCacheMarker,EndCacheMarker)
         Response.Write TheBody
      Else
         Response.Write "<div>Page Not Available</div>"
      End IF
  
      Set xmlHTTP = Nothing
else
		set di = server.createobject("DI.IIS")
		url = "http://www.datainn.co.nz" 
		url = "http://www.foodmachineryaustralasia.co.nz/admin/index.asp"
		
		mobile = "64272495088"
		message = "test"
		
		data = "<?xmlversion=""1.0""?>"
		data = data & "<send>"
		data = data & "<message>"
		data = data & "<timestamp>" & di.di_format(now(),"yyyymmddhhnnss") & "</timestamp>"
		data = data & "<userId>incedo</userId>"
		data = data & "<password>Aeraixe3</password>"
		data = data & "<messageId>" & di.di_format(now(),"yyyymmddhhnnss") & "</messageId>"
		data = data & "<to>" & mobile & "</to>"
		data = data & "<from>8244</from>"
		data = data & "<inReplyToId/>"
		data = data & "<deliveryInstruction/>"
		data = data & "<processingInstruction/>"
		data = data & "<rateCode/>"
		data = data & "<body>" & message & "</body>"
		data = data & "</message>"
		data = data & "<environment>2</environment>"
		data = data & "<application>Incedo</application>"
		data = data & "</send>"
		
		url = "https://www.lateralnz.com/HTTP/LateralServer/?XML=" & data
		response.write url & "<br>"

		set xmlhttp = CreateObject("Msxml2.ServerXMLHTTP.3.0") 
		xmlhttp.open "GET", url, false, "incedo", "Aeraixe3" 
		xmlhttp.send "" 
		Response.write xmlhttp.responseText 
		set xmlhttp = nothing 
		set di = nothing
end if
%>