<%
	if session("Incedo_MemberID")= "" then
		session("Incedo_Returnto") = "forum/showposts.asp?" & request.querystring
		response.redirect "../signon"
	else
%>
	<!--#include file="../inc_logging.asp"-->
<%
		secgroup = "Forum"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		'if secresult = "Failed" then 		
		'	response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
		'	response.end
		'end if
	end if
	if secresult = "Full" then
		'deleteoption = "<input name=""delete"" type=""submit"" id=""delete"" value=""Delete"" onclick=""return confirmdelete();""><br>Inhibit Email<input type=""checkbox"" name=""inhibitemail"" value=""1"">"
		deleteoption = "<br>Inhibit Email<input type=""checkbox"" name=""inhibitemail"" value=""1"">"
	'Shouldn't be able to delete where there are messages that have this one as there parentmessage! or warning and delete all messages below?
	end if
	id = request.querystring("id")
%>
<!--#include file = "database.inc"-->
<HTML>
<HEAD>
	<TITLE>DISCUSSION FORUM MESSAGE</TITLE>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js"></script>
	<script language="JavaScript">

	var replyedit = '';
	var ckeditor;
	function reply(id) {
		alert("The forums are no longer active, please use the Incedo Facebook pages");
		return;
		if(replyedit != '') {
			alert('You are already answering a message');
		}
		else {
			replyedit = 'r' + id;
			obj = document.getElementById('r' + id);		
			obj.innerHTML = '<input name="topic" type="text" id="topic" style="width:100%" class="summary"><br><textarea name="comments" id="comments" style="width:100%"></textarea><br><div align="right"><input name="cancel" type="button" id="cancel" value="Cancel" onClick="cancelreplyedit()"><input name="submit" type="submit" id="submit" value="Submit"></div>';
			document.getElementById('topic').value = document.getElementById('t' + id).innerHTML;
			document.getElementById('parentmessage').value = id;
			//tinyMCE.execCommand('mceAddControl',false,'comments'); 
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
		}
	}
	editcomments = ''
	function edit(id) {
		alert("The forums are no longer active, please use the Incedo Facebook pages");
		return;
		if(replyedit != '') {
			alert('You are already answering a message');
		}
		else {
			replyedit = 'e' + id;
			obj = document.getElementById('e' + id);		
			editcomments = obj.innerHTML;
			obj.innerHTML = '<input name="topic" type="text" id="topic" style="width:100%"><br><textarea name="comments" id="comments" style="width:100%"></textarea><br><div align="right"><input name="cancel" type="button" id="cancel" value="Cancel" onClick="cancelreplyedit()"><input name="submit" type="submit" id="submit" value="Submit"><%=deleteoption%></div>';
			document.getElementById('topic').value = document.getElementById('t' + id).innerHTML;
			document.getElementById('comments').value = editcomments;
			document.getElementById('parentmessage').value = id;
			document.getElementById('editmessage').value = 1;
			//tinyMCE.execCommand('mceAddControl',false,'comments'); 
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
		}
	}
	
	function deletepost(id) {
		alert("The forums are no longer active, please use the Incedo Facebook pages");
		return;
		if(confirm('Are you sure you want to delete this?')) {
			window.location='deletepost.asp?parent=<%=id%>&id=' + id;
		}
	}
	
	function cancelreplyedit() {
		//tinyMCE.execCommand('mceRemoveControl', false, 'comments');
		ckeditor.destroy();
		id = replyedit;
		obj = document.getElementById(id);		
		obj.innerHTML = editcomments;
		editcomments = '';
		replyedit = '';
	}
	
	function confirmdelete() {
		if(confirm('Are you sure you want to delete?')) {
			return(true);
		}
		else {
			return(false);
		}
	}
	
	function showlayer(layerid) { 
			if (document.getElementById){ 
				var vlayerid=document.getElementById(layerid); 
				vlayerid.style.display=(vlayerid.style.display!="block")? "block" : "none" 
				centrelayer(layerid);
			} 
	} 
	
	function centrelayer(layerid) { 
			var vlayerid=document.getElementById(layerid); 
			var pageWidth = document.body.offsetWidth ? document.body.offsetWidth : window.innerWidth;
			vlayerid.style.left = ((pageWidth - vlayerid.offsetWidth) / 2)+'px'; 
	}
	
	
	function closelayer(layerID) { 
			document.getElementById(layerID).style.display = "none"; 
	} 	
