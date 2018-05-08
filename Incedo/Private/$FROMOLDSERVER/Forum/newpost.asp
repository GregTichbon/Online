<HTML>
<HEAD>
	<TITLE>DISCUSSION FORUM: NEW MESSAGE</TITLE>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
</HEAD>
<body>
<%if 1=1 then%>
The forums are no longer active, please use the Incedo Facebook pages.
<%else%>
<P><center><b><font size="+1">DISCUSSION FORUM: New Message</font></b></center><p>
<FORM Name="messages" ACTION="post.asp" METHOD="POST">
<input name="knownas" type="hidden" id="knownas" value="<%=session("Incedo_knownas")%>">
<input name="firstname" type="hidden" id="firstname" value="<%=session("Incedo_firstname")%>">
<input name="lastname" type="hidden" id="lastname" value="<%=session("Incedo_lastname")%>">
<input name="memberid" type="hidden" id="memberid" value="<%=session("Incedo_MemberID")%>">
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
					{ name: 'styles', items : [ 'Format','Font','FontSize' ] },
					{ name: 'colors', items : [ 'TextColor','BGColor' ] },
					{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
				]
			});		
</script>
</TD></TR>
</TABLE>
<P>
<CENTER>
<INPUT TYPE="SUBMIT" NAME="submit" VALUE="Submit"></FORM>
</CENTER>
<!--#include file = "footer.inc"-->
<%end if%>
</body>
</HTML>



