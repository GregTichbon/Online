<%
	classifications = array("Jesus centered","Mission through service","People focused","Priesthood of all believers","Generosity","Creativity")
	
	ID = request.querystring("id")
	if id = "" then id = "new"
	
	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	classifications_sql = "SELECT BlogClassification.BlogClassificationID, BlogClassification.Classification, BlogClassification_Date.OpenDate, BlogClassification_Date.CloseDate " & _
			"FROM BlogClassification INNER JOIN BlogClassification_Date ON BlogClassification.BlogClassificationID = BlogClassification_Date.Blog_classification " & _
			"WHERE (((BlogClassification_Date.OpenDate)<=Date()) AND ((BlogClassification_Date.CloseDate) Is Null Or (BlogClassification_Date.CloseDate)>=Date())) " & _
			"ORDER BY BlogClassification.Classification"

	if id <> "new" then
		Set rs = Server.CreateObject("ADODB.Recordset")
		sqlstring = "SELECT * FROM blog where id = " & ID
		rs.Open sqlstring, db
		title = rs("title")
		blog = rs("blog")
		created = rs("created")
		author = rs("author")
		'closedate = rs("closedate")
		authorised = rs("authorised")
		authorname = rs("authorname")
		'anonymous = rs("anonymous")
		accesslevel = rs("accesslevel")
		rs.close
		classifications_sql = "or BlogClassification.BlogClassificationID = " 'to handle ones that may now have been closed
	else
		author = session("TeOraHou_MemberID")
		'authorname = session("TeOraHou_knownas") & " " & session("TeOraHou_lastname")
	end if
	
%>
<HTML>
<HEAD>
	<TITLE>BLOG</TITLE>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
</HEAD>
<body>
<P><center>
  <b><font size="+1">BLOG</font></b>
</center><p>
<FORM Name="messages" ACTION="maint_process.asp" METHOD="POST">
<input name="knownas" type="hidden" id="knownas" value="<%=session("TeOraHou_knownas")%>">
<input name="firstname" type="hidden" id="firstname" value="<%=session("TeOraHou_firstname")%>">
<input name="lastname" type="hidden" id="lastname" value="<%=session("TeOraHou_lastname")%>">
<input name="memberid" type="hidden" id="memberid" value="<%=session("TeOraHou_MemberID")%>">
<input name="author" type="hidden" id="author" value="<%=author%>">
<INPUT TYPE="Hidden" NAME="editmessage" VALUE="new">
<TABLE>
<TR>
  <TD><B>Title:</B></TD>
<TD><INPUT TYPE="TEXT" SIZE="50" MAXLENGTH="100" NAME="topic"></INPUT></TD></TR>
<TR>
  <TD VALIGN = TOP><B>Blog:</B></TD>
  <TD VALIGN = TOP><TEXTAREA NAME="blog" id="blog"><%=bog%></TEXTAREA>
<script type="text/javascript">
			ckeditor = CKEDITOR.replace( 'blog',
			{
				toolbar :
				[
					{ name: 'document' }, // { name: 'document', items : [ 'Source','-' ] },
					{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
					{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
					{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
					'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-' ] },
					{ name: 'links', items : [ 'Link','Unlink' ] },
					{ name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar' ] },
					'/',
					{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
					{ name: 'styles', items : [ 'Font','FontSize' ] },
					{ name: 'colors', items : [ 'TextColor','BGColor' ] },
					{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
				]
			});		
</script>
</TD></TR>
<%
if session("TeOraHou_MemberID") = "" then
%>
<TR>
  <TD VALIGN = TOP>Access</TD>
  <TD VALIGN = TOP><select name="accesslevel" size="1" id="accesslevel" onChange="javascript:alert('If public, allow anonymous');">
    <option value="0">--- Please Select ---</option>
    <option value="1">Public</option>
    <option value="2">Friends and Members</option>
    <option value="3">Members Only</option>
  </select></TD>
</TR>
<%
else
%>
<input name="accesslevel" type="hidden" id="accesslevel" value="1">
<%
end if
%>
<TR>
  <TD VALIGN = TOP>Classifications</TD>
  <TD VALIGN = TOP>
<%
for each classification in classifications
%>
  <input type="checkbox" name="<%=classification%>" id="<%=classification%>" value="checkbox"><%=classification%><br>
<%
next
%>
</TD>
</TR>
<TR>
  <TD VALIGN = TOP>Author Name </TD>
  <TD VALIGN = TOP><INPUT NAME="author" TYPE="TEXT" id="author" value="<%=authorname%>" SIZE="50" MAXLENGTH="100"></TD>
</TR>
<TR id="tr_anonymous>
  <TD VALIGN = TOP>Anonymous</TD>
  <TD VALIGN = TOP><input type="checkbox" name="anonymous" id="anonymous" value="checkbox"></TD>
</TR>
<%
if session("TeOraHou_MemberID") <> "" then
%>
<TR>
  <TD VALIGN = TOP>Authorised</TD>
  <TD VALIGN = TOP><input type="checkbox" name="authorised" value="checkbox" id="authorised"></TD>
</TR>
<%
end if
%>
<TR>
  <TD VALIGN = TOP>&nbsp;</TD>
  <TD VALIGN = TOP>&nbsp;</TD>
</TR>
<TR>
  <TD VALIGN = TOP>&nbsp;</TD>
  <TD VALIGN = TOP>&nbsp;</TD>
</TR>
</TABLE>

<INPUT TYPE="SUBMIT" NAME="submit" VALUE="Submit"></FORM>
</body>
</HTML>
<%
	db.close
	set db = nothing
%>


