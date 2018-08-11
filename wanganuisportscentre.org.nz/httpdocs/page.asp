<%
	if session("wcsc-signedon") = "" then
		response.redirect "signon.asp"
	end if
%>

<!DOCTYPE html>
<html>
<head>
<title>Wanganui Sports Centre Administration</title>
<script type="text/javascript" src="tinymce/js/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
tinymce.init({
        selector: "textarea",
        plugins: [
                "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker textpattern"
        ],

        toolbar1: "fullpage | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
        toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image media code | insertdatetime preview | forecolor backcolor",
        toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | fullscreen | ltr rtl | visualchars visualblocks nonbreaking pagebreak",

        menubar: false,
        toolbar_items_size: 'small',

        style_formats: [
                {title: 'Bold text', inline: 'b'},
                {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
                {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
                {title: 'Example 1', inline: 'span', classes: 'example1'},
                {title: 'Example 2', inline: 'span', classes: 'example2'},
                {title: 'Table styles'},
                {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ],
		height: 700
 });

function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;


	if(msg != '') {
		alert('You must enter valid information for the following:\n' + msg);
		return(false);
	}
}


</script>
</head>
<body>
    <%
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\wanganuisportscentre.org.nz\wanganuisportscentre.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	page = request.querystring("page")
	if page = "new" then
		id = "new"
		title = "New page"
		content = ""
		titlefld = ""
	else
		titlefield = ""
		sql = "SELECT * from [pages] where reference = '" & page & "'" 
		rs.Open sql, db
		if rs.eof then
			title = "Page not found"
		else
			id = rs("pageid")
			reference = rs("reference")
			content = rs("content") & ""
			content = replace(content,"'","&#39")
			content = replace(content,vbcrlf,"")
		end if
		rs.close
	end if
%>
    <h1>PAGE MAINTENANCE</h1>
	<h2><%=title%></h2>
<%
if 	title <> "Page not found" then
%>

    <form name="maint" method="post" action="page_process.asp" OnSubmit="return checkform();">
	        <input name="id" type="hidden" value="<%=id%>">
      <br>
	  
	  <textarea name="content" id="content"><%=content%></textarea>
      <p>
        <input name="$reset" type="reset" id="$reset" value="Reset">
        <input name="$submit" type="submit" id="$submit" value="Submit">
</p>
    </form>

<%
end if
%>
</body>
</html>
<%
		set rs = nothing
		db.close
		set db = nothing
%>

