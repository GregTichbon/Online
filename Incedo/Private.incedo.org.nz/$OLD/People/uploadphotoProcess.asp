<%
	rootfolder = Server.MapPath("\") & "\private\people\photos\"
	filename = request.querystring("id") & ".jpg"
	set SC = server.createobject("SCUpload.Upload")
	set sir = Server.CreateObject("SfImageResize.ImageResize")
	SC.upload
	for i = 1 to SC.files.count
		for j = 1 to SC.files(i).item.count
			SC.files(i).item(j).save rootfolder & "originals", filename
			sir.LoadFromFile rootfolder & "originals\" & filename
			sir.Height = 100
			sir.DoResize
			sir.SaveToFile rootfolder & "thumbnails\" & filename
			
			sir.LoadFromFile rootfolder & "originals\" & filename
			sir.Height = 400
			sir.DoResize
			sir.SaveToFile rootfolder & "H400\" & filename
			
		next 
	next 
	set SC = nothing
	set sir = nothing

	Response.Redirect "maint.asp?id=" & request.querystring("id")
%>