</script>
<link href="forum.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.b1h, .b2h, .b3h, .b4h, .b2bh, .b3bh, .b4bh{font-size:1px; overflow:hidden; display:block;}
	.b1h {height:1px; background:#aaa; margin:0 5px;}
	.b2h, .b2bh {height:1px; background:#aaa; border-right:2px solid #aaa; border-left:2px solid #aaa; margin:0 3px;}
	.b3h, .b3bh {height:1px; background:#aaa; border-right:1px solid #aaa; border-left:1px solid #aaa; margin:0 2px;}
	.b4h, .b4bh {height:2px; background:#aaa; border-right:1px solid #aaa; border-left:1px solid #aaa; margin:0 1px;}
	.b2bh, .b3bh, .b4bh {background: #ddd;}
	.headh {background: #aaa; border-right:1px solid #aaa; border-left:1px solid #aaa;}
	.headh h3 {margin: 0px 10px 0px 10px; padding-bottom: 3px;}
	.contenth {background: #ddd; border-right:1px solid #aaa; border-left:1px solid #aaa;}
	.contenth div {margin-left: 12px; padding-top: 5px;}
	.contenth p {margin-bottom: 0px}
	
#alert {
	margin:auto;
	width:510px;
	//height:364px;
	text-align: left;
	padding: 0px;
	border: solid #0000FF;
	top: 79px;
	position: absolute;
	display: none;
	left: 448px;
	font-size: 18px;
	background-color: #FF0000;
}
	
</style>
</HEAD>
<BODY onload = "javascript:showlayer('alert')" onResize="javascript:centrelayer('alert')">
  <div id="alert" class="alert">
    <p align="right"><a href="javascript:void(0)" onclick="closelayer('alert');">X</a></p>
	<p>The forums are no longer active, please use the Incedo Facebook pages.</p>
	<p align="center"><a href="javascript:void(0)" onclick="closelayer('alert');">Close</a></p>
  </div>
<form action="post.asp" method="post" name="messages" id="messages">
  <input name="knownas" type="hidden" id="knownas" value="<%=session("Incedo_knownas")%>">
  <input name="firstname" type="hidden" id="firstname" value="<%=session("Incedo_firstname")%>">
  <input name="lastname" type="hidden" id="lastname" value="<%=session("Incedo_lastname")%>">
  <input name="memberid" type="hidden" id="memberid" value="<%=session("Incedo_MemberID")%>">
  <%
set di = server.createobject("DI.IIS")
c1 = 0
sThread = MessageChildren(id, 0)
response.write sThread
set di = nothing
%>
<!--#include file = "footer.inc"-->
<!--#include file = "database_cleanup.inc"-->
<input name="threadparent" type="hidden" value="<%=id%>">
<input name="parentmessage" id="parentmessage" type="hidden" value="">
<input name="editmessage" id="editmessage" type="hidden" value="">
</form>
</body>
</HTML>
<%
Function MessageChildren(ID, IndentLevel)
	dim oRs, oCmd, sSQL, sAns
	dim oParam
	set oCmd = Server.CreateObject("ADODB.Command")
	set oCmd.ActiveConnection = conn
	oCmd.CommandText = "SELECT [firstname] & ' ' & [lastname] AS authorname, Skype, Email, forummessages.* " & _
"FROM people INNER JOIN forumMESSAGES ON people.ID = forumMESSAGES.AuthorID " & _
"WHERE forumMESSAGES.ID = " & id
'response.write "<br>-------------------------------------------------<br>" & oCmd.CommandText & "<br>-------------------------------------------------<br>"
'response.write id & " "
'response.end
	oCmd.CommandType = 1
	'set oParam = cmd.CreateParameter("MESSAGEID", 3, 1)
	'oCmd.parameters.append oParam
	'oParam.value = cint(ID)
	set oRs = oCmd.execute
	set oParam = nothing
	iIndent = IndentLevel
	'set oRs = oCmd.execute
	if oRs.eof then
		oRs.close 
		set oRs = Nothing
		set oCmd = nothing
		MessageChildren = ""
		exit function
	end if
	c1 = c1 + 1
	'spacer = "<TD width=""" & iIndent * 20 & "px"" bgcolor=""ffffff""></td>"
	spacer = "<TD bgcolor=""ffffff""></td>"
	if oRs("Skype") <> "" then
		skype = "<a href=""skype:" & oRs("skype") & "?call""><img src=""http://mystatus.skype.com/smallicon/greg_tichbon"" style=""border: none;"" width=""16"" height=""16"" alt=""Skype""></a> "
	else
		skype = ""
	end if
	if oRs("email") <> "" then
		'email = "<a href=""mailto:" & oRs("email") & "?subject=" & replace(oRs("Topic"),"""","""""") & "&body=" & replace(oRs("Comments"),"""","""""") & """>E</a> "
		email = "<a href=""mailto:" & oRs("email") & "?subject=" & replace(oRs("Topic"),"""","""""") & """><img src=""icons/email.gif"" alt=""Email " & oRs("AuthorName") & " directly""></a> "
	else
		email = ""
	end if
	sAns = "<table><TR>" & spacer
	sAns = sAns & "<td><b class=""b1h""></b><b class=""b2h""></b><b class=""b3h""></b><b class=""b4h""></b><div class=""headh""><h3>"
	sAns = sAns & "<table style=""width=99%""><tr><td>Posted: "
	sAns = sAns & di.di_format(oRs("DATEPOSTED"),"dd mmm yyyy hh:nn")
	sAns = sAns & "&nbsp;&nbsp;<img src=""icons/reply_topic.gif"" alt=""Reply"" onClick=""reply('" & oRs("id") & "')"">"
	if oRs("AuthorID") = session("forum_memberid") or secresult = "Full" then
		sAns = sAns & "&nbsp;&nbsp;<img src=""icons/reply_topic.gif"" alt=""Edit"" onClick=""edit('" & oRs("id") & "')"">"
		if oRs("parentmessage") <> 0 then
			sAns = sAns & "&nbsp;&nbsp;<img src=""icons/reply_topic.gif"" alt=""Delete"" onClick=""deletepost('" & oRs("id") & "')"">"
		end if
		sAns = sAns & "&nbsp;&nbsp;" & oRs("id") 
	end if
	sAns = sAns & "&nbsp;&nbsp;&nbsp;<b><div id=""t" & oRs("id") & """>" & oRs("Topic") & "</div></b></td>"
	sAns = sAns & "</td><td align=""right"">" & email & skype & oRs("AuthorName")  & "</td></tr></table></h3></div><div class=""contenth""><div id=""e" & oRs("id") & """>"
	sAns = sAns & oRs("comments") & "</div></div>"
	sAns = sAns & "<b class=""b4bh""></b><b class=""b3bh""></b><b class=""b2bh""></b><b class=""b1h""></b>"
	sAns = sAns & "<div id=""r" & oRs("id") & """></div></td></TR></table>"
	oRs.close
	sSQL = "SELECT ID FROM FORUMMESSAGES WHERE PARENTMESSAGE = " & ID
	oCmd.CommandText = sSQL
	oCmd.CommandType = 1
	set oRs = oCmd.execute
		do while not oRs.eof
			sAns = sAns & MessageChildren(oRs("ID"), iIndent + 1)
			oRs.MoveNext
		Loop
	oRs.Close
	set oRs = nothing
	set oCmd = nothing
	MessageChildren = sAns
End Function

%>




