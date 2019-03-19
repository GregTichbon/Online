<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "News"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult = "Failed" then 		
			response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
			response.end
		end if
'response.write secbaseare
'response.end
	end if

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	id = request.querystring("id")
	if id <> "new" then
		set di = server.createobject("DI.IIS")
		sql = "SELECT * from news where newsid = " & id  
		rs.Open sql, db
		if not rs.eof then
			title = rs("title")
			description = rs("description")
			content = rs("content")
			content = rs("content") & ""
			content = replace(content,"'","&#39")
			content = replace(content,vbcrlf,"")
			mydate = di.di_format(rs("datetime"),"dd/mm/yyyy")
			myhour = cint(di.di_format(rs("datetime"),"h"))
			myminute = cint(di.di_format(rs("datetime"),"n"))
			startdate = di.di_format(rs("startdate"),"dd/mm/yyyy")
			enddate = di.di_format(rs("enddate"),"dd/mm/yyyy")
			if rs("private") then privatechecked = " checked"
			if rs("public") then publicchecked = " checked"
			if rs("general") then generalchecked = " checked"
			if rs("live") then livechecked = " checked"
			basearea = rs("basearea") & ""
'response.write basearea
'response.end
		end if
		rs.close
		set di = nothing
	end if
%>
<html>
<head>
<title>Incedo News</title>
<link rel="stylesheet" type="text/css" media="all" href="../../calendar-win2k-1.css" title="win2k-1" />
<script type="text/javascript" src="../../calendar_stripped.js"></script>
<script type="text/javascript" src="../../calendar-en.js"></script>
<script type="text/javascript" src="../../calendar-setup_stripped.js"></script>
<script type="text/javascript" src="../../Javascript/validateDate.js"></script>
<script type="text/javascript" src="../../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="../../tiny_mce/plugins/tinybrowser/tb_tinymce.js.php"></script>
<script language="JavaScript">
	tinyMCE.init({
		mode : "exact",
		elements : "content",
		convert_urls : false,
		theme : "advanced",
		plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,fontselect,fontsizeselect,cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,image,cleanup,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons2 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen,visualchars,nonbreaking",
		theme_advanced_buttons3 : "",
		theme_advanced_buttons4 : "",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
		theme_advanced_resize_horizontal : false,
 		file_browser_callback : "tinyBrowser",
		extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style]"
	});

function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;
	if(frm.title.value == '') {
		msg = msg + delim + ' - Title';
		delim = '\n';
	}
	if(frm.description.value == '') {
		msg = msg + delim + ' - Description';
		delim = '\n';
	}
	if(frm.$date.value == '') {
		msg = msg + delim + ' - Date';
		delim = '\n';
	} else {
		if(IsDate(frm.$date.value) != 'OK') {
			msg = msg + delim + ' - Valid date';
			delim = '\n';
		}
	}
	if(frm.$hour.value == '' || frm.$minute.value == '') {
		msg = msg + delim + ' - Time';
		delim = '\n';
	}
	if(frm.startdate.value == '') {
		msg = msg + delim + ' - Start Date';
		delim = '\n';
	} else {
		if(IsDate(frm.startdate.value) != 'OK') {
			msg = msg + delim + ' - Valid start date';
			delim = '\n';
		}
	}
	if(frm.enddate.value == '') {
		msg = msg + delim + ' - End Date';
		delim = '\n';
	} else {
		if(IsDate(frm.enddate.value) != 'OK') {
			msg = msg + delim + ' - Valid end date';
			delim = '\n';
		} else {
			if(frm.enddate.value <= frm.startdate.value) {
				msg = msg + delim + ' - An end date after the start date';
				delim = '\n';
			}
		}
	}
	if(!(frm.$rssupdate[0].checked) && !(frm.$rssupdate[1].checked)) {
		msg = msg + delim + ' - An RSS option';
		delim = '\n';
	}
	if(msg != '') {
		alert('You must enter:\n' + msg);
		return(false);
	}
}
</script>
</head>
<body<%=onload%>>
    <h1>NEWS MAINTENANCE</h1>
    <form name="maint" method="post" action="news_process.asp" OnSubmit="return checkform();">
	<input name="id" type="hidden" id="id" value="<%=id%>">
      <table border="1" cellspacing="0" cellpadding="1">
        <tr>
          <td><div align="right">Title</div></td>
          <td><input name="title" type="text" id="title" value="<%=title%>" style="width:100%"></td>
        </tr>
		<tr>
		  <td><div align="right">Description</div></td>
		  <td><textarea name="description" cols="60" rows="5"><%=description%></textarea></td>
		</tr>
		<tr>
		  <td><div align="right">Release<br>
		    Date/Time</div></td>
		  <td>    <input name="$date" type="text" id="$date" value="<%=mydate%>">
