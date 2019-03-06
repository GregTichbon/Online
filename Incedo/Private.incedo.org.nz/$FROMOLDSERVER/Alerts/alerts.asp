<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Alerts"
		secoption = "General"
%>
	<!--#include file="../inc_security.asp"-->
<%
		if secresult = "Failed" then 		
			response.write "<div align=""center""><p>You do not have access to this screen</p><p><a href=""../default.asp"">Return to the menu</a></p></div>"
			response.end
		end if
	end if

	connection_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\vhosts\incedo.org.nz\incedo.mdb;"
	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.RecordSet")
	id = request.querystring("id")
	if id <> "new" then
		set di = server.createobject("DI.IIS")
		sql = "SELECT * from alerts where alertsid = " & id  
		rs.Open sql, db
		if not rs.eof then
			title = rs("title")
			description = rs("description")
			author = rs("author")
			content = rs("content")
			content = rs("content") & ""
			content = replace(content,"'","&#39")
			content = replace(content,vbcrlf,"")
			startdate = di.di_format(rs("startdate"),"dd/mm/yyyy")
			enddate = di.di_format(rs("enddate"),"dd/mm/yyyy")
		end if
		rs.close
		set di = nothing
	end if
%>
<html>
<head>
<title>Incedo Thoughts</title>
<link rel="stylesheet" type="text/css" media="all" href="../../calendar-win2k-1.css" title="win2k-1" />
<script type="text/javascript" src="../../calendar_stripped.js"></script>
<script type="text/javascript" src="../../calendar-en.js"></script>
<script type="text/javascript" src="../../calendar-setup_stripped.js"></script>
<script type="text/javascript" src="../../fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="../../Javascript/validateDate.js"></script>
<script language="JavaScript">
function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.maint;
	if(frm.title.value == '') {
		msg = msg + delim + ' - Title';
		delim = '\n';
	}
	if(frm.author.value == '') {
		msg = msg + delim + ' - Author';
		delim = '\n';
	}
	if(frm.description.value == '') {
		msg = msg + delim + ' - Description';
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
<body>
    <h1>ALERTS MAINTENANCE</h1>
    <form name="maint" method="post" action="alerts_process.asp" OnSubmit="return checkform();">
	<input name="id" type="hidden" id="id" value="<%=id%>">
      <table width="500" border="1" cellspacing="0" cellpadding="1">
        <tr>
          <td><div align="right">Title</div></td>
          <td><input name="title" type="text" id="title" value="<%=title%>" style="width:100%"></td>
        </tr>
        <tr>
		<tr>
		  <td><div align="right">Start Date</div></td>
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
		  <td><div align="right">End Date</div></td>
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
<script type="text/javascript">
var oFCKeditor = new FCKeditor( 'content' ) ;
//	oFCKeditor.BasePath	= '../../FCKeditor/' ;
oFCKeditor.Value	= '<%=content%>' ;
oFCKeditor.Create() ;
</script>	  
		  </td>
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




