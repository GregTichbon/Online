<%
	if session("Incedo_MemberID")= "" then
		response.redirect "../signon"
	else
		secgroup = "Videos"
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
		sql = "SELECT * from videos where id = " & id  
		rs.Open sql, db
		if not rs.eof then
			link = rs("link")
			title = rs("title")
			description = rs("description")
			internalshowfrom = di.di_format(rs("internalshowfrom"),"dd/mm/yyyy")
			internalshowto = di.di_format(rs("internalshowto"),"dd/mm/yyyy")
			externalshowfrom = di.di_format(rs("externalshowfrom"),"dd/mm/yyyy")
			externalshowto = di.di_format(rs("externalshowto"),"dd/mm/yyyy")
		end if
		rs.close
		set di = nothing
	end if
%>
<html>
<head>
<title>Incedo Videos</title>
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
	if(frm.link.value == '') {
		msg = msg + delim + ' - Link';
		delim = '\n';
	}
	if(frm.title.value == '') {
		msg = msg + delim + ' - Title';
		delim = '\n';
	}
	if(frm.description.value == '') {
		msg = msg + delim + ' - Description';
		delim = '\n';
	}
	if(frm.externalshowfrom.value != '') {
		if(IsDate(frm.externalshowfrom.value) != 'OK') {
			msg = msg + delim + ' - Valid External Show from Date';
			delim = '\n';
		} else {
			if(frm.externalshowto.value == '') {
				msg = msg + delim + ' - External Show to Date';
				delim = '\n';
			} else {
				if(IsDate(frm.externalshowto.value) != 'OK') {
					msg = msg + delim + ' - Valid External Show to Date';
					delim = '\n';
				} else {
					if(formatdate(frm.externalshowto.value) <= formatdate(frm.externalshowfrom.value)) {
						msg = msg + delim + ' - An External Show to Date after the External Show from Date';
						delim = '\n';
					}
				}
			}
		}
	} else {
		if(frm.externalshowto.value != '') {
			msg = msg + delim + ' - An External Show from Date';
			delim = '\n';
		}
	}
	if(frm.internalshowfrom.value != '') {
		if(IsDate(frm.internalshowfrom.value) != 'OK') {
			msg = msg + delim + ' - Valid Internal Show from Date';
			delim = '\n';
		} else {
			if(frm.internalshowto.value == '') {
				msg = msg + delim + ' - internal Show to Date';
				delim = '\n';
			} else {
				if(IsDate(frm.internalshowto.value) != 'OK') {
					msg = msg + delim + ' - Valid Internal Show to Date';
					delim = '\n';
				} else {
					if(formatdate(frm.internalshowto.value) <= formatdate(frm.internalshowfrom.value)) {
						msg = msg + delim + ' - An internal Show to Date after the internal Show from Date';
						delim = '\n';
					}
				}
			}
		}
	} else {
		if(frm.internalshowto.value != '') {
			msg = msg + delim + ' - An internal Show from Date';
			delim = '\n';
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
function formatdate(sUK) {   
	var A = sUK.split(/[\\\/]/); 
	A = [A[1],A[0],A[2]];   
	return new Date(Date.parse(A.join('/'))); 
} 
</script>
</head>
<body>
    <h1>VIDEO MAINTENANCE</h1>
    <form name="maint" method="post" action="video_process.asp" OnSubmit="return checkform();">
	<input name="id" type="hidden" id="id" value="<%=id%>">
      <table border="1" cellspacing="0" cellpadding="1">
        <tr>
          <td><div align="right">Link</div></td>
          <td><textarea name="link" rows="3" id="link" style="width:100%"><%=link%></textarea></td>
        </tr>
		<tr>
          <td><div align="right">Title</div></td>
          <td><input name="title" type="text" id="title" value="<%=title%>" style="width:100%"></td>
	    </tr>
		<tr>
		  <td><div align="right">Description</div></td>
		  <td><textarea name="description" cols="60" rows="5"><%=description%></textarea></td>
		</tr>
		<tr>
		  <td><div align="right">External Show From </div></td>
		  <td>    <input name="externalshowfrom" type="text" id="externalshowfrom" value="<%=externalshowfrom%>">
<img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger1">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "externalshowfrom",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger1",      // ID of the button	
	  showsTime   : false
    }
  );
</script>	  	  
</td>
	    </tr>
		<tr>
		  <td><div align="right">External Show To </div></td>
		  <td><input name="externalshowto" type="text" id="externalshowto" value="<%=externalshowto%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger2">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "externalshowto",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger2",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Internal Show From</div></td>
		  <td><input name="internalshowfrom" type="text" id="internalshowfrom" value="<%=internalshowfrom%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger3">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "internalshowfrom",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger3",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
		  </td>
	    </tr>
		<tr>
		  <td><div align="right">Internal Show To </div></td>
		  <td><input name="internalshowto" type="text" id="internalshowto" value="<%=internalshowto%>">
            <img src="../../cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date" id="trigger4"> </td>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "internalshowto",         // ID of the input field
      ifFormat    : "%d/%m/%Y",    		// the date format
      button      : "trigger4",      // ID of the button
	  showsTime   : false
    }
  );
</script>	  	  
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




