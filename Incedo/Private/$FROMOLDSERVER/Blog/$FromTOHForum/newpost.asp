<HTML>
<HEAD>
	<TITLE>DISCUSSION FORUM: NEW MESSAGE</TITLE>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
</HEAD>
<body>
<P><center><b><font size="+1">DISCUSSION FORUM: New Message</font></b></center><p>
<FORM Name="messages" ACTION="post.asp" METHOD="POST">
<input name="knownas" type="hidden" id="knownas" value="<%=session("TeOraHou_knownas")%>">
<input name="firstname" type="hidden" id="firstname" value="<%=session("TeOraHou_firstname")%>">
<input name="lastname" type="hidden" id="lastname" value="<%=session("TeOraHou_lastname")%>">
<input name="memberid" type="hidden" id="memberid" value="<%=session("TeOraHou_MemberID")%>">
<INPUT TYPE="Hidden" NAME="editmessage" VALUE="new">
<TABLE>
<TR>
  <TD><B>Title:</B></TD>
<TD><INPUT TYPE="TEXT" SIZE="50" MAXLENGTH="100" NAME="topic"></INPUT></TD></TR>
<TR><TD VALIGN = TOP><B>Message:</B></TD>
<TD VALIGN = TOP><TEXTAREA NAME="comments"></TEXTAREA>
<script type="text/javascript">
			ckeditor = CKEDITOR.replace( 'comments',
			{
				toolbar :
				[
					{ name: 'document', items : [ 'Source','-' ] },
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
</TABLE>

<INPUT TYPE="SUBMIT" NAME="submit" VALUE="Submit"></FORM>
<!--#include file = "database.inc"-->
<%
	sql = "SELECT people.Lastname, people.Firstname, people.KnownAs, ForumMembers.[email], ForumMembers.Status " & _
		  "FROM people INNER JOIN ForumMembers ON people.ID = ForumMembers.MemberID " & _
		  "WHERE (((ForumMembers.email) Is Not Null) AND ((ForumMembers.Status)='Live') AND ((people.Category) Is Null Or (people.Category)<>'Ceased')) order by firstname, lastname"
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	rs1.Open sql, conn
	do until rs1.eof
		response.write "<input type=""checkbox"" id=""$snd" & xx & """ name=""$snd" & xx & """ value=""-1"" checked> " & rs1("firstname") & " " & rs1("lastname") & " - " & rs1("email") & "<br>"
		rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
%>


<!--#include file = "footer.inc"-->
</body>
</HTML>