<img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "$date",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
    <select name="$hour" size="1" id="$hour">
	<option value=""></option>
<%
for f1=7 to 22
	if f1=myhour then
		selected = " selected"
	else
		selected = ""
	end if
	response.write "<option value=""" & f1 & """" & selected & ">" & right("0" & f1,2) & "</option>"
next
%>
    </select>
: 
<select name="$minute" size="1" id="$minute">
<%
for f1=0 to 55 step 5
	if f1=myminute then
		selected = " selected"
	else
		selected = ""
	end if
	response.write "<option value=""" & right("0" & f1,2) & """" & selected & ">" & right("0" & f1,2) & "</option>"
next
%>
</select> 
</td>
	    </tr>
		<tr>
		  <td><div align="right">Display From</div></td>
		  <td><input name="startdate" type="text" id="startdate" value="<%=startdate%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger2">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "startdate",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger2",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Display To </div></td>
		  <td><input name="enddate" type="text" id="enddate" value="<%=enddate%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger3">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "enddate",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger3",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
		  </td>
	    </tr>
		<tr>
          <td colspan="2">
		  <textarea name="content" id="content"><%=content%></textarea>
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Audience</div></td>
		  <td>Private
		    <input name="private" type="checkbox" id="private" value="true"<%=privatechecked%>>	      
	      &nbsp;&nbsp;&nbsp;&nbsp;Public	
	      <input name="public" type="checkbox" id="public" value="true"<%=publicchecked%>></td>
	    </tr>
		<tr>
		  <td><div align="right">General</div></td>
		  <td><input name="general" type="checkbox" id="general" value="true"<%=generalchecked%>></td>
	    </tr>
		<tr>
		  <td><div align="right">Area(s)</div></td>
		  <td>
<%
			sql = "select * from bases where [Type] = '" & secBaseAreaOption & "' order by centre"
			'sql = "select * from bases order by [type], centre"
'response.write sql
			rs.Open sql, db
			delim = ""
			do until rs.EOF
'response.write "*" & rs("centre") & "-" & secbasearea & "*<br>"
				if instr(", " & secbasearea & ",",", " & rs("centre") & ",") > 0 then
					if instr(basearea,", " & rs("centre") & ",") > 0 then
						checked = " checked"
					else
						checked = ""
					end if
					response.write delim & "<input type=""checkbox"" name=""$basearea"" value=""" & rs("centre") & """" & checked & ">" & rs("centre")
					delim = " | "
				end if
				rs.movenext
			loop	
			rs.close
%>	  
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Live</div></td>
		  <td><input name="live" type="checkbox" id="live" value="true"<%=livechecked%>></td>
	    </tr>
		<tr>
		  <td><div align="right">RSS Update </div></td>
		  <td>Yes
		    <input name="$rssupdate" type="radio" value="-1">	      
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No
	        <input name="$rssupdate" type="radio" value="0">
          </td>
		</tr>
      </table>
      <p>
        <input name="$reset" type="reset" id="$reset" value="Reset">
        <input name="$submit" type="submit" id="$submit" value="Submit">
<%
if id <> "new" then
%>		
        <input name="$delete" type="submit" id="$delete" value="Delete">
<%
end if
%>
</p>
    </form>
</body>
</html>
<%
		set rs = nothing
		db.close
		set db = nothing
%>




